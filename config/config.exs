import Config

config :tesla, adapter: Tesla.Adapter.Hackney

if config_env() == :test do
  import_config("test.exs")
end
