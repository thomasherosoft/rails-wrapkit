class IndependentContractorsController < WebApplicationController
  before_action :authorize_user
  before_action :set_ic, only: [:show, :edit, :update, :destroy, :overview, :information, :stats,
                                   :payroll,:ongoing_deals, :badged_image_upload]

  def index
    respond_to do |format|
      format.html {}
      format.json {
        render json: IndependentContractorsDatatable.new(
                 view_context,
                 {current_user: current_user}
               )
      }
    end
  end

  def add
    @ic = IndependentContractor.new
    @ic.build_user
    render layout: false
  end

  def show
    subtype = @ic.subtype
    if subtype.is_a? Agent
      render :agent_overview
    end
  end

  def new
    @ic = IndependentContractor.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ic.update(ic_params)
        format.html { redirect_to @ic, notice: 'Agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @ic, locals: { status: "success", message: I18n.t('agent.agent_update.toastr_success')}}
      else
        format.html { render :edit }
        format.json { render json: @ic.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @ic = IndependentContractor.new(ic_params)

    respond_to do |format|
      if @ic.save
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.json { render :show, status: :created, location: @agent }
      else
        binding.pry
        format.html { render :add }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # todo: no user should get destroyed, just inactivated
    # @ic.destroy
    respond_to do |format|
      format.html { redirect_to independent_contractors_url, notice: 'Independent contractor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def overview
  end

  def information
  end

  def stats
  end

  def payroll
  end

  def ongoing_deals
  end

  def badged_image_upload
    respond_to do |format|
      if @ic.update(agent_image)
        format.json { render nothing: true}
      else
        format.html { render :edit }
      end
    end
  end

  private
  def authorize_user
    authorize :ic_menu, :any?
  end

  def ic_params
    binding.pry
    params.require(:agent).permit(:first_name, :last_name, :username, :address, :city, :postal_code, :state_province, :country,
                                  :home_phone, :mobile, :email, :sin_number, :type, :distributor_name,
                                  :agent_number, :payment_method, :gst_number, :bin_number, :pre_inspector, :active)
  end

  def set_ic
    @ic = IndependentContractor.find(params[:id])
  end

  def agent_image
    params.permit(:badge_image)
  end
end
