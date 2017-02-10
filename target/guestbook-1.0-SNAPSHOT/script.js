currentListData = [];

/* Helper function which creates and adds a row item to the table */
function loadTableRow(data) {
    //Create the row element for each object in array and add a checkbox to it
    var tableRow = document.createElement("tr");
    addCheckBox(tableRow);

    //Create the data elements for a given row
    for(key in data[i]) {
        var tableData = document.createElement("td");
        tableData.innerHTML = data[i][key];
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

/* Add function */
function add(new_Item) {

    var newTableRow = document.createElement("tr");
    var newCheckBox = addCheckBox(newTableRow);
    //Update checkBox
    componentHandler.upgradeElement(newCheckBox);

    for(key in new_Item) {
        var rowData = document.createElement("td");
        rowData.innerHTML = new_Item[key];
        rowData.className = "mdl-data-table__cell--non-numeric";
        newTableRow.appendChild(rowData);
    }
    currentListData.push(new_Item);
    document.getElementById("tableBody").appendChild(newTableRow);
}

//resets the input boxes to empty
function reset_Input() {
  document.getElementById("catagory").value = "";
  document.getElementById("desc").value = "";
  document.getElementById("start_Date").value = "";
  document.getElementById("end_Date").value = "";
  document.getElementById("completed").value = "";
}

/* Triggering Add button function */
document.getElementById("addBtn").onclick = function () {

  // Get the new item info
  var new_catagory = document.getElementById("catagory").value;
  var new_desc = document.getElementById("desc").value;
  var new_start_Date = document.getElementById("start_Date").value;
  var new_end_Date = document.getElementById("end_Date").value;
  var new_completed;

  //Capitalize the boolean.
  if(document.getElementById("completed").checked) {
    new_completed = "True"; 
  } else {
    new_completed = "False";
  }

  // make the new item to be added
  var new_Item = {
    category: new_catagory,
    description: new_desc,
    startDate: new_start_Date,
    endDate: new_end_Date,
    completed: new_completed
  }

  //add new item and reset the inputs
  add(new_Item);
  reset_Input();
}

/* Add event handler to save button */
document.getElementById("saveBtn").onclick = function () {
  var dataObj = {
    list: currentListData,
    name: "LIST NAME"
  }
  $.ajax({
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json' 
    },
    type: "POST",
    url: "/createList",
    data: JSON.stringify(dataObj),
    success: function(response) {
      // console.log(response);
    },
    error: function(err) {
      // console.log(err);
    }
  });

};