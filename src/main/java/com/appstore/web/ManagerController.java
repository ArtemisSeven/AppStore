package com.appstore.web;

import com.appstore.dto.Page;
import com.appstore.dto.Result;
import com.appstore.entity.App;
import com.appstore.entity.Carousel;
import com.appstore.entity.Picture;
import com.appstore.entity.Type;
import com.appstore.enums.AppState;
import com.appstore.enums.PageTab;
import com.appstore.service.AppService;
import com.appstore.service.CarouselService;
import com.appstore.service.PictureService;
import com.appstore.service.TypeService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Controller
@RequestMapping("/managerCenter")
public class ManagerController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private TypeService typeService;

    @Autowired
    private AppService appService;

    @Autowired
    private CarouselService carouselService;

    @Autowired
    private PictureService pictureService;

    private final int typePageSize = 5;
    private final int appPageSize = 4;
    private final int carouselPageSize = 3;

    @RequestMapping(value = "/{typeName}/save", method = RequestMethod.POST)
    @ResponseBody
    private Result saveType(@PathVariable("typeName") String typeName) {
        System.out.println("saveType:" + typeName);
        if (typeService.checkTypeExist(typeName)) {
            return new Result(false, null);
        } else {
            Type type = typeService.saveType(typeName);
            if (type != null) {
                return new Result(true, type);
            } else {
                System.out.println("保存类型失败");
                return new Result(false, null);
            }
        }
    }

    @RequestMapping(value = "/{pageIndex}/{typeId}/delete", method = RequestMethod.GET)
    private String deleteTypeAndReturnNewPage(@PathVariable("pageIndex") int pageIndex, @PathVariable("typeId") int typeId, String keyword, Model model) {
        System.out.println("删除类型:" + pageIndex + " " + typeId + " " + keyword);
        typeService.deleteById(typeId);
        makeTypePageByIndex(keyword, pageIndex, model);
        return "manager";
    }

    @RequestMapping(value = "/{oldTypeName}/{newTypeName}/change", method = RequestMethod.POST)
    @ResponseBody
    private Result changeTypeName(@PathVariable("oldTypeName") String oldTypeName, @PathVariable("newTypeName") String newTypeName) {
        System.out.println("changeTypeName:" + oldTypeName + " " + newTypeName);
        if (typeService.checkTypeExist(newTypeName)) {
            return new Result(false, null);
        } else {
            typeService.updateTypeName(oldTypeName, newTypeName);
            return new Result(true, typeService.saveType(newTypeName));
        }
    }
    @RequestMapping(value = "/app/{appName}/check", method = RequestMethod.POST)
    @ResponseBody
    private Result checkAppNameExist(@PathVariable("appName") String appName) {
        if (appService.checkAppNameExist(appName)) {
            return new Result(false);
        }
        else {
            return new Result(true);
        }
    }

    @RequestMapping(value = "/{pageIndex}/typePage", method = RequestMethod.GET)
    private String getTypePage(@PathVariable("pageIndex") int pageIndex, String keyword, Model model) {
        System.out.println("getTypePage:" + pageIndex + " " + keyword);
        makeTypePageByIndex(keyword.trim(), pageIndex, model);
        return "manager";
    }

    public void makeTypePageByIndex(String keyword, int pageIndex, Model model) {
        System.out.println("makeTypePageByIndex:" + keyword + " " + pageIndex);
        List<Type> typeList = typeService.searchByKeywordLimit((pageIndex - 1) * typePageSize, typePageSize, keyword);
        int totalPages = (int) Math.ceil((double) typeService.searchByKeyword(keyword).size() / (double) typePageSize);
        List<Integer> typeAppSize=new LinkedList<Integer>();
        for (int i=0;i<typeList.size();++i){
            Integer size=appService.getAllAppByTypeId(typeList.get(i).getId()).size();
            typeAppSize.add(size);
        }
        Page typePage = new Page(PageTab.TYPE, keyword, totalPages, pageIndex, typeList,typeAppSize);
        model.addAttribute("resultPage", typePage);
    }




    @RequestMapping(value = "/app/saveOrUpload", method = RequestMethod.POST)
    private String saveOrUploadApp(Long oldAppId,String to, App app, MultipartFile appFile, MultipartFile logoFile, @RequestParam("displayFile") MultipartFile[] displayFiles, HttpServletRequest request, Model model) {
        try {
            System.out.println("saveOrUploadApp:" + to + " " + app.getAppName() + " " + appFile.getOriginalFilename());
            System.out.println("typeId:" + app.getTypeId());

            String s=app.getDescription();
            String dest;
            Pattern p = Pattern.compile("\t|\r|\n");
            Matcher m = p.matcher(s);
            dest = m.replaceAll("<br/>");
            System.out.println(dest);
            System.out.println("aas:"+dest);
            app.setDescription(dest);
            if (to.equals("SAVE")) {
                app.setState("OFF");
            } else {
                app.setState("ON");
            }

            String realPath = request.getSession().getServletContext().getRealPath("upload");
            File realPathDir = new File(realPath);
            Long appId;

            if (!realPathDir.exists()) {
                realPathDir.mkdir();
            }
            if (appFile.getSize() > 0) {
                FileUtils.copyInputStreamToFile(appFile.getInputStream(), new File(realPath + "/" + appFile.getOriginalFilename()));
                app.setFileName(appFile.getOriginalFilename());
                app.setFilePath(request.getContextPath() + "/upload/");
                app.setUpdateTime(new Date());
            }

            boolean updateApp = false;
            if (oldAppId!=-1) {
                updateApp = true;
            }
            if (updateApp) {
                //更新app
                App oldApp = appService.getAppById(oldAppId);
                appId = oldAppId;
//                if (app.getAppName() != null && !app.getAppName().equals(oldApp.getAppName())) {
//                    appService.updateAppNameById(appId, app.getAppName());
//                }
                if (app.getFilePath() != null && !app.getFilePath().equals(oldApp.getFilePath())) {
                    appService.updateFilePathById(appId, app.getFilePath());
                }
                if (app.getFileName() != null && !app.getFileName().equals(oldApp.getFileName())) {
                    appService.updateFileNameById(appId, app.getFileName());
                }
                if (app.getAppName() != null && !app.getAppName().equals(oldApp.getAppName())) {
                    appService.updateAppNameById(appId, app.getAppName());
                }
                if (app.getVersion() != null && !app.getVersion().equals(oldApp.getVersion())) {
                    appService.updateVersionById(appId, app.getVersion());
                }
                if (app.getOs() != null && !app.getVersion().equals(oldApp.getOs())) {
                    appService.updateOsById(appId, app.getOs());
                }
                if (app.getTypeId() != null && !app.getTypeId().equals(oldApp.getTypeId())) {
                    appService.updateTypeIdById(appId, app.getTypeId());
                }
                if (app.getCompany() != null && !app.getCompany().equals(oldApp.getCompany())) {
                    appService.updateCompanyById(appId, app.getCompany());
                }
                if (app.getDescription() != null && !app.getDescription().equals(oldApp.getDescription())) {
                    appService.updateDescriptionById(appId, app.getDescription());
                }
                if (to.equals("SAVE")) {
                    appService.updateStateById(appId, "OFF");
                    carouselService.deleteByAppId(appId);
                } else {
                    appService.updateStateById(appId, "ON");
                }
            } else {
                //保存app
                app.setAvgScore((byte) 5);
                app.setDownloadCount((long) 0);
                app.setRatingCount((long) 0);
                appService.save(app);
                appId = app.getId();
            }

            if (updateApp) {
                if (logoFile.getSize() > 0) {
                    FileUtils.copyInputStreamToFile(logoFile.getInputStream(), new File(realPath + "/" + logoFile.getOriginalFilename()));
                    pictureService.updatePicByAppId(appId, "LOGO", request.getContextPath() + "/upload/", logoFile.getOriginalFilename());
                }
                System.out.println("displayFilesLength:" + displayFiles.length);
                for (int i = 0; i < displayFiles.length; ++i) {
                    if (displayFiles[i].getSize() > 0) {
                        FileUtils.copyInputStreamToFile(displayFiles[i].getInputStream(), new File(realPath + "/" + displayFiles[i].getOriginalFilename()));
                        if (pictureService.getDisplayPicByAppIdAndModuleIndex(appId, "DISPLAY" + (i + 1)) != null) {
                            pictureService.updatePicByAppId(appId, "DISPLAY" + (i + 1), request.getContextPath() + "/upload/", displayFiles[i].getOriginalFilename());
                        } else {
                            Picture pp = new Picture();
                            pp.setAppId(appId);
                            pp.setPicPath(request.getContextPath() + "/upload/");
                            pp.setPicName(displayFiles[i].getOriginalFilename());
                            pp.setModule("DISPLAY" + (i + 1));
                            pictureService.save(pp);
                        }
                    }
                }
            } else {
                if (logoFile.getSize() > 0) {
                    FileUtils.copyInputStreamToFile(logoFile.getInputStream(), new File(realPath + "/" + logoFile.getOriginalFilename()));
                    Picture logo = new Picture();
                    logo.setAppId(appId);
                    logo.setModule("LOGO");
                    logo.setPicName(logoFile.getOriginalFilename());
                    logo.setPicPath(request.getContextPath() + "/upload/");
                    pictureService.save(logo);
                }
                for (int i = 0; i < displayFiles.length; ++i) {
                    if (displayFiles[i].getSize() > 0) {
                        FileUtils.copyInputStreamToFile(displayFiles[i].getInputStream(), new File(realPath + "/" + displayFiles[i].getOriginalFilename()));
                        Picture pic = new Picture();
                        pic.setModule("DISPLAY" + (i + 1));
                        pic.setAppId(appId);
                        pic.setPicName(displayFiles[i].getOriginalFilename());
                        pic.setPicPath(request.getContextPath() + "/upload/");
                        pictureService.save(pic);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        makeAppPageByIndex(AppState.ALL, "", 1, model);
        return "manager";
    }


    @RequestMapping(value = "/app/delete", method = RequestMethod.GET)
    private String deleteApp(@RequestParam("appId") long appId, Model model) {
        System.out.println("deleteAppId:" + appId);
        if (!appService.deleteById(appId)) {
            System.out.println("删除app失败:" + appId);
        }else{
            carouselService.deleteByAppId(appId);
        }
        makeAppPageByIndex(AppState.ALL, "", 1, model);
        return "manager";
    }

    @RequestMapping(value = "/{pageIndex}/appPage", method = RequestMethod.GET)
    private String getAppPage(@PathVariable("pageIndex") int pageIndex, String appState, String keyword, Model model) {
        System.out.println("getAppPage:" + pageIndex + " " + appState + " " + keyword);
        makeAppPageByIndex(AppState.valueOf(appState), keyword.trim(), pageIndex, model);
        return "manager";
    }

    public void makeAppPageByIndex(Enum<AppState> appState, String keyword, int pageIndex, Model model) {
        System.out.println("makeAppPageByIndex:" + appState + " " + keyword + " " + pageIndex);
        List<App> appList;
        int totalPages;
        if (appState.toString().equals("ALL")) {
            appList = appService.searchByKeywordLimit((pageIndex - 1) * appPageSize, appPageSize, keyword);
            totalPages = (int) Math.ceil((double) appService.searchByKeyword(keyword).size() / (double) appPageSize);
        } else {
            if (appState.toString().equals("ON")) {
                appList = appService.searchByStateAndKeywordLimit((pageIndex - 1) * appPageSize, appPageSize, appState.toString(), keyword);
            } else {
                appList = appService.searchByStateAndKeywordLimit((pageIndex - 1) * appPageSize, appPageSize, appState.toString(), keyword);
            }
            totalPages = (int) Math.ceil((double) appService.searchByStateAndKeyword(appState.toString(), keyword).size() / (double) appPageSize);
        }
        List<Picture> logoList = new LinkedList<Picture>();
        List<Picture> displaysList = new LinkedList<Picture>();
        for (int i = 0; i < appList.size(); ++i) {
            try {
                long appId = appList.get(i).getId();
                Picture logo = pictureService.getLogoPicByAppId(appId);
                logoList.add(logo);
                List<Picture> thisAppDisplaysList = pictureService.getDisplaysPicByAppId(appId);
                for (int j = 1; j <= 4; ++j) {
                    if (j > thisAppDisplaysList.size()) {
                        displaysList.add(null);
                    } else {
                        displaysList.add(thisAppDisplaysList.get(j - 1));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        List<Type> allType = typeService.getAllType();
        Page appPage = new Page(PageTab.APP, appState.toString(), keyword, totalPages, pageIndex, appList, logoList, displaysList, allType);
        model.addAttribute("resultPage", appPage);
    }

    @RequestMapping(value = "/{pageIndex}/carouselPage", method = RequestMethod.GET)
    private String getCarouselPage(@PathVariable("pageIndex") int pageIndex, Model model) {
        System.out.println("getCarouselPage:" + pageIndex + " " + " ");
        makeCarouselPageByIndex(pageIndex, model);
        return "manager";
    }

    public void makeCarouselPageByIndex(int pageIndex, Model model) {
        System.out.println("makeCarouselPageByIndex:" + " " + pageIndex);
        List<Carousel> carouselList = carouselService.getCarouselLimit((pageIndex - 1) * carouselPageSize, carouselPageSize);
        List<String> appNamesList = new LinkedList<String>();
        List<App> choseApps = appService.getIdAndName();
        for (int i = 0; i < carouselList.size(); ++i) {
            long appId = carouselList.get(i).getAppId();
            String appName = appService.getNameById(appId);
            appNamesList.add(appName);

            App app = new App();
            app.setAppName(appName);
            app.setId(appId);
            if (choseApps.contains(app)) {
                choseApps.remove(app);
            }
        }
        System.out.println("choseApps.size" + choseApps.size());
        int totalPages = (int) Math.ceil((double) carouselService.getAllCarousel().size() / (double) carouselPageSize);
        Page carouselPage = new Page(PageTab.CAROUSEL, totalPages, pageIndex, carouselList, appNamesList, choseApps);
        model.addAttribute("resultPage", carouselPage);
    }

    @RequestMapping(value = "/carousel/save", method = RequestMethod.POST)
    private String saveCarousel(long linkAppId, MultipartFile carouselFile, HttpServletRequest request, Model model) {
        System.out.println("saveCarousel");
        String realPath = request.getSession().getServletContext().getRealPath("upload");
        File realPathDir = new File(realPath);
        try {
            if (!realPathDir.exists()) {
                realPathDir.mkdir();
            }
            if (carouselFile.getSize() > 0) {
                FileUtils.copyInputStreamToFile(carouselFile.getInputStream(), new File(realPath + "/" + carouselFile.getOriginalFilename()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Carousel carousel = new Carousel();
        carousel.setAppId(linkAppId);
        carousel.setPicPath(request.getContextPath() + "/upload/");
        carousel.setPicName(carouselFile.getOriginalFilename());
        carouselService.save(carousel);
        makeCarouselPageByIndex(1, model);
        return "manager";
    }

    @RequestMapping(value = "/carousel/delete", method = RequestMethod.GET)
    private String deleteCarousel(@RequestParam("carouselId") long carouselId, Model model) {
        System.out.println("deleteCarouselId:" + carouselId);
        if (!carouselService.deleteById(carouselId)) {
            System.out.println("删除carousel失败:" + carouselId);
        }
        makeCarouselPageByIndex(1, model);
        return "manager";
    }

    @RequestMapping(value = "/carousel/update", method = RequestMethod.POST)
    private String updateCarousel(@RequestParam("carouselId") long carouselId, MultipartFile newCarouselFile, HttpServletRequest request, Model model) {
        System.out.println("updateCarouselId:" + carouselId + " " + newCarouselFile.getOriginalFilename());
        String realPath = request.getSession().getServletContext().getRealPath("upload");
        File realPathDir = new File(realPath);
        try {
            if (!realPathDir.exists()) {
                realPathDir.mkdir();
                System.out.println();
            }
            if (newCarouselFile.getSize() > 0) {
                FileUtils.copyInputStreamToFile(newCarouselFile.getInputStream(), new File(realPath + "/" + newCarouselFile.getOriginalFilename()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String picPath = request.getContextPath() + "/upload/";
        String picName = newCarouselFile.getOriginalFilename();
        if (!carouselService.update(carouselId, picPath, picName)) {
            System.out.println("更新carousel失败");
        }
        makeCarouselPageByIndex(1, model);
        return "manager";
    }
}
