require 'pact/consumer/rspec'
# or require 'pact/consumer/minitest' if you are using Minitest

Pact.service_consumer "super seven" do
  has_pact_with "superhero universe" do
    mock_service :superhero_services do
      port 1234
    end
  end
end

Pact.service_consumer "client interface" do
  has_pact_with "skill manager" do
    mock_service :skillmanager_services do
      port 1235
    end
  end
end