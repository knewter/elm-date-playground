module Main exposing (..)

import Time exposing (Time)
import Html.App as App
import Html exposing (..)
import Html.Events exposing (onClick)
import Task


-- MSG


type Msg
    = GetTheTime
    | GotTheTime Time



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
            [ button [ onClick GetTheTime ] [ text "get it" ]
            , currentTime
            ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetTheTime ->
            model ! [ Task.perform GotTheTime GotTheTime (Time.now) ]

        GotTheTime time ->
            { model | currentTime = Just time } ! []


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    { currentTime = Nothing } ! []
