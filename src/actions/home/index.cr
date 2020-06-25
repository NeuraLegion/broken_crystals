#class Home::Index < BrowserAction
#  include Auth::AllowGuests
#
#  get "/" do
#    if current_user?
#      redirect Me::Show
#    else
#      # When you're ready change this line to:
#      #
#      #   redirect SignIns::New
#      #
#      # Or maybe show signed out users a marketing page:
#      #
#      #   html Marketing::IndexPage
#      html Lucky::WelcomePage
#    end
#  end
#end

class Home::Index < BrowserAction
  include Auth::AllowGuests
  get "/" do
    # Renders the Users::IndexPage
    html Home::IndexPage, search: nil
  end
end
