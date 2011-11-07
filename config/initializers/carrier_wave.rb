CarrierWave.configure do |config|
config.cache_dir = "#{Rails.root}/tmp/uploads"
config.fog_credentials = {
  :provider             => 'AWS'
  :aws_accesws_key_id   => ENV['S3_KEY']
  :aws_secret_access_key=> ENV['S3_SECRET']
}
config.fog_directory = 'uploads'
end
