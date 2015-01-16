require 'flagon/inspector'

describe Flagon::Inspector do
  let(:loader) { double(:loader, get_flag: true, exists?: true) }
  subject { described_class.new(loader) }

  it "can check a flag" do
    expect(subject.check_flag(:a_flag)).to be true
  end

  it "raises an exception on a missing flag" do
    allow(loader).to receive(:exists?).and_return false
    expect{subject.check_flag(:missing_flag)}.
      to raise_exception described_class::FlagMissing, "The flag missing_flag is missing"
  end

  it "can execute a block if the flag exists" do
    test_object = double(:test_object)
    expect(test_object).to receive(:hello)
    subject.if_enabled(:a_flag) do
      test_object.hello
    end
  end
end
