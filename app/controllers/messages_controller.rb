
require 'openai'

class MessagesController < ApplicationController
  before_action :initialize_openai, only: [:create]

  def index
    @messages = Message.all
  end

  def create
    user_message = params[:user_message]

    # Save user message
    Message.create(role: 'user', content: user_message)

    # Prepare OpenAI API call
    messages = Message.all.map { |msg| { role: msg.role, content: msg.content } }

    response = @client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: messages, # Required.
        temperature: 0.7,
    })
    # assistant_message = response.choices[0].text.strip
    assistant_message = response.dig("choices", 0, "message", "content")

    # Save assistant message
    Message.create(role: 'assistant', content: assistant_message)

    # Return as JSON (or render HTML, or whatever you like)
    render json: { user_message: user_message, assistant_message: assistant_message }
  end

  private

  def initialize_openai
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end
end
