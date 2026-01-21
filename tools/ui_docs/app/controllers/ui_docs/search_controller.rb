# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/controllers/search_controller.rb
module UiDocs
  class SearchController < ApplicationController
    def show
      query = params[:q]&.strip&.downcase

      # Mock search data - in a real app this would by more dynamic
      search_data = [
        { title: "Dashboard Overview", description: "Main dashboard with key metrics", type: "page", section: "dashboard" },
        { title: "User Management", description: "Manage users and permissions", type: "page", section: "users" },
        { title: "Settings Configuration", description: "Application settings and preferences", type: "page", section: "settings" },
        { title: "API Documentation", description: "Complete API reference guide", type: "documentation", section: "api-docs" },
        { title: "Error Logs", description: "System error logs and debugging info", type: "logs", section: "logs" },
        { title: "Performance Metrics", description: "Application performance statistics", type: "analytics", section: "analytics" },
        { title: "Deployment History", description: "View and manage deployment records", type: "operations", section: "deployments" },
        { title: "Audit Logs", description: "Security and access audit trails", type: "security", section: "audit" },
        { title: "Team Management", description: "Manage teams and collaborators", type: "admin", section: "teams" },
        { title: "Billing & Subscriptions", description: "Manage billing and subscription plans", type: "billing", section: "billing" },
        { title: "Integration Settings", description: "Configure third-party integrations", type: "settings", section: "integrations" },
        { title: "Reports Generator", description: "Create and schedule custom reports", type: "reports", section: "reports" },
        { title: "Notification Center", description: "Manage system and user notifications", type: "notifications", section: "notifications" },
        { title: "Backup & Recovery", description: "System backup and restore options", type: "maintenance", section: "backup" },
        { title: "User Activity", description: "Monitor user actions and events", type: "monitoring", section: "activity" },
        { title: "System Health", description: "Overall system status and health metrics", type: "status", section: "health" },
      ]

      if query.present?
        @results = search_data.select do |item|
          item[:title].downcase.include?(query) ||
          item[:description].downcase.include?(query) ||
          item[:type].downcase.include?(query)
        end
      else
        @results = []
      end

      render layout: !request.xhr?
    end
  end
end
