import os
from dotenv import load_dotenv

import time

from pinecone import Pinecone, ServerlessSpec

from generate_random_id import generate_unique_code

from firebase_helper import pushDataToRealtimeFBDB

load_dotenv()

pc = Pinecone(api_key=os.environ['PINECONE_API_KEY'])


# creating a serverless index



name_spaces = ['bio', 'partner-preference', 'cusine-preference']

# pc.create_index(
#     name=index_name,
#     dimension=1024, # Replace with your model dimensions
#     metric="cosine", # Replace with your model metric
#     spec=ServerlessSpec(
#         cloud="aws",
#         region="us-east-1"
#     ) 
# )

data = [
    {"id": "vec1", "text": "Apple is a popular fruit known for its sweetness and crisp texture."},
    {"id": "vec2", "text": "The tech company Apple is known for its innovative products like the iPhone."},
    {"id": "vec3", "text": "Many people enjoy eating apples as a healthy snack."},
    {"id": "vec4", "text": "Apple Inc. has revolutionized the tech industry with its sleek designs and user-friendly interfaces."},
    {"id": "vec5", "text": "An apple a day keeps the doctor away, as the saying goes."},
    {"id": "vec6", "text": "Apple Computer Company was founded on April 1, 1976, by Steve Jobs, Steve Wozniak, and Ronald Wayne as a partnership."}
]

embeddings = pc.inference.embed(
    model="multilingual-e5-large",
    inputs=[d['text'] for d in data],
    parameters={"input_type": "passage", "truncate": "END"}
)

# print(len(embeddings[0]['values']))


def giveEmbeddings(data):
    embeddings = pc.inference.embed(
        model="multilingual-e5-large",
        inputs=[d['text'] for d in data],
        parameters={"input_type": "passage", "truncate": "END"}
    )
    return embeddings

def upsertDataChooseNameSpace(name_space: int, text: str, user_name: str, gender: str):
    '''
    name_sapce -> 0 = bio, 1 = partner-preference, 2 = cusine-preference
    '''
    index_name = "meet-app"
    data = [{'id': generate_unique_code(), 'name': user_name, 'text': text, 'gender': gender}]


    # Wait for the index to be ready
    while not pc.describe_index(index_name).status['ready']:
        time.sleep(1)

    index = pc.Index(index_name)

    embeddings = giveEmbeddings(data)

    vectors = []
    for d, e in zip(data, embeddings):
        vectors.append({
            "id": d['id'],
            "values": e['values'],
            "metadata": {'text': d['text'], 'name': d['name'], 'gender': d['gender']}
        })

    index.upsert(
        vectors=vectors,
        namespace=name_spaces[name_space]
    )


