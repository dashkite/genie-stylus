import * as _ from "@dashkite/joy"
import * as M from "@dashkite/masonry"
import stylus from "@dashkite/masonry-stylus"
import { File as F, Files as P } from "@dashkite/masonry-files"
import wrap from "@dashkite/masonry-export"

export default ( Genie ) ->

  options = Genie.get "stylus"

  Genie.define "stylus", M.start [
    P.targets options.targets
    M.read
    M.tr stylus
    F.extension ".${ build.preset }"
    F.write "build/${ build.target }"
  ]

  t.on "build", "stylus"

