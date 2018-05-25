class RunPolicy < ApplicationPolicy
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
    create?
  end

  def edit?
    update? && record.group_run.nil? && (record.beginning + 1.day) > Time.current
  end

  def destroy?
    create?
  end

  def join?
    record.group_run.nil? && record.not_started? && !create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
