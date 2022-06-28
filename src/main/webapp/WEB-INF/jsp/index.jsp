<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆首页</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/login.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/js.cookie.js"></script>
    <style>
        #login {
            height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }

        * {
            padding: 0;
            margin: 0;
        }
    </style>
</head>
<body style="background: url('img/bg.jpg')">
<div class="container" align="center">
    <div class="col-md-6" style="margin: 20%">
        <div class="inset">
            <form >
                <input type="hidden" name="enews" value="login">
                <div>
                    <h2 style="font-family: 华文行楷; font-size: 400%; ">万文图书馆</h2>
                    <span style="text-align: left;text-indent: 0.4em;"><label>用户名</label></span>
                    <span><input type="text" name="username" class="textbox" id="id"></span>
                </div>
                <div>
                    <span style="text-align: left;text-indent: 0.4em;"><label>密码</label></span>
                    <span><input name="password" type="password" class="password" id="passwd"></span>
                </div>
                <div class="sign">
                    <input type="button" value="登录" id="loginButton" class="submit">
                    <input type="reset" class="submit" value="重置">
                </div>
            </form>
            <p style="text-align: right;color: red;position: absolute" id="info"></p>
        </div>
    </div>
</div>
<script>
    $("#id").keyup(
        function () {
            if (isNaN($("#id").val())) {
                $("#info").text("提示:账号只能为数字");
            } else {
                $("#info").text("");
            }
        }
    )

    // // 记住登录信息
    // function rememberLogin(username, password, checked) {
    //     Cookies.set('loginStatus', {
    //         username: username,
    //         password: password,
    //         remember: checked
    //     }, {expires: 30, path: ''})
    // }
    //
    // 若选择记住登录信息，则进入页面时设置登录信息
    function setLoginStatus() {
        var loginStatusText = Cookies.get('loginStatus')
        if (loginStatusText) {
            var loginStatus
            try {
                loginStatus = JSON.parse(loginStatusText);
                $('#id').val(loginStatus.username);
                $('#passwd').val(loginStatus.password);
                $("#remember").prop('checked', true);
            } catch (__) {
            }
        }
    }

    // 设置登录信息
    setLoginStatus();
    $("#loginButton").click(function () {
        var id = $("#id").val();
        var passwd = $("#passwd").val();
        // var remember = $("#remember").prop('checked');
        if (id == '') {
            $("#info").text("提示:账号不能为空");
        } else if (passwd == '') {
            $("#info").text("提示:密码不能为空");
        } else if (isNaN(id)) {
            $("#info").text("提示:账号必须为数字");
        } else {
            $.ajax({
                type: "POST",
                url: "/api/loginCheck",
                data: {
                    id: id,
                    passwd: passwd
                },
                dataType: "json",
                success: function (data) {
                    if (data.stateCode.trim() === "0") {
                        $("#info").text("提示:账号或密码错误！");
                    } else if (data.stateCode.trim() === "1") {
                        $("#info").text("提示:登陆成功，跳转中...");
                        window.location.href = "/admin_main.html";
                    } else if (data.stateCode.trim() === "2") {
                        // if (remember) {
                        //     rememberLogin(id, passwd, remember);
                        // } else {
                        //     Cookies.remove('loginStatus');
                        // }
                        Cookies.remove('loginStatus');
                        $("#info").text("提示:登陆成功，跳转中...");
                        window.location.href = "/reader_main.html";
                    }
                }
            });
        }
    })

</script>
</div>

</body>
</html>
