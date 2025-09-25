// Import the compiled Gleam module output path after `gleam build`.
import * as game from "./build/dev/javascript/glick80/game.mjs";

let state = game.initial_state;

globalThis.TIC = function() {
  if (game.tic) {
    state = game.tic(state);
  }
};

// Only register callback functions if they exist
if (game.bdr) globalThis.BDR = function(row) {
  state = game.bdr(row, state);
};
if (game.boot) globalThis.BOOT = function() {
  state = game.boot(state);
};
if (game.menu) globalThis.MENU = function(index) {
  state = game.menu(index, state);
};
if (game.scn) globalThis.SCN = function(row) {
  state = game.scn(row, state);
};
