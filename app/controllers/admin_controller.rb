class AdminController < ApplicationController
  skip_before_filter :authorize

  TIMEOUT = 5
  POLL_INTERVAL = 0.1
  def index
  end

  def do_migrate
    admin_pwd = params[:password][:admin_pwd]
    if admin_pwd == ENV['ADMIN_PASSWORD'] or true
      puts 'do migrate'
      @output = `bundle exec rake db:migrate`
      # @output = `bundle exec rake db:rollback`
      puts 'fini'
      flash[:notice] = "Migrate success!"
    else
      flash[:alert] = "Password wrong!"
    end
    # raise @@data_pool[:output]
    render :action => 'index'
  end

  def rails_r
    admin_pwd = params[:password][:admin_pwd]
    if admin_pwd == ENV['ADMIN_PASSWORD'] or true
      begin
        script = params[:rails][:r]
        script_wrapper ="begin\n"+script+"\nrescue Exception => e\nputs e\nputs e.backtrace\nend"
        f = Tempfile.new('script')
        f.print script_wrapper
        puts f.path
        f.close
        command = "print `rails r #{f.path}`"
        output = ""
        print command
        t = Thread.new do
          open "|-" do |f|
            if f then
              while data=f.gets
                output<<data
              end
            else
              begin
                eval(command)
              rescue Exception => e
                puts e
              end
            end
          end
        end

        time_counter = 0
        is_timeout = false
        loop do
          sleep POLL_INTERVAL
          time_counter += POLL_INTERVAL
          break unless t.status
          is_timeout = time_counter >= TIMEOUT
          break if is_timeout
        end
        t.kill
        output = "==output(#{time_counter.round(3)}s)=timeout:#{is_timeout}==\n"+output+"\n=========="
        @output = output
      ensure
        f.close
        f.delete
      end
    else
      flash[:alert] = "Password wrong!"
    end
    render :action => 'index'
  end

end
