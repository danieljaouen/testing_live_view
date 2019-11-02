defmodule TestingLiveViewWeb.UserLive.New do
  use Phoenix.LiveView

  alias TestingLiveViewWeb.UserLive
  alias TestingLiveViewWeb.Router.Helpers, as: Routes
  alias TestingLiveView.Authentication
  alias TestingLiveView.Authentication.User

  def mount(_session, socket) do
    {
      :ok,
      assign(
        socket,
        %{
          count: 0,
          changeset: Authentication.change_user(%User{})
        }
      )
    }
  end

  def render(assigns) do
    TestingLiveViewWeb.UserView.render("new.html", assigns)
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> TestingLiveView.Authentication.change_user(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Authentication.create_user(user_params) do
      {:ok, _user} ->
        {
          :stop,
          socket
          |> put_flash(:info, "user created")
          |> redirect(to: Routes.user_path(socket, :index))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
