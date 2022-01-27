require_relative '../lib/01_townhall_scraper'

describe "town_hall_scraper method" do
  output = townhall_scraper
  it "should return an array of hashes, and this array is not nil" do
    expect(output).not_to be_nil
  end

  it "should contain TAVERNY city" do
    expect(output.all?{|h| h["TAVERNY"].nil?})
  end
end
