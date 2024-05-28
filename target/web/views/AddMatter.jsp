<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="../css/Contact.css" type="text/css" rel="stylesheet">
<%--    <script type="text/javascript" src="js/image-update.js"></script>--%>
    <title>联系人事项添加</title>
<%--    移动端页面适配代码--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
</head>
<body>
<div class="box">
    <div class="item">
        <h1>联系人事项添加</h1>
        <form action="../AddMatterServlet" method="post">
            <img id="image" src="../images/default.png" style="cursor: pointer" width="100"
                 height="100" value="">
            <div>
                <div><label>姓名：</label>
                    <input type="text" name="name" placeholder="姓名" required="required">
                </div>
                <div><label>日期：</label>
                    <input type="date" name="date" required="required">
                </div>
                <div><label>事件：</label>
                    <input type="text" name="matter" placeholder="事件" required="required">
                </div>
            </div>
            <div align="center">
                <button type="submit">添加</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>