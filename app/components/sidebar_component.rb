class SidebarComponent < ViewComponent::Base
  def initialize(user:, current_action:)
    @user = user
    @current_action = current_action
  end
end
