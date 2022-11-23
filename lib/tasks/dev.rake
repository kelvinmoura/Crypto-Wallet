namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      msg = ["Apagando DB....","Criado DB....","Migrando DB....","Adicionanado tipos de mineração....","Adicionando Moedas...."]
      task = [%x(rails db:drop),%x(rails db:create),%x(rails db:migrate),%x(rails dev:add_mining_types),%x(rails dev:add_coins)]
      5.times {|exc| show_spinner(msg[exc]) {task[exc]}}
    else
      puts "Você não está em modo de desenvolvimento"
    end
  end

    #Adicionar moedas pré-cadastradas no sistema.
    desc "Adicionando moedas"
    task add_coins: :environment do
        coins = [
          {   description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png",
              mining_type: MiningType.find_by(acronym: 'PoW')
          },
            
          {   description: "Ethereum",
              acronym: "ETH",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png",
              mining_type: MiningType.find_by(acronym: 'PoS')
              
          },
        
          {   description: "Dash",
              acronym: "DASH",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
              mining_type: MiningType.find_by(acronym: 'PoC')
              }
        ]
          
        Coin.create!([
        {    description: "Bitcoin",
            acronym: "BTC",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png",
            mining_type: MiningType.find_by(acronym: 'PoW')},
        
        {   description: "Ethereum",
            acronym: "ETH",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png",
            mining_type: MiningType.find_by(acronym: 'PoS')},
        
        {   description: "Dash",
            acronym: "DASH",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
            mining_type: MiningType.find_by(acronym: 'PoC')}
        ]
        )
        
        coins.each do |coin|
          Coin.find_or_create_by!(coin)  
        end
    end

    desc "Cadastrando tipos de mineração"
    task add_mining_types: :environment do
        mining_types = [
          {description: "Proof of Work", acronym: "PoW"},
          {description: "Proof of Stake", acronym: "PoS"},
          {description: "Proof of Capacity", acronym: "PoC"}
        ]
        MiningType.create!(
          [
          {description: "Proof of Work", acronym: "PoW"},
          {description: "Proof of Stake", acronym: "PoS"},
          {description: "Proof of Capacity", acronym: "PoC"}
          ]
        )
        mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
        end
    end


  def show_spinner(msg_start, msg_end = "Concluido com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin 
    yield 
    spinner.success("(#{msg_end})")
  end

end

