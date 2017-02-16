module Highlight.Token exposing (..)


type TokenType
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
    { tokenType : TokenType, str : String, index : Int }
