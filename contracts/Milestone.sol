pragma solidity ^0.4.18;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

/*
 * @title Supervised Wallet - investor can supervise and authorize how company use their money
 * @author Chun-Wei Chiang - <warrior.sp@gmail.com>
 */
 
 contract Milestone is usingOraclize{
    uint public EURGBP;
    event LogPriceUpdated(uint price);
    event LogNewOraclizeQuery(string description);
    
     
     function Milestone() payable{
         OAR = OraclizeAddrResolverI(0x1FD16B840121849F19d1668798dF67AD345b3B96);
         updatePrice();
     }
     
    function __callback(bytes32 myid, string result) {
        // if (msg.sender != oraclize_cbAddress()) throw; //Only for test
        EURGBP = parseInt(result);
        LogPriceUpdated(EURGBP);
    }
    
    function updatePrice() public payable {
        if (oraclize_getPrice("URL") > this.balance) {
            LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", "json(http://b2b41abc.ngrok.io/api/rr).target");
        }
    }

 }