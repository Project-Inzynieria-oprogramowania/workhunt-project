module ApplicationHelper
    include Pagy::Frontend

    def full_title(page_title = "")
        base_title = "WorkHunt"
        if page_title.present?
            "#{page_title} | #{base_title}"
        else
            base_title
        end
    end

    def pagy_url_for(pagy, page, absolute: false)
        url_params = "?#{pagy.vars[:page_params]}"
        url = url_for(url_params)
        url += "&page=#{page}"
        url
    end
end
