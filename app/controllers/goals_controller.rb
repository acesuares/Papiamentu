class GoalsController < InlineFormsController
  set_tab :goal
  autocomplete :goal, :name, full: true

  def show_goal
    @goal = referenced_object
    redirect_to '/' if @goal.nil?

    respond_to do |format|
      format.html {
        render layout: 'frontends'
      }
    #   format.pdf {
    #     html = render_to_string(layout: 'glosario')
    #     filename = "#{Time.now.to_s(:db)[0..9]}_#{@goal.name}.pdf"
    #     if Rails.env.production?
    #      # generate the pdf
    #      html = html.gsub(/\/assets\//, 'https://palabra.papiamentu.info/assets/')
    #      pdf = PDFKit.new(html).to_pdf
    #      send_data(pdf, :filename => filename, :type => 'application/pdf')
    #     else
    #      # generate the pdf
    #      html = html.gsub(/\/assets\//, 'http://127.0.0.1:3000/assets/')
    #      File.open("#{Rails.root}/pdfs/#{filename}.html", "w+b") {|f| f.write(html)}
    #      pdf = PDFKit.new(html).to_pdf
    #      send_data(pdf, :filename => filename, :type => 'application/pdf')
    #     end
    #    }
    end
  end


end
