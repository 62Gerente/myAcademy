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
        parse_authors(node, inbook)
        parse_editors(node, inbook)
      end
    end

    def parse_articles
      @articles.each do |node|
        article = get_article node
        @articles << article
        parse_authors(node, inbook)
      end
    end

    def parse_miscs
      @miscs.each do |node|
        misc = get_misc node
        @miscs << misc
        parse_authors(node, inbook)
      end
    end

    def parse_proceedings
      @proceedings.each do |node|
        proceeding = get_proceeding node
        @proceedings << proceeding
        parse_authors(node, inbook)
        parse_editors(node, inbook)
      end
    end

    def parse_books
      @books.each do |node|
        book = get_book node
        @books << book
        parse_authors(node, inbook)
        parse_editors(node, inbook)
      end
    end

    def parse_phdtheses
      @phdtheses.each do |node|
        phdthese = get_phdthese node
        @phdtheses << phdthese
        parse_authors(node, inbook)
      end
    end

    def parse_mastertheses
      @mastertheses.each do |node|
        masterthesis = get_masterthesis node
        @mastertheses << masterthesis
        parse_authors(node, inbook)
      end
    end

    def get_inbook(node)
      inbook = {}
      inbook["title"] = node.at_xpath('title').text
      inbook["chapter"] = node.at_xpath('chapter').text
      inbook["pages"] = node.at_xpath('pages').text
      inbook["publisher"] = node.at_xpath('publisher').text
      doi = node.at_xpath('doi')
      inbook["doi"] = doi.text if doi
      volume = node.at_xpath('volume')
      inbook["volume"] = volume.text if volume
      isbn = node.at_xpath('isbn')
      inbook["isbn"] = isbn.text if isbn
      year = node.at_xpath('doi').text
      month = node.at_xpath('month').text
      inbook["date"] = Date.parse("/#{month}/#{year}")
      inbook["publication_type_id"] = 1
      inbook["teacher_id"] = 1
      inbook
    end

    def get_inproceeding(node)
      inproceeding = {}
      inproceeding["title"] = node.at_xpath('title').text
      inproceeding["booktitle"] = node.at_xpath('booktitle').text
      address = node.at_xpath('address')
      inproceeding["address"] = address.text
      doi = node.at_xpath('doi')
      inproceeding["doi"] = doi.text if doi
      year = node.at_xpath('doi').text
      month = node.at_xpath('month').text
      isbn = node.at_xpath('isbn')
      inproceeding["isbn"] = isbn.text if isbn
      issn = node.at_xpath('issn')
      inproceeding["issn"] = issn.text if issn 
      uri = node.at_xpath('uri')
      inproceeding["uri"] = uri.text if uri 
      inproceeding["date"] = Date.parse("/#{month}/#{year}")
      inproceeding["publication_type_id"] = 2
      inproceeding["teacher_id"] = 1
      inproceeding
    end

    def get_article(node)
    
    end

    def get_misc(node)
    
    end

    def get_proceeding(node)
    
    end

    def get_book(node)
    
    end

    def get_phdthese(node)
    
    end

    def get_masterthesis(node)
    
    end

  end
end
