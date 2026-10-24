unit untGTinForTipos;

interface

Type
  TForMulTinDet = Record
    strFormul: String;
    fltQtdbas: Double;
  End;

  TBaixaPigmentos = Record
    strCodIte: String;
    fltQtdBaixa: Double;
    strTipComp: String;
  End;

  TForMulTinDetArray = Array[01..20] Of TForMulTinDet;
  TBaixaPigmentosArray = Array Of TBaixaPigmentos;

implementation

end.
