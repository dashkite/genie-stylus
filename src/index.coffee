import M from "@dashkite/masonry"
import stylus from "@dashkite/masonry-stylus"
import T from "@dashkite/masonry-targets"

export default ( Genie ) ->

  options = Genie.get "stylus"

  Genie.define "stylus:build", "stylus:clean", M.start [
    T.glob options.targets
    M.read
    M.tr stylus
    T.extension ".${ build.preset }"
    T.write "build/${ build.target }"
  ]

  # alias
  Genie.define "stylus", "stylus:build"
  
  Genie.on "build", "stylus:build"

  Genie.define "stylus:clean", "clean"
