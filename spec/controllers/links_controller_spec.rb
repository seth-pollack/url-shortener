require 'rails_helper'

describe LinksController, type: :controller do
  describe "GET #index" do
    it 'should render index' do
      Url.create(link: 'http://example.com')
      get :index
      expect(response).to render_template(:index)
    end
  end
  describe "POST #create" do
    context 'when url is valid' do 
      before { post :create, {url: {link: 'http://example.com'}} }

      it 'should redirect to home page' do
        expect(response).to redirect_to action: :index
      end

      context 'when url does not exist' do
        it 'should create a new url' do 
          expect(Url.count).to eq(1)
          expect(Url.first.id).to eq(1)
          expect(Url.first.link).to eq('http://example.com')
        end

        it 'should set the flash with the short url' do 
          expect(flash[:error]).to be_nil
          expect(flash[:success]).to eq('Url Shortened successfully!')
          expect(flash[:short_url]).to match(/b$/)
        end
      end
      
      context 'when url exists' do
        it 'should not create a new url' do 
          expect(Url.count).to eq(1)
          expect(Url.first.id).to eq(1)
          expect(Url.first.link).to eq('http://example.com')
        end

        it 'should set the flash with the short url' do 
          expect(flash[:error]).to be_nil
          expect(flash[:success]).to eq('Url Shortened successfully!')
          expect(flash[:short_url]).to match(/b$/)
        end
      end
    end

    context 'when url is invalid' do
      before { post :create, {url: {link: 'www.example.com'}} }

      it 'should redirect to home page' do
        expect(response).to redirect_to action: :index
      end

      it 'should set the flash error message' do 
        expect(flash[:success]).to be_nil
        expect(flash[:error]).to eq('Invalid url!')
      end
    end
  end
  describe "GET #show" do
    context 'when url exists' do
      before do 
        post :create, {url:{ link: 'http://www.example.com'}}
        get :show, {slug: 'b'}
      end

      it 'should redirect' do
        expect(response).to redirect_to 'http://www.example.com'
      end

      it 'should increment the visit count' do
        url = Url.find(1)
        expect(url.visits.count).to eq(1)
      end
    end
    context 'when url does not exist' do
      it 'should reirect 404' do
        get :show, {slug: 'b'}
        expect(response).to have_http_status(404)
      end
    end
  end
end
