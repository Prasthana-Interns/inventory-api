class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def default_path
    case Device.last.device_type.downcase
    when "laptop"
      'laptop.png'
    when "bag"
      'bag.jpeg' 
    when "mobile"
      'mobile.jpeg' 
    when "mouse"
      'Mouse.jpeg' 
    when "charger"
      'charger.jpeg' 
    else
      'no_img.png'      
    end
  end
end
