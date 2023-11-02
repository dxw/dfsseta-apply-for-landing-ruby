require "spec_helper"
require_relative "../../app/lib/submissions_reference_generator"

RSpec.describe SubmissionsReferenceGenerator do
  let(:reference) { SubmissionsReferenceGenerator.generate }

  describe "::generate" do
    it "always applies an 'APL' prefix (Apply for Landing)" do
      expect(reference).to match(/^AFL/)
    end

    it "includes a middle group of 3 numbers surrounded by hypens" do
      expect(reference).to match(/-\d{3}-/)
    end

    it "ends with a group of 3 uppercase letters preceeded by a hypen" do
      expect(reference).to match(/-[A-Z]{3}$/)
    end
  end
end
