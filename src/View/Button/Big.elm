module View.Button.Big exposing
    ( BigButton
    , disable
    , simple
    , toHtml
    )

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Ev
import Style as S
import View.Button.Common as Common



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type alias BigButton msg =
    { label : String
    , onClick : msg
    }



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


simple : String -> msg -> BigButton msg
simple label msg =
    { label = label
    , onClick = msg
    }


disable : Bool -> BigButton msg -> BigButton msg
disable b button =
    -- This is where we would change the wide button config
    -- to be disabled
    button


toHtml : BigButton msg -> Html msg
toHtml button =
    Html.button
        [ Attr.css
            [ S.wFull
            , S.batch Common.styles
            , S.shadow
            , Css.property "transition" "background-color 0.1s ease"
            , S.hover
                [ Css.backgroundColor <| Css.hex "#c75724" ]
            ]
        , Ev.onClick button.onClick
        ]
        [ Html.text button.label ]
