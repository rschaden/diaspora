module NotifierHelper
  
  # @param post [Post] The post object.
  # @param opts [Hash] Optional hash.  Accepts :length and :process_newlines parameters.
  # @return [String] The truncated and formatted post.
  def post_message(post, opts={})
    opts[:length] ||= 200
    if post.respond_to? :formatted_message
      message = truncate(post.formatted_message(:plain_text => true), :length => opts[:length])
      message = process_newlines(message) if opts[:process_newlines]
      message
    else
      I18n.translate 'notifier.a_post_you_shared'
    end
  end

  # @param comment [Comment] The comment to process.
  # @param opts [Hash] Optional hash.  Accepts :length and :process_newlines parameters.
  # @return [String] The truncated and formatted comment.
  def comment_message(comment, opts={})
    opts[:length] ||= 600
    text = truncate(comment.text, :length => opts[:length])
    text = process_newlines(text) if opts[:process_newlines]
    text
  end

  def invite_email_title
    if @inviter.present?
      I18n.t 'notifier.invited_you', :name => @inviter.person.name
    else
      I18n.t 'notifier.accept_invite'
    end
  end
end
