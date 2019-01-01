defmodule MastermindsWeb.PostView do
  use MastermindsWeb, :view

  def format_name(name) when is_binary(name)do
    hd(String.split(name, "/"))
  end
end
