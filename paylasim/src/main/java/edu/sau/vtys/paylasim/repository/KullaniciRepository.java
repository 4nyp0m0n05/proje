package edu.sau.vtys.paylasim.repository;

import edu.sau.vtys.paylasim.domain.Kullanici;
import javax.transaction.Transactional;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface KullaniciRepository extends CrudRepository<Kullanici, Integer> {

}
