module Nunjucks where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (Foreign)
import Data.Foreign.Class (class Encode, encode)

newtype Nunjucks = Nunjucks Foreign

foreign import default :: Nunjucks

foreign import renderImpl :: forall eff. Foreign -> String -> String -> Foreign -> Eff (exception :: EXCEPTION | eff) String
render' :: forall eff c. Encode c => Nunjucks -> String -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render' (Nunjucks nunjucks) method str context = renderImpl nunjucks method str (encode context)

render :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render nunjucks = render' nunjucks "render"

renderString :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
renderString nunjucks = render' nunjucks "renderString"
