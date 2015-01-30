class FormBuilder
  extend ActiveModel::Naming
  extend ActiveModel::Conversion
  extend ActiveModel::Validations

  def persisted?
    false
  end

  def to_key
    []
  end

end