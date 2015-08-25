class AgentsDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :overview_agent_path, :render

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= %w(
      Agent.first_name
      Agent.last_name
      Agent.agent_number
      Agent.distributor_name
      Agent.designation
      Agent.active
      Agent.actions
    )
  end

  def data
    records.map do |record|
      [
        record.first_name,
        record.last_name,
        record.agent_number,
        record.distributor_name,
        record.designation,
        record.active ? 'Active' : 'Inactive',
        get_action_buttons(record)
      ]
    end
  end

  def searchable_columns
    @searchable_columns ||= %w(
      Agent.first_name
      Agent.last_name
      Agent.agent_number
      Agent.distributor_name
      Agent.designation
    )
  end

  def sortable_columns
    @sortable_columns ||= %w(
      Agent.active
      Agent.first_name
      Agent.last_name
      Agent.agent_number
      Agent.distributor_name
      Agent.designation
    )
  end

  private

  def get_raw_records
    Agent.all
  end

  def get_action_buttons(agent)
    render(partial: 'agents/actions', formats: [:html], locals: { agent: agent })
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
