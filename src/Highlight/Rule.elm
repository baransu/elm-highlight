module Highlight.Rule exposing (Rule, rule)

import Highlight.Token exposing (TokenType)
import Regex exposing (Regex, regex)


rule : TokenType -> String -> ( TokenType, Regex )
rule tokenType str =
    ( tokenType, regex str )


type alias Rule =
    ( TokenType, Regex )
