require_relative '../support/no_rails_tests'
require_relative '../../lib/additional_aliases'

class NoRailsTests::Model < NoRailsTests::FakeModel
  include AdditionalAliases
  def foo; end;
end

describe AdditionalAliases do

  before { @model = NoRailsTests::Model.new }

  describe '#dangerous_alias' do
    it 'should create a dangerous alias' do
      @model.should respond_to(:foo)
      @model.should_not respond_to(:foo!)
      NoRailsTests::Model.dangerous_alias(:foo)
      @model.should respond_to(:foo!)
      @model.should_receive(:foo).with("bar")
      @model.should_receive(:save)
      @model.foo!("bar")
    end
  end

  describe '#question_alias' do
    it 'should create a question alias' do
      @model.should respond_to(:foo)
      @model.should_not respond_to(:foo?)
      NoRailsTests::Model.question_alias(:foo)
      @model.should respond_to(:foo?)
      @model.should_receive(:foo).with("bar")
      @model.foo?("bar")
    end
  end

end
