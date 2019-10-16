# frozen_string_literal: true

require 'howlong/version'
require 'date'

module Howlong
  def self.find_processes(search)
    processes = processes_from_system(search).split(/\n/)
    names = []
    processes.each do |p|
      process = p.match(/\S+#{search}/)
      # Make sure the first executable contains the search string, so we
      # won't catch processes such as grep `parameter` or this script:
      if process
        time = elapsed_time(p)
        names << [process[0], time]
      end
    end
    names
  end

  def self.build_sentence(process, delayed)
    return if delayed.nil?

    printable = "Process #{process} has been active for "
    if (delayed[:days]).positive?
      printable += "#{delayed[:days]} days, #{(delayed[:seconds].to_int / 86_400) % 24} hours, #{delayed[:minutes] % 60} minutes "
    elsif (delayed[:hours]).positive?
      printable += "#{delayed[:hours]} hours, #{delayed[:minutes] % 60} minutes "
    else
      printable += "#{delayed[:minutes]} minutes "
    end
    printable + "and #{delayed[:seconds] % delayed[:minutes]} seconds"
  end

  def self.sentences_string(process)
    sentences_array(process).join("\n")
  end

  def self.run(process)
    puts sentences_string(process)
  end

  def self.sentences_array(process)
    processes = find_processes(process)
    result = []
    processes.each do |p|
      result << build_sentence(p[0], p[1])
    end
    result
  end

  class << self
    private

    def processes_from_system(search)
      `ps -eo lstart,args | grep -i #{search}`
    end

    def elapsed_time(process)
      # We need the current offset so we can make time operations in the
      # same timezone, yey timezones!
      offset = Time.now.gmt_offset / 3600
      # Get the date from ps in the "Day Mon  %m hh:mm:ss yyyy" format,
      # substract offset and pass it to time
      start = (DateTime.parse(process.match(/[a-zA-Z\s0-9:]+[0-9]{4}/)[0]) - (offset / 24.0)).to_time
      length = Time.now - start

      seconds = length.to_int
      minutes = seconds / 60
      hours   = seconds / 3_600
      days    = seconds / 86_400

      {
        seconds: length.to_int,
        minutes: minutes,
        hours: hours,
        days: days
      }
    end
  end
end
