import webapp2
from google.appengine.api import urlfetch
import urllib2
import urllib
import base64
import simplejson as json
import random

MAIN_PAGE_HTML = """\
<html>
  <body>
    <form method="POST" action="/">
        Latitude: <input type=text name="lat">
        Longitude: <input type=text name="long">
    <input type="submit" value="Tell me where you live!">
    </form>
  </body>
</html>
"""

RESTAURANT_HTML ="""\
<html>
  <body>
    <form method="POST" action="/submitrestaurant">
        Latitude: <input type=text name="lat">
        Longitude: <input type=text name="long">
        American: <input type=text name="american">
        Chinese: <input type=text name="chinese">
        Diner: <input type=text name="diner">
        Seafood: <input type=text name="seafood">
        Italian: <input type=text name="italian">
        Thai: <input type=text name="thai">
        Price (1 thru 5) <input type=text name="price">
    <input type="submit" value="Tell me where you live!">
    </form>
  </body>
</html>
"""

OUTDOOR_HTML ="""\
<html>
  <body>
    <form method="POST" action="/outdoor">
        Latitude: <input type=text name="lat">
        Longitude: <input type=text name="long">
    <input type="submit" value="Tell me where you live!">
    </form>
  </body>
</html>
"""

CULTURAL_HTML ="""\
<html>
  <body>
    <form method="POST" action="/culture">
        Latitude: <input type=text name="lat">
        Longitude: <input type=text name="long">
    <input type="submit" value="Tell me where you live!">
    </form>
  </body>
</html>
"""

class RestaurantDisp(webapp2.RequestHandler):
    def get(self):
        self.response.write(RESTAURANT_HTML)

class RandomRestaurant(webapp2.RequestHandler):
    def post(self):
        self.response.headers['Content-Type'] = 'text/plain'
        latitude = self.request.get("lat")
        longitude = self.request.get("long")
        american = self.request.get("american")
        chinese = self.request.get("chinese")
        diner = self.request.get("diner")
        seafood = self.request.get("seafood")
        italian = self.request.get("italian")
        thai = self.request.get("thai")
        price = self.request.get("price")

        factualquery = 'http://api.v3.factual.com/t/restaurants-us?geo={"$circle":{"$center":['
        factualquery += str(latitude)
        factualquery += ","
        factualquery += str(longitude)
        factualquery += '],"$meters":2500}}&KEY=fp1SCfi27hqvFLHF5d55fyXoMCUNAh9V9hL4BD15&filters={"category_ids":{"$includes_any":['

        if american =="1":
            factualquery+="348,"

        if chinese == "1":
            factualquery+="352,"

        if diner =="1":
            factualquery+="354,"

        if seafood =="1":
            factualquery+="364,"

        if italian =="1":
            factualquery+="358,"

        if thai == "1":
            factualquery+="367,"

        factualquery = factualquery[:-1]

        factualquery+=']},"price":'
        factualquery+='"'
        factualquery+=price
        factualquery+='"}'
        self.response.write(factualquery)
        response = urlfetch.fetch(url = factualquery, method = urlfetch.GET)
        rezult = json.loads(response.content)
        responsedict = rezult['response']
        data = responsedict['data']
        index = random.randint(0, len(data)-1)
        randominlist = data[index]
        name = randominlist['name']
        self.response.write(randominlist)

        randomlat=randominlist['latitude']
        randomlong=randominlist['longitude']
        mapslink = 'comgooglemaps://?center='
        mapslink+=str(randomlat)
        mapslink+=","
        mapslink+=str(randomlong)
        mapslink+="q="

        namenospace = ""
        for i in range(0, len(name)):
            if name[i] == " ":
                namenospace += "+"
            else:
                namenospace += name[i]

        mapslink+=namenospace
        self.response.write("googlemapslink: " + mapslink)

        yelplink = "yelp:///search?term="
        yelplink += namenospace
        yelplink+="&cll="
        yelplink+=str(randomlat)
        yelplink+=","
        yelplink+=str(randomlong)
        self.response.write("yelplink: " + yelplink)



