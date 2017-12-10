package edu.sau.vtys.paylasim.domain;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "Zaman", schema = "public")
@Data
public class Zaman {

  @Id
  private Integer zaman_id;

  private Date zaman;

}
