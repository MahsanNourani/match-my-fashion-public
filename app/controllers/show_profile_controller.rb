class ShowProfileController < ApplicationController
  # Associated with the view that displays after a profile is selected from the search results list
  def show_profile
    if session[:current_user_key] != nil or params[:user_key] != nil
      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key" + user_key_current.to_s

      if GeneralInfo.exists?(:userKey => user_key_current)
        @general_info = GeneralInfo.find_by(userKey: user_key_current)
        @general_info_attributes = GeneralInfo.attribute_names
        @general_info_values = @general_info.attribute_values
        
        if session[:current_user_key] != nil and params[:user_key] == nil
          @login_user_true = session[:current_user_key]
        end

        case @general_info.specific_profile_id
        when 1
          @profile_type = "Designer"
          if SpecificDesigner.exists?(:user_key => user_key_current)
            @specific_designer = SpecificDesigner.find_by(user_key: user_key_current)
            @profile_info = @specific_designer.attribute_values
          else
            #stuff
          end
        when 2
          @profile_type = "Model"
          if SpecificModel.exists?(:user_key => user_key_current)
            @specific_model = SpecificModel.find_by(user_key: user_key_current)
            @profile_info = @specific_model.attribute_values
          else
            #stuff
          end
        when 3
          @profile_type = "Photographer"
          if SpecificPhotographer.exists?(:user_key => user_key_current)
            @specific_photographer = SpecificPhotographer.find_by(user_key: user_key_current)
            @profile_info = @specific_photographer.attribute_values
          else
            #stuff
          end
        else
          puts "Unknown profile type! Profile type given: "
          @profile_type = "Error"
        end
      else
        #SHOULD SHOW BLANK STUFF!!!!
        @general_info = GeneralInfo.new
        @general_info_values = Hash.new
        
      end
    else
      redirect_to "/login_info/login"
    end
  end
end
