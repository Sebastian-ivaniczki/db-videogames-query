1- Selezionare tutte le software house americane (3)

select * 
from software_houses sh
where country like 'United States'; 

2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)

select * 
from players p 
where city like 'Rogahnland';

3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)

select * 
from players p 
where name like '%a'

4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)

select * 
from reviews r 
join players p 
on p.id = r.player_id 
where p.id = 800;

5- Contare quanti tornei ci sono stati nell'anno 2015' (9)

select count(*) 
from tournaments t 
where year = 2015;

6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)

select *
from awards a 
where description like '%facere%';

7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo lID) (287)

select distinct videogames.id 
from videogames
join category_videogame cv on cv.videogame_id = videogames.id
where cv.category_id in (2, 6);

8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)

select * 
from reviews r 
where rating in (2,4);

9- Selezionare tutti i dati dei videogiochi rilasciati nell anno 2020 (46)

select *
from videogames v 
where year(release_date) = 2020;

10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)

select distinct v.id
from videogames v 
join reviews r on v.id = r.videogame_id 
where rating = 5;

GROUP BY
1- Contare quante software house ci sono per ogni paese (3)

select count(*) 
from software_houses sh  
group by city;

2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l ID) (500)

select count(*)
from reviews r 
group by videogame_id;

3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l ID) (13)

select count(*)
from videogames v 
join pegi_label_videogame plv on v.id  = plv.pegi_label_id
group by  v.id;


4- Mostrare il numero di videogiochi rilasciati ogni anno (11)

select year(release_date) as anno, count(*) as num_videogames
from videogames
group by year(release_date);

5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l ID) (7)

select videogame_id
from reviews r 
group by videogame_id 
order by avg(rating) desc; 

JOIN

1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)

select distinct p.*
from players p 
join reviews r on p.id = r.player_id;

2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)

select distinct v.*
from videogames v
join tournament_videogame tv on tv.videogame_id = v.id
join tournaments t on t.id = tv.tournament_id
where t.`year` = 2016;

3- Mostrare le categorie di ogni videogioco (1718)

select v.*, c.name
from videogames v
join category_videogame cv on cv.videogame_id = v.id
join categories c on c.id = cv.category_id;

4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)

select distinct  sh.name 
from software_houses sh
join videogames v on sh.id = v.software_house_id 
where year(v.release_date) = 2020;

5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)

select sh.name, a.name
from software_houses sh
join videogames v on sh.id = v.software_house_id
join award_videogame av on av.videogame_id = v.id
join awards a on av.award_id = a.id;

6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)

select distinct v.name, c.name, pl.name, r.rating 
from videogames v
join reviews r on v.id = r.videogame_id
join pegi_label_videogame plv on plv.videogame_id = v.id
join pegi_labels pl on  pl.id = plv.pegi_label_id
join category_videogame cv on cv.videogame_id = v.id
join categories c on c.id = cv.category_id
where r.rating >= 4;

7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)

select distinct v.name
from videogames v 
join tournament_videogame tv on v.id = tv.videogame_id
join tournaments t on tv.tournament_id = t.id 
join player_tournament pt on t.id = pt.tournament_id 
join players p on pt.player_id = p.id
where p.name like "s%";

8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018' (36)

select t.city
from awards a 
join award_videogame av on a.id = av.award_id 
join videogames v on av.videogame_id = v.id 
join tournament_videogame tv on v.id = tv.videogame_id 
join tournaments t on tv.tournament_id = t.id
where a.name like "gioco dell'anno" and av.`year` = 2018;

9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)

select p.* 
from awards a 
join award_videogame av on a.id = av.award_id 
join videogames v on av.videogame_id = v.id 
join tournament_videogame tv on v.id = tv.videogame_id 
join tournaments t on tv.tournament_id = t.id
join player_tournament pt on t.id = pt.tournament_id 
join players p on pt.player_id = p.id
where a.name like "gioco più atteso" and av.`year` = 2018 and t.`year` = 2019;