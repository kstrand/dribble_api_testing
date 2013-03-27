require (File.expand_path('./../../../spec_helper', __FILE__))

describe Dish::Player do
  
  describe "default attributes" do
    
   
    it "must include httparty methods" do
      Dish::Player.must_include HTTParty
    end

    # an API endpoint is the url location of the API and the method that is being called I think
    it "must have the base url set to the Dribble API endpoint" do 
      Dish::Player.base_uri.must_equal 'http://api.dribble.com'
    end

    describe "default instance attributes" do
        let(:player) { Dish::Player.new('simplebits') }
     
        it "must have an id attribute" do
          player.must_respond_to :username
        end
       
        it "must have the right id" do
          player.username.must_equal 'simplebits'
        end
       end


      describe "GET profile" do
       let(:player) { Dish::Player.new('simplebits') }

        before do
          VCR.insert_cassette 'player', :record => :new_episodes
        end

        after do
          VCR.eject_cassette
        end

        it "records the fixtures" do
          Dish::Player.get('/player/simplebits')
        end

        it "must have a profile method" do
           player.must_respond_to :profile
        end

        it "must parse the api response from JASON to hash" do
          player.profile.must_be_instance_of Hash
        end

        it "must perform the request and return the data" do
          player.profile["username"].must_equal("simplebits")
        end

      end
    end
end
