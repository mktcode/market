class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy follow unfollow ]
  allow_unauthenticated_access only: %i[ show ]

  # GET /users/name or name.emmaherbst.de
  def show
  end

  # GET /users/name/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "Profil wurde erfolgreich aktualisiert." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to user_path, status: :see_other, notice: "Benutzer wurde erfolgreich gelöscht." }
    end
  end

  def follow
    Current.user.following << @user unless Current.user.following.include?(@user)
    redirect_to @user, notice: "Du bekommst jetzt eine E-Mail, wenn #{@user.name.capitalize} ein neues Produkt veröffentlicht."
  end

  def unfollow
    Current.user.following.delete(@user)
    redirect_to @user, notice: "Du bekommst jetzt keine E-Mails mehr, wenn #{@user.name.capitalize} ein neues Produkt veröffentlicht."
  end

  private
    def set_user
      if request.subdomain.present? && request.subdomain != "www"
        @user = User.find_by(name: request.subdomain)
      else
        @user = User.find_by(name: params[:name])
      end

      if @user.nil?
        redirect_to root_url(host: Rails.application.config.main_host), alert: "Benutzer wurde nicht gefunden.", allow_other_host: true
      end
    end

    def user_params
      params.expect(user: [ :name, :bio, :avatar, :header, :slogan ])
    end
end
