## Module Debug.Console

#### `debug`

``` purescript
debug :: forall a eff. (Show a) => Debug a -> Eff (console :: CONSOLE | eff) Unit
```

Run a debug session in the console


