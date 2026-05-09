module ApplicationHelper
  def markdown(text)
  renderer = Redcarpet::Render::HTML.new(
    filter_html: true,
    hard_wrap: true
  )

  markdown = Redcarpet::Markdown.new(
    renderer,
    fenced_code_blocks: true,
    autolink: true,
    tables: true
  )

  html = markdown.render(text)

  formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")

  highlighted = html.gsub(/<pre><code( class="(.*?)")?>(.*?)<\/code><\/pre>/m) do
    lang = $2
    code = CGI.unescapeHTML($3)

    lexer = if lang
                Rouge::Lexer.find(lang) || Rouge::Lexers::PlainText
            else
                Rouge::Lexer.find_fancy(nil, code)
            end

    highlighted_code = formatter.format(lexer.lex(code))

    <<~HTML
    <div class="code-block">
      <button class="copy-btn">コピー</button>
      #{highlighted_code}
    </div>
    HTML
  end

  highlighted.html_safe
end
end