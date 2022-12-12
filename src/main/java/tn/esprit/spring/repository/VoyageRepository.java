package tn.esprit.spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import tn.esprit.spring.entities.Ville;
import tn.esprit.spring.entities.Voyage;

@Repository
public interface VoyageRepository extends CrudRepository<Voyage, Long> {

	//public Voyage findBygareDepart();
	
	@Query("select v from Voyage v where v.gareDepart=:ngdept and v.gareArrivee=:ngarr and v.heureDepart=:hdpt")
	List<Voyage>RechercheVoyage(@Param("ngdept")Ville nomGareDepart,@Param("ngarr") Ville nomGareArrive, @Param("hdpt")double heureDepart);
	
}
