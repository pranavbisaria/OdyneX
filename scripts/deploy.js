const hre = require("hardhat");

async function main(){
  const OdyneX = await hre.ethers.getContractFactory("OdyneX");
  const odyneX = await OdyneX.deploy();

  await odyneX.deployed();

  console.log("Library deployed to:", odyneX.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});