module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode as JE
import WebSocket
import Svg
import Svg.Attributes
import Svg.Events


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    Int


type Msg
    = Send String
    | Receive String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "Debug log: " msg of
        Send command ->
            ( model, WebSocket.send "ws://192.168.0.100:3000" command )

        Receive message ->
            ( model, Cmd.none )


buttonPress =
    "fill: #FFFFFF; stroke:#FFFFFF;"


circleNavigation =
    Svg.svg [ Svg.Attributes.version "1.2", Svg.Attributes.x "0px", Svg.Attributes.y "0px", Svg.Attributes.viewBox "0 0 900 900" ]
        [ Svg.g [ Svg.Attributes.id "Circle" ]
            [ Svg.path
                [ onClick <| Send "38"
                , Svg.Attributes.id "up"
                , Svg.Attributes.style "fill: #2D2D2D; stroke:#FFFFFF;"
                , Svg.Attributes.d "M759.8,140.2C680.5,61,571,12,450.1,12 C329,12,219.4,61.1,140.1,140.5l309.7,309.7L759.8,140.2z"
                ]
                []
            , Svg.path
                [ onClick <| Send "39"
                , Svg.Attributes.id "right"
                , Svg.Attributes.style "fill: #2D2D2D; stroke:#FFFFFF;"
                , Svg.Attributes.d "M759.8,759.9C839,680.6,888,571.1,888,450.2 c0-121.1-49.1-230.6-128.5-309.9L449.9,450L759.8,759.9z "
                ]
                []
            , Svg.path
                [ onClick <| Send "40"
                , Svg.Attributes.id "down"
                , Svg.Attributes.style "fill: #2D2D2D; stroke:#FFFFFF;"
                , Svg.Attributes.d "M140.1,759.9c79.3,79.2,188.8,128.2,309.7,128.2 c121.1,0,230.6-49.1,309.9-128.5L450.1,450L140.1,759.9z "
                ]
                []
            , Svg.path
                [ onClick <| Send "37"
                , Svg.Attributes.id "left"
                , Svg.Attributes.style "fill: #2D2D2D;stroke:#FFFFFF;"
                , Svg.Attributes.d "M140.3,140.2C61.1,219.4,12,329,12,449.9 c0,121.1,49.1,230.8,128.4,310l309.8-309.8L140.3,140.2z "
                ]
                []
            , Svg.circle
                [ onClick <| Send "13"
                , Svg.Attributes.id "enter"
                , Svg.Attributes.style "fill: #2D2D2D;stroke:#FFFFFF;"
                , Svg.Attributes.cx "450 "
                , Svg.Attributes.cy "450 "
                , Svg.Attributes.r "190.6 "
                ]
                []
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "canvas" ]
        [ circleNavigation
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://192.168.0.100:3000" Receive


init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )
