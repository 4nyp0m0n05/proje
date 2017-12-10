package edu.sau.vtys.paylasim.domain;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "Kull_tipi", schema = "public")
@Data
public class KullaniciTipi {

  @Id
  private Integer kull_tipi_id;


  private String kull_tipi;
}
