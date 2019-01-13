# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  subject { described_class.new(code: code, name: name, price: price) }

  let(:code) { '001' }
  let(:name) { 'T-shirt' }
  let(:price) { 9.99 }

  it 'creates instance with expected attributes' do
    expect(subject.code).to eq(code)
    expect(subject.name).to eq(name)
    expect(subject.price).to eq(price)
  end
end
