# frozen_string_literal: true

class PilotsController < ApplicationController
  def start
    @landable_bodies = LANDABLE_BODIES
  end
end
