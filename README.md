autotask_api
============

Ruby API wrapper for the Autotask WebService API

Sample code:
------------

    client = AutotaskAPI::Client.new do |c|
      c.basic_auth = ['user@example.com','mypassword']
      c.wsdl = 'https://webservices.autotask.net/atservices/1.5/atws.wsdl'
    end

    query = AutotaskAPI::QueryXML.new do |query|
      query.entity = 'contact'
      query.field = 'firstname'
      query.expression = 'Joe'
    end

    client.query query
