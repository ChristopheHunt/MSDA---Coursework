# # Week 4 IO Parsing HTML
############################################
# I will be using the Beautiful Soup python library to parse https://www.brainpickings.org.
# The site has excellent book reviews for a variety of topics by the site's creator Maria Popova.
# Additionally, she takes several exceptional quotes from each author for their book post, which will be our text of interest.
# Once we parse the text of interest, will pass them to the Alchemy API for the top ten keywords.
#############################################

import pandas as pd
from BeautifulSoup import BeautifulSoup
import urllib2
from alchemyapi.alchemyapi import AlchemyAPI

url = 'https://www.brainpickings.org'
page = urllib2.urlopen(url)
soup = BeautifulSoup(page.read())

divText = soup.find("div",  {"id": "main_body"} , {"class": "right"})
print(str(divText.div.strong.prettify) + " AUTHOR NAME TEST")
print(str(divText.div.blockquote.prettify) + " QUOTE TEXT TEST")

def build_quotes(TextSoup):
        divText = TextSoup.find("div",  {"id": "main_body"} , {"class": "right"})
        Allauthors = []
        Allquotes = []
        for tag in divText:
            author = tag.find('strong')
            if author not in (-1, None):
                Allauthors.append(author.contents)
            quotes = tag.find('blockquote')
            if quotes not in (-1, None):
                quote = quotes.findAll('p', text = True)
                Allquotes.append(quote)
        print(str(Allauthors[0]) + str(Allquotes[0]) + "FIRST QUOTE - RESULTS TEST")
        return(Allquotes)

Allquotes = build_quotes(soup)
alchemyapi = AlchemyAPI()
response = alchemyapi.keywords('text', Allquotes)
keywords = response.values()
keywords = keywords[2]

print(str(keywords[0]) + " KEYWORD SLICE CHECK")

df = pd.DataFrame(keywords)
df.index = df.index + 1
print df[0:10]

