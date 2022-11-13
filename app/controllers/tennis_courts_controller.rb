# frozen_string_literal: true

class TennisCourtsController < ApplicationController
  def by_radius
    @tennis_courts = TennisCourt.master.includes(:reports).by_radius(params[:lat], params[:long])

    render json: @tennis_courts, includes: %i[reports reviews]
  end

  def update
    @tennis_court = TennisCourt.master.find(params[:id])
    if @tennis_court.update(tennis_court_params)
      render json: @tennis_court, status: 200
    else
      render json: @tennis_court.errors, status: 400
    end
  end

  def reports
    @tennis_court = TennisCourt.master.find(params[:id])

    render json: @tennis_court.reports
  end

  def reviews
    @tennis_court = TennisCourt.master.find(params[:id])

    render json: @tennis_court.reviews
  end

  private

  def tennis_court_params
    params.require(:tennis_court).permit(
      reports_attributes: [:status],
      reviews_attributes: %i[id _destroy device_id rating comment],
      tennis_court_suggestions_attributes: %i[
        lat long name street_address_1 street_address_2 city
        state zip num_courts lights time_lights_off court_type
      ]
    )
  end
end
