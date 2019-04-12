module Viewpoint::EWS::Types
  class Message
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item

    def to_mail
      mail = Mail.new
      internet_message_headers.each do |header|
      	header.each do |k, v|
      		case k.downcase
    		 	when "references"
      			mail.references = v
      		when "in-reply-to"
      			mail.in_reply_to = v
      		end
      	end
      end
      mail.date date_time_sent unless date_time_sent.nil?
      # mail.message_id internet_message_id unless internet_message_id.nil?
      # mail.in_reply_to in_reply_to unless in_reply_to.nil?
      # mail.references references unless references.nil?
      mail.subject subject unless subject.nil?
      # # mail.return_path = sender.email_address unless(sender.nil? || ! sender.respond_to?(:email_address))
      mail.to to_recipients.map {|r| ("#{r.name} <#{r.email_address}>") if r.respond_to?(:email_address) } unless to_recipients.nil?
      # mail.cc cc_recipients.map {|r| r.email_address if r.respond_to?(:email_address) } unless cc_recipients.nil?
      # mail.from ("#{from.name} <#{from.email_address}>") unless (from.nil? || ! from.respond_to?(:email_address))
      # Because the mail gem does not pass an object to the block there are some issues with using self
      msg = self
      if(body_type == "HTML")
        mail.html_part do
          body msg.body
        end
        mail.text_part do
          body Nokogiri::HTML(msg.body).content
        end
      else
        mail.text_part do
          body msg.body
        end
      end

      # add attachments
      if(self.has_attachments?)
        self.attachments.each do |att|
          if att.class.to_s == "Viewpoint::EWS::Types::ItemAttachment"
            mail.attachments[att.file_name] =  {
              body: att.content,
              mime_type: att.content_type
            }
          else
            if att.is_inline?
              mail.attachments.inline[att.file_name] =  {
                body: att.content.nil? || att.content.empty? ? "" : Base64.decode64(att.content),
                mime_type: att.content_type
              }
            else
              mail.attachments[att.file_name] =  {
    		        body: att.content.nil? || att.content.empty? ? "" : Base64.decode64(att.content),
    		        mime_type: att.content_type
    		      }
            end
          end
        end
      end
      mail.to_s
    end
  end
end
