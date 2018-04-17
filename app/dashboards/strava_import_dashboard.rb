require "administrate/base_dashboard"

class StravaImportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    strava_id: Field::Number,
    distance: Field::Number.with_options(decimals: 2),
    name: Field::String,
    avg_speed: Field::Number.with_options(decimals: 2),
    beginning: Field::DateTime,
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
    :strava_id,
    :distance,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :strava_id,
    :distance,
    :name,
    :avg_speed,
    :beginning,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :strava_id,
    :distance,
    :name,
    :avg_speed,
    :beginning,
  ].freeze

  # Overwrite this method to customize how strava imports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(strava_import)
  #   "StravaImport ##{strava_import.id}"
  # end
end
