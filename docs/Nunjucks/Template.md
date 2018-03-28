## Module Nunjucks.Template

#### `Template`

``` purescript
newtype Template
  = Template Foreign
```

#### `compile`

``` purescript
compile :: forall eff. String -> Eff (exception :: EXCEPTION | eff) Template
```

#### `renderImpl`

``` purescript
renderImpl :: forall eff. Foreign -> Foreign -> Eff (exception :: EXCEPTION | eff) String
```

#### `render`

``` purescript
render :: forall eff c. Encode c => Template -> c -> Eff (exception :: EXCEPTION | eff) String
```


