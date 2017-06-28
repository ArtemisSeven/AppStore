package com.appstore.web;

import com.appstore.dto.Page;
import com.appstore.dto.ValidateAccountResult;
import com.appstore.entity.*;
import com.appstore.enums.PageTab;
import com.appstore.service.*;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/clientCenter")
public class ClientController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private TypeService typeService;
    @Autowired
    private CarouselService carouselService;
    @Autowired
    private PictureService pictureService;
    @Autowired
    private AppService appService;
    @Autowired
    private CommentService commentService;

    final int pageSize = 6;


    @RequestMapping(value = "/account/{phone}/{inOrRgs}", method = RequestMethod.POST)
    @ResponseBody
    private ValidateAccountResult validateAccount(@PathVariable("phone") Long phone, @PathVariable("inOrRgs") String inOrRgs, @RequestParam("psw") String psw, HttpSession session) {
        boolean phoneState = userService.checkPhone(phone);
        if (inOrRgs.equals("login")) {
            if (!phoneState) {
                return new ValidateAccountResult(false, false);
            } else {
                User user = userService.getUserByAccount(phone, psw);
                if (user == null) {
                    return new ValidateAccountResult(true, false);
                } else {
                    session.setAttribute("user", user);
                    return new ValidateAccountResult(true, true);
                }
            }
        } else {
            if (!phoneState) {
                User user = userService.registerAccount(phone, psw);
                if (user != null) {
                    session.setAttribute("user", user);
                    return new ValidateAccountResult(false, true);
                } else {
                    System.out.println("保存用户失败");
                    return new ValidateAccountResult(true, false);
                }
            } else {
                return new ValidateAccountResult(true, false);
            }
        }
    }

    @RequestMapping(value = "/account/logout", method = RequestMethod.GET)
    @ResponseBody
    private void logout(HttpSession session) {
        session.removeAttribute("user");
    }

    @RequestMapping(value = "/account/myInfo", method = RequestMethod.GET)
    private String getMyInfo(HttpServletRequest request,Model model) {
        makeMyInfoPage(request,model);
        return "myInfo";
    }

    private void makeMyInfoPage(HttpServletRequest request,Model model){
        User user=(User)request.getSession().getAttribute("user");
        List<Comment> commentList=commentService.getAllCommentByUserId(user.getId());
        List<String> appNames=new LinkedList<String>();
        for (int i=0;i<commentList.size();++i){
            appNames.add(appService.getNameById(commentList.get(i).getAppId()));
        }
        Page page=new Page(commentList,appNames);
        model.addAttribute("resultPage",page);
    }

    @RequestMapping(value = "/account/modifyPsw/{userId}",method = RequestMethod.POST)
    private String modifyPsw(@PathVariable("userId")long userId,String newPsw,HttpServletRequest request,Model model){
        userService.updatePsw(userId,newPsw);
        makeMyInfoPage(request,model);
        return "myInfo";
    }

    @RequestMapping(value = "/indexPage/getData", method = RequestMethod.GET)
    private String getIndexPageData(Model model) {
        List<Carousel> carouselList = carouselService.getAllCarousel();
        List<Type> typeList = typeService.getAllType();
        List<App> quantityAppList = appService.getAllAppByAvgScore();
        List<Picture> quantityLogoList = new LinkedList<Picture>();
        for (int i = 0; i < quantityAppList.size(); ++i) {
            quantityLogoList.add(pictureService.getLogoPicByAppId(quantityAppList.get(i).getId()));
        }
        List<App> qualityAppList = appService.getAllAppByDownloadCount();
        List<Picture> qualityLogoList = new LinkedList<Picture>();
        for (int i = 0; i < qualityAppList.size(); ++i) {
            qualityLogoList.add(pictureService.getLogoPicByAppId(qualityAppList.get(i).getId()));
        }
        Page indexPage = new Page(carouselList, typeList, quantityAppList, quantityLogoList, qualityAppList, qualityLogoList);

        model.addAttribute("resultPage", indexPage);
        return "realIndex";
    }

    @RequestMapping(value = "/app/search/{currentPage}", method = RequestMethod.GET)
    private String searchAppByNameKeyword(String appNameKeyword, @PathVariable("currentPage") int currentPage, Model model) {
        int totalPages = (int) Math.ceil((double) appService.searchByStateAndKeyword("ON", appNameKeyword).size() / (double) pageSize);
        List<App> appList = appService.searchByStateAndKeywordLimit((currentPage - 1) * pageSize, pageSize, "ON", appNameKeyword);
        List<Picture> logoList = new LinkedList<Picture>();
        for (int i = 0; i < appList.size(); ++i) {
            logoList.add(pictureService.getLogoPicByAppId(appList.get(i).getId()));
        }
        Page page = new Page(PageTab.SEARCH, appNameKeyword, appList, logoList, currentPage, totalPages);
        model.addAttribute("resultPage", page);
        return "searchResult";
    }

    @RequestMapping(value = "/app/type/{currentPage}", method = RequestMethod.GET)
    private String getTypeApp(@PathVariable("currentPage") int currentPage, @RequestParam("typeId") int typeId, Model model) {
        int totalPages = (int) Math.ceil((double) appService.getAllAppByTypeId(typeId).size() / (double) pageSize);
        List<App> appList = appService.getAllAppByTypeIdLimit(typeId, (currentPage - 1) * pageSize, pageSize);
        List<Picture> logoList = new LinkedList<Picture>();
        for (int i = 0; i < appList.size(); ++i) {
            logoList.add(pictureService.getLogoPicByAppId(appList.get(i).getId()));
        }
        Type type = typeService.getTypeById(typeId);
        Page page = new Page(PageTab.TYPE, type, appList, logoList, currentPage, totalPages);
        model.addAttribute("resultPage", page);
        return "searchResult";
    }

    @RequestMapping(value = "/app/quantity/{currentPage}", method = RequestMethod.GET)
    private String getQuantityApp(@PathVariable("currentPage") int currentPage, Model model) {
        int totalPages = (int) Math.ceil((double) appService.getAllAppByAvgScore().size() / (double) pageSize);
        List<App> appList = appService.getAllAppByAvgScoreLimit((currentPage - 1) * pageSize, pageSize);
        List<Picture> logoList = new LinkedList<Picture>();
        for (int i = 0; i < appList.size(); ++i) {
            logoList.add(pictureService.getLogoPicByAppId(appList.get(i).getId()));
        }
        Page page = new Page(PageTab.QUANTITY, appList, logoList, currentPage, totalPages);
        model.addAttribute("resultPage", page);
        return "searchResult";
    }

    @RequestMapping(value = "/app/quality/{currentPage}", method = RequestMethod.GET)
    private String getQualityApp(@PathVariable("currentPage") int currentPage, Model model) {
        int totalPages = (int) Math.ceil((double) appService.getAllAppByDownloadCount().size() / (double) pageSize);
        List<App> appList = appService.getAllAppByDownloadCountLimit((currentPage - 1) * pageSize, pageSize);
        List<Picture> logoList = new LinkedList<Picture>();
        for (int i = 0; i < appList.size(); ++i) {
            logoList.add(pictureService.getLogoPicByAppId(appList.get(i).getId()));
        }
        Page page = new Page(PageTab.QUALITY, appList, logoList, currentPage, totalPages);
        model.addAttribute("resultPage", page);
        return "searchResult";
    }

    @RequestMapping(value = "/app/download/{appId}", method = RequestMethod.GET)
    public ResponseEntity<byte[]> download(@PathVariable("appId") long appId, HttpServletRequest request) throws IOException {
        App app = appService.getAppById(appId);
        System.out.println(request.getSession().getServletContext().getRealPath("/"));//注意路径!
        File file = new File(request.getSession().getServletContext().getRealPath("/") + app.getFilePath() + app.getFileName());
        String dfileName = new String(file.getName().getBytes("utf-8"), "utf-8");
        //设置请求头内容,告诉浏览器打开下载窗口
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", dfileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        appService.updateDownloadCountById(app.getId(),app.getDownloadCount()+1);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/app/detail/{appId}", method = RequestMethod.GET)
    private String showAppDetail(@PathVariable("appId") long appId, Model model) {
        if (appService.getAppById(appId)==null){
            return "error";
        }else {
            makeAppDetailPageByAppId(appId, model);
            return "appDetail";
        }
    }

    private void makeAppDetailPageByAppId(long appId, Model model) {
        App app = appService.getAppById(appId);
        Picture logo = pictureService.getLogoPicByAppId(appId);
        List<Picture> displaysList = pictureService.getDisplaysPicByAppId(appId);
        String typeName = typeService.getTypeById(app.getTypeId()).getTypeName();
        List<Comment> commentList=commentService.getAllCommentByAppId(appId);
        List<Long> userPhoneList=new LinkedList<Long>();
        for (int i=0;i<commentList.size();++i){
            userPhoneList.add(userService.getUserById(commentList.get(i).getUserId()).getPhone());
        }
        Page page = new Page(app, typeName, logo, displaysList,commentList,userPhoneList);
        model.addAttribute("resultPage", page);
    }

    @RequestMapping(value = "/app/comment/{appId}", method = RequestMethod.POST)
    public String saveComment(@PathVariable("appId") long appId, @Param("score") byte score, @Param("commentContent") String commentContent, @Param("version") String version, HttpServletRequest request, Model model) {
        Comment comment = new Comment();
        comment.setAppId(appId);
        comment.setCommentTime(new Date());
        System.out.println(commentContent);
        comment.setContent(commentContent);
        comment.setScore(score);
        comment.setVersion(version);
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            comment.setUserId(user.getId());
        }
        commentService.save(comment);
        App app=appService.getAppById(appId);
        Long ratingCount=app.getRatingCount()+1;
        Byte avgScore=(byte)((app.getAvgScore()*app.getRatingCount()+score)/ratingCount);
        appService.updateRatingCountAndAvgScoreById(appId,ratingCount,avgScore);
        makeAppDetailPageByAppId(appId, model);
        return "appDetail";
    }
}
