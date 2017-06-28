<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="WEB-INF/common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="WEB-INF/common/head.jsp" %>
</head>
<body>
<%--<a id="getIndexPageData" href="/clientCenter/indexPage/getData">获取首页数据</a>--%>
<form id="getIndexPageData" action="/clientCenter/indexPage/getData" method="get"></form>
</body>
<script>
    $(function () {
        $('#getIndexPageData').submit();
    });
</script>
</html>