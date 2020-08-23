class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image
  # 画像なしでもテキストがあれば投稿できる
  validates :content, presence: true, unless: :was_attached?

  # 画像だけでも可
  def was_attached?
    self.image.attached?
  end
end