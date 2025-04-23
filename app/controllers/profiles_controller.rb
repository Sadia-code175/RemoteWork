
class ProfilesController < ApplicationController
    before_action :authenticate_user!
    
    def show
      @profile = current_user.profile
    end
    
    def edit
      @profile = current_user.profile
    end
    
    def update
      @profile = current_user.profile
      
      if @profile.update(profile_params)
        redirect_to profile_path, notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end
    
    private
    
    def profile_params
      if current_user.freelancer?
        params.require(:freelancer_profile).permit(:skills, :projects, :cv_data, :hourly_rate)
      else
        params.require(:hiring_client_profile).permit(:company_name, :company_details, :website)
      end
    end
  end