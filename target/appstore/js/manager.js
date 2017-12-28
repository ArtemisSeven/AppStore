var manager = {
    type: {
        URL: {
            saveType: function (typeName) {
                return '/managerCenter/' + typeName + '/save';
            },
            changeType: function (oldTypeName, newTypeName) {
                return '/managerCenter/' + oldTypeName + '/' + newTypeName + '/change';
            }
        },
        bindShowAddType: function () {
            $('#showAddType').click(function () {
                $('#addTypeModal').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
            });
        },
        bindAddType: function (dataListSize, keyword,ctx) {
            $('#addType').click(function () {
                var newType = $('#newType').val();
                if (!newType) {
                    $('#typeMessage').hide().html('请输入类型名称').show(200);
                } else {
                    $.post(ctx+manager.type.URL.saveType(newType), {}, function (result) {
                        if (!result['state']) {
                            $('#typeMessage').hide().html('此类型已存在').show(200);
                        } else {
                            $('#addTypeModal').modal('hide');
                            $('#getTypePage1').click();
                            ////alert("添加成功");
                            //var type = result['type'];
                            //var url = '/managerCenter/1/' + type['id'] + '/delete?keyword=' + keyword;
                            //$("#typeTable").prepend('<tr><td>' + newType + '</td><td>更名</td><td><a href="' + url + '">删除</a></td></tr>');
                            //if (dataListSize >= 5) {
                            //    $('#typeTable tr:last').remove();
                            //}
                        }
                    });
                }
            });
        },
        makePage: function (keyword) {
            var num = 2;
            $('#typeTab').addClass("active").siblings().removeClass("active");
            $('#nav-tabs li:eq(' + num + ') a').tab('show');
            $('#typeKeyword').val(keyword);
        },
        changeType: function (ctx) {
            $(".changeTypeNameNode").click(function () {
                $('#changeTypeModal').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
                var oldTypeNameNode = $(this).parent().prev();
                $('#changeTypeName').val(oldTypeNameNode.text());
                $('#changeTypeBtn').click(function () {
                    var newTypeName = $('#changeTypeName').val();
                    if (!newTypeName) {
                        $('#changeTypeMessage').hide().html('请输入类型名称').show(200);
                    } else {
                        $.post(ctx+manager.type.URL.changeType(oldTypeNameNode.text(), newTypeName), {}, function (result) {
                            if (!result['state']) {
                                $('#changeTypeMessage').hide().html('此类型已存在').show(200);
                            } else {
                                $('#changeTypeModal').modal('hide');
                                //alert("更改成功");
                                oldTypeNameNode.text(newTypeName);
                            }
                        });
                    }
                });
            });
        },
        initTypePage: function (param) {
            manager.type.bindShowAddType();
            manager.type.bindAddType(param['dataListSize'], param['keyword'],param['ctx']);
            manager.type.makePage(param['keyword']);
            manager.type.changeType(param['ctx']);

        }
    },
    app: {
        URL: {
            saveApp: function () {
                return '/managerCenter/app/saveOrUpload?to=SAVE';
            },
            uploadApp: function () {
                return '/managerCenter/app/saveOrUpload?to=UPLOAD';
            },
            checkAppName: function (appName) {
                return '/managerCenter/app/' + appName + '/check';
            },
            updateApp: function () {
                return '/managerCenter/app/saveOrUpload?to=UPLOAD';
            },
            deleteApp: function (appId) {
                return '/managerCenter/app/delete?appId=' + appId;
            },
            //saveCachePic: function () {
            //    return '/managerCenter/saveCachePic';
            //}
        },
        showUploadModal: function (allTypeSize) {
            if (allTypeSize<=0){
                alert('尚未任何app类型,请添加');
            }else {
                $('.appMessage0').each(function () {
                    $(this).html(' ');
                });
                $('#appFileNameCache0').html('');
                $('#logoPicCache0').attr('src', 'undefined');
                $('#displayPicCache10').attr('src', 'undefined');
                $('#displayPicCache20').attr('src', 'undefined');
                $('#displayPicCache30').attr('src', 'undefined');
                $('#displayPicCache40').attr('src', 'undefined');
                $('#uploadModal').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
            }
        },
        makePage: function (appState, keyword) {
            var num = 0;
            $('#appTab').addClass("active").siblings().removeClass("active");
            $('#nav-tabs li:eq(' + num + ') a').tab('show');

            $('#appState').val(appState);
            $('#appKeyword').val(keyword);
        },
        uploadButSaveApp: function (ctx) {
            $('.appMessage0').each(function () {
                $(this).html(' ');
            });
            var appName = $('#appName0').val();
            if (!appName) {
                $('#appNameMessage0').hide().html("app名称不能为空").show(200);
            } else {
                $.post(ctx+manager.app.URL.checkAppName(appName), {}, function (result) {
                    if (!result['state']) {
                        $('#appNameMessage0').hide().html("app名称已存在").show(200);
                    } else {
                        $('#appForm0').attr('action', ctx+manager.app.URL.saveApp()).submit();
                    }
                });
            }
        },
        updateButSaveApp: function (ctx) {
            var appName = $('#appName').val();
            if (!appName) {
                $('#appNameMessage').hide().html("app名称不能为空").show(200);
            } else {
                $('#appForm').attr('action', ctx+manager.app.URL.saveApp()).submit();
            }
        },
        uploadApp: function (ctx) {

            var appFile = $('#appFile0').val();
            var logoFile = $('#logoFile0').val();
            var displayFile1 = $('#displayFile10').val();
            var displayFile2 = $('#displayFile20').val();
            var displayFile3 = $('#displayFile30').val();
            var displayFile4 = $('#displayFile40').val();
            var appName = $('#appName0').val();
            var version = $('#version0').val();
            var company = $('#company0').val();
            var description = $('#description0').val();
            var ok = 1;
            //if (!appFile && $('#appFileNameCache').text == '') {
            if (!appFile) {
                $('#appFileMessage0').hide().html("app安装包不能为空").show(200);
                ok = 0
            }
            //if (!logoFile && $('#logoPicCache').attr('src') == 'undefined') {
            if (!logoFile) {
                $('#logoFileMessage0').hide().html("app Logo不能为空").show(200);
                ok = 0
            }
            //if (!displayFile1 && $('#displayPicCache1').attr('src') == 'undefined') {
            if (!displayFile1 ) {
                $('#displayFileMessage10').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            //if (!displayFile2 && $('#displayPicCache2').attr('src') == 'undefined') {
            if (!displayFile2 ) {
                $('#displayFileMessage20').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            //if (!displayFile3 && $('#displayPicCache3').attr('src') == 'undefined') {
            if (!displayFile3 ) {
                $('#displayFileMessage30').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            //if (!displayFile4 && $('#displayPicCache4').attr('src') == 'undefined') {
            if (!displayFile4 ) {
                $('#displayFileMessage40').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            if (!appName) {
                $('#appNameMessage0').hide().html("app名称不能为空").show(200);
                ok = 0
            }
            if (!version) {
                $('#versionMessage0').hide().html("app版本不能为空").show(200);
                ok = 0
            }
            if (!version) {
                $('#osMessage0').hide().html("app适用系统不能为空").show(200);
                ok = 0
            }
            if (!company) {
                $('#companyMessage0').hide().html("app出品公司不能为空").show(200);
                ok = 0
            }
            if (!description) {
                $('#descriptionMessage0').hide().html("app描述不能为空").show(200);
                ok = 0
            }
            if (ok == 1) {
                    $.post(ctx+manager.app.URL.checkAppName(appName), {}, function (result) {
                        if (!result['state']) {
                            $('#appNameMessage0').hide().html("app名称已存在").show(200);
                        } else {
                            $('#appForm0').attr('action', ctx+manager.app.URL.uploadApp()).submit();
                        }
                    });
            }
        },
        updateApp:function(ctx){
            var appFile = $('#appFile').val();
            var logoFile = $('#logoFile').val();
            var displayFile1 = $('#displayFile1').val();
            var displayFile2 = $('#displayFile2').val();
            var displayFile3 = $('#displayFile3').val();
            var displayFile4 = $('#displayFile4').val();
            var appName = $('#appName').val();
            var version = $('#version').val();
            var company = $('#company').val();
            var description = $('#description').val();
            var ok = 1;
            if (!appFile && $('#appFileNameCache').text == '') {
                //if (!appFile) {
                $('#appFileMessage').hide().html("app安装包不能为空").show(200);
                ok = 0
            }
            if (!logoFile && $('#logoPicCache').attr('src') == 'undefined') {
                //if (!logoFile) {
                $('#logoFileMessage').hide().html("app Logo不能为空").show(200);
                ok = 0
            }
            if (!displayFile1 && $('#displayPicCache1').attr('src') == 'undefined') {
                //if (!displayFile1 ) {
                $('#displayFileMessage1').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            if (!displayFile2 && $('#displayPicCache2').attr('src') == 'undefined') {
                //if (!displayFile2 ) {
                $('#displayFileMessage2').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            if (!displayFile3 && $('#displayPicCache3').attr('src') == 'undefined') {
                //if (!displayFile3 ) {
                $('#displayFileMessage3').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            if (!displayFile4 && $('#displayPicCache4').attr('src') == 'undefined') {
                //if (!displayFile4 ) {
                $('#displayFileMessage4').hide().html("app展示图片不能为空").show(200);
                ok = 0
            }
            if (!appName) {
                $('#appNameMessage').hide().html("app名称不能为空").show(200);
                ok = 0
            }
            if (!version) {
                $('#versionMessage').hide().html("app版本不能为空").show(200);
                ok = 0
            }
            if (!version) {
                $('#osMessage').hide().html("app适用系统不能为空").show(200);
                ok = 0
            }
            if (!company) {
                $('#companyMessage').hide().html("app出品公司不能为空").show(200);
                ok = 0
            }
            if (!description) {
                $('#descriptionMessage').hide().html("app描述不能为空").show(200);
                ok = 0
            }
            if (ok == 1) {
                $('#appForm').attr('action',ctx+manager.app.URL.updateApp()).submit();
            }
        },
        showUpdateAppModal: function (appId,appFileName,logo,d1,d2,d3,d4,appName,version,os,typeId,company,description) {
            $('.appMessage').each(function () {
                $(this).html(' ');
            });
            $('#oldAppId').val(appId);
            if (appFileName != 'null') {
                $('#appFileNameCache').html(appFileName);
            }
            if (logo != 'null') {
                $('#logoPicCache').attr('src', logo);
            } else {
                $('#logoPicCache').removeAttribute('src');
            }
            if (d1 != 'null') {
                $('#displayPicCache1').attr('src', d1);
            } else {
                $('#displayPicCache1').attr('src', 'undefined');
            }
            if (d2 != 'null') {
                $('#displayPicCache2').attr('src', d2);
            } else {
                $('#displayPicCache2').attr('src', 'undefined');
            }
            if (d3 != 'null') {
                $('#displayPicCache3').attr('src', d3);
            } else {
                $('#displayPicCache3').attr('src', 'undefined');
            }
            if (d4 != 'null') {
                $('#displayPicCache4').attr('src', d4);
            } else {
                $('#displayPicCache4').attr('src', 'undefined');
            }
            if (version != 'null') {
                $('#version').val(version);
            }
            if (os != 'null') {
                $('#os').val(os);
            }
            if (company != 'null') {
                $('#company').val(company);
            }
            if (description != 'null') {
                $('#description').val(description);
            }
            $('#appName').val(appName);
            $('#typeId').val(typeId);
            $('#updateModal').modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        },
        deleteApp: function (appId,ctx) {
            $('#tipsMessage').html('确定删除该App吗?');
            $('#tipsEnterBtn').attr('href', ctx+manager.app.URL.deleteApp(appId));
            $('#tipsModal').modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        },
        initAppPage: function (param) {
            manager.app.makePage(param['appState'], param['keyword']);
        }
    },
    carousel: {
        URL: {
            saveCarousel: function () {
                return '/managerCenter/carousel/save';
            },
            deleteCarousel: function (carouselId) {
                return '/managerCenter/carousel/delete?carouselId=' + carouselId;
            }
        },
        showAddCarouselModal: function (appSize) {
            if (appSize==0){
                alert('暂时没有可添加至carousel的app');
            }else {
                $('#addCarouselModal').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
                $('#carouselFileMessage').html(' ');
            }
        },
        makePage: function () {
            var num = 1;
            $('#carouselTab').addClass("active").siblings().removeClass("active");
            $('#nav-tabs li:eq(' + num + ') a').tab('show');
        },
        addCarousel: function (ctx) {
            $('#carouselFileMessage').html(' ');
            var carouselFile = $('#carouselFile').val();
            if (!carouselFile) {
                $('#carouselFileMessage').hide().html("图片不能为空").show(200);
            } else {
                $('#carouselForm').attr('action', ctx+manager.carousel.URL.saveCarousel()).submit();
            }
        },
        deleteCarousel: function (carouselId,ctx) {
            $('#tipsMessage').html('确定删除该Carousel吗?');
            $('#tipsEnterBtn').attr('href', ctx+manager.carousel.URL.deleteCarousel(carouselId));
            $('#tipsModal').modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        },
        showUpdateCarouselModal: function (carouselId) {
            $('#carouselId').val(carouselId);
            $('#newCarouselFileMessage').html(' ');
            $('#updateCarouselModal').modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        },
        updateCarousel: function () {
            var newCarouselFile = $('#newCarouselFile').val();
            if (!newCarouselFile) {
                $('#newCarouselFileMessage').hide().html("图片不能为空").show(200);
            } else {
                $('#updateCarouselForm').submit();
            }
        },
        initCarouselPage: function () {
            manager.carousel.makePage();
        }
    },
    tab:{
        bindLi:function(){
            $('#appLi').click(function(){
                $('#getAppPage1').click();
            });
            $('#carouselLi').click(function(){
                $('#getCarouselPage1').click();
            });
            $('#typeLi').click(function(){
                $('#getTypePage1').click();
            });
        }
    }

};