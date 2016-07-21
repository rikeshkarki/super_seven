require 'pry'
class WorkerSkill
  attr_reader :skill_id, :title, :status, :status_updated_at, :score

  def initialize(options)
    @skill_id = options['id']
    @title = options['title']
    @status = options['status']
    @status_updated_at = options['status_updated_at']
    @score = options['production']['score']
  end
end