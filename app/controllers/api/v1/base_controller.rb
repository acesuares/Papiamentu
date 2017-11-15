class Api::V1::BaseController < ActionController::API
  include ActionController::Serialization

  def not_found
    render status: 404, json: {
      errors: 'Not found'
    }.to_json
  end
end
