class FrontendsController < ApplicationController
  layout 'application'
  include CancanConcern
  load_and_authorize_resource :class => false

  def index
    @palabra_mas_resien_limit = params[:palabra_mas_resien_limit] || 10
    @palabra_mas_resien_offset = params[:palabra_mas_resien_offset] || 0
    @palabra_mas_mira_limit = params[:palabra_mas_mira_limit] || 10
    @palabra_mas_mira_offset = params[:palabra_mas_mira_offset] || 0
  end

  def palabra
    if params[:word].blank?
      redirect_to '/'
    else
      @search_word = params[:word].squish.gsub(CHARACTER_REGEX,'')
      @word = Word.find_by_variant(@search_word)
      if @word.nil?
        render 'palabra_nobo' and return
      end
      @word.increment_views
      # WordMailer.own_word_liked_or_visited_email(self.id, 'ace@suares.com').deliver
      OwnWordLikedOrVisitedWorker.perform_async(@word.id, 2)
      commontator_thread_show(@word)
    end
  end

  def glosario
    @glossary = Glossary.find_by_name(params[:glossary])
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

  def tra_palabra
    if params[:word].blank? || params[:commit] == "nò, mi ke bai bèk na e pagina inisio"
      redirect_to '/'
    else
      @search_word = params[:word].squish.gsub(CHARACTER_REGEX,'')
      @word = Word.find_by_name(@search_word)
      if @word.nil?
        @word = Word.create(name: @search_word, user_id: current_user.id, source_id: VIA_WEBSITE )
        NewWordCreatedWorker.perform_async(@word.id)
        #WordMailer.new_word_created_email(@word.id, 'ace@suares.com').deliver
      end
      redirect_to "/palabra/#{URI.encode(@word.name)}"
    end
  end

  def check_text
    text = params[:text]
    redirect_to '/' if text.blank?
    # get rid of curly quotes
    text.gsub! "\342\200\230", "'"
    text.gsub! "\342\200\231", "'"
    text.gsub! "\342\200\234", '"'
    text.gsub! "\342\200\235", '"'
    # get rid of non alpha num stuff except - and ' replace them with spaces.
    text.gsub! /[^-'[:alnum:]]/, " "
    # now preserve the ' in "pal'i maishi" but not in 'airquotes'.
    text.gsub! /^'| '|' |'$/,' '
    # replace whitespace by one space
    text.gsub!(/\s+/, ' ')
    # downaces all, which is a bit clumsy
    text.downcase!
    # convert to array
    words_in_text = text.split ' '
    # uniq and sort
    words_in_text.uniq!
    words_in_text.sort!
    # this is words in text_ar but not in all words!
    @words_missing = words_in_text - Word.all.map(&:name)
  end

  def _palabra_mas_resien
    @update_span = params[:update]
    @palabra_mas_resien_limit = params[:palabra_mas_resien_limit].to_i    || 15
    @palabra_mas_resien_offset = params[:palabra_mas_resien_offset].to_i  || 0
    @direction = params[:direction] || 'none'

    @palabra_mas_resien_offset += @palabra_mas_resien_limit if @direction == 'forward'
    @palabra_mas_resien_offset -= @palabra_mas_resien_limit if @direction == 'back'

    respond_to do |format|
      format.js { }
    end
  end

  def _palabra_mas_mira
    @update_span = params[:update]
    @palabra_mas_mira_limit = params[:palabra_mas_mira_limit].to_i    || 15
    @palabra_mas_mira_offset = params[:palabra_mas_mira_offset].to_i  || 0
    @direction = params[:direction] || 'none'

    @palabra_mas_mira_offset += @palabra_mas_mira_limit if @direction == 'forward'
    @palabra_mas_mira_offset -= @palabra_mas_mira_limit if @direction == 'back'

    respond_to do |format|
      format.js { }
    end
  end

  def my_profile
    @my_words = Word.unscoped.where(user_id: current_user.id).group_by{ |word| word.created_at.to_date.to_formatted_s(:db)}
    @votes_for = []
    @votes_against = []
    current_user.votes.each do |vote|
      if vote.voteable_type == 'Word'
        word = Word.find(vote.voteable_id) rescue nil
        if vote.vote
          @votes_for << word
        else
          @votes_against << word
        end
      end
    end
  end

  def rapport
    user_ids = Word.all.map(&:user_id).uniq.compact - [5] # 5 = FPI
    @users = User.order(:name).where(id: user_ids)
    @users.each do |user|
      user.user_words = Word.unscoped.where(user_id: user.id).group_by{ |word| word.created_at.to_date.to_formatted_s(:db)}
    end
  end


  def search
    if params[:word].blank?
      redirect_to root_path
    else
      redirect_to "/palabra/#{params[:word]}"
    end
  end
end
