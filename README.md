# purescript-debugger

A simple console debugger for PureScript functions

- [Module Documentation](docs/)
- [Example](test/Main.purs)

## Usage

    bower i purescript-debugger
    
The `Debug` module defines the `Debug` monad, which can be used to set breakpoints in pure functions.

The `Debug.Console` module defines the `debug` function which evaluates your function in an interactive console UI, allowing you to step, rewind and fast-forward evaluation at a breakpoint.
