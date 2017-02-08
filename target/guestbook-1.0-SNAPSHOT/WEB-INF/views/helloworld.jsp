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
			${message} ${name}
		</h2>
	</center>

	<!-- Sign in/out -->
	<div class="g-signin2" data-onsuccess="onSignIn"></div>
	<a href="#" onclick="signOut();">Sign out</a>
	<script>
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
			<input class="mdl-textfield__input" type="text" id="sample3">
			<label class="mdl-textfield__label" for="sample3">To Do List Name</label>
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
			<th>Description</th>
			<th>Start Date</th>
			<th>End Date</th>
			<th>Completed</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td class="mdl-data-table__cell--non-numeric">Kitchen</td>
			<td>Repair leaky sink</td>
			<td>2016-06-10</td>
			<td>2016-06-11</td>
			<td>False</td>
		</tr>
		<tr>
			<td class="mdl-data-table__cell--non-numeric">Attic</td>
			<td>Fix leak in roofk</td>
			<td>2016-06-07</td>
			<td>2016-06-17</td>
			<td>False</td>
		</tr>
		<tr>
			<td class="mdl-data-table__cell--non-numeric">Garage</td>
			<td>Paint interior</td>
			<td>2016-06-10</td>
			<td>2016-06-11</td>
			<td>False</td>
		</tr>
		<tr>
			<td class="mdl-data-table__cell--non-numeric">Garden</td>
			<td>Paint flowers</td>
			<td>2016-06-04</td>
			<td>2016-06-04</td>
			<td>True</td>
		</tr>
		<tr>
			<td class="mdl-data-table__cell--non-numeric">Garage</td>
			<td>Repair door</td>
			<td>2016-06-10</td>
			<td>2016-06-14</td>
			<td>True</td>
		</tr>
		</tbody>
	</table>

	<!-- Save Button -->
	<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored">
		Save
	</button>



</body>
</html>