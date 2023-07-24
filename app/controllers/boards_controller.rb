class BoardsController < ApplicationController
  include Pagy::Backend
  before_action :set_board, only: %i[ show ]

  def index
    @pagy, @boards = pagy(Board.all)
  end

  def show
  end

  def new
    @board = Board.new
    @last_ten_boards = Board.last(10).reverse
  end

  def create
    @board = Board.new(board_params)
    @last_ten_boards = Board.last(10).reverse

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:email, :width, :height, :number_of_mines, :name)
    end
end
