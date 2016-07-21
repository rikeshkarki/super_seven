require 'services/skill_manager'
require './spec/lib/services/pact_helper.rb'
require 'worker_skill'
require 'pry'

describe Services::SkillManager, :pact => true do

  before do
    # Configure your client to point to the stub service on localhost using the port you have specified
    Services::SkillManager.base_uri 'localhost:1235'
  end

  subject { Services::SkillManager.new }

  describe "put" do
    before do
      skillmanager_services.given("There is a worker with uid 1 and has skill with id zIEylmLnLx5ug0hlhvbk").
        upon_receiving("a request for a worker skill update").
        with(
              method: :put,
              path: "/api/v1/workers/1/skills/zIEylmLnLx5ug0hlhvbk",
              headers: {"x-api-token" => "123"},
              body: "score=0.92"
            ).
        will_respond_with(
          status: 200,
          headers: {'Content-Type' => 'application/json; charset=utf-8'},
          body: {
                  "id": "zIEylmLnLx5ug0hlhvbk",
                  "title": "PrabhatSkill_test",
                  "status": "skilled",
                  "status_updated_at": "2016-07-19T11:10:45Z",
                  "production": {
                    "invited_at": "2016-07-18T05:32:26Z",
                    "score": 0.92
                  }
                }
        )
    end

    it "returns worker skill detail" do
      expect(subject.update_worker_skill('1', 'zIEylmLnLx5ug0hlhvbk', {score: 0.92}).score).to eq(WorkerSkill.new({
                                                                                                              "id" => "zIEylmLnLx5ug0hlhvbk",
                                                                                                              "title" => "PrabhatSkill_test",
                                                                                                              "status" => "skilled",
                                                                                                              "status_updated_at" => "2016-07-19T11:10:45Z",
                                                                                                              "production" => {
                                                                                                                "invited_at" => "2016-07-18T05:32:26Z",
                                                                                                                "score" => 0.92
                                                                                                             }
                                                                                                            }).score)
    end

  end

end