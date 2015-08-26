RSpec.describe "test group" do
  it "has access to the helper methods defined in the module" do
    expect(help).to be(:available)
  end
end