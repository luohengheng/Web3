import { ethers } from "ethers";

const ALCHEMOLY_KEY = 'UmH8ksPbAVGoXlELP86ZIq1tzx_Y3zrr'
const provider = new ethers.JsonRpcProvider(`https://eth-sepolia.g.alchemy.com/v2/${ALCHEMOLY_KEY}`)
const PRIVEATE_KEY = 'fc2107e516d5751e473cbd898d3d1c59c14115f9720dd32f64bd13185cdfb77f'
const wallet = new ethers.Wallet(PRIVEATE_KEY, provider)
const walletAddress = await wallet.getAddress()

const contractAddress= '0x7b79995e5f793a07bc00c21412e50ecae098e7f9'
// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function deposit() public payable",
    "function transfer(address, uint) public returns (bool)",
    "function withdraw(uint) public",
]
const contractWETH = new ethers.Contract(contractAddress, abiWETH, wallet)
// const contractWETH = new ethers.Contract(contractAddress, abiWETH, provider)

const balanceWETH = await contractWETH.balanceOf(walletAddress)
console.log('balanceWETH', balanceWETH);

const tx = await contractWETH.deposit({value: ethers.parseEther('0.001')})
await tx.wait()
console.log('tx', tx);
const balanceWETH_deposit = await contractWETH.balanceOf(walletAddress)
console.log(`存款后WETH持仓: ${ethers.formatEther(balanceWETH_deposit)}\n`)

const tx2 = await contractWETH.transfer('vitalik.eth', ethers.parseEther('0.001'))
await tx2.wait()
const balanceWETH_transfer = await contractWETH.balanceOf(walletAddress)
console.log(`转账后WETH持仓: ${ethers.formatEther(balanceWETH_transfer)}\n`);

