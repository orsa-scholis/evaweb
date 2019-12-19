# frozen_string_literal: true

class SurveyEntry < ApplicationRecord
  belongs_to :survey, inverse_of: :survey_entries
  has_many :answers

  after_create_commit :broadcast_statistics

  private

  def broadcast_statistics
    BroadcastSurveyStatsJob.perform_later survey
  end
end
