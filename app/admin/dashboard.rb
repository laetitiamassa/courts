ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    columns do
        column do
            panel "Last users" do
                ul do
                    User.last(10).map do |user|
                        li link_to(user.name_or_placeholder, admin_user_path(user))
                    end
                end
            end
        end

        column do
            panel "Last courts" do
                ul do
                    Court.last(10).map do |court|
                        li link_to(court.date_display, admin_court_path(court)) do span court.bar end
                    end
                end
            end
        end

        column do
            panel "Connected this week" do
                span "Il y a"
                span User.where('current_sign_in_at >= ?', 1.week.ago).count
                span "utilisateurs hébdomadaires"
                ul do

                    User.where('current_sign_in_at >= ?', 1.week.ago).map do |user|
                        li link_to(user.name_or_placeholder, admin_user_path(user)) do 
                                span "-"
                                span user.bar 
                                #span user.current_sign_in_at #for checking
                            end
                        end
                    end
            end

            panel "Visited this week" do
                span User.where('last_seen_at >= ?', 1.week.ago).count
                span "visiteurs hébdomadaires"
                ul do
                    User.where('last_seen_at >= ?', 1.week.ago).map do |user|
                        li link_to(user.name_or_placeholder, admin_user_path(user)) do 
                                span "-"
                                span user.bar 
                                span user.last_seen_at #for checking
                            end
                        end
                end
            end
        end

        column do
            panel "Offre de remplacement par barreau" do
                ul do
                    #le bar en question + le nombre de users dont le barreau est celui-là
                        li "Bruxelles OBFG : " do 
                            span User.where(:bar =>"BrusselsFR").count
                            span "/"
                            span User.where(:bar =>"BrusselsFR", :subscribed => true).count
                            span "payants"
                        end
                        li "Bruxelles OVB : " do 
                            span User.where(:bar =>"BrusselsNL").count 
                            span "/"
                            span User.where(:bar =>"BrusselsNL", :subscribed => true).count
                            span "payants"
                        end
                        li "Arlon : " do 
                            span User.where(:bar =>"Arlon").count 
                            span "/"
                            span User.where(:bar =>"Arlon", :subscribed => true).count
                            span "payants"
                        end
                        li "Charleroi : " do 
                            span User.where(:bar =>"Charleroi").count
                            span "/"
                            span User.where(:bar =>"Charleroi", :subscribed => true).count
                            span "payants"
                         end
                        li "Dinant : " do 
                            span User.where(:bar =>"Dinant").count
                            span "/"
                            span User.where(:bar =>"Dinant", :subscribed => true).count
                            span "payants" 
                        end
                        li "Eupen : " do 
                            span User.where(:bar =>"Eupen").count 
                            span "/"
                            span User.where(:bar =>"Eupen", :subscribed => true).count
                            span "payants"
                        end
                        li "Huy : " do 
                            span User.where(:bar =>"Huy").count
                            span "/"
                            span User.where(:bar =>"Huy", :subscribed => true).count
                            span "payants" 
                        end
                        li "Liège : " do 
                            span User.where(:bar =>"Liege").count 
                            span "/"
                            span User.where(:bar =>"Liege", :subscribed => true).count
                            span "payants"
                        end
                        li "Marche : " do 
                            span User.where(:bar =>"Marche").count 
                            span "/"
                            span User.where(:bar =>"Marche", :subscribed => true).count
                            span "payants"
                        end
                        li "Mons : " do 
                            span User.where(:bar =>"Mons").count 
                            span "/"
                            span User.where(:bar =>"Mons", :subscribed => true).count
                            span "payants"
                        end
                        li "Namur : " do 
                            span User.where(:bar =>"Namur").count 
                            span "/"
                            span User.where(:bar =>"Namur", :subscribed => true).count
                            span "payants"
                        end
                        li "Neufchateau : " do 
                            span User.where(:bar =>"Neufchateau").count 
                            span "/"
                            span User.where(:bar =>"Neufchateau", :subscribed => true).count
                            span "payants"
                        end
                        li "Nivelles : " do 
                            span User.where(:bar =>"Nivelles").count 
                            span "/"
                            span User.where(:bar =>"Nivelles", :subscribed => true).count
                            span "payants"
                        end
                        li "Tournai : " do 
                            span User.where(:bar =>"Tournai").count 
                            span "/"
                            span User.where(:bar =>"Tournai", :subscribed => true).count
                            span "payants"
                        end
                        li "Verviers : " do 
                            span User.where(:bar =>"Anvers").count 
                            span "/"
                            span User.where(:bar =>"Anvers", :subscribed => true).count
                            span "payants"
                        end
                        li "Anvers : " do 
                            span User.where(:bar =>"Anvers").count 
                            span "/"
                            span User.where(:bar =>"Anvers", :subscribed => true).count
                            span "payants"
                        end
                        li "Brugge : " do 
                            span User.where(:bar =>"Brugge").count 
                            span "/"
                            span User.where(:bar =>"Brugge", :subscribed => true).count
                            span "payants"
                        end
                        li "Dendermonde : " do 
                            span User.where(:bar =>"Dendermonde").count 
                            span "/"
                            span User.where(:bar =>"Dendermonde", :subscribed => true).count
                            span "payants"
                        end
                        li "Gent : " do 
                            span User.where(:bar =>"Gent").count 
                            span "/"
                            span User.where(:bar =>"Gent", :subscribed => true).count
                            span "payants"
                        end
                        li "Hasselt : " do 
                            span User.where(:bar =>"Hasselt").count 
                            span "/"
                            span User.where(:bar =>"Hasselt", :subscribed => true).count
                            span "payants"
                        end
                        li "Ieper : " do 
                            span User.where(:bar =>"Ieper").count 
                            span "/"
                            span User.where(:bar =>"Ieper", :subscribed => true).count
                            span "payants"
                        end
                        li "Kortrijk : " do 
                            span User.where(:bar =>"Kortrijk").count 
                            span "/"
                            span User.where(:bar =>"Kortrijk", :subscribed => true).count
                            span "payants"
                        end
                        li "Leuven : " do 
                            span User.where(:bar =>"Leuven").count 
                            span "/"
                            span User.where(:bar =>"Leuven", :subscribed => true).count
                            span "payants"
                        end
                        li "Mechelen : " do 
                            span User.where(:bar =>"Mechelen").count 
                            span "/"
                            span User.where(:bar =>"Mechelen", :subscribed => true).count
                            span "payants"
                        end
                        li "Oudernaarde : " do 
                            span User.where(:bar =>"Oudernaarde").count 
                            span "/"
                            span User.where(:bar =>"Oudernaarde", :subscribed => true).count
                            span "payants"
                        end
                        li "Tongeren : " do 
                            span User.where(:bar =>"Tongeren").count 
                            span "/"
                            span User.where(:bar =>"Tongeren", :subscribed => true).count
                            span "payants"
                        end
                        li "Turnhout : " do 
                            span User.where(:bar =>"Turnhout").count 
                            span "/"
                            span User.where(:bar =>"Turnhout", :subscribed => true).count
                            span "payants"
                        end
                        li "Veurne : " do 
                            span User.where(:bar =>"Veurne").count 
                            span "/"
                            span User.where(:bar =>"Veurne", :subscribed => true).count
                            span "payants"
                        end

                end
            end
        end

        column do
            panel "Demande de remplacement par barreau" do
                ul do
                    #le bar en question + le nombre de users dont le barreau est celui-là
                        li "Bruxelles OBFG : " do 
                            span Court.where(:bar =>"BrusselsFR").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Bruxelles OVB : " do 
                            span Court.where(:bar =>"BrusselsNL").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé"
                        end
                        li "Arlon : " do 
                            span Court.where(:bar =>"Arlon").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Charleroi : " do 
                            span Court.where(:bar =>"Charleroi").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Dinant : " do 
                            span Court.where(:bar =>"Dinant").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Eupen : " do 
                            span Court.where(:bar =>"Eupen").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Huy : " do 
                            span Court.where(:bar =>"Huy").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Liège : " do 
                            span Court.where(:bar =>"Liege").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Marche : " do 
                            span Court.where(:bar =>"Marche").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Mons : " do 
                            span Court.where(:bar =>"Mons").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Namur : " do 
                            span Court.where(:bar =>"Namur").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Neufchateau : " do 
                            span Court.where(:bar =>"Neufchateau").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Nivelles : " do 
                            span Court.where(:bar =>"Nivelles").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Tournai : " do 
                            span Court.where(:bar =>"Tournai").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Verviers : " do 
                            span Court.where(:bar =>"Anvers").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Anvers : " do 
                            span Court.where(:bar =>"Anvers").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Brugge : " do 
                            span Court.where(:bar =>"Brugge").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Dendermonde : " do 
                            span Court.where(:bar =>"Dendermonde").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Gent : " do 
                            span Court.where(:bar =>"Gent").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Hasselt : " do 
                            span Court.where(:bar =>"Hasselt").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Ieper : " do 
                            span Court.where(:bar =>"Ieper").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Kortrijk : " do 
                            span Court.where(:bar =>"Kortrijk").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Leuven : " do 
                            span Court.where(:bar =>"Leuven").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Mechelen : " do 
                            span Court.where(:bar =>"Mechelen").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Oudernaarde : " do 
                            span Court.where(:bar =>"Oudernaarde").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Tongeren : " do 
                            span Court.where(:bar =>"Tongeren").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Turnhout : " do 
                            span Court.where(:bar =>"Turnhout").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end
                        li "Veurne : " do 
                            span Court.where(:bar =>"Veurne").count
                            span "/"
                            span Court.where(:have_found => true).count
                            span "trouvé" 
                        end


                        #"Mons", "Namur", "Neufchateau", "Nivelles", "Tournai", "Verviers", "Anvers", "Brugge", "Dendermonde", "Gent", "Hasselt", "Ieper", "Kortrijk", "Leuven", "Mechelen", "Oudernaarde", "Tongeren", "Turnhout", "Veurne"
                end
            end
        end
    end


  end # content



end
