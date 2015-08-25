json.array!(@marketing_documents) do |marketing_document|
  json.extract! marketing_document, :id
  json.url marketing_document_url(marketing_document, format: :json)
end
