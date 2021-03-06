class Goal < ActiveRecord::Base

  belongs_to :mentee


  def deliver_email(current_user, subject)
    email = self.mentee.email_histories.new
    email.body = self.body
    if email.save
      Resque.enqueue(EmailSend, email.id, current_user.id, subject)
    end
  end

end
