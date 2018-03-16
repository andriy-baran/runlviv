class GroupRunPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    record.user_id == user.id
  end

  def new?
    create?
  end

  def update?
    record.runs.exists?(user_id: user.id)
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

  def join?
    record.runs.detect{ |run| run.user_id == user.id }.nil?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
