module CheckYourAnswers
  Question = Struct.new(
    :ref,
    :title,
    :answer,
    keyword_init: true
  )
end
