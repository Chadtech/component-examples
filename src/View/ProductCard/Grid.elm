module View.ProductCard.Grid exposing (view)

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S


view : List (Html msg) -> Html msg
view body =
    Html.div
        [ Attr.css
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(auto-fill, minmax(286px, 1fr))"
            , S.g4
            ]
        ]
        body
