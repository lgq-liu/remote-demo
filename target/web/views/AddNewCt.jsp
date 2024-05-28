<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="../css/Contact.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="../js/image-update.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <title>添加联系人</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%--    移动端页面适配代码--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
</head>
<body>
<div class="box">
    <div class="item">
        <h1>添加联系人</h1>
        <form action="../AddNewCtServlet" id="uploadForm" method="post" enctype="multipart/form-data">
            <img id="image" src="../images/default.png" style="cursor: pointer" width="100"
                 height="100" onclick="selectImage()" value="">
            <input type="file" id="fileInput" name="ctImage" style="display: none;" onchange="showImage()"
                   accept="image/png,image/gif">
            <div class="item" style="margin-top: 10px">
                <label>姓名：</label>
                <input type="text" id="name" name="name" placeholder="姓名" required="required">
            </div>
            <div class="item"><label>地址：</label>
                <input type="text" id="address" name="address" placeholder="地址" required="required">
            </div>
            <div class="item">
                <label>邮箱：</label>
                <input type="text" id="e-mail" name="e-mail" placeholder="邮箱" required="required">
            </div>
            <div class="item">
                <label>QQ：</label>
                <input type="text" id="QQ" name="QQ" placeholder="QQ" required="required">
            </div>
            <div class="item">
                <label>微信：</label>
                <input type="text" id="weChat" name="weChat" placeholder="微信" required="required">
            </div>
            <div class="item1"><label>邮编：</label>
                <input type="text" id="postcode" name="postcode" placeholder="邮编" required="required">
                <label> 性别：</label>
                <select name="sex"> 
                    <option value="0" selected="selected">男</option>
                             
                    <option value="1">女</option>
                </select>
            </div>
            <div class="item1">
                <label>生日：</label>
                <input type="date" id="birth" name="birth" placeholder="生日" required="required" value="">
                <label> 电话：</label>
                <input type="text" id="phone" name="phone" placeholder="电话" required="required">
            </div>
            <div align="center">
                <button type="submit" id="btn_add">添加</button>
            </div>
        </form>
    </div>
</div>
<script type = "text/javascript">
    $(document).ready(function() {
        $("#uploadForm").submit(function () {   // 绑定表单的提交事件
            var email = $("#e-mail").val();
            var qq = $("#QQ").val();
            var wx = $("#weChat").val();
            var postcode = $("#postcode").val();
            var phone = $("#phone").val();
            if (!validateEmail(email)) {
                alert('邮箱格式不正确');
                return false;
            }
            if (!isNumber(qq)||qq.length>11) {
                alert("QQ号必须为纯数字并且不大于11位");
                return false;
            }
            if (!isNumber(wx)||wx.length>11) {
                alert("微信号必须为纯数字并且不大于11位");
                return false;
            }
            if(!isNumber(postcode)||postcode.length!==6){
                alert("邮编必须为6位纯数字");
                return false;
            }
            if(!isNumber(phone)||phone.length!==11){
                alert("手机号必须为11位纯数字");
                return false;
            }
            return true;
        });

        function validateEmail(email) {
            var re = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,}$/;
            return re.test(email);
        }
        function isNumber(value) {
            if (typeof value === 'number') {
                // 当变量类型为number时，直接返回true
                return true;
            } else if (typeof value === 'string') {
                // 当变量类型为string时，使用正则表达式判断是否为数字
                return !isNaN(Number(value)) && !isNaN(parseInt(value));
            }
            // 其他情况，返回false
            return false;
        }
    });
</script>
</body>
</html>
