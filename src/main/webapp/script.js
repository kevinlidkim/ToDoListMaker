var currentListData = [];
var currentUser = localStorage.getItem("user");
var email = localStorage.getItem("email");
var cBoxCounter = 0;

/* Disable Save Button if list is empty */
var saveBtn = document.getElementById("saveBtn");
saveBtn.disabled = true;
/*Disable table buttons first */
var addBtn = document.getElementById("addBtn");
var removeBtn = document.getElementById("removeBtn");
var upBtn = document.getElementById("upBtn");
var downBtn = document.getElementById("downBtn");
addBtn.disabled = true;
removeBtn.disabled = true;
upBtn.disabled = true;
downBtn.disabled = true;


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
    cBoxInput.onchange = function() {
        //first re-enable buttons if they were disabled from before
        //removeBtn.disabled = false;



        if (cBoxInput.checked) {  cBoxCounter++; }
        else { cBoxCounter--;}
        console.log(cBoxCounter);
        if (cBoxCounter == 1) {
            removeBtn.disabled = false;
            upBtn.disabled = false;
            downBtn.disabled = false;
        }
        else if (cBoxCounter > 1) {
            upBtn.disabled = true;
            downBtn.disabled = true;
        }
        else {
            removeBtn.disabled = true;
            upBtn.disabled = true;
            downBtn.disabled = true;
        }
    }

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
function add(item) {

  var newTableRow = document.createElement("tr");
  var newCheckBox = addCheckBox(newTableRow);
  //Update checkBox
  componentHandler.upgradeElement(newCheckBox);

  for(key in item) {
      var rowData = document.createElement("td");
      rowData.innerHTML = item[key];
      rowData.className = "mdl-data-table__cell--non-numeric";
      newTableRow.appendChild(rowData);
  }
  currentListData.push(item);
  document.getElementById("tableBody").appendChild(newTableRow);
  // Enable save button now that it has at least 1 item
  saveBtn.disabled = false;

}

/* Remove function*/
function remove() {
  //get all checkedboxes
  var c_boxes = document.getElementsByClassName(
      "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select is-checked"
  );
  for (var i = 0, length = c_boxes.length; i < length; i++) {
      //check for null
      if(c_boxes[i] != null) {
        // Deletes the checked box row from html
        c_boxes[i].parentNode.parentNode.parentNode.removeChild(c_boxes[i].parentNode.parentNode);
        // Move counter back so the next box can be removed properly.
        i--;
      }
  }
  //disable buttons again after removal
  removeBtn.disabled = true;
  upBtn.disabled = true;
  downBtn.disabled = true;
  //enable save button
  saveBtn.disabled = false;
  //check counter should? be reset to zero
    cBoxCounter = 0;
}

/* Move up function */
function moveUp() {

  var c_boxes = document.getElementsByClassName(
      "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
  );

  for (var i = 0, length = c_boxes.length; i < length; i++) {

    if(c_boxes[i] != null && c_boxes[i].classList.contains("is-checked")){

      if(i > 0 && !c_boxes[i-1].classList.contains("is-checked")) {
        // curr checked row.
        var curRowData = c_boxes[i].parentNode.parentNode;
        // row swap with
        var topRowData = c_boxes[i-1].parentNode.parentNode;

        var curArray = [];
        var topArray = [];

        // populate array data with row data
        for (var k = 1; k < curRowData.childNodes.length; k++) {
          topArray.push(topRowData.childNodes[k].innerHTML);
          curArray.push(curRowData.childNodes[k].innerHTML);
        }
        // swap data fields.
        for (var j = 1; j < curRowData.childNodes.length; j++) {
          topRowData.childNodes[j].innerHTML = curArray[j-1];
          curRowData.childNodes[j].innerHTML = topArray[j-1];
        }

        // move the checkboxes also
        c_boxes[i-1].MaterialCheckbox.check();
        c_boxes[i].MaterialCheckbox.uncheck();
      }
    }
  }
  //enable save button
  saveBtn.disabled = false;
}

