pragma solidity 0.8.0;
pragma experimental ABIEncoderV2;

import "../libraries/BasicTokenLibrary";
import "../libraries/EquityTokenLibrary";
import "../libraries/OperatorManagerLibrary.sol";
import "../libraries/SettlementRepositoryLibrary.sol";

import "../interfaces/IBasicToken.sol";
import "../interfaces/ISaleable.sol";
import "../interfaces/IInstrument.sol";
import "../interfaces/IOperatorManager.sol";
import "../interfaces/ISettlement.sol";

/**
 * An EquityToken is any token that contributes
 * to the share capital of an issuer.
 */
contract EquityToken is IBasicToken, IOperatorManager, ISaleable, IInstrument {

	using SecurityTokenBalancesLibrary for SecurityTokenBalancesLibrary.SecurityTokenBalances;

	// --
	// State
	// --

	BasicTokenLibrary.BasicToken private token;
	EquityTokenLibrary.Equity private equity;
    OperatorManagerLibrary.OperatorManager private operatorManager;
    SettlementRepositoryLibrary.SettlementTransactionRepository
        private settlementTransactionRepository;
	Sales.SaleRepository salesRepository;

	constructor (EquityTokenLibrary.EquityTokenInput memory equityTokenInput)
		public
	{
        token.owner = equityTokenInput.owner;
        token.initialSupply = equityTokenInput.initialSupply;
        token.currentSupply = equityTokenInput.initialSupply;
        token.isinCode = equityTokenInput.isinCode;
        token.name = equityTokenInput.name;
        token.symbol = equityTokenInput.symbol;
        token.settler = equityTokenInput.settler;
        token.registrar = equityTokenInput.registrar;

        token.securityTokenBalances.setIssuer(token.owner);
        token.securityTokenBalances.mint(token.owner, token.initialSupply);

		equity.voteWeight = equityTokenInput.voteWeight;
		equity.votePermanency = equity.votePermanency;
		equity.dividendsWeight = equity.dividendsWeight;
		equity.dividendsPermanency = equity.dividendsPermanency;
		equity.vetoRight = equity.vetoRight;
		equity.vetoPermanency = equity.vetoPermanency;
		equity.isTransferrable = equity.isTransferrable;
		equity.transferPermanency = equity.transferPermanency;
		equity.preferentialLiquidationRights = equity.preferentialLiquidationRights;
		equity.preferentialLiquidationRightsPermanency = equity.preferentialLiquidationRightsPermanency;
		equity.richInformationsRights = equity.richInformationsRights;
		equity.richInformationsRightsPermanency = equity.richInformationsRightsPermanency;
	}

    modifier issuerOnly() {
        require(
            msg.sender == token.owner,
            "Only issuer can perform this action"
        );
        _;
    }

    modifier registrarOnly() {
        require(
            operatorManager.isOperatorWithRoleAuthorized(
                msg.sender,
                REGISTRAR_ROLE
            ),
            "Only a registrar can perform this action"
        );
        _;
    }

    modifier settlerOnly() {
        require(
            operatorManager.isOperatorWithRoleAuthorized(
                msg.sender,
                SETTLER_ROLE
            ),
            "Only a settler can perform this action"
        );
        _;
    }

	// --
	// Basic token
	// --

    function owner() public view returns (address) {
        return token.owner;
    }

    function settler() public view returns (address) {
        return token.settler;
    }

    function registrar() public view returns (address) {
        return token.registrar;
    }

    function initialSupply() public view returns (uint256) {
        return token.initialSupply;
    }

    function currentSupply() public view returns (uint256) {
        return token.currentSupply;
    }

    function name() public view returns (string memory) {
        return token.name;
    }

    function symbol() public view returns (string memory) {
        return token.symbol;
    }

    function isinCode() public view returns (string memory) {
        return token.isinCode;
    }

	// --
	// Equity token
	// --

	function voteWeight() public view returns (uint256) {
		return equity.voteWeight;
	}

	function votePermanency() public view returns (uint256) {
		return equity.votePermanency;
	}

	function dividendsWeight() public view returns (uint256) {
		return equity.dividendsWeight;
	}

	function dividendsPermanency() public view returns (uint256) {
		return equity.dividendsPermanency;
	}

	function vetoRight() public view returns (uint256) {
		return equity.vetoRight;
	}

	function vetoPermanency() public view returns (uint256) {
		return equity.vetoPermanency;
	}

	function isTransferrable() public view returns (uint256) {
		return equity.isTransferrable;
	}

	function transferPermanency() public view returns (uint256) {
		return equity.transferPermanency;
	}

	function preferentialLiquidationRights() public view returns (uint256) {
		return equity.preferentialLiquidationRights;
	}

	function preferentialLiquidationRightsPermanency() public view returns (uint256) {
		return equity.preferentialLiquidationRightsPermanency;
	}

	function richInformationsRights() public view returns (uint256) {
		return equity.richInformationsRights;
	}

	function richInformationsRightsPermanency() public view returns (uint256) {
		return equity.richInformationsRightsPermanency;
	}

	// --
	// Equity token setters
	// --

	function setVoteWeight ()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function votePermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function dividendsWeight()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function dividendsPermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function vetoRight()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function vetoPermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function isTransferrable()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function transferPermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function preferentialLiquidationRights()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function preferentialLiquidationRightsPermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function richInformationsRights()
		public
		registrarOnly
	{
		// TODO: Implement
	}

	function richInformationsRightsPermanency()
		public
		registrarOnly
	{
		// TODO: Implement
	}


	// --
	// IInstrument
	// --

    function getType() public view override returns (string memory) {
        return "Equity";
    }

	// --
    // IBasicToken
	// --

    function getFullBalances()
        public
        view
        returns (SecurityTokenBalancesLibrary.Balance[] memory value)
    {
        return token.securityTokenBalances.getFullBalances();
    }

    function getBalance(address _address) public view returns (uint256 value) {
        return token.securityTokenBalances.getBalance(_address);
    }

	// --
	// ERC-20
	// --

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return token.securityTokenBalances.getBalance(_owner);
    }

    function transfer(address _to, uint256 _value)
        public
        pure
        returns (bool success)
    {
        return false;
    }

    function decimals() public pure returns (uint8) {
        return 0;
    }

    function totalSupply() public view returns (uint256) {
        return token.securityTokenBalances.totalSupply();
    }

    function burn(uint256 quantity) public registrarOnly {
        token.securityTokenBalances.burn(token.owner, quantity);
    }

	// --
	// ISaleable
	// --

	function initiateSale () external {}
	event SaleInitiated(uint256 saleId);

	function closeSale (uint256 saleId)
		public
		external
		registrarOnly
	{
		// TODO: IMPLEMENT
	}

	event SaleClosed(uint256 saleId);

	function openSale (uint256 saleId)
		public
		external
		registrarOnly
	{
		// TODO: IMPLEMENT
	}

	event SaleOpened(uint256 saleId);

	function makeOffer (uint256 saleId, address susbcriber, uint256 amount)
		public
		external
		registrarOnly
	{
		// TODO: IMPLEMENT
	}

	event SaleOfferCreated(uint256 saleId, uint256 participationId);

	function refuseOffer (uint256 saleId, uint256 participationId)
		public
		external
		registrarOnly
	{
		// TODO: IMPLEMENT
	}

	event SaleOfferRefused(uint256 saleId, uint256 participationId);

	function acceptOffer (uint256 saleId, uint256 participationId)
		public
		external
		registrarOnly
	{
		// TODO: IMPLEMENT
	}

	event SaleOfferAccepted(uint256 saleId, uint256 participationId);

}

