module Highlight.Lexer exposing (..)

import Dict exposing (Dict)
import Language.Elm
import Highlight.Rule exposing (..)
import Highlight.Token exposing (..)
import Regex exposing (..)


-- returns dictionary of all supported languages


defaultLexer : List Rule
defaultLexer =
    Language.Elm.rules


lexers : Dict String (List Rule)
lexers =
    Dict.empty
        |> Dict.insert "elm" Language.Elm.rules



-- lexer logic


replaceByWhitespace : Regex -> String -> String
replaceByWhitespace regex_ =
    replace All regex_ (\{ match } -> String.repeat (String.length match) " ")


getMatch : ( String, Regex ) -> String -> ( List Token, String )
getMatch ( token, regex_ ) str =
    let
        tokens =
            find All regex_ str
                |> List.map (\{ match, index } -> Token token match index)

        string =
            replaceByWhitespace regex_ str
    in
        ( tokens, string )


processRegex : ( String, Regex ) -> ( List Token, String ) -> ( List Token, String )
processRegex exp ( acc, string ) =
    let
        ( tokens, str ) =
            getMatch exp string
    in
        ( acc ++ tokens, str )


tokenize : List Rule -> List Token -> String -> List Token
tokenize rules acc str =
    let
        ( tokens, _ ) =
            rules
                |> List.foldl processRegex ( [], str )
    in
        tokens
            |> List.sortBy .index


tokenizeLine : List Rule -> String -> List Token
tokenizeLine rules str =
    let
        lineBreak =
            Token "other" "\n" <| String.length str
    in
        tokenize rules [] str ++ [ lineBreak ]


lexer : String -> String -> List Token
lexer lang input =
    let
        rules =
            -- [ rule "whitespace" "\\s" ]
            --     ++
            (Maybe.withDefault defaultLexer <| Dict.get lang lexers)
                ++ [ rule "any" "(\\s|.)+" ]

        tokenizeByLine =
            tokenizeLine rules
    in
        input
            |> String.lines
            |> List.map tokenizeByLine
            |> List.concat
            |> Debug.log "lexed"
