class UserController < ApplicationController
    before_action :set_coin, only: %i[ destroy edit update]
    def index
        @coins = Coin.all
    end

    def new
        @coin = Coin.new
    end

    def destroy
        @coin.destroy
    
        respond_to do |format|
          format.html { redirect_to coins_url, notice: "Moeda Deletada com sucesso." }
          format.json { head :no_content }
        end
    end

    def update
        respond_to do |format|
          if @coinUser.update(coinUser_params)
            format.html { redirect_to coin_url(@user), notice: "Coin was successfully updated." }
            format.json { render :show, status: :ok, location: @coinUser }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @coinUser.errors, status: :unprocessable_entity }
          end
        end
      end

      # POST /coins or /coins.json
    def create
    @coinUser = Coin.new(coinUser_params)

    respond_to do |format|
      if @coinUser.save
        format.html { redirect_to coin_url(@user), notice: "Coin was successfully created." }
        format.json { render :show, status: :created, location: @coinUser }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coinUser.errors, status: :unprocessable_entity }
      end
     end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_coin
            @coin = Coin.find(params[:id])
        end
        # Only allow a list of trusted parameters through.
        def coin_params
            params.require(:coin).permit(:description, :acronym, :url_image)
        end
end
