Rails.application.routes.draw do

  resources :solutions
  resources :practices do
    get 'submissions'
  end
  resources :assignment_groups
  resources :batches do
    resources :assignment_groups
  end
  resources :students
  resources :courses
  devise_for :users , :path_prefix => "my"
  resources :users
  get 'assignments/approve_assignment'
  resources :assignments do
    collection do
      get 'recents' # to override assignments_recents action will be recents_assignments
      get 'approved'
      get 'search'
      get 'approval'
      get 'sources'
      get 'approve'
      get 'findslug'
      get 'random'
    end
    resources :solutions
  end

  resources :submissions

  resources :answers do
      collection do
        get 'recents'
      end
  end

  resources :tags do
    collection do
      get 'index'
      get 'search'
      get 'questions'
      get 'assignments'
    end
  end

  resources :lists

  match 'favourites' , to: 'favourites#create' , via: :post
  match 'favourites' , to: 'favourites#destroy' , via: :delete

  match 'forks' ,to: 'forks#create' ,via: :post
  get 'forks/myforks'

  root "assignments#index"

  get 'tags/question_filter'

  get 'home/check_submission'
  get 'home/input'
  get 'home/check_cache'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
