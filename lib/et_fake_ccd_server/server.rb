require 'sinatra/base'
require_relative './repository'
module EtFakeCcdServer
  class Server < Sinatra::Base
    get '/caseworkers/:uid/jurisdictions/:jid/case-types/:ctid/cases' do |uid, jid, ctid|
      scope = { jid: jid, ctid: ctid }
      if params.key?('case.feeGroupReference')
        scope[:filters] ||= {}
        scope[:filters]['case.feeGroupReference'] = params['case.feeGroupReference']
      end
      repo.all(**scope).to_json
    end

    private

    def repo
      @repo ||= Repository.new
    end
  end
end
