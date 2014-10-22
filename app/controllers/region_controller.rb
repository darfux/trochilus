class RegionController < ApplicationController
  def country
    respond_to do |format|
      format.json { render json: Region::Country.all }
    end
  end

  def state
    states = Region::State.where(region_country_id: params[:p_id]).map{ |s| {id: s.id, name: s.name} }
    respond_to do |format|
      format.json { render json: states }
    end
  end

  def city
    cities = Region::City.where(region_state_id: params[:p_id]).map{ |s| {id: s.id, name: s.name} }
    respond_to do |format|
      format.json { render json: cities }
    end
  end
end
