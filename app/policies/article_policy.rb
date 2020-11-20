class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true  # Anyone can create a article
  end

  def show?
    true  # Anyone can view a article
  end

  # def edit?
  #   if user == record.user
  #     true
  #   else
  #     false
  #   end
  # end

  def edit?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
