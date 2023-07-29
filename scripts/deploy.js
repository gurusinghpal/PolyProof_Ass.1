const hre = require("hardhat");
const fs = require("fs");

async function main() {
  // Create constructor
  const NFT = await hre.ethers.getContractFactory("MyNFT");

  const prompt = "This is the prompt for my unusual NFT collection";

  // Deploy the contract with provided prompt
  const nft = await NFT.deploy(prompt);
  

  // Wait for the contract to be deployed
  await nft.deployed();

  // Log the contract address
  console.log("NFT contract deployed to:", nft.address);

  console.log("Prompt description:", await nft.promptDescription());

  // export the addresses
  fs.writeFileSync(
    "metadata/contractAddress.js",
    `
    export const nftAddress = "${nft.address}"
  `
  );
}

// Execute the deployment function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
