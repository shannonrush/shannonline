class ProjectsMailer < ActionMailer::Base
  
  def test_email
    recipients "Kathy_Gerwig@comcast.net"
    from       "admin"
    subject    "Test Email"
  end

end
