<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="WEB-INF/common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="WEB-INF/common/head.jsp" %>
</head>
<body>
<a href="<%=request.getContextPath()%>/clientCenter/indexPage/getData"><span id="getIndexPageData"></span></a>
</body>
<script>
    $(function () {
        $('#getIndexPageData').click();
    });
</script>
</html>