library Sales {

	struct SaleParticipantsRepository {
		mapping(uint256 => Sales.SaleParticipation) participations;
		KeyFlag[] keys;
		uint256 size;
	}

	struct KeyFlag {
		uint256 index;
		bool deleted;
	}

	struct SaleRepository {
		mapping(uint256 => Sales.Sale) salesByIndex;
		mapping(uint256 => Sales.Sale) salesByOperationId;
		KeyFlag[] keys;
		uint256 size;
		uint256 lastIndex;
	}

	struct SaleParticipation {
		address participant;
		uint256 status;
		uint256 amountToBuy;
		uint256 txId;
	}

	struct Sale {
		uint256 keyIndex;
		address owner; // Not sure
		uint256 status;
		uint256 operationId;
		uint256 amountToSell;
		uint256 amountSold;
		uint256 pricePerUnit;
		string currency;

		BasicTokenLibary.BasicToken token; // The token to sell

		Sales.SaleParticipationsRepository participations;
	}

	function insert(
		SaleRepository storage self,
		Sale memory sale
	)
		public
	{
		// Automatically get the last index
		uint256 newIndex = self.lastIndex + 1;

		require(
			containsOperation(self, sale.operationId) == false,
			"A sale with this operation id already exists"
		);

		uint256 keyIndex = self.keys.length;

		// All k, insert
		self.salesByOperationId[sale.operationId] = sale;
		self.salesByIndex[newIndex] = sale;
		self.size++;
		self.keys.push();
		self.keys.keyIndex = newIndex;
		self.lastIndex = newIndex;
	}

	function remove (
		SaleRepository storage self,
		uint256 index
	)
		public
	{
		uint256 keyIndex = self.salesByIndex[index].keyIndex;

		require(
			keyIndex != 0,
			"Cannot remove sale: sale not found"
		);

		uint256 operationId = self.salesByIndex[index].operationId;

		delete self.salesByIndex[keyIndex];
		delete self.salesByOperationId[operationId];
		self.keys[keyIndex - 1].deleted = true;
		self.size--;
	}

	function contains (
		SaleRepository storage self,
		uint256 index
	)
		public
		view
		returns (bool)
	{
		return self.salesByIndex[index].keyIndex > 0;
	}

	function containsOperation (
		SalesRepository storage self,
		uint256 operationId
	)
		public
		view
		returns (bool)
	{
		return self.salesByOperationId[operationId].keyIndex > 0;
	}

	function getSaleByIndex (
		SaleRepository storage self,
		uint256 index
	)
		view
		returns (Sale memory)
	{
		Sale storage sale = self.salesByIndex[index]

		return sale
	}

	function getSaleByOperationId (
		SaleRepository storage self,
		uint256 operationId
	)
		view
		returns (Sale memory)
	{
		Sale storage sale = self.salesByOperationId[operationId]

		return sale
	}

}

library DirectSaleLibrary {

	changeStatus (
		Sale storage self,
		uint256 newStatus
	) {
		require(
			self.status < newStatus,
			"Cannot rollback a status"
		);
	}

	invite (
		Sale storage self,
	) {
		// TODO: IMPLEMENT
	}

	setPricePerUnit (
		Sale storage self,
		uint256 pricePerUnit
	) {
		require(
			self.status === STATUS_CREATED,
			"Cannot change price of a running sale"
		);

		self.pricePerUnit = pricePerUnit;
	}

	setAmountToSell (
		Sale storage self,
		uint256 newAmountToSell
	) {
		require(
			newAmountToSell <= self.amountSold,
			"Cannot change amount to sell to a lower amount than already sold"
		);

		self.amountToSell = newAmountToSell;
	}

	setAmountSold (
		Sale storage self,
		uint256 newAmountSold
	) {
		require(
			newAmountSold <= self.amountToSell,
			"Cannot change amount sold to a bigger amount than the amount to sell"
		);

		require(
			newAmountSold >= self.amountSold,
			"Cannot lower the amount sold"
		);

		self.amountSold = newAmountSold;
	}

}
