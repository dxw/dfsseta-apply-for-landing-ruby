module CheckYourAnswers
  Stage = Struct.new(
    :name,
    :title,
    :link_path,
    :link_text,
    :questions,
    keyword_init: true
  )
end
