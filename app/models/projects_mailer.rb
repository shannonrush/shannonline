class ProjectsMailer < ActionMailer::Base
  
  def test_email
    recipients "shannonmrush@gmail.com"
    from       "admin"
    subject    "Test Email"
  end

end
