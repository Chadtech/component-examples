module View.ProductCard exposing
    ( asDark
    , default
    , descriptionView
    , globalStyles
    , newChip
    , priceView
    , showInsideChip
    , swatchesView
    , titleView
    , view
    , withHoverOverChip
    )

import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S
import View.ProductCard.Swatch as Swatch exposing (Swatch)



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type alias ProductCard msg =
    { hoverOverChip : Maybe (Html msg)
    , color : Color
    }


type Color
    = Color__Light
    | Color__Dark



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


default : ProductCard msg
default =
    { hoverOverChip = Nothing
    , color = Color__Light
    }


asDark : ProductCard msg -> ProductCard msg
asDark pc =
    { pc | color = Color__Dark }


withHoverOverChip : Html msg -> ProductCard msg -> ProductCard msg
withHoverOverChip chip pc =
    { pc | hoverOverChip = Just chip }



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


view : ProductCard msg -> List (Html msg) -> Html msg
view productCard body =
    let
        hoverOverChip : Html msg
        hoverOverChip =
            case productCard.hoverOverChip of
                Just chip ->
                    Html.div
                        [ Attr.css
                            [ S.top0
                            , S.right0
                            , S.absolute
                            , S.z1
                            ]
                        , Attr.class "hover-over-chip"
                        ]
                        [ chip ]

                Nothing ->
                    Html.text ""

        bgColor : Css.Color
        bgColor =
            case productCard.color of
                Color__Light ->
                    Css.rgb 247 247 247

                Color__Dark ->
                    Css.rgb 78 78 78

        textColor : Css.Color
        textColor =
            case productCard.color of
                Color__Light ->
                    Css.rgb 0 0 0

                Color__Dark ->
                    Css.rgb 255 255 255
    in
    Html.div
        [ Attr.css
            [ Css.backgroundColor bgColor
            , Css.color textColor
            , S.relative
            , S.col
            , S.itemsCenter
            , S.p2
            , S.g1
            ]
        , Attr.class "product-card"
        ]
        (hoverOverChip :: body)


titleView : String -> Html msg
titleView title =
    Html.div
        [ Attr.css
            [ S.wFull ]
        ]
        [ Html.text title ]


priceView : String -> Html msg
priceView price =
    Html.div
        [ Attr.css
            [ S.wFull
            ]
        ]
        [ Html.text price ]


swatchesView : List (Swatch msg) -> Html msg
swatchesView swatches =
    Html.div
        [ Attr.css
            [ S.wFull
            , S.g2
            , S.row
            ]
        ]
        (List.map Swatch.toHtml swatches)


descriptionView : String -> Html msg
descriptionView description =
    Html.div
        [ Attr.css
            [ S.wFull
            , S.textSm
            , Css.color <| Css.rgb 76 76 76
            ]
        ]
        [ Html.text description ]


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


newChip : Html msg
newChip =
    Html.div
        [ Attr.css
            [ Css.backgroundColor <| Css.rgb 108 184 200
            , S.rounded
            , S.px2
            , S.py1
            , Css.color <| Css.rgb 255 255 255
            , S.textSm
            ]
        ]
        [ Html.text "New" ]
