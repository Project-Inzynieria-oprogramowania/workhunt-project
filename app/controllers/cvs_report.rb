class CvsReport < Prawn::Document
    FONTS = {
        "Inter" => {
            :normal  => Rails.root.join("app/assets/fonts/Inter-Regular.ttf"),
            :bold  => Rails.root.join("app/assets/fonts/Inter-Bold.ttf")}
    }

    def print_section_title(data)
        move_down 10
        text data, size: 16, style: :bold, color: 'A343D3'
        move_down 5
    end

    def table_for_info(data)
        table(
            data,
            column_widths: {0 => 150},
            cell_style: { padding: [5, 30, 0, 0], borders: [] } 
        ) do | t |
            t.column(0).style(font_style: :bold)
            t.column(0).text_color = '663C7B'
        end
    end

    def person_info_data
        table_arr = [["Sex", @user.person.sex]]
        if (@user.person.DOB.present?)
            table_arr << ["Date of Birth", @user.person.DOB]
        end
        table_arr
    end

    def person_contacts_data
        table_arr = []
        if @user.telephones.present?
            table_arr << ["Telephones"] + [@user.telephones.pluck(:number).join("\n")]
        end
        if @user.emails.present?
            table_arr << ["Emails"] + [@user.emails.pluck(:address).join("\n")]
            # table_arr << ["Emails", make_table(@user.emails.pluck(:address).map { |address| [address] })]
        end
        table_arr
    end

    def table_with_data(data)
        table(
            data,
            column_widths: {0 => 110},
            cell_style: { 
                overflow: :expand, 
                text_wrap: :word_wrap, 
                padding: [5, 30, 10, 0], 
                borders: [] }
        ) do | t | 
            t.column(0).text_color = 'A6884E'
        end
    end

    def education_data
        table_arr = []
        @cv.educations.each do | elem | 
            elem_arr = []
            
            date = "#{elem.start_date.strftime("%d.%m.%Y")} - "
            elem.end_date.present? ? date += "#{elem.end_date.strftime("%d.%m.%Y")}" : date += "continue" 
            elem_arr << date

            elem_arr << make_table(
                [
                    [elem.institution],
                    ["#{elem.direction}, #{elem.specialization}"],
                    [elem.education_level]
                ],
                cell_style: { padding: [0, 0, 0, 0], borders: [] }
            ) do | t |
                t.row(2).text_color = '663C7B'
                t.row(0).size = 11
                t.row(0).font_style = :bold
                t.row(2).font_style = :bold
            end
            
            table_arr << elem_arr
        end
        table_arr
    end

    def experiences_data
        table_arr = []
        @cv.experiences.each do | elem | 
            elem_arr = []
            
            date = "#{elem.start_date.strftime("%d.%m.%Y")} - "
            elem.end_date.present? ? date += "#{elem.end_date.strftime("%d.%m.%Y")}" : date += "continue" 
            elem_arr << date

            elem_arr << make_table(
                [
                    [elem.position],
                    [elem.company],
                    ["#{elem.country}, #{elem.city}"],
                    #[elem.outline],
                    #[elem.responsibilities],
                    #[elem.achievements]
                ],
                cell_style: { 
                    # overflow: :expand, 
                    text_wrap: :word_wrap, 
                    padding: [0, 0, 0, 0], 
                    borders: [] 
                }
            ) do | t |
                t.row(1).text_color = '663C7B'
                t.row(0).size = 14
                t.row(0).font_style = :bold
                t.row(1).font_style = :bold
            end
            
            table_arr << elem_arr
        end
        table_arr
    end

    def languages_data
        formatted_data = []
          @cv.languages.map do |elem|
        
          arr = 
          [
            { text: "#{elem.name} - ", styles: [:bold], color: '262229', size: 11 },
            { text: elem.level, styles: [:bold], color: 'A6884E', size: 12 },
          ]
          if elem.certificates.present?
            arr << { text: " - #{elem.certificates}", styles: [:bold], color: '262229', size: 11 }
          end
          formatted_data << arr
        end
        formatted_data
      end
    
    def languages_with_data(data)
        data.each do |elem|
            formatted_text elem
            move_down 2
        end
    end

    def consent_statement_line(data)
        move_down bounds.absolute_bottom
        text data, size: 9, style: :bold, color: 'D7BE8C'
        move_down 5
    end

    def formatted_text_with_data(data)
        data.each do |elem|
            formatted_text elem
            move_down 20
        end
        move_up 20
    end

    def experiences_as_texts
        formatted_data = @cv.experiences.map do |elem|
            date = "#{elem.start_date.strftime("%d.%m.%Y")} - "
            elem.end_date.present? ? date += "#{elem.end_date.strftime("%d.%m.%Y")}" : date += "continue"
          
            experience_data = [
              { text: date, styles: [:normal], color: 'A6884E', size: 12 },
            ]
            if elem.company.present?
                experience_data << { text: elem.company, styles: [:bold], color: '262229', size: 12 }
            else
                experience_data << { text: "Freelance/Contract Work", styles: [:bold], color: '262229', size: 12 }
            end
            experience_data << { text: elem.position, styles: [:normal], color: 'A343D3', size: 12 }
            if elem.outline.present?
                experience_data << { text: "Outline:", styles: [:bold], color: 'A6884E', size: 11 }
                experience_data << { text: elem.outline, styles: [:normal], color: '262229', size: 10 }
            end
            if elem.responsibilities.present?
                experience_data << { text: "Responsibilities:", styles: [:bold], color: 'A6884E', size: 11 }
                experience_data << { text: elem.responsibilities, styles: [:normal], color: '262229', size: 10 }
            end
            if elem.achievements.present?
                experience_data << { text: "Achievements:", styles: [:bold], color: 'A6884E', size: 11 }
                experience_data << { text: elem.achievements, styles: [:normal], color: '262229', size: 10 }
            end
            if elem.country.present?
                if elem.city.present?
                    experience_data << { text: "#{elem.country}, #{elem.city}", styles: [:bold], color: 'A343D3', size: 11 }
                else
                    experience_data << { text: "#{elem.country}", styles: [:bold], color: 'A343D3', size: 11 }
                end
            elsif elem.city.present?
                    experience_data << { text: "#{elem.city}", styles: [:bold], color: 'A343D3', size: 11 }
            end
            experience_data.map { |text| text.merge!(text: "#{text[:text]}\n") }
        end
        formatted_data
    end
    

    def to_pdf(_cv_)
        font_size 10
        font_families.update(FONTS)
        self.stroke_color = 'A343D3'
        self.line_width = 2
        @cv = _cv_
        @user = User.find_by(id: Person.find_by(id: @cv.person_id).user_id)
        
        font "Inter"

        #
        #bounding_box([0, bounds.height], width: bounds.width*0.3, height: bounds.height) do
        #    fill_color 'A343D3'
        #    fill_rectangle [bounds.left, bounds.top], bounds.width, bounds.height
        #    fill_color '000000'
        #end
        #bounding_box([bounds.width*0.3, bounds.height], width: bounds.width*0.7, height: bounds.height) do
        #    text "This text will flow in a very narrow box starting" +
        #     "from xxxxx. The pointer will then be moved to [100, 200]" +
        #     "and return to the margin_box"
        #end
        #

        text "#{@user.person.name} #{@user.person.surname}", size: 22, style: :bold
        
        table_for_info(person_info_data)
        if (@user.telephones.present? || @user.emails.present?)
            move_down 10
            table_for_info(person_contacts_data)
        end

        move_down 20
        stroke_horizontal_rule

        if (@cv.about.present? || @cv.skills.present?)
            print_section_title("About me")
            text @cv.about
            
            if (@cv.skills.present?)
                move_down 10
                stroke_horizontal_rule
                print_section_title("Skills")
                @cv.skills.split("\n").each do | skill |
                    text "- #{skill}"
                end
            end
        end

        if (@cv.educations.present?)
            move_down 10
            stroke_horizontal_rule
            print_section_title("Educations")
            table_with_data(education_data)
        end

        if (@cv.experiences.present?)
            move_down 10
            stroke_horizontal_rule
            print_section_title("Experiences")
            formatted_text_with_data(experiences_as_texts)
        end

        if (@cv.interests.present?)
            move_down 10
            stroke_horizontal_rule
            print_section_title("Interests")
            text @cv.interests
        end
        
        if (@cv.languages.present?)
            move_down 10
            stroke_horizontal_rule
            print_section_title("Languages")
            languages_with_data(languages_data)
        end

        consent_statement_line("*I hereby consent to the processing of my personal information for the purposes of this application.")

        render
    end
end