class PagesController < ApplicationController
  def terms_of_service
  end

  def privacy_policy
  end

  def contact
    @user = current_user || OpenStruct.new(email: '')
    @support_message = SupportMessage.new
    if request.post?
      @support_message = SupportMessage.new(support_message_params)
      if @support_message.save
        redirect_to root_path, notice: I18n.t('contact.message_sent')
      else
        render :contact
      end
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  private

  def support_message_params
    params.fetch(:support_message, {}).permit(:email, :body)
  end
end
