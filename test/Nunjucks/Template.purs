module Test.Nunjucks.Template where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, throw)

import Test.Nunjucks (Context(..))
import Nunjucks.Template (compile, render)

main :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
main = do
    _ <- testRender
    pure unit

testRender :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
testRender = do
    template <- compile "Hello {{ username }}"
    output <- render template (Context { username: "James" })
    if output == "Hello James"
        then pure unit
        else throw $ "Bad render output: " <> output
