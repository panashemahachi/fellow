# Preview all emails at http://localhost:3000/rails/mailers/fellowship_addition
class FellowshipAdditionPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/fellowship_addition/added_to_fellowship
  def added_to_fellowship
    FellowshipAddition.added_to_fellowship
  end

end
