class TestHelper
  include OdiMembers::Helpers
end

module OdiMembers
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'says hello' do
      expect(helpers.hello).to eq 'Hello'
    end
  end
end
