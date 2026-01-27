# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/services/application_service.rb
module UiDocs
  # TODO: move this somewhere inside of rapid*
  class ApplicationService
    class << self
      def call(*args, **kargs)
        Rails.logger.tagged(name) do
          new(*args, **kargs).call
        end
      end
    end

    class Brief
      class << self
        def call(*args, **kargs)
          Rails.logger.tagged(name) do
            new.call(*args, **kargs)
          end
        end
      end
    end
  end
end
