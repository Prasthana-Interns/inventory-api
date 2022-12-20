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

    scope :search, ->(search) {(search.nil? ? index : where('lower(name) LIKE lower(?) OR lower(device_type) LIKE lower(?)', "%#{search}%", "%#{search}%"))}
    scope :assigned_list, ->{where.not(user_id: nil)} 
    scope :unassigned_list, ->{where(user_id: nil)}

 private

    def create_dev_no
     update(device_no:"DEV_#{self.id.to_s.rjust(3,'0')}")
    end

    def add_default_image
     image.attach(
        io:File.open(
            Rails.root.join( 'lib',default_url  )
        ),filename:'image',
        content_type:'image.jpeg'
      )
    end

end