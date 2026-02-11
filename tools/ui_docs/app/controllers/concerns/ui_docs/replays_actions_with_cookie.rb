# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/concerns/replays_actions_with_cookie.rb
module UiDocs
  module ReplaysActionsWithCookie
    private

    def find_cookie_actions(name)
      CookieActions.new(name, cookies)
    end

    class CookieActions
      attr_reader :name
      attr_reader :cookies

      def initialize(name, cookies)
        @name = name
        @cookies = cookies
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
          path: "/",
          expires: 1.year.from_now,
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
