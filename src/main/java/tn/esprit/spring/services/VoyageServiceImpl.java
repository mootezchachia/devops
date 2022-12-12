package tn.esprit.spring.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tn.esprit.spring.entities.Train;
import tn.esprit.spring.entities.Voyage;
import tn.esprit.spring.repository.TrainRepository;
import tn.esprit.spring.repository.VoyageRepository;

import java.util.List;

@Service
public class VoyageServiceImpl implements IVoyageService {
    @Autowired
    VoyageRepository voyageRepository;
    @Autowired
    TrainRepository trainRepository;
    @Override
    public void ajouterVoyage(Voyage v) {
        voyageRepository.save(v);
    }

    @Override
    public void modifierVoyage(Voyage v) {
		voyageRepository.save(v);
    }


    public void affecterTrainAVoyage(Long idTrain, Long idVoyage) {

        Train t = trainRepository.findById(idTrain).get();
        Voyage v = voyageRepository.findById(idVoyage).get();
        v.setTrain(t);
        voyageRepository.save(v);
    }

    @Override
    public List<Voyage> recupererAll() {
        List<Voyage> list = (List<Voyage>) voyageRepository.findAll();
        return list;
    }

    @Override
    public Voyage recupererVoyageParId(Long idVoyage) {
        Voyage v = voyageRepository.findById(idVoyage).orElse(null);
        return v;
    }

    @Override
    public void supprimerVoyage(Voyage v) {
        //TODO method
    }

}
