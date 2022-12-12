package tn.esprit.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import tn.esprit.spring.entities.Voyageur;
import tn.esprit.spring.entities.Train;
import tn.esprit.spring.entities.Ville;
import tn.esprit.spring.entities.Voyage;
import tn.esprit.spring.repository.TrainRepository;
import tn.esprit.spring.services.IVoyageurService;
import tn.esprit.spring.services.ITrainService;
import tn.esprit.spring.services.IVoyageService;

@RestController
public class RestControllerVoyageur {


    @Autowired
    IVoyageService ivoyageservice;

    @Autowired
    ITrainService itrainservice;

    @Autowired
    IVoyageurService iVoyageurservice;

    //http://localhost:8083/SpringMVC/servlet/ajouterVoyage
    @PostMapping("/ajouterVoyage")
    @ResponseBody
    public void ajouterGare(@RequestBody Voyage voiture) {
        ivoyageservice.ajouterVoyage(voiture);
    }


    ////http://localhost:8083/SpringMVC/servlet/ajouterTrain
    @PostMapping("/ajouterTrain")
    @ResponseBody
    public void ajouterTrain(@RequestBody Train train) {
        itrainservice.ajouterTrain(train);
    }

    ////http://localhost:8083/SpringMVC/servlet/ajouterVoyageur
    @PostMapping("/ajouterVoyageur")
    @ResponseBody
    public void ajouterVoyageur(@RequestBody Voyageur Voyageur) {
        iVoyageurservice.ajouterVoyageur(Voyageur);
    }

    //http://localhost:8083/SpringMVC/servlet/affecterTrainAVoyage/{idtr}/{idvyg}
    @PutMapping(value = "/affecterTrainAVoyage/{idtr}/{idvyg}")
    //1 1  2 2 3 3 4 4
    public void affecterTrainAVoyage(@PathVariable("idtr") Long idTrain, @PathVariable("idvyg") Long idVoyage) {
        ivoyageservice.affecterTrainAVoyage(idTrain, idVoyage);
    }

//@PutMapping(value = "/affecterTrainAGare/{idtr}/{idgdpt}/{idgar}")
//public void affecterTrainAGare(@PathVariable("idtr")Long idTrain, @PathVariable("idgdpt")Long idGareDepart,@PathVariable("idgar") Long idGareArrivee)
//{
//	igareservice.affecterTrainAGare(idTrain,idGareDepart,idGareArrivee);
//
//}

    ////http://localhost:8083/SpringMVC/servlet/affecterTrainAVoyageur/1/EZZAHRA/7.45
    @PutMapping(value = "/affecterTrainAVoyageur/{idc}/{nomgdpt}/{nomgarr}/{heuredept}")
    public void affecterTainAVoyageur(@PathVariable("idc") Long idVoyageur, @PathVariable("nomgdpt") Ville nomGareDepart, @PathVariable("nomgarr") Ville nomGareArrivee, @PathVariable("heuredept") double heureDepart) {
        itrainservice.affecterTainAVoyageur(idVoyageur, nomGareDepart, nomGareArrivee, heureDepart);
    }

    //////URL : http://localhost:8083/SpringMVC/servlet/TrainPlacesLibres/TUNIS
    @GetMapping(value = "/TrainPlacesLibres/{nomgdpt}")
    public int TrainPlacesLibres(@PathVariable("nomgdpt") Ville nomGareDepart) {
        System.out.println("in controller" + nomGareDepart);
        return itrainservice.TrainPlacesLibres(nomGareDepart);
    }

    @RequestMapping(value = "/ListerTrainsIndirects/{nomgdpt}/{nomgarr}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Train> ListerTrainsIndirects(@PathVariable("nomgdpt") Ville nomGareDepart, @PathVariable("nomgarr") Ville nomGareArrivee) {
        return itrainservice.ListerTrainsIndirects(nomGareDepart, nomGareArrivee);
    }

    @PutMapping(value = "/DesaffecterVoyageursTrain/{nomgdpt}/{heuredept}")
    public void DesaffecterVoyageursTrain(@PathVariable("nomgdpt") Ville nomGareDepart, @PathVariable("nomgarr") Ville nomGareArrivee, @PathVariable("heuredept") double heureDepart) {
        itrainservice.DesaffecterVoyageursTrain(nomGareDepart, nomGareArrivee, heureDepart);
    }

}
