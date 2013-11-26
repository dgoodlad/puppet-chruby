require 'spec_helper'

describe 'ruby' do
  let(:facts) { default_test_facts }

  let(:default_params) do
    {
      :default_gems      => [],
      :chruby_version    => '0.3.7',
      :chruby_root       => '/test/boxen/chruby',
      :chruby_rubies     => '/test/boxen/chruby/rubies',
      :rubybuild_version => 'v20131122.1',
      :user              => 'boxenuser'
    }
  end

  let(:params) { default_params }

  it do
    should include_class("ruby::params")

    should contain_file('/test/boxen/chruby').with_ensure('directory')
    should contain_file('/test/boxen/chruby/rubies').with_ensure('directory')

    should contain_exec('install chruby 0.3.7').with({
      'command' => 'curl -L https://github.com/postmodern/chruby/archive/v0.3.7.tar.gz | tar zx && (cd chruby-0.3.7 && make install)',
      'environment' => 'PREFIX=/test/boxen/chruby',
      'cwd' => '/tmp'
    })

    should contain_repository('/test/boxen/chruby/ruby-build').with_ensure('v20131122.1')

    should include_class("boxen::config")

    should contain_file('/test/boxen/env.d/chruby.sh').
      with_source('puppet:///modules/ruby/chruby.sh')
  end

  context "not darwin" do
    let(:facts) { default_test_facts.merge(:osfamily => "Linux") }

    it do
      should_not include_class("boxen::config")

      should_not contain_file('/test/boxen/env.d/chruby.sh').
        with_source('puppet:///modules/ruby/chruby.sh')
    end
  end
end
