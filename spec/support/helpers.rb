module Helpers
  def self.next_seq
    @next_seq = (@next_seq || 0) + 1
  end

  def login(user)
    #user = Fabricate(fabricator || :user)
    puts user.username
    $test_user = user
  end

  def login_user(fabricator=nil)
    #@request.env["devise.mapping"] = Devise.mappings[:user]
    user = Fabricate(fabricator || :user)
    sign_in user
    user
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end

  # Can be used like:
  #  extract_token_from_email(:reset_password)
  def extract_token_from_email(token_name)
    mail_body = last_email.to_s
    mail_body[/#{token_name.to_s}_token=([^"\n\r]+)/, 1]
  end

end

