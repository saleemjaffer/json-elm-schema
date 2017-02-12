module Fuzz.Extra exposing (..)

import Shrink exposing (Shrinker)
import Fuzz exposing (..)
import Random.Pcg as Random


-- import Fuzz.Internal as Internal exposing (Fuzz(..))


{-| A fuzzer for float values with a given minimum, inclusive.
Shrunken values will also be within the range.
-}
floatMinimum : Float -> Fuzzer Float
floatMinimum lo =
    custom
        (Random.frequency
            [ ( 4, Random.float lo (lo + 100) )
            , ( 1, Random.constant lo )
            , ( 8, Random.float lo (toFloat <| Random.maxInt - Random.minInt) )
            ]
        )
        (Shrink.keepIf (\i -> i >= lo) Shrink.float)


{-| A fuzzer for float values with a given maximum, inclusive.
Shrunken values will also be within the range.
-}
floatMaximum : Float -> Fuzzer Float
floatMaximum hi =
    custom
        (Random.frequency
            [ ( 4, Random.float (hi - 100) hi )
            , ( 1, Random.constant hi )
            , ( 8, Random.float (toFloat <| Random.minInt - Random.maxInt) hi )
            ]
        )
        (Shrink.keepIf (\i -> i <= hi) Shrink.float)
