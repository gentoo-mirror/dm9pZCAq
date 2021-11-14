# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby30"

inherit ruby-fakegem

DESCRIPTION="A Ruby Gem to detect under what license a project is distributed"
HOMEPAGE="
	https://licensee.github.io/licensee/
	https://github.com/licensee/licensee
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	dev-ruby/dotenv
	dev-ruby/octokit
	dev-ruby/reverse_markdown

	>=dev-ruby/rugged-0.24.0
	<dev-ruby/rugged-2.0.0

	>=dev-ruby/thor-0.19.0
	<dev-ruby/thor-2.0.0
"
