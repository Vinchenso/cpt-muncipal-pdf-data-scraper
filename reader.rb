require 'pdf/reader'
require 'rubygems'
require 'strscan'
require 'pry'

file = File.open('./pdf_examples/fake_example.pdf', "rb")

def print_header(page, end_of_header_trigger, end_of_summary_trigger)
  page_text = StringScanner.new(page.text)
  puts '--------------------Begining of Page------------------------'
  puts page_text.scan_until(end_of_header_trigger)
  puts '------------------------------------------------------------'
  puts page_text.scan_until(end_of_summary_trigger)
  puts '--------------------End of Page-----------------------------'
end

PDF::Reader.open(file) do |reader|
  reader.pages.each do |page|
    print_header(page, /Account Summary/i, /Please note/i) 
  end
end



