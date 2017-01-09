class UserAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:manage], User
  end
end