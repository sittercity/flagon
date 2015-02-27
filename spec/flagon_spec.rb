require 'flagon'

describe Flagon do
  it "can create an env loader" do
    loader = described_class.env_loader
    expect(loader).to be_a Flagon::Loader::EnvLoader
  end

  it "can create a file loader" do
    loader = described_class.file_loader("/a/file/name")
    expect(loader).to be_a Flagon::Loader::FileLoader
  end

  it "can create a hash loader" do
    loader = described_class.hash_loader({})
    expect(loader).to be_a Flagon::Loader::HashLoader
  end

  context "init" do
    it "uses the env loader by default" do
      inspector = described_class.init
      expect(inspector).to be_a Flagon::Inspector
      expect(inspector.loader).to be_a Flagon::Loader::EnvLoader
    end

    it "allows injection of a custom loader" do
      loader = double(:loader)
      inspector = described_class.init(loader)
      expect(inspector).to be_a Flagon::Inspector
      expect(inspector.loader).to be loader
    end
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

  context "ensure_flags_exist" do
    before do
      described_class.instance_variable_set(:@inspector, nil)
    end

    it "raises an error if flagon isn't initialized" do
      expect{described_class.ensure_flags_exist(:something)}.
        to raise_exception(described_class::NotInitialized)
    end

    it "calls the instance after it is initialized" do
      inspector = described_class.init
      expect(inspector).to receive(:ensure_flags_exist).with(:something)
      described_class.ensure_flags_exist(:something)
    end
  end
end
