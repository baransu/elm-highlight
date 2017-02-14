module Highlight exposing (..)

import Html exposing (Html, pre, code, span, p, text)
import Regex exposing (..)


type Type
    = Name
    | Operator
    | Parens
    | Literal
    | Keyword
    | Module
    | Comment
    | Other
    | Whitespace


type alias Token =
    ( Type, String )



-- user provided regexes?


regexes : List ( Type, Regex )
regexes =
    [ ( Name, regex "^[a-z]+(_[a-z]+)*" )
    , ( Literal, regex "^([0-9]\\.?[0-9]*)" )
    , ( Operator, regex "^(\\*|\\/|\\+|-|=)" )
    , ( Whitespace, regex "\\s" )
    ]



--{~r/^[A-Z][a-z]+(?:[A-Z][a-z]+)*/, :type},
--{~r/^#.*/, :comment},
--{~r/^".*?"/, :string},
--{~r/^\(/, :l_paren},
--{~r/^\)/, :r_paren},
--{~r/^\,/, :coma},
--{~r/^->/, :r_arrow},


remove : String -> List String -> ( Maybe String, String )
remove str matches =
    case List.head matches of
        Just match ->
            let
                len =
                    String.length match

                left =
                    String.left len str

                right =
                    String.dropLeft len str
            in
                ( Just left, right )

        Nothing ->
            ( Nothing, str )


getMatch : Regex -> String -> ( Maybe String, String )
getMatch regex_ str =
    find All regex_ str
        |> List.map .match
        |> remove str


removeByExpression : ( Type, Regex ) -> String -> ( Maybe Token, String )
removeByExpression ( type_, regex_ ) string =
    case getMatch regex_ string of
        ( Just t, str ) ->
            ( Just ( type_, t ), str )

        ( Nothing, str ) ->
            ( Nothing, str )


processRegex : ( Type, Regex ) -> ( List Token, String ) -> ( List Token, String )
processRegex expression ( acc, string ) =
    case removeByExpression expression string of
        ( Just t, str ) ->
            ( acc ++ [ t ], str )

        ( Nothing, str ) ->
            ( acc, str )


tokenize : List Token -> String -> List Token
tokenize acc str =
    if str == "" then
        acc
    else
        let
            ( tokens, string ) =
                regexes
                    |> List.foldl processRegex ( [], str )
        in
            if str == string then
                acc ++ [ ( Other, string ) ]
            else
                tokenize (acc ++ tokens) string


parse : String -> List Token
parse =
    tokenize []


renderToken : Token -> Html msg
renderToken token =
    case token of
        ( Name, str ) ->
            span [] [ text str ]

        ( Operator, str ) ->
            span [] [ text str ]

        ( Parens, str ) ->
            span [] [ text str ]

        ( Literal, str ) ->
            span [] [ text str ]

        ( Keyword, str ) ->
            span [] [ text str ]

        ( Module, str ) ->
            span [] [ text str ]

        ( Comment, str ) ->
            span [] [ text str ]

        ( Other, str ) ->
            span [] [ text str ]

        ( Whitespace, str ) ->
            span [] [ text str ]


render : String -> Html msg
render input =
    let
        codeBody =
            parse input
                |> List.map renderToken
    in
        pre []
            [ code [] codeBody
            ]
