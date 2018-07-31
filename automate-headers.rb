# => require gems 
require 'erb'
require 'roo'

# => open spreadsheet
xlsx = Roo::Spreadsheet.open('./cms/cms.xlsx')
xlsx = Roo::Excelx.new("./cms/cms.xlsx")

# => find number of headers by finding total rows 
totalheaders = xlsx.last_row 

# => start a while condition to iterate through each row. x is starting position of data
x = 2
until x > totalheaders do
    # => assign local variables to correct data
    @header_title = xlsx.row(x)[0]
    @header_img_link = xlsx.row(x)[1]
    @header_copy = xlsx.row(x)[2]

    # => render template
    template = File.read('template/seo-header-template.html.erb')
    result = ERB.new(template).result(binding)

    # => interpolate results to file
    File.open('build/' + @header_title + '.html', 'w+') do |f|
        f.write result
    end

    # => increment x 
    x += 1
end
