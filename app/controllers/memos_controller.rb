require "base64"

 class MemosController < ApplicationController
  def index
    @tid = params[:tid]
    @date = params[:date]
    if @tid
      # @memos = current_user.memos.find_by_sql("select memos.id,memos.body,memos.created_at,memos.attachment from memos inner join memos_tags on memos.id = memos_tags.memo_id where tag_id = #{@tid} order by memos.created_at desc")
      @memos = Memo.filter_by_tag @tid
    elsif @date
      @memos = Memo.filter_by_date(@date).order("created_at")
    else
      @memos = current_user.memos
    end
  end

  def search
    if params[:id]
@memos = Memo.find_by_sql("SELECT * from memos INNER JOIN memos_tags on memos.id = memos_tags.memo_id where tag_id = " + params[:id])
    else
      @memos = Memo.all
    end
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def new
    @memo = Memo.new
  end

  def create
    @params = memo_params
    if @params[:tagName] && !@params[:tagName].blank?
      @tagName = @params[:tagName]
      @params.delete(:tagName)
    end
    m = nil
    if @params[:body] && !@params[:body].blank?
      m = /#(.*?) /.match(@params[:body])
      if !m.nil? && m.size > 1
        body = @params[:body]
        for a in 1..m.size-1 do
          body.gsub!("##{m[a]} ", "")
        end
        @params[:body] = body
      end
    end
    @memo = current_user.memos.build(@params)

    if @memo.attachment
      attachmentFile = params[:memo][:attachment]
      enc = Base64.encode64(attachmentFile.read)
      @memo.attachment = enc
    end

    if @memo.save
      if !m.nil? && m.size > 1
        for a in 1..m.size-1 do
          next if m[a].blank?
          tagRecord = Tag.where(name: m[a])
          if tagRecord.one?
            @memo.tags << tagRecord
          else
            @memo.tags.create!({ name: m[a] })
          end
        end
      end
      if @tagName
        @tagName.split(",").each do |tag|
          tagRecord = Tag.where(name: @tagName)
          if tagRecord.one?
            @memo.tags << tagRecord
          else
            @memo.tags.create!({ name: tag })
          end
        end
      end

      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy

    redirect_to root_path, status: :see_other
  end

  def update
      @memo = Memo.find params[:id]
      @memo.update memo_params
      respond_to do |format|
        format.js { render partial: "layouts/memo", object: @memo }
        format.html { render partial: "layouts/memo", object: @memo }
      end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :body, :attachment, :tagName)
  end
 end
