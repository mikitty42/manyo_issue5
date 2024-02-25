class Task < ApplicationRecord
    validates :title,presence: true
    validates :content,presence: true
    validates :deadline,presence: true
    validates :status,presence: true
    
    enum status: {未着手: 0, 着手: 1, 完了: 2 }
    scope :get_by_title, -> (title) { where('title Like ?', "%#{title}%")}
    scope :get_by_status, -> (status) { where(status: status)}

end
