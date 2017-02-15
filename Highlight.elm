module Highlight exposing (..)

import Html exposing (Html, pre, code, span, p, text)
import Html.Attributes exposing (class)
import Regex exposing (..)


type Type
    = Name
    | Operator
    | Parens
    | Literal
    | Keyword
    | Namespace
    | Comment
    | Other
    | Punctuation
    | Whitespace


type alias Token =
    ( ( Type, String ), Int )


regexes : List ( Type, Regex )
regexes =
    [ ( Whitespace, regex "\\s+" )
    , ( Comment, regex "--.*" )
    , ( Literal, regex "(([0-9]\\.?[0-9]*)|(\".*?\"))" )
    , ( Punctuation, regex "(,|:|;|\\(|\\)|\\[|\\]|\\{|\\}|\\>|\\<)" )
    , ( Operator, regex "(\\*|\\/|\\+|\\-|\\=|\\||\\&|\\^|\\$)" )
    , ( Namespace, regex "[A-Z][a-z]+(?:[A-Z][a-z]+)*" )
    , ( Keyword, regex "^([a-z]+(?:[A-Z][a-z]+)*)" )
    , ( Name, regex "[a-z]+(?:[A-Z][a-z]+)*" )
    , ( Other, regex "\\S+" )
      -- keywords
    ]


replaceByWhitespace : Regex -> String -> String
replaceByWhitespace regex_ =
    replace All regex_ (\{ match } -> String.repeat (String.length match) " ")


getMatch : ( Type, Regex ) -> String -> ( List Token, String )
getMatch ( type_, regex_ ) str =
    let
        tokens =
            find All regex_ str
                |> List.map (\a -> ( ( type_, a.match ), a.index ))

        string =
            replaceByWhitespace regex_ str
    in
        ( tokens, string )


processRegex : ( Type, Regex ) -> ( List Token, String ) -> ( List Token, String )
processRegex expression ( acc, string ) =
    let
        ( tokens, str ) =
            getMatch expression string
    in
        ( acc ++ tokens, str )


tokenize : List Token -> String -> List Token
tokenize acc str =
    let
        ( tokens, string ) =
            regexes
                |> List.foldl processRegex ( [], str )
    in
        tokens
            |> List.sortBy (\( _, index ) -> index)


parse : String -> List Token
parse input =
    input
        |> String.lines
        |> List.map (\a -> tokenize [] a ++ [ ( ( Other, "\n" ), String.length a ) ])
        |> List.concatMap (\a -> a)
        |> List.map (\a -> Debug.log "parsed" a)


renderToken : Token -> Html msg
renderToken token =
    case (\( ( t, m ), i ) -> ( t, m )) token of
        ( Name, str ) ->
            span [ class "name" ] [ text str ]

        ( Operator, str ) ->
            span [ class "operator" ] [ text str ]

        ( Parens, str ) ->
            span [ class "parens" ] [ text str ]

        ( Literal, str ) ->
            span [ class "literal" ] [ text str ]

        ( Keyword, str ) ->
            span [ class "keyword" ] [ text str ]

        ( Namespace, str ) ->
            span [ class "namespace" ] [ text str ]

        ( Comment, str ) ->
            span [ class "comment" ] [ text str ]

        ( Punctuation, str ) ->
            span [ class "punctuation" ] [ text str ]

        ( Other, str ) ->
            span [ class "other" ] [ text str ]

        ( _, str ) ->
            text str


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



