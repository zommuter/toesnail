source "https://rubygems.org"

# Local build/test toolchain for the GitHub-Pages site. GH Pages itself builds
# remotely; this Gemfile is for `bundle exec jekyll build/serve` and the render
# tests in tests/ (no handoff — just local TDD; see tests/README.md).
gem "jekyll", "~> 4.4"
gem "minima"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
end

# Ruby 3.4 removed these from the default gem set; Jekyll still requires them.
gem "erb"
gem "csv"
gem "base64"
gem "logger"
gem "bigdecimal"
