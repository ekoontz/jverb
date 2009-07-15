class LexicalException < ActiveRecord::Base

  def export(xml)
    xml.exception(:inflection_id=>attributes["inflection_id"],
                  :form=>attributes["form"])
  end
end
