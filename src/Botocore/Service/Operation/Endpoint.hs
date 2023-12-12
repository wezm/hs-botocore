{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

-- |
-- Module      : Botocore.Service.Operation.Endpoint
-- Copyright   : (c) 2023 Bellroy Pty Ltd
-- License     : BSD-3-Clause
-- Maintainer  : Bellroy Tech Team <haskell@bellroy.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Botocore.Service.Operation.Endpoint where

import Barbies (Barbie (..))
import Barbies.TH (passthroughBareB)
import Data.Aeson.Decoding.Tokens (Tokens (..))
import Data.Aeson.Decoding.Tokens.Direct (Parser (..), field, record, text)
import Data.Text (Text)
import GHC.Generics (Generic)

$( passthroughBareB
     [d|
       data Endpoint = Endpoint {hostPrefix :: Text}
         deriving stock (Eq, Show, Generic)
       |]
 )

parse :: Parser Tokens k e Endpoint
parse =
  record
    Endpoint
      { hostPrefix = field "hostPrefix" text
      }
