# frozen_string_literal: true

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

  def messages_controller?
    controller.class == MessagesController
  end

  def subscribers_controller?
    controller.class == SubscribersController
  end

  def subscriptions_controller?
    controller.class == SubscriptionsController
  end

  def home_action?(action)
    controller.class == HomeController && controller.action_name == action
  end

  private

  def disable_item
    { href: '#',
      onclick: "'alert('#{t('feature_un')}');'" }
  end
end
