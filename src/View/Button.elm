module View.Button exposing
    ( Button
    , disable
    , simple
    , toHtml
    )

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Ev
import View.Button.Common as Common



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type alias Button msg =
    { label : String
    , onClick : msg
    }



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


simple : String -> msg -> Button msg
simple label msg =
    { label = label
    , onClick = msg
    }


disable : Bool -> Button msg -> Button msg
disable b button =
    -- This is where we would change the wide button config
    -- to be disabled
    button


toHtml : Button msg -> Html msg
toHtml button =
    Html.button
        [ Attr.css Common.styles
        , Ev.onClick button.onClick
        ]
        [ Html.text button.label ]
