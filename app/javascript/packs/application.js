// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

import "bootstrap"
import "../stylesheets/application"
import "@fortawesome/fontawesome-free/js/all";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function () {
    $("a.scroll").click(function () {
        var target = $(this).data("href");
        var position = $(target).offset().top - 120;
        $("html, body").animate({
            "scrollTop": position
        }, "slow");
    });

    $(".page-top").click(function () {
        $("html, body").animate({
            "scrollTop": 0
        }, "slow");
    });

    $(".flash").delay(2000).fadeOut();

    $("header .user-image").click(function () {
        $("header .popup-menu").show();
    });

    $("header .popup-menu .close").click(function () {
        $("header .popup-menu").hide();
    });

    $("header .hamburger").click(function () {
        if ($(this).hasClass("open")) {
            $(this).html('<i class="fas fa-bars"><i>');
            $(this).removeClass("open");
            $("header .pulldown-menu").slideUp();
        } else {
            $(this).addClass("open");
            $(this).html('<i class="fas fa-times"><i>');
            $("header .pulldown-menu").slideDown();
        }
    });

    $("#js-top-background").children("h1").delay(1000).fadeIn(1000);
    $("#js-top-background").children("p").delay(2000).fadeIn(1000);

    $("#js-twitter-auto").click();

    $("#js-setting-image-select").click(function () {
        $("#js-setting-image-file").click();
    });

    $("#js-setting-image-default").click(function () {
        if ($("#js-setting-image-file").prop("files")[0] !== undefined || $("#js-setting-image-is-default").prop("checked")) {
            $("#js-setting-image-is-default").prop("checked", false);
            $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
            $("#js-setting-image-name").text("");
            $("#js-setting-image-default").text("デフォルトに戻す");
            $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));

        } else {
            $("#js-setting-image-is-default").prop("checked", true);
            $("#js-setting-image-status").css("color", "white").css("background-color", "#FF8080").text("デフォルト");
            $("#js-setting-image-name").text("");
            $("#js-setting-image-default").text("デフォルト解除");
            $("#js-setting-image-image").attr("src", $("#js-setting-image-default-image").attr("src"));
        }
        $("#js-setting-image-file").val(undefined);
    });

    $("#js-setting-image-file").on("change", function () {
        var file = $(this).prop("files")[0];
        if (file === undefined) {
            if ($("#js-setting-image-is-default").prop("checked")) {
                $("#js-setting-image-status").css("color", "white").css("background-color", "#FF8080").text("デフォルト");
                $("#js-setting-image-name").text("");
                $("#js-setting-image-default").text("デフォルト解除");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-default-image").attr("src"));
            } else {
                $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                $("#js-setting-image-name").text("");
                $("#js-setting-image-default").text("デフォルトに戻す");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
            }
        } else {
            if (file.type.match("image.*")) {
                var fileNameRegExp = /\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/
                if (fileNameRegExp.test(file.name)) {
                    if (file.size <= 2097152) {
                        $("#js-setting-image-status").css("color", "#008000").css("background-color", "#80FF80").text("選択中");
                        $("#js-setting-image-name").text("ファイル名：" + file.name).css("color", "black");
                        $("#js-setting-image-is-default").prop("checked", false);
                        $("#js-setting-image-default").text("選択解除");

                        var reader = new FileReader();
                        reader.onload = function () {
                            $("#js-setting-image-image").attr("src", reader.result);
                        }
                        reader.readAsDataURL(file);

                    } else {
                        $(this).val(undefined);
                        $("#js-setting-image-is-default").prop("checked", false);
                        $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                        $("#js-setting-image-name").text("2MB以内の画像ファイルをアップロードしてください").css("color", "red");
                        $("#js-setting-image-default").text("デフォルトに戻す");
                        $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
                    }
                } else {
                    $(this).val(undefined);
                    $("#js-setting-image-is-default").prop("checked", false);
                    $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                    $("#js-setting-image-name").text("gif、png、jpgの画像ファイルをアップロードしてください").css("color", "red");
                    $("#js-setting-image-default").text("デフォルトに戻す");
                    $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
                }
            } else {
                $(this).val(undefined);
                $("#js-setting-image-is-default").prop("checked", false);
                $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                $("#js-setting-image-name").text("画像ファイルをアップロードしてください").css("color", "red");
                $("#js-setting-image-default").text("デフォルトに戻す");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
            }
        }
    });

    $("#js-records-delete-infinite-blocks-button").click(function () {
        var flag = confirm("本当に『Infinite Blocks』の全記録を削除しますか？");

        if (flag) {
            $("#js-records-delete-infinite-blocks").click();
        }
    });

    $(".js-webgames-screenshot-on").click(function () {
        var img = $(this).attr("src");
        $("#js-webgames-screenshot-image").attr("src", img);
        $("#js-webgames-screenshot").show();
    });

    $("#js-webgames-screenshot-image").click(function () {
        $("#js-webgames-screenshot").hide();
    });
});
