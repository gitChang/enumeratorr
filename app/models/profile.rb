class Profile < ApplicationRecord
  has_one_attached :profile_image

  before_validation :middlename_na
  before_validation :set_fullname


  validates :lastname, presence: true
  validates :firstname, presence: true

  validates :birthdate, presence: true
  validates :sex, presence: true

  validates :contactnumber, presence: true
  
  validate  :fullname_uniqueness


  private

  def middlename_na
    self.middlename = "" if middlename.present? && middlename.strip.downcase == "n/a"
  end


  def set_fullname
    name_parts = [lastname, firstname, middlename].compact.map(&:strip).reject(&:empty?)
    self.merged_names = name_parts.empty? ? "" : "#{name_parts.first}, #{name_parts[1..].join(' ')}".strip.downcase

    name_parts_two = [firstname, middlename, lastname].compact.map(&:strip).reject(&:empty?)
    self.merged_names_two = name_parts_two.empty? ? "" : "#{name_parts_two.first} #{name_parts_two[1..].join(' ')}".strip.downcase

    name_parts_lf = [lastname, firstname].compact.map(&:strip).reject(&:empty?)
    self.merged_names_lf = name_parts_lf.empty? ? "" : "#{name_parts_lf.first}, #{name_parts_lf[1..].join(' ')}".strip.downcase    
  
    name_parts_fl = [firstname, lastname].compact.map(&:strip).reject(&:empty?)
    self.merged_names_fl = name_parts_fl.empty? ? "" : "#{name_parts_fl.first} #{name_parts_fl[1..].join(' ')}".strip.downcase
  end


  def fullname_uniqueness
    se_query = "LEVENSHTEIN(TRIM(LOWER(merged_names)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_two)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_lf)), TRIM(LOWER(?))) <= 1 OR 
    LEVENSHTEIN(TRIM(LOWER(merged_names_fl)), TRIM(LOWER(?))) <= 1"

    if Profile
        .where.not(id: id)
        .where(se_query, self.merged_names, self.merged_names_two, self.merged_names_lf, self.merged_names_fl)
        .exists?
      errors.add(:base, "Your name already exists.")
      return
    end 
  end 
end
