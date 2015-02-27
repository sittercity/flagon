require 'flagon/inspector'

describe Flagon::Inspector do
  let(:loader) { double(:loader, get_flag: true, exists?: true) }
  subject { described_class.new(loader) }

  it "can check a flag" do
    expect(subject.enabled?(:a_flag)).to be true
  end

  it "can execute a block if the flag is enabled" do
    test_object = double(:test_object)
    expect(test_object).to receive(:hello)
    subject.when_enabled(:a_flag) do
      test_object.hello
    end
  end

  it "returns false by default if a flag doesn't exist" do
    allow(loader).to receive(:exists?).and_return false
    expect(subject.enabled?(:a_flag)).to be false
  end

  it "can ensure a flag exists" do
    allow(loader).to receive(:exists?).and_return false
    expect{subject.ensure_flags_exist(:missing_flag)}.
      to raise_exception described_class::FlagMissing, "The following flags are missing: missing_flag"
  end

  it "can ensure multiple flags exist" do
    allow(loader).to receive(:exists?).and_return false
    expect{subject.ensure_flags_exist(:missing_flag, :another_missing_flag)}.
      to raise_exception described_class::FlagMissing, "The following flags are missing: missing_flag, another_missing_flag"
  end
end
