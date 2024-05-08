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
            
            date = "#{elem.start_date.strftime("%d-%m-%Y")} - "
            elem.end_date.present? ? date += "#{elem.end_date.strftime("%d-%m-%Y")}" : date += "continue" 
            elem_arr << date

            elem_arr << make_table(
                [
                    [elem.institution],
                    ["#{elem.direction}, #{elem.specialization}"],
                    [elem.education_level]
                ],
                cell_style: { padding: [0, 0, 0, 0], borders: [] }
            ) do | t |
                t.row(0).text_color = '663C7B'
                t.row(0).size = 14
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
            
            date = "#{elem.start_date.strftime("%d-%m-%Y")} - "
            elem.end_date.present? ? date += "#{elem.end_date.strftime("%d-%m-%Y")}" : date += "continue" 
            elem_arr << date

            elem_arr << make_table(
                [
                    [elem.position],
                    [elem.company],
                    ["#{elem.country}, #{elem.city}"],
                    # [elem.outline],
                    # [elem.responsibilities],
                    # [elem.achievements]
                ],
                cell_style: { 
                    # overflow: :expand, 
                    text_wrap: :word_wrap, 
                    padding: [0, 0, 0, 0], 
                    borders: [] 
                }
            ) do | t |
                t.row(0).text_color = '663C7B'
                t.row(0).size = 14
                t.row(0).font_style = :bold
            end
            
            table_arr << elem_arr
        end
        table_arr
    end

    def to_pdf(_cv_)
        font_families.update(FONTS)
        self.stroke_color = 'A343D3'
        self.line_width = 2
        @cv = _cv_
        @user = User.find_by(id: Person.find_by(id: @cv.person_id).user_id)
        
        font "Inter"
        text "#{@user.person.name} #{@user.person.surname}", size: 22, style: :bold, color: '663C7B'
        
        table_for_info(person_info_data)
        if (@user.telephones.present? || @user.emails.present?)
            move_down 10
            table_for_info(person_contacts_data)
        end

        move_down 20
        stroke_horizontal_rule

        if (@cv.about.present? || @cv.skills.present?)
            move_down 10
            text @cv.about
            
            if (@cv.skills.present?)
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
            table_with_data(experiences_data)
        end
        text @cv.experiences.inspect

        if (@cv.interests.present?)
            move_down 10
            stroke_horizontal_rule
            print_section_title("Interests")
            text @cv.interests
        end
        
        # move_down 20
        # stroke_horizontal_rule
        # move_down 20

        
        # move_down 20
        # text @cv.languages.inspect

        # start_new_page
        render
    end
end