{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}

module Rockets where

import Data.Aeson (FromJSON)
import GHC.Generics
import Servant.API (ToHttpApiData)

newtype RocketId = RocketId String
  deriving (Eq, Show, Ord)
  deriving (FromJSON, ToHttpApiData) via String

newtype RocketName = RocketName String
  deriving (Eq, Show)
  deriving (FromJSON) via String

newtype RocketDescription = RocketDescription String
  deriving (Eq, Show)
  deriving (FromJSON) via String

newtype Stage = Stage Int
  deriving (Eq, Show)
  deriving (FromJSON) via Int

data Rocket = Rocket
  { id :: RocketId,
    name :: RocketName,
    description :: RocketDescription,
    stages :: Stage
  }
  deriving (Eq, Show, Generic)

instance FromJSON Rocket
