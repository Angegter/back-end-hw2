class Tamagotchi
  def initialize(name)
    @name = name
    @hunger = 30  # 0 - ситий, 100 - голодний (зменшив старт)
    @energy = 70  # 0 - втомлений, 100 - бадьорий
    @mood = 70    # 0 - сумний, 100 - веселий
    @alive = true
    puts "\n #{@name} з'явився на світ!"
  end

  def feed
    puts "\n Ви годуєте #{@name}. Смакота!"
    @hunger = [@hunger - 35, 0].max # Більше ситості
    @energy = [@energy + 5, 100].min
    passage_of_time(1)
  end

  def play
    puts "\n Ви граєте з #{@name}. Йому весело!"
    @mood = [@mood + 30, 100].min
    @energy = [@energy - 15, 0].max
    @hunger = [@hunger + 10, 100].min # Менше голоду від гри
    passage_of_time(1)
  end

  def sleep
    puts "\n #{@name} солодко спить і відновлює сили..."
    @energy = [@energy + 50, 100].min
    @hunger = [@hunger + 10, 100].min # Фіксований голод за сон
    @mood = [@mood + 5, 100].min
    # Під час сну час іде, але не так агресивно
    check_health
  end

  def status
    puts "\n--- Стан: #{@name} ---"
    puts "Ситість:  #{100 - @hunger}/100" # Інвертував для зрозумілості
    puts "Енергія:  #{@energy}/100"
    puts "Настрій:  #{@mood}/100"
    puts "-----------------------"
  end

  private

  def passage_of_time(factor)
    @hunger += 5 * factor
    @mood -= 3 * factor
    check_health
  end

  def check_health
    if @hunger >= 100
      puts "\n О ні! #{@name} помер від голоду. Потрібно було частіше годувати..."
      @alive = false
    elsif @energy <= 0
      puts "\n #{@name} знепритомнів від втоми! Йому потрібен терміновий сон."
      @mood -= 20
      @energy = 10
    end
  end

  public

  def start_game
    while @alive
      status
      puts "Оберіть дію:"
      puts "1 - Годувати"
      puts "2 - Грати"
      puts "3 - Покласти спати"
      puts "0 - Вийти"
      
      print "> "
      choice = gets.chomp.to_i
      
      case choice
      when 1 then feed
      when 2 then play
      when 3 then sleep
      when 0 
        puts "Бувай! #{@name} сумуватиме."
        break
      else 
        puts "Невідома команда, спробуй ще раз."
      end
    end
    puts "\nКінець гри."
  end
end

print "Як назвемо твого вихованця? "
name = gets.chomp
pet = Tamagotchi.new(name)
pet.start_game