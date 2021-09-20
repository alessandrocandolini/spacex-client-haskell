module App where

import Control.Concurrent.Async.Lifted
import Control.Monad.Trans.Except
import qualified Data.Set as S
import Launches (Launch (rocket))
import Network (fetchLatestLaunch, fetchLaunches, fetchRocketDetails)
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Rockets (Rocket, RocketId)
import Servant.Client
  ( ClientEnv,
    ClientError,
    ClientM,
    mkClientEnv,
    parseBaseUrl,
    runClientM,
  )
import Servant.Client.Internal.HttpClient (runClientM)

program :: IO ()
program = clientEnv >>= program'

clientEnv :: IO ClientEnv
clientEnv = mkClientEnv <$> manager <*> baseUrl
  where
    manager = newManager tlsManagerSettings
    baseUrl = parseBaseUrl "https://api.spacexdata.com"

program' :: ClientEnv -> IO ()
program' = (=<<) printRes . runClientM fetch

fetch :: ClientM ([Launch], [Rocket])
fetch = do
  l <- fetchLaunches
  r <- mapConcurrently fetchRocketDetails (uniqueRocketIds l)
  pure (l, r)

uniqueRocketIds :: [Launch] -> [RocketId]
uniqueRocketIds = S.toList . S.fromList . fmap rocket

showResults :: (Show a, Show b) => a -> b -> String
showResults _ = show

showResultsOrErrors :: (Show a, Show b) => Either ClientError (a, b) -> String
showResultsOrErrors = either show (uncurry showResults)

printRes :: (Show a, Show b) => Either ClientError (a, b) -> IO ()
printRes = putStrLn . showResultsOrErrors
