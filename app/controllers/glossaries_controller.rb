class GlossariesController < InlineFormsController
  set_tab :glossary
  layout 'frontends'
  autocomplete :word, :name, full: true

  def index
  end

  def show
    @glossary = referenced_object
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

  def edit
    @glossary = referenced_object
    redirect_to '/' if @glossary.nil?
    word_to_add = Word.find_by_name(params[:add_word])
    @glossary.words << word_to_add if word_to_add
    remove_words = params[:remove_words]
    unless remove_words.blank?
      words_to_remove = remove_words.map{ |word| Word.find_by_name(word) }.compact.uniq
      @glossary.words.delete words_to_remove
    end
  end

end
