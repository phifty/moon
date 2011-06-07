
module Moon::Action

  autoload :InjectTimestamps, File.join(File.dirname(__FILE__), "action", "inject_timestamps")
  autoload :Model, File.join(File.dirname(__FILE__), "action", "model")
  autoload :Models, File.join(File.dirname(__FILE__), "action", "models")
  autoload :RebuildArrays, File.join(File.dirname(__FILE__), "action", "rebuild_arrays")
  autoload :Reference, File.join(File.dirname(__FILE__), "action", "reference")
  autoload :RespondBlank, File.join(File.dirname(__FILE__), "action", "respond_blank")
  autoload :Transfer, File.join(File.dirname(__FILE__), "action", "transfer")
  autoload :ValidModelsRequired, File.join(File.dirname(__FILE__), "action", "valid_models_required")

end
