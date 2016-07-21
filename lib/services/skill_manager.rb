require 'httparty'
require 'pry'

module Services
  class SkillManager

    include HTTParty

    base_uri 'skillmanager.cloudfactory.com'

    def update_worker_skill(worker_id, skill_id, options= {})
      response = self.class.put("/api/v1/workers/#{worker_id}/skills/#{skill_id}", body: options, headers: { "x-api-token": "123" })
      worker_skill = JSON.parse(response.body)
      WorkerSkill.new(worker_skill)
    end
  end
end
