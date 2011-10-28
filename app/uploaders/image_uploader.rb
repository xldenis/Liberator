# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  def geometry
    if self.file
    img = MiniMagick::Image.open(self.file.path)
    @geometry = {:width => img[:width], :height=> img[:height] }
    else
    nil
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

   def manualcrop
    return unless model.cropping?
    manipulate! do |img| 
      puts current_path
      img = img.crop(model.crop_x.to_i,model.crop_y.to_i,model.crop_w.to_i,model.crop_h.to_i) 
    end 
   end
   version :scaled_orig do
    process :resize_to_fit => [960,540]
   end
   version :large do
    process :manualcrop     
    process :resize_to_fit => [960,540]
  end
   version :thumb do
    process :manualcrop
    process :resize_to_fit => [100,100]
   
   end

   def extension_white_list
     %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
