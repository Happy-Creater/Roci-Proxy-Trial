const Migrations = artifacts.require("RociNov20Token");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
