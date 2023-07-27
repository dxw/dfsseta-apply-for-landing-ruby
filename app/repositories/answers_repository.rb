class AnswersRepository
  def initialize(session)
    @session = session
  end

  def save(stage_name:, answer:)
    @session.update(stage_name => answer)
  end

  def find(stage_name)
    @session.dig(stage_name)
  end
end
