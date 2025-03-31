module View.ProductCard.Image exposing
    ( Image
    , simple
    , toHtml
    , withChip
    )

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type alias Image msg =
    { src : String
    , chip : Maybe (Html msg)
    }



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


simple : String -> Image msg
simple src =
    { src = src
    , chip = Nothing
    }


withChip : Html msg -> Image msg -> Image msg
withChip chip image =
    { image | chip = Just chip }


toHtml : Image msg -> Html msg
toHtml image =
    let
        chipView : Html msg
        chipView =
            case image.chip of
                Just chip ->
                    Html.div
                        [ Attr.css
                            [ S.absolute
                            , S.bottom0
                            , S.left0
                            ]
                        ]
                        [ chip ]

                Nothing ->
                    Html.text ""
    in
    Html.div
        [ Attr.css
            [ S.relative
            , S.row
            , S.justifyCenter
            , S.wFull
            ]
        ]
        [ Html.div
            [ Attr.css
                [ Css.backgroundImage <| Css.url image.src
                , Css.backgroundSize Css.cover
                , Css.backgroundPosition Css.center
                , S.h64
                , S.w64
                ]
            ]
            []
        , chipView
        ]
