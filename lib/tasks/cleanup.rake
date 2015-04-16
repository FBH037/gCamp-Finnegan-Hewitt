
task cleanup: :environment do

  Membership.all.select{|membership| membership.user == nil}.each do |membership|
    membership.destroy
  end

  Membership.all.select{|membership| membership.project == nil}.each do |membership|
    membership.destroy
  end

  Task.all.select{|task| task.project == nil}.each do |task|
    task.destroy
  end

  Comment.all.select{|comment| comment.task == nil}.each do |comment|
    comment.destroy
  end

  Comment.all.select{|comment| comment.user == nil}.each do |comment|
    comment.user_id = nil
    comment.save
  end

end
