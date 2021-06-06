const SEOToken = artifacts.require("SEOToken");

contract('SEOToken', (accounts) => {
  let seoTokenInstance;
  before(async () => {
    seoTokenInstance = await SEOToken.deployed();
  });

  it('should be 0.5 for the rate of token vs BNB', async () => {
    const rateOrigin = await seoTokenInstance.rate();
    assert.equal(rateOrigin.valueOf(), 0, "0 wasn in the first deploying");
    await seoTokenInstance.setRate(500);
    const rateCurrent = await seoTokenInstance.rate();
    assert.equal(rateCurrent, 0.5, "0.5 wasn in rate setting");

  });
  it('should confirm seo token info correctly', async () => {
    const seoTokenOwner = await seoTokenInstance.getOwner.call();

    // Get initial token owner address.
    assert.equal(seoTokenOwner, accounts[0], "SEO token owner wasn't first account correctly");
  });
  it('should be set token holders and lquidity pool, reward wallet correctly', async () => {

    // Set token holders and liquidity, reward wallet.
    await seoTokenInstance.setHolders(0x6EF5A3a808aF1104151F0aE7Af59fA3D691e946c);
    const holders = await seoTokenInstance.getHolders().call({from: account[0]});
    assert.equal(holders[0], "0x6EF5A3a808aF1104151F0aE7Af59fA3D691e946c", "Holders address is not correctly");
 
    await seoTokenInstance.setLiquidity(0x8dDa136Be59c0BaEce2fBdD49A498F78f184E2ef);
    const liquidity = await seoTokenInstance.getLiquidity().call({from: account[0]});
    assert.equal(liquidity, "0x8dDa136Be59c0BaEce2fBdD49A498F78f184E2ef", "liquidity address is not correctly");

    await seoTokenInstance.setRewardWallet(0x25c13Ac1562FB4359F9d227ac42eAcEBfE96bFC9);
    const rewardWallet = await seoTokenInstance.getRewardWallet().call({from: account[0]});
    assert.equal(rewardWallet, "0x25c13Ac1562FB4359F9d227ac42eAcEBfE96bFC9", "reward Wallet address is not correctly");
  });
});
