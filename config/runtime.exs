import Config

config :dealer_rater_rater,
       :base_url,
       System.get_env(
         "BASE_URL",
         "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/"
       )
