CarrierWave.configure do |config|  
    if Rails.env.production?
        config.fog_credentials = {
            provider: 'AWS',
            aws_access_key_id: ENV['S3_ACCESS_KEY'],
            aws_secret_access_key: ENV['S3_SECRET_KEY'],
            region: ENV['S3_REGION']
        }
        config.fog_directory = ENV['S3_BUCKET']
    else
        config.storage = :file
        config.enable_processing = false if Rails.env.test?
    end

    config.cache_storage = :file
    config.asset_host = ActionController::Base.asset_host
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false

    # config.processors = [ :mini_magick ]

    config.cache_dir = "#{Rails.root}/tmp/uploads"
end
