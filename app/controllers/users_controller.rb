class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ show ]

  # GET /users/name or /users/name.json or name.emmaherbst.de
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/name/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "Benutzer wurde erfolgreich erstellt." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "Benutzer wurde erfolgreich aktualisiert." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to user_path, status: :see_other, notice: "Benutzer wurde erfolgreich gelöscht." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      if request.subdomain.present? && request.subdomain != "www"
        @user = User.find_by(name: request.subdomain)
      else
        @user = User.find_by(name: params[:name])
      end
    end

    def user_params
      params.expect(user: [ :name, :bio, :avatar ])
    end
end
