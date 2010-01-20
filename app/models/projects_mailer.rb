class ProjectsMailer < ActionMailer::Base
  
  def test_email
    recipients "shannonmrush@gmail.com"
    from       "shannon@shannonline.com"
    subject    "Test Email"
  end

end
