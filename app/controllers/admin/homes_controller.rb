class Admin::HomesController < ApplicationController
  get "/admin" => "homes#top", as: "top"
end
