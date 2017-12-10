package edu.sau.vtys.paylasim.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "Kullanicilar", schema = "public")
@Data
public class Takip {

  @Id
  private String takip_id;

  @ManyToOne
  private Kullanici takip_edilen;

  @ManyToOne
  private Kullanici takip_eden;
}
