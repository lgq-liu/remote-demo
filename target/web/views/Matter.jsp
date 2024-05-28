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
    <title>联系人事项提醒</title>
<%--    移动端页面适配代码--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
</head>
<body>
<div class="box">
    <div class="h1"><h1>联系人事项提醒</h1></div>
    <div style="margin-top: 10px">
        <div class="box-search-button-group">
            <input type="text" id="searchText" name="keyword" placeholder="搜索"/>
            <div class="box-search">
                <img src="images/search.ico" id="searchButton" type="submit" alt="搜索">
            </div>
            <div class="box-button-group">
                <a href="views/AddMatter.jsp">
                    <img src="images/addNewCt.ico" id="add" type="submit" alt="添加">
                </a>
            </div>
            <select id="selectBox" name="selectBox" >
                <option value="0" selected="selected">待完成</option>
                <option value="1">取消</option>
                <option value="2">已完成</option>
            </select>
        </div>
    </div>
    <div>
        <table border="2" cellspacing="0">
            <tr>
                <th>姓名</th>
                <th>时间
                    <span class="sort-icon" style="cursor: pointer" data-sortby="time" data-order="ASC">
                        <i class="fa fa-sort-up"></i>
                    </span>
                    <span class="sort-icon" style="cursor: pointer" data-sortby="date" data-order="DESC">
                        <i class="fa fa-sort-down"></i>
                    </span></th>
                <th>事件</th>
                <th>操作</th>
                <th>操作</th>
            </tr>
            <c:forEach var="matter" items="${matterList}" varStatus="status">
                <tr>
                    <td>${matter.ct_name}</td>
                    <td>${matter.matter_time}</td>
                    <td>${matter.matter}</td>
                    <td><a id="btn_cancel" href="MatterStatServlet?matter_id=${matter.matter_id}&operate=cancel&matter_delete=${matter.matter_delete}">取消</a></td>
                    <td><a id="btn_finish" href="MatterStatServlet?matter_id=${matter.matter_id}&operate=finish&matter_delete=${matter.matter_delete}">完成</a></td>
                </tr>
            </c:forEach>
        </table>
        <%int currentPage=1;%>
        <input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>">
        <div class="pagination">
            <%currentPage= (int) request.getAttribute("currentPage");%>
            <%int totalPages= (int) request.getAttribute("totalMatterPage");%>
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
    var selectBox=document.getElementById("selectBox");  //获取selectBox数据
    // 从 sessionStorage 获取数据
    var sort = sessionStorage.getItem('sort');//sort值用于表示asc，desc
    var keyword = sessionStorage.getItem('keyword'); //搜索关键字
    $(document).ready(function () {  //排序图标的点击事件
        $('.sort-icon').on('click', function () {
            sort= $(this).data('order');
            sessionStorage.setItem('sort',sort);  // 把数据存储到 sessionStorage
            window.location.href = "MatterServlet?sort=" + sort + "&matter_delete="+selectBox.selectedIndex+"&keyword="+keyword;
        });
        $('#searchButton').click(function() { //搜索按钮点击事件
            keyword = $('#searchText').val(); // 获取搜索框的内容
            sessionStorage.setItem('keyword',keyword);
            var selectedValue = selectBox.options[selectBox.selectedIndex].value;
            window.location.href = "MatterServlet?matter_delete="+selectedValue+"&keyword="+keyword;
        });
    });
    function goToPage(page) {
        var currentPageInput = document.getElementById("currentPage");
        currentPageInput.value = page;
        var url = "MatterServlet"; // 获取当前页面的URL
        var updatedUrl = updateQueryStringParameter(url, "currentPage", page); // 更新URL中的currentPage参数
        updatedUrl=updateQueryStringParameter(updatedUrl,"matter_delete",selectBox.selectedIndex);
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
<%--下拉框选中的处理方法--%>
<script type="text/javascript">
    var selectElem = document.getElementById("selectBox");
    selectElem.addEventListener("change", function() {
        var selectedValue = selectElem.options[selectElem.selectedIndex].value;
        window.location.href = "MatterServlet?matter_delete=" + selectedValue;
    });
</script>
<script>
    var selectBox=document.getElementById("selectBox");  //设置下拉框的选中项
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