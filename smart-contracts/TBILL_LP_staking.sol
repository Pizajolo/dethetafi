// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// OpenZeppelin Contracts v4.3.2 (utils/introspection/IERC165.sol)
// File: @openzeppelin/contracts/utils/introspection/IERC165.sol

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// OpenZeppelin Contracts v4.3.2 (token/ERC721/IERC721.sol)
// File: @openzeppelin/contracts/token/ERC721/IERC721.sol
/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

interface geyserInfo {
    function activateWallet(
        uint8 poolID
    ) external;
    function deactivateWallet() external;
}

// import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract TBillStaking {

    address public admin;

    address public geyserInfoAddress = 0xF09E44E3D62A790a5B3a1B1D24d9dbd49921d551;
    uint private currentSupplyShares;

    address public accessToken;
    uint public accessTokenAmount;
    uint public compoundRewardBasePoints;

    uint256 public minimumCompoundBalance = 10000000000;

    mapping(uint => address) private TokenIdToOwnersAddress;

    mapping(address => uint) private OwnerToPoolShares;

    IERC20 public TBill = IERC20(0x22Cb20636c2d853DE2b140c2EadDbFD6C3643a39);
    IERC20 public LPToken = IERC20(0xb8C1d5ac3cb2a21FFd7Ff17CC43C049376c9Cd6f);
    IERC721 public MultiplierNFT = IERC721(0x172D0bD953566538f050aabFEef5E2E8143e09f4);

    IUniswapV2Router02 public immutable uniswapV2Router = IUniswapV2Router02(0x8366537D56cf2b86CA90e9dbC89450207A29f6E3);
    bool inSwapAndLiquify;


    constructor(address _accessToken, uint _accessTokenAmount, uint _compoundRewardBasePoints) {
        admin = payable(msg.sender);
        accessToken = _accessToken;
        accessTokenAmount = _accessTokenAmount;
        compoundRewardBasePoints = _compoundRewardBasePoints;
    }

    modifier onlyAdmin {
        require(msg.sender == admin, "only the admin can perform this action");
        _;
    }

    modifier lockTheSwap {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }

    // Event called when the contract is activated for staking
    event ActivateWallet(uint256 indexed poolId);
    // Event called when the contract is deactivated for staking
    event DeactivateWallet();
    // Event called when the TBILL is compound into LP-Tokens
    event Compound(uint256 indexed tbill, uint256 indexed rewards);
    // Event called when new LP-Tokens are staked
    event Deposit(uint256 indexed amount, address indexed wallet);
    // Event called when LP-Tokens are withdrawn
    event Withdraw(uint256 indexed amount, address indexed wallet);
    // Event called when new Multiplier NFT deposited
    event DepositMultiplier(uint256 indexed tokenId, address indexed wallet);
    // Event called when Multiplier NFT are withdrawn
    event WithdrawMultiplier(uint256 indexed tokenId, address indexed wallet);
    // Event called when minimum compound balance set
    event MinimumCompoundBalanceSet(uint256 indexed balance);


    function activateWallet(uint8 _poolID) onlyAdmin public {
        geyserInfo(geyserInfoAddress).activateWallet(_poolID);
        emit ActivateWallet(_poolID);
    }

    function deactivateWallet() onlyAdmin public {
        geyserInfo(geyserInfoAddress).deactivateWallet();
        emit DeactivateWallet();
    }

    function compound() public {
        uint256 tbill = TBill.balanceOf(address(this));
        require(minimumCompoundBalance <= tbill, "TBILL balance is not big enough");
        swapAndLiquify();
        emit Compound(tbill, 0);
    }

    function compoundRewarded() public {
        uint256 tbill = TBill.balanceOf(address(this));
        require(minimumCompoundBalance <= tbill, "TBILL balance is not big enough");
        TBill.transfer(msg.sender, TBill.balanceOf(address(this))*compoundRewardBasePoints/10000);
        swapAndLiquify();
        emit Compound(tbill, 0);
    }

    function stake(uint _amount) external{
        require(IERC721(accessToken).balanceOf(msg.sender) >= accessTokenAmount, "Not enough access tokens");
        if(TBill.balanceOf(address(this)) > minimumCompoundBalance) {
            compound();
        }
        if(currentSupplyShares == 0) {
            currentSupplyShares = _amount*100;
            LPToken.transferFrom(msg.sender, address(this), _amount);
            OwnerToPoolShares[msg.sender] = _amount*100;
            emit Deposit(_amount, msg.sender);
            return;
        }
        uint newShares = (_amount*currentSupplyShares)/LPToken.balanceOf(address(this));
        LPToken.transferFrom(msg.sender, address(this), _amount);
        currentSupplyShares += newShares;
        OwnerToPoolShares[msg.sender] += newShares;
        emit Deposit(_amount, msg.sender);
    }

    function withdraw(uint _amount) external {
        require(IERC721(accessToken).balanceOf(msg.sender) >= accessTokenAmount, "Not enough access tokens");
        require(balanceOfLP(msg.sender) >= _amount, "You don't own that amount");
        uint withdrawShares= (_amount*currentSupplyShares)/LPToken.balanceOf(address(this));
        currentSupplyShares -= withdrawShares;
        OwnerToPoolShares[msg.sender] -= withdrawShares;
        LPToken.transfer(msg.sender, _amount);
        emit Withdraw(_amount, msg.sender);
    }

    function balanceOfLP(address _wallet) public view returns(uint) {
        if(OwnerToPoolShares[_wallet] == 0) return 0;
        return (OwnerToPoolShares[_wallet] * LPToken.balanceOf(address(this)))/currentSupplyShares;
    }

    function balanceOfShares(address _wallet) external view returns(uint) {
        return OwnerToPoolShares[_wallet];
    }

    function depositMultiplier(uint _tokenId) public {
        MultiplierNFT.transferFrom(msg.sender, address(this), _tokenId);
        TokenIdToOwnersAddress[_tokenId] = msg.sender;
        emit DepositMultiplier(_tokenId, msg.sender);
    }

    function withdrawMultiplier(uint _tokenId) public {
        require(TokenIdToOwnersAddress[_tokenId] == msg.sender, "Not eligible to withdraw token");
        MultiplierNFT.transferFrom(address(this), msg.sender, _tokenId);
        emit WithdrawMultiplier(_tokenId, msg.sender);
    }

    function withdrawMultiplierAdmin(uint _tokenId) public onlyAdmin {
        MultiplierNFT.transferFrom(address(this), msg.sender, _tokenId);
        emit WithdrawMultiplier(_tokenId, msg.sender);
    }

    function swapAndLiquify() private lockTheSwap {
        uint256 balanceTBILL = TBill.balanceOf(address(this));
        // split the contract balance into halves
        uint256 half = balanceTBILL / 2;
        uint256 otherHalf = balanceTBILL - half;

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        swapTokensForTFuel(half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance - initialBalance;

        // add liquidity to uniswap
        addLiquidity(otherHalf, newBalance);

        //        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForTFuel(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(TBill);
        path[1] = uniswapV2Router.WETH();

        TBill.approve(address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 tfuelAmount) private {
        // approve token transfer to cover all possible scenarios
        TBill.approve(address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: tfuelAmount}(
            address(TBill),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp
        );
    }

    function setMinimumCompoundBalance(uint256 _balance) onlyAdmin public {
        minimumCompoundBalance = _balance;
        emit MinimumCompoundBalanceSet(_balance);
    }

    function getTBillBalance() public view returns(uint) {
        return TBill.balanceOf(address(this));
    }

    function getTotalLPBalance() public view returns(uint) {
        return LPToken.balanceOf(address(this));
    }

    function getCompoundReward() public view returns(uint){
        return TBill.balanceOf(address(this))*compoundRewardBasePoints/10000;
    }

    receive() external payable{}
}
