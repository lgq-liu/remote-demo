<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="css/show.css" type="text/css" rel="stylesheet">
    <!-- 引入 Font Awesome 的 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <%--    引入jquery--%>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>黑名单列表</title>
<%--    移动端页面适配代码--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
</head>
<body>
<div class="box">
    <div class="h1"><h1>黑名单列表</h1></div>
    <div id="he-plugin-standard"></div>
    <script>
        WIDGET = {
            "CONFIG": {
                "layout": "1",
                "width": "450",
                "height": "150",
                "background": "1",
                "background-size": "cover",
                "dataColor": "FFFFFF",
                "language": "zh",
                "modules": "01",
                "key": "298e80c8d3214ef1875f01431845250b"
            }
        }
    </script>
    <script src="https://widget.qweather.net/standard/static/js/he-standard-common.js?v=2.0"></script>
    <div style="margin-top: 10px">
        <div class="box-search-button-group">
            <input type="text" id="searchText" name="keyword" placeholder="搜索"/>
            <div class="box-search">
                <img src="images/search.ico" id="searchButton" type="submit" alt="搜索">
            </div>
            <select id="sexSelect" name="sexSelect">
                <option id="option1" value="all" selected="selected">全部</option>
                <option id="option2" value="0">男</option>
                <option id="option3" value="1">女</option>
            </select>
        </div>
    </div>
    <div>
        <table border="2" cellspacing="0">
            <tr>
                <th>姓名
                    <span class="sort-icon" style="cursor: pointer" data-sortby="name" data-order="ASC">
                        <i class="fa fa-sort-up"></i>
                    </span>
                    <span class="sort-icon" style="cursor: pointer" data-sortby="name" data-order="DESC">
                        <i class="fa fa-sort-down"></i>
                    </span>
                </th>
                <th>性别</th>
                <th>电话</th>
                <th>操作</th>
                <th>操作</th>
            </tr>
            <c:forEach var="contact" items="${contactList}" varStatus="status">
                <tr>
                    <td>${contact.ct_name}</td>
                    <td>${contact.ct_mf}</td>
                    <td>${contact.ct_phone}</td>
                    <td><a href="DetailCtServlet?ct_id=${contact.ct_id}">详情</a></td>
                    <td><a href="DeleteAndRestoreServlet?ct_id=${contact.ct_id}">还原</a></td>
                </tr>
            </c:forEach>
        </table>
        <%int currentPage=1;%>
        <input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>">
        <div class="pagination">
            <%currentPage= (int) request.getAttribute("currentPage");%>
            <%int totalPages= (int) request.getAttribute("totalContactPage");%>
            <%-- 生成上一页导航 --%>
            <% if (currentPage > 1) { %>
            <a href="javascript:void(0);" onclick="goToPage(<%= currentPage - 1 %>);">上一页</a>
            <% } else { %>
            <label class="disabled">上一页</label>
            <% } %>

            <%-- 生成页码导航 --%>
            <% for (int i = 1; i <= totalPages; i++) { %>
            <% if (i == currentPage) { %>
            <label class="active"><span><%= i %></span></label>
            <% } else { %>
            <a href="javascript:void(0);" onclick="goToPage(<%=i%>);"><%= i %></a>
            <% } %>
            <% } %>

            <%-- 生成下一页导航 --%>
            <% if (currentPage < totalPages) { %>
            <a href="javascript:void(0);" onclick="goToPage(<%=currentPage+1%>);">下一页</a>
            <% } else { %>
            <label class="disabled"><span>下一页</span></label>
            <% } %>
        </div>
    </div>
</div>
<script>
    // 从 sessionStorage 获取数据
    var sort = sessionStorage.getItem('sort');//sort值用于表示asc，desc
    var keyword = sessionStorage.getItem('keyword'); //搜索关键字
    var selectBox=document.getElementById("sexSelect");  //获取selectBox数据
    $(document).ready(function () { //页面元素初始化
        selectBox.addEventListener("change", function() {  //添加性别选择框的事件监听
            var selectedValue = selectBox.options[selectBox.selectedIndex].value;
            window.location.href = "BlackCtListServlet?sex=" + selectedValue;
        });
        //排序图标的点击事件
        $('.sort-icon').on('click', function () {
            sort= $(this).data('order');
            var selectedValue = selectBox.options[selectBox.selectedIndex].value;
            sessionStorage.setItem('sort',sort);  // 把数据存储到 sessionStorage
            window.location.href = "BlackCtListServlet?sort=" + sort+"&sex="+selectedValue+"&keyword="+keyword;
        });
        $('#searchButton').click(function() {
            keyword = $('#searchText').val(); // 获取搜索框的内容
            sessionStorage.setItem('keyword',keyword);
            window.location.href = "ContactListServlet?keyword="+keyword;
        });
    });

    function goToPage(page) {
        var currentPageInput = document.getElementById("currentPage");
        currentPageInput.value = page;
        var url = "BlackCtListServlet"; // 获取当前页面的URL
        var updatedUrl = updateQueryStringParameter(url, "currentPage", page); // 更新URL中的currentPage参数
        var selectedValue = selectBox.options[selectBox.selectedIndex].value;
        updatedUrl=updateQueryStringParameter(updatedUrl,"sex",selectedValue);
        if(sort!=null){
            updatedUrl = updateQueryStringParameter(updatedUrl, "sort", sort);
        }
        updatedUrl = updateQueryStringParameter(updatedUrl, "keyword", keyword);
        window.location.href = updatedUrl; // 跳转到更新后的URL
    }

    function updateQueryStringParameter(url, key, value) {
        var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
        var separator = url.indexOf("?") !== -1 ? "&" : "?";
        if (url.match(re)) {
            return url.replace(re, "$1" + key + "=" + value + "$2");
        } else {
            return url + separator + key + "=" + value;
        }
    }
</script>
<script>
    var selectBox=document.getElementById("sexSelect");  //设置下拉框的选中项
    var value=${selectedItem};
    for (var i = 0; i < selectBox.options.length; i++) {
        if (selectBox.options[i].value == value) {
            // 设置选中项
            selectBox.selectedIndex = i;
            break;
        }
    }
</script>
</body>
</html>
