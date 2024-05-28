<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css/Contact.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="js/image-update.js"></script>
    <title>详细信息</title>
<%--    移动端页面适配代码--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
</head>
<body>
<div class="box">
    <h1>详细信息</h1>
    <form method="post" enctype="multipart/form-data">
        <img id="image" src="images/${pic_name}" style="cursor: pointer" width="100"
             height="100" onclick="selectImage()" value="">
        <input type="file" id="fileInput" name="ctImage" style="display: none;" onchange="showImage()"
               accept="image/png,image/gif">
        <div class="item">
            <label>姓名：</label>
            <input type="text" name="name" placeholder="姓名" required="required" value="${name}">
        </div>
        <div class="item"><label>地址：</label>
            <input type="text" name="address" placeholder="地址" required="required" value="${address}">
        </div>
        <div class="item">
            <label>邮箱：</label>
            <input type="text" name="e-mail" placeholder="邮箱" required="required" value="${email}">
        </div>
        <div class="item">
            <label>QQ：</label>
            <input type="text" name="QQ" placeholder="QQ" required="required" value="${QQ}">
        </div>
        <div class="item">
            <label>微信：</label>
            <input type="text" name="weChat" placeholder="微信" required="required" value="${weChat}">
        </div>
        <div class="item1"><label>邮编：</label>
            <input type="text" name="postcode" placeholder="邮编" required="required" value="${postcode}">
            <label> 性别：</label>
            <select id="sex" name="sex"> 
                <option value="0">男</option>
                <option value="1">女</option>
            </select>
        </div>
        <div class="item1">
            <label>生日：</label>
            <input type="date" name="birth" placeholder="生日" required="required" value="${birth}">
            <label> 电话：</label>
            <input type="text" name="phone" placeholder="电话" required="required" value="${phone}">
        </div>
        <div class="button-group" align="center">
            <button type="submit" formaction="UpdateCtServlet" name="update" value="${ct_id}">更新</button>
            <button type="submit" formaction="MatterServlet">事项</button>
        </div>
    </form>

</div>
</body>
<script>
    var selectBox=document.getElementById("sex");
    var value=${sex};
    for (var i = 0; i < selectBox.options.length; i++) {
        if (selectBox.options[i].value == value) {
            // 设置选中项
            selectBox.selectedIndex = i;
            break;
        }
    }
</script>

</html>
