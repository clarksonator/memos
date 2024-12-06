class Memo < ApplicationRecord
  scope :filter_by_tag, ->(tagid) { joins(:tags).where( tags: { id: tagid } ) }
  scope :filter_by_date, lambda { |date| where("strftime('%m/%d/%Y',datetime(created_at,'localtime')) = ?", date) }
  belongs_to :user
  has_and_belongs_to_many :tags
  def get_tags
    @tag_names = ""
    tag_ids.each do |tag|
      @tag_names << Tag.find(tag).name << ","
    end
  @tag_names.chop
  end
end
