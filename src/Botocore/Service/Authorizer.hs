{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

-- |
-- Module      : Botocore.Service.Authorizer
-- Copyright   : (c) 2023 Bellroy Pty Ltd
-- License     : BSD-3-Clause
-- Maintainer  : Bellroy Tech Team <haskell@bellroy.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Botocore.Service.Authorizer where

import Barbies (Barbie (..))
import Barbies.TH (passthroughBareB)
import Botocore.Service.Authorizer.Placement (Placement)
import Botocore.Service.Authorizer.Placement qualified as Placement
import Data.Aeson.Decoding.Tokens (Tokens (..))
import Data.Aeson.Decoding.Tokens.Direct
  ( Parser (..),
    enum,
    field,
    record,
    text,
  )
import Data.Text (Text)
import GHC.Generics (Generic)

data Type = Provided
  deriving (Bounded, Enum, Eq, Ord, Show, Generic)

$( passthroughBareB
     [d|
       data Authorizer = Authorizer
         { name :: Text,
           type_ :: Type,
           placement :: Placement
         }
         deriving stock (Eq, Show, Generic)
       |]
 )

parse :: Parser Tokens k e Authorizer
parse =
  record
    Authorizer
      { name = field "name" text,
        type_ = field "type" . enum $ \case
          Provided -> "provided",
        placement = field "placement" Placement.parse
      }
