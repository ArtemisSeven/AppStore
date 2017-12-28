<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/tag.jsp" %>
<nav class="navbar navbar-default" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">AppStore</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <li><a id="showLogin" onclick="showLoginModal()" href="#">登录</a></li>
                        <li><a id="showRegister" onclick="showRegisterModal()" href="#">注册</a></li>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${sessionScope.user.role == '用户'}">
                            <li><a href="<%=request.getContextPath()%>/clientCenter/account/myInfo">个人中心</a></li>
                        </c:if>
                        <c:if test="${sessionScope.user.role == '管理员'}">
                            <li><a href="<%=request.getContextPath()%>/managerCenter/1/appPage?appState=ALL&keyword=">管理中心</a></li>
                        </c:if>
                        <li><a id="logout" onclick="logout('<%=request.getContextPath()%>')" href="#">退出</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
                <form class="navbar-form navbar-right" role="search" action="<%=request.getContextPath()%>/clientCenter/app/search/1" method="get">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="app名称关键字" name="appNameKeyword">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>


<div id="loginModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">登录</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <span class="input-group-addon">账号</span>
                    <input id="loginPhone" type="text" class="form-control" placeholder="请输入手机号码">

                </div>
                <div class="input-group" style="margin-top: 10px;">
                    <span class="input-group-addon">密码</span>
                    <input id="loginPsw" type="text" class="form-control" placeholder="请输入密码">
                </div>
                <div style="margin-top: 10px;">
                    <label>
                        <input id="rememberMe" type="checkbox">记住我
                    </label>
                    <span id="loginMessage" class="bg-danger pull-right"></span>
                </div>

            </div>

            <div class="modal-footer">
                <button id="findPswBtn" type="button" class="btn btn-default" data-dismiss="modal">
                    忘记密码
                </button>
                <button id="login" type="button" class="btn btn-primary" onclick="login('<%=request.getContextPath()%>')">登录</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="registerModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">注册</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <span class="input-group-addon">账号</span>
                    <input id="registerPhone" type="text" class="form-control" placeholder="请输入手机号码">
                </div>
                <div class="input-group" style="margin-top: 10px;">
                    <span class="input-group-addon">密码</span>
                    <input id="registerPsw1" type="text" class="form-control" placeholder="请输入密码">
                </div>
                <div class="input-group" style="margin-top: 10px;">
                    <span class="input-group-addon">确认密码</span>
                    <input id="registerPsw2" type="text" class="form-control" placeholder="请再次输入密码">
                </div>
                <div style="margin-top: 10px;">
                    <span id="registerMessage" class="bg-danger pull-right"></span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="register" type="button" class="btn btn-primary" onclick="register('<%=request.getContextPath()%>')">注册</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script src="<%=request.getContextPath()%>/js/account.js" type="text/javascript"></script>
<script>
    var rememberMeCookie = $.cookie('rememberMe');
    var phoneCookie = $.cookie('loginPhone');
    var pswCookie = $.cookie('loginPsw');
    function login(ctx){
        account.login(ctx);
    }
    function register(ctx){
        account.register(ctx);
    }
    function logout(ctx){
        account.logout(ctx);
    }
    function showLoginModal(){
        account.showLoginModal(rememberMeCookie, phoneCookie, pswCookie);
    }
    function showRegisterModal(){
        account.showRegisterModal();
    }
</script>