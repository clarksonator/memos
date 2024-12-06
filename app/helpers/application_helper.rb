module ApplicationHelper
  def tag_cloud
    @tags = Tag.all
    render partial: "layouts/tags/listing", locals: { tags:  @tags }
  end
end
