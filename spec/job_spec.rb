require 'spec_helper'

describe Job do

  describe '#perform' do
    it 'calls perform for for all missing pdf invoices' do
      invoices = 5.times.map { Invoice.new.finalize! }

      job = Job.new

      job.expects(:perform_for)
        .with(instance_of(Invoice)).times(5)
      job.perform

      invoices.each(&:pdf_generated!)

      job.expects(:perform_for).never
      job.perform
    end
  end

  describe '#perform_for' do
    it 'loads vies data and generates a pdf' do
      invoice = Invoice.new

      VatService.any_instance.expects(:load_vies_data).with(invoice).once
      PdfService.any_instance.expects(:generate_pdf).with(invoice).once

      Job.new.perform_for(invoice)
    end
  end
end
