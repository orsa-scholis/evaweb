# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :question_groups, inverse_of: :survey, dependent: :destroy
  has_many :survey_entries, inverse_of: :survey, dependent: :destroy
  has_many :questions, through: :question_groups, inverse_of: :survey
  has_many :answer_possibility_submissions, through: :question_groups

  validates :active_from, :active_to, :title, presence: true
  validates :active_from, timeliness: { type: :datetime }
  validates :active_to, timeliness: { type: :datetime, after: :active_from }

  translates :title
  globalize_accessors

  scope :active, -> { where('active_from <= ? AND active_to >= ?', Time.zone.now, Time.zone.now) }
  scope :descending, -> { order(active_to: :desc) }

  def active?
    Time.zone.now.in?(active_from..active_to)
  end

  def short_url
    return self[:short_url] if self[:short_url].present?

    update(short_url: UrlShortenService.new.shorten(survey_entries_url))

    self[:short_url]
  end

  private

  def survey_entries_url
    Rails.application.routes.url_helpers.survey_entries_url(id, host: ENV.fetch('APP_HOST', 'localhost'))
  end
end
