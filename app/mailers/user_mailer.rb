class UserMailer < ApplicationMailer
  default from: 'talangxiaotian6@gmail.com'

  def send_custom_id(user)
    @user = user
    mail(to: @user.email, subject: 'Your Custom Login ID')
  end
end
