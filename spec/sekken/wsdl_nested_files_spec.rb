require 'spec_helper'

describe Sekken::WSDL do
  describe 'with local files and imported wsdl' do
    it 'does not fail to create the wsdl' do
      expect{Sekken::WSDL.new(fixture('wsdl/import'), http_mock)}.to_not raise_error
    end
  end

  describe 'with local files and imported wsdl with two levels of import' do
    it 'does not fail to create the sample_header' do
      client = Sekken.new fixture('wsdl/sabre/SessionCreateRQ.wsdl')
      svc = client.operation("SessionCreateRQService","SessionCreatePortType", "SessionCreateRQ");
      expect{svc.example_header}.to_not raise_error
    end
  end

  describe 'with local files and imported wsdl with two levels of import' do
    it 'does not fail to create the sample_body' do
      client = Sekken.new fixture('wsdl/sabre/SessionCreateRQ.wsdl')
      svc = client.operation("SessionCreateRQService","SessionCreatePortType", "SessionCreateRQ");
      expect{svc.example_body}.to_not raise_error
    end
  end

  context 'with multiple levels of import' do
    let(:service) {'OperatingUnitBindingQSService'}
    let(:binding) {'OperatingUnitBindingQSPort'}
    let(:client) {Sekken.new fixture('wsdl/operating_unit/OperatingUnit.wsdl')}
    let(:operations) {["getOpUnit", "search", "upsertOpUnit", "getOpUnitCalendar", "upsertOpUnitCalendar"]}
    it 'should return list of expected operations' do
      operation = client.operation(service,binding, "getOpUnit");
      expect(client.operations(service, binding)).to eq(operations)
    end

    it 'all operations should return a example body' do
      client.operations(service, binding).each do |operation|
        expect(client.operation(service,binding, operation).example_body).to be_a(Hash)
      end
    end

    it 'all operations should return a example header' do
      client.operations(service, binding).each do |operation|
        expect(client.operation(service,binding, operation).example_header).to be_a(Hash)
      end
    end

    it 'should not raise an error when building a request payload' do
      client.operations(service, binding).each do |operation|
        op = client.operation(service,binding, operation)
        op.body = op.example_body
        expect {op.build}.not_to raise_error
      end
    end
  end
end
