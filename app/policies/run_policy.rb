class RunPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    record.user_id = user.id
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
