class Task
  attr_reader :id, :description, :status, :created_at, :updated_at

  def initialize(text, id)
    @id = id
    @description = text
    @status = :todo
    @created_at = Time.now
    @updated_at = Time.now
  end

  def to_h
    { id: id, description: description, status: status, createdAt: created_at, updatedAt: updated_at }
  end
end
