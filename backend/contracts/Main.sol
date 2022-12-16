// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Main {
    uint256 public totalEvents;

    struct Event {
        address organiser;
        uint256 id; // To keep the track of the events
        string genre;
        uint256 price;
        uint256 maxTickets;
        string location;
        bool isCompleted;
    }

    address[] public organizers;

    mapping(uint256 => Event) public events;
    mapping(address => uint256) public organizersEvent;

    modifier isOrganiser(bool _isOrganizer) {
        require(_isOrganizer, "Not an Organizer!");
        _;
    }

    function createEvent(
        address _organiser,
        uint256 _id,
        string memory _genre,
        uint256 _price,
        uint256 _maxTickets,
        string memory _location,
        bool _isOrganizer
    ) public isOrganiser(_isOrganizer) returns (uint256) {
        // Require condition to take the event adding cost I guess

        uint256 eventId = totalEvents;
        events[eventId] = Event(
            _organiser,
            _id,
            _genre,
            _price,
            _maxTickets,
            _location,
            false
        );

        totalEvents += 1;
        organizersEvent[_organiser] = eventId;
        return eventId;
    }

    function eventWasSuccess(
        bool _isOrganizer,
        address _organiser
    ) public isOrganiser(_isOrganizer) returns (uint256) {
        uint256 eventId = organizersEvent[_organiser];
        Event storage eve = events[eventId];
        eve.isCompleted = true;
        return eventId;
    }
}
