# GitAnalysis

Analysis Git-Project

## Installation

Install it yourself as:

    $ gem install git_analysis


Tested
```
ruby 2.0.0p353
```

## Usage

```
Commands:
  git-analysis count [-d]      # count(email domain only)
  git-analysis help [COMMAND]  # Describe available commands or one specific command
  git-analysis version         # show version
```

### Count E-mail Domain

(v0.0.1 is this mode only)  
Count Author's Email Domain. In order to investigate the companies that are participating in this project.  
If most domain is "gmail", this project is developed by private developers.  

```sample
$ git clone git@github.com:volanja/git_analysis.git
$ cd git_analysis
$ git-analysis count -d |jq '.'
{
  "gmail.com": 5
}
```

## Contributing

1. Fork it ( https://github.com/volanja/git_analysis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
