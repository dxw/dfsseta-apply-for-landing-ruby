# frozen_string_literal: true

class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

  LANDABLE_BODIES = [
    OpenStruct.new(id: "f869e63d-3ce5-4480-b8ac-3eb0c266f659", name: "Mars"),
    OpenStruct.new(id: "56f498b9-3b76-4ce8-9f3e-8a9ef20594f3", name: "Saturn (core)"),
    OpenStruct.new(id: "11bced89-eb9c-4163-ad9e-c3cb89d6745c", name: "International Space Station (ESA)"),
    OpenStruct.new(id: "bd41bc58-044b-4841-b159-219b091f68f2", name: "Tiangong space station"),
    OpenStruct.new(id: "5db88724-cb68-431f-a7c6-6f08347458f4", name: "Earth's moon"),
    OpenStruct.new(id: "21c97e41-ca50-4549-9892-36196d602a0f", name: "Pluto")
  ].freeze

  def health_check
    render json: {
      rails: "OK",
      git_sha: ENV.fetch("CURRENT_GIT_SHA", "UNKNOWN"),
      built_at: ENV.fetch("TIME_OF_BUILD", "UNKNOWN")
    }, status: :ok
  end
end
