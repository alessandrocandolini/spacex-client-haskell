{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Network where

import Data.Proxy
import Models
import Servant.API (JSON, type (:>))
import Servant.API.Alternative
import Servant.API.Capture
import Servant.API.Verbs (Get)
import Servant.Client (ClientM)
import Servant.Client.Internal.HttpClient (client)

type Latest = "v4" :> "launches" :> "latest" :> Get '[JSON] Launch

type RocketDetails = "v4" :> "rockets" :> Capture "rocketId" String :> Get '[JSON] Rocket

type Api = Latest :<|> RocketDetails

api :: Proxy Api
api = Proxy

fetchLatestLaunch :: ClientM Launch
fetchRocketDetails :: String -> ClientM Rocket
(fetchLatestLaunch :<|> fetchRocketDetails) = client api
