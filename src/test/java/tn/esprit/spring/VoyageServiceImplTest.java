package tn.esprit.spring;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import tn.esprit.spring.entities.Voyage;
import tn.esprit.spring.services.IVoyageService;

import static org.junit.Assert.assertNotNull;
import static tn.esprit.spring.entities.Ville.RADES;
import static tn.esprit.spring.entities.Ville.sfax;

@RunWith(SpringRunner.class)
@SpringBootTest
public class VoyageServiceImplTest {

    @Autowired
    IVoyageService VoyageService;

    @Test
    public Voyage testAddVoyage() {
        Voyage s = new Voyage(10L,RADES,sfax,10.0,11.0);
        VoyageService.ajouterVoyage(s);

        assertNotNull(s);
          return s;
    }


}
