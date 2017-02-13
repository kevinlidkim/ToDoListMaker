<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spring 4 MVC -HelloWorld</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_purple.min.css">
  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
  <center>
    <h2>THIS IS A NEW PAGE</h2>
    <h2>
      ${message} todolist

      <%-- ${viewableLists} --%>

    </h2>
  </center>

  <!-- Create/Load Buttons -->
	<button id="createBtn" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
		Create
	</button>
  <script type="text/javascript">
    document.getElementById("createBtn").onclick = function () {
        window.location = "/new";
    };
	</script>
  <button id="loadBtn" type="button"  class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
    Load
  </button>

	<!--To Do List Name Text Field -->
	<form action="#">
		<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
			<input class="mdl-textfield__input" type="text" id="listName">
			<label class="mdl-textfield__label" for="listName">To Do List Name</label>
		</div>
	</form>

	<!-- Public/Private Radio Buttons -->
	<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="public">
		<input checked class="mdl-radio__button" id="public" name="ppRadio" type="radio"
			   value="on">
		<span class="mdl-radio__label">Public</span>
	</label>
	<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="private">
		<input class="mdl-radio__button" id="private" name="ppRadio" type="radio" value="off">
		<span class="mdl-radio__label">Private</span>
	</label>

	<!-- Add/Delete/Move Up/Move Down Buttons -->
	<button id="addBtn" formnovalidate=""class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">add</i>
	</button>
	<button id="removeBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">remove</i>
	</button>
	<button id="upBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">arrow_upward</i>
	</button>
	<button id="downBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">arrow_downward</i>
	</button>

  <!-- New ToDo Item to be added-->
  <br><br>
  <label for="">Category</label>
  <input type="text" name="catagory" value="" id="catagory">

  <label for="">Description</label>
  <input type="text" name="desc" value="" id="desc">

  <label for="">Start Date</label>
  <input type="date" name="start_Date" value="" id="start_Date">

  <label for="">End Date</label>
  <input type="date" name="end_Date" value="" id="end_Date">

  <label for="">Completed</label>
  <input type="checkbox" name="completed" value="" id="completed">
  <br><br>

	<!-- Table -->
	<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
		<thead>
		<tr>
      <th>
				<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select" for="table-header">
					<input type="checkbox" id="table-header" class="mdl-checkbox__input" />
				</label>
			</th>
			<th class="mdl-data-table__cell--non-numeric">Category</th>
			<th class="mdl-data-table__cell--non-numeric">Description</th>
			<th class="mdl-data-table__cell--non-numeric">Start Date</th>
			<th class="mdl-data-table__cell--non-numeric">End Date</th>
			<th class="mdl-data-table__cell--non-numeric">Completed</th>
		</tr>
		</thead>
		<tbody id="tableBody">

		</tbody>
	</table>
  <!-- Save Button -->
  <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" id="saveBtn">
    Save
  </button>

  <%-- Load Button Popup Modal. --%>

  <dialog class="mdl-dialog">
    <h4 class="mdl-dialog__title">List to Load</h4>
    <div class="mdl-dialog__content">
  		<%-- dummy list --%>
      <ul id="loadedList" style="list-style-type:none;padding-left:0px;">

        <script>
          for(var key in ${viewableLists}) {
            console.log(${viewableLists}[key]);

            var listName = ${viewableLists}[key].name;
            var child = document.createElement('li');
            var input = '<input type=\"radio\" name=\"selectList\" value=\"' + key + '\">';

            child.innerHTML = input + listName;
            document.getElementById("loadedList").appendChild(child);
          }
        </script>

        <script>
          // var json = JSON.parse(${viewableLists});
          // console.log(${viewableLists});
        </script>


        <%-- <script>
          console.log(${viewableLists});
        </script> --%>
      </ul>
    </div>
    <div class="mdl-dialog__actions">
      <button type="button" class="mdl-button">Load</button>
      <button type="button" class="mdl-button close">Cancle</button>
    </div>
  </dialog>

  <%-- Scripts --%>
  <script src="../../script.js"></script>

  <script>

  var emptyData = [];

  //Load Table with empty data.
  for(var i = 0; i < emptyData.length; i++) {
      loadTableRow(emptyData);
  }
  </script>
  <script>
      var dialog = document.querySelector('dialog');
      var showDialogButton = document.querySelector('#loadBtn');
      if (! dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
      }
      showDialogButton.addEventListener('click', function() {
        dialog.showModal();
      });
      dialog.querySelector('.close').addEventListener('click', function() {
        dialog.close();
      });
  </script>

</body>
</html>
