class SayJob
  include SuckerPunch::Job
  workers 1

  def perform(words)
    `say #{words}`
  end
end
