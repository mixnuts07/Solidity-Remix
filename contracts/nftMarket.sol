// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;
import "./ownable.sol";


interface IBank{
    function transferFrom(address _from, address _to, uint _amount)external;
     function getBalance() external view returns(uint);
     function withdraw(uint _amount) external;
}

contract NFTMarket is Ownable {
    struct Kitty {
        uint id;
        string name;
        address owner;
    }
    Kitty[] public kitties;

    mapping(address => uint256[]) ownedKittyies;
    uint private price = 10000000000000000000; // 1ETH
    address private bankAddress = 0xd9145CCE52D386f254917e481eB44e9943F39138;

    // interfaceの呼び出しはコントラクトアドレスから参照している？
    // だからIBank(Contract Address??)
    // address(this) .. このコントラクトのアドレス
    IBank bank = IBank(bankAddress);
    
    function createKitty(string memory _name) external onlyOwner {
        // address(0) .. 0x00000..0000 誰のkittyでもないということ。→ 購入可能なkittyということ？？
        Kitty memory newKitty = Kitty(kitties.length , _name, address(0));
        kitties.push(newKitty);
    }

    function getOwner() view external returns(address){
        // ownableのowner => msg.sender
        return owner;
    }

    // frontから参照
    function viewKitty() view external returns(Kitty[] memory){
        return kitties;
    }

    // 外部のコントラクトとやり取りに必要なもの２つ
    // やり取りするコントラクトアドレス
    // Interface（関数の概要）

    // buyKitty .. msg.senderのETH から マーケットのコントラクトに行く
    function buyKitty(uint256 _id) external{
        // address(0)のkittyのみ買えるようにする
        require(kitties[_id].owner == address(0), "Kitty not for sale");
        ownedKittyies[msg.sender].push(_id);
        // 購入できたから所有権が移動した？？
        kitties[_id].owner = msg.sender;
        // interface 呼び出し
        bank.transferFrom(msg.sender, address(this),price);  
    }

    function withdrawFromBank() external onlyOwner{
        uint balance = bank.getBalance();
        bank.withdraw(balance);
    }

    // WithdrawしたEthをownerに渡す関数
    function transferToOwner() external onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    // コントラクト内にあるEthの確認
    function getBalance() view external onlyOwner returns(uint){
        return address(this).balance;
    }

    // BankコントラクトからEthを受け取る関数
    // receive .. 外部のコントラクトからEthを受け取る時に必要！
    receive() external payable{

    }
}