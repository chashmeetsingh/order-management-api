# Installation Steps for Ubuntu

```sh
sudo apt install curl
```
```sh
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```
```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
```
```sh
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```
```sh
sudo apt-get update
```
```sh
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
```
```sh
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
```
```sh
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```
```sh
curl -sSL https://get.rvm.io | bash -s stable
```
```sh
source ~/.rvm/scripts/rvm
```
```sh
rvm install 2.6.3
```
```sh
rvm use 2.6.3 --default
```
```sh
ruby -v
```
```sh
gem install bundler
```
```sh
gem install rails -v 6.0.2.1
```
```sh
bundle install
```
```sh
rake db:migrate
```
```sh
rails s
```

Finally, you can start testing.

### Endpoints and request types
#### 1. Get inventories
    GET ```localhost:3000/inventories```

#### 2. Get single inventory
    GET ```localhost:3000/inventories/1```

#### 3. Create inventory
    POST ```localhost:3000/inventories```
##### Payload
```
{
	"name" : "test 1",
	"description" : "test desc 1",
	"price" : 10.52,
	"quantity": 10
}
```

#### 4. Update inventory
##### Payload
PUT/PATCH ```localhost:3000/inventories/1```
```
{
	"name" : "test 1",
	"description" : "test desc 1",
	"price" : 10.52,
	"quantity": 10
}
```

#### 5. Delete inventory
DELETE ```localhost:3000/inventories/1```

#### 6. Get orders
GET ```localhost:3000/orders```

#### 7. Get single order
GET ```localhost:3000/orders/1```

#### 8. Create order
POST ```localhost:3000/orders```
##### Payload
```
{
	"orders" : {
		"email": "testtest.com",
		"order_items": [
    		{
    			"inventory_id" : 4,
    			"quantity" : 1
    		},
    		{
    			"inventory_id" : 5,
    			"quantity" : 1
	    	}
		]
	}
}
```

#### 9. Update order
PUT/PATCH ```localhost:3000/orders/1```
##### Payload
```
{
	"orders" : {
		"email": "test@test.com",
		"order_items": [
    		{
    			"inventory_id" : 2,
    			"quantity" : 2
    		}
    	]
	}
}
```

#### 10. Delete order
DELETE ```localhost:3000/orders/1```
