class UserController < ApplicationController
    before_action :set_coin, only: %i[destroy]
    def index
        @coins = Coin.all
    end

    def destroy
        @coin.destroy
    
        respond_to do |format|
          format.html { redirect_to coins_url, notice: "Moeda Deletada com sucesso." }
          format.json { head :no_content }
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin
      @coin = Coin.find(params[:id])
    end
end
