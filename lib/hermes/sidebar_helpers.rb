# frozen_string_literal: true

module Hermes
  # Helpers with the sidebar
  module SidebarHelpers
    def profile_link
      { href: edit_user_registration_path }
    end

    def sidebar_link(link, active_if)
      { class: ('active' if active_if), href: link }
    end

    def clients_controller?
      controller.class == ClientsController
    end

    def mail_logs_controller?
      controller.class == MailLogsController
    end

    def home_action?(action)
      controller.class == HomeController &&
        controller.action_name == action
    end

    private

    def disable_item
      { href: '#',
        onclick: "'alert('#{t('feature_un')}');'" }
    end
  end
end
