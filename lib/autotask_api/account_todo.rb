require 'time'

module AutotaskAPI
  class AccountToDo < Entity
    self.fields = [ :id, :account_id, :action_type, :activity_description,
                    :completed_date, :start_date_time, :end_date_time,
                    :contact_id, :creator_resource_id, :create_date_time,
                    :assigned_to_resource_id ]

    belongs_to :account
    belongs_to :contact
    belongs_to :assigned_to_resource, class_name: :resource

    delegate :account_name, to: :account
    delegate :phone, :email, :full_name, to: :contact, prefix: true,
      allow_nil: true

    def set_title_and_description
      @title, @description = activity_description.to_s.split(/\r?\n/).
        collect(&:strip)
    end

    def title
      @title || set_title_and_description.first
    end

    def description
      @title || set_title_and_description.last
    end

    def create_time
      Time.parse create_date_time
    end

    def start_time
      Time.parse start_date_time
    end

    def end_time
      Time.parse end_date_time
    end

    def completed?
      !completed_date.blank?
    end
  end
end
