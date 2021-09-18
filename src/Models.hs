{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}

module Models where

import Data.Aeson (FromJSON)
import GHC.Generics

newtype RocketId = RocketId String
  deriving (Eq, Show)
  deriving (FromJSON) via String

newtype LaunchId = LaunchId String
  deriving (Eq, Show)
  deriving (FromJSON) via String

newtype LaunchDetails = LaunchDetails String
  deriving (Eq, Show)
  deriving (FromJSON) via String

data Launch = Launch
  { id :: LaunchId,
    rocket :: RocketId,
    details :: LaunchDetails
  }
  deriving (Eq, Show, Generic)

instance FromJSON Launch

data Rocket = Rocket
  { rocketId :: RocketId -- fix name
  }
  deriving (Eq, Show, Generic)

instance FromJSON Rocket
