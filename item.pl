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
item(salmon,fishing).
item(nila,fishing).
item(lele,fishing).
item(gurame,fishing).
item(patin,fishing).
item(barracuda,fishing).
item(hiu,fishing).
item(pari,fishing).
% tool
item(bait,fishing).
item(normal_rod,fishing).
item(good_rod,fishing).
item(rare_rod,fishing).
item(legend_rod,fishing).
item(shovel,farming).
item(fertilizer,farming).
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
buyable(normal_rod).
buyable(good_rod).
buyable(rare_rod).
buyable(legend_rod).
buyable(shovel).
buyable(fertilizer).
buyable(good_fertilizer).
buyable(best_fertilizer).
buyable(instant_fertilizer).

% PERINGATAN
% SETIAP KALI MENGUBAH HARGA ITEM
% MAKA HARGA ITEM PADA INVENTORY MARKET
% JUGA HARUS DIPERBARUI (MANUAL GAN SORRY :V)

% farming
itemPrice(potato_seed,40).
itemPrice(tomato_seed,50).
itemPrice(carrot_seed,60).
itemPrice(rice_seed,70).
itemPrice(potato,80).
itemPrice(tomato,100).
itemPrice(carrot,120).
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
itemPrice(lele,30).
itemPrice(nila,50).
itemPrice(gurame,80).
itemPrice(patin,80).
itemPrice(salmon,175).
itemPrice(tuna,200).
itemPrice(barracuda,7500).
itemPrice(hiu,10000).
itemPrice(pari,1000).
% tool
itemPrice(bait,5).
itemPrice(normal_rod,500).
itemPrice(good_rod,2000).
itemPrice(rare_rod,4000).
itemPrice(legend_rod,10000).
itemPrice(shovel,300).
itemPrice(fertilizer,20).
itemPrice(good_fertilizer,40).
itemPrice(best_fertilizer,70).
itemPrice(instant_fertilizer,100).

% level unclocked
unlockedLvl(carrot_seed, 3).
unlockedLvl(rice_seed, 7).
unlockedLvl(sheep, 3).
unlockedLvl(cow, 7).
unlockedLvl(rare_rod, 3).
unlockedLvl(legend_rod, 7).
unlockedLvl(best_fertilizer, 3).
unlockedLvl(instant_fertilizer, 7).