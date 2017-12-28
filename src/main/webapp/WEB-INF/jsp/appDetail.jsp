<%@ page import="com.appstore.dto.Page" %>
<%@ page import="com.appstore.entity.App" %>
<%@ page import="com.appstore.entity.Picture" %>
<%@ page import="com.appstore.entity.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appstore.entity.User" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tag.jsp" %>
<html>
<head>
    <title>详情页</title>
    <%@include file="/WEB-INF/common/head.jsp" %>
    <style type="text/css">
        .chosen {
            color: #ff8257;
        }
        .noChosen {
            color: #dedede;
        }
    </style>
</head>
<body>
<%
    int login=0;
    User user=(User)request.getSession().getAttribute("user");
    if (user!=null) login=1;
    Page resultPage=(Page)request.getAttribute("resultPage");
    App app=resultPage.getApp();
    Picture logo=resultPage.getLogo();
    List<Picture> displaysList=resultPage.getDisplaysList();
    String typeName=resultPage.getTypeName();
    List<Comment> commentList=resultPage.getCommentList();
    List<String> userPhoneList=resultPage.getUserPhoneList();
    int isCurrentUserCommented=0;
%>
<jsp:include page="/WEB-INF/jsp/navigator.jsp"/>
<!--3-->
<div class="container">
    <div class="jumbotron">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-6 col-md-4">
                    <a href="#" class="thumbnail">
                        <img src="<%=logo.getPicPath()+logo.getPicName()%>"  alt="logo">
                    </a>
                </div>
                <div class="col-xs-6 col-md-7">
                    <p>
                        <strong><%=app.getAppName()%></strong><br/>
                        更新时间:<%=app.getUpdateTime()%><br/>
                        开发者:<%=app.getCompany()%><br/>
                        分类:<%=typeName%><br/>
                        版本号:<%=app.getVersion()%><br/>
                        适用系统:<%=app.getOs()%><br/>
                        下载次数:<%=app.getDownloadCount()%><br/>
                        评分:
                        <%--此处注意avgScore的值类型--%>
                        <%for(int i=0;i<app.getAvgScore();++i){%>
                            <span class="glyphicon glyphicon-star chosen"></span>
                        <%}%>
                        <%for(int i=0;i<(5-app.getAvgScore());++i){%>
                            <span class="glyphicon glyphicon-star noChosen"></span>
                        <%}%>
                        (<%=app.getRatingCount()%>次评分)
                        <a class="btn btn-primary btn-lg pull-right" href="<%=request.getContextPath()%>/clientCenter/app/download/<%=app.getId()%>" role="button">立即下载</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--3-->
<!--4-->
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">应用简介</h3>
        </div>
        <div class="panel-body">
            <p><%=app.getDescription()%></p>
        </div>
    </div>
</div>
<!--4-->
<!--5-->
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">应用预览</h3>
        </div>
        <div class="panel-body">
            <!--4.1-->
            <div class="row">
                <%for (int i=0;i<displaysList.size();++i){
                Picture display=displaysList.get(i);%>
                <div class="col-xs-6 col-md-3">
                    <a href="#" class="thumbnail">
                        <img src="<%=display.getPicPath()+display.getPicName()%>" alt="display">
                    </a>
                </div>
                <%}%>
            </div>
            <!--4.1-->
        </div>
    </div>
</div>
<!--5-->

<!--6-->
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">应用评价</h3>
        </div>
        <div class="panel-body">
            <!--6.1-->
            <div class="table-responsive">
                <!--6.2-->
                <%for (int j=0;j<commentList.size();++j){
                Comment comment=commentList.get(j);%>
                <table class="table">
                    <tr class="danger">
                        <td>
                            <%if (app.getVersion().equals(comment.getVersion())){%>
                                当前版本:
                                <%if (user!=null && comment.getUserId()==user.getId()){isCurrentUserCommented=1;}%>
                            <%}else{%>
                                <%=comment.getVersion()%>版本:
                            <%}%>
                            <%for (int k=0;k<comment.getScore();++k){%>
                                <span class="glyphicon glyphicon-star chosen"></span>
                            <%}%>
                            <%for (int o=0;o<(5-comment.getScore());++o){%>
                            <span class="glyphicon glyphicon-star noChosen"></span>
                            <%}%>
                        </td>
                    </tr>
                    <tr class="active">
                        <td>
                            <span><%=comment.getContent()%></span>
                        </td>
                    </tr>
                    <tr class="warning">
                        <td>
                            <span class="pull-right">评论者:<%=userPhoneList.get(j)%>&nbsp;&nbsp;/&nbsp;&nbsp;<%=comment.getCommentTime()%></span>
                        </td>
                    </tr>
                </table>
                <%}%>
                <!--6.2-->
            </div>
            <!--6.1-->

            <form id="commentForm" role="form" class="bg-active" style="margin-top: 20px;" enctype="multipart/form-data" action="<%=request.getContextPath()%>/clientCenter/app/comment/<%=app.getId()%>" method="post">
                <div class="form-group">
                    <strong>评分:</strong>
                    <p>
                        <span class="star glyphicon glyphicon-star noChosen"></span>
                        <span class="star glyphicon glyphicon-star noChosen"></span>
                        <span class="star glyphicon glyphicon-star noChosen"></span>
                        <span class="star glyphicon glyphicon-star noChosen"></span>
                        <span class="star glyphicon glyphicon-star noChosen"></span>

                    </p>
                    <input id="score" name="score" style="visibility: hidden" value="0">
                    <input name="version" style="visibility: hidden" value="<%=app.getVersion()%>">
                </div>
                <div class="form-group">
                    <textarea class="form-control" id="commentContent" name="commentContent"></textarea>
                </div>
            </form>
            <button onclick="checkSubmit(<%=login%>,<%=isCurrentUserCommented%>)" class="btn btn-default pull-right">提交</button>
        </div>
    </div>
</div>
</body>
<script>
    function checkSubmit(login,isCurrentUserCommented){
        if (login){
            if (!isCurrentUserCommented) {
                var commentContent = $('#commentContent').val();
                if (!commentContent) {
                    alert("评价不能为空");
                } else {
                    $('#commentForm').submit();
                }
            }else{
                alert("你已经评论过该版本了");
            }
        }else{
            alert("请先登录");
        }
    }
    $(document).ready(function () {
        var flag = 0;
        $(".star").hover(
                function () {
                    flag=0;
                    $(this).prevAll().removeClass("noChosen").addClass("chosen");
                    $(this).removeClass("noChosen").addClass("chosen");
                    $(this).nextAll().removeClass("chosen").addClass("noChosen");
                },
                function () {t
                    if (!flag) {
                        $(".star").removeClass("chosen").addClass("noChosen");
                    }
                }
        );
        $(".star").click(function () {
            flag = 1;
            var score=$(".star").index($(this))+1;
            $('#score').val(score);
        });
    });
</script>
