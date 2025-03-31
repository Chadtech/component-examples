module View.ProductCard.Swatch exposing
    ( Swatch
    , color
    , toHtml
    )

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Ev
import Style as S



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type alias Swatch msg =
    { value : Value
    , onClick : msg
    , selected : Bool
    }


type
    Value
    -- I see some of the swatches on Bellroy.com
    -- are textures, instead of solid colors.
    -- But for now, we will only support solid colors.
    = V__Color { r : Int, g : Int, b : Int }



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


color :
    { rgb : ( Int, Int, Int )
    , selected : Bool
    , onClick : msg
    }
    -> Swatch msg
color rec =
    let
        ( r, g, b ) =
            rec.rgb
    in
    { value = V__Color { r = r, g = g, b = b }
    , selected = rec.selected
    , onClick = rec.onClick
    }


toHtml : Swatch msg -> Html msg
toHtml swatch =
    let
        bg : Css.Style
        bg =
            case swatch.value of
                V__Color { r, g, b } ->
                    Css.backgroundColor <| Css.rgb r g b

        selectedCircle : Html msg
        selectedCircle =
            if swatch.selected then
                Html.div
                    [ Attr.css
                        [ S.roundedFull
                        , Css.border3 (Css.px 2) Css.solid (Css.rgb 255 255 255)
                        , S.flex1
                        ]
                    ]
                    []

            else
                Html.text ""
    in
    Html.div
        [ Attr.css
            [ S.w4
            , S.h4
            , bg
            , S.cursorPointer
            , S.roundedFull
            , Css.padding (Css.px 1)
            , S.row
            ]
        , Ev.onClick swatch.onClick
        ]
        [ selectedCircle ]
