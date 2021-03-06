{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving, StandaloneDeriving, FlexibleInstances, NamedFieldPuns, OverloadedStrings, QuantifiedConstraints, TypeOperators, UndecidableInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Instances () where

-- Testing code depends on certain instances that we don't want to
-- expose in semantic-core proper, yet are important enough that
-- we should keep track of them in a dedicated file.

import           Analysis.File
import           Core.Name (Name (..))
import           Data.Aeson
import           Data.Text (pack)
import qualified System.Path as Path

deriving newtype instance ToJSON Name
deriving newtype instance ToJSONKey Name

instance ToJSON a => ToJSON (File a) where
  toJSON File{filePath, fileSpan, fileBody} = object
    [ "path" .= filePath
    , "span" .= fileSpan
    , "body" .= fileBody
    ]

instance ToJSON Path.AbsRelFile where
  toJSON p = toJSON (pack (Path.toString p))
