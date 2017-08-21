module Language.Elm exposing (rules)

import Highlight.Rule exposing (rule, Rule)


rules : List Rule
rules =
    [ rule "keyword" "(\\s*)(let|in|if|then|else|case|of|where|module|import|exposing|type|alias|as|infix|infixl|infixr|port|effect|command|subscription)(\\s|$)+"
    , rule "comment" "--.*"
    , rule "number" "[0-9]\\.?[0-9]*"
    , rule "string" "\".*?\""
    , rule "type" "[A-Z][a-z]+(?:[A-Z][a-z]+)*"
    , rule "title" "[a-z]+(?:[A-Z][a-z]+)*"
    , rule "any" "(\\s*)[a-z]+(?:[A-Z][a-z]+)*"

    -- , rule "operator" "(\\*|\\/|\\+|\\-|\\=|\\||\\&|\\^|\\$)"
    ]
