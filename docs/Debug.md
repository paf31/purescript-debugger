## Module Debug

#### `Watch`

``` purescript
data Watch a
```

A monad for collecting watches      

##### Instances
``` purescript
instance functorWatch :: Functor Watch
instance applyWatch :: Apply Watch
instance applicativeWatch :: Applicative Watch
instance bindWatch :: Bind Watch
instance monadWatch :: Monad Watch
```

#### `runWatch`

``` purescript
runWatch :: forall a. Watch a -> List (Tuple String String)
```

Get the list of watches.

#### `watch`

``` purescript
watch :: forall a. (Show a) => String -> a -> Watch Unit
```

Define a watch

#### `Debug`

``` purescript
data Debug a
```

A monad for debugging pure functions

##### Instances
``` purescript
instance functorDebug :: Functor Debug
instance applyDebug :: Apply Debug
instance applicativeDebug :: Applicative Debug
instance bindDebug :: Bind Debug
instance monadDebug :: Monad Debug
```

#### `resume`

``` purescript
resume :: forall a. Debug a -> Either a (Tuple (Watch Unit) (Debug a))
```

Run the first step of a `Debug` session.

#### `break`

``` purescript
break :: Watch Unit -> Debug Unit
```

Define a breakpoint with the specified array of watches


