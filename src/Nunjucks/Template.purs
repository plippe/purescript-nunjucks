module Nunjucks.Template where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (Foreign)
import Data.Foreign.Class (class Encode, encode)

newtype Template = Template Foreign

foreign import compile :: forall eff. String -> Eff (exception :: EXCEPTION | eff) Template

foreign import renderImpl :: forall eff. Foreign -> Foreign -> Eff (exception :: EXCEPTION | eff) String
render :: forall eff c. Encode c => Template -> c -> Eff (exception :: EXCEPTION | eff) String
render (Template template) context = renderImpl template (encode context)
