class UsersController < ApplicationController
   def index
        participants = Participant.all

        render json: participants
    end
    
    
    def create
        participant = Participant.create(participant_params)

        
        
        params[:roles].each do |role|
            ParticipantRole.create(participant: participant, role_id: role.to_i)
        end
        
        render json: participant, serializer: ParticipantSerializer
    end

    def show
        participant = Participant.find(params[:id])

        render json: participant 
    end


    private

    def participant_params
        params.require(:participant).permit(:name, :mobile_number)
    end
end
