<%@ page import="com.appstore.dto.Page" %>
<%@ page import="com.appstore.entity.App" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appstore.entity.Picture" %>
<%@ page import="com.appstore.entity.Type" %>
<%@ page import="com.appstore.entity.Carousel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--3-->
<%
    Page indexPage=(Page)request.getAttribute("resultPage");
    List<Type> typeList=indexPage.getTypeList();
    List<App> quantityAppList=indexPage.getQuantityAppList();
    List<Picture> quantityAppLogoList=indexPage.getQuantityLogoList();
    List<App> qualityAppList=indexPage.getQualityAppList();
    List<Picture> qualityLogoList=indexPage.getQualityLogoList();
    List<Carousel> carouselList=indexPage.getCarouselList();
    int carouselListSize=carouselList.size();
%>
<div class="container">
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000">
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <%for (int i=1;i<carouselListSize;++i){%>
            <li data-target="#carousel-example-generic" data-slide-to="<%=i%>"></li>
            <%}%>
        </ol>
        <div class="carousel-inner" role="listbox">
        <%if (carouselListSize>0){%>
            <div class="item active">
                <a href="/clientCenter/app/detail/<%=carouselList.get(0).getAppId()%>"><img src="<%=carouselList.get(0).getPicPath()+carouselList.get(0).getPicName()%>" alt="0"></a>
            </div>
            <%for (int i=1;i<carouselListSize;++i){%>
            <div class="item">
                <a href="/clientCenter/app/detail/<%=carouselList.get(i).getAppId()%>"><img src="<%=carouselList.get(i).getPicPath()+carouselList.get(i).getPicName()%>" alt="<%=i%>"></a>
            </div>
            <%}%>
        <%}else{%>
        <div class="item active">
           <img src="/upload/noCarousel.png" alt="0">
        </div>
        <%}%>
        </div>
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<div class="container" style="margin-top: 20px;">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">分类</h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <%for (int i=0;i<typeList.size();++i){%>
                <div class="col-sm-2" style="text-align: center">
                    <a href="/clientCenter/app/type/1?typeId=<%=typeList.get(i).getId()%>" class="thumbnail" style="text-decoration: none">
                        <%=typeList.get(i).getTypeName()%>
                    </a>
                </div>
                <%}%>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><span>精选排行榜</span><span class="pull-right"><a href="/clientCenter/app/quantity/1" style="text-decoration: none">更多</a></span></h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <%for (int i=0;i<quantityAppList.size() && i<12;++i){
                Picture picture=quantityAppLogoList.get(i);%>
                <div class="col-md-2" style="text-align: center">
                    <div class="thumbnail">
                        <a href="/clientCenter/app/detail/<%=quantityAppList.get(i).getId()%>">
                        <img src="<%=picture.getPicPath()+picture.getPicName()%>" alt="logoPic" style="width: 100px;height: 100px;">
                        <div class="caption">
                            <h3><%=quantityAppList.get(i).getAppName()%></h3>
                        </div>
                        </a>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><span>下载排行版</span><span class="pull-right"><a href="/clientCenter/app/quality/1" style="text-decoration: none">更多</a></span></h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <%for (int i=0;i<qualityAppList.size() && i<12;++i){%>
                <div class="col-md-2" style="text-align: center">
                    <div class="thumbnail">
                        <a href="/clientCenter/app/detail/<%=qualityAppList.get(i).getId()%>">
                        <img src="<%=qualityLogoList.get(i).getPicPath()+qualityLogoList.get(i).getPicName()%>" alt="logoPic" style="width: 100px;height: 100px;">
                        <div class="caption">
                            <h3><%=qualityAppList.get(i).getAppName()%></h3>
                        </div>
                    </a>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>