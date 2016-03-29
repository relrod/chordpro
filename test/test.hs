import Test.Tasty
import Test.Tasty.HUnit
import Text.ChordPro.Parser
import Text.ChordPro.Types
import Text.Trifecta

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests]

simpleLyric :: String
simpleLyric = concat [ "[C]Cecilia, you're [F]breaking my [C]heart, you're "
                     , "[F]shaking my [C]confidence [G7]daily.\n"
                     ]

parseSimpleLyric :: Result [Lyric]
parseSimpleLyric = parseString parseLyricLine mempty simpleLyric

isSuccess :: Result a -> Bool
isSuccess (Success _) = True
isSuccess _ = False

resultToMaybe :: Result a -> Maybe a
resultToMaybe (Success a) = Just a
resultToMaybe _ = Nothing

unitTests = testGroup "Unit tests"
  [ testCase "Parse a simple lyric line successfully" $
      isSuccess parseSimpleLyric @?= True

  , testCase "Parse a simple lyric line into correct length" $
      (length <$> (resultToMaybe parseSimpleLyric)) @?= Just 12
  ]
