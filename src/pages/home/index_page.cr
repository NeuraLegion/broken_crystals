class Home::IndexPage < MainLayout
  needs search : String | Nil

  def content
    render_template "home/main.html.ecr"
  end
end
