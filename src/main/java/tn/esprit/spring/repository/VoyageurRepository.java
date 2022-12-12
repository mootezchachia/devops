package tn.esprit.spring.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import tn.esprit.spring.entities.Voyageur;



@Repository
public interface VoyageurRepository extends CrudRepository<Voyageur, Long> {

}
