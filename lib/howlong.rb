require "howlong/version"
require 'date'

module Howlong
  def self.howlong(search)
    processes = `ps -eo lstart,args | grep #{search}`.split(/\n/)
    processes.each do |p|
      process = p.split(/\s/)[5]
      # Make sure the first executable contains the search string, so we
      # won't catch processes such as grep `parameter` or this script:
      if process && process.include?(search)
        return elapsed_time(p)
      else
        puts "No process found with that name"
        return nil
      end
    end
  end

  def self.show(process, delayed)
    unless delayed == nil
    print = "Process #{process} has been active for "
    if delayed[:days] > 0
      print += "#{delayed[:days]} days, #{(delayed[:seconds].to_int / 86_400) % 24} hours, #{delayed[:minutes] % 60} minutes "
    elsif delayed[:hours] > 0
      print += "#{delayed[:hours]} hours, #{delayed[:minutes] % 60} minutes "
    else
      print += "#{delayed[:minutes]} minutes "
    end
    puts print +  "and #{delayed[:seconds] % delayed[:minutes]} seconds"
    end
  end

  def self.run(process)
    show(process, howlong(process))
  end


  private
  def self.elapsed_time(process)
    p = process.split(/\s/)[6]
    # We need the current offset so we can make time operations in the
    # same timezone, yey timezones!
    offset = Time.now.gmt_offset / 3600
    # Get the date from ps in the "Day Mon  %m hh:mm:ss yyyy" format,
    # substract offset and pass it to time
    start = (DateTime.parse(process.match(/[a-zA-Z\s0-9:]+[0-9]{4}/)[0]) - (offset / 24.0)).to_time
    length = Time.now - start

    seconds = length.to_int
    minutes = seconds / 60
    hours  = seconds / 3_600
    days = seconds / 86_400

    return {
      seconds: length.to_int,
      minutes: seconds / 60,
      hours: seconds / 3_600,
      days: seconds / 886_400
    }
  end

end
