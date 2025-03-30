module View.ProductCard exposing
    ( default
    , globalStyles
    , showInsideChip
    , view
    , withHoverOverChip
    )

import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type alias ProductCard msg =
    { hoverOverChip : Maybe (Html msg) }



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


default : ProductCard msg
default =
    { hoverOverChip = Nothing }


withHoverOverChip : Html msg -> ProductCard msg -> ProductCard msg
withHoverOverChip chip pc =
    { pc | hoverOverChip = Just chip }



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


view : ProductCard msg -> List (Html msg) -> Html msg
view productCard body =
    Html.div
        [ Attr.css
            [ Css.backgroundColor <| Css.rgb 225 225 225
            , S.relative
            ]
        , Attr.class "product-card"
        ]
        ((productCard.hoverOverChip
            |> Maybe.map
                (\html ->
                    Html.div
                        [ Attr.css
                            [ S.top0
                            , S.right0
                            , S.absolute
                            ]
                        , Attr.class "hover-over-chip"
                        ]
                        [ html ]
                )
            |> Maybe.withDefault (Html.text "")
         )
            :: body
        )


globalStyles : List Css.Global.Snippet
globalStyles =
    [ Css.Global.class "product-card"
        [ Css.Global.children
            [ Css.Global.class "hover-over-chip"
                [ Css.display Css.none
                ]
            ]
        , Css.hover
            [ Css.Global.children
                [ Css.Global.class "hover-over-chip"
                    [ Css.display Css.initial
                    ]
                ]
            ]
        ]
    ]


showInsideChip : Html msg
showInsideChip =
    Html.div
        [ Attr.css
            [ Css.backgroundColor <| Css.rgb 201 201 201
            , S.rounded
            , S.p1
            ]
        ]
        [ Html.text "SHOW INSIDE +" ]
