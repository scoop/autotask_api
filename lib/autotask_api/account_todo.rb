require 'time'

module AutotaskAPI
  class AccountToDo < Entity
    self.fields = [ :id, :account_id, :action_type, :activity_description,
                    :completed_date, :start_date_time, :end_date_time ]

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

    def start_time
      Time.parse start_date_time
    end

    def end_time
      Time.parse end_date_time
    end
  end
end
