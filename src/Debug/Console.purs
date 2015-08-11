module Debug.Console (debug) where
    
import Prelude
import Debug

import Data.List
import Data.Either
import Data.Tuple
import Data.Foldable (for_)

import Control.Monad.Eff
import Control.Monad.Eff.Console

import Node.ReadLine
    
-- | Run a debug session in the console
debug :: forall a eff. (Show a) => Debug a -> Eff (console :: CONSOLE | eff) Unit
debug dbg = do
  readline <- createInterface noCompletion
  setPrompt "λ> " 3 readline
  go readline Nil Nil dbg
  where
  go :: Interface -> List (Debug a) -> List (Debug a) -> Debug a -> Eff (console :: CONSOLE | eff) Unit
  go readline past future present = do
    log "\001B[2J\001B[0;0f"
    case resume present of
      Left a -> void do
        log "Finished."
        log $ "Result: " ++ show a
        input readline past future present
      Right (Tuple ws _) -> void do
        log "Hit a breakpoint."
        log "Watches: "
        for_ (runWatch ws) \(Tuple name value) -> log ("  " ++ name ++ ": " ++ value)
        input readline past future present
        
  input :: Interface -> List (Debug a) -> List (Debug a) -> Debug a -> Eff (console :: CONSOLE | eff) Unit
  input readline past future present = void do
    setLineHandler readline handler
    prompt readline
    where 
    handler :: LineHandler eff Unit
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
      
  usage :: Eff (console :: CONSOLE | eff) Unit
  usage = do
    log "Available commands:"
    log ""
    log "  b  Step backwards"
    log "  f  Step forwards"
    log "  n  Step to next breakpoint"
    log "  r  Restart"
    log "  q  Quit"
      