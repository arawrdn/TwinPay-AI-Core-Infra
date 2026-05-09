const hre = require("hardhat");

async function main() {
  console.log("Deploying TwinPayAI_Core...");

  const TwinPayAI = await hre.ethers.getContractFactory("TwinPayAI_Core");
  const twinPay = await TwinPayAI.deploy();

  await twinPay.waitForDeployment();

  console.log(`TwinPayAI_Core deployed to: ${await twinPay.getAddress()}`);
  console.log("Don't forget to verify it on Celoscan!");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
