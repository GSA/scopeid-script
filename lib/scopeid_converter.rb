require "net/http"
require "uri"
require "open-uri"
require "nokogiri"
require "csv"

class ScopeidConverter
  TOP_TERMS_URL = "http://govt-urls.usa.gov/tematres/vocab/services.php?task=fetchTopTerms"
  NESTED_TERMS_URL = "http://govt-urls.usa.gov/tematres/vocab/services.php?task=fetchDown&arg=%d"
  FILE = Date.today.strftime("%m_%Y") + "_scope_ids.csv"

  def initialize(top_terms_url = TOP_TERMS_URL, nested_terms_url = NESTED_TERMS_URL, file = FILE)
    @top_terms_url = top_terms_url
    @nested_terms_url = nested_terms_url
    @file = file
  end

  def build_csv_file
    taxonomy_hashes = get_top_level_terms
    csv_rows = build_csv_rows(taxonomy_hashes)

    write_csv_rows_to_file(csv_rows)

    @file
  end

  def get_top_level_terms
    xml_doc = Nokogiri::XML(open(@top_terms_url))

    xml_doc.xpath('//term').map do |term|
      if !term.xpath('./code').text.start_with?('z ')
        { :id => term.xpath('./term_id').text,
          :name => term.xpath('./string').text }
      else
        nil
      end
    end.compact
  end

  def build_csv_rows(taxonomy_hashes)
    csv_rows = []
    taxonomy_hashes.each do |hash|
      nested_terms_doc = Nokogiri::XML(open(@nested_terms_url % hash[:id].to_i))
      hash[:terms] = nested_terms_doc.xpath('//term').map{ |term| "http://" + term.xpath('./string').text }
      if hash[:name] != "usagovFEDgov"
        hash[:name] = "usagov"
      end
      hash[:terms].each do |term|
        csv_rows << [term, hash[:name]]
      end
    end
    csv_rows
  end

  def write_csv_rows_to_file(csv_rows)
    csv_rows.uniq!
    csv_rows.sort_by!{ |row| row[0].downcase }

    CSV.open(@file, "w") do |csv|
      csv_rows.each do |row|
        csv << row
      end
    end
  end

end