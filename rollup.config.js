import resolve from "@rollup/plugin-node-resolve"
import commonjs from "@rollup/plugin-commonjs";
import terser from "@rollup/plugin-terser";

export default {
  input: "app/javascript/application.js",
  output: {
    file: "app/assets/builds/application.js",
    format: "iife",
    inlineDynamicImports: true,
    sourcemap: false,
  },
  plugins: [
    commonjs(),
    resolve(),
    terser(),
  ]
}
