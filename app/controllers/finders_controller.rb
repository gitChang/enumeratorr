class FindersController < ApplicationController

  def index
    render "index"
  end


  def lookup
    name_of_enum = params[:enum_name]&.strip.upcase
    return redirect_to root_path, notice: "Name not found!" if name_of_enum.blank?

    se_query = "LEVENSHTEIN(TRIM(LOWER(merged_names)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_two)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_lf)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_fl)), TRIM(LOWER(?))) <= 1"

    @profile = Profile.where(se_query, name_of_enum, name_of_enum, name_of_enum, name_of_enum).first

    if @profile
      redirect_to show_profile_url(@profile.id)
    else
      redirect_to root_path, notice: "Name not found! Pls. Register."
    end
  end


  def summarize
    @all_enumerator = Profile.order(:id)

    @asn = @all_enumerator.where("address ILIKE ?", "%asuncion%")
    @kap = @all_enumerator.where("address ILIKE ?", "%kapalong%")
    @nc = @all_enumerator.where("address ILIKE ?", "%new corella%")
    @si = @all_enumerator.where("address ILIKE ?", "%san isidro%")
    @tag = @all_enumerator.where("address ILIKE ?", "%tagum%")
    @tal = @all_enumerator.where("address ILIKE ?", "%talaingod%")

    excluded_addresses = ["asuncion", "kapalong", "new corella", "san isidro", "tagum", "talaingod"]
    
    @noadd = @all_enumerator.where("address NOT ILIKE ALL(ARRAY[?])", excluded_addresses.map { |addr| "%#{addr}%" })

    render "summarize"
  end

end
