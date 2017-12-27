<%@ page import="com.appstore.dto.Page" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appstore.entity.App" %>
<%@ page import="com.appstore.entity.Picture" %>
<%@ page import="com.appstore.entity.Type" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="/WEB-INF/common/head.jsp" %>
    <%--<style>--%>
        <%--a{text-decoration: none;}--%>
    <%--</style>--%>
</head>
<body>
<%
    Page resultPage = (Page) request.getAttribute("resultPage");
    String pageTab=resultPage.getPageTab().toString();
    List<App> appList = resultPage.getAppList();
    List<Picture> logoList = resultPage.getLogoList();
    int count;
    int currentPage=resultPage.getCurrentPage();
    int totalPages=resultPage.getTotalPages();
    String keyword=resultPage.getKeyword();
    Type type=resultPage.getType();
    int pageIndexSize=5;

%>
<jsp:include page="/WEB-INF/jsp/navigator.jsp"/>
<div class="container">
    <%if (pageTab.equals("SEARCH")){%>
            <div class="alert alert-success" role="alert">共找到<%=appList.size()%>项"<%=keyword%>"相关应用:</div>
    <%}%>
    <%--else{--%>
        <%--if (pageTab.equals("QUALITY")){%>--%>
            <%--<div class="alert alert-success" role="alert">共找到<%=appList.size()%>项"<%=keyword%>"相关应用:</div><%--%>
        <%--}else{%>--%>
            <%--<div class="alert alert-success" role="alert">共找到<%=appList.size()%>项"<%=keyword%>"相关应用:</div>--%>
        <%--<%}%>--%>
    <%--<%}%>--%>
    <div class="panel panel-default" style="margin-top: 20px;">
        <div class="panel-heading">
            <%if (pageTab.equals("SEARCH")){%>
                <h3 class="panel-title">搜索结果</h3>
            <%}else{
                if (pageTab.equals("QUALITY")){%>
                    <h3 class="panel-title">下载排行版</h3><%
                }else{%>
                    <%if (pageTab.equals("QUANTITY")){%>
                    <h3 class="panel-title">精选排行榜</h3><%
                    }else{%>
                    <h3 class="panel-title"><%=type.getTypeName()%>类型</h3>
                    <%}%>
                <%}%>
            <%}%>
        </div>
        <div class="panel-body">
            <%for (int i = 0; i < appList.size(); ++i) {
            App app=appList.get(i);%>
            <div class="col-md-6">
                <div class="thumbnail">
                    <img src="<%=logoList.get(i).getPicPath()+logoList.get(i).getPicName()%>" alt="..." style="width: 100px;height: 100px;">
                    <div class="caption">
                        <h3><%=app.getAppName()%></h3>
                        <p><strong>出品公司:</strong><%=app.getCompany()%></p>
                        <p><strong>适用系统:</strong><%=app.getOs()%></p>
                        <p><strong>版本:</strong><%=app.getVersion()%></p>
                        <p style="height:150px; overflow: hidden"><strong>应用描述:</strong><%=app.getDescription()%></p>
                        <p>....</p>
                        <p><a href="/clientCenter/app/detail/<%=app.getId()%>" class="btn btn-primary" role="button">查看详情</a>
                        </p>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
    <div class="container">
        <div class="center-block" style="width:400px;">
            <ul class="pagination">
                <%
                    count = 0;
                    if (currentPage > 1) {%>
                <li>

                    <%if (pageTab.equals("SEARCH")){%>
                        <a href="<%="/clientCenter/app/search/"+(currentPage-1)+"?appNameKeyword="+keyword%>">上一页</a>
                    <%}else{
                        if (pageTab.equals("QUALITY")){%>
                            <a href="<%="/clientCenter/app/quality/"+(currentPage-1)%>">上一页</a><%
                        }else{%>
                            <%if (pageTab.equals("QUANTITY")){%>
                                <a href="<%="/clientCenter/app/quantity/"+(currentPage-1)%>">上一页</a>
                            <%}else {%>
                                <a href="<%="/clientCenter/app/type/"+(currentPage-1)+"?typeId="+type.getId()%>">上一页</a>
                            <%}%>
                        <%}%>
                    <%}%>

                </li>
                <%
                    }
                    for (int j = currentPage - 2; j <= totalPages && count < pageIndexSize; ++j) {
                        if (j >= 1) {
                            if (j == currentPage) {
                %>

                    <%if (pageTab.equals("SEARCH")){%>
                        <li><a href="<%="/clientCenter/app/search/"+j+"?appNameKeyword="+keyword%>" style="color: #f92050"><%=j%></a></li>
                    <%}else{
                        if (pageTab.equals("QUALITY")){%>
                            <li><a href="<%="/clientCenter/app/quality/"+j%>" style="color: #f92050"><%=j%></a></li><%
                        }else{%>
                            <%if (pageTab.equals("QUANTITY")){%>
                                <li><a href="<%="/clientCenter/app/quantity/"+j%>" style="color: #f92050"><%=j%></a></li>
                            <%}else {%>
                                <li><a href="<%="/clientCenter/app/type/"+j+"?typeId="+type.getId()%>" style="color: #f92050"><%=j%></a></li>
                            <%}%>
                        <%}%>
                    <%}%>

                        <%} else {%>

                        <%if (pageTab.equals("SEARCH")){%>
                            <li><a href="<%="/clientCenter/app/search/"+j+"?appNameKeyword="+keyword%>"><%=j%></a></li>
                        <%}else{
                            if (pageTab.equals("QUALITY")){%>
                                <li><a href="<%="/clientCenter/app/quality/"+j%>"><%=j%></a></li><%
                            }else{%>
                                <%if (pageTab.equals("QUANTITY")){%>
                                    <li><a href="<%="/clientCenter/app/quantity/"+j%>"><%=j%></a></li>
                                <%}else {%>
                                    <li><a href="<%="/clientCenter/app/type/"+j+"?typeId="+type.getId()%>"><%=j%></a></li>
                                <%}%>
                            <%}%>
                        <%}%>

                <%
                            }
                            count++;
                        }
                    }
                    if (currentPage < totalPages) {
                %>
                <li>
                        <%if (pageTab.equals("SEARCH")){%>
                            <a href="<%="/clientCenter/app/search/"+(currentPage+1)+"?appNameKeyword="+keyword%>">下一页</a>
                        <%}else{
                            if (pageTab.equals("QUALITY")){%>
                                <a href="<%="/clientCenter/app/quality/"+(currentPage+1)%>">下一页</a>
                            <%}else{%>
                                <%if (pageTab.equals("QUANTITY")){%>
                                    <a href="<%="/clientCenter/app/quantity/"+(currentPage+1)%>">下一页</a>
                                <%}else {%>
                                    <a href="<%="/clientCenter/app/type/"+(currentPage+1)+"?typeId="+type.getId()%>">下一页</a>
                                <%}%>
                            <%}%>
                        <%}%>
                </li>
                <%}%>
            </ul>
        </div>
    </div>
</div>
</body>
</html>