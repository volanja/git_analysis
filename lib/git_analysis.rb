require "git_analysis/version"
require "rugged"
require "fileutils"
require "pp"
require "oj"

module GitAnalysis

  # count domain
  def self.count_domain()
    repo = load_repo()
    domain = Array.new
    repo.walk(repo.last_commit).each do |commit|
      # TODO too Slow
      domain << commit.author[:email].match(/([a-zA-Z0-9\_\-\.]+$)/).to_s.rstrip
    end
    count = Hash.new(0)
    domain.each do |elem|
      count[elem] += 1
    end
    puts Oj.dump(count, :mode => :compat)
  end

  # export
  def self.export()
    repo = load_repo()
    commits = repo.walk(repo.last_commit).to_a
    list = Hash.new
    domain = Array.new
    commits.each do |c|
      log = Hash.new
      log[:sha] = c.oid
      log[:message] = c.message
      log[:time] =  c.time
      log[:name] = c.author[:name]
      log[:email] = c.author[:email]
      log[:domain] = c.author[:email].match(/([a-zA-Z0-9\_\-\.]+$)/)[1]
      list["#{c.oid}"] = log
    end
    puts Oj.dump(list, :mode => :compat)
  end

  # 以降はプライベートメソッド
  private

  def self.load_repo()
    repo ||= Rugged::Repository.new(Dir::pwd)
  rescue Rugged::RepositoryError, Rugged::OSError
    p 'Rugged::RepositoryError or Rugged::OSError'
    exit 1
  end

end
