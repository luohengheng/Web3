import { ethers } from "ethers";

// const ALCHEMY_MAINNET_URL = 'https://rpc.ankr.com/eth';
const ALCHEMY_MAINNET_URL = 'https://eth.llamarpc.com';
const ALCHEMY_SEPOLIA_URL = 'https://rpc.sepolia.org';

const providerETH = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);
const proviederSepolia = new ethers.JsonRpcProvider(ALCHEMY_SEPOLIA_URL);

async function checkBalances() {
    // 1. 查询vitalik在主网和Sepolia测试网的ETH余额
    console.log("1. 查询vitalik在主网和Sepolia测试网的ETH余额");
    try {
        const balance = await providerETH.getBalance('vitalik.eth');
        const newwork = (await providerETH.getNetwork()).toJSON();
        const blockNumber = await providerETH.getBlockNumber();
        const txCount = await providerETH.getTransactionCount("vitalik.eth");
        const feeData = await providerETH.getFeeData();
        const block = await providerETH.getBlock(0);

        const code = await providerETH.getCode("0xc778417e063141139fce010982780140aa0cd5ab")

        console.log(balance, newwork, blockNumber, txCount, feeData, block, code);
        // const balanceSepolia = await proviederSepolia.getBalance('0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045');
        // console.log(`Sepolia ETH balance of vitalik: ${ethers.formatEther(balanceSepolia)} ETH`);
    } catch (error) {
        console.error("Error fetching balances:", error);
    }
}

checkBalances()