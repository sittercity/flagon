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
end
