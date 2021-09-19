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
program' = (=<<) printRes . runExceptT . fetch

fetch :: ClientEnv -> ExceptT ClientError IO ([Launch], [Rocket])
fetch e = do
  l <- fetchAll
  r <- mapConcurrently fetchRocket (uniqueRocketIds l)
  pure (l, r)
  where
    fetchAll = ExceptT $ runClientM fetchLaunches e
    fetchRocket r = ExceptT $ print r >> runClientM (fetchRocketDetails r) e

uniqueRocketIds :: [Launch] -> [RocketId]
uniqueRocketIds = S.toList . S.fromList . fmap rocket

showResults :: (Show a, Show b) => a -> b -> String
showResults _ = show

showResultsOrErrors :: (Show a, Show b) => Either ClientError (a, b) -> String
showResultsOrErrors = either show (uncurry showResults)

printRes :: (Show a, Show b) => Either ClientError (a, b) -> IO ()
printRes = putStrLn . showResultsOrErrors
