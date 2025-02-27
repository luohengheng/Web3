import { ethers } from "ethers";

const ALCHEMY_URL = "https://eth-sepolia.g.alchemy.com/v2/UmH8ksPbAVGoXlELP86ZIq1tzx_Y3zrr"
const provider = new ethers.JsonRpcProvider(ALCHEMY_URL)

// 创建随机的wallet对象
const wallet1 = ethers.Wallet.createRandom()
const wallet1WithProvider = wallet1.connect(provider)
const mnemonic = wallet1.mnemonic
// console.log('wallet1', wallet1, wallet1WithProvider, mnemonic);

// 通过私钥创建签包
const privateKey = 'fc2107e516d5751e473cbd898d3d1c59c14115f9720dd32f64bd13185cdfb77f'
// const privateKey = '850b8cd0409780b6e25bb56320c4dfbe9c1bdf05bc6118e0290fc3b63fe08f3b'
const wallet2 = new ethers.Wallet(privateKey, provider)
// console.log('wallet2', wallet2, wallet2.mnemonic);


// 从助记词创建wallet对象
const wallet3 = ethers.Wallet.fromPhrase(mnemonic.phrase)
// console.log('wallet3', wallet3, wallet3.mnemonic);

const getWalletAddresses = async () => {
    const address1 = await wallet1WithProvider.getAddress()
    const address2 = await wallet2.getAddress()
    const address3 = await wallet3.getAddress()

    console.log(`1. 获取钱包地址`);
    console.log(`钱包1地址: ${address1}`);
    console.log(`钱包2地址: ${address2}`);
    console.log(`钱包3地址: ${address3}`);
    console.log(`钱包1和钱包3的地址是否相同: ${address1 === address3}`);
    console.log(`钱包1助记词: ${wallet1.mnemonic.phrase}`)
    console.log(`钱包2私钥: ${wallet2.privateKey}`)
    const txCount1 = await provider.getTransactionCount(address1)
    const txCount2 = await provider.getTransactionCount(address2)
    console.log(`钱包1发送交易次数: ${txCount1}`)
    console.log(`钱包2发送交易次数: ${txCount2}`)

    const tx = {
        to: address3,
        value: ethers.parseEther('0.0001')
    }
    const receipt = await wallet2.sendTransaction(tx)
    await receipt.wait()
    console.log('receipt', receipt);
}

getWalletAddresses()

ethers.Wallet.createRandom()
ethers.Wallet(privateKey, provider)
ethers.Wallet.fromPhrase(mnemonic.phrase)
ethers.ContractFactory()
ethers.Mnemonic.entropyToPhrase()
