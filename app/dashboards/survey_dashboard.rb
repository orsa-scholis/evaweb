# frozen_string_literal: true

require 'administrate/base_dashboard'

class SurveyDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  QUESTION_GROUP_SCOPE = (lambda do |first_associated|
    return QuestionGroup.not_associated if first_associated.nil?

    QuestionGroup.not_associated_or_with(first_associated.survey)
  end)

  NEW_ADMIN_QUESTION_GROUP_PATH = Rails.application.routes.url_helpers.new_admin_question_group_path.freeze
  ATTRIBUTE_TYPES = {
    question_groups: ScopedHasManyField.with_options(scope: QUESTION_GROUP_SCOPE,
                                                     new_path: NEW_ADMIN_QUESTION_GROUP_PATH),
    id: Field::Number,
    title: Field::String,
    title_de: Field::String,
    title_fr: Field::String,
    title_it: Field::String,
    active?: Field::Boolean,
    active_from: Field::DateTime,
    active_to: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    title
    active?
    active_from
    active_to
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    question_groups
    id
    title_de
    title_fr
    title_it
    active_from
    active_to
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    question_groups
    title_de
    title_fr
    title_it
    active_from
    active_to
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how surveys are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(survey)
    survey.title
  end
end
