name              "lsoft-postgres"
maintainer        "Longevity Software, LLC"
maintainer_email  "longevitysoft@gmail.com"
license           "Apache 2.0"
description       "Installs and configures postgresql for clients or servers"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"
source_url        "https://github.com/" if respond_to?(:source_url)
issues_url        "https://github.com/" if respond_to?(:issues_url)
recipe            "lsoft_postgres", "Includes postgresql::server"

supports "ubuntu", "<= 16.04"

%w{debian fedora suse opensuse amazon}.each do |os|
  supports os
end

%w{redhat centos scientific oracle}.each do |el|
  supports el, "~> 6.0"
end

depends "group"
depends "user"
depends "postgresql", ">=4.0.0"
