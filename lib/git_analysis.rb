require "git_analysis/version"
require "git"
require "fileutils"

module GitAnalysis

  # generate git log tog .git/stats/log
  def self.generate()
    if Dir.glob("./.git/stats").count == 0
      puts 'Directory Not Found. (./.git/stats)'
      exit 1
    end
  end
end
