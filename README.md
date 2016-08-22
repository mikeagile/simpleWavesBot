## Feature

This Bot are design for Eslang.es

## Code Example

You can see an example of CODE

```
   url = 'http://magicseaweed.com/api/yourApiKey/forecast/?spot_id=' + id 
   uri = URI(url)
   response = Net::HTTP.get(uri)
   data = JSON.parse(response)
      reply.text = "Olas entre #{data[0]['swell']['absMinBreakingHeight']} - #{data[0]['swell']['absMaxBreakingHeight']} metros con periodo de #{data[0]['swell']['components']['primary']['period']} segundos, donde la dirección del Swell es #{data[0]['swell']['compassDirection']} #{data[0]['charts']['swell']}"
      reply.send_with(bot)
```

## Motivation

We hope this will serve as code to help accelerate the development of chatbots

## Installation

Run -bundle install- to install the necessary ruby gems for use this bot. You will see the list in the Gemfie file.

Steps:
* cloned repository
* bundle install
* execute "ruby /example/bot.rb" in the command line

Or talk directly https://telegram.me/simpleWavesBot :)

Examples:

```ruby /example/bot.rb```

## Contributors

* Miguel Ángel Villar Gutiérrez (miguel.angel.villar.gutierrez@gmail.com).
* https://www.linkedin.com/in/mikeagile

## License

In progress by https://about.me/ma.villar


