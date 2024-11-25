module MemosHelper
  require "redcarpet"
  require "rouge"
  require "rouge/plugins/redcarpet"
  require "markdown_checkboxes"

  class CustomRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  @@markdown = CheckboxMarkdown.new(CustomRender, fenced_code_blocks: true)

  def renderMarkdown(text)
    @@markdown.render(text)
  end
end