if __name__ == "__main__":
    # synthetic data
    profiles = [
    ["Alice", "Alice is a creative soul with a passion for photography and the arts. She loves exploring new galleries and outdoor spots around New York, capturing moments and memories along the way. In her free time, she enjoys cozy nights in with a good book or dinner at local spots with friends.", "Alice is looking for someone who shares her love for culture and creativity. She appreciates deep conversations and values a partner who is emotionally intelligent and kind.", "Female"],
    
    ["Bob", "Bob is an easy-going guy who thrives on the energy of LA. He works in tech but spends his weekends surfing or hiking in the nearby hills. When he's not outdoors, you can find him discovering new music or enjoying a craft beer with friends.", "Bob is looking for someone laid-back who enjoys the outdoors as much as he does. He values positivity and is hoping to meet someone who loves adventure and spontaneity.", "Male"],
    
    ["Carol", "Carol is a fun-loving professional who enjoys the vibrancy of the Chicago food scene and local events. She's a huge fan of live music, festivals, and exploring hidden gems in the city. In her downtime, she enjoys movie marathons and trying out new recipes.", "Carol is looking for someone who's active and enjoys trying new things, from restaurants to weekend getaways. She values humor and someone who can make her laugh.", "Female"],
    
    ["Dave", "Dave is a fitness enthusiast and a fan of the sunny Miami lifestyle. He spends most of his time outdoors, whether he's at the beach or jogging along the coast. He enjoys staying active but also loves relaxing with a good film or a backyard BBQ.", "Dave is looking for someone who values a healthy, active lifestyle but also knows how to unwind. He's drawn to people who are down-to-earth and share a love for the outdoors.", "Male"],
    
    ["Eve", "Eve is a bright and ambitious woman who works in the healthcare field. When she's not working, she enjoys volunteering, exploring Houston's food scene, and traveling to new places. She's always up for a spontaneous road trip or trying new experiences.", "Eve is looking for someone who is passionate about life and driven in their career. She values kindness and wants a partner who enjoys making a difference in the world.", "Female"],
    
    ["Frank", "Frank is a nature lover with a passion for the Pacific Northwest. He works as a software developer but spends his free time hiking, camping, and enjoying Seattle's coffee culture. He's also a huge reader and enjoys a good mystery novel by the fireplace.", "Frank is looking for someone who appreciates the outdoors and has a curious mind. He's interested in meeting someone who shares his love for adventure and intellectual pursuits.", "Male"],
    
    ["Grace", "Grace is a tech professional who enjoys the vibrancy and innovation of San Francisco. She's always exploring the city's art galleries, cafes, and startup events. In her free time, she enjoys painting and yoga to keep her balanced and creative.", "Grace is looking for someone who's both ambitious and grounded. She values creativity and is attracted to people who are passionate about their work and personal interests.", "Female"],
    
    ["Hank", "Hank is an academic at heart, having studied literature and now working as a professor. He enjoys Boston's historic charm and spends his weekends visiting museums, reading, or having long discussions over coffee with friends.", "Hank is looking for someone intellectual and open-minded. He appreciates meaningful conversations and is drawn to those who have a passion for learning and exploring new ideas.", "Male"],
    
    ["Ivy", "Ivy is an outgoing marketing professional who loves the sunny and lively vibe of Phoenix. She enjoys weekend hiking trips, local festivals, and trying out new eateries around the city. She's always the life of the party, but she also enjoys quiet nights in.", "Ivy is looking for someone fun and adventurous, who can keep up with her energetic personality. She values confidence and is drawn to people who enjoy living life to the fullest.", "Female"],
    
    ["John", "John is a laid-back guy with a career in hospitality. He loves the excitement of Las Vegas but also knows how to enjoy the quiet moments. In his free time, he enjoys golfing, spending time with friends, and exploring the nearby desert.", "John is looking for someone who's easy-going and can appreciate both the excitement of city life and the tranquility of nature. He values honesty and a good sense of humor.", "Male"],
    
    ["Kate", "Kate is a creative marketing professional who loves the quirky and artistic culture of Austin. She's always checking out new live music shows, local markets, and food trucks. She's a huge fan of outdoor activities like paddleboarding and biking.", "Kate is looking for someone who shares her love for adventure and creativity. She's drawn to people who have a passion for life and enjoy making the most out of each day.", "Female"],
    
    ["Leo", "Leo is a nature lover and works as an environmental scientist in Denver. He enjoys everything from hiking the Rockies to camping under the stars. When he's not outdoors, you can find him supporting local breweries or cooking up a storm at home.", "Leo is looking for someone who shares his passion for the environment and loves being outdoors. He values kindness and is hoping to meet someone who appreciates nature as much as he does.", "Male"],
    
    ["Mia", "Mia is a fun-loving, outgoing woman with a passion for theme parks and travel. She works in event planning and enjoys Orlando's vibrant attractions. On her days off, she's always planning her next adventure or spending time with friends at local hotspots.", "Mia is looking for someone who shares her enthusiasm for travel and new experiences. She values spontaneity and is attracted to people who love to have fun and explore new places.", "Female"],
    
    ["Nina", "Nina is a strong and driven entrepreneur who's building her own business in Dallas. She's passionate about her work but always makes time for friends and family. In her free time, she enjoys fitness, good food, and binge-watching her favorite shows.", "Nina is looking for someone who's equally motivated and career-focused. She values ambition and is drawn to partners who can balance work with fun and relaxation.", "Female"],
    
    ["Oscar", "Oscar is an outgoing and adventurous guy who loves living by the beach in San Diego. He spends his free time surfing, hiking, and discovering new restaurants. He's a big foodie and enjoys hosting BBQs with friends.", "Oscar is looking for someone with a laid-back attitude who enjoys the outdoors and good food. He values people who are active and enjoy trying new things.", "Male"],
    
    ["Paul", "Paul is a nature lover and a passionate photographer. He enjoys the greenery and parks around Portland, often spending his weekends on photography hikes or exploring local markets. He's a fan of good coffee and quiet reading sessions.", "Paul is looking for someone who appreciates the little things in life and has an artistic side. He values creativity and is hoping to meet someone who enjoys the outdoors as much as he does.", "Male"],
    
    ["Quinn", "Quinn is a history buff and enjoys the rich culture of Philadelphia. He works as a researcher and spends his free time exploring the city's historic sites, trying out new restaurants, or hosting trivia nights with friends.", "Quinn is looking for someone who shares his love for learning and history. He appreciates partners who are curious about the world and enjoy thoughtful conversations.", "Male"],
    
    ["Rose", "Rose is a free-spirited traveler who's always planning her next trip. Based in Salt Lake City, she spends her weekends hiking, skiing, and enjoying the beauty of the mountains. She also enjoys cooking and experimenting with new recipes.", "Rose is looking for someone who shares her love for travel and adventure. She values independence and is hoping to meet someone who's as spontaneous and open to new experiences as she is.", "Female"],
    
    ["Steve", "Steve is a tech entrepreneur who loves the fast-paced energy of Atlanta. He enjoys the startup scene and is always working on the next big idea. In his free time, he enjoys exploring new restaurants, attending concerts, and staying active with sports.", "Steve is looking for someone who's driven and passionate about their work. He's attracted to people who are ambitious and enjoy a mix of city life and active living.", "Male"],
    
    ["Tina", "Tina is a lively and energetic woman who loves the music and culture of New Orleans. She's a music teacher and spends her free time attending festivals, exploring the local food scene, and enjoying the vibrant nightlife.", "Tina is looking for someone who shares her love for music and culture. She's attracted to people who have a creative side and enjoy going out to experience the best of what life has to offer.", "Female"]
    ]

    food_desc = cuisine_likings = [
    "I can't resist a good pizza! Whether it's New York style or Neapolitan, it's always my go-to comfort food.",
    "I absolutely love sushi! There's something special about fresh sashimi and creative rolls.",
    "Mexican street food is my jam - give me tacos, burritos, and guacamole any day!",
    "I'm a huge fan of Italian food, especially a rich, creamy plate of pasta with a glass of wine.",
    "Thai food is my favorite, with its perfect balance of sweet, spicy, and sour flavors.",
    "I have a soft spot for Indian curries - I love how the spices come together to create such rich flavors.",
    "I can't live without Chinese dim sum! The variety and flavors always keep things exciting.",
    "Vegan food is my thing - I love creative plant-based dishes that make you forget there's no meat.",
    "There's nothing better than a perfectly cooked steak from a classic American BBQ joint.",
    "Mediterranean cuisine is my favorite - I love fresh salads, hummus, and grilled meats.",
    "Give me a bowl of ramen on a cold day, and I'm the happiest person alive.",
    "I'm all about Lebanese food - shawarma, falafel, and tabbouleh are my absolute favorites.",
    "I have a sweet tooth for French pastries - croissants, éclairs, and macarons are the way to my heart.",
    "I love exploring new and innovative fusion dishes that blend different cuisines together.",
    "Tapas are the best way to eat - sharing small plates with friends and trying a little of everything is perfect.",
    "Seafood is my favorite! Whether it's lobster, shrimp, or oysters, I can't get enough.",
    "Greek food is always a winner for me - I love gyros, tzatziki, and everything feta.",
    "A good burger, fries, and a milkshake is my go-to meal for when I want to treat myself.",
    "Korean BBQ is my favorite dining experience - grilling the meat right at the table is so much fun!",
    "I love Middle Eastern cuisine, especially the rich, flavorful stews and kebabs."
]

    # counter = 0
    # for name, bio, preferences, gender in profiles:
    #     upsertDataChooseNameSpace(0, bio, name, 'f' if gender == "Female" else 'm')
    #     upsertDataChooseNameSpace(1, preferences, name, 'f' if gender == "Female" else 'm')
    #     upsertDataChooseNameSpace(2, food_desc[counter], name, 'f' if gender == "Female" else 'm')
    #     counter += 1

    
    # counter = 0
    # for name, bio, preferences, gender in profiles:
        
    #     pushDataToRealtimeFBDB({
    #         'name': name,
    #         'bio': bio,
    #         'preferences': preferences,
    #         'gender': gender,
    #         'cusine-preferences': food_desc[counter]
    #     })
    #     counter += 1

    ...