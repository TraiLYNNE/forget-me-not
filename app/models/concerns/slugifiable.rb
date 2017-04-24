module Slugifiable
  module InstanceMethods
    def slug
      "#{self.last_name.downcase}-#{self.first_name.downcase}"
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
end
