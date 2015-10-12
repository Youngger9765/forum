namespace :dev do

  task :fetch_firefight => :environment do
    puts "fetching firefight"

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=1316a13a-39cd-4db5-b663-930638f244c5"

    raw_content = RestClient.get(url)

    data = JSON.parse( raw_content )

    data["result"]["results"].each do |f|  

        Firefight.create( :firefight_id => f["_id"], :name => f["SBMNAME"], :result => f["RESULT"])

    end

  end

  task :fetch_legislator => :environment do
    puts "fetching legislators"

    url = "https://congressonline.azurewebsites.net/Api/Legislators/List?committee=0&legislatorSession=8
  "

    raw_content = RestClient.get(url)

    data = JSON.parse( raw_content )

    data.each do |le|  

        Legislator.create( :legislator_id => le["LegislatorId"], :name => le["FullName"], :party => le["Party"])

    end

  end

end