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
-- API --
----------------------------------------------------------------


styles : Variant -> List Style
styles variant =
    let
        bgColor : Style
        bgColor =
            case variant of
                Primary ->
                    S.bgOrange1

                Secondary ->
                    S.bgTransparent

        textColor : Style
        textColor =
            case variant of
                Primary ->
                    S.textWhite

                Secondary ->
                    S.textOrange

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
    , S.borderOrange
    , S.pointerCursor
    ]
