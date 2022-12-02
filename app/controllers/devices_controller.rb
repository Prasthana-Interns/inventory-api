class DevicesController < ApplicationController
     before_action :authorize_admin_access
def index
    devices = Device.all
    render json: devices, each_serializer: DeviceSerializer, status: :ok
 end

 def search
     @device = Device.search(params[:search])
     render json: @device, each_serializer: DeviceSerializer, status: :ok
 end

 def create
     @device = Device.create(device_params)
     render json: @device, serializer: DeviceSerializer, status: :ok
 end

 def destroy
     device = find_devices
     device.destroy 
 end

 def update
     device = find_devices
     device.update(device_params)
     render json: device, serializer: DeviceSerializer, status: :ok
 end

 def assigned
     devices = Device.where.not(user_id: nil)
     render json: devices, each_serializer: DeviceSerializer, status: :ok
 end

 def unassigned
     devices = Device.where(user_id: nil)
     render json: devices, each_serializer: DeviceSerializer, status: :ok
 end

 private

   def device_params
     params.require(:device).permit(:name, :device_type, :os, :user_id)
   end

   def find_devices
     Device.find_by(device_no: params[:device][:device_no])
   end
end
