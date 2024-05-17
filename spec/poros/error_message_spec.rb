require 'rails_helper'

RSpec.describe ErrorMessage do
  it "exists and can initialize" do
    message = "Record not found"
    status_code = 404
    error = ErrorMessage.new(message, status_code)

    expect(error).to be_a ErrorMessage
    expect(error.message).to eq("Record not found")
    expect(error.status_code).to eq(404)
  end
end