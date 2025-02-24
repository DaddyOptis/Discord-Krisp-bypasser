const MockKrispModule = {};

MockKrispModule._initialize = () => {
  console.warn("KrispModule initialization disabled.");
};

MockKrispModule.getNcModels = () => {
  console.warn("KrispModule.getNcModels disabled.");
  return Promise.resolve([]);
};

MockKrispModule.getVadModels = () => {
  console.warn("KrispModule.getVadModels disabled.");
  return Promise.resolve([]);
};

const Module = require('module');

const originalRequire = Module.prototype.require;

Module.prototype.require = function(path) {
  if (path === './discord_krisp.node') {
    console.warn("Krisp module intercepted and replaced with mock.");
    return MockKrispModule;
  }
  return originalRequire.call(this, path);
};