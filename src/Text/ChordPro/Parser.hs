-----------------------------------------------------------------------------
-- |
-- Module : Text.ChordPro.Parser
-- Copyright : (C) 2016 Ricky Elrod
-- License : BSD2 (see LICENSE file)
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
-- Portability : ghc
--
-- Parse <http://www.chordpro.org/chordpro/index.html ChordPro> files into
-- 'Chord's, 'Lyrics's, and 'Directive's.
----------------------------------------------------------------------------

module Text.ChordPro.Parser where

import Control.Applicative
import Text.ChordPro.Types
import Text.Parser.Char
import Text.Parser.Combinators
import Text.Parser.Token
import Text.Trifecta

parsePartialLyric :: (Monad m, TokenParsing m) => m Lyric
parsePartialLyric = Lyric <$> some (noneOf "[{\n")

parseChord :: (Monad m, TokenParsing m) => m Lyric
parseChord = do
  _ <- char '['
  chord <- manyTill anyChar (try (char ']'))
  return $ Chord chord

chordOrLyric :: (Monad m, TokenParsing m) => m Lyric
chordOrLyric = choice [ try parseChord
                      , try parsePartialLyric]

parseLyricLine :: (Monad m, TokenParsing m) => m [Lyric]
parseLyricLine = do
  s <- some chordOrLyric
  _ <- newline
  return s

