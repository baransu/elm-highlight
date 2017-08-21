module Highlight.Lexer exposing (..)

import Dict exposing (Dict)
import Language.Elm
import Highlight.Rule exposing (..)
import Highlight.Token exposing (..)
import Combine exposing (..)


-- parse (choice [string "a", string "b"]) str
-- returns dictionary of all supported languages


defaultLexer : List Rule
defaultLexer =
    Language.Elm.rules


lexers : Dict String (List Rule)
lexers =
    Dict.empty
        |> Dict.insert "elm" Language.Elm.rules


parseToken : Rule -> String -> ( Maybe Token, String )
parseToken ( type_, regexString ) input =
    case (parse << regex) regexString input of
        Ok ( _, _, result ) ->
            ( Just (Token type_ result)
            , String.dropLeft (String.length result) input
            )

        Err _ ->
            ( Nothing, input )


tokenize : Rule -> String -> ( List Token, String )
tokenize rule input =
    case parseToken rule input of
        ( Just token, str ) ->
            ( [ token ], str )

        ( Nothing, str ) ->
            ( [], str )


tokenizeLine : List Token -> List Rule -> String -> List Token
tokenizeLine acc rules input =
    case input of
        "" ->
            acc ++ [ Token "any" "\n" ]

        str ->
            let
                ( tokens, string ) =
                    List.foldl
                        (\rule ( tokens, string ) ->
                            let
                                ( t, str ) =
                                    tokenize rule string
                            in
                                ( tokens ++ t, str )
                        )
                        ( acc, input )
                        rules
            in
                tokenizeLine tokens rules string


lexer : String -> String -> List Token
lexer lang input =
    let
        rules =
            (Maybe.withDefault defaultLexer <| Dict.get lang lexers)
                ++ [ rule "any" "." ]

        tokenizeByLine =
            tokenizeLine [] rules
    in
        input
            |> String.lines
            |> List.map tokenizeByLine
            |> List.concat
            |> Debug.log "tokens"
