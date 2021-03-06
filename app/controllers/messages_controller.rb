class MessagesController < ApplicationController

  def index
    @message = Message.new
    @room = Room.find(params[:room_id]) # params内のroom_id(パスに含まれる)を代入　
    @messages = @room.messages.includes(:user).order("created_at DESC") # 表示するインスタンス
  end                                                                   # 降順に表示

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    # 保存できたらメッセージの一覧画面へ
    if @message.save
      redirect_to room_messages_path(@room)
    # 保存できなければ、indexアクションで同じページへ
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  # チャットルームに紐づいたメッセージのみを保存
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end