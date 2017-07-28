require 'pdf/reader'
require 'rubygems'
require 'strscan'
require 'pry'

file = File.open('./pdf_examples/fake_example.pdf', "rb")

def print_header(page, end_of_header_trigger, end_of_summary_trigger)
  page_text = StringScanner.new(page.text)
  puts '--------------------Begining of Page------------------------'
  pp page_text.scan_until(end_of_header_trigger)
  pp '------------------------------------------------------------'
  pp page_text.scan_until(end_of_summary_trigger)
  puts '--------------------End of Page-----------------------------'
end

def scan_details(page)
  page_text = StringScanner.new(page.text)
  # trigger_words = [{'PROPERTY RATES' => 14, 'WATER' => 5, 'REFUSE' => 6, 'SEWERAGE' => 8}]
  pp page_text.skip_until (/PROPERTY RATES/)
  pp page_text.pos = page_text.pos - 14
  p 'Print property'
  pp page_text.scan_until(/WATER/)
  pp page_text.pos = page_text.pos - 5
  p 'Print water'
  pp page_text.scan_until(/REFUSE/)
  pp page_text.pos = page_text.pos - 6
  p 'Print refuse'
  pp page_text.scan_until(/SEWERAGE/)
  pp page_text.pos = page_text.pos - 8
  p 'Print Sewerage'
  pp page_text.scan_until(/Meter/)
  pp page_text.pos = page_text.pos - 5
  pp page_text.rest
end

PDF::Reader.open(file) do |reader|
  reader.pages.each do |page|
    if page.number == 1
      print_header(page, /Web address:www.capetown.gov.za/i, /Please note:/i)
    else
      scan_details(page)
    end
  end
end

