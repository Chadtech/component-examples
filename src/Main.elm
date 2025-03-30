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
import Html.Styled as Html exposing (Html)
import Json.Decode as JD



--------------------------------------------------------
-- TYPES --
--------------------------------------------------------


type alias Model =
    {}


type Msg
    = NoOp



--------------------------------------------------------
-- INIT --
--------------------------------------------------------


init : JD.Value -> ( Model, Cmd Msg )
init json =
    ( {}, Cmd.none )



--------------------------------------------------------
-- UPDATE --
--------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



--------------------------------------------------------
-- VIEW --
--------------------------------------------------------


document : Model -> Document Msg
document model =
    { title = "Bellroy Components Examples"
    , body = List.map Html.toUnstyled <| view model
    }


view : Model -> List (Html Msg)
view model =
    [ Html.text "Hello World" ]



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
