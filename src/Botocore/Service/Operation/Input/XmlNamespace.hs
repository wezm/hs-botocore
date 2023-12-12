{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

-- |
-- Module      : Botocore.Service.Operation.Input.XmlNamespace
-- Copyright   : (c) 2023 Bellroy Pty Ltd
-- License     : BSD-3-Clause
-- Maintainer  : Bellroy Tech Team <haskell@bellroy.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Botocore.Service.Operation.Input.XmlNamespace where

import Barbies (Barbie (..))
import Barbies.TH (passthroughBareB)
import Data.Aeson.Decoding.Tokens (Tokens (..))
import Data.Aeson.Decoding.Tokens.Direct (Parser (..), field, record, text)
import Data.Text (Text)
import GHC.Generics (Generic)

$( passthroughBareB
     [d|
       data XmlNamespace = XmlNamespace {uri :: Text}
         deriving stock (Eq, Show, Generic)
       |]
 )

parse :: Parser Tokens k e XmlNamespace
parse = record XmlNamespace {uri = field "uri" text}
