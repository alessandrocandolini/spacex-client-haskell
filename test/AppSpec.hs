module AppSpec where

import App
import Test.QuickCheck.Property
import Test.Syd

spec :: Spec
spec = describe "Simple test" $ do
  it "example-based unit test" $
    1 `shouldBe` 2

  prop "property-based unit test" $
    \l -> reverse (reverse l) == (l :: [Int])
