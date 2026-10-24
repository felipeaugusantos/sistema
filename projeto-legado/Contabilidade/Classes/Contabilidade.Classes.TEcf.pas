unit Contabilidade.Classes.TEcf;

interface

type
  TInfoECF = class
  private
    Fblc : string ;
    Freg : string ;
  public
    property blc : string read Fblc write Fblc ;
    property reg : string read Freg write Freg ;
  end;

implementation

end.
