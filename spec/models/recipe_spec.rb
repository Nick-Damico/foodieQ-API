require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:all) do
    DatabaseCleaner.clean
    @user = create(:user_1)
    @recipe = build(:recipe)
    @recipe.user = @user
    # Ingredients to test associations between models
    @ingredient_one = build(:ingredient)
    @ingredient_two = build(:ingredient_two)
  end

  it 'is valid with title, description' do
    expect(@recipe).to be_valid
  end

  describe 'has_many' do
    it 'has_many ingredients' do
      @recipe.ingredients << @ingredient_one
      @recipe.ingredients << @ingredient_two

      expect(@recipe.ingredients.length).to eq(2)
      expect(@recipe.ingredients.first).to eq(@ingredient_one)
    end

    it 'has_many steps' do
      # Parent must be saved to call #create!
      @recipe.save
      @recipe.steps.create!(description: 'Add 1 Cup of chicken broth')
      @recipe.steps.create!(description: 'Add vegatable bouillion')

      expect(@recipe.steps.length).to eq(2)
    end
  end

  describe 'title' do
    it 'is invalid without title' do
      @recipe.title = ''
      @recipe.valid?

      expect(@recipe).to_not be_valid
      expect(@recipe.errors[:title]).to include("can't be blank")
    end

    it 'is invalid with a title length greater then 100characters' do
      @recipe.title = 'A' * 101

      expect(@recipe).to_not be_valid
      expect(@recipe.errors[:title]).to include('is too long (maximum is 100 characters)')
    end
  end

  describe 'description' do
    it 'is invalid without a description' do
      @recipe.description = ''

      expect(@recipe).to_not be_valid
      expect(@recipe.errors[:description]).to include("can't be blank")
    end

    it 'is invalid with a description greater then 1500 characters' do
      @recipe.description = Faker::Lorem.paragraph_by_chars(1501)

      expect(@recipe).to_not be_valid
      expect(@recipe.errors[:description]).to include('is too long (maximum is 1500 characters)')
    end
  end

  describe "image" do
    context 'with a valid image of type and size' do
      it 'has an attribute of image' do
        expect(@recipe).to respond_to(:image)
      end

      it 'takes an image file as a value' do
        file = fixture_file_upload(Rails.root.join('public', 'images', 'recipes', 'recipe_1.png'), 'image/png')
        @recipe.image = file
        @recipe.save

        expect(@recipe.image.attached?).to eq(true)
        expect(@recipe.image.filename).to eq(file.original_filename)
      end
    end

    context 'with an invalid image of type and size' do
      it 'is invalid with a content type not of .jpg or .png' do
        file = fixture_file_upload(Rails.root.join('public', 'documents', 'text.pdf'))
        @recipe.image = file

        expect(@recipe).to_not be_valid
        expect(@recipe.errors.full_messages).to include('Image must be of content types: jpg, png')
      end

      it 'is invalid with a file > 5mb' do
        file = fixture_file_upload(Rails.root.join('public', 'images', 'recipes', 'large.jpg'), 'image/jpg')
        @recipe.image = file

        expect(@recipe).to_not be_valid
        expect(@recipe.errors.full_messages).to include('Image is too large, max file size is 5mb')
      end
    end
  end

  describe 'published' do
    it 'defaults to a value of false' do
      expect(@recipe.published).to eq(false)
    end
  end

  describe 'Callback #format_description_title' do
    it 'removes leading/trailing whitepace and capitalizes first letter of title and description' do
      @recipe.title = ' orange cake '
      @recipe.description = ' best cake yet'
      @recipe.save

      expect(@recipe.title).to eq('Orange cake')
      expect(@recipe.description).to eq('Best cake yet')
    end
  end

  describe 'belongs to User' do
    it 'responds to #user method' do
      expect(@recipe).to respond_to(:user)
    end

    it 'creates a User singular association method #create_*' do
      recipe = build(:recipe)
      recipe.create_user(email: 'test@example.com', password: 'vaildpass123',
                         password_confirmation: 'validpass123')
      recipe.save

      expect(recipe.user.email).to eq('test@example.com')
    end

    it 'belongs to a User' do
      expect(@recipe.user).to eq (@user)
    end
  end
end
