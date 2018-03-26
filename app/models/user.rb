class User < ApplicationRecord
  before_create :add_guest_role
  acts_as_voter
  has_karma :words, :as => :submitter, :weight => [ 0.2, 0.2 ]
  acts_as_commontator
  # devise options
  devise :database_authenticatable
  devise :registerable # uncomment this if you want people to be able to register
  devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable
  # devise :token_authenticatable
  devise :confirmable
  # devise :lockable
  # devise :timeoutable
  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :locale
  attr_writer :inline_forms_attribute_list
  attr_accessor :user_words

  has_and_belongs_to_many :roles
  has_many :words

  has_many :spelling_sessions
  has_many :spelling_tries, through: :spelling_sessions

  # validations
  validates :name, :presence => true

  # pagination
  attr_reader :per_page
  @per_page = 7

  has_paper_trail

  # scopes

  #default_scope  { order(name: 'ASC') }

  scope :active, -> { where(active: 1) }
  scope :new_words_immediately, -> { where(new_words: 2) }
  scope :new_words_daily, -> { where(new_words: 3) }
  scope :new_words_weekly, -> { where(new_words: 4) }
  scope :new_words_monthly, -> { where(new_words: 5) }

  scope :own_words_immediately, -> { where(own_words: 2) }
  scope :own_words_daily, -> { where(own_words: 3) }
  scope :own_words_weekly, -> { where(own_words: 4) }
  scope :own_words_monthly, -> { where(own_words: 5) }
  scope :leaderboard, -> { joins(:spelling_tries).group('users.id').order('SUM(spelling_tries.points) DESC') }



  def _presentation
    name
  end

  def role?(role)
    return !!self.roles.find_by_name(role)
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :header_user_inloggegevens, '', :header ],
      [ :name, '', :text_field ],
      [ :email, '', :text_field ],
      [ :new_words, '', :dropdown_with_values, DELIVERY_SCHEDULES ],
      [ :own_words, '', :dropdown_with_values, DELIVERY_SCHEDULES ],
      [ :most_voted, '', :dropdown_with_values, DELIVERY_SCHEDULES ],
#      [ :locale, '', :dropdown ],
      [ :password, '', :devise_password_field ],
      [ :header_user_roles, '', :header ],
      [ :roles, '', :check_list ],
      [ :header_user_stuff, '', :header ],
      # [ :encrypted_password, '', :info ],
      [ :reset_password_token, '', :info ],
      [ :reset_password_sent_at, '', :info],
      [ :remember_created_at, '', :info ],
      [ :sign_in_count, '', :info ],
      [ :current_sign_in_at, '', :info ],
      [ :last_sign_in_at, '', :info ],
      [ :current_sign_in_ip, '', :info ],
      [ :last_sign_in_ip, '', :info ],
      [ :created_at, '', :info ],
      [ :updated_at, '', :info ],
    ]
  end

  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end



  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end



  def password_required?
    super && provider.blank?
  end



  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.skip_confirmation!
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end

  def own_words_immediately?
    self.own_words == 2
  end



protected
def add_guest_role
  roles << Role.find_by_name('viewer')
end


end
