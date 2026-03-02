// Generates src/Data/Currency.purs from Intl.supportedValuesOf('currency')

const currencies = Intl.supportedValuesOf("currency").sort()
const n = currencies.length
const lines = []

lines.push(`module Data.Currency where`)
lines.push(``)
lines.push(`import Prelude`)
lines.push(``)
lines.push(`import Control.Monad.Except (throwError)`)
lines.push(`import Data.Enum (class Enum, class BoundedEnum, Cardinality(..), enumFromTo)`)
lines.push(`import Data.Maybe (Maybe(..))`)
lines.push(`import Foreign (ForeignError(..))`)
lines.push(`import Yoga.JSON (class ReadForeign, class WriteForeign, readImpl, writeImpl)`)
lines.push(``)

// ADT
lines.push(`data Currency`)
currencies.forEach((c, i) => {
  const prefix = i === 0 ? "  = " : "  | "
  lines.push(`${prefix}${c}`)
})
lines.push(``)
lines.push(`derive instance Eq Currency`)
lines.push(`derive instance Ord Currency`)
lines.push(``)
lines.push(`instance Show Currency where`)
lines.push(`  show = toString`)
lines.push(``)

// Bounded
lines.push(`instance Bounded Currency where`)
lines.push(`  bottom = ${currencies[0]}`)
lines.push(`  top = ${currencies[n - 1]}`)
lines.push(``)

// Enum
lines.push(`instance Enum Currency where`)
lines.push(`  succ = case _ of`)
currencies.forEach((c, i) => {
  if (i < n - 1) lines.push(`    ${c} -> Just ${currencies[i + 1]}`)
  else lines.push(`    ${c} -> Nothing`)
})
lines.push(`  pred = case _ of`)
currencies.forEach((c, i) => {
  if (i === 0) lines.push(`    ${c} -> Nothing`)
  else lines.push(`    ${c} -> Just ${currencies[i - 1]}`)
})
lines.push(``)

// BoundedEnum
lines.push(`instance BoundedEnum Currency where`)
lines.push(`  cardinality = Cardinality ${n}`)
lines.push(`  toEnum = case _ of`)
currencies.forEach((c, i) => lines.push(`    ${i} -> Just ${c}`))
lines.push(`    _ -> Nothing`)
lines.push(`  fromEnum = case _ of`)
currencies.forEach((c, i) => lines.push(`    ${c} -> ${i}`))
lines.push(``)

// toString
lines.push(`toString :: Currency -> String`)
lines.push(`toString = case _ of`)
currencies.forEach(c => lines.push(`  ${c} -> "${c}"`))
lines.push(``)

// fromString
lines.push(`fromString :: String -> Maybe Currency`)
lines.push(`fromString = case _ of`)
currencies.forEach(c => lines.push(`  "${c}" -> Just ${c}`))
lines.push(`  _ -> Nothing`)
lines.push(``)

// allCurrencies
lines.push(`allCurrencies :: Array Currency`)
lines.push(`allCurrencies = enumFromTo bottom top`)
lines.push(``)

// ReadForeign / WriteForeign
lines.push(`instance WriteForeign Currency where`)
lines.push(`  writeImpl = toString >>> writeImpl`)
lines.push(``)
lines.push(`instance ReadForeign Currency where`)
lines.push(`  readImpl f = do`)
lines.push(`    let parse s = case fromString s of`)
lines.push(`          Just c -> pure c`)
lines.push(`          Nothing -> throwError $ pure $ ForeignError $ "Unknown currency: " <> s`)
lines.push(`    s <- readImpl f`)
lines.push(`    parse s`)
lines.push(``)

process.stdout.write(lines.join("\n") + "\n")
