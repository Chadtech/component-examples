module View.Button.Wide exposing
    ( WideButton
    , simple
    , toHtml
    )

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type alias WideButton msg =
    { label : String
    , onClick : msg
    }



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


simple : String -> msg -> WideButton msg
simple label msg =
    { label = label
    , onClick = msg
    }


toHtml : WideButton msg -> Html msg
toHtml button =
    Html.button
        [ Attr.css
            [ S.wFull ]
        ]
        [ Html.text button.label ]
