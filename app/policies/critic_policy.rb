class CriticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.where(approved: true) unless user

      if user.admin?
        scope.all
      else
        scope.where(user: user).or(scope.where(approved: true))
      end
    end
  end

  def permitted_attributes
    if user.admin?
      %i[title body approved]
    else
      %i[title body]
    end
  end

  def update?
    user.admin? || record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.user == user
  end
end
