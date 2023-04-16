enum AgeCohort { gentJove, gentGran }

class Age {
  final AgeCohort ageCohort;

  Age(this.ageCohort);

  String getAgeLabel() {
    switch (ageCohort) {
      case AgeCohort.gentJove:
        return 'jove';
      case AgeCohort.gentGran:
        return 'gran';
      default:
        throw Error;
    }
  }
}
