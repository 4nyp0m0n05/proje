package edu.sau.vtys.paylasim.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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

  @OneToOne(mappedBy = "paylasim", fetch = FetchType.EAGER)
  private Okunma okunma;

  @ManyToOne
  @JoinColumn(name = "kull_id")
  private Kullanici kullanici;
}
