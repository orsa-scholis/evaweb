# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  belongs_to :survey, inverse_of: :question_groups, required: false

  has_many :questions, dependent: :destroy, inverse_of: :question_group
  has_many :answer_possibility_submissions, dependent: :restrict_with_exception

  translates :description
  globalize_accessors

  scope :not_associated_or_with, ->(survey) { where(survey: survey).or(QuestionGroup.not_associated) }
  scope :not_associated, -> { where(survey: nil) }

  def questions_min_possible_value
    questions.map do |question|
      question.answer_possibilities.minimum(:value)
    end.min
  end

  def questions_max_possible_value
    questions.map do |question|
      question.answer_possibilities.maximum(:value)
    end.max
  end
end
