# glick80

[![Package Version](https://img.shields.io/hexpm/v/glick80)](https://hex.pm/packages/glick80)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glick80/)

A Gleam library for building TIC-80 fantasy console games with pure functional programming.

## Philosophy

This library embraces Gleam's functional nature by treating all TIC-80 callbacks as pure functions that take and return state. The JavaScript shim handles the imperative state management, while your Gleam code remains purely functional and easily testable.

## Usage

```sh
gleam add glick80@1
```

Define your game state and implement TIC-80 callbacks:

```gleam
import glick80_api as g

pub type State {
  State(player_x: Float, player_y: Float, frame: Int)
}

pub const initial_state = State(120.0, 68.0, 0)

// Main game loop - called 60 times per second
pub fn tic(state: State) -> State {
  let new_state = update_game(state)
  draw_game(new_state)
  new_state
}

// Optional TIC-80 callbacks - all take and return state
pub fn boot(state: State) -> State {
  // Initialize your game
  state
}

pub fn bdr(row: Int, state: State) -> State {
  // Called for each scanline during drawing
  state  
}

pub fn menu(index: Int, state: State) -> State {
  // Handle menu interactions
  state
}

pub fn scn(row: Int, state: State) -> State {
  // Called between scanlines
  state
}
```

The JavaScript shim automatically detects which callbacks you've implemented and wires them to TIC-80, handling all state persistence between frames.

## TIC-80 Callback Reference

| Function | Parameters | When Called | Typically Updates State? |
|----------|------------|-------------|--------------------------|
| `tic(state)` | `State` | Every frame (60fps) | ✅ Yes - main game logic |
| `boot(state)` | `State` | Game startup | ✅ Yes - initialize game |
| `menu(index, state)` | `Int, State` | Menu interactions | ✅ Maybe - menu state |
| `bdr(row, state)` | `Int, State` | Each scanline | ❌ Rarely - visual effects |
| `scn(row, state)` | `Int, State` | Between scanlines | ❌ Rarely - visual effects |

All functions must take state as their last parameter and return the (possibly modified) state. This ensures your game logic remains purely functional and testable.

## API Functions

The `glick80_api` module provides bindings to all TIC-80 functions:

```gleam
import glick80_api as g

// Drawing
g.cls(color: Int)                    // Clear screen
g.pix(x: Int, y: Int, color: Int)    // Set pixel
g.spr(id: Int, x: Float, y: Float)   // Draw sprite
g.rect(x: Int, y: Int, w: Int, h: Int, color: Int)  // Draw rectangle
g.print(text: a, x: Int, y: Int)     // Print text

// Input  
g.btn(id: Int) -> Bool               // Button pressed
g.btnp(id: Int) -> Bool              // Button just pressed
g.mouse() -> Mouse                   // Mouse state

// Audio
g.sfx(id: Int)                       // Play sound effect
g.music(track: Int)                  // Play music

// And many more...
```

Further documentation can be found at <https://hexdocs.pm/glick80>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
