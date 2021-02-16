# url-checker

Terminal based tool to check status of set URL's.
Runs concurrently
Code along with https://www.twitch.tv/lbarasti

## Installation

`shards install`

## Usage

`crystal src/url-checker.cr`

#### Current Expected Output
``` crystal
["http://google.com", "https://amazon.com", "http://localhost:3000"]
{"http://google.com" => {success: 1, failure: 0}}
{"http://google.com" => {success: 1, failure: 0},
 "http://localhost:3000" => {success: 0, failure: 1}}
{"http://google.com" => {success: 1, failure: 0},
 "http://localhost:3000" => {success: 0, failure: 1},
 "https://amazon.com" => {success: 1, failure: 0}}
 ```

## Contributing

1. Fork it (<https://github.com/your-github-user/url-checker/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ashlie Gray](https://github.com/your-github-user) - creator and maintainer
