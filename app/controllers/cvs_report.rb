class CvsReport < Prawn::Document
    font_families.update(
        "Inter" => {
            :normal  => Rails.root.join("app/assets/fonts/Inter-Regular.ttf") }
    )

    def to_pdf(_cv_)
        @cv = _cv_
        @user = User.find_by(id: Person.find_by(id: @cv.person_id).user_id)
        
        font "Inter"
        text "#{@user.person.name} #{@user.person.surname}", size: 24
        move_down 20
        text "Info", size: 16
        text @user.person.inspect
        move_down 20
        text "Emails", size: 16
        text @user.emails.inspect
        move_down 20
        text "Telephones", size: 16
        text @user.telephones.inspect
        move_down 20
        move_down 20
        text "CV", size: 16
        text @cv.inspect
        move_down 20
        text @cv.educations.inspect
        move_down 20
        text @cv.experiences.inspect
        move_down 20
        text @cv.languages.inspect

        # start_new_page
        # text "Hello, world!"
        render
    end
end