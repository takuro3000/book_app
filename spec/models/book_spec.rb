require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }
  
  it "is valid with a valid title" do
    expect(book).to be_valid
  end
end
