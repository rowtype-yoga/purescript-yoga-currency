module Test.Main where

import Prelude

import Data.Array as Array
import Data.Array.NonEmpty as NEA
import Data.Currency (Currency)
import Data.Currency as Currency
import Data.Maybe (Maybe(..), isJust)
import Data.String as String
import Effect (Effect)
import Effect.Aff (launchAff_)
import Partial.Unsafe (unsafeCrashWith)
import Test.QuickCheck (class Arbitrary)
import Test.QuickCheck.Gen (elements)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.QuickCheck (quickCheck)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

foreign import jsCurrencies :: Array String

newtype ArbCurrency = ArbCurrency Currency

instance Arbitrary ArbCurrency where
  arbitrary = ArbCurrency <$> elements nea
    where
    nea = case NEA.fromArray Currency.allCurrencies of
      Just a -> a
      Nothing -> unsafeCrashWith "allCurrencies is empty"

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "Currency" do
    it "toString produces 3-char codes" do
      quickCheck \(ArbCurrency c) ->
        String.length (Currency.toString c) == 3

    it "fromString <<< toString = Just (property)" do
      quickCheck \(ArbCurrency c) ->
        Currency.fromString (Currency.toString c) == Just c

    it "fromString rejects garbage" do
      Currency.fromString "ZZZ" `shouldEqual` Nothing
      Currency.fromString "" `shouldEqual` Nothing

    it "every JS runtime currency parses into our ADT" do
      let unparsed = Array.filter (\s -> not (isJust (Currency.fromString s))) jsCurrencies
      unparsed `shouldEqual` []

    it "every ADT constructor maps to a known JS runtime currency" do
      let excess = Array.filter (\c -> not (Array.elem (Currency.toString c) jsCurrencies)) Currency.allCurrencies
      map Currency.toString excess `shouldEqual` []

    it "spot check known currencies" do
      Currency.toString Currency.USD `shouldEqual` "USD"
      Currency.toString Currency.EUR `shouldEqual` "EUR"
      Currency.fromString "JPY" `shouldEqual` Just Currency.JPY
