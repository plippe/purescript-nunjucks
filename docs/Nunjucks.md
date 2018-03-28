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


