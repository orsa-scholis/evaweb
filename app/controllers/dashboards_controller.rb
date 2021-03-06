# frozen_string_literal: true

class DashboardsController < ApplicationController
  layout 'dashboards'

  before_action :load_survey
  before_action :load_survey_statistics
  before_action :generate_qr_code

  def index; end

  private

  def load_survey
    @survey = Survey.find(params[:id])
  end

  def load_survey_statistics
    @survey_statistics = AnswerGroupCalculationService.new(@survey).calculate
  end

  def generate_qr_code
    @qr_code = QrCodeService.new(@survey.short_url)
  end
end
