require 'nokogiri'

module Parser
  class Publications
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'jcrpubs.xml').to_s)
      @inbooks = @document.root.xpath('inbook')
      @inproceedings = @document.root.xpath('inproceedings')
      @articles = @document.root.xpath('article')
      @miscs = @document.root.xpath('misc')
      @proceedings = @document.root.xpath('proceedings')
      @books = @document.root.xpath('book')
      @phdtheses = @document.root.xpath('phdthesis')
      @mastertheses = @document.root.xpath('masterthesis')
      @publications = []
      @authors = []
      @editors = []
    end

    def xml
      @document.to_xml
    end

    def publications
      parse_publications if @publications.empty?
      @publications
    end

    def authors
      parse_publications if @publications.empty?
      @authors
    end

    def editors
      parse_publications if @publications.empty?
      @editors
    end

    def t
      @document
    end

    @private

    def parse_publications
      parse_inbooks
      parse_inproceedings
      parse_articles
      parse_miscs
      parse_proceedings
      parse_books
      parse_phdtheses
      parse_mastertheses
    end

    def parse_inbooks
      @inbooks.each do |node|
        inbook = get_inbook node
        @inbooks << inbook
        parse_authors(node, inbook)
        parse_editors(node, inbook)
      end
    end

    def parse_inproceedings
      @inproceedings.each do |node|
        inproceeding = get_inproceeding node
        @inproceedings << inproceeding
        parse_authors(node, inproceeding)
        parse_editors(node, inproceeding)
      end
    end

    def parse_articles
      @articles.each do |node|
        article = get_article node
        @articles << article
        parse_authors(node, article)
        parse_editors(node, article)
      end
    end

    def parse_miscs
      @miscs.each do |node|
        misc = get_misc node
        @miscs << misc
        parse_authors(node, misc)
        parse_editors(node, misc)
      end
    end

    def parse_proceedings
      @proceedings.each do |node|
        proceeding = get_proceeding node
        @proceedings << proceeding
        parse_authors(node, proceeding)
        parse_editors(node, proceeding)
      end
    end

    def parse_books
      @books.each do |node|
        book = get_book node
        @books << book
        parse_authors(node, book)
        parse_editors(node, book)
      end
    end

    def parse_phdtheses
      @phdtheses.each do |node|
        phdthesis = get_phdthesis node
        @phdtheses << phdthesis
        parse_authors(node, phdthesis)
        parse_editors(node, phdthesis)
      end
    end

    def parse_mastertheses
      @mastertheses.each do |node|
        masterthesis = get_masterthesis node
        @mastertheses << masterthesis
        parse_authors(node, masterthesis)
        parse_editors(node, masterthesis)
      end
    end

    def parse_authors(node, publication)
      parse_authors_references(node, publication)

      authors = node.xpath('author')
      authors.each do |node|
        author = get_element(node, publication)
        @authors << author
      end
    end

    def parse_editors(node, publication)
      parse_editors_references(node, publication)

      editors = node.xpath('editor')
      editors.each do |node|
        editor = get_element(node, publication)
        @editors << editor
      end
    end

    def parse_authors_references
      authors = node.xpath('author-ref')
      authors.each do |node|
        author = get_author_ref(node, publication)
        @authors << author
      end
    end

    def parse_editors_references
      editors = node.xpath('editor-ref')
      editors.each do |node|
        editor = get_editor_ref(node, publication)
        @editors << editor
      end
    end

    def get_element(node, publication)
      element = {}
      element["name"] = node.text
      element["publication_id"] = get_publication_bd(publication).id
      element["teacher_id"] = 1
      element
    end

    def get_author_ref(node, publication)
      id = node.attributes['authorid'].text
      author_node = @document.at_xpath("//author[@id='#{id}']")
      get_element(author_node, publication)
    end

    def get_editor_ref(node, publication)
      id = node.attributes['editorid'].text
      editor_node = @document.at_xpath("//editor[@id='#{id}']")
      get_element(editor_node, publication)
    end

    def get_publication_bd(publication)
      Publication.where(publication).first_or_create!
    end

    def get_publication(node)
      publication = {}

      title = node.at_xpath('title')
      publication["title"] = title.text if title

      chapter = node.at_xpath('chapter')
      publication['chapter'] = chapter.text if chapter

      pages = node.at_xpath('pages')
      publication['pages'] = pages.text if pages

      publisher = node.at_xpath('publisher')
      publication['publisher'] = publisher.text if publisher

      doi = node.at_xpath('doi')
      publication['doi'] = doi.text if doi

      volume = node.at_xpath('volume')
      publication['volume'] = volume.text if volume

      isbn = node.at_xpath('isbn')
      publication['isbn'] = isbn.text if isbn

      issn = node.at_xpath('issn')
      publication['issn'] = issn.text if issn

      booktitle = node.at_xpath('booktitle')
      publication['booktitle'] = booktitle.text if booktitle

      address = node.at_xpath('address')
      publication['address'] = address.text if address

      uri = node.at_xpath('uri')
      publication['uri'] = uri.text if uri

      journal = node.at_xpath('journal')
      publication['journal'] = journal.text if journal

      number = node.at_xpath('number')
      publication['number'] = number.text if number

      howpublished = node.at_xpath('howpublished')
      publication['howpublished'] = howpublished.text if howpublished

      school = node.at_xpath('school')
      publication['school'] = school.text if school

      year = node.at_xpath('year')
      year ? year.text : "0000"
      month = node.at_xpath('month').text
      month ? month.text : "01"
      day = node.at_xpath('day')
      day ? day.text : "01"
      inbook["date"] = Date.parse("#{day}/#{month}/#{year}")

      publication['teacher_id'] = 1
      publication
    end

    def get_inbook(node)
      inbook = get_publication(node)
      inbook["publication_type_id"] = 1
      inbook
    end

    def get_inproceeding(node)
      inproceeding = get_publication(node)
      inproceeding["publication_type_id"] = 2
      inproceeding
    end

    def get_article(node)
      article = get_publication(node)
      article["publication_type_id"] = 3
      article
    end

    def get_misc(node)
      misc = get_publication(node)
      misc["publication_type_id"] = 4
      misc    
    end

    def get_proceeding(node)
      proceeding = get_publication(node)
      proceeding["publication_type_id"] = 5
      proceeding 
    end

    def get_book(node)
      book = get_publication(node)
      book["publication_type_id"] = 6
      book 
    end

    def get_phdthesis(node)
      phdthesis = get_publication(node)
      phdthesis["publication_type_id"] = 7
      phdthesis 
    end

    def get_masterthesis(node)
      masterthesis = get_publication(node)
      masterthesis["publication_type_id"] = 8
      masterthesis  
    end

  end
end
