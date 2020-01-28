module ApplicationHelper
    def default_meta_tags
        {
            site: "Atelier144",
            title: "オリジナルフリーゲーム配信サイト",
            reverse: true,
            charset: "utf-8",
            description: "Atelier144はたったひとりの個人によって開発運営されている会員登録制のフリーゲーム配信サイトです。",
            keywords: ["フリーゲーム","ブラウザゲーム"],
            icon:[
                { href: image_url("favicon.ico")}
            ]
        }
    end
end
