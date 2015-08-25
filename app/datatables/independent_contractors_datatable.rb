class IndependentContractorsDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :independent_contractors_path, :render

  def view_columns
    @view_columns ||= %w(
      User.first_name
      User.last_name
      IndependentContractor.agent_number
      Distributorship.name
      User.status
      User.created_at
      actions
    )
  end

  def data
    records.map do |record|
      [
        record.user.first_name,
        record.user.last_name,
        record.agent_number,
        record.user.get_absolute_subtype.class.to_s.titlecase,
        record.office.distributorship.name,
        record.user.active ? 'Active' : 'Inactive',
        record.user.created_at.strftime("%Y-%m-%d"),
        get_action_buttons(record)
      ]
    end
  end

  def searchable_columns
    @searchable_columns ||= %w(
      User.first_name
      User.last_name
    )
  end

  private

  def get_raw_records
    # TODO: finish with the authorization
    case choosing_role
      when "Employee"
        IndependentContractor
          .joins(:user)
          .joins(office: :distributorship)
      when "Distributor"
        # Get all ICs in the user's distributorships
        # including other distributors
        IndependentContractor
        .joins(:user)
        .joins(office: :distributorship)
        .where('distributor_id is not null')
      when "OfficeManager"
        IndependentContractor
          .joins(:user)
          .joins(office: :distributorship)
          .where(office: current_user.subtype.office)
          .where('office_manager_id is not null')
      when "OfficeAdmin"
        IndependentContractor
          .joins(:user)
          .joins(office: :distributorship)
          .where(office: current_user.subtype.office)
          .where('office_admin_id IS NOT NULL')
      when "Recruiter"
        IndependentContractor
          .joins(:user)
          .joins(office: :distributorship)
          .where(office: current_user.subtype.office)
          .where('recruiter_id IS NOT NULL')
      when "TeamLead"
        IndependentContractor
          .joins(:user)
          .joins(office: :distributorship)
          .where('team_lead_id IS NOT NULL')
      when "Agent"
        IndependentContractor
        .joins(:user)
        .joins(office: :distributorship)
        .joins(:agent)
        .where('agent_id IS NOT NULL')
      else
        nil
    end
  end

  def get_action_buttons(ic)
    render(partial: 'independent_contractors/actions', formats: [:html], locals: { ic: ic })
  end

  def current_user
    @current_user ||= options[:current_user]
  end

  def current_user_absolute_subtype
    @current_user_absolute_subtype = current_user.get_absolute_subtype
  end

  def choosing_role
    @choosing_role = params[:extra_search].present? ? params[:extra_search].tr(" ", "") : "Employee"
  end
end
