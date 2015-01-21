require 'flagon'

describe Flagon do
  it "returns the env inspector by default" do
    inspector = described_class.init
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::EnvLoader
  end

  it "returns the file inspector when passed a file name" do
    inspector = described_class.init("/a/file/path")
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::FileLoader
  end

  it "returns the hash inspector when passed a config hash" do
    inspector = described_class.init({a_flag: 'on'})
    expect(inspector).to be_a Flagon::Inspector
    expect(inspector.loader).to be_a Flagon::Loader::HashLoader
  end

  context "enabled?" do
    before do
      described_class.instance_variable_set(:@inspector, nil)
    end

    it "raises an error if flagon isn't initialized" do
      expect{described_class.enabled?(:something)}.
        to raise_exception(described_class::NotInitialized)
    end

    it "calls the instance after it is initialized" do
      inspector = described_class.init
      expect(inspector).
        to receive(:enabled?)
      described_class.enabled?(:something)
    end
  end

  context "when_enabled" do
    before do
      described_class.instance_variable_set(:@inspector, nil)
    end

    it "raises an error if flagon isn't initialized" do
      expect{ described_class.when_enabled(:something) {} }.
        to raise_exception(described_class::NotInitialized)
    end

    it "calls the instance after it is initialized" do
      inspector = described_class.init
      expect(inspector).
        to receive(:when_enabled)
      described_class.when_enabled(:something) {}
    end
  end
end
