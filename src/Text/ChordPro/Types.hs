-----------------------------------------------------------------------------
-- |
-- Module : Text.ChordPro.Types
-- Copyright : (C) 2016 Ricky Elrod
-- License : BSD2 (see LICENSE file)
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
-- Portability : ghc
--
-- This module defines types used for working with ChordPro data.
--
-- We break this into four main types:
--   * a 'Lyric' relates to what the specification calls a \"song line.\"
--   * a 'Directive' is either a preamble, formatting, or output-related
--     directive.
--   * a 'ChordProLine' is a sum containing one of the above two types
--   * a 'ChordProSong' is a list of 'ChordProLines'
----------------------------------------------------------------------------

module Text.ChordPro.Types where

-- | A 'Lyric' relates to a song line. Given a line in a ChordPro file, we will
-- run across both lyrics and chords.
--
-- If we have the input string @Swing [D]low, sweet [G]chari[D]ot@, then we can
-- parse that into @[Lyric "Swing ", Chord D, Lyric "low, sweet ", Chord G,
-- Lyric "chari", Chord D, Lyric "ot"]@.
data Lyric =
    Lyric String
  | Chord String
  deriving (Eq, Ord, Show)

-- data Directive
