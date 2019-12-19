# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to belong_to :question_group }
  it { is_expected.to have_many :answers }
end
