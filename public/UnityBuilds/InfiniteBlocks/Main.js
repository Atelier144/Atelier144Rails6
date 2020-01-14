var gameInstance = UnityLoader.instantiate("gameContainer", "/UnityBuilds/InfiniteBlocks/InfiniteBlocks.json");

function GetUserIdFromUnity() {
    return document.getElementById("unity-user-id").textContent;
}

function GetLanguageCodeFromUnity() {
    return document.getElementById("unity-language-code").textContent;
}

function SendInfiniteBlocksRecordFromUnity(userId, score, level) {
    $.ajax({
        url: "/games/infinite-blocks/record",
        type: "POST",
        data: {
            user_id: userId,
            score: score,
            level: level
        },
        dataType: "html",
        success: function (data) {
            console.log("SUCCESS");
            window.location.href = "/games/infinite-blocks/result";
        },
        error: function (data) {
            console.log("FAILED");
            alert("ランキングの登録に失敗しました。");
        }
    });
}

function GetInfiniteBlocksHighScoreFromUnity() {
    var value = $.cookie("Atelier144InfiniteBlocksHighScore");
    return value;
}

function SetInfiniteBlocksHighScoreFromUnity(highScore) {
    $.cookie("Atelier144InfiniteBlocksHighScore", highScore);

}

function DestroyInfiniteBlocksHighScoreFromUnity() {
    $.cookie("Atelier144InfiniteBlocksHighScore", 0);
}

function GetInfiniteBlocksMaxLevelFromUnity() {
    var value = $.cookie("Atelier144InfiniteBlocksMaxLevel");
    return value;
}

function SetInfiniteBlocksMaxLevelFromUnity(maxLevel) {
    $.cookie("Atelier144InfiniteBlocksMaxLevel", maxLevel);
}

function DestroyInfiniteBlocksMaxLevelFromUnity() {
    $.cookie("Atelier144InfiniteBlocksMaxLevel", 0);
}
