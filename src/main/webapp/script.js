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

var categoryHeader = $("th.category");
var descriptionHeader = $("th.description");
var startDateHeader = $("th.startDate");
var endDateHeader = $("th.endDate");

var categoryHits = 0;
var descriptionHits = 0;
var startDateHits = 0;
var endDateHits = 0;

/* Helper function which creates and adds a row item to the table */
function loadTableRow(data) {
    //Create the row element for each object in array and add a checkbox to it
    var tableRow = document.createElement("tr");
    addCheckBox(tableRow);

    //Create the data elements for a given row
    for(key in data[i]) {
        var tableData = document.createElement("td");
        tableData.innerHTML = data[i][key];
        tableData.className = "mdl-data-table__cell--non-numeric ";
        tableRow.appendChild(tableData);
    }
    // console.log("loading...");
    // console.log(data[i][key]);
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
        if (cBoxInput.checked) {  cBoxCounter++; }
        else { cBoxCounter--;}
        // console.log(cBoxCounter);
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
          cBoxCounter++;
          removeBtn.disabled = false;
      }
  } else {
      for (var i = 0, length = boxes.length; i < length; i++) {
          boxes[i].MaterialCheckbox.uncheck();
          cBoxCounter--;
          removeBtn.disabled = true;
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
      "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
  );
  for (var i = 0, length = c_boxes.length; i < length; i++) {
      //check for null
      if(c_boxes[i] != null && c_boxes[i].classList.contains("is-checked")) {
        // Deletes the checked box row from html
        c_boxes[i].parentNode.parentNode.parentNode.removeChild(c_boxes[i].parentNode.parentNode);
        // Move counter back so the next box can be removed properly.

        // array.splice(start, deleteCount)
        if(currentListData.length > 1) {
          // console.log("REMOVING: ");
        } else {
          currentListData.pop();
        }

        i--;
      }

  }
  //disable buttons again after removal
  removeBtn.disabled = true;
  upBtn.disabled = true;
  downBtn.disabled = true;
  //enable save button if theres still stuff in the list
  if (currentListData.length == 0) {
    saveBtn.disabled = true;
  }
  else {
    saveBtn.disabled = false;
  }
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

        // swap data position in the array
        var temp = currentListData[i];
        currentListData[i] = currentListData[i-1];
        currentListData[i-1] = temp;
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

        // swap data position in the array
        var temp = currentListData[i-1];
        currentListData[i-1] = currentListData[i];
        currentListData[i] = temp;
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
  removeAllSortingIcons();
  moveUp();
}

