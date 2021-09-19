{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Network
  ( api,
    fetchLatestLaunch,
    fetchRocketDetails,
  )
where

import Data.Proxy (Proxy (..))
import Launches (Launch)
import Rockets (Rocket, RocketId)
import Servant.API (JSON, type (:>))
import Servant.API.Alternative (type (:<|>) (..))
import Servant.API.Capture (Capture)
import Servant.API.Verbs (Get)
import Servant.Client (ClientM)
import Servant.Client.Internal.HttpClient (client)

type Latest = "v4" :> "launches" :> "latest" :> Get '[JSON] Launch

type RocketDetails = "v4" :> "rockets" :> Capture "rocketId" RocketId :> Get '[JSON] Rocket

type Api = Latest :<|> RocketDetails

api :: Proxy Api
api = Proxy

fetchLatestLaunch :: ClientM Launch
fetchRocketDetails :: RocketId -> ClientM Rocket
(fetchLatestLaunch :<|> fetchRocketDetails) = client api
