class Spreadsheet
  require 'roo'

  def get_url
    "https://docs.google.com/spreadsheets/d/1QQPyukGjuaMyX5lsvQsGm8zUqEc1egRypeYvVRIEF4c/export?format=xlsx"
  end

  def get_data
    """
    return: [List] of [{header: response}]
    """
    xls = Roo::Spreadsheet.open(get_url, extension: :xlsx)
    # Only one sheet..
    sheet = xls.sheet(0)
    rows = sheet.parse(headers: true)
    rows[1..-1]
  end

  def create_characters
    characters = ["Jon Snow", "Sansa Stark", "Arya Stark", "Bran Stark",
      "Cersei Lannister", "Jaime Lannister", "Tyrion Lannister",
      "Daenerys Targaryen", "Yara Greyjoy", "Theon Greyjoy", "Melisandre",
      "Jorah Mormont", "The Hound", "The Mountain", "Samwell Tarly",
      "Gilly", "Sam (Child)", "Lord Varys", "Brienne of Tarth", "Davos Seaworth",
      "Bronn", "Podrick Payne", "Tormund Giantsbane",  "Grey Worm",
      "Gendry",  "Beric Dondarrion",  "Euron Greyjoy", "Missandei"]

    for name in characters
      char = Character.new(name: name, filename: name + ".jpeg")
      char.save
    end
  end

  def populate_db
    ignore = ["Timestamp", "Email Address", "Name"]

    create_characters
    get_data.each do |response|
      user = User.new(name: response["Name"], email: response["Email Address"])
      user.save
      response.each do |k, v|
        # Don't assume its a question/answer if the key is in ignore
        next if ignore.include? k
        character = Character.find_by(name: k)
        # Otherwise assume ts a Question and Answer
        question = Question.find_or_create_by(text: k, points: 1, character: character)
        guess = user.guesses.new(question_id: question.id, text: v)
        guess.save
      end
    end

    Question.all.each do |q|
      # questions about a character default to Alive
      q.set_answer("Alive") unless q.character.nil?
    end
  end
end
