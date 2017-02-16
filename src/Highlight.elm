module Highlight exposing (highlighted)

import Highlight.Lexer exposing (lexer)
import Highlight.View exposing (renderToken)
import Html exposing (Html, pre, code, span, p, text)
import Html.Attributes exposing (class)


highlighted : String -> String -> Html msg
highlighted lang str =
    pre []
        [ code [] <| List.map renderToken <| lexer lang str ]



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
