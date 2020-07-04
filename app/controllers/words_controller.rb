class WordsController < InlineFormsController
  set_tab :word
  autocomplete :word, :name, full: true, limit: 20

  def index
    @objects ||= @Klass
    search = params[:search] || ""
    search = '%' + search + '%'
    @objects = @objects.where("name LIKE ? ", search )
    @objects = @objects.accessible_by(current_ability) if cancan_enabled?
    @objects = @objects.unscoped.order("created_at desc") if params[:newest_words] == "1"
    if params[:only_standardized]
      @objects = @objects.standardized
    end
    if params[:only_buki_di_oro]
      @objects = @objects.buki_di_oro
    end
    if params[:only_deleted]
      @objects = @objects.deleted
    end
    super
  end

def new
  @object = @Klass.new
  @object.user_id = current_user.id

  if current_user.role? :viewer
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :synonym , "synonym", :text_area_without_ckeditor ],
      [ :wordtypes, '', :check_list ],
      [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :specific , "specific", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :school_language , "school_language", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :goals, '', :check_list ],
      [ :description_nl , "description_nl", :text_area_without_ckeditor ],
      [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
      [ :tr_nl , "tr_nl", :text_field ],
      [ :tr_en , "tr_en", :text_field ],
    ]
  else
    @inline_forms_attribute_list ||= [
      [ :header_lema, '', :header ],
      [ :name , "name", :text_field ],
      [ :synonym , "synonym", :text_area_without_ckeditor ],
      [ :header_gramma, '', :header ],
      [ :wordtypes, '', :check_list ],
      [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si', 2 => 'unknown' } ],
      [ :specific , "specific", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :school_language , "school_language", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :header_fuente, '', :header ],
      [ :fshp_categories, '', :check_list ],
      [ :sources, '', :check_list ],
      [ :goals, '', :check_list ],
      [ :header_splikashon, '', :header ],
      [ :description_nl , "description_nl", :text_area_without_ckeditor ],
      [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
      [ :tr_nl , "tr_nl", :text_field ],
      [ :tr_en , "tr_en", :text_field ],
      [ :tr_es , "tr_es", :text_field ],
      [ :tr_pap_cw , "tr_pap_cw", :text_field ],
      [ :tr_pap_aw , "tr_pap_aw", :text_field ],
      [ :buki_di_oro_text, '', :info ],
    ]
  end
  super
end

  def create
    @object = @Klass.new
    @object.user_id = current_user.id

    if current_user.role? :viewer

      @inline_forms_attribute_list ||= [
        [ :name , "name", :text_field ],
        [ :synonym , "synonym", :text_area_without_ckeditor ],
        [ :wordtypes, '', :check_list ],
        [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si' } ],
        [ :specific , "specific", :radio_button, { 0 => 'nò', 1 => 'si' } ],
        [ :school_language , "school_language", :radio_button, { 0 => 'nò', 1 => 'si' } ],
        [ :goals, '', :check_list ],
        [ :description_nl , "description_nl", :text_area_without_ckeditor ],
        [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
        [ :tr_nl , "tr_nl", :text_field ],
        [ :tr_en , "tr_en", :text_field ],
      ]

    else
      @inline_forms_attribute_list ||= [
        [ :header_lema, '', :header ],
        [ :name , "name", :text_field ],
        [ :synonym , "synonym", :text_area_without_ckeditor ],
        [ :header_gramma, '', :header ],
        [ :wordtypes, '', :check_list ],
        [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si', 2 => 'unknown' } ],
        [ :specific , "specific", :radio_button, { 0 => 'nò', 1 => 'si' } ],
        [ :school_language , "school_language", :radio_button, { 0 => 'nò', 1 => 'si' } ],
        [ :header_fuente, '', :header ],
        [ :fshp_categories, '', :check_list ],
        [ :sources, '', :check_list ],
        [ :goals, '', :check_list ],
        [ :header_splikashon, '', :header ],
        [ :description_nl , "description_nl", :text_area_without_ckeditor ],
        [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
        [ :tr_nl , "tr_nl", :text_field ],
        [ :tr_en , "tr_en", :text_field ],
        [ :tr_es , "tr_es", :text_field ],
        [ :tr_pap_cw , "tr_pap_cw", :text_field ],
        [ :tr_pap_aw , "tr_pap_aw", :text_field ],
        [ :buki_di_oro_text, '', :info ],
      ]
    end
    super
  end


  # vote_fu (now thumbs_up) for thumbs
  def _vote_for_thumbs
    @thumbs_word = Word.find(params[:id])
    @update_span = params[:update]
    current_user.vote_for(@thumbs_word)
    # OwnWordLikedOrVisitedWorker.perform_async(@thumbs_word.id, 1)
    respond_to do |format|
      format.js { }
    end
  end

  def _vote_against_thumbs
    @thumbs_word = Word.find(params[:id])
    @update_span = params[:update]
    current_user.vote_against(@thumbs_word)
    # OwnWordLikedOrVisitedWorker.perform_async(@thumbs_word.id, -1)
    respond_to do |format|
      format.js { }
    end
  end

  def _vote_reset_thumbs
    @thumbs_word = Word.find(params[:id])
    @update_span = params[:update]
    current_user.unvote_for(@thumbs_word)
    # OwnWordLikedOrVisitedWorker.perform_async(@thumbs_word.id, 0)
    respond_to do |format|
      format.js { }
    end
  end

  def export
    require 'csv'
    @object ||= @Klass
    @objects = @object.order(:name)
    send_data (@objects.to_csv), :type => 'text/csv; charset=UTF-8', :disposition => "attachment; filename=pap_words.csv";
  end

end
