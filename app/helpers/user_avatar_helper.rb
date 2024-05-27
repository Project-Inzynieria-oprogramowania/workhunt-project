module UserAvatarHelper
    def get_avatar(user)
        if user.avatar.present?
            user.avatar.image.url
        else
            asset_path('profile-picture-placeholder.png')
        end
    end
end