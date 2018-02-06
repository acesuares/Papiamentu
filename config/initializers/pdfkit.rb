PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  config.default_options = {
    :encoding=>"UTF-8",
    :page_size => 'A4',
    :margin_top    => '0.5in',
    :margin_right  => '0.6in',
    :margin_bottom => '1in',
    :margin_left   => '0.6in'
  }
end
