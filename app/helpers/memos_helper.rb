module MemosHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class CustomRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end


  @@markdown = Redcarpet::Markdown.new(CustomRender, fenced_code_blocks: true)

  def renderMarkdown(text)
    @@markdown.render(text)
  end
end
