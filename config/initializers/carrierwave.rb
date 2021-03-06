if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = true
  end

  # make sure our uploader is auto-loaded
  # PdfUploader
  ImageUploader

  # use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider => 'AWS',
        :aws_access_key_id => ENV['S3_ID'],
        :aws_secret_access_key => ENV['S3_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET'] # required
    config.fog_authenticated_url_expiration = 20000
    config.fog_public = false
  end
end