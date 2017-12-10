package edu.sau.vtys.paylasim.repository;

import edu.sau.vtys.paylasim.domain.Kullanici;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public class KullaniciDao {

  @Autowired
  private EntityManager entityManager;

  public List<Kullanici> getAll() {
    Query nativeQuery = entityManager.createNativeQuery("select * from \"Kullanicilar\"", Kullanici.class);
    List resultList = nativeQuery.getResultList();
    return resultList;

  }

}
