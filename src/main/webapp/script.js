//Dummy to-do list as an array of objects
var testData = [
    {
        category: "Kitchen",
        description: "Repair leaky sink",
        startDate: "2016-06-10",
        endDate: "2016-06-11",
        completed: "False"
    },
    {
        category: "Attic",
        description: "Fix leak in roof",
        startDate: "2016-06-07",
        endDate: "2016-06-17",
        completed: "False"
    },
    {
        category: "Garage",
        description: "Paint interior",
        startDate: "2016-06-10",
        endDate: "2016-06-11",
        completed: "False"
    },
    {
        category: "Garden",
        description: "Paint flowers",
        startDate: "2016-06-04",
        endDate: "2016-06-04",
        completed: "True"
    },
    {
        category: "Garage",
        description: "Repair door",
        startDate: "2016-06-10",
        endDate: "2016-06-14",
        completed: "False"
    }
];

//Load the dummy to-do list by loading each object as a row item
for(var i = 0; i < testData.length; i++) {
    loadTableRow();
}

/* Helper function which creates and adds a row item to the table */
function loadTableRow() {
    //Create the row element for each object in array and add a checkbox to it
    var tableRow = document.createElement("tr");
    addCheckBox(tableRow);

    //Create the data elements for a given row
    for(key in testData[i]) {
        var tableData = document.createElement("td");
        tableData.innerHTML = testData[i][key];
        tableData.className = "mdl-data-table__cell--non-numeric";
        tableRow.appendChild(tableData);
    }
    //Append the row to the table
    document.getElementById("tableBody").appendChild(tableRow);
}

/* Helper function which creates and adds a checkbox to a specified tableRow */
function addCheckBox(tableRow) {

    var checkBox = document.createElement("td");

    var cBoxLabel = document.createElement("label");
    //"boxes" class added to differentiate from the master checkbox
    cBoxLabel.className = "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select";

    var cBoxInput = document.createElement("input");
    cBoxInput.className = "mdl-checkbox__input";
    cBoxInput.setAttribute("type", "checkbox");

    cBoxLabel.appendChild(cBoxInput);
    checkBox.appendChild(cBoxLabel);
    tableRow.appendChild(checkBox);

    //Return label element, which can be updated when making a new row item so that it looks like the others
    return cBoxLabel;
}

/* Master checkbox functionality to check/uncheck all row items */
var table = document.querySelector('table');
var headerCheckbox = table.querySelector('thead .mdl-data-table__select input');
//Selects dynamic/live collection of non-master checkboxes
var boxes = document.getElementsByClassName(
    "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
);
var headerCheckHandler = function(event) {
    if (event.target.checked) {
        for (var i = 0, length = boxes.length; i < length; i++) {
            boxes[i].MaterialCheckbox.check();
        }
    } else {
        for (var i = 0, length = boxes.length; i < length; i++) {
            boxes[i].MaterialCheckbox.uncheck();
        }
    }
};
headerCheckbox.addEventListener('change', headerCheckHandler);

/* Dummy add function */
function add() {
    var object = {
        category: "a",
        description: "a",
        startDate: "a",
        endDate: "a",
        completed: "a"
    };

    var newTableRow = document.createElement("tr");
    var newCheckBox = addCheckBox(newTableRow);
    //Update checkBox
    componentHandler.upgradeElement(newCheckBox);

    for(key in object) {
        var rowData = document.createElement("td");
        rowData.innerHTML = object[key];
        rowData.className = "mdl-data-table__cell--non-numeric";
        newTableRow.appendChild(rowData);
    }

    document.getElementById("tableBody").appendChild(newTableRow);
}