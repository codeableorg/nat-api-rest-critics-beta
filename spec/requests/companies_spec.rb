require 'rails_helper'
describe 'Companies', type: :request do

  describe 'index path' do
    it 'respond with http success status code' do
      Company.create(name: 'Test')
      get '/api/companies'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show path' do
    it 'respond with the correct company' do
      company = Company.create(name: 'Test')
      get api_company_path(company)
      actual_company = JSON.parse(response.body)
      expect(actual_company['id']).to eql(company.id)
    end
  end
end