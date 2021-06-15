const NumFun = artifacts.require("NumFun");
const NumUpdated = artifacts.require("NumUpdated");
const proxy = artifacts.require("proxy");

module.exports = async function(deployer, network, accounts) {
  //deploy contract
  const num = await NumFun.new();
  const prox = await proxy.new(num.address);

  //Create proxy to fool truffle
  var proxyNum = await NumFun.at(prox.address);

  //Set the num through the proxy
  await proxyNum.setNum(10);

  //Test
  var getNum = await proxyNum.getNum();
  console.log("Before upgrade: " + getNum.toNumber());
  console.log(prox.address);

  //deploy the new version
  const numUpdated = await NumUpdated.new();
  prox.upgrade(numUpdated.address);

  //fool truffle once again
  proxyNum = await NumUpdated.at(prox.address);

  //initialize the address
  proxyNum.Initialized(accounts[0]);

  //checks that storage remains
  getNum = await proxyNum.getNum();
  console.log("After upgrade: " + getNum.toNumber());
  console.log(prox.address);

  //set the new number
  await proxyNum.setNum(30);

  //return the result
  getNum = await proxyNum.getNum();
  console.log("After changed: " + getNum.toNumber());
  console.log(prox.address);
}
