Rails.application.routes.draw do
  devise_for :users                    #rails g devise userによって自動生成されたルーティング
  root to: 'prototypes#index'          #ルートアドレスを指定しルートアドレスにprototypesコントローラーのindexアクションを実行。
                                       #ルートアドレスはhttp://localhost:3000
  get 'index', to: 'prototypes#index'  #prototypesコントローラーのindexアクションを以下のアドレスに実行。
                                       #アドレスはhttp://localhost:3000/index
  resources :prototypes do             #基本ルーティングの指定。アドレスはhttp://localhost:3000/prototypes
    resources :comments #あらかじめ決められたアドレスが自動生成される。
  end                                  #resources :indexのように指定してもhttp://localhost:3000/index
                                       #は読み込めない。アドレスの指定は不可。エラーが出る。ルーティング名はコントローラー名と同じでなければならない。    
  resources :users, only: :show                                                                  
  get 'profile', to: 'prototypes#pikoko' #prototypesコントローラーのpikokoアクションをhttp://localhost:3000/profileアドレスに指定。                                    
end