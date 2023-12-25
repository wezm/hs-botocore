{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

-- |
-- Module      : Botocore.Service.Shape.Value
-- Copyright   : (c) 2023 Bellroy Pty Ltd
-- License     : BSD-3-Clause
-- Maintainer  : Bellroy Tech Team <haskell@bellroy.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Botocore.Service.Shape.Value where

import Barbies (Barbie (..))
import Barbies.TH (passthroughBareB)
import Botocore.Service.Types (ShapeName, shapeName)
import Data.Aeson.Decoding.Tokens (Tokens (..))
import Data.Aeson.Decoding.Tokens.Direct
  ( Parser,
    field,
    optional,
    record,
    text,
  )
import Data.Text (Text)
import GHC.Generics (Generic)

$( passthroughBareB
     [d|
       data Value = Value
         { shape :: ShapeName,
           documentation :: Maybe Text,
           locationName :: Maybe Text
         }
         deriving stock (Eq, Show, Generic)
       |]
 )

parse :: Parser Tokens k e Value
parse =
  record
    Value
      { shape = field "shape" shapeName,
        documentation = optional $ field "documentation" text,
        locationName = optional $ field "locationName" text
      }
