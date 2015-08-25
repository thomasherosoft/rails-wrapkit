class CustomersController < WebApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy, :overview, :verification, :service, :billing, :history]

  protect_from_forgery :except => :index

  def index
    respond_to do |format|
      format.html {}
      format.json { render json: CustomersDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer, locals: { status: "success", message: I18n.t('customer.customer_update.toastr_success')}}
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def overview
     # @customer =
  end

  def verification
  end

  def service
  end

  def billing
  end

  def history
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :service_street_number, :service_address, :service_city,
                                       :service_province, :service_country, :service_phone, :service_mobile,
                                       :service_email, :fi_postal_code, :mailing_street_number, :mailing_address,
                                       :mailing_city, :mailing_province, :mailing_country, :mailing_phone,
                                       :mailing_mobile, :mailing_email, :use_service_address)
    end
end
