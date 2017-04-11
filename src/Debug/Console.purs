module Debug.Console (debug, module R) where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Console (CONSOLE) as R
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Exception (EXCEPTION) as R
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.List (List(..), (:))
import Data.Tuple (Tuple(..))
import Debug (Debug, resume, runWatch)
import Debug (Debug, Watch, resume, runWatch, watch, break) as R
import Node.ReadLine (READLINE, LineHandler, Interface, setPrompt, noCompletion,
                      createConsoleInterface, prompt, setLineHandler, close)
import Node.ReadLine (READLINE) as R

-- | Run a debug session in the console
debug
  :: forall a eff
   . Show a
  => Debug a
  -> Eff ( readline :: READLINE
         , console :: CONSOLE
         , exception :: EXCEPTION
         | eff
         ) Unit
debug dbg = do
    readline <- createConsoleInterface noCompletion
    setPrompt "λ> " 3 readline
    go readline Nil Nil dbg
  where
    go :: forall eff1
        . Interface
       -> List (Debug a)
       -> List (Debug a)
       -> Debug a
       -> Eff ( console :: CONSOLE
              , readline :: READLINE
              | eff1
              ) Unit
    go readline past future present = do
      case resume present of
        Left a -> void do
          log "Finished."
          log $ "Result: " <> show a
          input readline past future present
        Right (Tuple ws _) -> void do
          log "Hit a breakpoint."
          log "Watches: "
          for_ (runWatch ws) \(Tuple name value) -> log ("  " <> name <> ": " <> value)
          input readline past future present

    input
      :: forall eff1
       . Interface
      -> List (Debug a)
      -> List (Debug a)
      -> Debug a
      -> Eff ( readline :: READLINE
             , console :: CONSOLE
             | eff1
             ) Unit
    input readline past future present = void do
        setLineHandler readline handler
        prompt readline
      where
        handler :: forall eff2
                 . LineHandler ( console :: CONSOLE
                               , readline :: READLINE
                               | eff2
                               ) Unit
        handler "b" = case past of
          Nil -> void do
            log "Already at the oldest frame!"
            prompt readline
          Cons first rest -> go readline rest (present : future) first
        handler "f" = case future of
          Nil -> void do
            log "Already at the latest frame!"
            prompt readline
          Cons first rest -> go readline (present : past) rest first
        handler "n" = case resume present of
          Left _ -> void do
            log "Already completed!"
            prompt readline
          Right (Tuple _ next) -> go readline (present : past) Nil next
        handler "r" = go readline Nil Nil dbg
        handler "q" = void (close readline)
        handler _ = void do
          usage
          prompt readline

    usage :: forall eff1
           . Eff ( console :: CONSOLE
                 , readline :: READLINE
                 | eff1
                 ) Unit
    usage = do
      log "Available commands:"
      log ""
      log "  b  Step backwards"
      log "  f  Step forwards"
      log "  n  Step to next breakpoint"
      log "  r  Restart"
      log "  q  Quit"
