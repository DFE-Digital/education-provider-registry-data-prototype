require "govuk_markdown"

Nanoc::Filter.define(:govuk_markdown) do |content, _params|
  html = GovukMarkdown.render(content, { headings_start_with: "l" })

  html = html.gsub(/href="((?:\.\.?\/)[^":?#]+)\.md([?#][^"]*)?"/) do
    path = Regexp.last_match(1)
    suffix = Regexp.last_match(2).to_s
    output_path = path.end_with?("/index") || path == "./index" || path == "../index" ? "#{path}.html" : "#{path}/index.html"

    %(href="#{output_path}#{suffix}")
  end

  html
end
