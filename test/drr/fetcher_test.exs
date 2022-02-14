defmodule DRR.FetchTest do
  use ExUnit.Case
  alias DRR.Fetcher

  import Tesla.Mock

  test "gets and parses a page" do
    mock_global(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          headers: [{"content-type", "text/html; charset=utf-8"}],
          body: File.read!(Path.join(__DIR__, "../fixtures/page1.html"))
        }
    end)

    assert Fetcher.fetch("http://example.com", 1) == [
             [
               %{
                 body:
                   "Everyone was very friendly and we got a good deal.  We were pleased with the attention and pricing received.",
                 date: "February 11, 2022",
                 employees: [
                   %{name: "Mike Lambert", rating: 50},
                   %{name: "Taylor Prickett", rating: 50}
                 ],
                 rating: 50,
                 user: "Rita Shar"
               },
               %{
                 body:
                   "Adrian is the best very nice very patient and he got me the car I wanted!",
                 date: "February 10, 2022",
                 employees: [%{name: "Adrian \"AyyDee\" Cortes", rating: 50}],
                 rating: 50,
                 user: "Stacey30"
               },
               %{
                 body:
                   "We drove to Gladewater from Longview after being contacted by the internet monitor that a new Enclave had arrived that day. Adrian Cortes moved the car into a bay so we could be warmer & very patiently reviewed all the features before taking us for a test drive. Adrian was very knowledgeable and professional.  I am going to love driving my 2022 Buick Enclave Avenir and am thankful for his help!",
                 date: "February 09, 2022",
                 employees: [
                   %{name: "Adrian \"AyyDee\" Cortes", rating: 50},
                   %{name: "Marissa Wallace", rating: 50}
                 ],
                 rating: 50,
                 user: "ellisonsusan80"
               },
               %{
                 body:
                   "Tristan and Brandon sold me a awesome 2022 Chevy trax they were very helpful and was able to get me and my wife in a new vehicle when several other dealerships could not and on top of that the amazing price they gave us for our trade in.",
                 date: "February 07, 2022",
                 employees: [
                   %{name: "Brandon McCloskey", rating: 50},
                   %{name: "Tristian Olivares", rating: 50},
                   %{name: "Taylor Prickett", rating: 50}
                 ],
                 rating: 50,
                 user: "feliciastephenson17"
               },
               %{
                 body:
                   "I general do not like dealing with \"dealerships\", but my experience with Kyre was exceptional. He took the time to listen to what I wanted and what I had to say.  Did not push me toward any particular vehicle.  Knew when to \"back off\" and let me make my own decision.  Happy to call him my friend.  Would do business with him again.",
                 date: "February 04, 2022",
                 employees: [%{name: "Kyre Lewis", rating: 50}],
                 rating: 50,
                 user: "gary"
               },
               %{
                 body:
                   "Always have a great experience been going there for 6 years and will always go back great service great attitude when you go in .",
                 date: "January 27, 2022",
                 employees: [%{name: "Adrian \"AyyDee\" Cortes", rating: 50}],
                 rating: 50,
                 user: "johnkim2005webb"
               },
               %{
                 body:
                   "He was very driven and motivated, polite and caring! I will recommend him!! Very satisfied!!!",
                 date: "January 27, 2022",
                 employees: [%{name: "Tristian Olivares", rating: 50}],
                 rating: 50,
                 user: "Tonya.griffin903"
               },
               %{
                 body:
                   "Adrian was a great sales person. He was very professional. He made the buying process so easy. He was very thorough in showing me everything about the truck. I really appreciate his kindness and making this a great experience!",
                 date: "January 26, 2022",
                 employees: [
                   %{name: "Adrian \"AyyDee\" Cortes", rating: 50},
                   %{name: "Taylor Prickett", rating: 50}
                 ],
                 rating: 50,
                 user: "Jody"
               },
               %{
                 body:
                   "Tristian was awesome so helpful and patient with us and worked so hard to get us in r new car we had a great experience with them I would recommend them to everyone",
                 date: "January 25, 2022",
                 employees: [%{name: "Tristian Olivares", rating: 50}],
                 rating: 50,
                 user: "jolynschneider6"
               },
               %{
                 body:
                   "Everyone here was very friendly and very helpful.  They got me into an awesome vehicle and I couldn't b e happier",
                 date: "January 17, 2022",
                 employees: [
                   %{name: "Kent Abernathy", rating: 50},
                   %{name: "Adrian \"AyyDee\" Cortes", rating: 50},
                   %{name: "Mike Lambert", rating: 50},
                   %{name: "Kyre Lewis", rating: 50},
                   %{name: "Kristina Manning", rating: 50},
                   %{name: "Brandon McCloskey", rating: 50},
                   %{name: "Tristian Olivares", rating: 50},
                   %{name: "Taylor Prickett", rating: 50},
                   %{name: "Freddie Tomlinson", rating: 50}
                 ],
                 rating: 50,
                 user: "Mkoballard78"
               }
             ]
           ]
  end
end
