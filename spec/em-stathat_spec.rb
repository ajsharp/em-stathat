require 'spec_helper'

describe EM::Stathat do
  subject { EM::Stathat }
  it { should == EM::StatHat }
end

describe EM::StatHat, '.config' do
  before do
    EM::StatHat.config { } # reset the config
  end

  it "can set ukey" do
    EM::StatHat.config do |c|
      c.ukey = 'thing'
    end
    EM::StatHat.config.ukey.should == 'thing'
  end

  it "returns a config instance" do
    EM::StatHat.config() {}.should be_instance_of EM::StatHat::Config
  end

  it "can reset stuff" do
    EM::StatHat.config do |c|
      c.ukey = 'thing'
    end

    EM::StatHat.config do |c|
      c.ukey = 'otherthing'
    end
    EM::StatHat.config.ukey.should == 'otherthing'
  end

  it "can set email" do
    EM::StatHat.config do |c|
      c.email = 'user@example.com'
    end
    EM::StatHat.config.email.should == 'user@example.com'
  end
end

describe EM::StatHat, 'initializing' do
  it "raises an error if EM::StatHat has not been configured" do
    EM::StatHat.config { |c| c.ukey = nil }
    expect {
      EM::StatHat.new
    }.to raise_error(RuntimeError, "You must configure EM::StatHat before using it!")
  end

  it "does not raise an error if ukey is configured" do
    EM::StatHat.config { |u| u.ukey = 'key' }
    expect { EM::StatHat.new }.not_to raise_error
  end

  it "sets the base url by default" do
    #EM::StatHat.new.base_url.should ==
  end
end

describe EM::StatHat, '.configured?' do
  before { EM::StatHat.config { } }
  subject { EM::StatHat.configured? }

  it "returns true if both email and ukey are set" do
    EM::StatHat.config { |c| c.ukey = 'key'; c.email = 'user@example.com' }
    EM::StatHat.should be_configured
  end

  it "returns false if only email is configured" do
    EM::StatHat.config { |c| c.ukey = nil; c.email = 'user@example.com' }
    EM::StatHat.should_not be_configured
  end

  it "returns false if only ukey is configured" do
    EM::StatHat.config { |c| c.ukey = 'key'; c.email = nil }
    EM::StatHat.should_not be_configured
  end

  it "returns false if both are unconfigured" do
    EM::StatHat.should_not be_configured
  end
end
