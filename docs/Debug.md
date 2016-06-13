## Module Debug

#### `Watch`

``` purescript
data Watch a
```

A monad for collecting watches

##### Instances
``` purescript
Functor Watch
Apply Watch
Applicative Watch
Bind Watch
Monad Watch
```

#### `runWatch`

``` purescript
runWatch :: forall a. Watch a -> List (Tuple String String)
```

Get the list of watches.

#### `watch`

``` purescript
watch :: forall a. Show a => String -> a -> Watch Unit
```

Define a watch

#### `Debug`

``` purescript
data Debug a
```

A monad for debugging pure functions

##### Instances
``` purescript
Functor Debug
Apply Debug
Applicative Debug
Bind Debug
Monad Debug
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


