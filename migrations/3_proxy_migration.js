const Migrations = artifacts.require("Proxy");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
