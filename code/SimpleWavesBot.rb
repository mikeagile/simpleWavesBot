#encoding: utf-8
require 'telegram_bot'
require 'pp'
require 'logger'
require 'net/http'
require 'json'

def idspot(name)
  id='nil'
  file = File.read ("/data/spots.json")
  data = JSON.parse(file)
  data.each do |item|
     if item['name'] == name
        return item['cod']
     end
  end  
  return id
end

logger = Logger.new("/NFS/logs/vlabs/simpleWavesBot/simpleWavesBot.log", Logger::DEBUG)
bot = TelegramBot.new(token: 'yourApiKey', logger: logger)
logger.debug "starting telegram bot"
bot.get_updates(fail_silently: true) do |message|
  logger.info "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)
  message.reply do |reply|
    if idspot(command.downcase) != 'nil'
      url = 'http://magicseaweed.com/api/yourApiKey/forecast/?spot_id=' + idspot(command.downcase)
      uri = URI(url)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      reply.text = "Olas entre #{data[0]['swell']['absMinBreakingHeight']} - #{data[0]['swell']['absMaxBreakingHeight']} metros con periodo de #{data[0]['swell']['components']['primary']['period']} segundos, donde la dirección del Swell es #{data[0]['swell']['compassDirection']} #{data[0]['charts']['swell']}"
      reply.send_with(bot)
      reply.text = "Y, un viento de #{data[0]['wind']['speed']} kph con dirección #{data[0]['wind']['compassDirection']} #{data[0]['charts']['wind']}"
      reply.send_with(bot)
    else
      reply.text = "#{message.from.first_name}, lo siento, pero no hemos encontrado niguna información para la playa #{command.inspect}, es realmente una playa ;)"
      reply.send_with(bot)
    end
    logger.info "sending #{reply.text.inspect} to @#{message.from.username}"
  end
end
