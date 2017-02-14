<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="google-signin-client_id" content="874074052748-hsjcp5bhstjnp8osn72ktpgaq16kk1ia.apps.googleusercontent.com">
	<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
	<script type="text/javascript">
        function onLoad() {
            gapi.load("auth2", function() {
                gapi.auth2.init().then(
                    function(){
                        var g = gapi.auth2.getAuthInstance();
                        if (g.isSignedIn.get() == false) {
                            // console.log("not logged in");
                            window.location.href = "/";
                        }
                        else { // console.log("logged in");
                      }
                    },
                    function(){ // console.log("error");
                    });
            });

        }
	</script>
	<title>To Do List Maker</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_purple.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.6/dialog-polyfill.min.css">
	<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<!-- cdn for modernizr, if you haven't included it already -->
	<script src="http://cdn.jsdelivr.net/webshim/1.12.4/extras/modernizr-custom.js"></script>
	<!-- polyfiller file to detect and load polyfills -->
	<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js"></script>
	<%-- sorting library to sort table --%>
	<script src="http://listjs.com/assets/javascripts/list.min.js"></script>
	<script>
        webshims.setOptions('waitReady', false);
        webshims.setOptions('forms-ext', {types: 'date'});
        webshims.polyfill('forms forms-ext');
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.6/dialog-polyfill.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
	<link rel="icon" href="../../check-mark.svg">
	<style>
		*{  font-family: 'Lato', sans-serif; }
		.vertCenterLeft { display:flex;display:-ms-flexbox;display:-webkit-flex;align-items:center; }
		.textDecAuto { text-decoration:none; }
		.textDecAuto:hover { text-decoration:underline; }
		.mdl-radio__outer-circle { border: 2px solid #262626; }
		.mdl-radio.is-checked .mdl-radio__outer-circle, .mdl-checkbox.is-checked .mdl-checkbox__box-outline { border: 2px solid #7289DA !important; }
		.mdl-radio__inner-circle, .mdl-ripple, .mdl-button { background: #7289DA !important; }
		.mdl-radio__label, mdl-textfield__input { color:white !important; }
		.mdl-textfield__label, .mdl-checkbox__tick-outline { color: white; }
		.mdl-textfield.is_focused .mdl-textfield__input { border-bottom: 1px solid #7289DA !important; }
		.mdl-textfield--floating-label.is-focused .mdl-textfield__label,.mdl-textfield--floating-label.is-dirty .mdl-textfield__label { color: #7289DA !important; }
		.mdl-textfield__label:after, .mdl-checkbox.is-checked .mdl-checkbox__tick-outline, .mdl-checkbox__ripple-container .mdl-ripple { background-color: #7289DA; }
		.mdl-button--colored { background-color:#7289da;color:white; }
	</style>

</head>
<body style="background-color: #363636;text-align:center;min-width:1300px;height:100%;width:100vw;overflow-x:hidden;">

<div style="position:relative;text-align:center;height:250px;color:white;background-color:#7289DA;overflow:hidden;width:100%;">
	<img src="../../pattern.png" width="100%" style="position: absolute;z-index:1;top:0;bottom:0;left:0;right:0;opacity:0.5;"/>
	<div style="height:60px;padding-top:20px;position:relative;z-index:2;">
		<div class="vertCenterLeft" style="position:absolute;left:35px;font-weight:600;font-size:1.6em;margin-top:5px;"><span style="margin-right:10px;">Welcome, </span> <div id="user" style="display:inline-block;vertical-align:top;"></div>!</div>

		<div class="vertCenterLeft" style="position:absolute;right:5px;width:600px;justify-content:flex-end;">
			<!-- Create/Load Buttons -->
			<button class="mdl-button mdl-js-button mdl-js-ripple-effect textDecAuto" id="createBtn" style="margin-right:10px;color:white;text-transform:capitalize;font-family: 'Lato', sans-serif;font-size:1.6em;">
				Create
			</button>
			<script type="text/javascript">
                document.getElementById("createBtn").onclick = function () {
									// window.location = "/new";
              		window.location = "/tdlm";
                };
			</script>
			<button id="loadBtn" type="button" class="mdl-button mdl-js-button mdl-js-ripple-effect textDecAuto" style="margin-right:10px;color:white;text-transform:capitalize;font-family: 'Lato', sans-serif;font-size:1.6em;">
				Load
			</button>

			<!-- Sign in/out -->
			<a href="/" onclick="signOut();"><div class="mdl-button mdl-js-button mdl-js-ripple-effect textDecAuto" style="margin-right:25px;color:white;text-transform:capitalize;font-family: 'Lato', sans-serif;font-size:1.6em;">Sign Out</div></a>
			<script type="text/javascript">
                //Sign out function
                function signOut() {
                    var auth2 = gapi.auth2.getAuthInstance();
                    auth2.signOut().then(function() {
                        console.log('User signed out');
                    });
                }
			</script>

		</div>
	</div>
	<div style="font-size:4em;font-weight:600;text-align:center;margin-top:80px;position:relative;z-index:2;">todolist</div>

</div>

<div style="margin: 0 auto;display:inline-block;padding-top:35px;padding-bottom:30px;">
	<div class="vertCenterLeft" style="">
		<!--To Do List Name Text Field -->
		<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="font-size:1.3em;margin-right:10px;">
			<input class="mdl-textfield__input" type="text" id="listName" style="color:white;padding-bottom:3px;">
			<label class="mdl-textfield__label" for="listName" style="">To Do List Name</label>
		</div>

		<!-- Public/Private Radio Buttons -->
		<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="public" style="margin-left:125px;">
			<input checked class="mdl-radio__button" id="public" name="ppRadio" type="radio" value="on">
			<span class="mdl-radio__label">Public</span>
		</label>
		<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="private" style="margin-left:20px;">
			<input class="mdl-radio__button" id="private" name="ppRadio" type="radio" value="off">
			<span class="mdl-radio__label">Private</span>
		</label>

		<div style="margin-left:125px; color:white;font-size:1.5em;">New ToDo Item To Be Added</div>

	</div>

	<div class="vertCenterLeft" style="position:relative;margin-bottom:30px;min-height:360px;">

		<!-- Table -->
		<div style="display:inline-block;vertical-align:top;margin-right:120px;width:590px;min-height:300px;">
			<div id="listTable">
				<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
					<thead>
					<tr>
						<th>
							<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select" for="table-header">
								<input type="checkbox" id="table-header" class="mdl-checkbox__input" />
							</label>
						</th>
						<th class="mdl-data-table__cell--non-numeric mdl-data-table__header--sorted-ascending sort" data-sort="category">Category</th>
						<th class="mdl-data-table__cell--non-numeric mdl-data-table__header--sorted-ascending sort" data-sort="description">Description</th>
						<th class="mdl-data-table__cell--non-numeric mdl-data-table__header--sorted-ascending sort" data-sort="startDate">Start Date</th>
						<th class="mdl-data-table__cell--non-numeric mdl-data-table__header--sorted-ascending sort" data-sort="endDate">End Date</th>
						<th class="mdl-data-table__cell--non-numeric mdl-data-table__header--sorted-ascending">Completed</th>
					</tr>
					</thead>
					<tbody id="tableBody" class="list">

					</tbody>
				</table>
			</div>

			<!-- Save Button -->
			<button id="saveBtn" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" style="float:right;color:white;text-transform:capitalize;margin-top:20px;">
				Save
			</button>
		</div>

		<div style="width:70px;position:absolute;top:0;left:615px;padding-bottom:70px;">
			<!-- Add/Delete/Move Up/Move Down Buttons -->
			<div style="margin-top:15px;margin-bottom:25px;">
				<button id="addBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
					<i class="material-icons">add</i>
				</button>
			</div>
			<div style="margin-bottom:25px;">
				<button id="removeBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
					<i class="material-icons">remove</i>
				</button>
			</div>
			<div style="margin-bottom:25px;">
				<button id="upBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
					<i class="material-icons">arrow_upward</i>
				</button>
			</div>
			<div style="margin-bottom:25px;">
				<button id="downBtn" class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-js-ripple-effect mdl-button--colored">
					<i class="material-icons">arrow_downward</i>
				</button>
			</div>

		</div>

		<!-- New ToDo Item to be added-->
		<div style="display:inline-block;vertical-align:top;text-align:left; width:340px;height:100%;">
			<div style="position:absolute;right:0;top:0;padding:20px 20px;border: 1px solid #7289da;border-radius:10px;">
				<div>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="font-size:1.3em;margin-right:10px;">
						<input class="mdl-textfield__input" type="text" name="category" value="" id="category" style="color:white;padding-bottom:3px;">
						<label class="mdl-textfield__label" for="listName" style="">Category</label>
					</div>
				</div>
				<div>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="font-size:1.3em;margin-right:10px;">
						<input class="mdl-textfield__input" type="text" name="desc" value="" id="desc" style="color:white;padding-bottom:3px;">
						<label class="mdl-textfield__label" for="listName" style="">Description</label>
					</div>
				</div>
				<div>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label date" style="font-size:1.3em;margin-right:10px;">
						<input class="mdl-textfield__input" type="date" name="start_Date" value="" id="start_Date" style="color:white;padding-bottom:3px;">
						<label class="mdl-textfield__label" for="listName" style="">Start Date</label>
					</div>
				</div>
				<div>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label date" style="font-size:1.3em;margin-right:10px;">
						<input class="mdl-textfield__input" type="date" name="end_Date" value="" id="end_Date" style="color:white;padding-bottom:3px;">
						<label class="mdl-textfield__label" for="listName" style="">End Date</label>
					</div>
				</div>
				<label class="mdl-checkbox mdl-js-checkbox mdl--js-ripple-effect" for="completed" >
					<input type="checkbox" name="completed" value="" id="completed" class="mdl-checkbox__input">
					<span class="mdl-checkbox__label" style="color:white;">Completed</span>
				</label>
			</div>
		</div>
	</div>
</div>

<!-- Testing load right now -->
<script>
	function loadViewableLists() {
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "/loadViewableLists");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "email");
			hiddenField.setAttribute("value", localStorage.getItem("email"));

			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
	}

	function loadSelectedList() {
				var form = document.createElement("form");
				var lists = ${viewableLists};
				var pos = $('input[name="selectList"]:checked').val();

				form.setAttribute("method", "post");
				form.setAttribute("action", "/loadSelectedList");
				var hiddenField = document.createElement("input");
				var hiddenField2 = document.createElement("input");

				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "id");
				hiddenField.setAttribute("value", lists[pos].id);

				hiddenField2.setAttribute("type", "hidden");
				hiddenField2.setAttribute("name", "email");
				hiddenField2.setAttribute("value", localStorage.getItem("email"));

				form.appendChild(hiddenField);
				form.appendChild(hiddenField2);
				document.body.appendChild(form);
				form.submit();
		}
</script>
<button onclick="loadViewableLists()" style="display:none;">Load Viewable Lists</button>

<%-- Load Button Popup Modal. --%>
<dialog class="mdl-dialog" style="background-color:#99aab5;text-align:left;border-radius:10px;">
	<h4 class="mdl-dialog__title" style="font-family:'Lato', sans-serif;font-weight:600;">List to Load</h4>
	<div class="mdl-dialog__content">
		<ul id="loadedList" style="list-style-type:none;padding-left:0;text-align:left;color:#262626;">
		</ul>
	</div>
	<div class="mdl-dialog__actions">
		<button id="loadSelectedListBtn" type="button" class="mdl-button" onclick=loadSelectedList()>Load</button>
		<button type="button" class="mdl-button close">Cancle</button>
	</div>
</dialog>

<script>
	$("#loadSelectedListBtn").click(loadSelectedList);
</script>

<footer class="mdl-mini-footer" style="position:absolute;left:0;right:0;bottom:0;width:100%;display:none">
	<div class="mdl-mini-footer__left-section" style="padding-left:30px;font-size:1.6em;">
		<div class="mdl-logo" style="margin-right:30px;position:relative;bottom:3px;">ToDoList Maker</div>
		<ul class="mdl-mini-footer__link-list">
			<li><a href="http://www3.cs.stonybrook.edu/~cse308/Section01/" class="textDecAuto" style="color:#9e9e9e;">CSE308</a></li>
			<li><a href="http://www3.cs.stonybrook.edu/~cse308/Section01/hw/TeamBuildingExercise.html" class="textDecAuto" style="color:#9e9e9e;">Team Building Exercise</a></li>
		</ul>
	</div>
	<div class="mdl-mini-footer__right-section" style="padding-right:30px;">
		<ul class="mdl-mini-footer__link-list">
			<li><span style="margin-right:8px;color:#7289da;">Project Manager</span><span>Kevin Li</span></li>
			<li><span style="margin-right:8px;color:#7289da;">Lead Programmer</span><span>Yong Lei</span></li>
			<li><span style="margin-right:8px;color:#7289da;">Data Designer</span><span>Stanley Chen</span></li>
			<li><span style="margin-right:8px;color:#7289da;">Lead Designer</span><span>Varun Shivakumar</span></li>
		</ul>
	</div>
</footer>
<script>
    var user = document.getElementById("user");
    user.innerHTML = localStorage.getItem("user");
    // console.log(localStorage.getItem("user") + " sup");
    // console.log(localStorage.getItem("email") + " yo");
</script>

<script src="../../script.js"></script>
<script>
		var selectedList = ${selectedList};
		var data = [];

		if(selectedList != null) {
			data = selectedList.list;
		}

		//remove unwanted data fields.
		for(var i = 0; i < data.length; i++) {
			delete data[i].id;
			delete data[i].theList;
		}

		currentListData = data;

		console.log("current LIST:");
		console.log(currentListData);

    //Load the current list by loading each object as a row item
    for(var i = 0; i < currentListData.length; i++) {
        loadTableRow(currentListData);
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
<script>

    var lists = ${viewableLists};
    // console.log("yo lists");
    // console.log(lists);

		// populate the load button list.
		for(var key in lists) {
			// console.log(lists[key]);

			var listName = lists[key].name;
			var id = lists[key].id;

			var child = document.createElement('li');
			child.setAttribute("id", id);
			var input = '<input type=\"radio\" name=\"selectList\" value=\"' + key + '\">';

			child.innerHTML = input + listName;
			document.getElementById("loadedList").appendChild(child);
		}
</script>
<%-- SORTING THE TABLE --%>
<script>
	var options = {
	  valueNames: [ 'category', 'description', 'startDate', 'endDate']
	};

	// Init list
	var listTable = new List('listTable', options);

	$("th.sort").click(function() {
		console.log(this);
		if(this.classList.contains('mdl-data-table__header--sorted-ascending')) {
			$(this).removeClass('mdl-data-table__header--sorted-ascending').addClass('mdl-data-table__header--sorted-descending');
		} else {
			$(this).removeClass('mdl-data-table__header--sorted-descending').addClass('mdl-data-table__header--sorted-ascending');
		}
	});
</script>
<script>
	setTimeout(function(){$('.date').each(function(){$(this).addClass('is-focused')})}, 1000);
	$(document).on('mouseover','body',function(){$('.date').each(function(){$(this).addClass('is-focused');$(this).removeClass('is-invalid');})});
	$("#start_Date").datepicker({dateFormat: 'mm-dd-yyyy'});
	$("#end_Date").datepicker({dateFormat: 'mm-dd-yyyy'})
</script>
</body>
</html>
