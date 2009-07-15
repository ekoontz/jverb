class Inflection < ActiveRecord::Base

  def export(xml)
    xml.inflection(:id=>attributes["id"],
                   :name=>attributes["name"])
  end

end
