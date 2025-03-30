module View.Button exposing
    ( Button
    , disable
    , primary
    , secondary
    , toHtml
    )

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Ev
import Style as S
import View.Button.Common as Common exposing (Variant)



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type alias Button msg =
    { label : String
    , onClick : msg
    , variant : Variant
    }



----------------------------------------------------------------
-- HELPERS --
----------------------------------------------------------------


make : String -> msg -> Variant -> Button msg
make label msg variant =
    { label = label
    , onClick = msg
    , variant = variant
    }



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


primary : String -> msg -> Button msg
primary label msg =
    make label msg Common.Primary


secondary : String -> msg -> Button msg
secondary label msg =
    make label msg Common.Secondary


disable : Bool -> Button msg -> Button msg
disable b button =
    -- This is where we would change the wide button config
    -- to be disabled
    button


toHtml : Button msg -> Html msg
toHtml button =
    Html.button
        [ Attr.css
            [ S.batch <| Common.styles button.variant
            , S.py2
            , S.px4
            ]
        , Ev.onClick button.onClick
        ]
        [ Html.text button.label ]
