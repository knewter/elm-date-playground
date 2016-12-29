module Main exposing (..)

-- based on example from http://package.elm-lang.org/packages/elm-lang/core/latest/Task#perform

import Time exposing (Time)
import Html exposing (..)
import Html.Events exposing (onClick)
import Task


-- MSG


type Msg
    = GetTime
    | NewTime Time



-- MODEL


type alias Model =
    { currentTime : Maybe Time
    }



-- VIEW


view : Model -> Html Msg
view model =
    let
        currentTime =
            case model.currentTime of
                Nothing ->
                    text ""

                Just theTime ->
                    text <| toString theTime
    in
        div []
            [ button [ onClick GetTime ] [ text "get time" ]
            , currentTime
            ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetTime ->
            model ! [ Task.perform NewTime Time.now ]

        NewTime time ->
            { model | currentTime = Just time } ! []


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    { currentTime = Nothing } ! []
