module Highlight.View exposing (renderToken)

import Highlight.Token exposing (..)
import Html exposing (Html, span, text)
import Html.Attributes exposing (class)
import Regex exposing (..)


renderToken : Token -> Html msg
renderToken { tokenType, str } =
    case ( tokenType, str ) of
        ( Whitespace, str ) ->
            text str

        ( tokenType, str ) ->
            let
                className =
                    tokenType
                        |> toString
                        |> String.toLower
                        |> replace All (regex "_") (\_ -> " ")
                        |> (++) "token "
            in
                span
                    [ class className ]
                    [ text str ]
