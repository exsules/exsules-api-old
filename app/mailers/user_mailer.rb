class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    return unless @user

    mail(to: @user.email, subject: 'test')
  end
end
