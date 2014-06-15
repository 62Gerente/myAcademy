(function() {
    $(document).ready(function() {
        var selected = $("#publication_publication_type_id option:selected").text();
        render_form(selected);
        $("#publication_publication_type_id").change(function() {
            selected = $("#publication_publication_type_id option:selected").text();
            render_form(selected);
        });

        function render_title_section(value) {
            $("#custom_fields").append("<label class=\"col-sm-3 control-label\">" + value + "</label>");
        }

        function render_date_field(title, value, id) {
            $(id).append("<div class=\"m-b-10\"><div class=\"row\"><div class=\"col-sm-8\"><div>" + title + "</div><input class=\"input form-control datepicker\" data-behaviour=\"datepicker\" data-date-format=\"dd-mm-yyyy\" data-required=\"true\" id=\"publication_" + value + "\" name=\"publication[" + value + "]\" style=\"width: 100%\" type=\"text\"></div></div></div>");
        }

        function render_text_area(title, value, id) {
            $(id).append("<div class=\"m-b-10\"><div>" + title + "</div><div class=\"row\"><div class=\"col-sm-8\"><textarea class=\"input input-large input-light brad\" data-required=\"true\" id=\"publication_" + value + "\" name=\"publication[" + value + "]\" style=\"width: 100%\"></textarea></div></div></div>");
        }

        function render_text_field(title, value, id) {
            $(id).append("<div class=\"m-b-10\"><div>" + title + "</div><div class=\"row\"><div class=\"col-sm-8\"><input class=\"input input-large input-light brad\" data-required=\"true\" id=\"publication_" + value + "\" name=\"publication[" + value + "]\" style=\"width: 100%\" type=\"text\"></div></div></div>");
        }

        function render_form_area(id) {
            $("#custom_fields").append("<div class=\"col-sm-9 m-t-10\" id=\"" + id + "\"></div>");
        }

        function render_form(value) {
            $("#custom_fields").empty();
            if (value == "article") {
                render_title_section("Article");
                render_form_area("form_article");
                render_text_field("Journal", "journal", "#form_article");
                render_text_field("Volume", "volume", "#form_article");
                render_text_field("Publisher", "publisher", "#form_article");
                render_text_field("Number", "number", "#form_article");
                render_date_field("Date", "date", "#form_article");
            } else if (value == "inbook") {
                render_title_section("Inbook");
                render_form_area("form_inbook");
                render_text_field("Chapter", "chapter", "#form_inbook");
                render_text_field("Pages", "pages", "#form_inbook");
                render_text_field("Publisher", "publisher", "#form_inbook");
                render_date_field("Date", "date", "#form_inbook");
            } else if (value == "inproceeding") {
                render_title_section("Inproceeding");
                render_form_area("form_inproceeding");
                render_text_field("Book Title", "booktitle", "#form_inproceeding");
                render_text_field("Address", "address", "#form_inproceeding");
                render_date_field("Date", "date", "#form_inproceeding");
            } else if (value == "proceeding") {
                render_title_section("Proceeding");
                render_form_area("form_proceeding");
                render_text_field("Address", "address", "#form_proceeding");
                render_date_field("Date", "date", "#form_proceeding");
                render_text_field("International Standard Book Number", "issn", "#form_proceeding");
            } else if (value == "misc") {
                render_title_section("Miscellaneous");
                render_form_area("form_misc");
                render_text_area("Description", "howpublished", "#form_misc");
                render_date_field("Date", "date", "#form_misc");
            } else if (value == "book") {
                render_title_section("Book");
                render_form_area("form_book");
                render_text_field("Publisher", "publisher", "#form_book");
                render_text_field("Address", "address", "#form_book");
                render_date_field("Date", "date", "#form_book");
            } else if (value == "masterthesis") {
                render_title_section("Master Thesis");
                render_form_area("form_masterthesis");
                render_text_field("School", "school", "#form_masterthesis");
                render_date_field("Date", "date", "#form_masterthesis");
            } else if (value == "phdthesis") {
                render_title_section("Phd Thesis");
                render_form_area("form_phdthesis");
                render_text_field("School", "school", "#form_phdthesis");
                render_text_field("Address", "address", "#form_phdthesis");
                render_date_field("Date", "date", "#form_phdthesis");
            };
            $('.datepicker').datepicker();
        }
    })
}).call(this);
