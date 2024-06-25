# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'rke2 class' do
  context 'without any parameters', :cleanup_rpm do
    include_examples 'the example', 'simple.pp'

    it_behaves_like 'an idempotent resource'

    %w[
      rancher-rke2-common-stable
      rancher-rke2-1.28-stable
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    %w[
      rke2-common
      rke2-server
    ].each do |pkg|
      describe package(pkg) do
        it { is_expected.to be_installed }
        it { is_expected.to be_installed.with_version('1.28') }
      end
    end
  end

  context 'release_series 1.30', :cleanup_rpm do
    include_examples 'the example', 'release_series_1_30.pp'

    it_behaves_like 'an idempotent resource'

    %w[
      rancher-rke2-common-stable
      rancher-rke2-1.30-stable
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    %w[
      rke2-common
      rke2-server
    ].each do |pkg|
      describe package(pkg) do
        it { is_expected.to be_installed }
        it { is_expected.to be_installed.with_version('1.30') }
      end
    end
  end

  context 'version not the most recent in release series', :cleanup_rpm do
    include_examples 'the example', 'version.pp'

    it_behaves_like 'an idempotent resource'

    %w[
      rancher-rke2-common-stable
      rancher-rke2-1.28-stable
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    %w[
      rke2-common
      rke2-server
    ].each do |pkg|
      describe package(pkg) do
        it { is_expected.to be_installed }
        it { is_expected.to be_installed.with_version('1.28.2~rke2r1') }
      end
    end
  end

  context 'versionlock true', :cleanup_rpm do
    include_examples 'the example', 'versionlock.pp'

    it_behaves_like 'an idempotent resource'

    %w[
      rancher-rke2-common-stable
      rancher-rke2-1.30-stable
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    %w[
      rke2-common
      rke2-server
    ].each do |pkg|
      describe package(pkg) do
        before(:each) do
          # check that the versionlock prevents upgrades
          on hosts, 'dnf update -y rke2\*'
        end

        it { is_expected.to be_installed }
        it { is_expected.to be_installed.with_version('1.30.0~rke2r1') }
      end

      describe command('dnf versionlock list') do
        its(:exit_status) { is_expected.to eq(0) }
        its(:stdout) { is_expected.to match(/#{pkg}-0:1.30.0~rke2r1/) }
      end
    end
  end

  context 'with config', :cleanup_rpm do
    include_examples 'the example', 'config.pp'

    it_behaves_like 'an idempotent resource'

    %w[
      rancher-rke2-common-stable
      rancher-rke2-1.30-stable
    ].each do |repo|
      describe yumrepo(repo) do
        it { is_expected.to exist }
        it { is_expected.to be_enabled }
      end
    end

    %w[
      rke2-common
      rke2-server
    ].each do |pkg|
      describe package(pkg) do
        before do
          # check that the versionlock prevents upgrades
          on hosts, 'dnf update -y rke2\*'
        end

        it { is_expected.to be_installed }
        it { is_expected.to be_installed.with_version('1.30.0~rke2r1') }
      end

      describe command('dnf versionlock list') do
        its(:exit_status) { is_expected.to eq(0) }
        its(:stdout) { is_expected.to match(%r{#{pkg}-0:1.30.0~rke2r1}) }
      end
    end

    describe file('/etc/rancher/rke2/config.yaml') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match(<<~CONFIG) }
        ---
        tls-san:
        - rke2.example.com
        node-label:
        - role=storage-node
        disable:
        - rke2-ingress-nginx
        disable-cloud-controller: true
      CONFIG
    end
  end
end
