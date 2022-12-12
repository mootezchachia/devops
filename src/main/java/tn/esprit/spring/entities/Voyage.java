package tn.esprit.spring.entities;





import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
public class Voyage  implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idVoyage;


	private long  codeVoyage;
	
	@Enumerated(EnumType.STRING)
	private Ville gareDepart;
	
	
	@Enumerated(EnumType.STRING)
	private Ville gareArrivee;
	
	
	@Temporal(TemporalType.DATE)
	private Date dateDepart;
	@Temporal(TemporalType.DATE)
	private Date dateArrivee;
	
	private double heureDepart;
	
	private double heureArrivee;
	
	@ManyToOne
	Train train;
	
	
	@ManyToMany
    public List<Voyageur> mesVoyageurs;


	public long getCodeVoyage() {
		return codeVoyage;
	}


	public void setCodeVoyage(long codeVoyage) {
		this.codeVoyage = codeVoyage;
	}


	public Long getIdVoyage() {
		return idVoyage;
	}


	public void setIdVoyage(Long idVoyage) {
		this.idVoyage = idVoyage;
	}


	public Ville getGareDepart() {
		return gareDepart;
	}


	public void setGareDepart(Ville gareDepart) {
		this.gareDepart = gareDepart;
	}


	public Ville getGareArrivee() {
		return gareArrivee;
	}


	public void setGareArrivee(Ville gareArrivee) {
		this.gareArrivee = gareArrivee;
	}


	public Date getDateDepart() {
		return dateDepart;
	}


	public void setDateDepart(Date dateDepart) {
		this.dateDepart = dateDepart;
	}


	public Date getDateArrivee() {
		return dateArrivee;
	}


	public void setDateArrivee(Date dateArrivee) {
		this.dateArrivee = dateArrivee;
	}


	public double getHeureDepart() {
		return heureDepart;
	}


	public void setHeureDepart(double heureDepart) {
		this.heureDepart = heureDepart;
	}


	public double getHeureArrivee() {
		return heureArrivee;
	}


	public void setHeureArrivee(double heureArrivee) {
		this.heureArrivee = heureArrivee;
	}


	public Train getTrain() {
		return train;
	}


	public void setTrain(Train train) {
		this.train = train;
	}


	public List<Voyageur> getMesVoyageurs() {
		return mesVoyageurs;
	}


	public void setMesVoyageurs(List<Voyageur> mesVoyageurs) {
		this.mesVoyageurs = mesVoyageurs;
	}


	public Voyage(long codeVoyage,Ville gareDepart,Ville gareArrivee,double heureDepart,double heureArrivee) {

this.idVoyage = idVoyage;
this.codeVoyage = codeVoyage;
this.gareDepart = gareDepart;
this.gareArrivee = gareArrivee;
this.heureDepart = heureDepart;
this.heureArrivee = heureArrivee;
	}
	
	


    


	
	
}
