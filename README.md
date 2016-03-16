# Language Heatmap
Trying to build a heatmap in the US of programming language hotspots


## Goals
- Practice Top-Down TDD
- Practice good dependency management with constructor injection
- Mock collaborators for small unit tests
- Push state to edges of application and avoid stateful classes
- Keep unit tests green
- Use cucumber as integration test to drive development

## Install and Run
`bundle install`  
**RSpec:** `rspec`  
**Cucumber:** `cucumber`  


A few good resources:   
https://upload.wikimedia.org/wikipedia/commons/5/5f/USA_Counties_with_FIPS_and_names.svg  
http://flowingdata.com/2009/11/12/how-to-make-a-us-county-thematic-map-using-free-tools/  
http://bl.ocks.org/mbostock/4060606  
https://github.com/octokit/octokit.rb  
https://developer.github.com/v3/search/  
https://github.com/ReactiveX/RxRuby

```
https://api.github.com/search/repositories?q=language:ruby
  ||> contributors_url
  ||> login
  ||> https://api.github.com/users/{login}
  ||> location
  ||> filter non_us
  ||> reduce by frequency
  ||> map to color code
  ||> place on svg, recording non-matches
```

```
client = Octokit::Client.new(login: 'username', password: 'pword')
client.search_repos("language:ruby").items.map{ |repo| repo[:full_name] }.map{ |name| client.contributors(name) }.flatten.map{ |contributor| contributor[:login] }.map{ |login| client.user(login) }.map{ |user| user[:location] }
```
