require "base64"

 class MemosController < ApplicationController
  def index
    @memos = Memo.all
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)

    if @memo.attachment
      attachmentFile = params[:memo][:attachment]
      enc = Base64.encode64(attachmentFile.read)
      @memo.attachment = enc
    end

    if @memo.save
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
    params.require(:memo).permit(:title, :body, :attachment)
  end
 end
