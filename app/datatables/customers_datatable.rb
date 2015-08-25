class CustomersDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :overview_agent_path, :render

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= [
      'Customer.id', 'Customer.first_name', 'Customer.last_name', 'Customer.service_address',
      'Customer.service_phone', 'Customer.actions'
      # :id, :first_name, :last_name, :service_phone, :service_street_number, :service_address, :service_city, :service_province
    ]
  end

  def data
    records.map do |record|
      [
        record.id,
        record.first_name,
        record.last_name,
        record.address,
        record.phone_number,
        get_action_buttons(record)
      ]
    end
  end

  def searchable_columns
    @searchable_columns ||= %w(Customer.first_name Customer.last_name Customer.service_address Customer.service_phone)
    # this is equal to:
    # @searchable_columns ||= ['User.first_name', 'User.last_name', 'User.bio']
  end

  def sortable_columns
    @sortable_columns ||= %w(Customer.id Customer.first_name Customer.last_name Customer.service_address Customer.service_phone)
    # this is equal to:
    # @sortable_columns ||= ['User.first_name', 'User.last_name', 'User.bio']
  end

  private

  def get_raw_records
    Customer.general
    # Customer.includes(:user).general

    # this is a ActiveRecord:Relation
    # result.filter(column_params).sort(view_columns)
  end

  def get_action_buttons(customer)
    render(partial: "customers/actions", formats: [:html], locals: { customer: customer})
  end

end
