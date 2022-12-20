class DevicesController < ApplicationController
      before_action :authorize_admin_access
      before_action :find_device, only: [:destroy, :update]
      
   def index
      devices = Device.all.order(created_at: :asc)
      render json: devices, each_serializer: DeviceSerializer, status: :ok
   end

   def search
      device = Device.search(params[:search]).order(created_at: :asc)
      render json: device, each_serializer: DeviceSerializer, status: :ok
   end

   def create
      begin
         device = Device.create!(device_params)
         render json: device, serializer: DeviceSerializer, status: :created
      rescue ActiveRecord::RecordInvalid => e 
         render json: { error: e.message }, status: :unprocessable_entity
      end
   end

   def destroy
     @device.destroy
   end

   def update
      @device.update(device_params)
      render json: @device, serializer: DeviceSerializer, status: :ok
   end

   def assigned
      devices = Device.assigned_list.order(created_at: :asc)
      render json: devices, each_serializer: DeviceSerializer, status: :ok
   end

   def unassigned
      devices = Device.unassigned_list.order(created_at: :asc)
      render json: devices, each_serializer: DeviceSerializer, status: :ok
   end

 private

   def device_params
      params.require(:device).permit(:name, :device_type, :os, :user_id)
   end

   def find_device
      @device = Device.find(params[:id])
   end

end
