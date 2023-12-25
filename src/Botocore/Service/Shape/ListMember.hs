{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

-- |
-- Module      : Botocore.Service.Shape.ListMember
-- Copyright   : (c) 2023 Bellroy Pty Ltd
-- License     : BSD-3-Clause
-- Maintainer  : Bellroy Tech Team <haskell@bellroy.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Botocore.Service.Shape.ListMember where

import Barbies (Barbie (..))
import Barbies.TH (passthroughBareB)
import Botocore.Service.Types (ShapeName, shapeName)
import Data.Aeson.Decoding.Tokens (Tokens (..))
import Data.Aeson.Decoding.Tokens.Direct
  ( Parser,
    bool,
    field,
    optional,
    record,
    text,
  )
import Data.Text (Text)
import GHC.Generics (Generic)

$( passthroughBareB
     [d|
       data ListMember = ListMember
         { shape :: ShapeName,
           documentation :: Maybe Text,
           jsonvalue :: Maybe Bool,
           locationName :: Maybe Text
         }
         deriving stock (Eq, Show, Generic)
       |]
 )

parse :: Parser Tokens k e ListMember
parse =
  record
    ListMember
      { shape = field "shape" shapeName,
        documentation = optional $ field "documentation" text,
        jsonvalue = optional $ field "jsonvalue" bool,
        locationName = optional $ field "locationName" text
      }
