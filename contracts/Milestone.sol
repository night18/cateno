pragma solidity ^0.4.18;
import "./oraclizeAPI.sol";

/*
 * @title Supervised Wallet - investor can supervise and authorize how company use their money
 * @author Chun-Wei Chiang - <warrior.sp@gmail.com>
 */
contract Milestone is usingOraclize {

    uint256 public EURGBP;
    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewOraclizeQuery(string description);

    function Milestone() payable {
        LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Oraclize Query.");
        OAR = OraclizeAddrResolverI(0xAFb707Fe5900F0439324523EC630D6553C8A1318);

    }

    function __callback(bytes32 myid, string result) {
        // if (msg.sender != oraclize_cbAddress()) revert();
        EURGBP = parseInt(result);
        LogPriceUpdated(result);
    }

    function updatePrice() payable {
        if (oraclize_getPrice("URL") > this.balance) {
            LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", "json(http://2dff6440.ngrok.io/api/qq).target");
        }
    }
}