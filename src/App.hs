module App where

import Launches (Launch (rocket))
import Network (fetchLatestLaunch, fetchRocketDetails)
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Rockets (Rocket)
import Servant.Client (ClientError, ClientM, mkClientEnv, parseBaseUrl)
import Servant.Client.Internal.HttpClient (runClientM)

program :: IO ()
program = do
  manager <- newManager tlsManagerSettings
  baseUrl <- parseBaseUrl "https://api.spacexdata.com"
  let clientEnv = mkClientEnv manager baseUrl
  res <- runClientM fetch clientEnv
  printRes res

fetch :: ClientM (Launch, Rocket)
fetch = do
  l <- fetchLatestLaunch
  r <- fetchRocketDetails $ rocket l
  pure (l, r)

showResults :: Launch -> Rocket -> String
showResults = curry show

showResultsOrErrors :: Either ClientError (Launch, Rocket) -> String
showResultsOrErrors = either show (uncurry showResults)

printRes :: Either ClientError (Launch, Rocket) -> IO ()
printRes = putStrLn . showResultsOrErrors
