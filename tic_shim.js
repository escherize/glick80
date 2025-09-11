// Import the compiled Gleam module output path after `gleam build`.
import { initial_state, frame } from "./build/dev/javascript/glick80/game.mjs";

let state = initial_state;

globalThis.TIC = function () {
  state = frame(state);
};
