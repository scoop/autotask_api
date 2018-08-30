autotask_api
============

Ruby API wrapper for the Autotask WebService API

Sample code:
------------

    client = AutotaskAPI::Client.new do |c|
      c.basic_auth = ['user@example.com', 'mypassword']
      c.wsdl = 'https://webservices.autotask.net/atservices/1.5/atws.wsdl'
    end

    query = AutotaskAPI::QueryXML.new do |query|
      query.entity = 'contact'
      query.field = 'firstname'
      query.expression = 'Joe'
    end

    client.query = query
    
    
`find_all` usage: This will fetch all the billing items for a given invoice id.

    billing_items = BillingItem.find_all(1, 'invoiceId')
    
  

Webservices endpoints:
----------------------

Autotask usually requires you to talk to a specific webservices endpoint. If
you do not know the endpoint you're supposed to be talking to, you can use the
`getZoneInfo` call of the API to find out.


    client = AutotaskAPI::Client.new do |c|
      c.basic_auth = ['user@example.com', 'mypassword']
      c.wsdl = 'https://webservices.autotask.net/atservices/1.5/atws.wsdl'
      c.log = true
    end

    puts client.zone_info('another@user.com')

This will result in a bunch of XML, like so:

    <getZoneInfoResponse xmlns="http://autotask.net/ATWS/v1_5/">
      <getZoneInfoResult>
        <URL>https://webservices7.autotask.net/ATServices/1.5/atws.asmx</URL>
        <ErrorCode>0</ErrorCode>
        <DataBaseType/>
        <CI>12345678</CI>
      </getZoneInfoResult>
    </getZoneInfoResponse>

For this user, then, you should use `webservices7` as the API endpoint.
