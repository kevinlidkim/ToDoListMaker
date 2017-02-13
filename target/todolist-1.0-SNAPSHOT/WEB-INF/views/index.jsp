<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="google-signin-client_id" content="874074052748-hsjcp5bhstjnp8osn72ktpgaq16kk1ia.apps.googleusercontent.com">
    <title>To Do List Maker</title>
    <link rel="icon" href="../../check-mark.svg">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body style="background-color: #7289da;display:flex;display:-ms-flexbox;display:-webkit-flex;align-items:center;justify-content:center;">

<div style="width:800px;display:flex;display:-ms-flexbox;display:-webkit-flex;align-items:center;position:relative;overflow:hidden;border-radius:10px;padding: 40px 0 50px 0;">
    <div style="position:absolute;top:0;right:0;bottom:0;left:0;background-color:#23272A;opacity:0.90;z-index:0;"></div>
    <div style="z-index:1;position:relative;">
        <img src="../../check-mark.svg" height="330px" />
    </div>
    <div style="z-index:1;position:relative;top:8px;">
        <div style="font-family:'Lato', sans-serif;font-size:3em;margin-bottom:25px;font-weight:600;color:white;">ToDo List Maker</div>
        <div style="font-family:'Lato', sans-serif;font-size:2em;margin-bottom:15px;font-weight:600;color:white;">Ex. List of Things I Hate</div>
        <div style="font-family:'Lato', sans-serif;font-size:1.2em;margin-bottom:10px;font-weight:400;color:white;">1. Landing Pages</div>
        <div style="font-family:'Lato', sans-serif;font-size:1.2em;margin-bottom:10px;font-weight:400;color:white;">2. Irony</div>
        <div style="font-family:'Lato', sans-serif;font-size:1.2em;margin-bottom:25px;font-weight:400;color:white;">3. Lists</div>
        <div id="my-signin2"></div>
    </div>
</div>
<img src="../../pattern.png" width="100%" height="100%" style="position:absolute;z-index:-1;top:0;bottom:0;left:0;right:0;opacity:0.5;"/>

<script>
    function onSuccess(googleUser) {
        //console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
        var user = googleUser.getBasicProfile().getName();
        var email = googleUser.getBasicProfile().getEmail();
        localStorage.setItem("user", user);
        localStorage.setItem("email", email);
        //window.location.href = "tdlm";
        // return false;

        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/tdlm");
        var params = {user: user, email: email};
        for(var key in params) {
            if(params.hasOwnProperty(key)) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", key);
                hiddenField.setAttribute("value", params[key]);

                form.appendChild(hiddenField);
            }
        }
        document.body.appendChild(form);
        form.submit();

    }
    function onFailure(error) {
        console.log(error);
    }
    function renderButton() {
        gapi.signin2.render('my-signin2', {
            'scope': 'profile email',
            'width': 240,
            'height': 50,
            'longtitle':true,
            'theme': 'dark',
            'onsuccess': onSuccess,
            'onfailure': onFailure
        });
    }
</script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>

</body>
</html>
