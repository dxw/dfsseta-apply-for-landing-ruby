class AddDecisionEnumToLandingApplication < ActiveRecord::Migration[7.2]
  def change
    change_column :landing_applications, :application_decision, "integer USING CAST(application_decision AS integer)"
  end
end
