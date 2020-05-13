defmodule FgHttpWeb.NewDeviceLive do
  @moduledoc """
  Manages LiveView for New Devices
  """

  use Phoenix.LiveView
  use Phoenix.HTML
  alias FgHttp.Devices.Device
  alias FgHttpWeb.Router.Helpers, as: Routes

  def mount(_params, %{"current_user_id" => user_id}, socket) do
    if connected?(socket), do: wait_for_device_connect(socket)

    device = %Device{id: "1", user_id: user_id}
    {:ok, assign(socket, :device, device)}
  end

  defp wait_for_device_connect(_socket) do
    # XXX: pass socket to fg_vpn somehow
    :timer.send_after(3000, self(), :update)
  end

  def handle_info(:update, socket) do
    new_device = Map.merge(socket.assigns.device, %{public_key: "foobar"})
    {:noreply, assign(socket, :device, new_device)}
  end
end
