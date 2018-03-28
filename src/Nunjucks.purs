module Nunjucks where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (Foreign)
import Data.Foreign.Class (class Encode, encode)
import Data.Foreign.Generic (genericEncode, defaultOptions)
import Data.Foreign.Generic.Class (class GenericEncode)
import Data.Foreign.NullOrUndefined (NullOrUndefined(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype, over)

newtype Nunjucks = Nunjucks Foreign

foreign import default :: Nunjucks

foreign import renderImpl :: forall eff. Foreign -> String -> String -> Foreign -> Eff (exception :: EXCEPTION | eff) String
render' :: forall eff c. Encode c => Nunjucks -> String -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render' (Nunjucks nunjucks) method str context = renderImpl nunjucks method str (encode context)

-- Renders the template named name with the context hash. The result is returned from render and errors are thrown.
render :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
render nunjucks = render' nunjucks "render"

-- Same as render, but renders a raw string instead of loading a template.
renderString :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
renderString nunjucks = render' nunjucks "renderString"

genericEncode' :: forall a rep. Generic a rep => GenericEncode rep => a -> Foreign
genericEncode' = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

-- autoescape (default: true) controls if output with dangerous characters are escaped automatically. See Autoescaping
-- throwOnUndefined (default: false) throw errors when outputting a null/undefined value
-- trimBlocks (default: false) automatically remove trailing newlines from a block/tag
-- lstripBlocks (default: false) automatically remove leading whitespace from a block/tag
-- watch (default: false) reload templates when they are changed (server-side). To use watch, make sure optional dependency chokidar is installed.
-- noCache (default: false) never use a cache and recompile templates each time (server-side)
-- web an object for configuring loading templates in the browser
-- express an express app that nunjucks should install to
-- tags: (default: see nunjucks syntax) defines the syntax for nunjucks tags. See Customizing Syntax
type ConfigurationType =
    { autoescape :: NullOrUndefined Boolean
    , throwOnUndefined :: NullOrUndefined Boolean
    , trimBlocks :: NullOrUndefined Boolean
    , lstripBlocks :: NullOrUndefined Boolean
    , watch :: NullOrUndefined Boolean
    , noCache :: NullOrUndefined Boolean
    , web :: NullOrUndefined WebConfiguration
    , express :: NullOrUndefined Foreign
    , tags :: NullOrUndefined TagsConfiguration
    }

newtype Configuration = Configuration ConfigurationType
derive instance newtypeConfiguration :: Newtype Configuration _
derive instance repGenericConfiguration :: Generic Configuration _
instance encodeConfiguration :: Encode Configuration where encode = genericEncode'

defaultConfiguration :: Configuration
defaultConfiguration = Configuration
    { autoescape: NullOrUndefined Nothing
    , throwOnUndefined: NullOrUndefined Nothing
    , trimBlocks: NullOrUndefined Nothing
    , lstripBlocks: NullOrUndefined Nothing
    , watch: NullOrUndefined Nothing
    , noCache: NullOrUndefined Nothing
    , web: NullOrUndefined Nothing
    , express: NullOrUndefined Nothing
    , tags: NullOrUndefined Nothing
    }

defaultConfiguration' :: (ConfigurationType -> ConfigurationType) -> Configuration
defaultConfiguration' f = over Configuration f defaultConfiguration

-- object for configuring loading templates in the browser
-- useCache (default: false) will enable cache and templates will never see updates
-- async (default: false) will load templates asynchronously instead of synchronously (requires use of the asynchronous API for rendering)
type WebConfigurationType =
    { useCache :: NullOrUndefined Boolean
    -- , async :: NullOrUndefined Boolean
    }

newtype WebConfiguration = WebConfiguration WebConfigurationType
derive instance newtypeWebConfiguration :: Newtype WebConfiguration _
derive instance repGenericWebConfiguration :: Generic WebConfiguration _
instance encodeWebConfiguration :: Encode WebConfiguration where encode = genericEncode'

defaultWebConfigurationType :: WebConfiguration
defaultWebConfigurationType = WebConfiguration
    { useCache: NullOrUndefined Nothing
    -- , async: NullOrUndefined Nothing
    }

defaultWebConfigurationType' :: (WebConfigurationType -> WebConfigurationType) -> WebConfiguration
defaultWebConfigurationType' f = over WebConfiguration f defaultWebConfigurationType

-- If you want different tokens than {{ and the rest for variables, blocks, and comments, you can specify different tokens as the tags option
type TagsConfigurationType =
    { blockStart :: NullOrUndefined String
    , blockEnd :: NullOrUndefined String
    , variableStart :: NullOrUndefined String
    , variableEnd :: NullOrUndefined String
    , commentStart :: NullOrUndefined String
    , commentEnd :: NullOrUndefined String
    }

newtype TagsConfiguration = TagsConfiguration TagsConfigurationType
derive instance newtypeTagsConfiguration :: Newtype TagsConfiguration _
derive instance repGenericTagsConfiguration :: Generic TagsConfiguration _
instance encodeTagsConfiguration :: Encode TagsConfiguration where encode = genericEncode'

defaultTagsConfiguration :: TagsConfiguration
defaultTagsConfiguration = TagsConfiguration
    { blockStart: NullOrUndefined Nothing
    , blockEnd: NullOrUndefined Nothing
    , variableStart: NullOrUndefined Nothing
    , variableEnd: NullOrUndefined Nothing
    , commentStart: NullOrUndefined Nothing
    , commentEnd: NullOrUndefined Nothing
    }

defaultTagsConfiguration' :: (TagsConfigurationType -> TagsConfigurationType) -> TagsConfiguration
defaultTagsConfiguration' f = over TagsConfiguration f defaultTagsConfiguration

-- Tell nunjucks to flip any feature on or off with the opts hash
foreign import configureImpl :: forall eff. Foreign -> Eff (exception :: EXCEPTION | eff) Nunjucks
configure :: forall eff. Configuration -> Eff (exception :: EXCEPTION | eff) Nunjucks
configure = configureImpl <<< encode
