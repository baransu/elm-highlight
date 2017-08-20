module Main exposing (..)

import Highlight
import Html exposing (Html, textarea, text, div, h3)
import Html.Attributes exposing (value, class, style)
import Html.Events exposing (onInput)


type Msg
    = UpdateInput String


type alias Model =
    { source : String }


view : Model -> Html Msg
view { source } =
    div [ class "row" ]
        [ div [ class "column" ]
            [ textarea [ style [ ( "height", "600px" ) ], value source, onInput UpdateInput ] []
            ]
        , div [ class "column" ]
            [ Highlight.toHtml "elm" source
            ]
        ]


source : String
source =
    """view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ div [ class "column" ]
            [ textarea [ style [ ( "height", "600px" ) ], value model ] []
            ]
        , div [ class "column" ]
            [ Highlight.render [ model | something ]
            ]
        ]
-- here is random comment
"""


init : ( Model, Cmd Msg )
init =
    ( Model source, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput source ->
            ( { model | source = source }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
