module Main exposing (..)

import Highlight
import Highlight.Lexer exposing (lexer)
import Highlight.Token exposing (Token)
import Html exposing (Html, textarea, text, div, h3)
import Html.Attributes exposing (value, class, style)
import Html.Events exposing (onInput)


type Msg
    = UpdateInput String


type alias Model =
    { tokens : List Token, source : String }


view : Model -> Html Msg
view { source, tokens } =
    div [ class "row" ]
        [ div [ class "column" ]
            [ textarea [ style [ ( "height", "600px" ) ], value source, onInput UpdateInput ] []
            ]
        , div [ class "column" ]
            [ h3 [] [ text "fromString" ]
            , Highlight.fromString "Elm" source
            , h3 [] [ text "fromTokens" ]
            , Highlight.fromTokens tokens
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


elmLexer : String -> List Token
elmLexer =
    lexer "Elm"


init : ( Model, Cmd Msg )
init =
    let
        tokens =
            elmLexer source
    in
        ( Model tokens source, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput str ->
            let
                tokens =
                    elmLexer str
            in
                ( { model | source = str, tokens = tokens }, Cmd.none )


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
