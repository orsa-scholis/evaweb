# frozen_string_literal: true

class SurveyEntryBlueprint
  def initialize(survey)
    @survey = survey
  end

  def survey_entry
    entry = @survey.survey_entries.new
    build_answers(entry)
    entry
  end

  private

  def build_answers(entry)
    @survey.question_groups.includes(:questions).each do |question_group|
      question_group.questions.each { |question| entry.answers.build(question: question) }
    end
  end
end
