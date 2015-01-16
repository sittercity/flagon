RSpec.shared_examples "a loader" do
  it "can check the key" do
    expect(subject).to respond_to :exists?
  end

  it "can get the flag" do
    expect(subject).to respond_to :get_flag
  end
end
