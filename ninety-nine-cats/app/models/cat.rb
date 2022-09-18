require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  CAT_COLORS = ["Black", "White", "Orange", "Brown"]

  validates :birth_date, presence: true
  validates :color, presence: true, inclusion: { in: CAT_COLORS }
  validates :name, presence: true
  validates :sex, presence: true, inclusion: { in: ["M", "F"] }
  validate :birth_date, :birth_date_cannot_be_future

  def birth_date_cannot_be_future
    if birth_date && birth_date > Date.today
      self.errors.add(:birth_date, "can't be in the future")
    end
  end

  def age
    cat_year = Date.today.year - birth_date.year
    cat_year -= 1 if Date.today < birth_date + cat_year.years
    
    if cat_year > 0 # return about x years
      return "About #{cat_year} years"
    else # return about x months
      cat_month = Date.today.month - birth_date.month
      return "About #{cat_month} months"
    end
  end
end

# about x years
# over x years
# about x months