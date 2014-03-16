class SayJob
  include SuckerPunch::Job
  # minimum celluoid pool size is 2
  workers 2

  def perform(words)
    `say #{words}`
  end
end
