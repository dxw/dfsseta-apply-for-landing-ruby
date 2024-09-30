class AddDecisionEnumToLandingApplication < ActiveRecord::Migration[7.2]
  def change
    remove_column :landing_applications, :application_decision
    add_column :landing_applications, :application_decision, :integer
  end
end
