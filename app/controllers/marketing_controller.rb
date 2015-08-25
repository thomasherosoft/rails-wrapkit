class MarketingController < WebApplicationController
  before_action :set_marketing_document, only: [:show, :edit, :update, :destroy]

  # GET /marketing_documents
  # GET /marketing_documents.json
  def index
    @marketing_documents = MarketingDocument.all
  end

  # GET /marketing_documents/1
  # GET /marketing_documents/1.json
  def show
  end

  # GET /marketing_documents/new
  def new
    @marketing_document = MarketingDocument.new
  end

  # GET /marketing_documents/1/edit
  def edit
  end

  def products
  end

  def programs
  end

  def digital_field
  end

  def collateral
  end

  def promotions
  end

  # POST /marketing_documents
  # POST /marketing_documents.json
  def create
    @marketing_document = MarketingDocument.new(marketing_document_params)

    respond_to do |format|
      if @marketing_document.save
        format.html { redirect_to @marketing_document, notice: 'Marketing document was successfully created.' }
        format.json { render :show, status: :created, location: @marketing_document }
      else
        format.html { render :new }
        format.json { render json: @marketing_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marketing_documents/1
  # PATCH/PUT /marketing_documents/1.json
  def update
    respond_to do |format|
      if @marketing_document.update(marketing_document_params)
        format.html { redirect_to @marketing_document, notice: 'Marketing document was successfully updated.' }
        format.json { render :show, status: :ok, location: @marketing_document }
      else
        format.html { render :edit }
        format.json { render json: @marketing_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marketing_documents/1
  # DELETE /marketing_documents/1.json
  def destroy
    @marketing_document.destroy
    respond_to do |format|
      format.html { redirect_to marketing_documents_url, notice: 'Marketing document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketing_document
      @marketing_document = MarketingDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marketing_document_params
      params[:marketing_document]
    end
end
