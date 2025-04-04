module View.Collapsible exposing
    ( Collapsible
    , simple
    , toHtml
    )

--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Ev
import Style as S
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttr


type alias Collapsible msg =
    { label : String
    , isOpen : Bool
    , onClick : msg
    }



--------------------------------------------------------------------------------
-- HELPERS --
--------------------------------------------------------------------------------


chevronUpSvg : Html msg
chevronUpSvg =
    Svg.svg
        [ SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.css
            [ S.wFull
            , S.hAuto
            ]
        ]
        [ Svg.path
            [ SvgAttr.d "M6 9l6 6 6-6"
            , SvgAttr.fill "none"
            , SvgAttr.stroke "currentColor"
            , SvgAttr.strokeWidth "2"
            ]
            []
        ]


chevronDownSvg : Html msg
chevronDownSvg =
    Svg.svg
        [ SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.css
            [ S.wFull
            , S.hAuto
            ]
        ]
        [ Svg.path
            [ SvgAttr.d "M6 15l6-6 6 6"
            , SvgAttr.fill "none"
            , SvgAttr.stroke "currentColor"
            , SvgAttr.strokeWidth "2"
            ]
            []
        ]



--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------


simple : String -> { isOpen : Bool } -> msg -> Collapsible msg
simple label rec msg =
    { label = label
    , isOpen = rec.isOpen
    , onClick = msg
    }


toHtml : Collapsible msg -> Html msg
toHtml collapsible =
    let
        icon : Html msg
        icon =
            chevronUpSvg

        topRow : Html msg
        topRow =
            Html.div
                [ Attr.css
                    [ S.row
                    , S.justifySpaceBetween
                    , S.itemsCenter
                    ]
                ]
                [ Html.div
                    [ Attr.css
                        [ S.textGray0
                        ]
                    ]
                    [ Html.text collapsible.label ]
                , Html.div
                    [ Attr.css
                        [ S.w4
                        , S.h4
                        , Css.transform <|
                            Css.rotate
                                (Css.deg <|
                                    if collapsible.isOpen then
                                        0

                                    else
                                        180
                                )
                        , Css.property "transition" "transform 0.2s ease"
                        ]
                    ]
                    [ icon ]
                ]
    in
    Html.div
        [ Attr.css
            [ S.col
            , S.pointerCursor
            ]
        , Ev.onClick collapsible.onClick
        ]
        [ topRow ]
