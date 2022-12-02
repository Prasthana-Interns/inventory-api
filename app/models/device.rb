class Device < ApplicationRecord
    belongs_to :user, optional: true
    after_create :create_dev_no
    validates :name, presence: true
    validates :device_type, presence: true

    def self.search(search)
        if search
           where("name LIKE ? OR device_type LIKE ?", "%#{search}%", "%#{search}%")
        end
    end

private
    def create_dev_no
        update(device_no:"DEV_#{self.id.to_s.rjust(3,'0')}")
    end
end