class AddDetailToGoogleCalendars < ActiveRecord::Migration[5.1]
  def change
    add_column :google_calendars, :next_sync_token, :string
    add_column :google_calendars, :email, :string
    add_column :google_calendars, :refresh_token, :string
    add_column :google_calendars, :sync, :boolean, default: false, null: false
  end
end
