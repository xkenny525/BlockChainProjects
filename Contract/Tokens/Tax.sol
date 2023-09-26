// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
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
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);    
}

interface IERC20Metadata {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

library Address {    
    error AddressInsufficientBalance(address account);  
    error FailedInnerCall();   

    function sendValue(address payable recipient, uint256 amount) internal returns(bool) {
        if (address(this).balance < amount) {
            revert AddressInsufficientBalance(address(this));
        }

        (bool success, ) = recipient.call{value: amount}("");
        if (!success) {
            revert FailedInnerCall();
        }

        return success;
    }    
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
     address private _owner;

    error OwnableUnauthorizedAccount(address account);
    error OwnableInvalidOwner(address owner);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }
   
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }
    
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }
   
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address from = _msgSender();
        _transfer(from, to, amount);        
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender(); 
        _approve(owner, spender, amount);
        return true;
    }

   function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

contract Panda is ERC20, Ownable {    
    using Address for address payable;

    enum Lock { UNLOCKED, LOCKED }

    IUniswapV2Router02  public  router;    
    address             public  pair;

    mapping (address => bool) private _isExcludedFromTax;
    mapping (address => bool) private _isExcludedFromTxMaxLimit;

    bool    public  tradingEnabled;
    bool    public  txMaxLimitEnabled;

    uint256 public  buyTax;
    uint256 public  sellTax;

    address public  marketingWallet;    
    
    uint256 public  txMaxLimitBuy;
    uint256 public  txMaxLimitSell;       

    Lock private lock = Lock.UNLOCKED;
    modifier mutex() {
        require(lock == Lock.UNLOCKED, 'LOCKED');
        lock = Lock.LOCKED;
        _;
        lock = Lock.UNLOCKED;
    }
   
    constructor () ERC20("Animal", "Panda") {   
        address routerAddress;
        if (block.chainid == 56) {
            routerAddress = 0x10ED43C718714eb63d5aA57B78B54704E256024E; // BSC Mainnet PancakeRouter
        } else if (block.chainid == 97) {
            routerAddress = 0xD99D1c33F9fC3444f8101754aBC46c52416550D1; // BSC Testnet PancakeRouter
        } else if (block.chainid == 1 || block.chainid == 5) {
            routerAddress = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; // ETH Mainnet and Testnet Goerli UniswapV2Router02
        } else {
            revert();
        }

        IUniswapV2Router02 _router = IUniswapV2Router02(routerAddress);
        address _pair = IUniswapV2Factory(_router.factory())
            .createPair(address(this), _router.WETH());

        router = _router;
        pair = _pair;

        _approve(address(this), address(router), type(uint256).max);

        buyTax  = 0;
        sellTax = 10; 

        marketingWallet = 0x0d4Aa5A944427cB2d2040D84f273978B29264dbB;

        txMaxLimitEnabled = true;
        txMaxLimitBuy     = totalSupply() * 10 / 10000;
        txMaxLimitSell    = totalSupply() * 10 / 10000;

        _isExcludedFromTxMaxLimit[owner()] = true;
        _isExcludedFromTxMaxLimit[address(this)] = true;
        _isExcludedFromTxMaxLimit[address(0xdead)] = true;
        _isExcludedFromTxMaxLimit[marketingWallet] = true;
        _isExcludedFromTxMaxLimit[0x407993575c91ce7643a4d4cCACc9A98c36eE1BBE] = true; //pinklock

        _isExcludedFromTax[owner()] = true;
        _isExcludedFromTax[address(0xdead)] = true;
        _isExcludedFromTax[address(this)] = true;

        _mint(owner(), 1e9 * (10 ** decimals()));        
    }        

    function excludeFromTax(address account, bool excluded) external onlyOwner{
        require(_isExcludedFromTax[account] != excluded,"Account is already the value of 'excluded'");
        _isExcludedFromTax[account] = excluded;
    }

    function setSellTax(uint256 _newSellTax) external onlyOwner {        
        require(_newSellTax <= 10, "Tax cannot exceed the maximum 10");
        sellTax = _newSellTax;
    }

    function setMarketingWallet(address _newWallet) external onlyOwner{
        require(_newWallet != marketingWallet, "Marketing wallet is already that address");
        require(_newWallet != address(0), "Marketing wallet cannot be the zero address");

        // Prevent honeypot
        _isExcludedFromTxMaxLimit[_newWallet] = true;

        marketingWallet = _newWallet;
    }    

    function startTrading() external onlyOwner{
        require(!tradingEnabled, "Trading already enabled.");
        tradingEnabled = true;
    }

    function stopTrading() external onlyOwner{
        require(tradingEnabled, "Trading already disabled.");
        tradingEnabled = false;
    }

    function _transfer(address from,address to,uint256 amount) internal  override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(tradingEnabled || _isExcludedFromTax[from] || _isExcludedFromTax[to], "Trading not yet enabled!");
       
        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        if (txMaxLimitEnabled) 
        {
            if ((from == pair || to == pair) &&
                !_isExcludedFromTxMaxLimit[from] && 
                !_isExcludedFromTxMaxLimit[to]
            ) {
                if (from == pair) {
                    require(
                        amount <= txMaxLimitBuy,  
                        "AntiWhale: Transfer amount exceeds the maxTransactionAmount"
                    );
                } else {
                    require(
                        amount <= txMaxLimitSell, 
                        "AntiWhale: Transfer amount exceeds the maxTransactionAmount"
                    );
                }
            }
        }

        uint256 _totalFees;
        if (_isExcludedFromTax[from] || _isExcludedFromTax[to]) {
            _totalFees = 0;
        } else if (from == pair) {
            _totalFees = 0;
        } else if (to == pair) {
            _totalFees =  sellTax;
        } else {
            _totalFees = 0;
        }

        if (_totalFees > 0) {
            uint256 fees = (amount * _totalFees) / 100;
            amount = amount - fees;
            super._transfer(from, address(marketingWallet), fees);
        }

        super._transfer(from, to, amount);
    }    

    function setTxMaxLimitEnabled(bool enable) external onlyOwner {        
        txMaxLimitEnabled = enable;
    }

    function setTxMaxLimitBuy(uint256 _txMaxLimitBuy) external onlyOwner {
        require(
            _txMaxLimitBuy  >= (totalSupply() / (10 ** decimals())) / 1_000, 
            "Not less than 0.1% of total supply"
        ); 
        txMaxLimitBuy  = _txMaxLimitBuy  * (10 ** decimals());        
    }

    function setTxMaxLimitSell(uint256 _txMaxLimitSell) external onlyOwner {
        require(             
            _txMaxLimitSell >= (totalSupply() / (10 ** decimals())) / 1_000, 
            "Not less than 0.1% of total supply"
        ); 
        txMaxLimitSell = _txMaxLimitSell * (10 ** decimals());
    }

    function excludeFromTxMaxLimit(address account, bool exclude) external onlyOwner {
        require( _isExcludedFromTxMaxLimit[account] != exclude, "The account is already in this state");
        require(account != address(this), "Can't set this address.");
        require(account != address(marketingWallet), "Can't set this address.");

        _isExcludedFromTxMaxLimit[account] = exclude;      
    }    

    function isExcludedFromTxMaxLimit(address account) public view returns(bool) {
        return _isExcludedFromTxMaxLimit[account];
    }    

    function rescueERC20(address tokenAddress, uint256 amount) external onlyOwner{
        require(tokenAddress != address(this), "Can't take self token");
        IERC20(tokenAddress).transfer(owner(), amount);
    }

    function rescuePlatformCoins(uint256 weiAmount) external onlyOwner{
        payable(owner()).sendValue(weiAmount);
    }

    receive() external payable {}
}