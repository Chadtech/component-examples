module View.Button.Common exposing (styles)

import Css exposing (Style)
import Style as S


styles : List Style
styles =
    [ Css.property "background-color" "rgb(225 90 29)"
    , S.rounded
    , Css.color <| Css.rgb 255 255 255
    , S.py2
    , S.px4
    , S.fontWeight800
    , S.borderNone
    , S.pointerCursor
    ]
