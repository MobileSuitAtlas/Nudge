class Entry < ApplicationRecord
  belongs_to :habit

  validates :content, presence: true

  # Default to today's date if not specified
  before_validation :set_default_date, if: -> { entry_date.blank? }

  private

  def set_default_date
    self.entry_date ||= Date.today
  end
end
