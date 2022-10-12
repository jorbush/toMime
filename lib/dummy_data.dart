import 'package:flutter/material.dart';

import './models/card.dart';
import './models/collection.dart';

final DUMMY_COLLECTIONS = [
  Collection(
    id: "1c",
    cards: cardsStartedPack,
    title: "Started Pack",
    description: "The initial collection available for all the users.",
    price: 0.0,
    imgPath: "assets/backgrounds/sky.png",
  ),
  Collection(
    id: "2c",
    cards: cardsWildAnimals,
    title: "Wild Animals",
    description:
        "The unique collection of animals that makes the game wildly enjoyable",
    price: 0.99,
    imgPath: "assets/backgrounds/sky1.png",
  ),
];

final cardsStartedPack = [
  CardItem(
    name: "air_ballon",
    imgPath: "assets/started_pack/air_ballon.png",
  ),
  CardItem(
    name: "bike",
    imgPath: "assets/started_pack/bike.png",
  ),
  CardItem(
    name: "camera",
    imgPath: "assets/started_pack/camera.png",
  ),
  CardItem(
    name: "car",
    imgPath: "assets/started_pack/car.png",
  ),
  CardItem(
    name: "chainsaw",
    imgPath: "assets/started_pack/chainsaw.png",
  ),
  CardItem(
    name: "chick",
    imgPath: "assets/started_pack/chick.png",
  ),
  CardItem(
    name: "chicken",
    imgPath: "assets/started_pack/chicken.png",
  ),
  CardItem(
    name: "coffee",
    imgPath: "assets/started_pack/coffee.png",
  ),
  CardItem(
    name: "drum",
    imgPath: "assets/started_pack/drum.png",
  ),
  CardItem(
    name: "football_ball",
    imgPath: "assets/started_pack/football_ball.png",
  ),
  CardItem(
    name: "ghost",
    imgPath: "assets/started_pack/ghost.png",
  ),
  CardItem(
    name: "guitar",
    imgPath: "assets/started_pack/guitar.png",
  ),
  CardItem(
    name: "hammer",
    imgPath: "assets/started_pack/hammer.png",
  ),
  CardItem(
    name: "house",
    imgPath: "assets/started_pack/house.png",
  ),
  CardItem(
    name: "pencil",
    imgPath: "assets/started_pack/pencil.png",
  ),
  CardItem(
    name: "plane",
    imgPath: "assets/started_pack/plane.png",
  ),
  CardItem(
    name: "rat",
    imgPath: "assets/started_pack/rat.png",
  ),
  CardItem(
    name: "sheep",
    imgPath: "assets/started_pack/sheep.png",
  ),
  CardItem(
    name: "tv",
    imgPath: "assets/started_pack/tv.png",
  ),
  CardItem(
    name: "vintage_phone",
    imgPath: "assets/started_pack/vintage_phone.png",
  ),
];

final cardsWildAnimals = [
  CardItem(
    name: "bear",
    imgPath: "assets/wild_animals/bear.png",
  ),
  CardItem(
    name: "bird",
    imgPath: "assets/wild_animals/bird.png",
  ),
  CardItem(
    name: "cat",
    imgPath: "assets/wild_animals/cat.png",
  ),
  CardItem(
    name: "cock",
    imgPath: "assets/wild_animals/cock.png",
  ),
  CardItem(
    name: "cow",
    imgPath: "assets/wild_animals/cow.png",
  ),
  CardItem(
    name: "dog",
    imgPath: "assets/wild_animals/dog.png",
  ),
  CardItem(
    name: "donkey",
    imgPath: "assets/wild_animals/donkey.png",
  ),
  CardItem(
    name: "duck",
    imgPath: "assets/wild_animals/duck.png",
  ),
  CardItem(
    name: "elephant",
    imgPath: "assets/wild_animals/elephant.png",
  ),
  CardItem(
    name: "fish",
    imgPath: "assets/wild_animals/fish.png",
  ),
  CardItem(
    name: "frog",
    imgPath: "assets/wild_animals/frog.png",
  ),
  CardItem(
    name: "goat",
    imgPath: "assets/wild_animals/goat.png",
  ),
  CardItem(
    name: "grasshopper",
    imgPath: "assets/wild_animals/grasshopper.png",
  ),
  CardItem(
    name: "gull",
    imgPath: "assets/wild_animals/gull.png",
  ),
  CardItem(
    name: "horse",
    imgPath: "assets/wild_animals/horse.png",
  ),
  CardItem(
    name: "lion",
    imgPath: "assets/wild_animals/lion.png",
  ),
  CardItem(
    name: "monkey",
    imgPath: "assets/wild_animals/monkey.png",
  ),
  CardItem(
    name: "owl",
    imgPath: "assets/wild_animals/owl.png",
  ),
  CardItem(
    name: "pig",
    imgPath: "assets/wild_animals/pig.png",
  ),
  CardItem(
    name: "snake",
    imgPath: "assets/wild_animals/snake.png",
  ),
];
