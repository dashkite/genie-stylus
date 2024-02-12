import M from "@dashkite/masonry"
import stylus from "@dashkite/masonry-stylus"
import T from "@dashkite/masonry-targets"

# sigh...
debounce = do ({ last } = {}) ->
  last = 0
  ( f ) ->
    ( args... ) ->
      now = performance.now()
      if ( now - last ) > 1000 #ms
        last = now
        f args...

# IMPORTANT we don't set defaults because we can't 
# know what a reasonable default is: did you want
# css or js?

export default ( Genie ) ->

  options = Genie.get "stylus"

  Genie.define "stylus", M.start [
    T.glob options.targets
    M.read
    M.tr stylus
    T.extension ".${ build.preset }"
    T.write "build/${ build.target }"
  ]

  Genie.on "build", "stylus"

  Genie.define "stylus:watch", ->
    W = await import( "@dashkite/masonry-watch" )
    do M.start [
      W.glob options.targets
      debounce -> Genie.apply "stylus"

      # W.match type: "file", name: [ "add", "change" ], [
      #   M.read
      #   M.tr stylus
      #   T.extension ".${ build.preset }"
      #   T.write "build/${ build.target }"
      # ]
      # W.match type: "file", name: "rm", [
      #   T.extension ".${ build.preset }"
      #   T.rm "build/${ build.target }"
      # ]
      # W.match type: "directory", name: "rm", 
      #   T.rm "build/${ build.target }"        
    ]

  Genie.on "watch", "stylus:watch&"