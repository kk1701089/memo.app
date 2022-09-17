loop do
  require "csv"

  puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

  memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

  # １が入力された時
  if memo_type == 1

    #  ファイル名を入力させ、変数に代入
    puts "拡張子を除いたファイル名を入力してください"
    file_name = gets.chomp!
    puts "入力したファイル名：#{file_name}"

    # すでに存在しているファイルかチェック
    file_get = File.exist?("#{file_name}.csv")
    
    # ファイルが存在していなかった場合
    if file_get == false
        # 書き出しモードでファイルを作成する
      CSV.open("#{file_name}.csv",'w') do |csv|

        puts "メモに文字を入力してください"
        puts "enterを押すと改行されます"
        puts "メモを書き終えたら ctrl+D を押して保存してください"
        puts ""

        # 入力した値をcsvファイルに書き込む
        while line = gets
          input1 = line.chomp
          csv << [input1]
        end
        puts "メモを保存しました"
      end

    # ファイルが存在していた場合
    elsif file_get == true
      puts "#{file_name}.csvはすでに存在しているため、1 で違う名前でファイルを作成し直すか 2 でファイルを編集してください"
    end

   # 入力された値が２だった場合
  elsif memo_type == 2

    #  ファイル名を入力させ、変数に代入
    puts "拡張子を除いたファイル名を入力してください"
    file_name = gets.chomp!
    puts "開いたファイル名：#{file_name}.csv"

    # すでに存在しているファイルかチェック
    file_get = File.exist?("#{file_name}.csv")

    # 存在しているファイルだった場合
    if file_get == true
      # 追記モードでcsvファイルを開く
      CSV.open("#{file_name}.csv", 'a') do |csv|
        puts "追記したい内容を入力してください"
        puts "enterを押すと改行されます"
        puts "メモを書き終えたら ctrl+D を押して保存してください"
        puts ""

        # １行ずつ読み込みそれを表示
      get_string = []
      File.foreach("#{file_name}.csv") do |line|
        get_string << line.chomp
      end
      get_string.each{|num|
        p num
      }
        # 書き込み
        while line = gets
          input2 = line.chomp
          csv << [input2]
        end
        puts "メモを保存しました"
      end

    # 存在していないファイル名が入力された場合
    elsif file_get == false
      puts "#{file_name}.csvは存在しないため編集することができません"
    end
  end
end