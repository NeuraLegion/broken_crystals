class Users::Show < BrowserAction
  include Auth::AllowGuests
  get "/users/:some_user_id" do
    plain_text "Requested user id: #{some_user_id}"
  end
end
