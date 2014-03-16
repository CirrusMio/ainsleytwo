class SayJob
  include SuckerPunch::Job

  def perform(words)
    `say #{words}`
  end
end
