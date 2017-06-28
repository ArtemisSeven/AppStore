<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appstore.entity.Type" %>
<%@ page import="com.appstore.entity.App" %>
<%@ page import="com.appstore.entity.Picture" %>
<%@ page import="com.appstore.dto.Page" %>
<%@ page import="com.appstore.entity.Carousel" %><%--
  Created by IntelliJ IDEA.
  User: chenyuexiao
  Date: 16/11/14
  Time: 上午1:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/tag.jsp" %>
<html>
<head>
    <title>首页</title>
    <%@include file="../common/head.jsp" %>
</head>
<body>
<jsp:include page="../jsp/navigator.jsp"/>

<!--2-->
<div class="container">
    <!-- 选项卡组件（菜单项nav-pills）-->
    <ul id="nav-tabs" class="nav nav-tabs" role="tablist">
        <li onclick="firstAppPage()"><a id="appTab" href="#app" role="tab" data-toggle="pill">App管理模块&nbsp;&nbsp;<span
                class="glyphicon glyphicon-th-large"></span></a></li>
        <li onclick="firstCarouselPage()"><a id="carouselTab" href="#carousel" role="tab" data-toggle="pill">Carousel管理模块&nbsp;&nbsp;<span
                class="glyphicon glyphicon-sound-stereo"></span></a></li>
        <li onclick="firstTypePage()"><a id="typeTab" href="#type" role="tab" data-toggle="pill">类别管理模块&nbsp;&nbsp;<span
                class="glyphicon glyphicon-tags"></span></a></li>
    </ul>
    <!-- 选项卡面板 -->
    <% Page resultPage = (Page) request.getAttribute("resultPage");
        String pageTab = resultPage.getPageTab().toString();
        System.out.println("pageTab" + pageTab);
        int totalPages = resultPage.getTotalPages();
        int currentPage = resultPage.getCurrentPage();
        int count;
        String keyword = resultPage.getKeyword();
        int pageIndexSize = 5;//显示几个页码
    %>
    <div id="tabContent" class="tab-content">
        <div class="tab-pane fade in active" id="app">
            <%if (pageTab.equals("APP")) {%>
            <div class="row" style="margin-top: 20px;">
                <%
                    List<App> appList = resultPage.getDataList();
                    List<Picture> logoList = resultPage.getLogoList();
                    List<Picture> displaysList = resultPage.getDisplaysList();
                    String appState = resultPage.getAppState();
                    int allTypeSize=resultPage.getAllType().size();
                    System.out.println("APP COME IN:" + appList.size());
                %>
                <form class="form-inline  col-md-10" role="search" method="get" action="/managerCenter/1/appPage">
                    <div class="form-group">
                        <span class="glyphicon glyphicon-search"></span>
                        <%--传递page.stateSelected给jq控制选中--%>
                        <label for="appState">app状态</label>
                        <select name="appState" id="appState" class="form-control">
                            <option id="all" value="ALL">全部</option>
                            <option id="on" value="ON">已上传</option>
                            <option id="off" value="OFF">未上传</option>
                        </select>
                        <%--传递page.keyword给jq控制显示--%>
                        <input name="keyword" id="appKeyword" type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索app</button>
                </form>
                <div class=" col-md-2">
                    <button class="btn btn-default" id="showUpload" onclick="showUploadModal(<%=allTypeSize%>)">
                        上传app&nbsp;&nbsp;<span class="glyphicon glyphicon-upload"></span>
                    </button>

                </div>
            </div>
            <div class="panel panel-default" style="margin-top: 20px;">
                <div class="panel-heading">
                    <h3 class="panel-title">app列表</h3>
                </div>
                <div class="panel-body">
                    <% for (int j = 0; j < appList.size(); ++j) {
                        App app = appList.get(j);
                        Picture logo = logoList.get(j);
                        Picture display1 = displaysList.get(j * 4);
                        Picture display2 = displaysList.get(j * 4 + 1);
                        Picture display3 = displaysList.get(j * 4 + 2);
                        Picture display4 = displaysList.get(j * 4 + 3);
                        String typeName="未知";
                        for (Type t:resultPage.getAllType()) {
                            if (t.getId()==app.getTypeId()){
                                typeName=t.getTypeName();
                            }
                        }
                    %>
                    <div class="col-md-6">
                        <div class="thumbnail">
                            <%if (logo != null) {%><img style="width:100px;height: 100px;"
                                                        src="<%=logo.getPicPath()+logo.getPicName()%>"
                                                        alt="logoPic"><%} else {%><img src="/upload/b.png" alt="logoPic"
                                                                                       style="width:100px;height: 100px;"><%}%>
                            <div class="caption">
                                <h4>名称:<%=app.getAppName()%></h4>
                                <p>
                                    <strong>展示图片:</strong><br/>
                                    <%if (display1 != null) {%><img
                                        src="<%=display1.getPicPath()+display1.getPicName()%>" alt="displayPic"
                                        style="width:120px;height: 200px;"><%} else {%><img src="/upload/b.png"
                                                                                            alt="displayPic"
                                                                                            style="width:120px;height: 200px;"><%}%>
                                    <%if (display2 != null) {%><img
                                        src="<%=display2.getPicPath()+display2.getPicName()%>" alt="displayPic"
                                        style="width:120px;height: 200px;"><%} else {%><img src="/upload/b.png"
                                                                                            alt="displayPic"
                                                                                            style="width:120px;height: 200px;"><%}%>
                                    <%if (display3 != null) {%><img
                                        src="<%=display3.getPicPath()+display3.getPicName()%>" alt="displayPic"
                                        style="width:120px;height: 200px;"><%} else {%><img src="/upload/b.png"
                                                                                            alt="displayPic"
                                                                                            style="width:120px;height: 200px;"><%}%>
                                    <%if (display4 != null) {%><img
                                        src="<%=display4.getPicPath()+display4.getPicName()%>" alt="displayPic"
                                        style="width:120px;height: 200px;"><%} else {%><img src="/upload/b.png"
                                                                                            alt="displayPic"
                                                                                            style="width:120px;height: 200px;"><%}%>
                                </p>
                                <%if (app.getState().equals("ON")) {%><p><strong>状态:</strong>已上架</p><%} else {%><p><strong>状态:</strong>未上架</p><%}%>
                                <p><strong>分类:</strong><%=typeName%></p>
                                <%if (app.getCompany() != "") {%><p><strong>出品公司:</strong><%=app.getCompany()%></p><%} else {%><p><strong>出品公司:</strong>待完善</p><%}%>
                                <%if (app.getOs() != "") {%><p><strong>适用系统:</strong><%=app.getOs()%></p><%} else {%><p><strong>适用系统:</strong>待完善</p><%}%>
                                <%if (app.getVersion() != "") {%><p><strong>版本:</strong><%=app.getVersion()%></p><%} else {%><p><strong>版本:</strong>待完善</p><%}%>
                                <%if (app.getDescription() != "") {
                                %><p style="height:200px; overflow: hidden"><strong>应用描述:</strong><%=app.getDescription()%></p>
                                <p>....</p>
                                <%} else {%><p><strong>应用描述:</strong>待完善</p><%}%>

                                <% String _appFileName = "null";
                                    String _logo = "null";
                                    String _d1 = "null";
                                    String _d2 = "null";
                                    String _d3 = "null";
                                    String _d4 = "null";
                                    String _version = "null";
                                    String _os = "null";
                                    String _company = "null";
                                    String _description = "null";
                                    if (logo != null) {
                                        _logo = logo.getPicPath() + logo.getPicName();
                                    }
                                    if (display1 != null) {
                                        _d1 = display1.getPicPath() + display1.getPicName();
                                    }
                                    if (display2 != null) {
                                        _d2 = display2.getPicPath() + display2.getPicName();
                                    }
                                    if (display3 != null) {
                                        _d3 = display3.getPicPath() + display3.getPicName();
                                    }
                                    if (display4 != null) {
                                        _d4 = display4.getPicPath() + display4.getPicName();
                                    }
                                    if (app.getVersion() != "") {
                                        _version = app.getVersion();
                                    }
                                    if (app.getOs() != "") {
                                        _os = app.getOs();
                                    }
                                    if (app.getCompany() != "") {
                                        _company = app.getCompany();
                                    }
                                    if (app.getDescription() != "") {
                                        _description = app.getDescription();
                                    }
                                    if (app.getFileName() != "") {
                                        _appFileName = app.getFileName();
                                    }
                                %>
                                <br/>
                                <p>
                                    <button onclick="showUpdateAppModal(<%=app.getId()%>,'<%=_appFileName%>','<%=_logo%>','<%=_d1%>','<%=_d2%>','<%=_d3%>','<%=_d4%>','<%=app.getAppName()%>','<%=_version%>','<%=_os%>',<%=app.getTypeId()%>,'<%=_company%>','<%=_description%>')"
                                            class="btn btn-info" role="button">更新
                                    </button>
                                    <button onclick="deleteApp(<%=app.getId()%>)" class="btn btn-info" role="button">
                                        删除
                                    </button>
                                    <%if (app.getState().equals("ON")) {%><a
                                        href="/clientCenter/app/detail/<%=app.getId()%>" class="btn btn-info"
                                        role="button">查看详情</a><%}%>
                                </p>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="container">
                <div class="center-block" style="width:400px;">
                    <ul class="pagination">
                        <%
                            count = 0;
                            if (currentPage > 1) {%>
                        <li>
                            <a href="<%="/managerCenter/"+(currentPage-1)+"/appPage?keyword="+keyword+"&appState="+appState%>">上一页</a>
                        </li>
                        <%
                            }
                            for (int j = currentPage - 2; j <= totalPages && count < pageIndexSize; ++j) {
                                if (j >= 1) {
                                    if (j == currentPage) {
                        %>
                        <li><a href="<%="/managerCenter/"+j+"/appPage?keyword="+keyword+"&appState="+appState%>"
                               style="color: #f92050"><%=j%>
                        </a></li>
                        <%} else {%>
                        <li><a href="<%="/managerCenter/"+j+"/appPage?keyword="+keyword+"&appState="+appState%>"><%=j%>
                        </a></li>
                        <%
                                    }
                                    count++;
                                }
                            }
                            if (currentPage < totalPages) {
                        %>
                        <li>
                            <a href="<%="/managerCenter/"+(currentPage+1)+"/appPage?keyword="+keyword+"&appState="+appState%>">下一页</a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <%}%>
        </div>


        <div class="tab-pane fade" id="carousel">
            <%if (pageTab.equals("CAROUSEL")) {%>
            <div class="row" style="margin-top: 20px;">
                <div class="col-md-2 pull-right">
                    <button class="btn btn-default" id="showAddCarousel" onclick="showAddCarouselModal(<%=resultPage.getChoseApps().size()%>)">
                        添加app至carousel&nbsp;&nbsp;<span class="glyphicon glyphicon-expand"></span>
                    </button>

                </div>
            </div>
            <%
                List<Carousel> carouselList = resultPage.getDataList();
                List<String> appNamesList = resultPage.getAppNames();
                System.out.println("CAR COME IN:" + carouselList.size());
            %>
            <div class="panel panel-default" style="margin-top: 20px;">
                <div class="panel-heading">
                    <h3 class="panel-title">当前Carousel</h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <%
                            for (int i = 0; i < carouselList.size(); ++i) {
                                Carousel carousel = carouselList.get(i);
                                String appName = appNamesList.get(i);
                        %>
                        <div class="col-md-6">
                            <div class="thumbnail">
                                <img src="<%=carousel.getPicPath()+carousel.getPicName()%>" alt="carouselPic">
                                <div class="caption">
                                    <h3><%=appName%>
                                    </h3>
                                    <p>
                                        <button onclick="showUpdateCarouselModal(<%=carousel.getId()%>)"
                                                class="btn  btn-primary" role="button">更换图片
                                        </button>
                                        <button onclick="deleteCarousel(<%=carousel.getId()%>)" class="btn btn-default"
                                                role="button">删除
                                        </button>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="center-block" style="width:400px;">
                    <ul class="pagination">
                        <%
                            count = 0;
                            if (currentPage > 1) {%>
                        <li>
                            <a href="<%="/managerCenter/"+(currentPage-1)+"/carouselPage"%>">上一页</a>
                        </li>
                        <%
                            }
                            for (int j = currentPage - 2; j <= totalPages && count < pageIndexSize; ++j) {
                                if (j >= 1) {
                                    if (j == currentPage) {
                        %>
                        <li><a href="<%="/managerCenter/"+j+"/carouselPage"%>"
                               style="color: #f92050"><%=j%>
                        </a></li>
                        <%} else {%>
                        <li><a href="<%="/managerCenter/"+j+"/carouselPage"%>"><%=j%>
                        </a></li>
                        <%
                                    }
                                    count++;
                                }
                            }
                            if (currentPage < totalPages) {
                        %>
                        <li>
                            <a href="<%="/managerCenter/"+(currentPage+1)+"/carouselPage"%>">下一页</a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <%}%>
        </div>


        <div class="tab-pane fade" id="type">
            <%if (pageTab.equals("TYPE")) {%>
            <div class="row" style="margin-top: 20px;">
                <form class="form-inline  col-md-10" role="search" action="/managerCenter/1/typePage" method="get">
                    <div class="form-group">
                        <span class="glyphicon glyphicon-search"></span>
                        <input id="typeKeyword" name="keyword" type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索类别</button>
                </form>
                <div class="col-md-2">
                    <button class="btn btn-default" id="showAddType">
                        添加类别
                        <span class="glyphicon glyphicon-tag"></span>
                    </button>
                </div>
            </div>
            <table class="table table-bordered table-striped" style="margin-top: 20px;">
                <thead>
                <tr>
                    <th>类别名称</th>
                    <th colspan="2">操作</th>
                </tr>
                </thead>
                <tbody id="typeTable">
                <%

                    List<Type> typeList = resultPage.getDataList();
                    List<Integer> typeAppSize = resultPage.getTypeAppSize();
                    for (int j = 0; j < typeList.size(); ++j) {
                        Type type = typeList.get(j);%>
                <tr>
                    <td><%=type.getTypeName()%>
                    </td>
                    <td><span class="changeTypeNameNode" style="color: #6c68af">更名</span></td>
                    <hide><a id="deleteTypeA" style="visibility: hidden;"><span id="deleteTypeLink">隐藏删除</span></a></hide>
                    <td><span
                            onclick="checkTypeNull(<%=typeAppSize.get(j)%>,<%=currentPage%>,<%=type.getId()%>)">删除</span>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <div class="container">
                <div class="center-block" style="width:400px;">
                    <ul class="pagination">
                        <%
                            count = 0;
                            if (currentPage > 1) {%>
                        <li><a href="<%="/managerCenter/"+(currentPage-1)+"/typePage?keyword="+keyword%>">上一页</a></li>
                        <%
                            }
                            for (int j = currentPage - 2; j <= totalPages && count < pageIndexSize; ++j) {
                                if (j >= 1) {
                                    if (j == currentPage) {
                        %>
                        <li><a href="<%="/managerCenter/"+j+"/typePage?keyword="+keyword%>"
                               style="color: #f92050"><%=j%>
                        </a></li>
                        <%} else {%>
                        <li><a href="<%="/managerCenter/"+j+"/typePage?keyword="+keyword%>"><%=j%>
                        </a></li>
                        <%
                                    }
                                    count++;
                                }
                            }
                            if (currentPage < totalPages) {
                        %>
                        <li><a href="<%="/managerCenter/"+(currentPage+1)+"/typePage?keyword="+keyword%>">下一页</a></li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <%}%>
        </div>

    </div>

</div>
<!--2-->

<%--上传弹窗--%>
<div id="uploadModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">上传app</h4>
            </div>
            <div class="modal-body">
                <form id="appForm0" role="form" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="appFile0">app文件</label><span id="appFileMessage0" class="appMessage0 text-danger"></span>
                        <input id="appFile0" name="appFile" type="file" style="width: 140px;">
                        <p id="appFileNameCache0"></p>
                        <p class="help-block">请选择app的安装包文件</p>
                    </div>
                    <div class="form-group">
                        <label for="logoFile0">logo图片</label><span id="logoFileMessage0" class="appMessage0 text-danger"></span>
                        <input id="logoFile0" name="logoFile" type="file" style="width: 140px;"
                               onchange="showPicCache0('logo',this)">
                        <p><img id="logoPicCache0" style="width: 100px;height: 100px;"/></p>
                        <p class="help-block">请选择1张规格为200*200的图片作为logo</p>
                    </div>
                    <div class="form-group">
                        <label>预览图片</label>
                        <input type="file" id="displayFile10" name="displayFile" onchange="showPicCache0('display1',this)"
                               style="width: 140px;"><span id="displayFileMessage10"
                                                           class="appMessage0 text-danger"></span>
                        <input type="file" id="displayFile20" name="displayFile" onchange="showPicCache0('display2',this)"
                               style="width: 140px;"><span id="displayFileMessage20"
                                                           class="appMessage0 text-danger"></span>
                        <input type="file" id="displayFile30" name="displayFile" onchange="showPicCache0('display3',this)"
                               style="width: 140px;"><span id="displayFileMessage30"
                                                           class="appMessage0 text-danger"></span>
                        <input type="file" id="displayFile40" name="displayFile" onchange="showPicCache0('display4',this)"
                               style="width: 140px;"><span id="displayFileMessage40"
                                                           class="appMessage0 text-danger"></span>
                        <p>
                            <img id="displayPicCache10" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache20" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache30" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache40" style="width: 100px;height: 200px;"/></p>
                        <p class="help-block">请选择4张规格为200*400的图片供用户预览app界面</p>
                    </div>
                    <div class="form-group">
                        <label for="appName0">app名称</label><span id="appNameMessage0"
                                                                 class="appMessage0 text-danger"></span>
                        <input id="appName0" name="appName" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="version0">app版本</label><span id="versionMessage0"
                                                                 class="appMessage0 text-danger"></span>
                        <input id="version0" name="version" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="os0">适用系统</label><span id="osMessage0"
                                                                 class="appMessage0 text-danger"></span>
                        <input id="os0" name="os" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="typeId0">app类别</label>
                        <select name="typeId" class="form-control" id="typeId0">
                            <c:forEach var="type" items="${resultPage.allType}">
                                <option value="${type.id}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="company0">出品公司</label><span id="companyMessage0"
                                                                class="appMessage0 text-danger"></span>
                        <input id="company0" name="company" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="description0">app简介</label><span id="descriptionMessage0"
                                                                     class="appMessage0 text-danger"></span>
                        <textarea id="description0" name="description" class="form-control"></textarea>
                    </div>
                    <hide><input  name="oldAppId" style="visibility: hidden;" value="-1"/></hide>
                </form>
            </div>
            <div class="modal-footer">
                <span id="saveAppBtn0" onclick="uploadButSaveApp()" class="btn btn-primary">保存</span>
                <span id="uploadAppBtn0" onclick="uploadApp()" class="btn btn-primary">上架</span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 上传弹窗-->

<%--更新弹窗--%>
<div id="updateModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">更新app</h4>
            </div>
            <div class="modal-body">
                <form id="appForm" role="form" method="post" enctype="multipart/form-data">
                    <hide><input id="oldAppId" name="oldAppId" style="visibility: hidden;" value="-1"/></hide>
                    <div class="form-group">
                        <label for="appFile">app文件</label><span id="appFileMessage"
                                                                class="appMessage text-danger"></span>
                        <input id="appFile" name="appFile" type="file" style="width: 140px;">
                        <p id="appFileNameCache"></p>
                        <p class="help-block">请选择app的安装包文件</p>
                    </div>
                    <div class="form-group">
                        <label for="logoFile">logo图片</label><span id="logoFileMessage"
                                                                  class="appMessage text-danger"></span>
                        <input id="logoFile" name="logoFile" type="file" style="width: 140px;"
                               onchange="showPicCache('logo',this)">
                        <p><img id="logoPicCache" style="width: 100px;height: 100px;"/></p>
                        <p class="help-block">请选择1张规格为200*200的图片作为logo</p>
                    </div>
                    <div class="form-group">
                        <label>预览图片</label>
                        <input type="file" id="displayFile1" name="displayFile" onchange="showPicCache('display1',this)"
                               style="width: 140px;"><span id="displayFileMessage1"
                                                           class="appMessage text-danger"></span>
                        <input type="file" id="displayFile2" name="displayFile" onchange="showPicCache('display2',this)"
                               style="width: 140px;"><span id="displayFileMessage2"
                                                           class="appMessage text-danger"></span>
                        <input type="file" id="displayFile3" name="displayFile" onchange="showPicCache('display3',this)"
                               style="width: 140px;"><span id="displayFileMessage3"
                                                           class="appMessage text-danger"></span>
                        <input type="file" id="displayFile4" name="displayFile" onchange="showPicCache('display4',this)"
                               style="width: 140px;"><span id="displayFileMessage4"
                                                           class="appMessage text-danger"></span>
                        <p><img id="displayPicCache1" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache2" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache3" style="width: 100px;height: 200px;"/>
                            <img id="displayPicCache4" style="width: 100px;height: 200px;"/></p>
                        <p class="help-block">请选择4张规格为200*400的图片供用户预览app界面</p>
                    </div>
                    <div class="form-group">
                        <label for="appName">app名称</label><span id="appNameMessage"
                                                                class="appMessage text-danger"></span>
                        <input id="appName" name="appName" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="version">app版本</label><span id="versionMessage"
                                                                class="appMessage text-danger"></span>
                        <input id="version" name="version" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="os">适用系统</label><span id="osMessage"
                                                           class="appMessage0 text-danger"></span>
                        <input id="os" name="os" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="type">app类别</label>
                        <select name="typeId" class="form-control" id="typeId">
                            <c:forEach var="type" items="${resultPage.allType}">
                                <option value="${type.id}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="company">出品公司</label><span id="companyMessage"
                                                               class="appMessage text-danger"></span>
                        <input id="company" name="company" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="description">app简介</label><span id="descriptionMessage"
                                                                    class="appMessage text-danger"></span>
                        <textarea id="description" name="description" class="form-control"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span id="saveAppBtn" onclick="updateButSaveApp()" class="btn btn-primary">保存</span>
                <span id="uploadAppBtn" onclick="updateApp()" class="btn btn-primary">上传</span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 更新弹窗-->


<%--carousel弹窗--%>
<div class="modal fade" id="addCarouselModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">添加app至carousel</h4>
            </div>
            <div class="modal-body">
                <form id="carouselForm" role="form" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="choseApps">app列表</label>
                        <select class="form-control" id="choseApps" name="linkAppId">
                            <c:forEach items="${resultPage.choseApps}" var="app">
                                <option value="${app.id}">${app.appName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="carouselFile">logo图片</label><span id="carouselFileMessage"
                                                                      class="text-danger"></span>
                        <input id="carouselFile" name="carouselFile" type="file" style="width: 140px;"
                               onchange="showPicCache('carousel',this)">
                        <img id="carouselPicCache" style="width: 300px;height: 200px;"/>
                        <p class="help-block">请选择1张规格为200*200的图片用于展示</p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span id="saveCarouselBtn" onclick="saveCarousel()" class="btn btn-primary">添加</span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal carousel弹窗-->


<%--添加类型弹窗--%>
<div class="modal fade" id="addTypeModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">添加app类别</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="newType">类别名称</label>
                    <input id="newType" type="text" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <span id="typeMessage" class="bg-danger"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addType" type="button" class="btn btn-primary">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 类型弹窗-->


<%--改变类型弹窗--%>
<div class="modal fade" id="changeTypeModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">更改类别名称</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="newType">类别名称</label>
                    <input id="changeTypeName" type="text" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <span id="changeTypeMessage" class="bg-danger"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="changeTypeBtn" type="button" class="btn btn-primary">更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 类型弹窗-->

<%--提示信息弹窗--%>
<div class="modal fade" id="tipsModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <p id="tipsMessage"></p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a id="tipsEnterBtn" type="button" class="btn btn-primary">确定</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 提示信息弹窗-->


<%--更换carousel图片弹窗--%>
<div class="modal fade" id="updateCarouselModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">更换carousel图片</h4>
            </div>
            <div class="modal-body">
                <form id="updateCarouselForm" role="form" method="post" enctype="multipart/form-data"
                      action="/managerCenter/carousel/update">
                    <div class="form-group">
                        <label for="newCarouselFile">carousel图片</label><span id="newCarouselFileMessage"
                                                                             class="text-danger"></span>
                        <input id="newCarouselFile" name="newCarouselFile" type="file" style="width: 140px;">
                        <img id="newCarouselPicCache"/>
                        <p class="help-block">请选择1张规格为200*200的图片用于展示<input id="carouselId" name="carouselId"
                                                                           style="visibility: hidden"
                                                                           onchange="showPicCache('newCarousel',this)"/>
                        </p>

                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="updateCarouselBtn" onclick="updateCarousel()" type="button" class="btn btn-primary">确定
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal 更换carousel图片弹窗-->
<hide>
    <a href="/managerCenter/1/appPage?appState=ALL&keyword=" style="visibility: hidden;"><span
            id="getAppPage1">app</span></a>
    <a href="/managerCenter/1/carouselPage" style="visibility: hidden;"><span id="getCarouselPage1">car</span></a>
    <a href="/managerCenter/1/typePage?keyword=" style="visibility: hidden;"><span id="getTypePage1">type</span></a>
</hide>


</body>
</html>
<script src="/js/manager.js" type="text/javascript"></script>
<script>
    function firstAppPage() {
        $('#getAppPage1').click();
    }
    function firstCarouselPage() {
        $('#getCarouselPage1').click();
    }
    function firstTypePage() {
        $('#getTypePage1').click();
    }
    function checkTypeNull(size,currentPage,typeId) {
        if (size == 0) {
//            alert('准备删除');
            var href = '/managerCenter/' + currentPage + '/' + typeId + '/delete?keyword=';
            $('#deleteTypeA').attr('href',href);
            $('#deleteTypeLink').click();
        } else {
            alert('请先删除该类型下的所有app');
        }
    }
    function uploadButSaveApp() {
        manager.app.uploadButSaveApp();
    }
    function updateButSaveApp() {
        manager.app.updateButSaveApp();
    }
    function showUploadModal(allTypeSize){
        manager.app.showUploadModal(allTypeSize);
    }
    function uploadApp() {
        manager.app.uploadApp();
    }
    function updateApp(){
        manager.app.updateApp();
    }
    function showUpdateAppModal(appId,appFileName,logo,d1,d2,d3,d4,appName,version,os,typeId,company,description) {
//    function showUpdateAppModal() {
        manager.app.showUpdateAppModal(appId,appFileName,logo,d1,d2,d3,d4,appName,version,os,typeId,company,description);
    }
    function deleteApp(appId) {
        manager.app.deleteApp(appId);
    }
    function saveCarousel() {
        manager.carousel.addCarousel();
    }
    function deleteCarousel(carouselId) {
        manager.carousel.deleteCarousel(carouselId);
    }
    function (carouselId) {
        manager.carousel.showUpdateCarouselModal(carouselId);
    }
    function updateCarousel() {
        manager.carousel.updateCarousel();
    }
    function showAddCarouselModal(appSize){
        manager.carousel.showAddCarouselModal(appSize);
    }
    function showPicCache0(name, file) {
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                switch (name) {
                    case 'logo':
                        $('#logoPicCache0').attr('src', evt.target.result);
                        break;
                    case 'display1':
                        $('#displayPicCache10').attr('src', evt.target.result);
                        break;
                    case 'display2':
                        $('#displayPicCache20').attr('src', evt.target.result);
                        break;
                    case 'display3':
                        $('#displayPicCache30').attr('src', evt.target.result);
                        break;
                    case 'display4':
                        $('#displayPicCache40').attr('src', evt.target.result);
                        break;
                    case 'carousel':
                        $('#carouselPicCache0').attr('src', evt.target.result);
                        break;
                    case 'newCarousel':
                        $('#newCarouselPicCache0').attr('src', evt.target.result);
                        break;
                }
            };
            reader.readAsDataURL(file.files[0]);
        }
    }
    function showPicCache(name, file) {
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                switch (name) {
                    case 'logo':
                        $('#logoPicCache').attr('src', evt.target.result);
                        break;
                    case 'display1':
                        $('#displayPicCache1').attr('src', evt.target.result);
                        break;
                    case 'display2':
                        $('#displayPicCache2').attr('src', evt.target.result);
                        break;
                    case 'display3':
                        $('#displayPicCache3').attr('src', evt.target.result);
                        break;
                    case 'display4':
                        $('#displayPicCache4').attr('src', evt.target.result);
                        break;
                    case 'carousel':
                        $('#carouselPicCache').attr('src', evt.target.result);
                        break;
                    case 'newCarousel':
                        $('#newCarouselPicCache').attr('src', evt.target.result);
                        break;
                }
            };
            reader.readAsDataURL(file.files[0]);
        }
    }
    $(function () {
        if (${resultPage.pageTab eq "TYPE"}) {
            manager.type.initTypePage({
                dataListSize:${fn:length(resultPage.dataList)}, keyword: "${resultPage.keyword}"
            });
        }
        else {
            if (${resultPage.pageTab eq "APP"}) {
                manager.app.initAppPage({
                    appState: "${resultPage.appState}", keyword: "${resultPage.keyword}"
                });
            }
            else {
                manager.carousel.initCarouselPage();
            }
        }
    });
</script>
