require 'flagon'

describe Flagon do
  it "returns the env inspector by default" do
    inspector = described_class.configure
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::EnvLoader
  end

  it "returns the file inspector when passed a file name" do
    inspector = described_class.configure("/a/file/path")
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::FileLoader
  end

  it "returns the hash inspector when passed a config hash" do
    inspector = described_class.configure({a_flag: 'on'})
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::HashLoader
  end

  context "check_flag" do
    before do
      described_class.instance_variable_set(:@inspector, nil)
    end

    it "raises an error if flagon isn't initialized" do
      expect{described_class.check_flag(:something)}.
        to raise_exception(described_class::NotInitialized)
    end

    it "calls the instance after it is initialized" do
      inspector = described_class.configure
      expect(inspector).
        to receive(:check_flag)
      described_class.check_flag(:something)
    end
  end

  context "if_enabled" do
    before do
      described_class.instance_variable_set(:@inspector, nil)
    end

    it "raises an error if flagon isn't initialized" do
      expect{ described_class.if_enabled(:something) {} }.
        to raise_exception(described_class::NotInitialized)
    end

    it "calls the instance after it is initialized" do
      inspector = described_class.configure
      expect(inspector).
        to receive(:if_enabled)
      described_class.if_enabled(:something) {}
    end
  end
end
