# frozen_string_literal: true

def cleanup_rpm
  on hosts, %(
    dnf erase -y rke2\\*
    rm -f /etc/yum.repos.d/rancher\\*
  )
end

RSpec.configure do |c|
  c.before(:context, :cleanup_rpm) do
    cleanup_rpm
  end
end
