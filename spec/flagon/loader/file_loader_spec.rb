require 'flagon/loader/file_loader'
require 'support/shared_loader_specs'

describe Flagon::Loader::FileLoader do
  let(:file_name) { File.expand_path('../../../support/flags.yaml', __FILE__) }

  subject { described_class.new(file_name) }

  it_behaves_like "a loader"

  it "can check if a flag exists" do
    expect(subject.exists?(:feature_1)).to be true
    expect(subject.exists?(:non_existant)).to be false
  end

  it "can get a flag" do
    expect(subject.get_flag(:feature_1)).to be true
    expect(subject.get_flag(:feature_2)).to be false
  end
end
