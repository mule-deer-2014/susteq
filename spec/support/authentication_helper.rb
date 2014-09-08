module AuthenticationHelper
  def login user
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    find('input[type="submit"]').click
  end
end
