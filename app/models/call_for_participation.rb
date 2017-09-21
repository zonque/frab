class CallForParticipation < ApplicationRecord
  belongs_to :conference, optional: true

  validates :start_date, :end_date, presence: true

  has_paper_trail

  def to_s
    "#{model_name.human}: #{conference.title}"
  end

  def in_the_future?
    start_date > Date.today
  end

  def still_running?
    end_date > Date.today
  end

  def is_open?
    Time.zone.now > start_date and Time.zone.now < end_date
  end
end
