# frozen_string_literal: true

module Rails7StartKit
  class << self
    def puma_start_command
      'bundle exec puma -C config/_PUMA.rb'
    end

    def puma_stop_command
      'pkill -f puma'
    end

    # rubocop:disable Lint/UselessAssignment
    def puma_start
      puts 'Launching PUMA'
      if inside_rails_conainer?
        system(puma_start_command)
      else
        container_bash_exec('rails', puma_start_command, detached = true)
      end
    end

    def puma_stop
      puts 'Stopping PUMA'
      if inside_rails_conainer?
        system("PUMA_WORKERS=0 #{puma_start_command} & ")
      else
        container_bash_exec('rails', puma_stop_command)
      end
    end
    # rubocop:enable Lint/UselessAssignment

    def puma_restart
      puma_stop
      puma_start
    end
  end
end
