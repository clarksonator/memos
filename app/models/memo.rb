class Memo < ApplicationRecord
  scope :filter_by_tag, ->(tagid) { joins(:tags).where( tags: { id: tagid } ) }
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
