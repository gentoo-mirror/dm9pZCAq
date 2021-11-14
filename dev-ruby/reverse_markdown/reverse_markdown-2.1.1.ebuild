# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Ruby gem to convert html into markdown"
HOMEPAGE="
	https://rubygems.org/gems/reverse_markdown
	https://github.com/xijo/reverse_markdown
"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64"

ruby_add_rdepend "dev-ruby/nokogiri"

ruby_add_bdepend "test? ( dev-ruby/kramdown )"
