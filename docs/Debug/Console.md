## Module Debug.Console

#### `debug`

``` purescript
debug :: forall a eff. Show a => Debug a -> Eff (readline :: READLINE, console :: CONSOLE, err :: EXCEPTION | eff) Unit
```

Run a debug session in the console


### Re-exported from Control.Monad.Eff.Console:

#### `CONSOLE`

``` purescript
data CONSOLE :: !
```

The `CONSOLE` effect represents those computations which write to the
console.

### Re-exported from Control.Monad.Eff.Exception:

#### `EXCEPTION`

``` purescript
data EXCEPTION :: !
```

This effect is used to annotate code which possibly throws exceptions

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

### Re-exported from Node.ReadLine:

#### `READLINE`

``` purescript
data READLINE :: !
```

The effect of interacting with a stream via an `Interface`

