/// OsmMom -- governance interface for the OSM

// Copyright (C) 2019 Maker Ecosystem Growth Holdings, INC.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity ^0.5.12;

import "ds-note/note.sol";
import "osm/osm.sol";

contract OsmMom is DSNote {
    address public owner;
    modifier onlyOwner { require(msg.sender == owner); _;}

    mapping (address => uint) public wards;
    function rely(address usr) public note onlyOwner { wards[usr] = 1; }
    function deny(address usr) public note onlyOwner { wards[usr] = 0; }
    modifier auth { require(owner == msg.sender || wards[msg.sender] == 1); _; }

    OSM public osm_;

    constructor(OSM osmAddress) public {
        owner = msg.sender;
        osm_ = osmAddress;
    }

    function setOwner(address owner_) public note onlyOwner {
        owner = owner_;
    }

    function stop() external auth {
        osm_.stop();
    }

    function start() external auth {
        osm_.start();
    }

    function void() external auth {
        osm_.void();
    }
}
