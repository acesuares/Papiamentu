class Api::V1::EndpointsController < Api::V1::BaseController
  def palabra
    @search_word = params[:word].squish.gsub(CHARACTER_REGEX,'')
    word = Word.find_by_variant(@search_word)
    return not_found if word.nil?
    render json: word
  end
end
