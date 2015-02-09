require 'spec_helper'

describe ReportController do

  before :each do
    @appliances = ["Bob", "Linda", "Amy"].map {|s| Appliance.create(customer: s, name: s) }

    @appliances.each do |a| 
      Target.create(hostname: a.customer, address: "127.0.0.1", appliance_id: a.id)      
    end

  end

  describe 'GET to report_data' do
    it 'returns the report as json' do
      report = Report.new(@appliances)
      allow(BatchPing).to receive(:ping!)

      get :report_data
      
      expect(response.status).to eq(200)
      expect(response.body).to eq(report.to_json)
    end
  end

  describe 'GET to report' do
    it 'renders the report view' do
      get :report
      expect(response.status).to eq(200)
      expect(assigns(:customers)).not_to be_nil
      expect(assigns(:targets)).not_to be_nil
      expect(response).to render_template('report')
    end
  end

end
