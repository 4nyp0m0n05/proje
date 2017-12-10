package edu.sau.vtys.paylasim.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "Okunma", schema = "public")
@Data
public class Okunma {

  @Id
  private Integer okunma_id;

  private Integer sayac;

  @OneToOne
  @JoinColumn(name = "paylasim_id")
  private Paylasim paylasim;
}
