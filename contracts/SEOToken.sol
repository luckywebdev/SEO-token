// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;


interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor () { }

  function _msgSender() internal view returns (address) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a, "SafeMath: subtraction overflow");
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0, "SafeMath: division by zero");
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0, "SafeMath: modulo by zero");
    return a % b;
  }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor () {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  /**
   * @dev Returns the address of the current owner.
   */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   * Can only be called by the current owner.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;


  /**
   * @dev modifier to allow actions only when the contract IS paused
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev modifier to allow actions only when the contract IS NOT paused
   */
  modifier whenPaused {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() external onlyOwner whenNotPaused returns (bool) {
    paused = true;
    emit Pause();
    return true;
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() external onlyOwner whenPaused returns (bool) {
    paused = false;
    emit Unpause();
    return true;
  }
}


contract SEOToken is Context, IBEP20, Ownable, Pausable {
  using SafeMath for uint256;

  address[] private _holders;
  address private _liquidity;
  address private _rewardPool;

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowances;
  mapping (address => uint256) private _holderId;


  uint256 private _totalSupply;
  uint8 private _decimals;
  string private _symbol;
  string private _name;
  uint private _rate;

  event Buytoken(address indexed seller, address indexed buyer, uint256 bnbAmount, uint256 tokenAmount);
  event TransferWithReward(address indexed _rewardPool, address[] indexed _recipient, uint256 rewardAmount, uint256[] _rewardRate);

  constructor(string memory token_name, string memory token_symbol, uint8 token_decimals, uint total_supply) {
    _name = token_name;
    _symbol = token_symbol;
    _decimals = token_decimals;
    _totalSupply = total_supply * (10**18);
    _balances[msg.sender] = _totalSupply;
    _setArrayValue(msg.sender);

    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external override view returns (address) {
    return owner();
  }

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external override view returns (uint8) {
    return _decimals;
  }

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external override view returns (string memory) {
    return _symbol;
  }

  /**
  * @dev Returns the token name.
  */
  function name() external override view returns (string memory) {
    return _name;
  }

  /**
   * @dev See {BEP20-totalSupply}.
   */
  function totalSupply() external override view returns (uint256) {
    return _totalSupply;
  }

  /**
   * @dev See {BEP20-balanceOf}.
   */
  function balanceOf(address account) external override view returns (uint256) {
    return _balances[account];
  }

  /**
   * @dev Get Token vs BNB rate.
   */
  function rate() external view returns (uint) {
    return _rate;
  }

  /**
   * @dev Get holders addresses for only onwer.
   */
  function getHolders(address owner) external view returns (address[] memory) {
    require(owner == _getOwner(), "Only owner can get this address" );
    return _holders;
  }

  /**
   * @dev Get liquidity address for only onwer.
   */
  function getLiquidity(address owner) external view returns (address) {
    require(owner == _getOwner(), "Only owner can get this address" );
    return _liquidity;
  }

  /**
   * @dev Get reward wallet address for only onwer.
   * @param owner reward wallet address
   */
  function getRewardWallet(address owner) external view returns (address) {
    require(owner == _getOwner(), "Only owner can get this address" );
    return _rewardPool;
  }

  /**
   * @dev Get Token vs BNB rate.
   * @param rateBNB Token vs BNB rate
   */
  function setRate(uint rateBNB) external onlyOwner returns (bool) {
    require(rateBNB > 0, "rate should be greater than 0");
    _rate = rateBNB;
    return true;
  }

  /**
   * @dev Add token holder.
   * @param holder holder address to be added
   */
  function setHolders(address holder) external onlyOwner returns (bool) {
    _setArrayValue(holder);
    return true;
  }

  /**
   * @dev Add token liquidity.
   * @param liquidity liquidity address to be added
   */
  function setLiquidity(address liquidity) external onlyOwner returns (bool) {
    require(liquidity != address(0), "liquidity address must not be 0");
    _liquidity = liquidity;
    return true;
  }

  /**
   * @dev Add token holder.
   * @param rewardPool devWallet address to be added
   */
  function setRewardWallet(address rewardPool) external onlyOwner returns (bool) {
    require(rewardPool != address(0), "reward pool address must not be 0");
    _rewardPool = rewardPool;
    return true;
  }

  /**
   * @dev See {BEP20-transfer}.
   *
   * Requirements:
   *
   * - `recipient` cannot be the zero address.
   * - the caller must have a balance of at least `amount`.
   */
  function transfer(address recipient, uint256 amount) external override returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }

  /**
   * @dev See {BEP20-allowance}.
   */
  function allowance(address owner, address spender) external override view returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * @dev See {BEP20-approve}.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function approve(address spender, uint256 amount) external override returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  }

  /**
   * @dev See {BEP20-transferFrom}.
   *
   * Emits an {Approval} event indicating the updated allowance. This is not
   * required by the EIP. See the note at the beginning of {BEP20};
   *
   * Requirements:
   * - `sender` and `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   * - the caller must have allowance for `sender`'s tokens of at least
   * `amount`.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount));
    return true;
  }

  /**
   * @dev Atomically increases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }

  /**
   * @dev Atomically decreases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   * - `spender` must have allowance for the caller of at least
   * `subtractedValue`.
   */
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue));
    return true;
  }

  /**
   * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
   * the total supply.
   *
   * Requirements
   *
   * - `msg.sender` must be the token owner
   */
  function mint(uint256 amount) public onlyOwner whenNotPaused returns (bool) {
    _mint(_msgSender(), amount);
    return true;
  }

  /**
   * @dev Buy token with BNB, and then will be included 5% fee 
   * @param seller token holder, who can buy from
   *
   * - `msg.sender` must be the token owner
   */
  function buyTokens(address payable seller) external payable returns (bool) {
    require(seller != address(0));
    require(_balances[seller] > msg.value.mul(_rate).div(1000));
    require(msg.value > 0);
    uint256 buyTokenAmountWithFee = msg.value.mul(_rate).div(1000);
    uint256 buyTokenAmountFee = buyTokenAmountWithFee.mul(5).div(100);
    uint256 buyTokenAmountWithoutFee = buyTokenAmountWithFee.sub(buyTokenAmountFee);
    _balances[seller] = _balances[seller].sub(buyTokenAmountWithFee);
    uint256 holderFee = buyTokenAmountFee.mul(2).div(5);
    if(_holders.length > 0) {
      for(uint i = 0; i < _holders.length; i++) {
        _balances[_holders[i]] = _balances[_holders[i]].add(holderFee.div(_holders.length));
      }
    }
    else {
      _balances[owner()] =  _balances[owner()].add(holderFee);
    }
    uint256 liquidityFee = buyTokenAmountFee.mul(2).div(5);
    if(_liquidity != address(0)) {
      _balances[_liquidity] = _balances[_liquidity].add(liquidityFee);
    }
    else {
      _balances[owner()] =  _balances[owner()].add(liquidityFee);
    }
    uint256 rewardPoolFee = buyTokenAmountFee.mul(1).div(5);
    if(_rewardPool != address(0)) {
      _balances[_rewardPool] = _balances[_rewardPool].add(rewardPoolFee);
    }
    else {
      _balances[owner()] =  _balances[owner()].add(rewardPoolFee);
    }
    _balances[msg.sender] = _balances[msg.sender].add(buyTokenAmountWithoutFee);
    forwardFunds(seller);
    emit Buytoken(seller, msg.sender, msg.value, buyTokenAmountWithoutFee);
    return true;
  }

  /**
   * @dev Transfer reward amount to plugin owners from rewardWallet 
   * @param _recipient recipient address to receive reward
   * @param _rewardRate rate to receive reward
   * - `msg.sender` must be the token owner
   */
  function transferWithReward(address[] memory _recipient, uint[] memory _rewardRate) external returns (bool) {
    require(_rewardPool == msg.sender);
    require(_recipient.length == _rewardRate.length, "Recipient length must be the same as rewardRate length.");
    uint rewardAmountTotal = 0;
    for(uint i = 0; i < _recipient.length; i++) {
      if(_recipient[i] != address(0)) {
        uint recipientBalance = _balances[_recipient[i]];
        uint rewardAmount = recipientBalance.mul(_rewardRate[i]).div(1000);
        if(_balances[_rewardPool] > rewardAmount) {
          _transfer(_rewardPool, _recipient[i], rewardAmount);
          rewardAmountTotal = rewardAmountTotal.add(rewardAmount);
        }
      }
    }

    emit TransferWithReward(_rewardPool, _recipient, rewardAmountTotal, _rewardRate);
    return true;
  }


  /**
   * @dev Send BNB to the fund collection wallet 
   * @param funder token holder, who can receive BNB 
   *
   * - `msg.sender` must be the token owner
   */
  function forwardFunds(address payable funder) internal {
    require(funder != msg.sender, "Token seller must not be the same as Token buyer");
    require(funder != address(0), "Token seller address must not be zero");
    funder.transfer(msg.value);
  }


  /**
   * @dev Moves tokens `amount` from `sender` to `recipient`.
   *
   * This is internal function is equivalent to {transfer}, and can be used to
   * e.g. implement automatic token fees, slashing mechanisms, etc.
   *
   * Emits a {Transfer} event.
   *
   * Requirements:
   *
   * - `sender` cannot be the zero address.
   * - `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   */
  function _transfer(address sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");

    _balances[sender] = _balances[sender].sub(amount);
    _balances[recipient] = _balances[recipient].add(amount);
    emit Transfer(sender, recipient, amount);
  }

  /** @dev Creates `amount` tokens and assigns them to `account`, increasing
   * the total supply.
   *
   * Emits a {Transfer} event with `from` set to the zero address.
   *
   * Requirements
   *
   * - `to` cannot be the zero address.
   */
  function _mint(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: mint to the zero address");

    _totalSupply = _totalSupply.add(amount);
    _balances[account] = _balances[account].add(amount);
    emit Transfer(address(0), account, amount);
  }

  /**
   * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
   *
   * This is internal function is equivalent to `approve`, and can be used to
   * e.g. set automatic allowances for certain subsystems, etc.
   *
   * Emits an {Approval} event.
   *
   * Requirements:
   *
   * - `owner` cannot be the zero address.
   * - `spender` cannot be the zero address.
   */
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

  /**
   * @dev Set Token holders address array.
   * @param user address to be registered
   */
  function _setArrayValue(address user) private returns (bool) {
    require(user != address(0), "token user address must be not 0");
    uint holderId = _holderId[user];
    uint holderLen = _holders.length;
    if(holderLen > 0) {
      if(_holders[holderId] != user) {
        _holders.push(user);
        _holderId[user] = holderLen;
      }
    }
    else {
      _holders.push(user);
      _holderId[user] = 0;
    }
    return true;
  }

  /**
   * @dev Get owner address.
   */
  function _getOwner() private view returns (address) {
    return owner();
  }
}