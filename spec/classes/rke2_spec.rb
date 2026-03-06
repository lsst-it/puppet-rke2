# frozen_string_literal: true

require 'spec_helper'

describe 'rke2' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_class('rke2::repo') }
      it { is_expected.to contain_class('rke2::install') }
      it { is_expected.to contain_class('rke2::service') }

      context 'with manage_repo => false' do
        let(:params) { { manage_repo: false } }

        it { is_expected.to compile }
        it { is_expected.not_to contain_class('rke2::repo') }
        it { is_expected.to contain_class('rke2::install') }
        it { is_expected.to contain_class('rke2::service') }
      end
    end
  end
end
