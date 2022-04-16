const API_URL = "https://tbillstats.io/api/getNFTforWallet/";
const ABI_TNT721 = [
    "function balanceOf(address _owner) view returns (uint256)",
    "function ownerOf(uint256 _tokenId) view returns (address)",
    "function tokenURI(uint256 _tokenId) view returns (string memory)",
    "function tokenOfOwnerByIndex(address _owner, uint256 _index) view returns (uint256)",
    "function approve(address to, uint256 tokenID)",
    "function isApprovedForAll(address owner, address operator) view returns (bool)",
    "function setApprovalForAll(address operator, bool approved)",
    "function getApproved(uint256 tokenId) view returns (address)",
    "event Approval(address indexed owner, address indexed to, uint256 tokenId)",
    "function name() view returns (string)",
];

const ABI_TNT20 = [
    "function balanceOf(address _owner) view returns (uint256)",
    "function approve(address _spender, uint256 _value) returns (bool)",
    "function allowance(address _owner, address _spender) view returns (uint256)",
    'function totalSupply() view returns (uint256)',
]

const ABI_LP_POOL = [
        'constructor(address _accessToken, uint256 _accessTokenAmount, uint256 _compoundRewardBasePoints)',
        'function LPToken() view returns (address)',
        'function MultiplierNFT() view returns (address)',
        'function TBill() view returns (address)',
        'function accessToken() view returns (address)',
        'function accessTokenAmount() view returns (uint256)',
        'function activateWallet(uint8 _poolID)',
        'function admin() view returns (address)',
        'function balanceOfLP(address _wallet) view returns (uint256)',
        'function balanceOfShares(address _wallet) view returns (uint256)',
        'function compound()',
        'function compoundRewardBasePoints() view returns (uint256)',
        'function compoundRewarded()',
        'function deactivateWallet()',
        'function depositMultiplier(uint256 _tokenId)',
        'function getCompoundReward() view returns (uint256)',
        'function getTBillBalance() view returns (uint256)',
        'function getTotalLPBalance() view returns (uint256)',
        'function geyserInfoAddress() view returns (address)',
        'function minimumCompoundBalance() view returns (uint256)',
        'function setMinimumCompoundBalance(uint256 _balance)',
        'function stake(uint256 _amount)',
        'function uniswapV2Router() view returns (address)',
        'function withdraw(uint256 _amount)',
        'function withdrawMultiplier(uint256 _tokenId)',
        'function withdrawMultiplierAdmin(uint256 _tokenId)'
    ]
;

const NETWORK_OPTIONS = {
    chainId: "0x169",
    chainName: "Theta Mainnet",
    nativeCurrency: { name: "Theta Fuel", symbol: "TFUEL", decimals: 18 },
    rpcUrls: ["https://eth-rpc-api.thetatoken.org/rpc"],
    blockExplorerUrls: ["https://explorer.thetatoken.org/"],
};

// const NETWORK_OPTIONS = {
//     chainId: "0x16D",
//     chainName: "Theta Testnet",
//     nativeCurrency: { name: "Theta Fuel", symbol: "TFUEL", decimals: 18 },
//     rpcUrls: ["https://eth-rpc-api-testnet.thetatoken.org/rpc"],
//     blockExplorerUrls: ["https://testnet-explorer.thetatoken.org/"],
// };

const MULTIPLIER_ADDRESS = "0x172D0bD953566538f050aabFEef5E2E8143e09f4";
const WTFUEL_ADDRESS = "0x4dc08b15ea0e10b96c41aec22fab934ba15c983e";

export default API_URL;
export {ABI_TNT721, ABI_TNT20, NETWORK_OPTIONS, ABI_LP_POOL, MULTIPLIER_ADDRESS, WTFUEL_ADDRESS};
