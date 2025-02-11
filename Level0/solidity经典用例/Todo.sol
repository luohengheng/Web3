// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Todo {
    struct TodDo {
        string text;
        bool completed;
    }

    TodDo[] todos;

    function cretate(string memory str, bool comp) public {
        todos.push(TodDo({
            text: str,
            completed: comp
        }));
    }

    function getItem(uint _index) public view returns(TodDo memory) {
        return todos[_index];
    }

    function updateText(uint _index, string memory str) public {
        todos[_index].text = str;
    }

    function updateCompleted(uint _index, bool bol) public {
        todos[_index].completed = bol;
    }
}