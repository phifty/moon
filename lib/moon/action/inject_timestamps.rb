
class Moon::Action::InjectTimestamps

  def initialize(model_key)
    @model_key = model_key
  end

  def perform(context)
    @context = context
    fetch_model
    fetch_id
    fetch_now
    inject_created_at unless has_id?
    inject_update_at
    nil
  end

  private

  def fetch_model
    @model = @context.models[@model_key]
  end

  def fetch_id
    @id = GOM::Object.id @model
  end

  def fetch_now
    @now = Time.now
  end

  def has_id?
    !!@id
  end

  def inject_created_at
    @model.created_at = @now
  end

  def inject_update_at
    @model.updated_at = @now
  end

end