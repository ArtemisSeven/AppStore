<%@ page import="com.appstore.dto.Page" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appstore.entity.Comment" %>
<%@ page import="com.appstore.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: chenyuexiao
  Date: 16/11/14
  Time: 上午1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="../common/head.jsp" %>
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
    Page resultPage=(Page)request.getAttribute("resultPage");
    List<String> appNames=resultPage.getAppNames();
    List<Comment> commentList=resultPage.getCommentList();
    User user=(User)request.getSession().getAttribute("user");
%>
<jsp:include page="../jsp/navigator.jsp"/>
<!--3-->
<div class="container">
    <div class="row" style="margin-top: 20px;">
        <div class="col-md-2">
            <button class="btn btn-default" id="modifyPswBtn">
                修改密码
                <span class="glyphicon glyphicon-edit"></span>
            </button>
            <div class="modal fade" id="modifyPswModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">修改密码</h4>
                        </div>
                        <div class="modal-body">
                            <form id="modifyPswForm" method="post" action="/clientCenter/account/modifyPsw/<%=user.getId()%>">
                            <div class="form-group">
                                <label>原密码</label><span id="oldPswTips" class="text-danger"></span>
                                <input type="text" class="form-control" id="oldPsw" name="oldPsw">
                                <label>新密码</label><span id="newPswTips" class="text-danger"></span>
                                <input type="text" class="form-control" id="newPsw" name="newPsw">
                            </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="checkModify(<%=user.getPassword()%>)">修改</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </div>
    </div>

    <table class="table table-bordered table-striped" style="margin-top: 20px;">
        <thead>
        <tr>
            <th>App名称</th>
            <th>版本号</th>
            <th>我的评分</th>
            <th colspan="2" class="text-center">我的评论</th>

        </tr>
        </thead>
        <tbody>
        <%for (int i=0;i<commentList.size();++i){
        Comment comment=commentList.get(i);%>
        <tr>
            <td><%=appNames.get(i)%></td>
            <td><%=comment.getVersion()%></td>
            <td>
                <%for (int j=0;j<comment.getScore();++j){%>
                <span class="glyphicon glyphicon-star chosen"></span>
                <%}%>
                <%for (int j=0;j<(5-comment.getScore());++j){%>
                <span class="glyphicon glyphicon-star noChosen"></span>
                <%}%>
            </td>
            <td><%=comment.getContent()%></td>
            <td><%=comment.getCommentTime()%></td>
        </tr>
        <%}%>
        </tbody>
    </table>
</div>
<!--3-->
<script src="/js/myInfo.js" type="text/javascript"></script>
<script>
    function checkModify(psw){
        var oldPsw=$('#oldPsw').val();
        var newPsw=$('#newPsw').val();
        if (oldPsw==psw){
            if (newPsw!=''){
                if (newPsw!=psw){
                    $('#modifyPswForm').submit();
                }else{
                    $('#newPswTips').hide().html('新密码不能与旧密码相同').show(200);
                }
            }else{
                $('#newPswTips').hide().html('新密码不能为空').show(200);
            }
        }else{
            $('#oldPswTips').hide().html('原密码错误').show(200);
        }
    }
</script>
</body>
