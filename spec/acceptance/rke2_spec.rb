# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'rke2 class' do
  context 'without any parameters' do
    include_examples 'the example', 'simple.pp'

    it_behaves_like 'an idempotent resource'

    describe yumrepo('rancher-rke2-common-stable') do
      it { should exist }
      it { should be_enabled }
    end

    describe yumrepo('rancher-rke2-1.28-stable') do
      it { should exist }
      it { should be_enabled }
    end
  end

  context 'without release_series 1.30' do
    include_examples 'the example', 'release_series_1_30.pp'

    it_behaves_like 'an idempotent resource'

    describe yumrepo('rancher-rke2-common-stable') do
      it { should exist }
      it { should be_enabled }
    end

    describe yumrepo('rancher-rke2-1.28-stable') do
      it { should_not exist }
    end

    describe yumrepo('rancher-rke2-1.30-stable') do
      it { should exist }
      it { should be_enabled }
    end
  end
end
