require 'flagon/loader/env_loader'
require 'support/shared_loader_specs'

describe Flagon::Loader::EnvLoader do
  it_behaves_like "a loader"

  it "can return a key" do
    ENV['A_KEY'] = 'on'
    expect(subject.get_flag(:a_key)).
      to be true
  end

  it "can report a key that is off" do
    ENV['A_KEY'] = 'off'
    expect(subject.get_flag(:a_key)).
      to be false
  end

  it "evaluates a blank key as off" do
    ENV['BLANK_KEY'] = 'off'
    expect(subject.get_flag(:blank_key)).
      to be false
  end

  it "detects keys" do
    ENV['A_KEY'] = 'off'
    expect(subject.exists?(:a_key)).to be true
  end

  it "detects blank keys" do
    ENV['BLANK_KEY'] = ''
    expect(subject.exists?(:blank_key)).to be true
  end

  it "can detect a missing key" do
    expect(subject.exists?(:non_existant)).to be false
  end
end
