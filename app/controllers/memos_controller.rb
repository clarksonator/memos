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
      print "file"
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

  private

  def memo_params
    params.require(:memo).permit(:title, :body, :attachment)
  end
 end
