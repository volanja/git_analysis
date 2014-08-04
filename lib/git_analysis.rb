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
    count = Hash.new{|h,k| h[k] = Hash.new(0) }
    repo.walk(repo.last_commit).each do |commit|
      domain = commit.author[:email].gsub(/\A[a-zA-Z0-9\_\-\.\+ ]+@/,"").rstrip
      diff = commit_diff(repo, commit)

      count[:"#{domain}"][:"addition"] += diff[1].to_i
      count[:"#{domain}"][:"deletion"] += diff[2].to_i

      count[:"total"][:"addition"] += diff[1].to_i
      count[:"total"][:"deletion"] += diff[2].to_i
    end
    # TODO more Faster! it takes 50 sec(10k / sec).
    sorted = count.sort_by{|a,b| -b[:"addition"] }
    puts Oj.dump(Hash[sorted], :mode => :compat)
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

  def self.commit_diff(repo,commit)
    sha = String.new
    sha_parents = String.new
    diff_stat = Array.new

    sha = commit.oid
    unless commit.parents[0].nil?
      sha_parents = commit.parents[0].oid
      # Too Slow. More Faster
      diff_stat = repo.diff(sha_parents,sha).stat
    else
      tmp = commit.diff.stat
      diff_stat = [tmp[0], tmp[2], tmp[1]]
    end
    return diff_stat
  end

end
