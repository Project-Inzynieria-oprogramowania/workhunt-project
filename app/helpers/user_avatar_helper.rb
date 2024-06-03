module UserAvatarHelper
    def get_avatar(user)
        if user.avatar.image.present?
            user.avatar.image.url
        else
            asset_path('profile-picture-placeholder.png')
        end
    end
end