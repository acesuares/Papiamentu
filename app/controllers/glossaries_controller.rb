class GlossariesController < InlineFormsController
  set_tab :glossary
  layout 'frontends'

  def index
  end

  def show
    @glossary = Glossary.find(1)
    redirect_to '/' if @glossary.nil?

    respond_to do |format|
      format.html {
      }
      format.pdf {
        html = render_to_string(layout: 'glosario')
        filename = "#{Time.now.to_s(:db)[0..9]}_#{@glossary.name}.pdf"
        if Rails.env.production?
         # generate the pdf
         html = html.gsub(/\/assets\//, 'https://palabra.papiamentu.info/assets/')
         pdf = PDFKit.new(html).to_pdf
         send_data(pdf, :filename => filename, :type => 'application/pdf')
        else
         # generate the pdf
         html = html.gsub(/\/assets\//, 'http://127.0.0.1:3000/assets/')
         File.open("#{Rails.root}/pdfs/#{filename}.html", "w+b") {|f| f.write(html)}
         pdf = PDFKit.new(html).to_pdf
         send_data(pdf, :filename => filename, :type => 'application/pdf')
        end
       }
    end
  end

  def new
    @object = @Klass.new
    @object.user_id = current_user.id
    super
  end

  def create
    @object = @Klass.new
    @object.user_id = current_user.id
    super
  end

end
