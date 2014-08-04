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
  git-analysis count [-d][-l]  # count. email-domain or line. please run `git-analysis help count`)
  git-analysis help [COMMAND]  # Describe available commands or one specific command
  git-analysis version         # show version
```

### Count E-mail Domain

Count Author's Email Domain. In order to investigate the companies that are participating in this project.  
If most domain is "gmail", this project is developed by private developers.  

```sample
$ git clone git@github.com:volanja/git_analysis.git
$ cd git_analysis

$ git-analysis count -d |jq '.'
{
  "total": 5,
  "gmail.com": 5
}
```

total = `git log --pretty=oneline |wc -l`

### Count Addition & Deletion by Domain (add v0.0.2)
```
$ git-analysis count -l |jq '.'
{
  "gmail.com": {
    "addition": 290,
    "deletion": 50
  },
  "total": {
    "addition": 290,
    "deletion": 50
  }
}

note: sort by addition
```


## Contributing

1. Fork it ( https://github.com/volanja/git_analysis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
