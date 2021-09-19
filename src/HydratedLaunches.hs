module HydratedLaunches where

import Launches
import Rockets (Rocket, RocketId)

data HydratedLaunch = HydratedLaunch
  { id :: LaunchId,
    rocket :: Rocket,
    details :: LaunchDetails
  }
  deriving (Eq, Show)
