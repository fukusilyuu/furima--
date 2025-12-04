// babel.config.js
module.exports = {
  presets: [
    "@babel/preset-env",
    // 他に必要なプリセットがあれば
  ],
  plugins: [
    ["@babel/plugin-proposal-class-properties", { "loose": true }],
    ["@babel/plugin-proposal-private-methods", { "loose": true }],
    // 他のプラグインがあれば続けて
  ]
};
