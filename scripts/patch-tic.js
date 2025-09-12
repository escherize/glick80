#!/usr/bin/env node
const fs = require("fs");
const path = require("path");

const TIC_PATH = process.env.TIC_PATH;
const rel = process.argv[2] || "jstarget.js";
if (!TIC_PATH) {
  console.error("TIC_PATH not set. Example: TIC_PATH=\"/Users/bcm/Library/Application Support/com.nesbox.tic/TIC-80\"");
  process.exit(1);
}
const target = path.join(TIC_PATH, rel);
const CART = "dist/cart.js";
const START = "// script:  js";
const END = "// <TILES>";

if (!fs.existsSync(CART)) {
  console.error(`Missing ${CART}. Run: npm run build`);
  process.exit(1);
}
if (!fs.existsSync(target)) {
  console.error(`Target not found: ${target}`);
  process.exit(1);
}

const cart = fs.readFileSync(CART, "utf8");
const txt = fs.readFileSync(target, "utf8");
const startIdx = txt.indexOf(START);
if (startIdx === -1) {
  console.error(`Start marker not found: ${START}`);
  process.exit(1);
}
const endIdx = txt.indexOf(END, startIdx);
if (endIdx === -1) {
  console.error(`End marker not found after start: ${END}`);
  process.exit(1);
}

// backup
const bak = `${target}.bak`;
fs.writeFileSync(bak, txt, "utf8");

// replace strictly between markers, keep markers
const head = txt.slice(0, startIdx + START.length);
const tail = txt.slice(endIdx);
const out = `${head}\n${cart}\n${tail}`;
fs.writeFileSync(target, out, "utf8");

console.log(`Patched: ${target}`);
console.log(`Backup:  ${bak}`);