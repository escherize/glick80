// Re-export TIC-80 globals so Gleam can import them as ES module bindings.
export const spr = globalThis.spr;
export const btn = globalThis.btn;
export const cls = globalThis.cls;
// Name avoids clobbering Gleam stdlib names.
export const print = globalThis.print;