class RandomOutdoor(webapp2.RequestHandler):
    def get(self):
        self.response.write(OUTDOOR_HTML)
    def post(self):
        latitude = self.request.get("lat")
        longitude = self.request.get("long")
        self.response.headers['Content-Type'] = 'text/plain'
        factualquery = 'http://api.v3.factual.com/t/places?filters={%22category_ids%22:{%22$includes_any%22:[109,111,112,118,154,327,375,376,387,394,399,401,403,408]}}'
        factualquery += '&geo={"$circle":{"$center":['
        factualquery += str(latitude)
        factualquery += ","
        factualquery += str(longitude)
        factualquery += '],"$meters":2500}}'
        factualquery+='&KEY=fp1SCfi27hqvFLHF5d55fyXoMCUNAh9V9hL4BD15&limit=50'
        #base64version = base64.b64decode(factualquery)
        factualresponse = urlfetch.fetch(url = factualquery, method = urlfetch.GET)
        rezult = json.loads(factualresponse.content)
        responsedict = rezult['response']
        data = responsedict['data']
        index = random.randint(0, len(data)-1)
        randominlist = data[index]
        self.response.write(randominlist)
        randomlat=randominlist['latitude']
        randomlong=randominlist['longitude']
        googlequery='https://maps.googleapis.com/maps/api/streetview?size=400x400&location='
        googlequery+=str(randomlat)
        googlequery+=","
        googlequery+=str(randomlong)
        googlequery+='&key=AIzaSyAT2PcZUhBG0sHmuAB0GLxZz1iUIIcHrlc'
        #self.response.write(googlequery)
        #googleresponse = urlfetch.fetch(url = googlequery, method = urlfetch.GET)
        self.response.write("streetviewlink: " + googlequery)

class RandomCultural(webapp2.RequestHandler):
    def get(self):
        self.response.write(CULTURAL_HTML)
    def post(self):
        latitude=self.request.get("lat")
        longitude=self.request.get("long")
        self.response.headers['Content-Type'] = 'text/plain'
        factualquery = 'http://api.v3.factual.com/t/places?filters={%22category_ids%22:{%22$includes_any%22:[53,108,110,11,147,166,174,309,317]}}'
        factualquery += '&geo={"$circle":{"$center":['
        factualquery += str(latitude)
        factualquery += ","
        factualquery += str(longitude)
        factualquery += '],"$meters":2500}}'
        factualquery+='&KEY=fp1SCfi27hqvFLHF5d55fyXoMCUNAh9V9hL4BD15&limit=50'
        #base64version = base64.b64decode(factualquery)
        factualresponse = urlfetch.fetch(url = factualquery, method = urlfetch.GET)
        rezult = json.loads(factualresponse.content)
        responsedict = rezult['response']
        data = responsedict['data']
        index = random.randint(0, len(data)-1)
        randominlist = data[index]
        self.response.write(randominlist)
        randomlat=randominlist['latitude']
        randomlong=randominlist['longitude']
        googlequery='https://maps.googleapis.com/maps/api/streetview?size=400x400&location='
        googlequery+=str(randomlat)
        googlequery+=","
        googlequery+=str(randomlong)
        googlequery+='&key=AIzaSyAT2PcZUhBG0sHmuAB0GLxZz1iUIIcHrlc'
        self.response.write("streetviewlink: " + googlequery)
        #self.response.write(googlequery)
        #googleresponse = urlfetch.fetch(url = googlequery, method = urlfetch.GET)


application = webapp2.WSGIApplication([
    ('/restaurantdisp', RestaurantDisp),
    ('/submitrestaurant', RandomRestaurant),
    ('/outdoor', RandomOutdoor),
    ('/culture', RandomCultural)
], debug=True)
