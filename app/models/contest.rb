class Contest < ActiveRecord::Base
  has_many :photos, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  validates :status, presence: true, inclusion: { in: ['pending', 'approved'] }

  validates :email, presence: true, email: true
  validates :prize, presence: true
  validates :description, presence: true

  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :validate_times

  validates :image_large_url, presence: true
  validates :image_medium_url, presence: true
  validates :image_thumb_url, presence: true

  validate :validate_image

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }

  before_validation do
    self.title.try(:strip!)
    self.prize.try(:strip!)
    self.email.try(:strip!)
    self.name.try(:strip!)
    self.company.try(:strip!)
  end

  def start_at= str
    write_attribute :start_at, Date.strptime(str, '%m/%d/%Y') unless str.strip.blank?
  end

  def end_at= str
    write_attribute :end_at, Date.strptime(str, '%m/%d/%Y') unless str.strip.blank?
  end

  def approve
    self.status = 'approved'
    save
  end

  def approved?
    self.status == 'approved'
  end

  def pending?
    self.status == 'pending'
  end

  def started?
    self.start_at >= Time.now
  end

  def ended?
    self.end_at < Time.now
  end

  def can_submit_photo?
    !ended?
  end

  def self.current_contests(n)
    approved.where('start_at <= ? AND end_at > ?', Time.now, Time.now).order(created_at: :desc).limit(n)
  end

  def self.previous_contests(n = 10)
    approved.where('end_at < ?', Time.now).order(created_at: :desc).limit(n)
  end

  def photos_for_view(page = 1)
    photos.order(created_at: :desc).page(page).per(12)
  end

  def milliseconds_left
    (end_at - Time.now).to_i * 1000
  end

  protected

  def validate_times
    if end_at.present?
      errors.add(:end_at, 'must be in the future') if end_at < Time.now
    end

    if start_at.present? and end_at.present?
      errors.add(:start_at, 'must be before end date') unless start_at < end_at
    end
  end

  def validate_image
    if image_large_url.blank? or image_medium_url.blank? or image_thumb_url.blank?
      errors.add(:header_image, "can't be blank")
    end
  end
end