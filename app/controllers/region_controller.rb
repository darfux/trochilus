class RegionController < ApplicationController
  def country
    respond_to do |format|
      format.json { render json: Region::Country.all }
    end
  end

  def state
    states = Region::State.where(region_country_id: params[:p_id]).sort_by{ |e| e.name_with_py }.map{ |s| {id: s.id, name: s.name_with_py} }
    respond_to do |format|
      format.json { render json: states }
    end
  end

  def city
    cities = Region::City.where(region_state_id: params[:p_id]).sort_by{ |e| e.name_with_py }.map{ |s| {id: s.id, name: s.name_with_py} }
    respond_to do |format|
      format.json { render json: cities }
    end
  end
end
