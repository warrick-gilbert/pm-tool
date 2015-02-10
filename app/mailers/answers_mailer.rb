class AnswersMailer < ApplicationMailer

  def notify_discussion_owner(comment)
    # discussion_owner = User.find(@discussion.user_id)
    @comment   = comment
    @discussion = @comment.discussion
    @user     = @discussion.user
    mail to: @user.email, subject: "pm tool"
  end

  def notify_task_owner(task)
    # discussion_owner = User.find(@discussion.user_id)
    @task   = task
    # @discussion = @comment.discussion
    @user     = @task.user
    mail to: @user.email, subject: "pm tool"
  end
end
