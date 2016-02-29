
# coding: utf-8

# # Week 4 IO Parsing HTML

# ### I will be using the Beautiful Soup python library to parse https://www.brainpickings.org. The site has excellent book reviews for a variety of topics by the site's creator Maria Popova. Additionally, she takes several exceptional quotes from each author for their book post, which will be our text of interest. Once we parse the text of interest, will pass them to the Alchemy API for the top ten keywords.  

# In[1]:

from IPython.display import HTML
HTML('<iframe src=https://www.brainpickings.org width=1000 height=400></iframe>')


# In[2]:

from BeautifulSoup import BeautifulSoup
import urllib2

url = 'https://www.brainpickings.org'
page = urllib2.urlopen(url)
soup = BeautifulSoup(page.read())


# In[3]:

divText = soup.find("div",  {"id": "main_body"} , {"class": "right"})
print(str(divText.div.strong.prettify) + " AUTHOR NAME TEST")
print(str(divText.div.blockquote.prettify) + " QUOTE TEXT TEST")


# In[4]:

Allquotes = []
Allauthors = []

for tag in divText:
    author = tag.find('strong')
    if author not in (-1, None):
        Allauthors.append(author.contents)
    quotes = tag.find('blockquote')
    if quotes not in (-1, None):
        quote = quotes.findAll('p', text = True)
        Allquotes.append(quote)


# In[5]:

print Allauthors[0]
print Allquotes[0]


# In[6]:

from alchemyapi.alchemyapi import AlchemyAPI


# In[7]:

alchemyapi = AlchemyAPI()
response = alchemyapi.keywords('text', Allquotes)
keywords = response.values()


# In[8]:

keywords = keywords[2]
print(str(keywords[0]) + " KEYWORD SLICE CHECK")


# In[9]:

import pandas as pd
df = pd.DataFrame(keywords)
df.index = df.index + 1
df[0:10]

