require 'spec_helper'

describe AttemptedQuestion do
  describe "creation" do
    it "should have question id and player id as composite primary key" do
      AttemptedQuestion.primary_key.should include(:question_id)
      AttemptedQuestion.primary_key.should include(:player_id)
    end

    it "should not allow same question id and player id" do
      question = Question.create(:question => "Is panda cute?",
                                 :correct_answer => "Definitely!",
                                 :incorrect_answer_1 => "No",
                                 :incorrect_answer_2 => "It depends")
      player = Player.create(:first_name => "Teddy",
                             :last_name => "Bear",
                             :email => "teddybear@home.com",
                             :mobile_number => "123",
                             :city => "melb",
                             :company_name => "Home",
                             :role => "housekeeper")
      attempt1 = AttemptedQuestion.create(:question_id => question.id,
                                          :player_id => player.id,
                                          :answered_correctly => false)
      attempt1.should be_valid
      attempt2 = AttemptedQuestion.create(:question_id => question.id,
                                          :player_id => player.id,
                                          :answered_correctly => false)
      attempt2.should_not be_valid
    end
  end

  it "should order by question id by default" do
    attempt1 = AttemptedQuestion.create(:question_id => 3,
                                        :player_id => 1,
                                        :answered_correctly => false)
    attempt2 = AttemptedQuestion.create(:question_id => 1,
                                        :player_id => 1,
                                        :answered_correctly => false)
    attempt3 = AttemptedQuestion.create(:question_id => 2,
                                        :player_id => 1,
                                        :answered_correctly => false)
    all_attempts = AttemptedQuestion.all
    all_attempts[0].should == attempt2
    all_attempts[1].should == attempt3
    all_attempts[2].should == attempt1
  end
end
