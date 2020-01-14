class User < ApplicationRecord
    mount_uploader :image, ImagesUploader

    validates :name, uniqueness: true, presence: true
    validates :email, uniqueness: true, allow_nil: true
    validates :twitter_uid, uniqueness: true, allow_nil: true
    validates :reset_password_token, uniqueness: true, allow_nil: true

    has_secure_password

    def image_url
        if self.twitter_image
            return self.twitter_image
        else
            return self.image.url
        end
    end
end
