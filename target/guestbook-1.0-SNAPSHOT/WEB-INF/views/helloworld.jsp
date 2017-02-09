<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="874074052748-hsjcp5bhstjnp8osn72ktpgaq16kk1ia.apps.googleusercontent.com">
<title>Spring 4 MVC -HelloWorld</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_purple.min.css">
	<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>


</head>
<body>
	<center>
		<h2>Hello World</h2>
		<h2>
			${message} guestbook
		</h2>
	</center>

	<!-- Sign in/out -->
	<div class="g-signin2" data-onsuccess="onSignIn"></div>
	<a href="#" onclick="signOut();">Sign out</a>
	<script type="text/javascript">
		//Sign out function
		function signOut() {
		    var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function() {
		        console.log('User signed out');
			});
		}
	</script>

	<!-- Create/Load Buttons -->
	<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
		Create
	</button>
	<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
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
	<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">add</i>
	</button>
	<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">remove</i>
	</button>
	<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">arrow_upward</i>
	</button>
	<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
		<i class="material-icons">arrow_downward</i>
	</button>

	<!-- Table -->
	<table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
		<thead>
		<tr>
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
	<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
		Save
	</button>
</body>
<script>
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
    ]

    for(i = 0; i < testData.length; i++) {
        //Create the row element for each object in array
        var tableRow = document.createElement("tr");
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
</script>
</html>