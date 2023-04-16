enum AgeCohort { gentJove, gentGran }

class Age {
  final AgeCohort ageCohort;

  Age(this.ageCohort);

  String getAgeLabel() {
    switch (ageCohort) {
      case AgeCohort.gentJove:
        return 'Gent jove';
      case AgeCohort.gentGran:
        return 'Gent gran';
      default:
        throw Error;
    }
  }
}
