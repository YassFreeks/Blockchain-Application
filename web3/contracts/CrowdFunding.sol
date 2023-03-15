// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");
        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
        
    }

    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        if(sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory)  {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }
    
    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for(uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }


}


// This is a smart contract written in Solidity programming language for a crowdfunding platform. The contract allows users to create campaigns, donate to campaigns, and view campaign information.

// The Campaign struct defines the properties of a campaign, including the owner's address, title, description, target amount, deadline, amount collected, image, donators array, and donations array.

// The mapping variable campaigns is used to store all the campaigns created by users.

// The createCampaign function allows users to create a new campaign by passing in the required parameters. The function first checks if the deadline is in the future and then creates a new Campaign struct with the provided details and stores it in the campaigns mapping. It returns the ID of the newly created campaign.

// The donateToCampaign function allows users to donate to a specific campaign by passing in the campaign ID and sending Ether with the transaction. The function first retrieves the campaign using the ID and then adds the donor's address and donation amount to the campaign's donators and donations arrays. It then sends the donation amount to the campaign owner's address and updates the amountCollected property of the campaign.

// The getDonators function allows users to view the list of donors and their donations for a specific campaign by passing in the campaign ID. It returns two arrays, one containing the donor addresses and the other containing their respective donations.

// The getCampaigns function allows users to view all the campaigns created on the platform. It retrieves all the campaigns from the campaigns mapping and returns an array of Campaign structs.