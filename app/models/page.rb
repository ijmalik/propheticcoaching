class Page < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :ebook
  before_destroy :remove_es_index
  before_destroy {|page| page.ebook.categories.clear}
  
  after_save do
    tire.index.refresh
  end

  after_destroy do
    tire.index.refresh
  end


  mapping do
    indexes :id, type: 'integer'
    indexes :ebook_id, type: 'integer'
    indexes :page_number
    indexes :tags, boost: 10, analyzer: 'snowball'
    indexes :category_name, :as => 'category_name', type: 'string', analyzer: 'snowball'
    # indexes :categories do
    #   indexes :name, type: 'string', analyzer: 'snowball'
    # end
  end

  def to_indexed_json
    to_json(methods: [:category_name])
  end
  # def to_indexed_json
  #   to_json( include: { categories: { only: [:name] } } )
  # end  

  def category_name
    # category_list = self.ebook.categories.map(&:name)
    # category_list.empty? ? ["Ebook"] : category_list
    self.ebook.categories.map(&:name)
  end

  def self.search(params)
    if params[:category].present?
      # Page.tire.update_index
      params_categories = params[:category]
      categories_ary = params_categories.to_s.split(',')
      tire.search(load: true, page: params[:page], per_page: 10) do
        query { 
        string params[:query], default_operator: "AND" if params[:query].present? 
          categories_ary.each do |category|  
            match 'category_name',  category
          end
        }
        # sort { by :ebook_id, 'asc' }
        # sort do
        #   by :ebook_id, 'desc'
        #   by :page_number, 'asc'
        # end        
        # size 3000
      end
    else
      tire.search(load: true, page: params[:page], per_page: 10) do
          tags_query = lambda do |boolean|
            boolean.should { string 'tags:'+params[:query], default_operator: "AND"  }
          end
        if params[:query].present?        
          query do
            boolean &tags_query
          end
        end      
          # sort do
          #   by :ebook_id, 'desc'
          #   by :page_number, 'asc'
          # end  
        # query { string ('tags: '+params[:query]), default_operator: "AND" } if params[:query].present?
        # sort do
        #   # by :ebook_id, 'desc'
        #   by :page_number, 'asc'
        # end        
        # sort { by :ebook_id, 'asc' }
        # size 3000
      end
    end
    # tire.search(load: true) do
    #   query { 
    #     string "602ProPrint", default_operator: "AND" 
    #     match 'ebook_id',  '549'
    #   }
    #   sort { by :updated_at, "desc" }
    # end

    # tire.search do
    #   query { string params[:query], default_operator: "AND" } if params[:query].present?
    #   sort { by :page_number, 'asc' }
    # end
  end

  def remove_es_index
    self.index.remove self
  end
  after_save do
    self.tire.update_index
  end

  # def to_indexed_json
  #   to_json(methods: [:ebook_name])
  # end

  # def to_indexed_json
  #   {
  #   :id            => id,
  #   :ebook_id      => ebook_id,
  #   :page_number   => page_number,
  #   :tags          => tags,
  #   :categories    => {:name => self.ebook.categories.map(&:name)}
  #   }.to_json
  # end

  def ebook_name
    ebook.name if ebook
  end

  def self.duplicate_page
    # find all models and group them on keys which should be common
    grouped = all.group_by{|page| [page.ebook_id,page.page_number] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end

end
