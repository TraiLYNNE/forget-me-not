module Slugifiable
  module InstanceMethods
    def slug
      "#{self.last_name}-#{self.first_name}"
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
end
