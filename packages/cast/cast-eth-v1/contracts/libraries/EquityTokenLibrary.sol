pragma solidity 0.8.0;

library EquityTokenLibrary {

	struct EquityTokenInput {
		// Basic token fields
        uint256 initialSupply;
        string isinCode;
        string name;
        string symbol;
        address registrar;
        address settler;
        address owner;

		uint256 voteWeight; // 0 = no, X = yes
		uint256 votePermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 dividendsWeight; // 0 = no; X = yes
		uint256 dividendsPermanency; // ...

		uint256 vetoRight; // 0 = no, 1 = YES
		uint256 vetoPermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 isTransferrable; // 0 = no, 1 = YES
		uint256 transferPermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 preferentialLiquidationRights; // 0 = no, 1 = YES
		uint256 preferentialLiquidationRightsPermanency; // 

		uint256 richInformationsRights;
		uint256 richInformationsRightsPermanency;
	}

	struct Equity {
        uint256 initialSupply;
        string isinCode;
        string name;
        string symbol;
        address registrar;
        address settler;
        address owner;

		uint256 voteWeight; // 0 = no, X = yes
		uint256 votePermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 dividendsWeight; // 0 = no; X = yes
		uint256 dividendsPermanency; // ...

		uint256 vetoRight; // 0 = no, 1 = YES
		uint256 vetoPermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 isTransferrable; // 0 = no, 1 = YES
		uint256 transferPermanency; // 1 = PERMANENT, 0 = NOT PERMANENT

		uint256 preferentialLiquidationRights; // 0 = no, 1 = YES
		uint256 preferentialLiquidationRightsPermanency; // 

		uint256 richInformationsRights;
		uint256 richInformationsRightsPermanency;
	}

	event Dummy(); // Needed otherwise typechain has no output

}
