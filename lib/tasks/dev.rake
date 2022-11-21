namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      msg = ["Apagando DB....","Criado DB....","Migrando DB....","Inserindo seeds...."]
      task = [%x(rails db:drop),%x(rails db:create),%x(rails db:migrate),%x(rails db:seed)]
      4.times {|exc| show_spinner(msg[exc]) {task[exc]}}
    else
      puts "Você não está em modo de desenvolvimento"
    end
  end

  def show_spinner(msg_start, msg_end = "Concluido com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin 
    yield 
    spinner.success("(#{msg_end})")
  end
  

end
