<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="../css/login.css" type="text/css" rel="stylesheet">
    <title>用户登录</title>
    <%--    移动端页面适配代码--%>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
</head>
<body>
<div class="login">
    <h1>联系人在线管理系统</h1>
    <form action="../LoginServlet" method="post">
        <img src="../images/user.ico">
        <input type="text" name="user" placeholder="用户名" required="required">
        <img src="../images/pwd.ico">
        <input type="password" name="password" placeholder="密  码" required="required">
        <button type="submit" id="btn_login" name="btn_login">登录</button>
    </form>
</div>
<script>

</script>
</body>
</html>