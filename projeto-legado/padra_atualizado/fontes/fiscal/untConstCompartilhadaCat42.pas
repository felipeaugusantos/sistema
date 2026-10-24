unit untConstCompartilhadaCat42;

interface

  Type
  TTipoChamadaCat42 = (tcc42Tela1, tcc42Tela2, tcc42Tela3, tcc42Tela4);

  TCat42Variaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String[200];
    strEmpEst : String[200];
    strEmpCod : String[3];
    strClaVen : String[255];
    strClaDev : String[255];
    blnUsuarioLogadoUtilizaModoClassico : Boolean;
  End;

implementation

end.
