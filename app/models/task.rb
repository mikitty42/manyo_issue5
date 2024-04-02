class Task < ApplicationRecord
    validates :title,presence: true
    validates :content,presence: true
    validates :deadline,presence: true
    validates :status,presence: true
    enum priority: {高: 0, 中: 1, 低: 2 }
    enum status: {未着手: 0, 着手: 1, 完了: 2 }
    scope :get_by_title, -> (title) { where('title Like ?', "%#{title}%")}
    scope :get_by_status, -> (status) { where(status: status)}
    belongs_to :user
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
end
