package edu.sau.vtys.paylasim.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "Paylasim", schema = "paylasim")
@Data
public class Paylasim {

  @Id
  private Integer paylasim_id;

  private String yazi;

  private Character ptipi;

  private String eski_yazi;

  @OneToOne(mappedBy = "paylasim")
  private Okunma okunma;
}
