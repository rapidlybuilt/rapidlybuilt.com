module HasLayout
  def self.included(base)
    base.class_eval do
      helper_method :layout
    end
  end

  private

  def layout
    @layout ||= Layout.new
  end

  class Layout
    attr_accessor :title
    attr_accessor :title_suffix
    attr_accessor :content_css

    def dynamic?
      false
    end

    def full_title
      if title.present? && title_suffix.present?
        "#{title} - #{title_suffix}"
      elsif title.present?
        title
      elsif title_suffix.present?
        title_suffix
      end
    end

    def copyright_range
      this_year = Time.zone.now.year
      base_year = 2026

      if this_year == base_year
        base_year
      else
        "#{base_year} - #{this_year}"
      end
    end
  end
end
