module Highlight.Rule exposing (Rule, rule)

import Regex exposing (Regex, regex)


rule : String -> String -> ( String, Regex )
rule token str =
    ( token, regex str )


type alias Rule =
    ( String, Regex )
