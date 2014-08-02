require "git_analysis/version"
require "rugged"
require "fileutils"
require "pp"
require "oj"

module GitAnalysis

  # count domain
  def self.count_domain()
    repo = load_repo()
    count = Hash.new(0)
    repo.walk(repo.last_commit).each do |commit|
      # TODO more Faster
      domain = commit.author[:email].gsub(/\A[a-zA-Z0-9\_\-\.\+ ]+@/,"").rstrip
      count[:"#{domain}"] += 1
      count[:"total"] += 1
    end
    sorted = count.sort_by{|a,b| -b }
    puts Oj.dump(Hash[sorted], :mode => :compat)
  end

  def self.count_diff()
    repo = load_repo()
    repo.walk(repo.last_commit).each do |commit|
      sha = String.new
      sha_parents = String.new
      sha = commit.oid
      unless commit.parents[0].nil?
        sha_parents = commit.parents[0].oid
        diff_stat = repo.diff(sha_parents,sha).stat
      else
        diff_stat = commit.diff.stat
      end
      puts "add "+ diff_stat[1].to_s + ", del "+ diff_stat[2].to_s
    end
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
