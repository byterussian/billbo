class PdfService

  def initialize(uploader: Configuration.uploader)
    @uploader = uploader
  end

  def generate_pdf(invoice)
    phantom = Shrimp::Phantom.new(
      "http://X:#{Configuration.api_token}@#{Configuration.host}/invoices/#{invoice.number}")
    phantom.to_pdf("tmp/#{invoice.number}.pdf")

    invoice.pdf_generated! if uploader.store!(File.open("tmp/#{invoice.number}.pdf"))
  end

  private

  attr_reader :uploader
end
