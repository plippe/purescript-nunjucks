## Module Nunjucks.Render

#### `Renderer`

``` purescript
class Renderer a  where
  extract :: a -> Foreign
```

##### Instances
``` purescript
Renderer Nunjucks
```

#### `render`

``` purescript
render :: forall eff r c. Renderer r => Encode c => r -> String -> c -> Eff (exception :: EXCEPTION | eff) String
```

#### `renderString`

``` purescript
renderString :: forall eff r c. Renderer r => Encode c => r -> String -> c -> Eff (exception :: EXCEPTION | eff) String
```


