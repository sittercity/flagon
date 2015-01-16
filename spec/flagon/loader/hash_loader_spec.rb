require 'flagon/loader/hash_loader'
require 'support/shared_loader_specs'

describe Flagon::Loader::HashLoader do
  let(:init_hash) { {a_flag: 'on', another_flag: 'false'} }

  subject { described_class.new(init_hash) }

  it_behaves_like "a loader"

  it "can check if a flag exists" do
    expect(subject.exists?(:a_flag)).to be true
    expect(subject.exists?(:non_existant)).to be false
  end

  it "can get a flag" do
    expect(subject.get_flag(:a_flag)).to be true
    expect(subject.get_flag(:another_flag)).to be false
  end
end
