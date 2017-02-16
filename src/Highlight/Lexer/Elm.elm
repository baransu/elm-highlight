module Highlight.Lexer.Elm exposing (rules)

import Highlight.Rule exposing (rule, Rule)
import Highlight.Token exposing (..)


rules : List Rule
rules =
    [ rule Whitespace "\\s+"
    , rule Comment "--.*"
    , rule Literal "(([0-9]\\.?[0-9]*)|(\".*?\"))"
    , rule Punctuation "(,|:|;|\\(|\\)|\\[|\\]|\\{|\\}|\\>|\\<)"
    , rule Operator "(\\*|\\/|\\+|\\-|\\=|\\||\\&|\\^|\\$)"
    , rule Namespace "[A-Z][a-z]+(?:[A-Z][a-z]+)*"
    , rule Name "[a-z]+(?:[A-Z][a-z]+)*"
    , rule Keyword "^([a-z]+(?:[A-Z][a-z]+)*)"
    , rule Other "\\S+"
    ]
