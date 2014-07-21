require "git_analysis/version"
require "rugged"
require "fileutils"
require "pp"

module GitAnalysis

  # generate git log tog .git/stats/log
  def self.generate()
    if Dir.glob("./.git/stats").count == 0
      puts 'Directory Not Found. (./.git/stats)'
      #exit 1
    end
    repo = Rugged::Repository.new(Dir::pwd)
    commits = repo.walk(repo.last_commit).to_a
    list = Hash.new
    commits.each do |c|
      log = Hash.new
      #pp c.inspect
      log[:sha] = c.oid
      log[:message] = c.message
      log[:time] =  c.time
      log[:name] = c.author[:name]
      log[:email] = c.author[:email]
      list["#{c.oid}"] = log
    end
    pp list
  end

  # 以降はプライベートメソッド
  private
end
