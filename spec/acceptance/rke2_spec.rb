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

    describe package('rke2-server') do
      it { is_expected.to be_installed }
      it { is_expected.to be_installed.with_version('1.28') }
    end
  end

  context 'without release_series 1.30', :cleanup_rpm do
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

    describe package('rke2-server') do
      it { is_expected.to be_installed }
      it { is_expected.to be_installed.with_version('1.30') }
    end
  end
end
