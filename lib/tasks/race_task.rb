require 'date'
require './app/models/race'

class RaceTask

  def self.update_race_progress
    puts "#{Time.now} update_race_progress started."
    today = Date.today.to_datetime
    RakutenRanking.instance.clear
    Race.find(:all, conditions: ["collect_start <= ? and collect_end >= ?", today, today]).each do |r|
      puts "race : #{r.name}, end_date : #{r.end_date}"
      r.create_progress today
    end
    puts "#{Time.now} update_race_progress finished."
  end

  def self.start_races
    puts "#{Time.now} start races started."
    threads = []
    Race.where(["state = ? and start_date <= ?", 'READY', Time.now]).each do |r|
      threads << Thread.new { r.start }
    end    
    sleep 1
    threads.each {|t| t.join}
    puts "#{Time.now} start races finished."
  end

# start_races()でVotingCard#payback()を呼び出すため、コメントアウト
=begin
  def self.payback_voting_card
    puts "#{Time.now} payback_voting_card started."
    today = Date.today.to_datetime
    Race.where(end_date: today).load.each do |race|
      puts "race : #{race.name}, end_date : #{race.end_date}"
      race.create_result unless race.race_result
      race.voting_cards.find_all_by_payout(nil).each do |card|
        card.payback
      end
    end
    puts "#{Time.now} payback_voting_card finished."
  end
=end

end
