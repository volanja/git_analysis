require "git_analysis/version"
require "git"
require "fileutils"
require "pp"

module GitAnalysis

  # generate git log tog .git/stats/log
  def self.generate()
    if Dir.glob("./.git/stats").count == 0
      puts 'Directory Not Found. (./.git/stats)'
      exit 1
    end
    g = Git.open(Dir::pwd)
    p g.config('remote.origin.url')
    # Get Commit Infomation
    list = Hash.new
    g.log.each {|l|
      log = Hash.new
      log["sha"] = l.sha
      log["date"] = l.author.date
      log["email"] = l.author.email
      log["name"] = l.author.name
      log["mesagge"] = l.message

      list["#{l.sha}"] = log
    }
    pp list
  end

  # 以降はプライベートメソッド
  private
end
