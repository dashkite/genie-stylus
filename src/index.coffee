import M from "@dashkite/masonry"
import stylus from "@dashkite/masonry-stylus"
import T from "@dashkite/masonry-targets"
import W from "@dashkite/masonry-targets/watch"

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

  Genie.define "stylus:watch", M.start [
    W.glob options.targets
    W.match type: "file", name: [ "add", "change" ], [
      M.read
      M.tr stylus
      T.extension ".${ build.preset }"
      T.write "build/${ build.target }"
    ]
    W.match type: "file", name: "rm", [
      T.extension ".${ build.preset }"
      T.rm "build/${ build.target }"
    ]
    W.match type: "directory", name: "rm", 
      T.rm "build/${ build.target }"        
  ]

  Genie.on "watch", "stylus:watch&"