interface ISaleable {

	function initiateSale () external;
	event SaleInitiated(uint256 saleId);

	function closeSale (uint256 saleId) external;
	event SaleClosed(uint256 saleId);

	function openSale (uint256 saleId) external;
	event SaleOpened(uint256 saleId);

	function makeOffer (uint256 saleId, address susbcriber, uint256 amount) external;
	event SaleOfferCreated(uint256 saleId, uint256 participationId);

	function refuseOffer (uint256 saleId, uint256 participationId) external;
	event SaleOfferRefused(uint256 saleId, uint256 participationId);

	function acceptOffer (uint256 saleId, uint256 participationId) external;
	event SaleOfferAccepted(uint256 saleId, uint256 participationId);

}
