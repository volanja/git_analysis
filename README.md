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
  "count": {
    "gmail.com": 14
  },
  "infomation": {
    "last_commit_oid": "7bf2839121b1940c4999b187cd5717f9e94a4a85",
    "last_commit_date": "2014-08-04 23:55:25 +0900",
    "total_commit": 14
  }
}

total = `git log --pretty=oneline |wc -l`
```
### Count E-mail Domain (topN add v0.0.3)
if N = 1, display most domain. and others is `total_commit - top1_commit`

```
$ git clone https://github.com/libgit2/rugged.git
$ cd rugged

$ git-analysis count -d -n 2 |jq '.'
{
  "count": {
    "gmail.com": 882,
    "googlemail.com": 453,
    "others": 437
  },
  "infomation": {
    "last_commit_oid": "e96d26174b2bf763e9dd5dd2370e79f5e29077c9",
    "last_commit_date": "2014-07-23 20:16:10 +0900",
    "total_commit": 1772
  }
}
```


### Count Addition & Deletion by Domain (add v0.0.2)
```
$ git-analysis count -l |jq '.'
{
  "count": {
    "gmail.com": {
      "addition": 364,
      "deletion": 74
    }
  },
  "infomation": {
    "last_commit_oid": "022403ad80ee7b22231e40f9a3679a019d5439f6",
    "last_commit_date": "2014-08-06 00:02:01 +0900",
    "total_commit": {
      "addition": 364,
      "deletion": 74
    }
  }
}

note: sort by addition
```

### Count Addition & Deletion by Domain (topN add v0.0.3)
if N = 1, display most domain. and others is `total_commit(add/del) - top1_commit(add/del)`

```
$ git clone https://github.com/libgit2/rugged.git
$ cd rugged

$ git-analysis count -l -n 2 |jq '.'
{
  "count": {
    "gmail.com": {
      "addition": 32308,
      "deletion": 15641
    },
    "googlemail.com": {
      "addition": 17668,
      "deletion": 7277
    },
    "others": {
      "addition": 21768,
      "deletion": 7098
    }
  },
  "infomation": {
    "last_commit_oid": "e96d26174b2bf763e9dd5dd2370e79f5e29077c9",
    "last_commit_date": "2014-07-23 20:16:10 +0900",
    "total_commit": {
      "addition": 71744,
      "deletion": 30016
    }
  }
}
```


## Contributing

1. Fork it ( https://github.com/volanja/git_analysis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
