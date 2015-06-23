require 'csv'
require 'rails_helper'
require 'pp'

describe ScopeidConverter do
  top_terms_fixture = "#{Rails.root}/spec/fixtures/top_terms.xml"
  nested_terms_fixtures = "#{Rails.root}/spec/fixtures/nested_terms/%d.xml"
  test_csv = "#{Rails.root}/spec/lib/spec_csv_result.csv"

  converter = ScopeidConverter.new(top_terms_fixture, nested_terms_fixtures, test_csv)
  file = converter.build_csv_file

  rows_array = CSV.read(file)
  expected_results = [['http://404.gov', 'usagovFEDgov'], ['http://afognak.org', 'usagov']]

  it "parses the XML correctly" do 
    expect(rows_array).to eq(expected_results)
  end

end