class AdminAbility
  include CanCan::Ability

  def initialize
    cannot [:show], User
  end
end