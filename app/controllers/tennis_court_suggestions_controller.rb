# frozen_string_literal: true

class TennisCourtSuggestionsController < ApplicationController
  def create
    @tennis_court_suggestion = TennisCourtSuggestion.new(tennis_court_suggestion_params)

    if @tennis_court_suggestion.save
      render json: @tennis_court_suggestion, status: 201
    else
      render json: @tennis_court_suggestion.errors, status: 400
    end
  end

  private

  def tennis_court_suggestion_params
    params.require(:tennis_court_suggestion).permit(
      :name, :street_address_1, :street_address_2, :city,
      :state, :zip, :num_courts, :lights, :time_lights_off, :court_type
    )
  end
end
