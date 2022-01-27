require_relative '../lib/00_crypto_scraper'

describe "crypto_scraper method" do
  output = crypto_scraper
  it "should return an array of crypto hashes, and this array is not nil" do
    expect(output).not_to be_nil
  end

  it "should contain 'BTC'" do
    expect(output.all?{|h| h["BTC"].nil?})
  end
end