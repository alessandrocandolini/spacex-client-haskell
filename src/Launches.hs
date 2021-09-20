{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}

module Launches where

import Data.Aeson (FromJSON)
import GHC.Generics (Generic)
import Rockets (RocketId)

newtype LaunchId = LaunchId String
  deriving (Eq, Show)
  deriving (FromJSON) via String

newtype LaunchDetails = LaunchDetails String
  deriving (Eq, Show)
  deriving (FromJSON) via String

data Launch = Launch
  { id :: LaunchId,
    rocket :: RocketId,
    details :: Maybe LaunchDetails
  }
  deriving (Eq, Show, Generic)

instance FromJSON Launch
