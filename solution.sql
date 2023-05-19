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