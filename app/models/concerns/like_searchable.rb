module LikeSearchable
  extend ActiveSupport::Concern

  module ClassMethods
    def like_search(fields={})
      query = ""
      values = []
      fields.each do |field, value|
        unless value.blank?
          unless query.blank?
            query += " OR "
          end

          # If it has a dot,
          # it's already expliciting a table
          if field["."]
            query += "CAST(#{field.to_s} as varchar) ILIKE ?"
          else
            query += "CAST(#{self.table_name}.#{field.to_s} as varchar) ILIKE ?"
          end

          values << "%#{value}%"
        end
      end

      relation = self.where(query, *values)
      relation
    end
  end
end
