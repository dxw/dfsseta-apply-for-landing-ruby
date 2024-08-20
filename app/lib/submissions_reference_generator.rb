class SubmissionsReferenceGenerator
  def self.generate
    "AFL-#{random_numbers}-#{random_letters}"
  end

  private_class_method

  def self.random_numbers
    3.times.map { Kernel.rand(1..9).to_s }.join
  end

  def self.random_letters
    3.times.map { ("A".."Z").to_a.sample }.join
  end
end
