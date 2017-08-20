module Highlight exposing (toHtml)

import Highlight.Lexer exposing (lexer)
import Highlight.Token exposing (Token)
import Highlight.View exposing (renderToken)
import Html exposing (Html, pre, code, span, p, text)
import Html.Attributes exposing (class)


toHtml : String -> String -> Html msg
toHtml lang str =
    pre []
        [ code [ class ("hljs " ++ String.toLower lang) ] <| List.map renderToken <| lexer lang str ]
