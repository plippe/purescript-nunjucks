module Test.Nunjucks.Render where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, message, throw, throwException, try)
import Data.Either (Either(..))
import Data.Foreign.Class (class Encode)
import Data.Foreign.Generic (defaultOptions, genericEncode)
import Data.Generic.Rep (class Generic)

import Nunjucks (default)
import Nunjucks.Render (render, renderString)

newtype Context = Context { username :: String }
derive instance repGenericContext :: Generic Context _
instance encodeContext :: Encode Context where encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

main :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
main = do
    _ <- testRenderNoFile
    _ <- testRender
    -- _ <- testRenderString

    pure unit

testRenderNoFile :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
testRenderNoFile = do
    errOrSuccess <- try $ render default "unknown" (Context { username: "James" })
    case errOrSuccess of
        Right succ -> throw "Render unknown should fail"
        Left err -> if (message err) == "template not found: unknown"
            then pure unit
            else throwException err

testRender :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
testRender = do
    output <- render default "/Users/pvinchon/Code/purescript-nunjucks/resources/index.nunjucks" (Context { username: "James" })
    if output == "Hello James\n"
        then pure unit
        else throw $ "Bad render output: " <> output

testRenderString :: forall eff. Eff (exception :: EXCEPTION | eff) Unit
testRenderString = do
    output <- renderString default "Hello {{ username }}" (Context { username: "James" })
    if output == "Hello James"
        then pure unit
        else throw $ "Bad renderString output: " <> output
