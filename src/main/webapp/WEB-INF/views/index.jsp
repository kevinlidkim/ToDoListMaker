<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="google-signin-client_id" content="874074052748-hsjcp5bhstjnp8osn72ktpgaq16kk1ia.apps.googleusercontent.com">
    <title>To Do List Maker</title>
</head>
<body>
<div>To Do List Maker</div>
<div id="my-signin2"></div>
<script>
    function onSuccess(googleUser) {
        //console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
        sessionStorage.setItem("user", googleUser.getBasicProfile().getName());
        window.location.href = "http://localhost:8080/tdlm";
        return false;
    }
    function onFailure(error) {
        console.log(error);
    }
    function renderButton() {
        gapi.signin2.render('my-signin2', {
            'scope': 'profile email',
            //'width': 240,
            //'height': 50,
            //'theme': 'dark',
            'onsuccess': onSuccess,
            'onfailure': onFailure
        });
    }
</script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>

</body>
</html>
