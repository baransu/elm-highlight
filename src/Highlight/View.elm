module Highlight.View exposing (renderToken)

import Highlight.Token exposing (..)
import Html exposing (Html, span, text, code)
import Html.Attributes exposing (class)
import Regex exposing (..)


renderToken : Token -> Html msg
renderToken { token, str } =
    case ( token, str ) of
        ( "any", str ) ->
            span [] [ text str ]

        ( token, str ) ->
            span
                [ class ("hljs-" ++ token) ]
                [ text str ]
