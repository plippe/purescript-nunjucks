module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Console (CONSOLE, log)

import Test.Nunjucks.Render as Render

main :: forall eff. Eff (exception :: EXCEPTION, console :: CONSOLE | eff) Unit
main = do
  _ <- Render.main
  log "You should add some tests."
