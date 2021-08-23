class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user&.admin? ? scope.all : scope.contributor
    end
  end
end
