module UsesOpenGraph
  extend ActiveSupport::Concern

  included do
    helper_method :open_graph
    helper_method :open_graph?

    before_action :set_open_graph_defaults
  end

  def open_graph
    @open_graph ||= OpenGraph.new
  end

  def open_graph?
    @open_graph.present?
  end

  def set_open_graph_defaults
    open_graph.url = request.original_url
    open_graph.domain = request.host
    open_graph.type = "website"
    open_graph.title = "Rapidly Built"
    open_graph.description = "Build in the open. Share what works."
    open_graph.image_url = view_context.image_url("opengraph.png")
  end

  class OpenGraph
    attr_accessor :locale, :type, :url, :title, :description, :image_url, :domain

    def initialize
      @locale = "en_US"
    end

    def tags(v)
      a = ActiveSupport::SafeBuffer.new

      description = self.description if self.description.present?
      description = description.strip.gsub(/\s+/, " ") if description.present?
      description = description.truncate(100, separator: " ", omission: "...") if description.present?

      a << v.tag(:meta, property: "og:locale",       content: locale) if locale.present?
      a << v.tag(:meta, property: "og:type",         content: "article")
      a << v.tag(:meta, property: "og:url",          content: url) if url.present?
      a << v.tag(:meta, property: "og:title",        content: title) if title.present?
      a << v.tag(:meta, property: "og:description",  content: description) if description.present?
      a << v.tag(:meta, property: "og:image",        content: image_url) if image_url.present?

      a << v.tag(:meta, name: "twitter:title",       content: title) if title.present?
      a << v.tag(:meta, name: "twitter:description", content: description) if description.present?
      a << v.tag(:meta, name: "twitter:card",        content: "summary_large_image") if image_url.present?
      a << v.tag(:meta, name: "twitter:image",       content: image_url) if image_url.present?
      a << v.tag(:meta, name: "twitter:domain",      content: domain) if domain.present?
      a << v.tag(:meta, name: "twitter:url",         content: url) if url.present?

      a
    end
  end
end
