{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Network
  ( api,
    fetchLatestLaunch,
    fetchRocketDetails,
    fetchLaunches,
  )
where

import Data.Proxy (Proxy (..))
import Launches (Launch)
import Rockets (Rocket, RocketId)
import Servant.API (JSON, type (:>))
import Servant.API.Alternative (type (:<|>) (..))
import Servant.API.Capture (Capture)
import Servant.API.Verbs (Get)
import Servant.Client (ClientEnv, ClientError, ClientM, HasClient (Client), hoistClient)
import Servant.Client.Internal.HttpClient (client, runClientM)

type LaunchesEndpoint = "v4" :> "launches" :> Get '[JSON] [Launch]

type LatestEndpoint = "v4" :> "launches" :> "latest" :> Get '[JSON] Launch

type RocketDetailsEndpoint = "v4" :> "rockets" :> Capture "rocketId" RocketId :> Get '[JSON] Rocket

type Api = LatestEndpoint :<|> RocketDetailsEndpoint :<|> LaunchesEndpoint

api :: Proxy Api
api = Proxy

fetchLatestLaunch :: ClientM Launch
fetchRocketDetails :: RocketId -> ClientM Rocket
fetchLaunches :: ClientM [Launch]
(fetchLatestLaunch :<|> fetchRocketDetails :<|> fetchLaunches) = client api
