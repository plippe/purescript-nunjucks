module Nunjucks where

import Data.Foreign (Foreign)

newtype Nunjucks = Nunjucks Foreign

foreign import default :: Nunjucks
