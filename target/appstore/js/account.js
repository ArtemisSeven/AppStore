var account = {
    URL: {
        inOrRgsAccount: function (phone, inOrRgs) {
            return '/clientCenter/account/' + phone + '/' + inOrRgs;
        },
        logout: function () {
            return '/clientCenter/account/logout';
        }
    },
    validatePhone: function (phone) {
        if (phone && phone.length == 11 && !isNaN(phone)) {
            return true;
        } else {
            return false;
        }
    },
    showLoginModal: function (rememberMeCookie, phoneCookie, pswCookie) {
        $('#loginModal').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });
        if (rememberMeCookie == 'true') {
            $('#loginPhone').val(phoneCookie);
            $('#loginPsw').val(pswCookie);
            $('#rememberMe').attr('checked', true);
        }
    },

    showRegisterModal: function () {
        $('#registerModal').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });
    },
    login: function () {
        var loginPhone = $('#loginPhone').val();
        var loginPsw = $('#loginPsw').val();
        var rememberMe = $('#rememberMe').is(':checked');//?

        $.cookie('rememberMe', rememberMe, {expires: 7});

        if (!account.validatePhone(loginPhone)) {
            $('#loginMessage').hide().html('请输入正确的手机号码').show(200);
        } else {
            if (!loginPsw) {
                $('#loginMessage').hide().html('请输入密码').show(200);
            } else {
                $.post(account.URL.inOrRgsAccount(loginPhone, "login"), {psw: loginPsw}, function (loginResult) {
                    //不明白这里alert(xxx)会alert两次
                    if (!loginResult['phoneState']) {
                        $('#loginMessage').hide().html('此手机号码尚未注册').show(200);
                    }
                    else {
                        if (!loginResult['pswState']) {
                            $('#loginMessage').hide().html('密码不正确').show(200);
                        } else {
                            if (rememberMe) {
                                $.cookie('loginPhone', loginPhone, {expires: 7});
                                $.cookie('loginPsw', loginPsw, {expires: 7});
                            } else {
                                $.cookie('loginPhone', '', {expires: -1});
                                $.cookie('loginPsw', '', {expires: -1});
                            }

                            //window.location.reload();
                            //用reload好像会死循环原地爆炸
                            var href = "http://localhost:8080";//应该在哪登录返回哪个页面的
                            window.location.replace(href);


                        }
                    }
                });
            }
        }

    },
    logout: function () {
        $.get(account.URL.logout(), {}, function () {
            var href = "http://localhost:8080";
            window.location.replace(href);
        });
    },
    register: function () {
        var registerPhone = $('#registerPhone').val();
        var registerPsw1 = $('#registerPsw1').val();
        var registerPsw2 = $('#registerPsw2').val();

        if (!account.validatePhone(registerPhone)) {
            $('#registerMessage').hide().html('请输入正确的手机号码').show(200);
        } else {
            if (!registerPsw1) {
                $('#registerMessage').hide().html('请输入密码').show(200);
            } else {
                if (!registerPsw2) {
                    $('#registerMessage').hide().html('请再次输入密码').show(200);
                } else {
                    if (registerPsw1 != registerPsw2) {
                        $('#registerMessage').hide().html('两次输入的密码不一样').show(200);
                    } else {
                        $.post(account.URL.inOrRgsAccount(registerPhone, "register"), {psw: registerPsw1}, function (registerResult) {
                            if (registerResult['phoneState']) {
                                $('#registerMessage').hide().html('此手机号码已被注册').show(200);
                            }
                            else {
                                $.cookie('rememberMe', '', {expires: -1});
                                $.cookie('loginPhone', '', {expires: -1});
                                $.cookie('loginPsw', '', {expires: -1});

                                //window.location.reload();
                                var href = "http://localhost:8080";
                                window.location.replace(href);

                            }
                        });
                    }

                }
            }
        }

    }
};


