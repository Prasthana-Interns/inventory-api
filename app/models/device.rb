class Device < ApplicationRecord
    belongs_to :user, optional: true
    after_create :create_dev_no
    validates :name, presence: true
    validates :device_type, presence: true
    has_one_attached :image
    after_create :add_default_image

    def image_url
     Rails.application.routes.url_helpers.url_for(image) if image.attached?
    end

    scope :search, ->(search) {(search.nil? ? all : where('lower(name) LIKE lower(?) OR lower(device_type) LIKE lower(?)', "%#{search}%", "%#{search}%"))}
    scope :assigned_list, ->{where.not(user_id: nil)} 
    scope :unassigned_list, ->{where(user_id: nil)}
 private

    def create_dev_no
     update(device_no:"DEV-#{self.id.to_s.rjust(3,'0')}")
    end

    def add_default_image
     image_path = default_path
     image.attach(
        io:File.open(
            Rails.root.join( 'lib',image_path )
        ),filename: image_path
      )
    end

end