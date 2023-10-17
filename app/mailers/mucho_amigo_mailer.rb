class MuchoAmigoMailer < Devise::Mailer
  default from: 'mucho.amigo@sagacicweb.com'

  # Override the method to customize the subject or other details
  def confirmation_instructions(record, token, opts={})
    @resource = record
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end
end