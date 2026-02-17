# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/concerns/replays_actions_with_cookie.rb
module UiDocs
  module ReplaysActionsWithCookie
    private

    def find_cookie_actions(name, **kwargs)
      CookieActions.new(name, cookies, **kwargs)
    end

    class CookieActions
      attr_reader :name
      attr_reader :cookies
      attr_reader :path
      attr_reader :expires

      def initialize(name, cookies, path: "/", expires: 1.day.from_now)
        @name = name
        @cookies = cookies
        @path = path
        @expires = expires
      end

      def cookie_value
        cookies[name]
      end

      def reset
        cookies.delete(name)
      end

      def bulk_delete(ids:)
        ids = Array(ids).map(&:to_s)
        actions = actions_data
        actions << { "type" => "bulk_delete", "ids" => ids }

        cookies[name] = {
          value: actions.to_json,
          path: path,
          expires: expires,
        }
      end

      def actions_data
        raw = cookie_value
        return [] if raw.blank?
        JSON.parse(raw)
      rescue JSON::ParserError
        []
      end

      def replay(records)
        actions = actions_data
        ids_to_delete = Set.new

        actions.each do |action|
          case action["type"]
          when "bulk_delete"
            ids_to_delete.merge(action["ids"])
          else
            Rails.logger.warn "Invalid action type: #{action["type"].inspect}"
          end
        end

        return records if ids_to_delete.empty?
        records.dup.delete_if { |record| ids_to_delete.include?(record.id.to_s) }
      end
    end
  end
end
