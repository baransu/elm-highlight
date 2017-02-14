module Main exposing (..)

import Highlight
import Html exposing (Html, textarea, text, div)
import Html.Attributes exposing (value, class, style)
import Html.Events exposing (onInput)


type Msg
    = UpdateInput String


type alias Model =
    String


view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ div [ class "column" ]
            [ textarea [ style [ ( "height", "600px" ) ], value model, onInput UpdateInput ] []
            ]
        , div [ class "column" ]
            [ Highlight.render model
            ]
        ]


init : ( Model, Cmd Msg )
init =
    let
        model =
            """view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ div [ class "column" ]
            [ textarea [ style [ ( "height", "600px" ) ], value model ] []
            ]
        , div [ class "column" ]
            [ Highlight.render [ model ]
            ]
        ]
"""
    in
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput str ->
            ( str, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
