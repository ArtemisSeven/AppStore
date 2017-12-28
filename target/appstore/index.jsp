<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="WEB-INF/common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="WEB-INF/common/head.jsp" %>
</head>
<body>
<form id="getIndexPageData" action="<%=request.getContextPath()%>/clientCenter/indexPage/getData" method="get"></form>
</body>
<script>
    $(function () {
        $('#getIndexPageData').submit();
    });
</script>
</html>