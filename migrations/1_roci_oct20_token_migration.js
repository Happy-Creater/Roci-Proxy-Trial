const Migrations = artifacts.require("RociOct20Token");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
