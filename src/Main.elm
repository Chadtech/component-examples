module Main exposing (main)

{-| This repo is meant to demonstrate how I would make various components in Elm.

Making components is tricky. The fundamental reason to make re-usable components,
is to unite various implementations under one common code source. In this way,
changes made to the component are reflected at all the places it is used. I think
this is counter-intuitive to many people, who think that if two things are the same
(two buttons, for example), they should be the same code. This is true only to the
extent that we expect the buttons to change together. If two buttons are identical,
but we know that one button will evolve over time in ways that will interfere with
the implementation details of the other, they should not be based on a re-usable
component. Conversely, if two things are not the same, but maybe share one important
attribute, such as their width, they _should_ be based on re-usable code. That way,
if we need to change the width, all things that share that width will change
together, regardless as to whether those things are in any sense "the same".

Furthermore, this question of "do these things change together" applies not only to
the decision of whether to make something a re-usable component, but which parts
should be re-usable. Modals, for example, are all similar in their placement on the
screen, their general layout, and their behavior of closing when clicked outside of.
But beyond that, they are pretty different, and might have wildly different content
in the body of the modal. Given these details, Modal components should generally
re-use code for the container of the modal, but the body of the internal content of
a modal should be pretty open and loosely defined with few requirements.

-}

import Browser exposing (Document)
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Json.Decode as JD
import Style as S
import View.Button as Button
import View.Collapsible as Collapsible



--------------------------------------------------------
-- TYPES --
--------------------------------------------------------


type alias Model =
    { openCollapsibles : List CollapsibleExample }


type Component
    = Component__Button
    | Component__Collapsible


type CollapsibleExample
    = CE__Text
    | CE__Filter


type Msg
    = ClickedCollapsible CollapsibleExample
    | ClickedAddToCart
    | ClickedHello



--------------------------------------------------------
-- INIT --
--------------------------------------------------------


init : JD.Value -> ( Model, Cmd Msg )
init json =
    let
        model : Model
        model =
            { openCollapsibles = [] }
    in
    ( model, Cmd.none )



--------------------------------------------------------
-- HELPERS --
--------------------------------------------------------


allComponents : List Component
allComponents =
    [ Component__Button
    , Component__Collapsible
    ]


allCollapsibleExamples : List CollapsibleExample
allCollapsibleExamples =
    [ CE__Text
    , CE__Filter
    ]



--------------------------------------------------------
-- UPDATE --
--------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedCollapsible example ->
            ( { model
                | openCollapsibles =
                    if List.member example model.openCollapsibles then
                        List.filter ((/=) example) model.openCollapsibles

                    else
                        example :: model.openCollapsibles
              }
            , Cmd.none
            )

        ClickedAddToCart ->
            ( model, Cmd.none )

        ClickedHello ->
            ( model, Cmd.none )



--------------------------------------------------------
-- VIEW --
--------------------------------------------------------


document : Model -> Document Msg
document model =
    { title = "Bellroy Components Examples"
    , body = List.map Html.toUnstyled <| view model
    }


globalStyles : Html Msg
globalStyles =
    Css.Global.global
        [ Css.Global.body
            [ S.m0
            , S.p4
            , S.col
            , S.g4
            ]
        ]


view : Model -> List (Html Msg)
view model =
    globalStyles :: List.map (componentView model) allComponents


componentView : Model -> Component -> Html Msg
componentView model component =
    Html.div
        [ Attr.css
            [ S.row ]
        ]
        [ Html.div
            [ Attr.css
                [ S.flex1 ]
            ]
            [ Html.text "TODO - code block area" ]
        , componentExampleView model component
        ]


componentExampleView : Model -> Component -> Html Msg
componentExampleView model component =
    Html.div
        [ Attr.css
            [ S.flex1
            , S.g4
            , S.col
            ]
        ]
        (case component of
            Component__Button ->
                [ Html.div
                    [ Attr.css
                        [ S.row
                        , S.g4
                        ]
                    ]
                    [ Button.simple "Hello" ClickedHello
                        |> Button.toHtml
                    , Button.simple "Hi" ClickedHello
                        |> Button.toHtml
                    ]
                , Html.div
                    [ Attr.css
                        [ S.w64 ]
                    ]
                    [ Button.simple "ADD TO CART" ClickedAddToCart
                        |> Button.fullWidth
                        |> Button.toHtml
                    ]
                ]

            Component__Collapsible ->
                List.map (collapsibleExampleView model.openCollapsibles) allCollapsibleExamples
        )


collapsibleExampleView : List CollapsibleExample -> CollapsibleExample -> Html Msg
collapsibleExampleView openCollapsibles example =
    let
        msg : Msg
        msg =
            ClickedCollapsible example

        isOpen : Bool
        isOpen =
            List.member example openCollapsibles
    in
    case example of
        CE__Text ->
            Collapsible.simple
                "Text"
                { isOpen = isOpen }
                msg
                |> Collapsible.toHtml
                    (if isOpen then
                        [ Html.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." ]

                     else
                        []
                    )

        CE__Filter ->
            Collapsible.simple
                "Filter"
                { isOpen = isOpen }
                msg
                |> Collapsible.toHtml
                    (if isOpen then
                        [ Html.text "TODO" ]

                     else
                        []
                    )



--------------------------------------------------------
-- SUBSCRIPTIONS --
--------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--------------------------------------------------------
-- MAIN --
--------------------------------------------------------


main : Program JD.Value Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = document
        }
