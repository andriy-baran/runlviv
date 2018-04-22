require "administrate/base_dashboard"

class RunDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group_run: Field::BelongsTo,
    id: Field::Number,
    place: Field::String,
    distance: Field::String,
    tempo: Field::String,
    beginning: Field::DateTime,
    competition_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :id,
    :place,
    :distance,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :place,
    :distance,
    :tempo,
    :beginning,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :place,
    :distance,
    :tempo,
    :beginning,
    :approved
  ].freeze

  # Overwrite this method to customize how runs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(run)
  #   "Run ##{run.id}"
  # end
end
