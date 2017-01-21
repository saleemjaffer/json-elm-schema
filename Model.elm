module Model exposing (..)


type Schema
    = Object ObjectSchema
    | String StringSchema
    | Integer IntegerSchema
    | Number NumberSchema
    | Null


type alias BaseSchema extras =
    { extras
        | title : Maybe String
        , description : Maybe String
    }


type alias ObjectSchema =
    BaseSchema
        { properties : List ObjectProperty
        }


type alias BaseNumberSchema num =
    BaseSchema
        { minimum : Maybe num
        , maximum : Maybe num
        }


type alias IntegerSchema =
    BaseNumberSchema Int


type alias NumberSchema =
    BaseNumberSchema Float


type ObjectProperty
    = Required String Schema
    | Optional String Schema


type alias StringSchema =
    BaseSchema {}
