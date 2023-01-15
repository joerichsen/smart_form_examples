defmodule SmartFormExamplesWeb.HelloWorldLive do
  use SmartFormExamplesWeb, :live_view

  alias SmartFormExamples.{Repo, User}

  defmodule Form do
    use SmartForm

    smart_form do
      field :name, :string, required: true
      field :email, :string, required: true, format: ~r/@/
    end
  end

  def render(assigns) do
    ~H"""
    <.header>Hello World</.header>

    <.simple_form :let={f} for={@form} phx-change="validate" phx-submit="save">
      <.input field={{f, :name}} label="name" />
      <.input field={{f, :email}} label="Email" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>

    <.header class="mt-5">Users</.header>
    <ul>
      <%= for user <- @users do %>
        <li><%= user.name %> - <%= user.email %></li>
      <% end %>
    </ul>
    """
  end

  def mount(_params, _session, socket) do
    form = Form.new(%User{})
    users = Repo.all(User)
    {:ok, load_data(socket)}
  end

  def load_data(socket) do
    form = Form.new(%User{})
    users = Repo.all(User)
    assign(socket, form: form, users: users)
  end

  def handle_event("validate", %{"form" => params}, socket) do
    form = socket.assigns.form |> Form.validate(params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"form" => params}, socket) do
    form = socket.assigns.form |> Form.validate(params)

    if form.valid? do
      form |> Form.changeset() |> Repo.insert()
      {:noreply, load_data(socket)}
    else
      {:noreply, assign(socket, form: form)}
    end
  end
end
