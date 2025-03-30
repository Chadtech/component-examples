module View.Button.Common exposing
    ( Variant(..)
    , styles
    )

import Css exposing (Style)
import Style as S



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type Variant
    = Primary
    | Secondary



----------------------------------------------------------------
-- HELPERS --
----------------------------------------------------------------


orange : Css.Color
orange =
    Css.rgb 225 90 29



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


styles : Variant -> List Style
styles variant =
    let
        bgColor : Style
        bgColor =
            case variant of
                Primary ->
                    Css.backgroundColor orange

                Secondary ->
                    Css.backgroundColor <| Css.rgba 0 0 0 0

        textColor : Style
        textColor =
            case variant of
                Primary ->
                    Css.color <| Css.rgb 255 255 255

                Secondary ->
                    Css.color orange

        fontWeight : Style
        fontWeight =
            case variant of
                Primary ->
                    S.fontWeight800

                Secondary ->
                    S.none
    in
    [ bgColor
    , S.rounded
    , textColor
    , fontWeight
    , S.border
    , Css.borderColor orange
    , S.pointerCursor
    ]
