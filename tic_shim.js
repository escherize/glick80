// Import the compiled Gleam module output path after `gleam build`.
import { initial_state, draw, update} from "./build/dev/javascript/glick80/game.mjs";

let state = initial_state;

globalThis.TIC = function () {
  state = update(state);
  draw(state);
};
