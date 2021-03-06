#!/usr/bin/env bash
# This bootstraps Puppet on CentOS 6.x
# It has been tested on CentOS 6.3 64bit

set -e

REPO_URL="http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm"

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if git --version > /dev/null 2>&1; then
  echo "Git is already installed"
  exit 0
fi

yum -y install zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
wget -O v1.8.1.2.tar.gz https://github.com/git/git/archive/v1.8.1.2.tar.gz
tar -xzvf ./v1.8.1.2.tar.gz
cd git-1.8.1.2/
su
make prefix=/usr/local all
make prefix=/usr/local install
exit 0