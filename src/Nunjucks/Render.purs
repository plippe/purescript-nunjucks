module Nunjucks.Render ( class Renderer
                       , extract
                       , render
                       , renderString
                       ) where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (Foreign)
import Data.Foreign.Class (class Encode, encode)

import Nunjucks

class Renderer a where
  extract :: a -> Foreign

instance rendererNunjucks :: Renderer Nunjucks where
  extract (Nunjucks obj) = obj

foreign import renderImpl :: forall eff. Foreign -> String -> String -> Foreign -> Eff (exception :: EXCEPTION | eff) String
render' :: forall eff r c. Renderer r => Encode c => r -> String -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render' renderer method str context = renderImpl (extract renderer) method str (encode context)

render :: forall eff r c. Renderer r => Encode c => r -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render renderer = render' renderer "render"

renderString :: forall eff r c. Renderer r => Encode c => r -> String -> c -> Eff (exception :: EXCEPTION | eff) String
renderString renderer = render' renderer "renderString"
