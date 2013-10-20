class WizardsController < ApplicationController
  def hide
    wizard_name = params[:wizard_name]
    current_user.hidden_wizards.where(wizard_name: wizard_name).first_or_create

    respond_to do |format|
      format.js
    end
  end
end
