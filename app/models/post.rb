class Post < ActiveRecord::Base
  include Ando::Taggable
  
  #====  SCOPES ====#
  default_scope :order => "published_at DESC, created_at DESC"
  
  #====  ASSOCIATIONS  ====#
  belongs_to :post,   :polymorphic => true
  belongs_to :author, :class_name => 'User'
  
  #====  VALIDATIONS  ====#
  validates_presence_of :post, :author, :name
  
  #====  CALLBACKS  ====#
  before_validation_on_create :set_author
  
  #====  STATEFULNESS  ====#
  include AASM
  
  alias_attribute :aasm_state, :status
  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :published
  aasm_state :hidden
  
  aasm_event :publish do
    transitions :to => :published, :from => [:draft, :published, :hidden],
                :guard => :set_published_at_if_blank
  end
  
  aasm_event :unpublish do
    transitions :to => :hidden, :from => [:draft, :published, :hidden]
  end
  
protected

  def set_author
    self.author ||= Ando.current_user
  end
  
  def set_published_at_if_blank
    self.published_at ||= self.created_at
  end
  
end
