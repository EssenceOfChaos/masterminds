defmodule MastermindsWeb.Router do
  use MastermindsWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", MastermindsWeb do
    pipe_through :browser
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", MastermindsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/logout", AuthController, :logout
    resources "/posts", PostController
    get "/quizzes/:topic", QuizController, :begin
  end

  # Other scopes may use custom stacks.
  # scope "/api", MastermindsWeb do
  #   pipe_through :api
  # end
end