-- /* .highlight .c { color: #2aa1ae } /\* Comment *\/ */
-- /* .highlight .err { color: #e0211d } /\* Error *\/ */
-- /* .highlight .g { color: #93A1A1 } /\* Generic *\/ */
-- /* .highlight .k { color: #4f97d7 } /\* Keyword *\/ */
-- /* .highlight .l { color: #93A1A1 } /\* Literal *\/ */
-- /* .Highlight .n { color: #93A1A1 } /\* Name *\/ */
-- /* .highlight .o { color: #E6E1DC } /\* Operator *\/ */
-- /* .highlight .x { color: #E6E1DC } /\* Other *\/ */
-- /* .highlight .p { color: #4f97d7 } /\* Punctuation *\/ */
-- /* .highlight .cm { color: #2aa1ae } /\* Comment.Multiline *\/ */
-- /* .highlight .cp { color: #2aa1ae } /\* Comment.Preproc *\/ */
-- /* .highlight .c1 { color: #2aa1ae } /\* Comment.Single *\/ */
-- /* .highlight .cs { color: #2aa1ae } /\* Comment.Special *\/ */
-- /* .highlight .gd { color: #2aa1ae } /\* Generic.Deleted *\/ */
-- /* .highlight .ge { color: #93A1A1; font-style: italic } /\* Generic.Emph *\/ */
-- /* .highlight .gr { color: #DC322F } /\* Generic.Error *\/ */
-- /* .highlight .gh { color: #CB4B16 } /\* Generic.Heading *\/ */
-- /* .highlight .gi { color: #859900 } /\* Generic.Inserted *\/ */
-- /* .highlight .go { color: #93A1A1 } /\* Generic.Output *\/ */
-- /* .highlight .gp { color: #93A1A1 } /\* Generic.Prompt *\/ */
-- /* .highlight .gs { color: #93A1A1; font-weight: bold } /\* Generic.Strong *\/ */
-- /* .highlight .gu { color: #CB4B16 } /\* Generic.Subheading *\/ */
-- /* .highlight .gt { color: #93A1A1 } /\* Generic.Traceback *\/ */
-- /* .highlight .kc { color: #CB4B16 } /\* Keyword.Constant *\/ */
-- /* .highlight .kd { color: #bc6ec5 } /\* Keyword.Declaration *\/ */
-- /* .highlight .kn { color: #859900 } /\* Keyword.Namespace *\/ */
-- /* .highlight .kp { color: #859900 } /\* Keyword.Pseudo *\/ */
-- /* .highlight .kr { color: #bc6ec5 } /\* Keyword.Reserved *\/ */
-- /* .highlight .kt { color: #DC322F } /\* Keyword.Type *\/ */
-- /* .highlight .ld { color: #93A1A1 } /\* Literal.Date *\/ */
-- /* .highlight .m { color: #72abdf } /\* Literal.Number *\/ */
-- /* .highlight .s { color: #2d9574 } /\* Literal.String *\/ */
-- /* .highlight .na { color: #93A1A1 } /\* Name.Attribute *\/ */
-- /* .highlight .nb { color: #B58900 } /\* Name.Builtin *\/ */
-- /* .highlight .nc { color: #bc6ec5 } /\* Name.Class *\/ */
-- /* .highlight .no { color: #CB4B16 } /\* Name.Constant *\/ */
-- /* .highlight .nd { color: #86dc2f } /\* Name.Decorator *\/ */
-- /* .highlight .ni { color: #CB4B16 } /\* Name.Entity *\/ */
-- /* .highlight .ne { color: #CB4B16 } /\* Name.Exception *\/ */
-- /* .highlight .nf { color: #86dc2f } /\* Name.Function *\/ */
-- /* .highlight .nl { color: #93A1A1 } /\* Name.Label *\/ */
-- /* .highlight .nn { color: #93A1A1 } /\* Name.Namespace *\/ */
-- /* .highlight .nx { color: #E6E1DC } /\* Name.Other *\/ */
-- /* .highlight .py { color: #93A1A1 } /\* Name.Property *\/ */
-- /* .highlight .nt { color: #bc6ec5 } /\* Name.Tag *\/ */
-- /* .highlight .nv { color: #7590db } /\* Name.Variable *\/ */
-- /* .highlight .ow { color: #859900 } /\* Operator.Word *\/ */
-- /* .highlight .w { color: #93A1A1 } /\* Text.Whitespace *\/ */
-- /* .highlight .mf { color: #72abdf } /\* Literal.Number.Float *\/ */
-- /* .highlight .mh { color: #72abdf } /\* Literal.Number.Hex *\/ */
-- /* .highlight .mi { color: #72abdf } /\* Literal.Number.Integer *\/ */
-- /* .highlight .mo { color: #72abdf } /\* Literal.Number.Oct *\/ */
-- /* .highlight .sb { color: #586E75 } /\* Literal.String.Backtick *\/ */
-- /* .highlight .sc { color: #72abdf } /\* Literal.String.Char *\/ */
-- /* .highlight .sd { color: #93A1A1 } /\* Literal.String.Doc *\/ */
-- /* .highlight .s2 { color: #72abdf } /\* Literal.String.Double *\/ */
-- /* .highlight .se { color: #CB4B16 } /\* Literal.String.Escape *\/ */
-- /* .highlight .sh { color: #93A1A1 } /\* Literal.String.Heredoc *\/ */
-- /* .highlight .si { color: #72abdf } /\* Literal.String.Interpol *\/ */
-- /* .highlight .sx { color: #72abdf } /\* Literal.String.Other *\/ */
-- /* .highlight .sr { color: #DC322F } /\* Literal.String.Regex *\/ */
-- /* .highlight .s1 { color: #72abdf } /\* Literal.String.Single *\/ */
-- /* .highlight .ss { color: #72abdf } /\* Literal.String.Symbol *\/ */
-- /* .highlight .bp { color: #bc6ec5 } /\* Name.Builtin.Pseudo *\/ */
-- /* .highlight .vc { color: #bc6ec5 } /\* Name.Variable.Class *\/ */
-- /* .highlight .vg { color: #bc6ec5 } /\* Name.Variable.Global *\/ */
-- /* .highlight .vi { color: #bc6ec5 } /\* Name.Variable.Instance *\/ */
-- /* .highlight .il { color: #72abdf } /\* Literal.Number.Integer.Long *\/ */
