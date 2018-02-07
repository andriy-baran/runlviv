class PagesController < ApplicationController
  def terms_of_service
  end

  def privacy_policy
  end

  def contact
  end

  def profile
    @user = User.find(params[:id])
  end
end
