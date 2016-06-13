module Debug
  ( Debug
  , Watch
  , runWatch
  , resume
  , break
  , watch
  ) where

import Prelude

import Data.Either (Either(..))
import Data.List (List(..), singleton)
import Data.Tuple (Tuple(..))

-- | A monad for collecting watches
data Watch a = Watch (List (Tuple String String)) a

-- | Get the list of watches.
runWatch :: forall a. Watch a -> List (Tuple String String)
runWatch (Watch ws _) = ws

-- | Define a watch
watch :: forall a. Show a => String -> a -> Watch Unit
watch name value = Watch (singleton (Tuple name (show value))) unit

instance functorWatch :: Functor Watch where
  map f (Watch ws a) = Watch ws (f a)

instance applyWatch :: Apply Watch where
  apply = ap

instance applicativeWatch :: Applicative Watch where
  pure = Watch Nil

instance bindWatch :: Bind Watch where
  bind (Watch ws a) f =
    case f a of
      Watch ws' b -> Watch (ws <> ws') b

instance monadWatch :: Monad Watch

-- | A monad for debugging pure functions
data Debug a = Done a | Break (Watch Unit) (Debug a)

-- | Run the first step of a `Debug` session.
resume :: forall a. Debug a -> Either a (Tuple (Watch Unit) (Debug a))
resume (Done a) = Left a
resume (Break ws d) = Right (Tuple ws d)

instance functorDebug :: Functor Debug where
  map f (Done a) = Done (f a)
  map f (Break ws a) = Break ws (map f a)

instance applyDebug :: Apply Debug where
  apply = ap

instance applicativeDebug :: Applicative Debug where
  pure = Done

instance bindDebug :: Bind Debug where
  bind (Done a) f = f a
  bind (Break ws d) f = Break ws (bind d f)

instance monadDebug :: Monad Debug

-- | Define a breakpoint with the specified array of watches
break :: Watch Unit -> Debug Unit
break ws = Break ws (Done unit)
