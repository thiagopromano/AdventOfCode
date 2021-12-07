import Config

config :advent_of_code_utils, auto_reload?: true


if File.exists?("config/config_secret.exs"), do: import_config("config_secret.exs")
