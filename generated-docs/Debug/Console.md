## Module Debug.Console

#### `debug`

``` purescript
debug :: forall a. Show a => Debug a -> Effect Unit
```

Run a debug session in the console


### Re-exported from Debug:

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

#### `watch`

``` purescript
watch :: forall a. Show a => String -> a -> Watch Unit
```

Define a watch

#### `runWatch`

``` purescript
runWatch :: forall a. Watch a -> List (Tuple String String)
```

Get the list of watches.

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

