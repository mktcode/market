def login_as(user)
  fill_in "Email", with: user.email_address
  fill_in "Password", with: "password"
  click_button "Sign in"
end
