const Proxy = artifacts.require("Proxy");
const RociOct20Token = artifacts.require("RociOct20Token");
const RociNov20Token = artifacts.require("RociNov20Token");

const { soliditySha3, BN } = require("web3-utils");

contract("Proxy", accounts => {
    let RociOct20TokenContract, RociNov20TokenContract, Contract;

    before(async function() {
        await RociOct20Token.new(
            { from: accounts[0] }
        ).then(function(instance) {
            RociOct20TokenContract = instance;
        });

        await RociNov20Token.new(
            { from: accounts[1] }
        ).then(function(instance) {
            RociNov20TokenContract = instance;
        });

        await Proxy.new(
            { from: accounts[2] }
        ).then(function(instance) {
            Contract = instance;
        });
    });

    describe("token is created correctly", () => {
        it("RociOct20Token is created correctly", async () => {
            const balance = await RociOct20TokenContract.balanceOf(accounts[0]);
            assert.equal(
                balance.toString(),
                new BN('100000000000000000000000000').toString(),
                "10000000 RociOct20Token is not minted correctly..."
                );
        });

        it("RocNov20Token is created correctly", async () => {
            const balance = await RociNov20TokenContract.balanceOf(accounts[1]);
            assert.equal(
                balance.toString(),
                new BN('100000000000000000000000000').toString(),
                "10000000 RociNov20Token is not minted correctly..."
                );
        });
    });

    describe("token is registered in proxy correctly", () => {
        it("RociOct20Token is registered correctly", async() => {
            await Contract.registerToken(
                'roci-oct20',
                RociOct20TokenContract.address,
                { from: accounts[2] }
                );
        })

        it("RociNov20Token is registered correctly", async() => {
            await Contract.registerToken(
                'roci-nov20',
                RociNov20TokenContract.address,
                { from: accounts[2] }
                );
        })
    })

    describe("token is transferred successfully.", () => {
        it("transfer rocioct20token to second account", async() => {
            await Contract.registerToken(
                'roci-oct20',
                RociOct20TokenContract.address,
                { from: accounts[2] }
                );
            console.log(await Contract.test('roci-oct20'));
            console.log(new BN(await RociOct20TokenContract.balanceOf(accounts[0])).toString());
            console.log(accounts[0]);
            await RociOct20TokenContract.approve(Contract.address, '50000000000000000000000000', { from: accounts[0]});
            await Contract.transfer(
                'roci-oct20',
                accounts[1],
                '50000000000000000000000000',
                { from: accounts[0] }
            );
            console.log(new BN(await RociOct20TokenContract.balanceOf(accounts[1])).toString());
        })
    })
})