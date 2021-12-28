class Api::V1::ListWordsWithThisLengthController < Api::V1::BaseController
  def list
    @length = params[:length].to_i
    list_of_words_with_this_length = Word.list_words_with_this_length(@length)
    list = [list_of_words_with_this_length.count, list_of_words_with_this_length.map(&:name)].flatten

    render json: list
  end
end
