class TestHelper
  include OdiMembers::Helpers
end

module OdiMembers
  describe Helpers do
    let(:helpers) { TestHelper.new }
  end
end
