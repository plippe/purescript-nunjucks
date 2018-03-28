## Module Nunjucks

#### `Nunjucks`

``` purescript
newtype Nunjucks
  = Nunjucks Foreign
```

#### `default`

``` purescript
default :: Nunjucks
```

#### `renderImpl`

``` purescript
renderImpl :: forall eff. Foreign -> String -> String -> Foreign -> Eff (exception :: EXCEPTION | eff) String
```

#### `render'`

``` purescript
render' :: forall eff c. Encode c => Nunjucks -> String -> String -> c -> Eff (exception :: EXCEPTION | eff) String
```

#### `render`

``` purescript
render :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
```

#### `renderString`

``` purescript
renderString :: forall eff c. Encode c => Nunjucks -> String -> c -> Eff (exception :: EXCEPTION | eff) String
```

#### `genericEncode'`

``` purescript
genericEncode' :: forall a rep. Generic a rep => GenericEncode rep => a -> Foreign
```

#### `ConfigurationType`

``` purescript
type ConfigurationType = { autoescape :: NullOrUndefined Boolean, throwOnUndefined :: NullOrUndefined Boolean, trimBlocks :: NullOrUndefined Boolean, lstripBlocks :: NullOrUndefined Boolean, watch :: NullOrUndefined Boolean, noCache :: NullOrUndefined Boolean, web :: NullOrUndefined WebConfiguration, express :: NullOrUndefined Foreign, tags :: NullOrUndefined TagsConfiguration }
```

#### `Configuration`

``` purescript
newtype Configuration
  = Configuration ConfigurationType
```

##### Instances
``` purescript
Newtype Configuration _
Generic Configuration _
Encode Configuration
```

#### `defaultConfiguration`

``` purescript
defaultConfiguration :: Configuration
```

#### `defaultConfiguration'`

``` purescript
defaultConfiguration' :: (ConfigurationType -> ConfigurationType) -> Configuration
```

#### `WebConfigurationType`

``` purescript
type WebConfigurationType = { useCache :: NullOrUndefined Boolean }
```

#### `WebConfiguration`

``` purescript
newtype WebConfiguration
  = WebConfiguration WebConfigurationType
```

##### Instances
``` purescript
Newtype WebConfiguration _
Generic WebConfiguration _
Encode WebConfiguration
```

#### `defaultWebConfigurationType`

``` purescript
defaultWebConfigurationType :: WebConfiguration
```

#### `defaultWebConfigurationType'`

``` purescript
defaultWebConfigurationType' :: (WebConfigurationType -> WebConfigurationType) -> WebConfiguration
```

#### `TagsConfigurationType`

``` purescript
type TagsConfigurationType = { blockStart :: NullOrUndefined String, blockEnd :: NullOrUndefined String, variableStart :: NullOrUndefined String, variableEnd :: NullOrUndefined String, commentStart :: NullOrUndefined String, commentEnd :: NullOrUndefined String }
```

#### `TagsConfiguration`

``` purescript
newtype TagsConfiguration
  = TagsConfiguration TagsConfigurationType
```

##### Instances
``` purescript
Newtype TagsConfiguration _
Generic TagsConfiguration _
Encode TagsConfiguration
```

#### `defaultTagsConfiguration`

``` purescript
defaultTagsConfiguration :: TagsConfiguration
```

#### `defaultTagsConfiguration'`

``` purescript
defaultTagsConfiguration' :: (TagsConfigurationType -> TagsConfigurationType) -> TagsConfiguration
```

#### `configureImpl`

``` purescript
configureImpl :: forall eff. Foreign -> Eff (exception :: EXCEPTION | eff) Nunjucks
```

#### `configure`

``` purescript
configure :: forall eff. Configuration -> Eff (exception :: EXCEPTION | eff) Nunjucks
```


