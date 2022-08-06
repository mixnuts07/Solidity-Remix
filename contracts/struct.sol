// SPDX-License-Identifier:MIT
pragma solidity ~0.8.15;

contract MyContract{
// 構造体 .. さまざまな型を組み合わせてカスタマイズできる。
    struct Kitty{
        string name;
        address owner;
        uint256 id;
    }

    // 構造体は型のように使える。
    // 配列だから、[]が必要。
    // kittiesは配列の名前。
    Kitty[] kitties;
    
    // addressからIdを記録する。 
    mapping(address => uint256[]) ownerToKitty;

    function addKitty(string memory _name, address _owner)public{
        uint id = kitties.length;
        // StructureのKitty
        // 追加していく！
        Kitty memory newKitty = Kitty(_name, _owner, id);
        // kitties配列に構造体のnewKittyを追加していく
        kitties.push(newKitty);
        // mappingに記録する.
        ownerToKitty[_owner].push(id);
    }
    
    function getKitty(address _owner) public view returns(string[] memory) {
        // 何匹所有しているか
        uint numOfKittyies = ownerToKitty[_owner].length;
        // numOfKittyies の長さを持った配列を作成. (変数で配列の長さを決めるときはこの書き方)
        string[] memory names = new string[](numOfKittyies);

        for(uint i=0; i< numOfKittyies; i++){
            // 所有者のidをループ
            uint id = ownerToKitty[_owner][i];
            // push はmemoryでは使えない(memoryは長さは決まっているから)
            names[i] = kitties[id].name;
        }
        return names;
        
    }
}
