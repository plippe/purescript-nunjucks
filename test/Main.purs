module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Console (CONSOLE, log)

import Test.Nunjucks as Nunjucks
import Test.Nunjucks.Template as Template

main :: forall eff. Eff (exception :: EXCEPTION, console :: CONSOLE | eff) Unit
main = do
  _ <- Nunjucks.main
  _ <- Template.main
  log "You should add some tests."
