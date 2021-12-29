pragma solidity ^0.8.0;

interface AlarmWakeUp {
    function callback(bytes calldata _data) external;
}

contract AlarmService {
    struct TimeEvent {
        address addr;
        bytes data;
    }

    mapping(uint256 => TimeEvent[]) private _events;

    function set(uint256 _time) public returns (bool) {
        TimeEvent memory _timeEvent;
        _timeEvent.addr = msg.sender;
        _timeEvent.data = msg.data;
        _events[_time].push(_timeEvent);
    }

    function call(uint256 _time) public {
        TimeEvent[] memory timeEvents = _events[_time];
        for (uint256 i = 0; i < timeEvents.length; i++) {
            AlarmWakeUp(timeEvents[i].addr).callback(timeEvents[i].data);
        }
    }
}

contract AlarmTrigger is AlarmWakeUp {
    AlarmService private _alarmService;

    constructor() {
        _alarmService = new AlarmService();
    }

    function callback(bytes memory _data) public {
        // Do something
    }

    function setAlarm() public {
        _alarmService.set(block.timestamp + 60);
    }
}
