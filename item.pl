% farming
item(potato_seed,farming).
item(carrot_seed,farming).
item(tomato_seed,farming).
item(rice_seed,farming).
item(potato,farming).
item(carrot,farming).
item(tomato,farming).
item(rice,farming).
% ranching
item(chicken,ranching).
item(sheep,ranching).
item(cow,ranching).
item(turkey,ranching).
item(egg,ranching).
item(wol,ranching).
item(milk,ranching).
% fishing
item(tuna,fishing).
item(nila,fishing).
item(lele,fishing).
item(gurame,fishing).
item(patin,fishing).
item(barracuda,fishing).
item(hiu,fishing).
item(pari,fishing).
% tool
item(bait,fishing).
item(fishing_rod,fishing).
item(good_rod,fishing).
item(rare_rod,fishing).
item(legend_rod,fishing).
item(shovel,farming).
item(good_fertilizer,farming).
item(best_fertilizer,farming).
item(instant_fertilizer,farming).

% yang bisa dibeli
% kalau dijual jadi 50% harga beli
buyable(potato_seed).
buyable(carrot_seed).
buyable(tomato_seed).
buyable(rice_seed).
buyable(chicken).
buyable(sheep).
buyable(cow).
buyable(turkey).
buyable(bait).
buyable(fishing_rod).
buyable(good_rod).
buyable(rare_rod).
buyable(legend_rod).
buyable(shovel).
buyable(good_fertilizer).
buyable(best_fertilizer).
buyable(instant_fertilizer).

% farming
itemPrice(potato_seed,40).
itemPrice(carrot_seed,60).
itemPrice(tomato_seed,50).
itemPrice(rice_seed,70).
itemPrice(potato,80).
itemPrice(carrot,120).
itemPrice(tomato,100).
itemPrice(rice,150).
% ranching
itemPrice(chicken,200).
itemPrice(sheep,1500).
itemPrice(cow,2000).
itemPrice(turkey,750).
itemPrice(egg,50).
itemPrice(wol,200).
itemPrice(milk,50).
% fishing
itemPrice(tuna,200).
itemPrice(nila,50).
itemPrice(lele,30).
itemPrice(gurame,80).
itemPrice(patin,80).
itemPrice(barracuda,7500).
itemPrice(hiu,10000).
itemPrice(pari,1000).
% tool
itemPrice(bait,5).
itemPrice(fishing_rod,500).
itemPrice(good_rod,2000).
itemPrice(rare_rod,4000).
itemPrice(legend_rod,10000).
itemPrice(shovel,300).
itemPrice(good_fertilizer,40).
itemPrice(best_fertilizer,70).
itemPrice(instant_fertilizer,100).


