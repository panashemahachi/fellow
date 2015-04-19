class FellowshipAddition < ActionMailer::Base
  default from: "friends@joinfellow.com"

  # adder is person who addded the artifact
  def added_to_fellowship(fellowship_members, actual_artifact, fellowship_name, c_user_id)
    @greeting = "Hi"

    # Pass as instance variable
    @fellowship_members = fellowship_members
    @adder = User.where(id: actual_artifact.user_id).first.username
    @title = actual_artifact.title
    @fellowship_name = fellowship_name
    @actual_artifact = actual_artifact

    # predict url

    #If contains appostrophe
    g_title = actual_artifact.title.dup

    # replace appost with space
    g_title.sub! '\'', ' '

    link_arr = g_title.split(" ").join("-")
    @url = "http://joinfellow.com/artifacts" + "/" + actual_artifact.id.to_s + "-" + link_arr

    # Send to all fellowship members
    fellowship_members.each do |fm|
      if fm.id != c_user_id
        mail to: fm.email, subject: "@#{@adder} wants you to read an artifact on Fellow."
      end
    end
  end
end