/* Move up function */
function moveDown() {

  var c_boxes = document.getElementsByClassName(
      "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
  );

  for (var i = c_boxes.length-1; i >= 0; i--) {

    // Check if current box is checked.
    if(c_boxes[i] != null && c_boxes[i].classList.contains("is-checked")){

      // Make sure next box is not checked.
      if(i < c_boxes.length && c_boxes[i+1] != null && !c_boxes[i+1].classList.contains("is-checked")) {

        // curr checked row.
        var curRowData = c_boxes[i].parentNode.parentNode;
        // row swap with
        var botRowData = c_boxes[i+1].parentNode.parentNode;

        var curArray = [];
        var botArray = [];

        // populate array data
        for (var k = 1; k < curRowData.childNodes.length; k++) {
          curArray.push(curRowData.childNodes[k].innerHTML);
          botArray.push(botRowData.childNodes[k].innerHTML);
        }
        // swap data fields.
        for (var j = 1; j < curRowData.childNodes.length; j++) {
          curRowData.childNodes[j].innerHTML = botArray[j-1];
          botRowData.childNodes[j].innerHTML = curArray[j-1];
        }

        // move the checkboxes also
        c_boxes[i].MaterialCheckbox.uncheck();
        c_boxes[i+1].MaterialCheckbox.check();

        i++;
      }
    }
  }
  //enable save button
  saveBtn.disabled = false;
}

/* Resets the input boxes to empty */
function reset_Input() {
  document.getElementById("category").value = "";
  document.getElementById("desc").value = "";
  document.getElementById("start_Date").value = "";
  document.getElementById("end_Date").value = "";
  document.getElementById("completed").value = "";
}

document.getElementById("upBtn").onclick = function () {
  moveUp();
  console.log("Current list:");
  console.log(currentListData);
}

document.getElementById("downBtn").onclick = function () {
  moveDown();
}

/* Triggering Add button function */
document.getElementById("addBtn").onclick = function () {

  // Get the new item info
  var new_category = document.getElementById("category").value;
  var new_desc = document.getElementById("desc").value;
  var new_start_Date = document.getElementById("start_Date").value;
  var new_end_Date = document.getElementById("end_Date").value;

  //Capitalize the boolean.
  var new_completed;
  if(document.getElementById("completed").checked) {
    new_completed = "True";
  } else {
    new_completed = "False";
  }

  // make the new item to be added
  var new_Item = {
    category: new_category,
    description: new_desc,
    startDate: new_start_Date,
    endDate: new_end_Date,
    completed: new_completed
  }

  //add new item and reset the inputs, also disable add again until new inputs
  add(new_Item);
  reset_Input();
  addBtn.disabled = true;
}

/* Check to see whether list to be saved is private or public */
function privateOrPublic() {
  if (document.getElementById('private').checked) {
    return false;
  } else if (document.getElementById('public').checked) {
    return true;
  } else {
    // ??? when would it reach here
    return false;
  }
}



/* Add event handler to save button */
saveBtn.onclick = function () {

  console.log(currentUser);
  // var listId = "4644337115725824";
  var listId = "";

  // Get listName from form input.
  var listName = document.getElementById("listName").value

  var isPublic = privateOrPublic();
  var dataObj = {
    list: currentListData,
    name: listName,
    owner: currentUser,
    isPublic: isPublic,
    listId: listId
  };
  $.ajax({
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    type: "POST",
    url: "/createList",
    data: JSON.stringify(dataObj),
    success: function(response) {
       console.log(response);
    },
    error: function(err) {
       console.log(err);
    }
  });

};

/* Triggering remove button function*/
removeBtn.onclick = function () { remove(); }

/* Enabling/Disabling Add Button */
var category = document.getElementById("category");
var desc = document.getElementById("desc");
var startDate = document.getElementById("start_Date");
var endDate = document.getElementById("end_Date");

/* Helper function */
function toggleAddBtn() {
    if (category.value != "" &&desc.value != "" && startDate.value != "" && endDate.value != "") {
        addBtn.disabled = false;
    }
    else {
        addBtn.disabled = true;
    }
}

category.oninput = function() { toggleAddBtn() };
desc.oninput = function() { toggleAddBtn() };
startDate.oninput = function() { toggleAddBtn() };
endDate.oninput = function() { toggleAddBtn() };
