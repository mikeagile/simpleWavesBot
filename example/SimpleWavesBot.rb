#encoding: utf-8
require 'telegram_bot'
require 'pp'
require 'logger'
require 'net/http'
require 'json'

logger = Logger.new("/NFS/logs/vlabs/simpleWavesBot/simpleWavesBot.log", Logger::DEBUG)

bot = TelegramBot.new(token: 'yourApiKey', logger: logger)
logger.debug "starting telegram bot"

bot.get_updates(fail_silently: true) do |message|
  logger.info "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)
  id='nil' 
  message.reply do |reply|
    case command
    when /start/i
        reply.text = "Soy el bot de simpleWaves para informarte de las olas de tu playa favorita"
    when /hola/i
        reply.text = "Hola, #{message.from.first_name}. Preguntame por una playa :)"
    when /somo/i 
      id= '174'
    when /liencres/i
      id='4395'
    when /salinas/i
      id='177'
    when /razo/i
      id='4369'
    end

    if id=='nil' 
        reply.text = "#{message.from.first_name}, lo siento, pero no hemos encontrado niguna información para la playa #{command.inspect}, es realmente una playa ;)"
    else
      url = 'http://magicseaweed.com/api/yourApiKey/forecast/?spot_id=' + id 
      uri = URI(url)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      reply.text = "Olas entre #{data[0]['swell']['absMinBreakingHeight']} - #{data[0]['swell']['absMaxBreakingHeight']} metros con periodo de #{data[0]['swell']['components']['primary']['period']} segundos, donde la dirección del Swell es #{data[0]['swell']['compassDirection']} #{data[0]['charts']['swell']}"
      reply.send_with(bot)
      reply.text = "Y, un viento de #{data[0]['wind']['speed']} kph con dirección #{data[0]['wind']['compassDirection']} #{data[0]['charts']['wind']}"
    end

    logger.info "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)

  end
end
