module View.Button exposing
    ( Button
    , disable
    , fullWidth
    , simple
    , toHtml
    )

import Css exposing (Style)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style as S



----------------------------------------------------------------
-- TYPES --
----------------------------------------------------------------


type alias Button msg =
    { label : String
    , onClick : msg
    , shape : Shape
    }


type Shape
    = Shape__Normal
    | Shape__FullWidth



----------------------------------------------------------------
-- API --
----------------------------------------------------------------


simple : String -> msg -> Button msg
simple label msg =
    { label = label
    , onClick = msg
    , shape = Shape__Normal
    }


fullWidth : Button msg -> Button msg
fullWidth button =
    { button
        | shape = Shape__FullWidth
    }


disable : Bool -> Button msg -> Button msg
disable b button =
    -- This is where we would change the wide button config
    -- to be disabled
    button


toHtml : Button msg -> Html msg
toHtml button =
    let
        width : Style
        width =
            case button.shape of
                Shape__Normal ->
                    S.none

                Shape__FullWidth ->
                    S.wFull
    in
    Html.button
        [ Attr.css
            [ width
            ]
        ]
        [ Html.text button.label ]
