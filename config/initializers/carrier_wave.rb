CarrierWave.configure do |config|
config.cache_dir = "uploads"
require 'carrierwave/processing/mini_magick'
end
