require 'csv'

puts "1(新規でメモを作成) 2(既存のメモ編集をする)"
while true
  option = gets.chomp
  if option == "1"
    mode = "new"  # 新規作成モード
    break
  elsif option == "2"
    mode = "edit"  # 編集モード
    break
  else
    puts "不正な値です。再入力してください。1(新規でメモを作成) 2(既存のメモ編集をする)"
  end
end

# ファイル名を入力させる（拡張子を除く）
puts "拡張子を除いたファイル名を入力してください"
file_name = gets.chomp
file_path = "#{file_name}.csv"  # 拡張子を追加

# オプション2（既存のメモ編集）の場合は、ファイルの存在を確認
if mode == "edit"
  if File.exist?(file_path)
    puts "現在のメモの内容:"
    CSV.foreach(file_path) do |row|
      puts row.join  # 既存のメモ内容を表示
    end
  else
    puts "指定したファイルが見つかりません。新規メモを作成します。"
    mode = "new"
  end
end

puts "メモしたい内容を入力してください"
puts "完了したらCtrl + Dを押します"

input_lines = []

# EOF (Ctrl + D) が入力されるまでループ
while line = gets
  input_lines << line.chomp  # 末尾の改行を削除して配列に追加
end

# CSVファイルに保存（上書き）
CSV.open(file_path, "w") do |csv|
  input_lines.each do |line|
    csv << [line]  # 1行ずつCSVに保存
  end
end

puts "You entered:"
puts input_lines
puts "メモが '#{file_path}' に保存されました。"