document.getElementById("downBtn").onclick = function () {
  removeAllSortingIcons();
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
  removeAllSortingIcons();
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

  // console.log(currentUser);
  // var listId = "4644337115725824";
  var listId = document.getElementById("currentList").getAttribute("listId");

  // Get listName from form input.
  var listName = document.getElementById("listName").value;
  if (listName.length == 0) {
      listName = "Blank";
  }

  var isPublic = privateOrPublic();
  var dataObj = {
    list: currentListData,
    name: listName,
    owner: email,
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
        //console.log(response);
    },
    error: function(err) {
       // console.log(err);
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
function clearTable() { document.getElementById("tableBody").innerHTML = ""; }
function clearcurrenListData() {currentListData = [];}
function removeAllSortingIcons() {
  $("th").removeClass('mdl-data-table__header--sorted-ascending')
  $("th").removeClass('mdl-data-table__header--sorted-descending')
}

function compareCategoryASC(a,b) {
  if (a.category < b.category)
    return -1;
  if (a.category > b.category)
    return 1;
  return  0;
}

function compareCategoryDESC(a,b) {
  if (b.category < a.category)
    return -1;
  if (b.category > a.category)
    return 1;
  return 0;
}

function compareDescriptionASC(a,b) {
  if (a.description < b.description)
    return -1;
  if (a.description > b.description)
    return 1;
  return  0;
}

function compareDescriptionDESC(a,b) {
  if (b.description < a.description)
    return -1;
  if (b.description > a.description)
    return 1;
  return 0;
}

function compareStartDateASC(a,b) {
  if (a.startDate < b.startDate)
    return -1;
  if (a.startDate > b.startDate)
    return 1;
  return  0;
}

function compareStartDateDESC(a,b) {
  if (b.startDate < a.startDate)
    return -1;
  if (b.startDate > a.startDate)
    return 1;
  return 0;
}

function compareEndDateASC(a,b) {
  if (a.endDate < b.endDate)
    return -1;
  if (a.endDate > b.endDate)
    return 1;
  return  0;
}

function compareEndDateDESC(a,b) {
  if (b.endDate < a.endDate)
    return -1;
  if (b.endDate > a.endDate)
    return 1;
  return 0;
}

categoryHeader.click(function() {

  removeAllSortingIcons();

  if(categoryHits % 2 != 0) {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareCategoryASC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    categoryHeader.addClass('mdl-data-table__header--sorted-ascending');

  } else {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareCategoryDESC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    categoryHeader.addClass('mdl-data-table__header--sorted-descending');

  }
  categoryHits++;
  cBoxCounter = 0;
  upBtn.disabled = true;
  downBtn.disabled = true;
  removeBtn.disabled = true;
});
descriptionHeader.click(function() {

  removeAllSortingIcons();

  if(descriptionHits % 2 != 0) {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareDescriptionASC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    descriptionHeader.addClass('mdl-data-table__header--sorted-ascending');


  } else {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareDescriptionDESC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    descriptionHeader.addClass('mdl-data-table__header--sorted-descending');

  }
  descriptionHits++;
  cBoxCounter = 0;
  upBtn.disabled = true;
  downBtn.disabled = true;
  removeBtn.disabled = true;
});
startDateHeader.click(function() {

  removeAllSortingIcons();

  if(startDateHits % 2 != 0) {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareStartDateASC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    startDateHeader.addClass('mdl-data-table__header--sorted-ascending');


  } else {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareStartDateDESC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    startDateHeader.addClass('mdl-data-table__header--sorted-descending');

  }
  startDateHits++;
  cBoxCounter = 0;
  upBtn.disabled = true;
  downBtn.disabled = true;
  removeBtn.disabled = true;
});
endDateHeader.click(function() {

  removeAllSortingIcons();

  if(endDateHits % 2 != 0) {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareEndDateASC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    endDateHeader.addClass('mdl-data-table__header--sorted-ascending');


  } else {

    var tempList = currentListData;
    var listSize = tempList.length;

    //sort
    currentListData.sort(compareEndDateDESC);

    //clear table and arraylist cuz they gonna be repopulated.
    clearTable();
    clearcurrenListData();

    for(var i = 0; i < listSize; i++) {
      //re-add all the items in the correct order
      add(tempList[i]);
    }

    endDateHeader.addClass('mdl-data-table__header--sorted-descending');

  }
  endDateHits++;
  cBoxCounter = 0;
  upBtn.disabled = true;
  downBtn.disabled = true;
  removeBtn.disabled = true;
});

//allow list name and public/private change only if table is not empty
var listName = document.getElementById("listName");
var public = document.getElementById("public");
var private = document.getElementById("private");
listName.oninput = function() {
  if (currentListData.length != 0) {
    saveBtn.disabled = false;
  }
  else {
    saveBtn.disabled = true;
  }
}
public.onclick = function() {
  if (currentListData.length != 0) {
    saveBtn.disabled = false;
  }
  else {
    saveBtn.disabled = true;
  }
}
private.onclick = function() {
  if (currentListData.length != 0) {
    saveBtn.disabled = false;
  }
  else {
    saveBtn.disabled = true;
  }
}


/* Disable all buttons if list is not yours */
var listOwner = document.getElementById("currentList").getAttribute("owner");
if (listOwner != "" && listOwner != email) {
  addBtn.disabled = true;
  removeBtn.disabled = true;
  upBtn.disabled = true;
  downBtn.disabled = true;
  saveBtn.disabled = true;
  document.getElementById("listName").disabled = true;
  document.getElementById("category").disabled = true;
  document.getElementById("desc").disabled = true;
  document.getElementById("start_Date").disabled = true;
  document.getElementById("end_Date").disabled = true;
  document.getElementById("completed").disabled = true;
  document.getElementById("public").disabled = true;
  document.getElementById("private").disabled = true;
  var boxes = document.getElementsByClassName(
    "boxes mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
  );
  for (var i = 0, length = boxes.length; i < length; i++) {
    boxes[i].MaterialCheckbox.disable();
  }
}
