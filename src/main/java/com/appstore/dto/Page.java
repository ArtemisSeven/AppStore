package com.appstore.dto;

import com.appstore.entity.*;
import com.appstore.enums.PageTab;

import java.util.List;

public class Page {
    private Enum<PageTab> pageTab;//Common
    private String keyword;//Common
    private int totalPages;//Common
    private int currentPage;//Common
    private List dataList;//Common
//    private int pageSize;

    private List<Integer> typeAppSize;

    private String appState;//APP
    private List<Picture> logoList;//APP
    private List<Picture> displaysList;//APP
    private List<Type> allType;//APP

    private List<String> appNames;//carousel
    private List<App> choseApps;//carousel

    private List<Carousel> carouselList;//indexPage
    private List<Type> typeList;//indexPage
    private List<App> quantityAppList;//indexPage
    private List<Picture> quantityLogoList;//indexPage
    private List<App> qualityAppList;//indexPage
    private List<Picture> qualityLogoList;//indexPage

    private List<App> appList;//searchAppByName

    private Type type;//typeApp

    private App app;//appDetail
    private String typeName;//appDetail
    private Picture logo;//appDetail
    private List<Comment> commentList;
    private List<Long> userPhoneList;

    public Page() {}

    //indexPage
    public Page(List<Carousel> carouselList,List<Type> typeList,List<App> quantityAppList,List<Picture> quantityLogoList,List<App> qualityAppList,List<Picture> qualityLogoList){
        this.carouselList=carouselList;
        this.typeList=typeList;
        this.quantityAppList=quantityAppList;
        this.quantityLogoList=quantityLogoList;
        this.qualityAppList=qualityAppList;
        this.qualityLogoList=qualityLogoList;
    }
    //typeApp
    public Page(PageTab pageTab,Type type,List<App> appList,List<Picture> logoList,int currentPage,int totalPages){
        this.pageTab=pageTab;
        this.type=type;
        this.appList=appList;
        this.logoList=logoList;
        this.currentPage=currentPage;
        this.totalPages=totalPages;
    }
    //searchAppByName
    public Page(PageTab pageTab,String keyword,List<App> appList,List<Picture> logoList,int currentPage,int totalPages){
        this.pageTab=pageTab;
        this.keyword=keyword;
        this.appList=appList;
        this.logoList=logoList;
        this.currentPage=currentPage;
        this.totalPages=totalPages;
    }
    //quantity quality
    public Page(PageTab pageTab,List<App> appList,List<Picture> logoList,int currentPage,int totalPages){
        this.pageTab=pageTab;
        this.appList=appList;
        this.logoList=logoList;
        this.currentPage=currentPage;
        this.totalPages=totalPages;
    }

    //appDetail
    public Page(App app, String typeName, Picture logo, List<Picture> displaysList, List<Comment> commentList,List<Long> userPhoneList){
        this.app=app;
        this.typeName=typeName;
        this.logo=logo;
        this.displaysList=displaysList;
        this.commentList=commentList;
        this.userPhoneList=userPhoneList;
    }


    //myInfo
    public Page(List<Comment> commentList,List<String> appNames){
        this.commentList=commentList;
        this.appNames=appNames;
    }
    //TYPE
    public Page(Enum<PageTab> pageTab,String keyword, int totalPages, int currentPage, List dataList,List<Integer> typeAppSize) {
        this.pageTab = pageTab;
        this.keyword = keyword;
        this.totalPages = totalPages;
        this.currentPage = currentPage;
        this.dataList = dataList;
        this.typeAppSize=typeAppSize;
    }

    //APP
    public Page(Enum<PageTab> pageTab, String appState, String keyword, int totalPages, int currentPage, List dataList, List<Picture> logoList,List<Picture> displaysList, List<Type> allType) {
        this.pageTab = pageTab;
        this.keyword = keyword;
        this.totalPages = totalPages;
        this.currentPage = currentPage;
        this.dataList = dataList;
        this.appState = appState;
        this.logoList = logoList;
        this.displaysList=displaysList;
        this.allType = allType;
    }

    //CAROUSEL
    public Page(Enum<PageTab> pageTab, int totalPages, int currentPage, List dataList,List<String> appNames,List<App> choseApps) {
        this.pageTab = pageTab;
        this.totalPages = totalPages;
        this.currentPage = currentPage;
        this.dataList = dataList;
        this.appNames=appNames;
        this.choseApps=choseApps;
    }

    public List<Integer> getTypeAppSize() {
        return typeAppSize;
    }

    public void setTypeAppSize(List<Integer> typeAppSize) {
        this.typeAppSize = typeAppSize;
    }

    public List<Long> getUserPhoneList() {
        return userPhoneList;
    }

    public void setUserPhoneList(List<Long> userPhoneList) {
        this.userPhoneList = userPhoneList;
    }

    public List<Comment> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<Comment> commentList) {
        this.commentList = commentList;
    }

    public App getApp() {
        return app;
    }

    public void setApp(App app) {
        this.app = app;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Picture getLogo() {
        return logo;
    }

    public void setLogo(Picture logo) {
        this.logo = logo;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public List<App> getAppList() {
        return appList;
    }

    public void setAppList(List<App> appList) {
        this.appList = appList;
    }

    public Enum<PageTab> getPageTab() {
        return pageTab;
    }

    public void setPageTab(Enum<PageTab> pageTab) {
        this.pageTab = pageTab;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public List getDataList() {
        return dataList;
    }

    public void setDataList(List dataList) {
        this.dataList = dataList;
    }

    public String getAppState() {
        return appState;
    }

    public void setAppState(String appState) {
        this.appState = appState;
    }

    public List<Picture> getLogoList() {
        return logoList;
    }

    public void setLogoList(List<Picture> logoList) {
        this.logoList = logoList;
    }

    public List<Picture> getDisplaysList() {
        return displaysList;
    }

    public void setDisplaysList(List<Picture> displaysList) {
        this.displaysList = displaysList;
    }

    public List<Type> getAllType() {
        return allType;
    }

    public void setAllType(List<Type> allType) {
        this.allType = allType;
    }

    public List<String> getAppNames() {
        return appNames;
    }

    public void setAppNames(List<String> appNames) {
        this.appNames = appNames;
    }

    public List<App> getChoseApps() {
        return choseApps;
    }

    public void setChoseApps(List<App> choseApps) {
        this.choseApps = choseApps;
    }

    public List<Carousel> getCarouselList() {
        return carouselList;
    }

    public void setCarouselList(List<Carousel> carouselList) {
        this.carouselList = carouselList;
    }

    public List<Type> getTypeList() {
        return typeList;
    }

    public void setTypeList(List<Type> typeList) {
        this.typeList = typeList;
    }

    public List<App> getQuantityAppList() {
        return quantityAppList;
    }

    public void setQuantityAppList(List<App> quantityAppList) {
        this.quantityAppList = quantityAppList;
    }

    public List<Picture> getQuantityLogoList() {
        return quantityLogoList;
    }

    public void setQuantityLogoList(List<Picture> quantityLogoList) {
        this.quantityLogoList = quantityLogoList;
    }

    public List<App> getQualityAppList() {
        return qualityAppList;
    }

    public void setQualityAppList(List<App> qualityAppList) {
        this.qualityAppList = qualityAppList;
    }

    public List<Picture> getQualityLogoList() {
        return qualityLogoList;
    }

    public void setQualityLogoList(List<Picture> qualityLogoList) {
        this.qualityLogoList = qualityLogoList;
    }
}
