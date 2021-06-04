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
  it('should call a function that get total supply', async () => {
    const seoTokenTotalSupply = (await seoTokenInstance.totalSupply.call()).toNumber();

    assert.equal(seoTokenTotalSupply, 21000000000000, "21000000000000 wasn't in total Supply");
  });
  it('should confirm seo token info correctly', async () => {
    const seoTokenName = await seoTokenInstance.name.call();
    const seoTokenOwner = await seoTokenInstance.getOwner.call();
    const seoTokenSymbol = await seoTokenInstance.symbol.call();
    const seoTokenDecimals = (await seoTokenInstance.decimals.call()).toNumber();

    // Get initial balances of first and second account.
    assert.equal(seoTokenOwner, accounts[0], "SEO token owner wasn't first account correctly");
    assert.equal(seoTokenName, "SEO mockup coin2", "SEO token name wasn't equal to 'SEO coin'");
    assert.equal(seoTokenSymbol, "SEO", "SEO token symbol wasn't equal to 'SEO'");
    assert.equal(seoTokenDecimals, 18, "SEO token decimals wasn't equal to 18");
  });
  it('should send seo token to another address correctly', async () => {
    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (await seoTokenInstance.balanceOf.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await seoTokenInstance.balanceOf.call(accountTwo)).toNumber();

    // Make transaction from first account to second.
    const amount = 10;
    await seoTokenInstance.transfer(accountTwo, amount, { from: accountOne });

    // Get balances of first and second account after the transactions.
    const accountOneEndingBalance = (await metaCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await metaCoinInstance.getBalance.call(accountTwo)).toNumber();


    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
  });
});
