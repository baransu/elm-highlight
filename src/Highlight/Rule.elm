module Highlight.Rule exposing (Rule, rule)


rule : String -> String -> ( String, String )
rule token regexStr =
    ( token, regexStr )


type alias Rule =
    ( String, String )
