require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      :provider => 'AWS',
      :region => ENV['S3_REGION'],
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
      # path_style: true
    }
    config.fog_directory = ENV['S3_BUCKET']
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end