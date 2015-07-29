Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get '/merchants/random', to: 'merchants#random'
      get '/merchants/find', to: 'merchants#find'
      get '/merchants/find_all', to: 'merchants#find_all'
      get 'merchants/most_revenue', to: 'merchants#most_revenue'
      get 'merchants/most_items', to: 'merchants#most_items'
      get 'merchants/revenue', to: 'merchants#all_revenue'
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchants#items', only: [:index]
        get '/invoices', to: 'merchants#invoices', only: [:index]
        get '/revenue', to: 'merchants#revenue'
        get '/favorite_customer', to: 'merchants#favorite_customer'
        get '/customers_with_pending_invoices', to: 'merchants#customers_with_pending_invoices'
      end

      get '/customers/random', to: 'customers#random'
      get '/customers/find', to: 'customers#find'
      get '/customers/find_all', to: 'customers#find_all'
      resources :customers, except: [:new, :edit] do
        get '/invoices', to: 'customers#invoices', only: [:index]
        get '/transactions', to: 'customers#transactions', only: [:index]
        get '/favorite_merchant', to: 'customers#favorite_merchant'
        get '/merchants', to: 'customers#merchants'
      end

      get '/invoices/random', to: 'invoices#random'
      get '/invoices/find', to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      resources :invoices, except: [:new, :edit] do
        get '/transactions', to: 'invoices#transactions', only: [:index]
        get '/invoice_items', to: 'invoices#invoice_items', only: [:index]
        get '/items', to: 'invoices#items', only: [:index]
        get '/customer', to: 'invoices#customer', only: [:show]
        get '/merchant', to: 'invoices#merchant', only: [:show]
      end

      get '/invoice_items/random', to: 'invoice_items#random'
      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      resources :invoice_items, except: [:new, :edit] do
        get '/invoice', to: 'invoice_items#invoice', only: [:show]
        get '/item', to: 'invoice_items#item', only: [:show]
      end

      get '/transactions/random', to: 'transactions#random'
      get '/transactions/find', to: 'transactions#find'
      get '/transactions/find_all', to: 'transactions#find_all'
      resources :transactions, except: [:new, :edit] do
        get '/invoice', to: 'transactions#invoice', only: [:show]
      end

      get '/items/random', to: 'items#random'
      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'
      get '/items/most_revenue', to: 'items#most_revenue'
      get '/items/most_items', to: 'items#most_items'
      resources :items, except: [:new, :edit] do
        get '/invoice_items', to: 'items#invoice_items', only: [:index]
        get '/merchant', to: 'items#merchant', only: [:show]
        get '/best_day', to: 'items#best_day'
      end
    end
  end
end
