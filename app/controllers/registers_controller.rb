class RegistersController < ApplicationController

  def new
    render "new"
  end


  def create
    @profile = Profile.new profile_params

    if !@profile.save
      flash.now[:notice] = @profile.errors.first.full_message
      puts @profile.errors.first.full_message
      render :new, status: :unprocessable_entity
      return
    else
      if params[:profile_image].present?
        @profile.profile_image.attach(params[:profile_image])
      end

      redirect_to show_profile_url(@profile.id), notice: "Your profile has been created!"
    end
  end


  def edit
    @profile = Profile.find(params[:id])
  end


  def update
    profile = Profile.find(params[:id])
  
    # Update attributes using strong parameters
    if profile.update(profile_params)
      # Attach the profile image if provided
      if params[:profile_image].present?
        profile.profile_image.attach(params[:profile_image])
      end
  
      redirect_to show_profile_url(profile.id), notice: "Your data has been updated!"
    else
      redirect_to edit_profile_url(profile.id), notice: "Fields with * are required."
    end
  end


  def show
    @profile = Profile.find(params[:id])

    # Generate the QR code
    @qr = RQRCode::QRCode.new(@profile.merged_names).as_png
  end

  
  private
  
  def profile_params
    params.require(:profile).permit(:profile_image, :lastname, :firstname, :middlename, :birthdate, :sex, :address, :contactnumber, :email)
  end

end
