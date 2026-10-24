unit untImportaTintometricosTerceirosTabelas;

interface

type
  TImportaTintometricosTerceirosTabelasAbstract = Class
  public
    function fNomeTabela: String; virtual; abstract;
    function fSelect: String; virtual; abstract;
    function fCampoMD5: String; virtual; abstract;
    function fCampoCodIte: String; virtual; abstract;
    function fGetCodIteBaseImobiliaria(strMd5: String): String;
    function fGetSQLDadosTinta(strMd5Key: String): String;
    function fGetSelectConsultaPorMd5: String; virtual; abstract;
    function fWhereEmpresa(): String; Virtual;
  End;

  TImportaTintometricosTerceirosSUV = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
    function fWhereEmpresa(): String; Override;
  End;

  TImportaTintometricosTerceirosCIM = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
    function fWhereEmpresa(): String; Override;
  End;

  TImportaTintometricosTerceirosALV = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;


  TImportaTintometricosTerceirosFUT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosSAY = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosBAU = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosSHE = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosEUC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosREI = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosDAC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosPPG = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosBZA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosSKY = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosDUP = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosFAL = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosWAN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosLAZ = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosADV = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

   TImportaTintometricosTerceirosALE = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosAJT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosANJ = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosAJA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosBZC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosPFA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosGEN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosANN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosBEL = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosBZI = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosCAL = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5():String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosCIA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosDUX = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosFAR = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosGLO = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosGRA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosHYD = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5():String; Override;
  End;

  TImportaTintometricosTerceirosINT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosIQU = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosJOT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosKIL = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosLIK = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosLKS = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosLKC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMZA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMZI = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMZD = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMEG = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMON = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosNEX = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosPPX = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosQUA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosREC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosREN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosSPA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosDOX = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosSTA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosUNI = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosWEG = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosINK = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosSTW = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect() : String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosKRE = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosKIN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosBLT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMAX = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosSHW = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect(): String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosALK = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosALA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosCHR = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosADS = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosADT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosLEI = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosMAE = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosSIN = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosDCA = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosLUZ = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosPRT = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosAN2 = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;

  TImportaTintometricosTerceirosRS2 = Class(TImportaTintometricosTerceirosTabelasAbstract)
  public
    function fNomeTabela: String; override;
    function fSelect: String; override;
    function fCampoMD5: String; override;
    function fCampoCodIte: String; override;
    function fGetSelectConsultaPorMd5: String; override;
  End;


  TImportaTintometricosTerceirosLEC = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect() : String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosREP = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect() : String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;

  TImportaTintometricosTerceirosMIF = Class(TImportaTintometricosTerceirosTabelasAbstract)
  Public
    function fNomeTabela(): String; Override;
    function fSelect() : String; Override;
    function fCampoMD5(): String; Override;
    function fCampoCodIte(): String; Override;
    function fGetSelectConsultaPorMd5(): String; Override;
  End;


  TImportaTintometrico = Class
    class function fGetCodIteBaseImobiliaria(strIdePro, strMd5: String): String;
    class function fGetTipoImporta(strIdePro: String): TImportaTintometricosTerceirosTabelasAbstract;
    class function fGetSQLDadosTinta(strIdePro, strMd5Key: String): String;
    class function fGetSelectConsultaPorMd5(strIdePro: String): String;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, System.SysUtils;

{ TImportaTintometricosTerceirosSUV }

function TImportaTintometricosTerceirosSUV.fCampoCodIte: String;
begin
  Result := 'SUV_CODITE';
end;

function TImportaTintometricosTerceirosSUV.fCampoMD5: String;
begin
  Result := 'SUV_MD5KEY';
end;

function TImportaTintometricosTerceirosSUV.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   S.AUTOINCREM, ';
  Result := Result + '   S.SUV_REFERE, ';
  Result := Result + '   S.SUV_UNIDAD, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   ITE_REFERE, ';
  Result := Result + '   S.SUV_NOMCOR, ';
  Result := Result + '   S.SUV_R_G_B_, ';
  Result := Result + '   S.SUV_TONALI, ';
  Result := Result + '   S.SUV_CORNOM, ';
  Result := Result + '   S.SUV_DESCRI, ';
  Result := Result + '   S.SUV_CODBAS, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   S.SUV_CODFML, ';
  Result := Result + '   S.SUV_CODUNI, ';
  Result := Result + '   S.SUV_MD5KEY, ';
  Result := Result + '   SUV_FORM01, ';
  Result := Result + '   SUV_QTDB01, ';
  Result := Result + '   SUV_FORM02, ';
  Result := Result + '   SUV_QTDB02, ';
  Result := Result + '   SUV_FORM03, ';
  Result := Result + '   SUV_QTDB03, ';
  Result := Result + '   SUV_FORM04, ';
  Result := Result + '   SUV_QTDB04, ';
  Result := Result + '   SUV_FORM05, ';
  Result := Result + '   SUV_QTDB05, ';
  Result := Result + '   SUV_FORM06, ';
  Result := Result + '   SUV_QTDB06, ';
  Result := Result + '   SUV_FORM07, ';
  Result := Result + '   SUV_QTDB07, ';
  Result := Result + '   SUV_FORM08, ';
  Result := Result + '   SUV_QTDB08, ';
  Result := Result + '   SUV_FORM09, ';
  Result := Result + '   SUV_QTDB09, ';
  Result := Result + '   SUV_FORM10, ';
  Result := Result + '   SUV_QTDB10, ';
  Result := Result + '   SUV_FORM11, ';
  Result := Result + '   SUV_QTDB11, ';
  Result := Result + '   SUV_FORM12, ';
  Result := Result + '   SUV_QTDB12, ';
  Result := Result + '   SUV_FORM13, ';
  Result := Result + '   SUV_QTDB13, ';
  Result := Result + '   SUV_FORM14, ';
  Result := Result + '   SUV_QTDB14, ';
  Result := Result + '   SUV_FORM15, ';
  Result := Result + '   SUV_QTDB15, ';
  Result := Result + '   SUV_FORM16, ';
  Result := Result + '   SUV_QTDB16, ';
  Result := Result + '   SUV_FORM17, ';
  Result := Result + '   SUV_QTDB17, ';
  Result := Result + '   SUV_FORM18, ';
  Result := Result + '   SUV_QTDB18, ';
  Result := Result + '   SUV_FORM19, ';
  Result := Result + '   SUV_QTDB19, ';
  Result := Result + '   SUV_FORM20, ';
  Result := Result + '   SUV_QTDB20 ';
  Result := Result + ' FROM ';
  Result := Result + '   SUV_CADSUV S ';
  Result := Result + '   LEFT JOIN SUV_CADBAS B ';
  Result := Result + '     ON S.SUV_CODBAS = B.SUV_CODBAS ';
  Result := Result + '     AND S.SUV_CODFML = B.SUV_CODFML ';
  Result := Result + '     AND S.SUV_CODUNI = B.SUV_CODUNI ';
  Result := Result + '   LEFT JOIN CADITE I ';
  Result := Result + '     ON B.SUV_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"         ';
  Result := Result + ' WHERE SUV_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosSUV.fNomeTabela: String;
begin
  Result := 'SUV_CADSUV_SIT';
end;

function TImportaTintometricosTerceirosSUV.fSelect: String;
begin
  Result := '      SELECT SUV_CODEMP AS CODEMP, ';
  Result := Result + '    SUV_DESCRI AS DESCRI, ';
//  Result := Result + '    SUV_REFERE AS REFERE, ';
  Result := Result + '    IF(COALESCE(SUV_REFERE,"") <> "", SUV_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '    SUV_UNIDAD AS UNIDAD, ';
  Result := Result + '    SUV_CODFML AS CODFML, ';
  Result := Result + '    SUV_CODBAS AS CODBAS, ';
  Result := Result + '    SUV_NOMCOR AS NOMCOR, ';
  Result := Result + '    SUV_R_G_B_ AS R_G_B_, ';
  Result := Result + '    SUV_TONALI AS TONALI, ';
  Result := Result + '    SUV_CORNOM AS CORNOM, ';
  Result := Result + '    SUV_MD5KEY AS MD5KEY, ';
  Result := Result + '    SUV_CODITE AS CODITE, ';
  Result := Result + '    SUV_DESITE AS DESITE, ';
  Result := Result + '    SUV_PREVEN AS PREVEN  ';
end;

function TImportaTintometricosTerceirosSUV.fWhereEmpresa: String;
Var
  blnEmpresa: Boolean;
begin
  blnEmpresa := (fCfgSis('EXPEMP') = 'S');

  If Not blnEmpresa Then
    Exit('');

  Result := '';
  Result := Result + '  AND SUV_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

{ TImportaTintometricosTerceirosTabelasAbstract }

function TImportaTintometricosTerceirosTabelasAbstract.fGetCodIteBaseImobiliaria(
  strMd5: String): String;
  Var
    qryBusca : TUniQuery;
begin
  qryBusca := fCriaQuery;

  Try
    With qryBusca Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ' + fCampoCodIte );
      SQL.Add('  FROM ' + fNomeTabela );
      SQL.Add(' WHERE ' + fCampoMD5 + ' = :MD5 ');
      ParamByName('MD5').AsString := strMd5;
      Open;
      Result := FieldByName(fCampoCodIte).AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

function TImportaTintometricosTerceirosTabelasAbstract.fGetSQLDadosTinta(strMd5Key: String): String;
begin
  Result := '';
  Result := Result +    fSelect ;
  Result := Result + '   FROM ' + fNomeTabela;
  Result := Result + '   LEFT JOIN CADITE ';
  Result := Result + '     ON ITE_CODITE = '+ fCampoCodIte;
  Result := Result + '   WHERE ' + fCampoMD5 + ' = ' + QuotedStr(strMd5Key);
  Result := Result + ' ' + fWhereEmpresa;
end;

function TImportaTintometricosTerceirosTabelasAbstract.fWhereEmpresa: String;
begin
  Result := '';
end;

{ TImportaTintometricosTerceirosCIM }

function TImportaTintometricosTerceirosCIM.fCampoCodIte: String;
begin
  Result := 'COR_CODITE';
end;

function TImportaTintometricosTerceirosCIM.fCampoMD5: String;
begin
  Result := 'COR_MD5KEY';
end;

function TImportaTintometricosTerceirosCIM.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '    CORIMO_CADCOR.AUTOINCREM, ';
  Result := Result + '    COR_DESCRI, ';
  Result := Result + '    COR_CODIGO, ';
  Result := Result + '    COR_UNIDAD, ';
  Result := Result + '    COR_COLID2, ';
  Result := Result + '    COR_DESPRO, ';
  Result := Result + '    COR_CODBAS, ';
  Result := Result + '    COR_UNIVER, ';
  Result := Result + '    ITE_CODITE, ';
  Result := Result + '    ITE_DESITE, ';
  Result := Result + '    ITE_REFERE, ';
  Result := Result + '    COR_CODITE, ';
  Result := Result + '    COR_CODUNI, ';
  Result := Result + '    COR_CODEMB, ';
  Result := Result + '    COR_COLID1, ';
  Result := Result + '    COR_MD5KEY, ';
  Result := Result + '    COR_FORM01, ';
  Result := Result + '    COR_QTDC01, ';
  Result := Result + '    COR_FORM02, ';
  Result := Result + '    COR_QTDC02, ';
  Result := Result + '    COR_FORM03, ';
  Result := Result + '    COR_QTDC03, ';
  Result := Result + '    COR_FORM04, ';
  Result := Result + '    COR_QTDC04, ';
  Result := Result + '    COR_FORM05, ';
  Result := Result + '    COR_QTDC05, ';
  Result := Result + '    COR_FORM06, ';
  Result := Result + '    COR_QTDC06, ';
  Result := Result + '    COR_FORM07, ';
  Result := Result + '    COR_QTDC07, ';
  Result := Result + '    COR_FORM08, ';
  Result := Result + '    COR_QTDC08, ';
  Result := Result + '    COR_FORM09, ';
  Result := Result + '    COR_QTDC09, ';
  Result := Result + '    COR_FORM10, ';
  Result := Result + '    COR_QTDC10 ';
  Result := Result + '  FROM ';
  Result := Result + '    CORIMO_CADCOR ';
  Result := Result + '    LEFT JOIN CORIMO_CADBAS ';
  Result := Result + '      ON COR_CODBAS = BAS_BASE__ ';
  Result := Result + '      AND COR_DESPRO = BAS_DESCRI ';
  Result := Result + '      AND COR_CODUNI = BAS_UNIDAD ';
  Result := Result + '    LEFT JOIN CADITE ';
  Result := Result + '      ON BAS_CODITE = ITE_CODITE ';
  Result := Result + '  WHERE COR_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosCIM.fNomeTabela: String;
begin
  Result := 'CORIMO_CADCOR_SIT';
end;

function TImportaTintometricosTerceirosCIM.fSelect: String;
begin
  Result := '          SELECT COR_DESCRI AS DESCRI, ';
  Result := Result + '        COR_CODIGO AS CODIGO, ';
  Result := Result + '        COR_CODEMP AS CODEMP, ';
  Result := Result + '        COR_UNIDAD AS UNIDAD, ';
  Result := Result + '        COR_COLID2 AS NOMCOR, ';
  Result := Result + '        COR_DESPRO AS DESPRO, ';
  Result := Result + '        COR_CODBAS AS CODBAS, ';
  Result := Result + '        COR_UNIVER AS UNIVER, ';
  Result := Result + '        COR_CODEMB AS CODEMB, ';
  Result := Result + '        COR_COLID1 AS COLID1, ';
  Result := Result + '        COR_CODITE AS CODITE, ';
  Result := Result + '        COR_DESITE AS DESITE, ';
  Result := Result + '        IF(COALESCE(COR_REFERE,"") <> "", COR_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '        COR_MD5KEY AS MD5KEY, ';
  Result := Result + '        COR_PREVEN AS PREVEN  ';
end;

function TImportaTintometricosTerceirosCIM.fWhereEmpresa: String;
Var
  blnEmpresa: Boolean;
begin
  blnEmpresa := (fCfgSis('EXPEMP') = 'S');

  If Not blnEmpresa Then
    Exit('');

  Result := '';
  Result := Result + '  AND COR_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

{ TImportaTintometrico }

class function TImportaTintometrico.fGetCodIteBaseImobiliaria(strIdePro,
  strMd5: String): String;
  Var
    objImp : TImportaTintometricosTerceirosTabelasAbstract;
begin
  objImp := Nil;
  Try
    objImp := fGetTipoImporta(strIdePro);
    Result := objImp.fGetCodIteBaseImobiliaria(strMd5);
  Finally
    FreeAndNil(objImp);
  End;
end;

class function TImportaTintometrico.fGetSelectConsultaPorMd5(
  strIdePro: String): String;
  Var
    objImp : TImportaTintometricosTerceirosTabelasAbstract;
begin
  objImp := Nil;
  Try
    objImp := fGetTipoImporta(strIdePro);
    Result := objImp.fGetSelectConsultaPorMd5;
  Finally
    FreeAndNil(objImp);
  End;
end;

class function TImportaTintometrico.fGetSQLDadosTinta(strIdePro,
  strMd5Key: String): String;
  Var
    objImp : TImportaTintometricosTerceirosTabelasAbstract;
begin
  objImp := Nil;
  Try
    objImp := fGetTipoImporta(strIdePro);
    Result := objImp.fGetSQLDadosTinta(strMd5Key);
  Finally
    FreeAndNil(objImp);
  End;
end;

class function TImportaTintometrico.fGetTipoImporta(strIdePro: String): TImportaTintometricosTerceirosTabelasAbstract;
begin
  If strIdePro = 'SUV' Then
    Result := TImportaTintometricosTerceirosSUV.Create
  Else If strIdePro = 'CIM' Then
    Result := TImportaTintometricosTerceirosCIM.Create
  Else If strIdePro = 'FUT' Then
    Result := TImportaTintometricosTerceirosFUT.Create
  Else If strIdePro = 'SAY' Then
    Result := TImportaTintometricosTerceirosSAY.Create
  Else If strIdePro = 'BAU' Then
    Result := TImportaTintometricosTerceirosBAU.Create
  Else If strIdePro = 'SHE' Then
    Result := TImportaTintometricosTerceirosSHE.Create
  Else If strIdePro = 'EUC' Then
    Result := TImportaTintometricosTerceirosEUC.Create
  Else If strIdePro = 'REI' Then
    Result := TImportaTintometricosTerceirosREI.Create
  Else If strIdePro = 'DAC' Then
    Result := TImportaTintometricosTerceirosDAC.Create
  Else If strIdePro = 'PPG' Then
    Result := TImportaTintometricosTerceirosPPG.Create
  Else If strIdePro = 'BZA' Then
    Result := TImportaTintometricosTerceirosBZA.Create
  Else If strIdePro = 'SKY' Then
    Result := TImportaTintometricosTerceirosSKY.Create
  Else If strIdePro = 'LAZ' Then
    Result := TImportaTintometricosTerceirosLAZ.Create
  Else If strIdePro = 'MZA' Then
    Result := TImportaTintometricosTerceirosMZA.Create
  Else If strIdePro = 'MZI' Then
    Result := TImportaTintometricosTerceirosMZI.Create
  Else If strIdePro = 'LKS' Then
    Result := TImportaTintometricosTerceirosLKS.Create
  Else If strIdePro = 'BLT' Then
    Result := TImportaTintometricosTerceirosBLT.Create
  Else If strIdePro = 'ALE' Then
    Result := TImportaTintometricosTerceirosALE.Create
  Else If strIdePro = 'SHW' Then
    Result := TImportaTintometricosTerceirosSHW.Create
  Else If strIdePro = 'ALK' Then
    Result := TImportaTintometricosTerceirosALK.Create
  Else If strIdePro = 'JOT' Then
    Result := TImportaTintometricosTerceirosJOT.Create
  Else If strIdePro = 'CHR' Then
    Result := TImportaTintometricosTerceirosCHR.Create
  Else If strIdePro = 'ADS' Then
    Result := TImportaTintometricosTerceirosADS.Create
  Else If strIdePro = 'ADT' Then
    Result := TImportaTintometricosTerceirosADT.Create
  Else If strIdePro = 'LEI' Then
    Result := TImportaTintometricosTerceirosLEI.Create
  Else If strIdePro = 'PPX' Then
    Result := TImportaTintometricosTerceirosPPX.Create
  Else If strIdePro = 'MAE' Then
    Result := TImportaTintometricosTerceirosMAE.Create
  Else If strIdePro = 'SIN' Then
    Result := TImportaTintometricosTerceirosSIN.Create
  Else If strIdePro = 'DCA' Then
    Result := TImportaTintometricosTerceirosDCA.Create
  Else If strIdePro = 'LUZ' Then
    Result := TImportaTintometricosTerceirosLUZ.Create
  Else If strIdePro = 'BZC' Then
    Result := TImportaTintometricosTerceirosBZC.Create
  Else If strIdePro = 'STW' Then
    Result := TImportaTintometricosTerceirosSTW.Create
  Else If strIdePro = 'LEC' Then
    Result := TImportaTintometricosTerceirosLEC.Create
  Else If strIdePro = 'REP' Then
    Result := TImportaTintometricosTerceirosREP.Create
  Else If strIdePro = 'MIF' Then
    Result := TImportaTintometricosTerceirosMIF.Create
  Else If strIdePro = 'KIL' Then
    Result := TImportaTintometricosTerceirosKIL.Create
  Else If strIdePro = 'CIA' Then
    Result := TImportaTintometricosTerceirosCIA.Create
  Else If strIdePro = 'IQU' Then
    Result := TImportaTintometricosTerceirosIQU.Create
  Else If strIdePro = 'PRT' Then
    Result := TImportaTintometricosTerceirosPRT.Create
  Else If strIdePro = 'AN2' Then
    Result := TImportaTintometricosTerceirosAN2.Create
  Else If strIdePro = 'WCP' Then
    Result := TImportaTintometricosTerceirosWAN.Create
  Else If strIdePro = 'MZD' Then
    Result := TImportaTintometricosTerceirosMZD.Create
  Else If strIdePro = 'RS2' Then
    Result := TImportaTintometricosTerceirosRS2.Create
  Else If strIdePro = 'ALV' Then
    Result := TImportaTintometricosTerceirosALV.Create
  Else If strIdePro = 'PFA' Then
    Result := TImportaTintometricosTerceirosPFA.Create
  Else If strIdePro = 'ALA' Then
    Result := TImportaTintometricosTerceirosALA.Create
  Else if strIdePro = 'BZI' Then
    Result := TImportaTintometricosTerceirosBZI.Create
  Else
    Raise Exception.Create(Format('Tinta "%s" não suportada!', [strIdePro]));
end;

{ TImportaTintometricosTerceirosFUT }

function TImportaTintometricosTerceirosFUT.fCampoCodIte: String;
begin
  Result := 'FUT_CODITE';
end;

function TImportaTintometricosTerceirosFUT.fCampoMD5: String;
begin
  Result := 'FUT_MD5KEY';
end;

function TImportaTintometricosTerceirosFUT.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   FUT_CODEMP, ';
  Result := Result + '   FUT_DESCRI, ';
  Result := Result + '   FUT_REFERE, ';
  Result := Result + '   FUT_UNIDAD, ';
  Result := Result + '   FUT_PRODUT, ';
  Result := Result + '   FUT_SPRODU, ';
  Result := Result + '   FUT_CODBAS, ';
  Result := Result + '   FUT_RED___, ';
  Result := Result + '   FUT_GREEN_, ';
  Result := Result + '   FUT_BLUE__, ';
  Result := Result + '   FUT_FAMILI, ';
  Result := Result + '   FUT_MD5KEY, ';
  Result := Result + '   FUT_CADFUT.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   FUT_FORM01, ';
  Result := Result + '   FUT_QTDB01, ';
  Result := Result + '   FUT_FORM02, ';
  Result := Result + '   FUT_QTDB02, ';
  Result := Result + '   FUT_FORM03, ';
  Result := Result + '   FUT_QTDB03, ';
  Result := Result + '   FUT_FORM04, ';
  Result := Result + '   FUT_QTDB04, ';
  Result := Result + '   FUT_FORM05, ';
  Result := Result + '   FUT_QTDB05, ';
  Result := Result + '   FUT_FORM06, ';
  Result := Result + '   FUT_QTDB06, ';
  Result := Result + '   FUT_FORM07, ';
  Result := Result + '   FUT_QTDB07, ';
  Result := Result + '   FUT_FORM08, ';
  Result := Result + '   FUT_QTDB08, ';
  Result := Result + '   FUT_FORM09, ';
  Result := Result + '   FUT_QTDB09, ';
  Result := Result + '   FUT_FORM10, ';
  Result := Result + '   FUT_QTDB10, ';
  Result := Result + '   FUT_FORM11, ';
  Result := Result + '   FUT_QTDB11, ';
  Result := Result + '   FUT_FORM12, ';
  Result := Result + '   FUT_QTDB12, ';
  Result := Result + '   FUT_FORM13, ';
  Result := Result + '   FUT_QTDB13, ';
  Result := Result + '   FUT_FORM14, ';
  Result := Result + '   FUT_QTDB14, ';
  Result := Result + '   FUT_FORM15, ';
  Result := Result + '   FUT_QTDB15, ';
  Result := Result + '   FUT_FORM16, ';
  Result := Result + '   FUT_FORM17, ';
  Result := Result + '   FUT_FORM18, ';
  Result := Result + '   FUT_FORM19, ';
  Result := Result + '   FUT_FORM20, ';
  Result := Result + '   FUT_QTDB16, ';
  Result := Result + '   FUT_QTDB17, ';
  Result := Result + '   FUT_QTDB18, ';
  Result := Result + '   FUT_QTDB19, ';
  Result := Result + '   FUT_QTDB20  ';
  Result := Result + ' FROM FUT_CADFUT  ';
  Result := Result + '   INNER JOIN FUT_CADBAS  ';
  Result := Result + '     ON FUT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND FUT_UNIDAD = BAS_CODUNI ';
  Result := Result + '       AND FUT_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE  ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE FUT_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosFUT.fNomeTabela: String;
begin
  Result := 'FUT_CADFUT_SIT';
end;

function TImportaTintometricosTerceirosFUT.fSelect: String;
begin
  Result := '      SELECT FUT_CODEMP AS CODEMP, ';
  Result := Result + '    FUT_DESCRI AS DESCRI, ';
//  Result := Result + '    FUT_REFERE AS REFERE, ';
  Result := Result + '    IF(COALESCE(FUT_REFERE,"") <> "", FUT_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '    FUT_UNIDAD AS UNIDAD, ';
  Result := Result + '    FUT_PRODUT AS PRODUT, ';
  Result := Result + '    FUT_SPRODU AS NOMCOR, ';
  Result := Result + '    FUT_CODBAS AS CODBAS, ';
  Result := Result + '    FUT_RED___ AS R,      ';
  Result := Result + '    FUT_GREEN_ AS G,      ';
  Result := Result + '    FUT_BLUE__ AS B,      ';
  Result := Result + '    FUT_FAMILI AS FAMILI, ';
  Result := Result + '    FUT_MD5KEY AS MD5KEY, ';
  Result := Result + '    FUT_CODITE AS CODITE, ';
  Result := Result + '    FUT_DESITE AS DESITE, ';
  Result := Result + '    FUT_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosSAY }

function TImportaTintometricosTerceirosSAY.fCampoCodIte: String;
begin
  Result := 'SAY_CODITE';
end;

function TImportaTintometricosTerceirosSAY.fCampoMD5: String;
begin
  Result := 'SAY_MD5KEY';
end;

function TImportaTintometricosTerceirosSAY.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   SAY_BASE__, ';
  Result := Result + '   SAY_CODBAS, ';
  Result := Result + '   SAY_PRODUT, ';
  Result := Result + '   SAY_DESEMB, ';
  Result := Result + '   SAY_CODIGO, ';
  Result := Result + '   SAY_DESCRI, ';
  Result := Result + '   SAY_COMENT, ';
  Result := Result + '   SAY_MD5KEY, ';
  Result := Result + '   SAY_CADSAY.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   SAY_FORM01, ';
  Result := Result + '   SAY_QTDC01, ';
  Result := Result + '   SAY_FORM02, ';
  Result := Result + '   SAY_QTDC02, ';
  Result := Result + '   SAY_FORM03, ';
  Result := Result + '   SAY_QTDC03, ';
  Result := Result + '   SAY_FORM04, ';
  Result := Result + '   SAY_QTDC04, ';
  Result := Result + '   SAY_FORM05, ';
  Result := Result + '   SAY_QTDC05, ';
  Result := Result + '   SAY_FORM06, ';
  Result := Result + '   SAY_QTDC06, ';
  Result := Result + '   SAY_FORM07, ';
  Result := Result + '   SAY_QTDC07, ';
  Result := Result + '   SAY_FORM08, ';
  Result := Result + '   SAY_QTDC08, ';
  Result := Result + '   SAY_FORM09, ';
  Result := Result + '   SAY_QTDC09, ';
  Result := Result + '   SAY_FORM10, ';
  Result := Result + '   SAY_QTDC10, ';
  Result := Result + '   SAY_FORM11, ';
  Result := Result + '   SAY_QTDC11, ';
  Result := Result + '   SAY_FORM12, ';
  Result := Result + '   SAY_QTDC12, ';
  Result := Result + '   SAY_FORM13, ';
  Result := Result + '   SAY_QTDC13, ';
  Result := Result + '   SAY_FORM14, ';
  Result := Result + '   SAY_QTDC14, ';
  Result := Result + '   SAY_FORM15, ';
  Result := Result + '   SAY_QTDC15, ';
  Result := Result + '   SAY_FORM16, ';
  Result := Result + '   SAY_FORM17, ';
  Result := Result + '   SAY_FORM18, ';
  Result := Result + '   SAY_FORM19, ';
  Result := Result + '   SAY_FORM20, ';
  Result := Result + '   SAY_QTDC16, ';
  Result := Result + '   SAY_QTDC17, ';
  Result := Result + '   SAY_QTDC18, ';
  Result := Result + '   SAY_QTDC19, ';
  Result := Result + '   SAY_QTDC20  ';
  Result := Result + ' FROM SAY_CADSAY                  ';
  Result := Result + '   INNER JOIN SAY_CADBAS          ';
  Result := Result + '     ON SAY_BASE__ = BAS_BASE__   ';
  Result := Result + '      AND SAY_CODBAS = BAS_CODBAS ';
  Result := Result + '      AND SAY_PRODUT = BAS_PRODUT ';
  Result := Result + '      AND SAY_DESEMB = BAS_DESEMB ';
  Result := Result + '   INNER JOIN CADITE              ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE   ';
  Result := Result + '   INNER JOIN SAY_CADEMB          ';
  Result := Result + '     ON SAY_DESEMB = EMB_DESEMB   ';
  Result := Result + '   INNER JOIN CADUNI              ';
  Result := Result + '     ON EMB_CODUNI = UNI_CODUNI   ';
  Result := Result + ' WHERE SAY_MD5KEY = :MD5KEY       ';
end;

function TImportaTintometricosTerceirosSAY.fNomeTabela: String;
begin
  Result := 'SAY_CADSAY_SIT';
end;

function TImportaTintometricosTerceirosSAY.fSelect: String;
begin
  Result := '      SELECT SAY_CODEMP AS CODEMP, ';
  Result := Result + '    SAY_BASE__ AS BASE__, ';
  Result := Result + '    SAY_CODBAS AS CODBAS, ';
  Result := Result + '    SAY_PRODUT AS PRODUT, ';
  Result := Result + '    SAY_DESEMB AS DESEMB, ';
//  Result := Result + '    SAY_CODIGO AS REFERE, ';

  Result := Result + '    ITE_REFERE AS REFERE, ';
  Result := Result + '    SAY_DESCRI AS NOMCOR, ';
  Result := Result + '    SAY_COMENT AS COMENT, ';
  Result := Result + '    SAY_MD5KEY AS MD5KEY, ';
  Result := Result + '    SAY_CODITE AS CODITE, ';
  Result := Result + '    SAY_DESITE AS DESITE, ';
  Result := Result + '    SAY_DESITE AS DESCRI, ';
  Result := Result + '    SAY_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosBAU }

function TImportaTintometricosTerceirosBAU.fCampoCodIte: String;
begin
  Result := 'BAU_CODITE';
end;

function TImportaTintometricosTerceirosBAU.fCampoMD5: String;
begin
  Result := 'BAU_MD5KEY';
end;

function TImportaTintometricosTerceirosBAU.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   BAU_CODEMP, ';
  Result := Result + '   BAU_CODBAS, ';
  Result := Result + '   BAU_CODUNI, ';
  Result := Result + '   BAU_DESCRI, ';
  Result := Result + '   BAU_NOMCOR, ';
  Result := Result + '   BAU_PRODUT, ';
  Result := Result + '   BAU_UNIDAD, ';
  Result := Result + '   BAU_MD5KEY, ';
  Result := Result + '   S.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   BAU_FORM01, ';
  Result := Result + '   BAU_QTDB01, ';
  Result := Result + '   BAU_FORM02, ';
  Result := Result + '   BAU_QTDB02, ';
  Result := Result + '   BAU_FORM03, ';
  Result := Result + '   BAU_QTDB03, ';
  Result := Result + '   BAU_FORM04, ';
  Result := Result + '   BAU_QTDB04, ';
  Result := Result + '   BAU_FORM05, ';
  Result := Result + '   BAU_QTDB05, ';
  Result := Result + '   BAU_FORM06, ';
  Result := Result + '   BAU_QTDB06, ';
  Result := Result + '   BAU_FORM07, ';
  Result := Result + '   BAU_QTDB07, ';
  Result := Result + '   BAU_FORM08, ';
  Result := Result + '   BAU_QTDB08, ';
  Result := Result + '   BAU_FORM09, ';
  Result := Result + '   BAU_QTDB09, ';
  Result := Result + '   BAU_FORM10, ';
  Result := Result + '   BAU_QTDB10, ';
  Result := Result + '   BAU_FORM11, ';
  Result := Result + '   BAU_QTDB11, ';
  Result := Result + '   BAU_FORM12, ';
  Result := Result + '   BAU_QTDB12, ';
  Result := Result + '   BAU_FORM13, ';
  Result := Result + '   BAU_QTDB13, ';
  Result := Result + '   BAU_FORM14, ';
  Result := Result + '   BAU_QTDB14, ';
  Result := Result + '   BAU_FORM15, ';
  Result := Result + '   BAU_QTDB15, ';
  Result := Result + '   BAU_FORM16, ';
  Result := Result + '   BAU_FORM17, ';
  Result := Result + '   BAU_FORM18, ';
  Result := Result + '   BAU_FORM19, ';
  Result := Result + '   BAU_FORM20, ';
  Result := Result + '   BAU_QTDB16, ';
  Result := Result + '   BAU_QTDB17, ';
  Result := Result + '   BAU_QTDB18, ';
  Result := Result + '   BAU_QTDB19, ';
  Result := Result + '   BAU_QTDB20  ';
  Result := Result + ' FROM          ';
  Result := Result + '   BAU_CADBAU S                      ';
  Result := Result + '   INNER JOIN BAU_CADBAS B           ';
  Result := Result + '      ON S.BAU_CODBAS = B.BAS_CODBAS ';
  Result := Result + '     AND S.BAU_PRODUT = B.BAS_DESCRI ';
  Result := Result + '     AND UPPER(IFNULL(S.BAU_ATIVAD, ''S'')) = ''S''   ';
  Result := Result + '   INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';
  Result := Result + ' WHERE BAU_MD5KEY = :MD5KEY       ';
end;

function TImportaTintometricosTerceirosBAU.fNomeTabela: String;
begin
  Result := 'BAU_CADBAU_SIT';
end;

function TImportaTintometricosTerceirosBAU.fSelect: String;
begin
  Result := '     SELECT BAU_CODBAS AS CODBAS, ';
  Result := Result + '   BAU_CODUNI AS CODUNI, ';
  Result := Result + '   BAU_DESCRI AS DESCRI, ';
  Result := Result + '   BAU_NOMCOR AS NOMCOR, ';
//  Result := Result + '   BAU_PRODUT AS REFERE, ';
  Result := Result + '   ITE_REFERE AS REFERE, ';
  Result := Result + '   BAU_UNIDAD AS UNIDAD, ';
  Result := Result + '   BAU_MD5KEY AS MD5KEY, ';
  Result := Result + '   BAU_CODITE AS CODITE, ';
  Result := Result + '   BAU_DESITE AS DESITE, ';
  Result := Result + '   BAU_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosSHE }

function TImportaTintometricosTerceirosSHE.fCampoCodIte: String;
begin
  Result := 'SHE_CODITE';
end;

function TImportaTintometricosTerceirosSHE.fCampoMD5: String;
begin
  Result := 'SHE_MD5KEY';
end;

function TImportaTintometricosTerceirosSHE.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   SHE_CODEMP, ';
  Result := Result + '   SHE_DESCRI, ';
  Result := Result + '   SHE_CODIGO, ';
  Result := Result + '   SHE_CODIG2, ';
  Result := Result + '   SHE_UNIDAD, ';
  Result := Result + '   SHE_BASE__, ';
  Result := Result + '   SHE_PROKEY, ';
  Result := Result + '   SHE_SUBKEY, ';
  Result := Result + '   SHE_COMMEN, ';
  Result := Result + '   SHE_MD5KEY, ';
  Result := Result + '   S.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   SHE_FORM01, ';
  Result := Result + '   SHE_QTDB01, ';
  Result := Result + '   SHE_FORM02, ';
  Result := Result + '   SHE_QTDB02, ';
  Result := Result + '   SHE_FORM03, ';
  Result := Result + '   SHE_QTDB03, ';
  Result := Result + '   SHE_FORM04, ';
  Result := Result + '   SHE_QTDB04, ';
  Result := Result + '   SHE_FORM05, ';
  Result := Result + '   SHE_QTDB05, ';
  Result := Result + '   SHE_FORM06, ';
  Result := Result + '   SHE_QTDB06, ';
  Result := Result + '   SHE_FORM07, ';
  Result := Result + '   SHE_QTDB07, ';
  Result := Result + '   SHE_FORM08, ';
  Result := Result + '   SHE_QTDB08, ';
  Result := Result + '   SHE_FORM09, ';
  Result := Result + '   SHE_QTDB09, ';
  Result := Result + '   SHE_FORM10, ';
  Result := Result + '   SHE_QTDB10, ';
  Result := Result + '   SHE_FORM11, ';
  Result := Result + '   SHE_QTDB11, ';
  Result := Result + '   SHE_FORM12, ';
  Result := Result + '   SHE_QTDB12, ';
  Result := Result + '   SHE_FORM13, ';
  Result := Result + '   SHE_QTDB13, ';
  Result := Result + '   SHE_FORM14, ';
  Result := Result + '   SHE_QTDB14, ';
  Result := Result + '   SHE_FORM15, ';
  Result := Result + '   SHE_QTDB15, ';
  Result := Result + '   SHE_FORM16, ';
  Result := Result + '   SHE_FORM17, ';
  Result := Result + '   SHE_FORM18, ';
  Result := Result + '   SHE_FORM19, ';
  Result := Result + '   SHE_FORM20, ';
  Result := Result + '   SHE_QTDB16, ';
  Result := Result + '   SHE_QTDB17, ';
  Result := Result + '   SHE_QTDB18, ';
  Result := Result + '   SHE_QTDB19, ';
  Result := Result + '   SHE_QTDB20  ';
  Result := Result + ' FROM SHE_CADSHE S ';
  Result := Result + '   INNER JOIN SHE_CADBAS B ';
  Result := Result + '     ON SHE_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND SHE_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND SHE_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND SHE_UNIDAD = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE I ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE SHE_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosSHE.fNomeTabela: String;
begin
  Result := 'SHE_CADSHE_SIT';
end;

function TImportaTintometricosTerceirosSHE.fSelect: String;
begin
  Result := '     SELECT SHE_CODEMP AS CODEMP, ';
  Result := Result + '   SHE_DESCRI AS DESCRI, ';
//  Result := Result + '   SHE_CODIGO AS REFERE, ';
  Result := Result + '   ITE_REFERE AS REFERE, ';
  Result := Result + '   SHE_CODIG2 AS NOMCOR, ';
  Result := Result + '   SHE_UNIDAD AS UNIDAD, ';
  Result := Result + '   SHE_BASE__ AS BASE__, ';
  Result := Result + '   SHE_PROKEY AS PROKEY, ';
  Result := Result + '   SHE_SUBKEY AS SUBKEY, ';
  Result := Result + '   SHE_COMMEN AS COMMEN, ';
  Result := Result + '   SHE_MD5KEY AS MD5KEY, ';
  Result := Result + '   SHE_CODITE AS CODITE, ';
  Result := Result + '   SHE_DESITE AS DESITE, ';
  Result := Result + '   SHE_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosEUC }

function TImportaTintometricosTerceirosEUC.fCampoCodIte: String;
begin
  Result := 'EUC_CODITE';
end;

function TImportaTintometricosTerceirosEUC.fCampoMD5: String;
begin
  Result := 'EUC_MD5KEY';
end;

function TImportaTintometricosTerceirosEUC.fGetSelectConsultaPorMd5: String;

  function fCamMd5: String;
  begin
    Result := '';
    Result := Result + ' CONCAT(IFNULL(EUC_CODCOR, ""), ';
    Result := Result + '        IFNULL(EUC_DESCOR, ""), ';
    Result := Result + '        IFNULL(EUC_PRODUT, ""), ';
    Result := Result + '        IFNULL(EUC_DESBAS, ""), ';
    Result := Result + '        IFNULL(EUC_UNIDAD, ""), ';
    Result := Result + '        IFNULL(EUC_CODNFM, "")) ';
  end;

begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   EUC_CODEMP, ';
  Result := Result + '   EUC_CODCOR, ';
  Result := Result + '   EUC_DESCOR, ';
  Result := Result + '   EUC_PRODUT, ';
  Result := Result + '   EUC_DESBAS, ';
  Result := Result + '   EUC_UNIDAD, ';
  Result := Result + '   EUC_CODNFM, ';
  Result := Result + '   EUC_OBSCOR, ';
  Result := Result + fCamMd5 + ' AS EUC_MD5KEY, ';
  Result := Result + '   EUC_CADEUC.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   EUC_FORM01, ';
  Result := Result + '   EUC_QTDB01, ';
  Result := Result + '   EUC_FORM02, ';
  Result := Result + '   EUC_QTDB02, ';
  Result := Result + '   EUC_FORM03, ';
  Result := Result + '   EUC_QTDB03, ';
  Result := Result + '   EUC_FORM04, ';
  Result := Result + '   EUC_QTDB04, ';
  Result := Result + '   EUC_FORM05, ';
  Result := Result + '   EUC_QTDB05, ';
  Result := Result + '   EUC_FORM06, ';
  Result := Result + '   EUC_QTDB06  ';
  Result := Result + '  FROM   ';
  Result := Result + '  	EUC_CADEUC  ';
  Result := Result + '    INNER JOIN EUC_CADBAS ON EUC_PRODUT = BAS_PRODUT ';
  Result := Result + '  	                   	 AND EUC_DESBAS = BAS_DESCRI ';
  Result := Result + '  	                   	 AND EUC_UNIDAD = BAS_CODUNI ';
  Result := Result + '  	INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ' + fCamMd5 + ' = :MD5KEY ';
end;

function TImportaTintometricosTerceirosEUC.fNomeTabela: String;
begin
  Result := 'EUC_CADEUC_SIT';
end;

function TImportaTintometricosTerceirosEUC.fSelect: String;
begin
  Result := '     SELECT EUC_CODEMP AS CODEMP, ';
  Result := Result + '   EUC_CODCOR AS CODCOR, ';
  Result := Result + '   EUC_DESCOR AS NOMCOR, ';
//  Result := Result + '   EUC_PRODUT AS REFERE, ';
  Result := Result + '   ITE_REFERE AS REFERE, ';
  Result := Result + '   EUC_DESBAS AS DESBAS, ';
  Result := Result + '   EUC_UNIDAD AS UNIDAD, ';
  Result := Result + '   EUC_CODNFM AS CODNFM, ';
  Result := Result + '   EUC_OBSCOR AS OBSCOR, ';
  Result := Result + '   EUC_MD5KEY AS MD5KEY, ';
  Result := Result + '   EUC_CODITE AS CODITE, ';
  Result := Result + '   EUC_DESITE AS DESCRI, ';
  Result := Result + '   EUC_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosREI }

function TImportaTintometricosTerceirosREI.fCampoCodIte: String;
begin
  Result := 'REI_CODITE';
end;

function TImportaTintometricosTerceirosREI.fCampoMD5: String;
begin
  Result := 'REI_MD5KEY';
end;

function TImportaTintometricosTerceirosREI.fGetSelectConsultaPorMd5: String;
begin
  Result := Result + ' SELECT  ';
  Result := Result + '   REI_CODPRO, ';
  Result := Result + '   REI_DESCOR, ';
  Result := Result + '   REI_REFERE, ';
  Result := Result + '   REI_CODBAS, ';
  Result := Result + '   REI_DESCRI, ';
  Result := Result + '   REI_UNIDAD, ';
  Result := Result + '   REI_DTACAD, ';
  Result := Result + '   REI_MD5KEY, ';
  Result := Result + '   REI_CADREI.AUTOINCREM, ';
  Result := Result + '   I.ITE_CODITE, ';
  Result := Result + '   I.ITE_DESITE, ';
  Result := Result + '   REI_FORM01, ';
  Result := Result + '   REI_QTDC01, ';
  Result := Result + '   REI_FORM02, ';
  Result := Result + '   REI_QTDC02, ';
  Result := Result + '   REI_FORM03, ';
  Result := Result + '   REI_QTDC03, ';
  Result := Result + '   REI_FORM04, ';
  Result := Result + '   REI_QTDC04, ';
  Result := Result + '   REI_FORM05, ';
  Result := Result + '   REI_QTDC05, ';
  Result := Result + '   REI_FORM06, ';
  Result := Result + '   REI_QTDC06, ';
  Result := Result + '   REI_FORM07, ';
  Result := Result + '   REI_QTDC07, ';
  Result := Result + '   REI_FORM08, ';
  Result := Result + '   REI_QTDC08, ';
  Result := Result + '   REI_FORM09, ';
  Result := Result + '   REI_QTDC09, ';
  Result := Result + '   REI_FORM10, ';
  Result := Result + '   REI_QTDC10, ';
  Result := Result + '   REI_FORM11, ';
  Result := Result + '   REI_QTDC11, ';
  Result := Result + '   REI_FORM12, ';
  Result := Result + '   REI_QTDC12, ';
  Result := Result + '   REI_FORM13, ';
  Result := Result + '   REI_QTDC13, ';
  Result := Result + '   REI_FORM14, ';
  Result := Result + '   REI_QTDC14, ';
  Result := Result + '   REI_FORM15, ';
  Result := Result + '   REI_QTDC15  ';
  Result := Result + '  FROM REI_CADREI ';
  Result := Result + ' INNER JOIN REI_CADBAS ON BAS_CODBAS = REI_CODBAS ';
  Result := Result + '                      AND REI_UNIDAD = BAS_UNIDAD ';
  Result := Result + ' INNER JOIN CADITE I ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + ' WHERE REI_MD5KEY  = :MD5KEY ';
end;

function TImportaTintometricosTerceirosREI.fNomeTabela: String;
begin
  Result := 'REI_CADREI_SIT';
end;

function TImportaTintometricosTerceirosREI.fSelect: String;
begin
  Result := '     SELECT REI_CODEMP AS CODEMP, ';
  Result := Result + '   REI_CODPRO AS CODPRO, ';
  Result := Result + '   REI_DESCOR AS NOMCOR, ';
//  Result := Result + '   REI_REFERE AS REFERE, ';
  Result := Result + '   IF(COALESCE(REI_REFERE,"") <> "", REI_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '   REI_CODBAS AS CODBAS, ';
  Result := Result + '   REI_DESCRI AS DESCRI, ';
  Result := Result + '   REI_UNIDAD AS UNIDAD, ';
  Result := Result + '   REI_DTACAD AS DTACAD, ';
  Result := Result + '   REI_MD5KEY AS MD5KEY, ';
  Result := Result + '   REI_CODITE AS CODITE, ';
  Result := Result + '   REI_DESITE AS DESITE, ';
  Result := Result + '   REI_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosDAC }

function TImportaTintometricosTerceirosDAC.fCampoCodIte: String;
begin
  Result := 'DAC_CODITE';
end;

function TImportaTintometricosTerceirosDAC.fCampoMD5: String;
begin
  Result := 'DAC_MD5KEY';
end;

function TImportaTintometricosTerceirosDAC.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   D.DAC_CODEMP, ';
  Result := Result + '   DAC_DESCRI, ';
  Result := Result + '   DAC_REFERE, ';
  Result := Result + '   DAC_CODUNI, ';
  Result := Result + '   DAC_DESUNI, ';
  Result := Result + '   DAC_EMBALA, ';
  Result := Result + '   DAC_COLECA, ';
  Result := Result + '   DAC_CODCOR, ';
  Result := Result + '   DAC_PROCOD, ';
  Result := Result + '   DAC_CODBAS, ';
  Result := Result + '   DAC_CODFML, ';
  Result := Result + '   DAC_MD5KEY,  ';
  Result := Result + '   D.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   DAC_FORM01, ';
  Result := Result + '   DAC_QTDB01, ';
  Result := Result + '   DAC_FORM02, ';
  Result := Result + '   DAC_QTDB02, ';
  Result := Result + '   DAC_FORM03, ';
  Result := Result + '   DAC_QTDB03, ';
  Result := Result + '   DAC_FORM04, ';
  Result := Result + '   DAC_QTDB04, ';
  Result := Result + '   DAC_FORM05, ';
  Result := Result + '   DAC_QTDB05, ';
  Result := Result + '   DAC_FORM06, ';
  Result := Result + '   DAC_QTDB06, ';
  Result := Result + '   DAC_FORM07, ';
  Result := Result + '   DAC_QTDB07, ';
  Result := Result + '   DAC_FORM08, ';
  Result := Result + '   DAC_QTDB08, ';
  Result := Result + '   DAC_FORM09, ';
  Result := Result + '   DAC_QTDB09, ';
  Result := Result + '   DAC_FORM10, ';
  Result := Result + '   DAC_QTDB10, ';
  Result := Result + '   DAC_FORM11, ';
  Result := Result + '   DAC_QTDB11, ';
  Result := Result + '   DAC_FORM12, ';
  Result := Result + '   DAC_QTDB12, ';
  Result := Result + '   DAC_FORM13, ';
  Result := Result + '   DAC_QTDB13, ';
  Result := Result + '   DAC_FORM14, ';
  Result := Result + '   DAC_QTDB14, ';
  Result := Result + '   DAC_FORM15, ';
  Result := Result + '   DAC_QTDB15  ';
  Result := Result + '   FROM DAC_CADDAC D ';
  Result := Result + '  INNER JOIN DAC_UNIDAC U ON D.DAC_CODUNI = U.DAC_UNIAUT ';
  Result := Result + '  INNER JOIN DAC_CADBAS B ON D.DAC_CODFML = B.BAS_CODFML ';
  Result := Result + '	                       AND B.BAS_UNIDAD = U.DAC_UNIDAC ';
  Result := Result + '	                       AND B.BAS_BASE__ = D.DAC_CODBAS ';
  Result := Result + '  INNER JOIN CADITE I     ON B.BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '  WHERE DAC_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosDAC.fNomeTabela: String;
begin
  Result := 'DAC_CADDAC_SIT';
end;

function TImportaTintometricosTerceirosDAC.fSelect: String;
begin
  Result := '     SELECT DAC_CODEMP AS CODEMP, ';
  Result := Result + '   DAC_DESCRI AS DESCRI, ';
//  Result := Result + '   DAC_REFERE AS REFERE, ';
  Result := Result + '   IF(COALESCE(DAC_REFERE,"") <> "", DAC_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '   DAC_REFERE AS NOMCOR, ';
  Result := Result + '   DAC_CODUNI AS CODUNI, ';
  Result := Result + '   DAC_DESUNI AS DESUNI, ';
  Result := Result + '   DAC_EMBALA AS EMBALA, ';
  Result := Result + '   DAC_COLECA AS COLECA, ';
  Result := Result + '   DAC_CODCOR AS CODCOR, ';
  Result := Result + '   DAC_PROCOD AS PROCOD, ';
  Result := Result + '   DAC_CODBAS AS CODBAS, ';
  Result := Result + '   DAC_CODFML AS CODFML, ';
  Result := Result + '   DAC_MD5KEY AS MD5KEY, ';
  Result := Result + '   DAC_CODITE AS CODITE, ';
  Result := Result + '   DAC_DESITE AS DESITE, ';
  Result := Result + '   DAC_PREVEN AS PREVEN  ';
end;

{ TImportaTintometricosTerceirosPPG }

function TImportaTintometricosTerceirosPPG.fNomeTabela: String;
begin
  Result := 'PPG_CADPPG_SIT';
end;

function TImportaTintometricosTerceirosPPG.fSelect: String;
begin
  Result := '     SELECT PPG_DESCOR AS NOMCOR, ';
  Result := Result + '   PPG_CODCOR AS CODCOR, ';
  Result := Result + '   PPG_CODATC AS DESCRI, ';
  Result := Result + '   PPG_VARIAN AS VARIAN, ';
  Result := Result + '   PPG_REFERE AS REFERE, ';
  Result := Result + '   PPG_MARCA_ AS MARCA_, ';
  Result := Result + '   PPG_UTILIZ AS UTILIZ, ';
  Result := Result + '   PPG_SISTEM AS SISTEM, ';
  Result := Result + '   PPG_EFEFIN AS EFETIN, ';
  Result := Result + '   PPG_ORIGEM AS ORIGEM, ';
  Result := Result + '   PPG_PAISES AS PAISES, ';
  Result := Result + '   PPG_VEICUL AS VEICUL, ';
  Result := Result + '   PPG_MONTAD AS MONTAD, '; //descrição da montadora(PPG_CADMON)
  Result := Result + '   PPG_A_N_O_ AS A_N_O_, ';
  Result := Result + '   PPG_TIPO__ AS TIPO_,  ';
  Result := Result + '   PPG_MD5KEY AS MD5KEY, ';
  Result := Result + '   PPG_CODITE AS CODITE, '; //Produto para venda PPG

  //Campos referentes a preços concentrados de cada embalagem
  Result := Result + '   PPG_PRECLT AS PRECLT, ';
  Result := Result + '   PPG_PRECGL AS PRECGL, ';
  Result := Result + '   PPG_PRECLA AS PRECLA, ';
  Result := Result + '   PPG_PRECCP AS PRECCP, ';
  Result := Result + '   PPG_PRECSP AS PRECSP, ';
  Result := Result + '   PPG_PRECBD AS PRECBD, ';
  Result := Result + '   PPG_PRECTB AS PRECTB, ';

  //Campos referentes a preços diluidos de cada embalagem
  Result := Result + '   PPG_PREDLT AS PREDLT, ';
  Result := Result + '   PPG_PREDGL AS PREDGL, ';
  Result := Result + '   PPG_PREDLA AS PREDLA, ';
  Result := Result + '   PPG_PREDCP AS PREDCP, ';
  Result := Result + '   PPG_PREDSP AS PREDSP, ';
  Result := Result + '   PPG_PREDBD AS PREDBD, ';
  Result := Result + '   PPG_PREDTB AS PREDTB, ';

  //Campos referentes aos produtos de cada embalagem
  Result := Result + '   PPG_EMBALT AS EMBALT, ';
  Result := Result + '   PPG_EMBAGL AS EMBAGL, ';
  Result := Result + '   PPG_EMBALA AS EMBALA, ';
  Result := Result + '   PPG_EMBACP AS EMBACP, ';
  Result := Result + '   PPG_EMBASP AS EMBASP, ';
  Result := Result + '   PPG_EMBABD AS EMBABD, ';
  Result := Result + '   PPG_EMBATB AS EMBATB, ';

  //Campos referentes aos volumes de cada embalagem
  Result := Result + '   PPG_VOLULT AS VOLULT, ';
  Result := Result + '   PPG_VOLUGL AS VOLUGL, ';
  Result := Result + '   PPG_VOLULA AS VOLULA, ';
  Result := Result + '   PPG_VOLUCP AS VOLUCP, ';
  Result := Result + '   PPG_VOLUSP AS VOLUSP, ';
  Result := Result + '   PPG_VOLUBD AS VOLUBD, ';
  Result := Result + '   PPG_VOLUTB AS VOLUTB, ';

  //Campos referentes aos preços de cada embalagem
  Result := Result + '   PPG_PREELT AS PREELT, ';
  Result := Result + '   PPG_PREEGL AS PREEGL, ';
  Result := Result + '   PPG_PREELA AS PREELA, ';
  Result := Result + '   PPG_PREECP AS PREECP, ';
  Result := Result + '   PPG_PREESP AS PREESP, ';
  Result := Result + '   PPG_PREEBD AS PREEBD, ';
  Result := Result + '   PPG_PREETB AS PREETB, ';

  //Campos referentes aos tipos de cada embalagem
  Result := Result + '   PPG_TIPOLT AS TIPOLT, ';
  Result := Result + '   PPG_TIPOGL AS TIPOGL, ';
  Result := Result + '   PPG_TIPOLA AS TIPOLA, ';
  Result := Result + '   PPG_TIPOCP AS TIPOCP, ';
  Result := Result + '   PPG_TIPOSP AS TIPOSP, ';
  Result := Result + '   PPG_TIPOBD AS TIPOBD, ';
  Result := Result + '   PPG_TIPOTB AS TIPOTB  ';
end;

function TImportaTintometricosTerceirosPPG.fCampoMD5: String;
begin
  Result := 'PPG_MD5KEY';
end;

function TImportaTintometricosTerceirosPPG.fCampoCodIte: String;
begin
  Result := 'PPG_CODITE';
end;

function TImportaTintometricosTerceirosPPG.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';

  Result := Result + '     PPG_DESCOR,  ';
  Result := Result + '     PPG_CODCOR,  ';
  Result := Result + '     PPG_CODATC,  ';
  Result := Result + '     PPG_VARIAN,  ';
  Result := Result + '     PPG_REFERE,  ';
  Result := Result + '     PPG_MARCA_,  ';
  Result := Result + '     PPG_UTILIZ,  ';
  Result := Result + '     PPG_SISTEM,  ';
  Result := Result + '     PPG_EFEFIN,  ';
  Result := Result + '     PPG_ORIGEM,  ';
  Result := Result + '     PPG_PAISES,  ';
  Result := Result + '     PPG_VEICUL,  ';
  Result := Result + '     PPG_MONTAD,  ';
  Result := Result + '     PPG_A_N_O_,  ';
  Result := Result + '     PPG_TIPO__,  ';
  Result := Result + '     PPG_MD5KEY,  ';
  Result := Result + '     MON_DESCRI,  ';

  Result := Result + '     PPG_CODB01,  ';
  Result := Result + '     PPG_CODB02,  ';
  Result := Result + '     PPG_CODB03,  ';
  Result := Result + '     PPG_CODB04,  ';
  Result := Result + '     PPG_CODB05,  ';
  Result := Result + '     PPG_CODB06,  ';
  Result := Result + '     PPG_CODB07,  ';
  Result := Result + '     PPG_CODB08,  ';
  Result := Result + '     PPG_CODB09,  ';
  Result := Result + '     PPG_CODB10,  ';
  Result := Result + '     PPG_CODB11,  ';
  Result := Result + '     PPG_CODB12,  ';
  Result := Result + '     PPG_CODB13,  ';
  Result := Result + '     PPG_CODB14,  ';
  Result := Result + '     PPG_CODB15,  ';
  Result := Result + '     PPG_CODB16,  ';
  Result := Result + '     PPG_CODB17,  ';
  Result := Result + '     PPG_CODB18,  ';
  Result := Result + '     PPG_CODB19,  ';
  Result := Result + '     PPG_CODB20,  ';
  Result := Result + '     PPG_QTDB01,  ';
  Result := Result + '     PPG_QTDB02,  ';
  Result := Result + '     PPG_QTDB03,  ';
  Result := Result + '     PPG_QTDB04,  ';
  Result := Result + '     PPG_QTDB05,  ';
  Result := Result + '     PPG_QTDB06,  ';
  Result := Result + '     PPG_QTDB07,  ';
  Result := Result + '     PPG_QTDB08,  ';
  Result := Result + '     PPG_QTDB09,  ';
  Result := Result + '     PPG_QTDB10,  ';
  Result := Result + '     PPG_QTDB11,  ';
  Result := Result + '     PPG_QTDB12,  ';
  Result := Result + '     PPG_QTDB13,  ';
  Result := Result + '     PPG_QTDB14,  ';
  Result := Result + '     PPG_QTDB15,  ';
  Result := Result + '     PPG_QTDB16,  ';
  Result := Result + '     PPG_QTDB17,  ';
  Result := Result + '     PPG_QTDB18,  ';
  Result := Result + '     PPG_QTDB19,  ';
  Result := Result + '     PPG_QTDB20   ';

  Result := Result + ' FROM PPG_CADPPG  ';
  Result := Result + '   INNER JOIN PPG_CADBAS  ';
  Result := Result + '     ON PPG_CODB01 = BAS_CODBAS ';
  Result := Result + '   LEFT JOIN PPG_CADMON         ';
  Result := Result + '     ON PPG_MONTAD = MON_CODMON ';

  Result := Result + ' WHERE PPG_MD5KEY = :MD5KEY ';
end;

{ TImportaTintometricosTerceirosBZA }

function TImportaTintometricosTerceirosBZA.fCampoCodIte: String;
begin
  Result := 'BZA_CODITE';
end;

function TImportaTintometricosTerceirosBZA.fCampoMD5: String;
begin
  Result := 'BZA_MD5KEY';
end;

function TImportaTintometricosTerceirosBZA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BZA_MONTAD,             ';
  Result := Result + '    BZA_A_N_O_,             ';
  Result := Result + '    BZA_DESCRI,             ';
  Result := Result + '    BZA_CODUNI,             ';
  Result := Result + '    BZA_ARQTXT,             ';
  Result := Result + '    BZA_CODNFM,             ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    BZA_CODB' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    BZA_QTDB' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    BZA_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    BZA_CADBZA              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    BZA_MD5KEY = :MD5KEY    ';
end;

function TImportaTintometricosTerceirosBZA.fNomeTabela: String;
begin
  Result := 'BZA_CADBZA_SIT';
end;

function TImportaTintometricosTerceirosBZA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    BZA_MONTAD AS MONTAD,                 ';
  Result := Result + '    BZA_A_N_O_ AS A_N_O_,                 ';
  Result := Result + '    BZA_DESCRI AS DESCRI,                 ';
  Result := Result + '    BZA_DESCRI AS NOMCOR,                 ';
  Result := Result + '    BZA_CODUNI AS CODUNI,                 ';
  Result := Result + '    BZA_ARQTXT AS ARQTXT,                 ';
  Result := Result + '    BZA_CODNFM AS CODNFM,                 ';
  Result := Result + '    BZA_MD5KEY AS MD5KEY,                 ';
  Result := Result + '    ITE_REFERE AS REFERE,                 ';

  Result := Result + '    BZA_CODDIL AS CODDIL,                 ';
  Result := Result + '    BZA_PORDIL AS PORDIL,                 ';

  Result := Result + '    BZA_PRECLT AS PRECLT,                 ';
  Result := Result + '    BZA_PRECGL AS PRECGL,                 ';
  Result := Result + '    BZA_PRECLA AS PRECLA,                 ';
  Result := Result + '    BZA_PRECCP AS PRECCP,                 ';
  Result := Result + '    BZA_PRECSP AS PRECSP,                 ';

  Result := Result + '    BZA_PREDLT AS PREDLT,                 ';
  Result := Result + '    BZA_PREDGL AS PREDGL,                 ';
  Result := Result + '    BZA_PREDLA AS PREDLA,                 ';
  Result := Result + '    BZA_PREDCP AS PREDCP,                 ';
  Result := Result + '    BZA_PREDSP AS PREDSP,                 ';

  Result := Result + '    BZA_EMBALT AS EMBALT,                 ';
  Result := Result + '    BZA_EMBAGL AS EMBAGL,                 ';
  Result := Result + '    BZA_EMBALA AS EMBALA,                 ';
  Result := Result + '    BZA_EMBACP AS EMBACP,                 ';
  Result := Result + '    BZA_EMBASP AS EMBASP,                 ';

  Result := Result + '    BZA_VOLULT AS VOLULT,                 ';
  Result := Result + '    BZA_VOLUGL AS VOLUGL,                 ';
  Result := Result + '    BZA_VOLULA AS VOLULA,                 ';
  Result := Result + '    BZA_VOLUCP AS VOLUCP,                 ';
  Result := Result + '    BZA_VOLUSP AS VOLUSP,                 ';

  Result := Result + '    BZA_PREELT AS PREELT,                 ';
  Result := Result + '    BZA_PREEGL AS PREEGL,                 ';
  Result := Result + '    BZA_PREELA AS PREELA,                 ';
  Result := Result + '    BZA_PREECP AS PREECP,                 ';
  Result := Result + '    BZA_PREESP AS PREESP,                 ';

  Result := Result + '    BZA_TIPOLT AS TIPOLT,                 ';
  Result := Result + '    BZA_TIPOGL AS TIPOGL,                 ';
  Result := Result + '    BZA_TIPOLA AS TIPOLA,                 ';
  Result := Result + '    BZA_TIPOCP AS TIPOCP,                 ';
  Result := Result + '    BZA_TIPOSP AS TIPOSP                  ';
end;

{ TImportaTintometriosTerceirosSKY }

function TImportaTintometricosTerceirosSKY.fCampoCodIte: String;
begin
  Result := 'SKY_CODITE';
end;

function TImportaTintometricosTerceirosSKY.fCampoMD5: String;
begin
  Result := 'SKY_MD5KEY';
end;

function TImportaTintometricosTerceirosSKY.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                                  ';
  Result := Result + '    SKY_CODPRO,                           ';
  Result := Result + '    SKY_DESCRI,                           ';
  Result := Result + '    SKY_ANOFAB,                           ';
  Result := Result + '    SKY_CODUNI,                           ';
  Result := Result + '    SKY_ANUANC,                           ';
  Result := Result + '    SKY_CORPAI,                           ';
  Result := Result + '    SKY_NACIMP,                           ';
  Result := Result + '    SKY_CODMON,                           ';
  Result := Result + '    SKY_CONDIL,                           ';
  Result := Result + '    SKY_CODSGR,                           ';
  Result := Result + '    SKY_CODGRU,                           ';
  Result := Result + '    SKY_VERSAO,                           ';
  Result := Result + '    SKY_CODNFM,                           ';
  Result := Result + '    SKY_VARIAN,                           ';
  Result := Result + '    SKY_OBS001,                           ';


  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    SKY_FORM' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    SKY_QTDC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    SKY_QTDB' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    SKY_MD5KEY                            ';
  Result := Result + '  FROM                                    ';
  Result := Result + '    SKY_CADSKY                            ';
  Result := Result + '    LEFT JOIN SKY_CADMON ON SKY_CODMON = MON_CODMON  ';
  Result := Result + '    LEFT JOIN SKY_CADGRU ON SKY_CODGRU = GRU_CODGRU  ';
  Result := Result + '    LEFT JOIN SKY_CADSGR ON SKY_CODSGR = SGR_CODSGR  ';
  Result := Result + '  WHERE                                   ';
  Result := Result + '    SKY_MD5KEY = :MD5KEY                  ';
end;

function TImportaTintometricosTerceirosSKY.fNomeTabela: String;
begin
  Result := 'SKY_CADSKY_SIT';
end;

function TImportaTintometricosTerceirosSKY.fSelect: String;
begin
  Result := '';
  Result := Result +  ' SELECT                              ';
  Result := Result + '    SKY_CODPRO AS CODPRO,             ';
  Result := Result + '    SKY_DESCRI AS DESCRI,             ';
  Result := Result + '    SKY_ANOFAB AS ANOFAB,             ';
  Result := Result + '    SKY_CODUNI AS CODUNI,             ';
  Result := Result + '    SKY_ANUANC AS ANUANC,             ';
  Result := Result + '    SKY_CORPAI AS CORPAI,             ';
  Result := Result + '    SKY_NACIMP AS NACIMP,             ';
  Result := Result + '    SKY_CODMON AS CODMON,             ';
  Result := Result + '    SKY_CONDIL AS CONDIL,             ';
  Result := Result + '    SKY_CODSGR AS CODSGR,             ';
  Result := Result + '    SKY_CODGRU AS CODGRU,             ';
  Result := Result + '    SKY_VERSAO AS VERSAO,             ';
  Result := Result + '    SKY_CODNFM AS CODNFM,             ';
  Result := Result + '    SKY_VARIAN AS VARIAN,             ';
  Result := Result + '    SKY_OBS001 AS OBS001,             ';
  Result := Result + '    SKY_MD5KEY AS MD5KEY,             ';
  Result := Result + '    ITE_REFERE AS REFERE,             ';
  Result := Result + '    SKY_DESCRI AS NOMCOR,             ';

  Result := Result + '    SKY_CODITE AS CODITE,             ';
  Result := Result + '    SKY_CODDIL AS CODDIL,             ';
  Result := Result + '    SKY_PORDIL AS PORDIL,             ';

  Result := Result + '    SKY_PRECLT AS PRECLT,             ';
  Result := Result + '    SKY_PRECGL AS PRECGL,             ';
  Result := Result + '    SKY_PRECCP AS PRECCP,             ';
  Result := Result + '    SKY_PRECBD AS PRECBD,             ';

  Result := Result + '    SKY_PREDLT AS PREDLT,             ';
  Result := Result + '    SKY_PREDGL AS PREDGL,             ';
  Result := Result + '    SKY_PREDCP AS PREDCP,             ';
  Result := Result + '    SKY_PREDBD AS PREDBD,             ';

  Result := Result + '    SKY_EMBALT AS EMBALT,             ';
  Result := Result + '    SKY_EMBAGL AS EMBAGL,             ';
  Result := Result + '    SKY_EMBACP AS EMBACP,             ';
  Result := Result + '    SKY_EMBABD AS EMBABD,             ';

  Result := Result + '    SKY_VOLULT AS VOLULT,             ';
  Result := Result + '    SKY_VOLUGL AS VOLUGL,             ';
  Result := Result + '    SKY_VOLUCP AS VOLUCP,             ';
  Result := Result + '    SKY_VOLUBD AS VOLUBD,             ';

  Result := Result + '    SKY_PREELT AS PREELT,             ';
  Result := Result + '    SKY_PREEGL AS PREEGL,             ';
  Result := Result + '    SKY_PREECP AS PREECP,             ';
  Result := Result + '    SKY_PREEBD AS PREEBD,             ';

  Result := Result + '    SKY_TIPOLT AS TIPOLT,             ';
  Result := Result + '    SKY_TIPOGL AS TIPOGL,             ';
  Result := Result + '    SKY_TIPOCP AS TIPOCP,             ';
  Result := Result + '    SKY_TIPOBD AS TIPOBD              ';
end;

{ TImportaTintometriosTerceirosDUP }

function TImportaTintometricosTerceirosDUP.fCampoCodIte: String;
begin
  Result := 'DUP_CODITE';
end;

function TImportaTintometricosTerceirosDUP.fCampoMD5: String;
begin
  Result := 'DUP_MD5KEY';
end;

function TImportaTintometricosTerceirosDUP.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    DUP_CODDUP,                       ';
  Result := Result + '    DUP_CODOEM,                       ';
  Result := Result + '    DUP_LINHA_,                       ';
  Result := Result + '    DUP_QUALID,                       ';
  Result := Result + '    DUP_ALTERN,                       ';
  Result := Result + '    DUP_REGIAO,                       ';
  Result := Result + '    DUP_DESCRI,                       ';
  Result := Result + '    DUP_MONTAD,                       ';
  Result := Result + '    DUP_ANOCOR,                       ';
  Result := Result + '    DUP_LITRAG,                       ';
  Result := Result + '    DUP_CATALI,                       ';
  Result := Result + '    DUP_OBSERV,                       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    DUP_BASE' + fStrZero(intContador, 2) +  ',  ';
    Result := Result + '    DUP_QTDC' + fStrZero(intContador, 2) +  ',  ';
    Result := Result + '    DUP_QTDD' + fStrZero(intContador, 2) +  ',  ';
    Result := Result + '    DUP_TIPB' + fStrZero(intContador, 2) +  ',  ';
  End;

  Result := Result + '    DUP_MD5KEY                        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    DUP_CADDUP                        ';
  Result := Result + '  WHERE                               ';
  Result := Result + '    MD5KEY = :MD5KEY                  ';
end;

function TImportaTintometricosTerceirosDUP.fNomeTabela: String;
begin
  Result := 'DUP_CADDUP_SIT';
end;

function TImportaTintometricosTerceirosDUP.fSelect: String;
begin
  Result := '';
  Result := Result +  '  SELECT                                 ';
  Result := Result + '     DUP_CODDUP AS CODDUP,                ';
  Result := Result + '     DUP_CODOEM AS CODOEM,                ';
  Result := Result + '     DUP_LINHA_ AS LINHA_,                ';
  Result := Result + '     DUP_QUALID AS QUALID,                ';
  Result := Result + '     DUP_ALTERN AS ALTERN,                ';
  Result := Result + '     DUP_REGIAO AS REGIAO,                ';
  Result := Result + '     DUP_DESCRI AS DESCRI,                ';
  Result := Result + '     DUP_MONTAD AS MONTAD,                ';
  Result := Result + '     DUP_ANOCOR AS ANOCOR,                ';
  Result := Result + '     DUP_LITRAG AS LITRAG,                ';
  Result := Result + '     DUP_CATALI AS CATALI,                ';
  Result := Result + '     DUP_OBSERV AS OBSERV,                ';
  Result := Result + '     DUP_MD5KEY AS MD5KEY,                ';

  Result := Result + '     DUP_PRECLT AS PRECLT,                ';
  Result := Result + '     DUP_PRECGL AS PRECGL,                ';
  Result := Result + '     DUP_PRECLA AS PRECLA,                ';
  Result := Result + '     DUP_PRECCP AS PRECCP,                ';
  Result := Result + '     DUP_PRECSP AS PRECSP,                ';
  Result := Result + '     DUP_PRECBD AS PRECBD,                ';
  Result := Result + '     DUP_PRECTB AS PRECTB,                ';
  Result := Result + '     DUP_PRECSD AS PRECSD,                ';
  Result := Result + '     DUP_PRECPO AS PRECPO,                ';

  Result := Result + '     DUP_PREDLT AS PREDLT,                ';
  Result := Result + '     DUP_PREDGL AS PREDGL,                ';
  Result := Result + '     DUP_PREDLA AS PREDLA,                ';
  Result := Result + '     DUP_PREDCP AS PREDCP,                ';
  Result := Result + '     DUP_PREDSP AS PREDSP,                ';
  Result := Result + '     DUP_PREDBD AS PREDBD,                ';
  Result := Result + '     DUP_PREDTB AS PREDTB,                ';
  Result := Result + '     DUP_PREDSD AS PREDSD,                ';
  Result := Result + '     DUP_PREDPO AS PREDPO,                ';

  Result := Result + '     DUP_PCUCLT AS PCUCLT,                '; // Preço de Custo - Litro (Concentrado)
  Result := Result + '     DUP_PCUDLT AS PCUDLT,                '; // Preço de Custo - Litro (Diluido)

  Result := Result + '     DUP_PCUCGL AS PCUCGL,                '; // Preço de Custo - Galão (Concentrado)
  Result := Result + '     DUP_PCUDGL AS PCUDGL,                '; // Preço de Custo - Galão (Diluido)

  Result := Result + '     DUP_PCUCLA AS PCUCLA,                '; // Preço de Custo - Lata (Concentrado)
  Result := Result + '     DUP_PCUDLA AS PCUDLA,                '; // Preço de Custo - Lata (Diluido)

  Result := Result + '     DUP_PCUCCP AS PCUCCP,                '; // Preço de Custo - Copo (Concentrado)
  Result := Result + '     DUP_PCUDCP AS PCUDCP,                '; // Preço de Custo - Copo (Diluido)

  Result := Result + '     DUP_PCUCSP AS PCUCSP,                '; // Preço de Custo - Spray Sint. (Concentrado)
  Result := Result + '     DUP_PCUDSP AS PCUDSP,                '; // Preço de Custo - Spray Sint. (Diluido)

  Result := Result + '     DUP_PCUCBD AS PCUCBD,                '; // Preço de Custo - Balde (Concentrado)
  Result := Result + '     DUP_PCUDBD AS PCUDBD,                '; // Preço de Custo - Balde (Diluido)

  Result := Result + '     DUP_PCUCTB AS PCUCTB,                '; // Preço de Custo - Tambor (Concentrado)
  Result := Result + '     DUP_PCUDTB AS PCUDTB,                '; // Preço de Custo - Tambor (Diluido)

  Result := Result + '     DUP_PCUCSD AS PCUCSD,                '; // Preço de Custo - Spray Duco (Concentrado)
  Result := Result + '     DUP_PCUDSD AS PCUDSD,                '; // Preço de Custo - Spray Duco (Diluido)

  Result := Result + '     DUP_PCUCPO AS PCUCPO,                '; // Preço de Custo - Spray Poli. (Concentrado)
  Result := Result + '     DUP_PCUDPO AS PCUDPO,                '; // Preço de Custo - Spray Poli. (Diluido)

  Result := Result + '     DUP_PRCLT1 AS PRCLT1,                '; // Preço de Venda - Litro PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCLT2 AS PRCLT2,                '; // Preço de Venda - Litro PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCLT3 AS PRCLT3,                '; // Preço de Venda - Litro PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCLT4 AS PRCLT4,                '; // Preço de Venda - Litro PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCLT5 AS PRCLT5,                '; // Preço de Venda - Litro PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCLT6 AS PRCLT6,                '; // Preço de Venda - Litro PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCLT7 AS PRCLT7,                '; // Preço de Venda - Litro PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDLT1 AS PRDLT1,                '; // Preço de Venda - Litro PREVE1 (Diluido)
  Result := Result + '     DUP_PRDLT2 AS PRDLT2,                '; // Preço de Venda - Litro PREVE2 (Diluido)
  Result := Result + '     DUP_PRDLT3 AS PRDLT3,                '; // Preço de Venda - Litro PREVE3 (Diluido)
  Result := Result + '     DUP_PRDLT4 AS PRDLT4,                '; // Preço de Venda - Litro PREVE4 (Diluido)
  Result := Result + '     DUP_PRDLT5 AS PRDLT5,                '; // Preço de Venda - Litro PREVE5 (Diluido)
  Result := Result + '     DUP_PRDLT6 AS PRDLT6,                '; // Preço de Venda - Litro PREVE6 (Diluido)
  Result := Result + '     DUP_PRDLT7 AS PRDLT7,                '; // Preço de Venda - Litro PREVE7 (Diluido)

  Result := Result + '     DUP_PRCGL1 AS PRCGL1,                '; // Preço de Venda - Galão PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCGL2 AS PRCGL2,                '; // Preço de Venda - Galão PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCGL3 AS PRCGL3,                '; // Preço de Venda - Galão PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCGL4 AS PRCGL4,                '; // Preço de Venda - Galão PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCGL5 AS PRCGL5,                '; // Preço de Venda - Galão PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCGL6 AS PRCGL6,                '; // Preço de Venda - Galão PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCGL7 AS PRCGL7,                '; // Preço de Venda - Galão PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDGL1 AS PRDGL1,                '; // Preço de Venda - Galão PREVE1 (Diluido)
  Result := Result + '     DUP_PRDGL2 AS PRDGL2,                '; // Preço de Venda - Galão PREVE2 (Diluido)
  Result := Result + '     DUP_PRDGL3 AS PRDGL3,                '; // Preço de Venda - Galão PREVE3 (Diluido)
  Result := Result + '     DUP_PRDGL4 AS PRDGL4,                '; // Preço de Venda - Galão PREVE4 (Diluido)
  Result := Result + '     DUP_PRDGL5 AS PRDGL5,                '; // Preço de Venda - Galão PREVE5 (Diluido)
  Result := Result + '     DUP_PRDGL6 AS PRDGL6,                '; // Preço de Venda - Galão PREVE6 (Diluido)
  Result := Result + '     DUP_PRDGL7 AS PRDGL7,                '; // Preço de Venda - Galão PREVE7 (Diluido)

  Result := Result + '     DUP_PRCLA1 AS PRCLA1,                '; // Preço de Venda - Lata PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCLA2 AS PRCLA2,                '; // Preço de Venda - Lata PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCLA3 AS PRCLA3,                '; // Preço de Venda - Lata PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCLA4 AS PRCLA4,                '; // Preço de Venda - Lata PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCLA5 AS PRCLA5,                '; // Preço de Venda - Lata PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCLA6 AS PRCLA6,                '; // Preço de Venda - Lata PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCLA7 AS PRCLA7,                '; // Preço de Venda - Lata PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDLA1 AS PRDLA1,                '; // Preço de Venda - Lata PREVE1 (Diluido)
  Result := Result + '     DUP_PRDLA2 AS PRDLA2,                '; // Preço de Venda - Lata PREVE2 (Diluido)
  Result := Result + '     DUP_PRDLA3 AS PRDLA3,                '; // Preço de Venda - Lata PREVE3 (Diluido)
  Result := Result + '     DUP_PRDLA4 AS PRDLA4,                '; // Preço de Venda - Lata PREVE4 (Diluido)
  Result := Result + '     DUP_PRDLA5 AS PRDLA5,                '; // Preço de Venda - Lata PREVE5 (Diluido)
  Result := Result + '     DUP_PRDLA6 AS PRDLA6,                '; // Preço de Venda - Lata PREVE6 (Diluido)
  Result := Result + '     DUP_PRDLA7 AS PRDLA7,                '; // Preço de Venda - Lata PREVE7 (Diluido)

  Result := Result + '     DUP_PRCCP1 AS PRCCP1,                '; // Preço de Venda - Copo PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCCP2 AS PRCCP2,                '; // Preço de Venda - Copo PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCCP3 AS PRCCP3,                '; // Preço de Venda - Copo PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCCP4 AS PRCCP4,                '; // Preço de Venda - Copo PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCCP5 AS PRCCP5,                '; // Preço de Venda - Copo PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCCP6 AS PRCCP6,                '; // Preço de Venda - Copo PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCCP7 AS PRCCP7,                '; // Preço de Venda - Copo PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDCP1 AS PRDCP1,                '; // Preço de Venda - Copo PREVE1 (Diluido)
  Result := Result + '     DUP_PRDCP2 AS PRDCP2,                '; // Preço de Venda - Copo PREVE2 (Diluido)
  Result := Result + '     DUP_PRDCP3 AS PRDCP3,                '; // Preço de Venda - Copo PREVE3 (Diluido)
  Result := Result + '     DUP_PRDCP4 AS PRDCP4,                '; // Preço de Venda - Copo PREVE4 (Diluido)
  Result := Result + '     DUP_PRDCP5 AS PRDCP5,                '; // Preço de Venda - Copo PREVE5 (Diluido)
  Result := Result + '     DUP_PRDCP6 AS PRDCP6,                '; // Preço de Venda - Copo PREVE6 (Diluido)
  Result := Result + '     DUP_PRDCP7 AS PRDCP7,                '; // Preço de Venda - Copo PREVE7 (Diluido)

  Result := Result + '     DUP_PRCSP1 AS PRCSP1,                '; // Preço de Venda - Spray Sint. PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCSP2 AS PRCSP2,                '; // Preço de Venda - Spray Sint. PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCSP3 AS PRCSP3,                '; // Preço de Venda - Spray Sint. PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCSP4 AS PRCSP4,                '; // Preço de Venda - Spray Sint. PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCSP5 AS PRCSP5,                '; // Preço de Venda - Spray Sint. PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCSP6 AS PRCSP6,                '; // Preço de Venda - Spray Sint. PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCSP7 AS PRCSP7,                '; // Preço de Venda - Spray Sint. PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDSP1 AS PRDSP1,                '; // Preço de Venda - Spray Sint. PREVE1 (Diluido)
  Result := Result + '     DUP_PRDSP2 AS PRDSP2,                '; // Preço de Venda - Spray Sint. PREVE2 (Diluido)
  Result := Result + '     DUP_PRDSP3 AS PRDSP3,                '; // Preço de Venda - Spray Sint. PREVE3 (Diluido)
  Result := Result + '     DUP_PRDSP4 AS PRDSP4,                '; // Preço de Venda - Spray Sint. PREVE4 (Diluido)
  Result := Result + '     DUP_PRDSP5 AS PRDSP5,                '; // Preço de Venda - Spray Sint. PREVE5 (Diluido)
  Result := Result + '     DUP_PRDSP6 AS PRDSP6,                '; // Preço de Venda - Spray Sint. PREVE6 (Diluido)
  Result := Result + '     DUP_PRDSP7 AS PRDSP7,                '; // Preço de Venda - Spray Sint. PREVE7 (Diluido)

  Result := Result + '     DUP_PRCBD1 AS PRCBD1,                '; // Preço de Venda - Balde PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCBD2 AS PRCBD2,                '; // Preço de Venda - Balde PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCBD3 AS PRCBD3,                '; // Preço de Venda - Balde PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCBD4 AS PRCBD4,                '; // Preço de Venda - Balde PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCBD5 AS PRCBD5,                '; // Preço de Venda - Balde PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCBD6 AS PRCBD6,                '; // Preço de Venda - Balde PREVE6 (Concentrado)
  Result := Result + '     DUP_PRDBD7 AS PRCBD7,                '; // Preço de Venda - Balde PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDBD1 AS PRDBD1,                '; // Preço de Venda - Balde PREVE1 (Diluido)
  Result := Result + '     DUP_PRDBD2 AS PRDBD2,                '; // Preço de Venda - Balde PREVE2 (Diluido)
  Result := Result + '     DUP_PRDBD3 AS PRDBD3,                '; // Preço de Venda - Balde PREVE3 (Diluido)
  Result := Result + '     DUP_PRDBD4 AS PRDBD4,                '; // Preço de Venda - Balde PREVE4 (Diluido)
  Result := Result + '     DUP_PRDBD5 AS PRDBD5,                '; // Preço de Venda - Balde PREVE5 (Diluido)
  Result := Result + '     DUP_PRDBD6 AS PRDBD6,                '; // Preço de Venda - Balde PREVE6 (Diluido)
  Result := Result + '     DUP_PRDBD7 AS PRDBD7,                '; // Preço de Venda - Balde PREVE7 (Diluido)

  Result := Result + '     DUP_PRCTB1 AS PRCTB1,                '; // Preço de Venda - Tambor PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCTB2 AS PRCTB2,                '; // Preço de Venda - Tambor PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCTB3 AS PRCTB3,                '; // Preço de Venda - Tambor PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCTB4 AS PRCTB4,                '; // Preço de Venda - Tambor PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCTB5 AS PRCTB5,                '; // Preço de Venda - Tambor PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCTB6 AS PRCTB6,                '; // Preço de Venda - Tambor PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCTB7 AS PRCTB7,                '; // Preço de Venda - Tambor PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDTB1 AS PRDTB1,                '; // Preço de Venda - Tambor PREVE1 (Diluido)
  Result := Result + '     DUP_PRDTB2 AS PRDTB2,                '; // Preço de Venda - Tambor PREVE2 (Diluido)
  Result := Result + '     DUP_PRDTB3 AS PRDTB3,                '; // Preço de Venda - Tambor PREVE3 (Diluido)
  Result := Result + '     DUP_PRDTB4 AS PRDTB4,                '; // Preço de Venda - Tambor PREVE4 (Diluido)
  Result := Result + '     DUP_PRDTB5 AS PRDTB5,                '; // Preço de Venda - Tambor PREVE5 (Diluido)
  Result := Result + '     DUP_PRDTB6 AS PRDTB6,                '; // Preço de Venda - Tambor PREVE6 (Diluido)
  Result := Result + '     DUP_PRDTB7 AS PRDTB7,                '; // Preço de Venda - Tambor PREVE7 (Diluido)

  Result := Result + '     DUP_PRCSD1 AS PRCSD1,                '; // Preço de Venda - Spray Duco. PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCSD2 AS PRCSD2,                '; // Preço de Venda - Spray Duco. PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCSD3 AS PRCSD3,                '; // Preço de Venda - Spray Duco. PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCSD4 AS PRCSD4,                '; // Preço de Venda - Spray Duco. PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCSD5 AS PRCSD5,                '; // Preço de Venda - Spray Duco. PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCSD6 AS PRCSD6,                '; // Preço de Venda - Spray Duco. PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCSD7 AS PRCSD7,                '; // Preço de Venda - Spray Duco. PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDSD1 AS PRDSD1,                '; // Preço de Venda - Spray Duco. PREVE1 (Diluido)
  Result := Result + '     DUP_PRDSD2 AS PRDSD2,                '; // Preço de Venda - Spray Duco. PREVE2 (Diluido)
  Result := Result + '     DUP_PRDSD3 AS PRDSD3,                '; // Preço de Venda - Spray Duco. PREVE3 (Diluido)
  Result := Result + '     DUP_PRDSD4 AS PRDSD4,                '; // Preço de Venda - Spray Duco. PREVE4 (Diluido)
  Result := Result + '     DUP_PRDSD5 AS PRDSD5,                '; // Preço de Venda - Spray Duco. PREVE5 (Diluido)
  Result := Result + '     DUP_PRDSD6 AS PRDSD6,                '; // Preço de Venda - Spray Duco. PREVE6 (Diluido)
  Result := Result + '     DUP_PRDSD7 AS PRDSD7,                '; // Preço de Venda - Spray Duco. PREVE7 (Diluido)

  Result := Result + '     DUP_PRCPO1 AS PRCPO1,                '; // Preço de Venda - Spray Poli. PREVE1 (Concentrado)
  Result := Result + '     DUP_PRCPO2 AS PRCPO2,                '; // Preço de Venda - Spray Poli. PREVE2 (Concentrado)
  Result := Result + '     DUP_PRCPO3 AS PRCPO3,                '; // Preço de Venda - Spray Poli. PREVE3 (Concentrado)
  Result := Result + '     DUP_PRCPO4 AS PRCPO4,                '; // Preço de Venda - Spray Poli. PREVE4 (Concentrado)
  Result := Result + '     DUP_PRCPO5 AS PRCPO5,                '; // Preço de Venda - Spray Poli. PREVE5 (Concentrado)
  Result := Result + '     DUP_PRCPO6 AS PRCPO6,                '; // Preço de Venda - Spray Poli. PREVE6 (Concentrado)
  Result := Result + '     DUP_PRCPO7 AS PRCPO7,                '; // Preço de Venda - Spray Poli. PREVE7 (Concentrado)

  Result := Result + '     DUP_PRDPO1 AS PRDPO1,                '; // Preço de Venda - Spray Poli. PREVE1 (Diluido)
  Result := Result + '     DUP_PRDPO2 AS PRDPO2,                '; // Preço de Venda - Spray Poli. PREVE2 (Diluido)
  Result := Result + '     DUP_PRDPO3 AS PRDPO3,                '; // Preço de Venda - Spray Poli. PREVE3 (Diluido)
  Result := Result + '     DUP_PRDPO4 AS PRDPO4,                '; // Preço de Venda - Spray Poli. PREVE4 (Diluido)
  Result := Result + '     DUP_PRDPO5 AS PRDPO5,                '; // Preço de Venda - Spray Poli. PREVE5 (Diluido)
  Result := Result + '     DUP_PRDPO6 AS PRDPO6,                '; // Preço de Venda - Spray Poli. PREVE6 (Diluido)
  Result := Result + '     DUP_PRDPO7 AS PRDPO7,                '; // Preço de Venda - Spray Poli. PREVE7 (Diluido)


  Result := Result + '     DUP_EMBALT AS EMBALT,                ';
  Result := Result + '     DUP_EMBAGL AS EMBAGL,                ';
  Result := Result + '     DUP_EMBALA AS EMBALA,                ';
  Result := Result + '     DUP_EMBACP AS EMBACP,                ';
  Result := Result + '     DUP_EMBASP AS EMBASP,                ';
  Result := Result + '     DUP_EMBABD AS EMBABD,                ';
  Result := Result + '     DUP_EMBATB AS EMBATB,                ';
  Result := Result + '     DUP_EMBASD AS EMBASD,                ';
  Result := Result + '     DUP_EMBAPO AS EMBAPO,                ';

  Result := Result + '     DUP_VOLULT AS VOLULT,                ';
  Result := Result + '     DUP_VOLUGL AS VOLUGL,                ';
  Result := Result + '     DUP_VOLULA AS VOLULA,                ';
  Result := Result + '     DUP_VOLUCP AS VOLUCP,                ';
  Result := Result + '     DUP_VOLUSP AS VOLUSP,                ';
  Result := Result + '     DUP_VOLUBD AS VOLUBD,                ';
  Result := Result + '     DUP_VOLUTB AS VOLUTB,                ';
  Result := Result + '     DUP_VOLUSD AS VOLUSD,                ';
  Result := Result + '     DUP_VOLUPO AS VOLUPO,                ';

  Result := Result + '     DUP_PREELT AS PREELT,                ';
  Result := Result + '     DUP_PREEGL AS PREEGL,                ';
  Result := Result + '     DUP_PREELA AS PREELA,                ';
  Result := Result + '     DUP_PREECP AS PREECP,                ';
  Result := Result + '     DUP_PREESP AS PREESP,                ';
  Result := Result + '     DUP_PREEBD AS PREEBD,                ';
  Result := Result + '     DUP_PREETB AS PREETB,                ';
  Result := Result + '     DUP_PREESD AS PREESD,                ';
  Result := Result + '     DUP_PREEPO AS PREEPO,                ';

  Result := Result + '     DUP_TIPOLT AS TIPOLT,                ';
  Result := Result + '     DUP_TIPOGL AS TIPOGL,                ';
  Result := Result + '     DUP_TIPOLA AS TIPOLA,                ';
  Result := Result + '     DUP_TIPOCP AS TIPOCP,                ';
  Result := Result + '     DUP_TIPOSP AS TIPOSP,                ';
  Result := Result + '     DUP_TIPOBD AS TIPOBD,                ';
  Result := Result + '     DUP_TIPOTB AS TIPOTB,                ';
  Result := Result + '     DUP_TIPOSD AS TIPOSD,                ';
  Result := Result + '     DUP_TIPOPO AS TIPOPO                 ';
end;


{ TImportaTintometricosTerceirosFAL }

function TImportaTintometricosTerceirosFAL.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosFAL.fCampoMD5: String;
begin
  Result := 'FAL_MD5KEY';
end;

function TImportaTintometricosTerceirosFAL.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    FAL_CODIGO,                   ';
  Result := Result + '    FAL_DESCRI,                   ';
  Result := Result + '    FAL_LINHA_,                   ';
  Result := Result + '    FAL_DTACAD,                   ';
  Result := Result + '    FAL_CODUNI,                   ';
  Result := Result + '    FAL_BASE__,                   ';
  Result := Result + '    ITE_CODITE,                   ';
  Result := Result + '    ITE_DESITE,                   ';
  Result := Result + '    ITE_REFERE,                   ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    FAL_FORM' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    FAL_QTDC' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    FAL_MD5KEY                    ';
  Result := Result + '  FROM                            ';
  Result := Result + '    FAL_CADFAL                    ';
  Result := Result + '    INNER JOIN FAL_CADBAS B ON    ';
  Result := Result + '      FAL_BASE__ = B.BAS_DESCRI AND   ';
  Result := Result + '      FAL_CODUNI = B.BAS_CODUNI AND   ';
  Result := Result + '      FAL_LINHA_ = B.BAS_LINHA_       ';
  Result := Result + '    INNER JOIN CADITE I ON        ';
  Result := Result + '      B.BAS_CODITE = I.ITE_CODITE     ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    FAL_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosFAL.fNomeTabela: String;
begin
  Result := 'FAL_CADFAL_SIT';
end;

function TImportaTintometricosTerceirosFAL.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    FAL_BASE__ AS BASE__,         ';
  Result := Result + '    FAL_CODIGO AS CODIGO,         ';
  Result := Result + '    FAL_CODUNI AS CODUNI,         ';
  Result := Result + '    FAL_DESCRI AS DESCRI,         ';
  Result := Result + '    FAL_LINHA_ AS LINHA_,         ';
  Result := Result + '    FAL_CODITE AS CODITE,         ';
  Result := Result + '    FAL_DESITE AS DESITE,         ';
  Result := Result + '        IF(COALESCE(FAL_REFERE,"") <> "", FAL_REFERE, ITE_REFERE) AS REFERE, ';
  Result := Result + '    FAL_PREVEN AS PREVEN,         ';
  Result := Result + '    FAL_MD5KEY AS MD5KEY          ';
end;

{ TImportaTintometricosTerceirosWAN }

function TImportaTintometricosTerceirosWAN.fCampoCodIte: String;
begin
  Result := 'WAN_CODITE';
end;

function TImportaTintometricosTerceirosWAN.fCampoMD5: String;
begin
  Result := 'WAN_MD5KEY';
end;

function TImportaTintometricosTerceirosWAN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    WAN_LINHA_,                   ';
  Result := Result + '    WAN_NOMLIN,                   ';
  Result := Result + '    WAN_DESCRI,                   ';
  Result := Result + '    WAN_CODAKZ,                   ';
  Result := Result + '    WAN_ALTERN,                   ';
  Result := Result + '    WAN_MONTAD,                   ';
  Result := Result + '    WAN_ANOINI,                   ';
  Result := Result + '    WAN_ANOFIN,                   ';
  Result := Result + '    WAN_CATALI,                   ';
  Result := Result + '    WAN_CAMADA,                   ';
  Result := Result + '    WAN_CONCUS,                   ';
  Result := Result + '    WAN_CONVEN,                   ';
  Result := Result + '    WAN_DILCUS,                   ';
  Result := Result + '    WAN_DILVEN,                   ';
  Result := Result + '    WAN_4P1CUS,                   ';
  Result := Result + '    WAN_4P1VEN,                   ';
  Result := Result + '    WAN_VERCOR,                   ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    WAN_LINC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_CODC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QCON' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QD21' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_QD41' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    WAN_PORC' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    WAN_MD5KEY                    ';
  Result := Result + '  FROM                            ';
  Result := Result + '    WANPRO_CADWAN                 ';
  Result := Result + '  LEFT JOIN WANPRO_CODUNI ON      ';
  Result := Result + '    WANPRO_CODAKZ = WAN_CODAKZ AND  ';
  Result := Result + '    WANPRO_ALTERN = WAN_ALTERN AND  ';
  Result := Result + '    WANPRO_VERCOR = WAN_VERCOR  ';
  Result := Result + '  WHERE WAN_MD5KEY = :MD5KEY    ';
end;

function TImportaTintometricosTerceirosWAN.fNomeTabela: String;
begin
  Result := 'WANPRO_CADWAN_SIT';
end;

function TImportaTintometricosTerceirosWAN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    WAN_LINHA_ AS LINHA_,                   ';
  Result := Result + '    WAN_NOMLIN AS NOMLIN,                   ';
  Result := Result + '    WAN_DESCRI AS DESCRI,                   ';
  Result := Result + '    WAN_DESCRI AS NOMCOR,                   ';
  Result := Result + '    ITE_REFERE AS REFERE,                   ';
  Result := Result + '    WAN_CODAKZ AS CODAKZ,                   ';
  Result := Result + '    WAN_ALTERN AS ALTERN,                   ';
  Result := Result + '    WAN_MONTAD AS MONTAD,                   ';
  Result := Result + '    WAN_ANOINI AS ANOINI,                   ';
  Result := Result + '    WAN_ANOFIN AS ANOFIN,                   ';
  Result := Result + '    WAN_CATALI AS CATALI,                   ';
  Result := Result + '    WAN_CAMADA AS CAMADA,                   ';
  Result := Result + '    WAN_CONCUS AS CONCUS,                   ';
  Result := Result + '    WAN_CONVEN AS CONVEN,                   ';
  Result := Result + '    WAN_DILCUS AS DILCUS,                   ';
  Result := Result + '    WAN_DILVEN AS DILVEN,                   ';
  Result := Result + '    WAN_4P1CUS AS 4P1CUS,                   ';
  Result := Result + '    WAN_4P1VEN AS 4P1VEN,                   ';
  Result := Result + '    WAN_VERCOR AS VERCOR,                   ';

  Result := Result + '    WAN_CODITE AS CODITE,                   ';
  Result := Result + '    WAN_CODDIL AS CODDIL,                   ';
  Result := Result + '    WAN_PORDIL AS PORDIL,                   ';

  Result := Result + '    WAN_PRECLT AS PRECLT,                   ';
  Result := Result + '    WAN_PRECGL AS PRECGL,                   ';
  Result := Result + '    WAN_PRECLA AS PRECLA,                   ';
  Result := Result + '    WAN_PRECCP AS PRECCP,                   ';
  Result := Result + '    WAN_PRECSP AS PRECSP,                   ';
  Result := Result + '    WAN_PRECSS AS PRECSS,                   ';

  Result := Result + '    WAN_PRD2LT AS PRD2LT,                   ';
  Result := Result + '    WAN_PRD2GL AS PRD2GL,                   ';
  Result := Result + '    WAN_PRD2LA AS PRD2LA,                   ';
  Result := Result + '    WAN_PRD2CP AS PRD2CP,                   ';
  Result := Result + '    WAN_PRD2SP AS PRD2SP,                   ';
  Result := Result + '    WAN_PRD2SS AS PRD2SS,                   ';

  Result := Result + '    WAN_PRD4LT AS PRD4LT,                   ';
  Result := Result + '    WAN_PRD4GL AS PRD4GL,                   ';
  Result := Result + '    WAN_PRD4LA AS PRD4LA,                   ';
  Result := Result + '    WAN_PRD4CP AS PRD4CP,                   ';
  Result := Result + '    WAN_PRD4SP AS PRD4SP,                   ';
  Result := Result + '    WAN_PRD4SS AS PRD4SS,                   ';

  Result := Result + '    WAN_EMBALT AS EMBALT,                   ';
  Result := Result + '    WAN_EMBAGL AS EMBAGL,                   ';
  Result := Result + '    WAN_EMBALA AS EMBALA,                   ';
  Result := Result + '    WAN_EMBACP AS EMBACP,                   ';
  Result := Result + '    WAN_EMBASP AS EMBASP,                   ';
  Result := Result + '    WAN_EMBASS AS EMBASS,                   ';

  Result := Result + '    WAN_VOLULT AS VOLULT,                   ';
  Result := Result + '    WAN_VOLUGL AS VOLUGL,                   ';
  Result := Result + '    WAN_VOLULA AS VOLULA,                   ';
  Result := Result + '    WAN_VOLUCP AS VOLUCP,                   ';
  Result := Result + '    WAN_VOLUSP AS VOLUSP,                   ';
  Result := Result + '    WAN_VOLUSS AS VOLUSS,                   ';

  Result := Result + '    WAN_PREELT AS PREELT,                   ';
  Result := Result + '    WAN_PREEGL AS PREEGL,                   ';
  Result := Result + '    WAN_PREELA AS PREELA,                   ';
  Result := Result + '    WAN_PREECP AS PREECP,                   ';
  Result := Result + '    WAN_PREESP AS PREESP,                   ';
  Result := Result + '    WAN_PREESS AS PREESS,                   ';

  Result := Result + '    WAN_TIPOLT AS TIPOLT,                   ';
  Result := Result + '    WAN_TIPOGL AS TIPOGL,                   ';
  Result := Result + '    WAN_TIPOLA AS TIPOLA,                   ';
  Result := Result + '    WAN_TIPOCP AS TIPOCP,                   ';
  Result := Result + '    WAN_TIPOSP AS TIPOSP,                   ';
  Result := Result + '    WAN_TIPOSS AS TIPOSS                    ';
end;

{ TImportaTintometricosTerceirosLAZ }

function TImportaTintometricosTerceirosLAZ.fCampoCodIte: String;
begin
  Result := 'MIX_CODITE';
end;

function TImportaTintometricosTerceirosLAZ.fCampoMD5: String;
begin
  Result := 'MIX_MD5KEY';
end;

function TImportaTintometricosTerceirosLAZ.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := ' SELECT                ';
  Result := Result + '   MIX_CODIGO,          ';
  Result := Result + '   MIX_DESCRI,          ';
  Result := Result + '   MIX_REFERE,          ';
  Result := Result + '   MIX_MONTAD,          ';
  Result := Result + '   MIX_DTACAD,          ';
  Result := Result + '   MIX_A_N_O_,          ';
  Result := Result + '   MIX_UNIVER,          ';
  Result := Result + '   MIX_VOLCON,          ';
  Result := Result + '   MIX_VOLDIL,          ';
  Result := Result + '   MIX_VOLMID,          ';
  Result := Result + '   MIX_VOLMIC,          ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '   MIX_BASE' + fStrZero(intContador, 2) + ',  ';
    Result := Result + '   MIX_QTDC' + fStrZero(intContador, 2) + ',  ';
    Result := Result + '   MIX_QTDD' + fStrZero(intContador, 2) + ',  ';
  End;

  Result := Result + '   MIX_ACRMOB           ';
  Result := Result + ' FROM                   ';
  Result := Result + '   LAZ_CADMIX           ';
  Result := Result + ' WHERE                  ';
  Result := Result + '   MIX_CODIGO = :MD5KEY ';
end;

function TImportaTintometricosTerceirosLAZ.fNomeTabela: String;
begin
  Result := 'LAZ_CADMIX_SIT';
end;

function TImportaTintometricosTerceirosLAZ.fSelect: String;
begin
  Result := '';
  Result := Result +  '   SELECT                      ';
  Result := Result +  '     MIX_CODIGO AS CODIGO,               ';
  Result := Result +  '     MIX_DESCRI AS DESCRI,               ';
  Result := Result +  '     MIX_REFERE AS REFERE,               ';
  Result := Result +  '     MIX_MONTAD AS MONTAD,               ';
  Result := Result + '      MIX_DESCRI AS NOMCOR,               ';
  Result := Result +  '     MIX_A_N_O_ AS A_N_O_,               ';
  Result := Result +  '     MIX_UNIVER AS UNIVER,               ';
  Result := Result +  '     MIX_MD5KEY AS MD5KEY,               ';
  Result := Result +  '     MIX_CODITE AS CODITE,               ';
  Result := Result +  '     MIX_CODDIL AS CODDIL,               ';
  Result := Result +  '     MIX_PORDIL AS PORDIL,               ';
  Result := Result +  '     MIX_PRECLT AS PRECLT,               ';
  Result := Result +  '     MIX_PRECGL AS PRECGL,               ';
  Result := Result +  '     MIX_PRECLA AS PRECLA,               ';
  Result := Result +  '     MIX_PRECCP AS PRECCP,               ';
  Result := Result +  '     MIX_PRECSP AS PRECSP,               ';
  Result := Result +  '     MIX_PREDLT AS PREDLT,               ';
  Result := Result +  '     MIX_PREDGL AS PREDGL,               ';
  Result := Result +  '     MIX_PREDLA AS PREDLA,               ';
  Result := Result +  '     MIX_PREDCP AS PREDCP,               ';
  Result := Result +  '     MIX_PREDSP AS PREDSP,               ';
  Result := Result +  '     MIX_EMBALT AS EMBALT,               ';
  Result := Result +  '     MIX_EMBAGL AS EMBAGL,               ';
  Result := Result +  '     MIX_EMBALA AS EMBALA,               ';
  Result := Result +  '     MIX_EMBACP AS EMCACP,               ';
  Result := Result +  '     MIX_EMBASP AS EMBASP,               ';
  Result := Result +  '     MIX_VOLULT AS VOLULT,               ';
  Result := Result +  '     MIX_VOLUGL AS VOLUGL,               ';
  Result := Result +  '     MIX_VOLULA AS VOLULA,               ';
  Result := Result +  '     MIX_VOLUCP AS VOLUCP,               ';
  Result := Result +  '     MIX_VOLUSP AS VOLUSP,               ';
  Result := Result +  '     MIX_PREELT AS PREELT,               ';
  Result := Result +  '     MIX_PREEGL AS PREEGL,               ';
  Result := Result +  '     MIX_PREELA AS PREELA,               ';
  Result := Result +  '     MIX_PREECP AS PREECP,               ';
  Result := Result +  '     MIX_PREESP AS PREESP,               ';
  Result := Result +  '     MIX_TIPOLT AS TIPOLT,               ';
  Result := Result +  '     MIX_TIPOGL AS TIPOGL,               ';
  Result := Result +  '     MIX_TIPOLA AS TIPOLA,               ';
  Result := Result +  '     MIX_TIPOCP AS TIPOCP,               ';
  Result := Result +  '     MIX_TIPOSP AS TIPOSP                ';
end;

{ TImportaTintometricosTerceirosADV }

function TImportaTintometricosTerceirosADV.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosADV.fCampoMD5: String;
begin
  Result := 'ADV_MD5KEY';
end;

function TImportaTintometricosTerceirosADV.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ADV_DESCRI,       ';
  Result := Result + '    ADV_CODIGO,       ';
  Result := Result + '    ADV_CODIG2,       ';
  Result := Result + '    BAS_DESCRI,       ';
  Result := Result + '    ADV_UNIDAD,       ';
  Result := Result + '    ADV_PROKEY,       ';
  Result := Result + '    ADV_SUBKEY,       ';
  Result := Result + '    ADV_BASE__,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ADV_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ADV_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ADV_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    ADVCOR_CADADV     ';
  Result := Result + '  INNER JOIN ADVCOR_CADBAS ON         ';
  Result := Result + '    ADV_PROKEY = BAS_PROKEY AND       ';
  Result := Result + '    ADV_SUBKEY = BAS_SUBKEY AND       ';
  Result := Result + '    ADV_BASE__ = BAS_BASE__ AND       ';
  Result := Result + '    ADV_UNIDAD = BAS_UNIDAD           ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE         ';
  Result := Result + '  WHERE               ';
  Result := Result + '    ADV_MD5KEY = :MD5KEY            ';


end;

function TImportaTintometricosTerceirosADV.fNomeTabela: String;
begin
  Result := 'ADVCOR_CADADV_SIT';
end;

function TImportaTintometricosTerceirosADV.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ADV_BASE__ AS BASE__,           ';
  Result := Result + '    ADV_PROKEY AS PROKEY,           ';
  Result := Result + '    ADV_SUBKEY AS SUBKEY,           ';
  Result := Result + '    ADV_DESCRI AS DESCRI,           ';
  Result := Result + '    ADV_CODIGO AS CODIGO,           ';
  Result := Result + '    ADV_CODIG2 AS CODIG2,           ';
  Result := Result + '    ADV_CODITE AS CODITE,           ';
  Result := Result + '    ADV_DESITE AS DESITE,           ';
  Result := Result + '    ADV_REFERE AS REFERE,           ';
  Result := Result + '    ADV_PREVEN AS PREVEN,           ';
  Result := Result + '    ADV_MD5KEY AS MD5KEY            ';
end;

{ TImportaTintometricosTerceirosALE }

function TImportaTintometricosTerceirosALE.fCampoCodIte: String;
begin
  Result := 'ALE_CODITE';
end;

function TImportaTintometricosTerceirosALE.fCampoMD5: String;
begin
  Result := 'ALE_MD5KEY';
end;

function TImportaTintometricosTerceirosALE.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ALE_PRODUT,       ';
  Result := Result + '    ALE_CODIGO,       ';
  Result := Result + '    ALE_BASE__,       ';
  Result := Result + '    EMB_CODUNI,       ';
  Result := Result + '    ALE_EMBALA,       ';
  Result := Result + '    ALE_NOMCOR,       ';
  Result := Result + '    ALE_NOMLON,       ';
  Result := Result + '    BAS_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ALE_DTACAD,       ';
  Result := Result + '    ALE_CODNFM,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_REFERE,       ';
  Result := Result + '    ALE_COLECA,       ';


  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ALE_CODC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    ALE_QTOZ' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    ALE_QSHO' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    ALE_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    ALE_CADALE        ';
  Result := Result + '  INNER JOIN ALE_CADBAS ON          ';
  Result := Result + '    ALE_PRODUT = BAS_PRODUT AND     ';
  Result := Result + '    ALE_BASE__ = BAS_BASE__ AND     ';
  Result := Result + '    ALE_EMBALA = BAS_EMBALA         ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE         ';
  Result := Result + '  INNER JOIN ALE_CADEMB ON          ';
  Result := Result + '    BAS_EMBALA = EMB_NOME__         ';
  Result := Result + '  INNER JOIN CADUNI ON              ';
  Result := Result + '    EMB_CODUNI = UNI_CODUNI         ';
  Result := Result + '  WHERE                             ';
  Result := Result + '    ALE_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosALE.fNomeTabela: String;
begin
  Result := 'ALE_CADALE_SIT';
end;

function TImportaTintometricosTerceirosALE.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ALE_CODIGO AS CODIGO,         ';
  Result := Result + '    ALE_BASE__ AS BASE__,         ';
  Result := Result + '    ALE_PRODUT AS PRODUT,         ';
  Result := Result + '    ALE_PRODUT AS DESCRI,         ';
  Result := Result + '    ALE_CODUNI AS CODUNI,         ';
  Result := Result + '    ALE_EMBALA AS EMBALA,         ';
  Result := Result + '    ALE_NOMCOR AS NOMCOR,         ';
  Result := Result + '    ALE_NOMLON AS NOMLON,         ';
  Result := Result + '    ALE_CODITE AS CODITE,         ';
  Result := Result + '    ALE_DESITE AS DESITE,         ';
  Result := Result + '    ALE_REFERE AS REFERE,         ';
  Result := Result + '    ALE_MD5KEY AS MD5KEY,         ';
  Result := Result + '    ALE_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosAJT }

function TImportaTintometricosTerceirosAJT.fCampoCodIte: String;
begin
  Result := 'AJT_CODITE';
end;

function TImportaTintometricosTerceirosAJT.fCampoMD5: String;
begin
  Result := 'AJT_MD5KEY';
end;

function TImportaTintometricosTerceirosAJT.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    AJT_CODIGO,     ';
  Result := Result + '    AJT_DESCRI,     ';
  Result := Result + '    AJT_PRODUT,     ';
  Result := Result + '    AJT_ACABAM,     ';
  Result := Result + '    AJT_VARIAC,     ';
  Result := Result + '    AJT_CORMON,     ';
  Result := Result + '    AJT_ANOINI,     ';
  Result := Result + '    AJT_ANOFIM,     ';
  Result := Result + '    AJT_DTACAD,     ';
  Result := Result + '    AJT_OBSERV,     ';
  Result := Result + '    AJT_CODMON,     ';
  Result := Result + '    MON_DESCRI,     ';
  Result := Result + '    AJT_VOLUME,     ';
  Result := Result + '    AJT_GRAMA_,     ';
  Result := Result + '    AJT_ACRMOB,     ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    AJT_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    AJT_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    AJT_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    AJT_CADAJT      ';
  Result := Result + '  LEFT JOIN AJT_CADMON ON       ';
  Result := Result + '    MON_CODMON = AJT_CODMON     ';
  Result := Result + '  WHERE             ';
  Result := Result + '    AJT_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosAJT.fNomeTabela: String;
begin
  Result := 'AJT_CADAJT_SIT';
end;

function TImportaTintometricosTerceirosAJT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    AJT_CODIGO AS CODIGO,     ';
  Result := Result + '    AJT_DESCRI AS DESCRI,     ';
  Result := Result + '    AJT_PRODUT AS PRODUT,     ';
  Result := Result + '    AJT_ACABAM AS ACABAM,     ';
  Result := Result + '    AJT_VARIAC AS VARIAC,     ';
  Result := Result + '    AJT_CORMON AS CORMON,     ';
  Result := Result + '    AJT_ANOINI AS ANOINI,     ';
  Result := Result + '    AJT_ANOFIM AS ANOFIM,     ';
  Result := Result + '    AJT_CODMON AS CODMON,     ';
  Result := Result + '    AJT_OBSERV AS OBSERV,     ';
  Result := Result + '    AJT_MD5KEY AS MD5KEY,     ';

  Result := Result + '    AJT_CODITE AS CODITE,     ';
  Result := Result + '    AJT_CODDIL AS CODDIL,     ';
  Result := Result + '    AJT_PORDIL AS PORDIL,     ';

  Result := Result + '    AJT_PRECLT AS PRECLT,     ';
  Result := Result + '    AJT_PRECGL AS PRECGL,     ';
  Result := Result + '    AJT_PREDLT AS PREDLT,     ';
  Result := Result + '    AJT_PREDGL AS PREDGL,     ';
  Result := Result + '    AJT_EMBALT AS EMBALT,     ';
  Result := Result + '    AJT_EMBAGL AS EMBAGL,     ';
  Result := Result + '    AJT_VOLULT AS VOLULT,     ';
  Result := Result + '    AJT_VOLUGL AS VOLUGL,     ';
  Result := Result + '    AJT_PREELT AS PREELT,     ';
  Result := Result + '    AJT_PREEGL AS PREEGL,     ';
  Result := Result + '    AJT_TIPOLT AS TIPOLT,     ';
  Result := Result + '    AJT_TIPOGL AS TIPOGL      ';

end;


{ TImportaTintometricosTerceirosANJ }

function TImportaTintometricosTerceirosANJ.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosANJ.fCampoMD5: String;
begin
  Result := 'ANJ_MD5KEY';
end;

function TImportaTintometricosTerceirosANJ.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ANJ_DESCRI,       ';
  Result := Result + '    ANJ_CODIGO,       ';
  Result := Result + '    ANJ_CODIG2,       ';
  Result := Result + '    BAS_DESCRI,       ';
  Result := Result + '    ANJ_UNIDAD,       ';
  Result := Result + '    ANJ_DTACAD,       ';
  Result := Result + '    ANJ_BASE__,       ';
  Result := Result + '    ANJ_PROKEY,       ';
  Result := Result + '    ANJ_SUBKEY,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    AJT_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    AJT_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ANJ_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    ANJ_CADANJ        ';
  Result := Result + '  INNER JOIN ANJ_CADBAS ON   ';
  Result := Result + '    ANJ_PROKEY = BAS_PROKEY AND   ';
  Result := Result + '    ANJ_SUBKEY = BAS_SUBKEY AND   ';
  Result := Result + '    ANJ_UNIDAD = BAS_UNIDAD AND   ';
  Result := Result + '    ANJ_BASE__ = BAS_BASE__       ';
  Result := Result + '  INNER JOIN CADITE I ON     ';
  Result := Result + '    BAS_CODITE = I.ITE_CODITE     ';
end;

function TImportaTintometricosTerceirosANJ.fNomeTabela: String;
begin
  Result := 'ANJ_CADANJ_SIT';
end;

function TImportaTintometricosTerceirosANJ.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    ANJ_CODIGO AS CODIGO,     ';
  Result := Result + '    ANJ_CODIG2 AS CODIG2,     ';
  Result := Result + '    ANJ_BASE__ AS BASE__,     ';
  Result := Result + '    ANJ_PROKEY AS PROKEY,     ';
  Result := Result + '    ANJ_SUBKEY AS SUBKEY,     ';
  Result := Result + '    ANJ_UNIDAD AS UNIDAD,     ';
  Result := Result + '    ANJ_DESCRI AS DESCRI,     ';
  Result := Result + '    ANJ_CODITE AS CODITE,     ';
  Result := Result + '    ANJ_DESITE AS DESITE,     ';
  Result := Result + '    ANJ_REFERE AS REFERE,     ';
  Result := Result + '    ANJ_MD5KEY AS MD5KEY,     ';
  Result := Result + '    ANJ_PREVEN AS PREVEN      ';
end;


{ TImportaTintometricosTerceirosAJA }

function TImportaTintometricosTerceirosAJA.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosAJA.fCampoMD5: String;
begin
  Result := 'AJA_MD5KEY';
end;

function TImportaTintometricosTerceirosAJA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    AJA_CODIGO,     ';
  Result := Result + '    AJA_CODIG2,     ';
  Result := Result + '    AJA_BASE__,     ';
  Result := Result + '    AJA_PROKEY,     ';
  Result := Result + '    AJA_SUBKEY,     ';
  Result := Result + '    AJA_UNIDAD,     ';
  Result := Result + '    AJA_DESCRI,     ';
  Result := Result + '    ITE_CODITE,     ';
  Result := Result + '    ITE_DESITE,     ';
  Result := Result + '    ITE_REFERE,     ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    AJA_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    AJA_QTDB' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    AJA_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    AJA_CADAJA      ';
  Result := Result + '  INNER JOIN AJA_CADBAS ON      ';
  Result := Result + '    AJA_BASE__ = BAS_BASE__ AND       ';
  Result := Result + '    AJA_PROKEY = BAS_PROKEY AND       ';
  Result := Result + '    AJA_SUBKEY = BAS_SUBKEY AND       ';
  Result := Result + '    AJA_UNIDAD = BAS_UNIDAD           ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE             ';
  Result := Result + '    AJA_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosAJA.fNomeTabela: String;
begin
  Result := 'AJA_CADAJA_SIT';
end;

function TImportaTintometricosTerceirosAJA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    AJA_CODIGO AS CODIGO,     ';
  Result := Result + '    AJA_CODIG2 AS CODIG2,     ';
  Result := Result + '    AJA_BASE__ AS BASE__,     ';
  Result := Result + '    AJA_PROKEY AS PROKEY,     ';
  Result := Result + '    AJA_SUBKEY AS SUBKEY,     ';
  Result := Result + '    AJA_UNIDAD AS UNIDAD,     ';
  Result := Result + '    AJA_DESCRI AS DESCRI,     ';
  Result := Result + '    AJA_CODITE AS CODITE,     ';
  Result := Result + '    AJA_DESITE AS DESITE,     ';
  Result := Result + '    AJA_REFERE AS REFERE,     ';
  Result := Result + '    AJA_MD5KEY AS MD5KEY,     ';
  Result := Result + '    AJA_PREVEN AS PREVEN      ';
end;

{ TImportaTintometricosTerceirosBZC }

function TImportaTintometricosTerceirosBZC.fCampoCodIte: String;
begin
  Result := 'BZC_CODITE';
end;

function TImportaTintometricosTerceirosBZC.fCampoMD5: String;
begin
  Result := 'BZC_MD5KEY';
end;

function TImportaTintometricosTerceirosBZC.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BZC_CODIGO,       ';
  Result := Result + '    BZC_DESCRI,       ';
  Result := Result + '    BZC_CODNFM,       ';
  Result := Result + '    BZC_ESPECI,       ';
  Result := Result + '    BZC_REVISA,       ';
  Result := Result + '    BZC_CODSUF,       ';
  Result := Result + '    BZC_AUTORI,       ';
  Result := Result + '    BZC_CODUNI,       ';
  Result := Result + '    BZC_A_N_O_,       ';
  Result := Result + '    BZC_CODMON,       ';
  Result := Result + '    BZC_LINHA_,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    BZC_TIPO__,       ';
  Result := Result + '    BZC_DTACAD,       ';
  Result := Result + '    BZC_ACRMOB,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    BZC_BASE' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    BZC_QTDC' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    BZC_QTDD' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    BZC_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    BZC_CADBZC        ';
  Result := Result + '  INNER JOIN BZC_CADMON ON    ';
  Result := Result + '    BZC_CODMON = MON_CODMON     ';
  Result := Result + '  WHERE               ';
  Result := Result + '    BZC_MD5KEY = :MD5KEY      ';
end;

function TImportaTintometricosTerceirosBZC.fNomeTabela: String;
begin
  Result := 'BZC_CADBZC_SIT';
end;

function TImportaTintometricosTerceirosBZC.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BZC_CODIGO AS CODIGO,       ';
  Result := Result + '    BZC_DESCRI AS NOMCOR,       ';
  Result := Result + '    BZC_DESCRI AS DESCRI,       ';
  Result := Result + '    BZC_CODUNI AS CODUNI,       ';
  Result := Result + '    BZC_A_N_O_ AS A_N_O_,       ';
  Result := Result + '    BZC_CODMON AS CODMON,       ';
  Result := Result + '    BZC_REVISA AS REVISA,       ';
  Result := Result + '    BZC_ESPECI AS ESPECI,       ';
  Result := Result + '    BZC_TIPO__ AS TIPO__,       ';
  Result := Result + '    BZC_AUTORI AS AUTORI,       ';
  Result := Result + '    BZC_LINHA_ AS LINHA_,       ';
  Result := Result + '    BZC_MD5KEY AS MD5KEY,       ';
  Result := Result + '    BZC_CODITE AS CODITE,       ';
  Result := Result + '    ITE_REFERE AS REFERE,       ';
  Result := Result + '    BZC_CODDIL AS CODDIL,       ';
  Result := Result + '    BZC_PORDIL AS PORDIL,       ';
  Result := Result + '    BZC_PRECLT AS PRECLT,       ';
  Result := Result + '    BZC_PRECGL AS PRECGL,       ';
  Result := Result + '    BZC_PRECLA AS PRECLA,       ';
  Result := Result + '    BZC_PREDLT AS PREDLT,       ';
  Result := Result + '    BZC_PREDGL AS PREDGL,       ';
  Result := Result + '    BZC_PREDLA AS PREDLA,       ';
  Result := Result + '    BZC_EMBALT AS EMBALT,       ';
  Result := Result + '    BZC_EMBAGL AS EMBAGL,       ';
  Result := Result + '    BZC_EMBALA AS EMBALA,       ';
  Result := Result + '    BZC_VOLULT AS VOLULT,       ';
  Result := Result + '    BZC_VOLUGL AS VOLUGL,       ';
  Result := Result + '    BZC_VOLULA AS VOLULA,       ';
  Result := Result + '    BZC_PREELT AS PREELT,       ';
  Result := Result + '    BZC_PREEGL AS PREEGL,       ';
  Result := Result + '    BZC_PREELA AS PREELA,       ';
  Result := Result + '    BZC_TIPOLT AS TIPOLT,       ';
  Result := Result + '    BZC_TIPOGL AS TIPOGL,       ';
  Result := Result + '    BZC_TIPOLA AS TIPOLA        ';
end;

{ TImportaTintometricosTerceirosGEN }

function TImportaTintometricosTerceirosGEN.fCampoCodIte: String;
begin
  Result := 'GEN_CODITE';
end;

function TImportaTintometricosTerceirosGEN.fCampoMD5: String;
begin
  Result := 'GEN_MD5KEY';
end;

function TImportaTintometricosTerceirosGEN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    GEN_CODIGO,       ';
  Result := Result + '    GEN_DESCRI,       ';
  Result := Result + '    GEN_VARIAC,       ';
  Result := Result + '    GEN_OBSERV,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    GEN_ANOINI,       ';
  Result := Result + '    GEN_ANOFIM,       ';
  Result := Result + '    GEN_DTACAD,       ';
  Result := Result + '    GEN_CODNFM,       ';
  Result := Result + '    GEN_CODMON,       ';
  Result := Result + '    GEN_ACRMOB,       ';
  Result := Result + '    GEN_DILUID,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    GEN_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    GEN_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    GEN_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    GEN_CADGEN        ';
  Result := Result + '  LEFT JOIN GEN_CADMON ON       ';
  Result := Result + '    MON_CODMON = GEN_CODMON       ';
  Result := Result + '  WHERE               ';
  Result := Result + '    GEN_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosGEN.fNomeTabela: String;
begin
  Result := 'GEN_CADGEN_SIT';
end;

function TImportaTintometricosTerceirosGEN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    GEN_CODIGO AS CODIGO,     ';
  Result := Result + '    GEN_DESCRI AS DESCRI,     ';
  Result := Result + '    GEN_VARIAC AS VARIAC,     ';
  Result := Result + '    GEN_CODMON AS CODMON,     ';
  Result := Result + '    GEN_DESMON AS DESMON,     ';
  Result := Result + '    GEN_ANOINI AS ANOINI,     ';
  Result := Result + '    GEN_ANOFIM AS ANOFIM,     ';
  Result := Result + '    GEN_DILUID AS DILUID,     ';
  Result := Result + '    GEN_CODITE AS CODITE,     ';
  Result := Result + '    GEN_CODDIL AS CODDIL,     ';
  Result := Result + '    GEN_PORDIL AS PORDIL,     ';

  Result := Result + '    GEN_PRECLT AS PRECLT,     ';
  Result := Result + '    GEN_PRECGL AS PRECGL,     ';
  Result := Result + '    GEN_PRECCP AS PRECCP,     ';
  Result := Result + '    GEN_PRECSP AS PRECSP,     ';

  Result := Result + '    GEN_PREDLT AS PREDLT,     ';
  Result := Result + '    GEN_PREDGL AS PREDGL,     ';
  Result := Result + '    GEN_PREDCP AS PREDCP,     ';
  Result := Result + '    GEN_PREDSP AS PREDSP,     ';

  Result := Result + '    GEN_EMBALT AS EMBALT,     ';
  Result := Result + '    GEN_EMBAGL AS EMBAGL,     ';
  Result := Result + '    GEN_EMBACP AS EMBACP,     ';
  Result := Result + '    GEN_EMBASP AS EMBASP,     ';

  Result := Result + '    GEN_VOLULT AS VOLULT,     ';
  Result := Result + '    GEN_VOLUGL AS VOLUGL,     ';
  Result := Result + '    GEN_VOLUCP AS VOLUCP,     ';
  Result := Result + '    GEN_VOLUSP AS VOLUSP,     ';

  Result := Result + '    GEN_PREELT AS PREELT,     ';
  Result := Result + '    GEN_PREEGL AS PREEGL,     ';
  Result := Result + '    GEN_PREECP AS PREECP,     ';
  Result := Result + '    GEN_PREESP AS PREESP,     ';

  Result := Result + '    GEN_TIPOLT AS TIPOLT,     ';
  Result := Result + '    GEN_TIPOGL AS TIPOGL,     ';
  Result := Result + '    GEN_TIPOCP AS TIPOCP,     ';
  Result := Result + '    GEN_TIPOSP AS TIPOSP     ';
end;

{ TImportaTintometricosTerceirosANN }

function TImportaTintometricosTerceirosANN.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosANN.fCampoMD5: String;
begin
  Result := 'ANN_MD5KEY';
end;

function TImportaTintometricosTerceirosANN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    ANN_CODIGO,     ';
  Result := Result + '    ANN_DESCRI,     ';
  Result := Result + '    ANN_UNIDAD,     ';
  Result := Result + '    ANN_CODBAS,     ';
  Result := Result + '    ANN_CODEMB,     ';
  Result := Result + '    ANN_PRODUT,     ';
  Result := Result + '    ITE_CODITE,     ';
  Result := Result + '    ITE_DESITE,     ';
  Result := Result + '    ITE_REFERE,     ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ANN_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    ANN_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    ANN_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    ANN_CADANN      ';
  Result := Result + '  INNER JOIN ANN_CADBAS ON          ';
  Result := Result + '    ANN_CODBAS = BAS_BASE__ AND     ';
  Result := Result + '    ANN_PRODUT = BAS_DESCRI AND     ';
  Result := Result + '    ANN_UNIDAD = BAS_UNIDAD         ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    ITE_CODITE = BAS_CODITE         ';
  Result := Result + '  WHERE             ';
  Result := Result + '    ANN_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosANN.fNomeTabela: String;
begin
  Result := 'ANN_CADANN_SIT';
end;

function TImportaTintometricosTerceirosANN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    ANN_CODIGO AS CODIGO,       ';
  Result := Result + '    ANN_DESCRI AS DESCRI,       ';
  Result := Result + '    ANN_CODBAS AS CODBAS,       ';
  Result := Result + '    ANN_UNIDAD AS UNIDAD,       ';
  Result := Result + '    ANN_CODEMB AS CODEMB,       ';
  Result := Result + '    ANN_PRODUT AS PRODUT,       ';
  Result := Result + '    ANN_CODITE AS CODITE,       ';
  Result := Result + '    ANN_DESITE AS DESITE,       ';
  Result := Result + '    ANN_REFERE AS REFERE,       ';
  Result := Result + '    ANN_MD5KEY AS MD5KEY,       ';
  Result := Result + '    ANN_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosBEL }

function TImportaTintometricosTerceirosBEL.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosBEL.fCampoMD5: String;
begin
  Result := 'BEL_MD5KEY';
end;

function TImportaTintometricosTerceirosBEL.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BEL_DESCRI,       ';
  Result := Result + '    BEL_CODUNI,       ';
  Result := Result + '    BEL_CODBAS,       ';
  Result := Result + '    BEL_NOMCOR,       ';
  Result := Result + '    BEL_DTACAD,       ';
  Result := Result + '    BEL_COLECA,       ';
  Result := Result + '    BEL_PRODUT,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    BEL_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    BEL_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    BEL_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    BEL_CADBEL        ';
  Result := Result + '  INNER JOIN BEL_CADBAS ON        ';
  Result := Result + '    BEL_CODBAS = BAS_CODBAS AND       ';
  Result := Result + '    BEL_PRODUT = BAS_PRODUT AND       ';
  Result := Result + '    BEL_CODUNI = BAS_CODUNI           ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE               ';
  Result := Result + '    BEL_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosBEL.fNomeTabela: String;
begin
  Result := 'BEL_CADBEL_SIT';
end;

function TImportaTintometricosTerceirosBEL.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    BEL_CODBAS AS CODBAS,       ';
  Result := Result + '    BEL_DESCRI AS DESCRI,       ';
  Result := Result + '    BEL_CODUNI AS CODUNI,       ';
  Result := Result + '    BEL_PRODUT AS PRODUT,       ';
  Result := Result + '    BEL_NOMCOR AS NOMCOR,       ';
  Result := Result + '    BEL_COLECA AS COLECA,       ';
  Result := Result + '    BEL_CODITE AS CODITE,       ';
  Result := Result + '    BEL_DESITE AS DESITE,       ';
  Result := Result + '    BEL_REFERE AS REFERE,       ';
  Result := Result + '    BEL_MD5KEY AS MD5KEY,       ';
  Result := Result + '    BEL_PREVEN AS PREVEN        ';
end;


{ TImportaTintometricosTerceirosBZI }

function TImportaTintometricosTerceirosBZI.fCampoCodIte: String;
begin
  Result := 'BZI_CODITE';
end;

function TImportaTintometricosTerceirosBZI.fCampoMD5: String;
begin
  Result := 'BZI_MD5KEY';
end;

function TImportaTintometricosTerceirosBZI.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BZI_DESCRI,       ';
  Result := Result + '    BZI_REFERE,       ';
  Result := Result + '    BZI_CODIGO,       ';
  Result := Result + '    BZI_UNIDAD,       ';
  Result := Result + '    BZI_LINHA_,       ';
  Result := Result + '    BZI_CODBAS,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';
  Result := Result + '    BZI_DTACAD,       ';
  Result := Result + '    BZI_CODUNI,       ';
  Result := Result + '    BZI_GRUPRO,       ';
  Result := Result + '    BZI_EMBALA,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    BZI_CODC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    BZI_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    BZI_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    BZI_CADBZI        ';
  Result := Result + '  INNER JOIN BZI_CADBAS ON        ';
  Result := Result + '    BAS_BASE__ = BZI_CODBAS AND       ';
  Result := Result + '    BAS_LINHA_ = BZI_LINHA_ AND       ';
  Result := Result + '    BAS_UNIDAD = BZI_CODUNI AND       ';
  Result := Result + '    BAS_DESCRI = BZI_DESCRI AND       ';
  Result := Result + '    BAS_EMBALA = BZI_EMBALA           ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE               ';
  Result := Result + '    BZI_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosBZI.fNomeTabela: String;
begin
  Result := 'BZI_CADBZI_SIT';
end;

function TImportaTintometricosTerceirosBZI.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    BZI_CODIGO AS CODIGO,       ';
  Result := Result + '    BZI_DESCRI AS DESCRI,       ';
  Result := Result + '    BZI_DESCRI AS NOMCOR,       ';
  Result := Result + '    BZI_CODBAS AS CODBAS,       ';
  Result := Result + '    BZI_CODUNI AS CODUNI,       ';
  Result := Result + '    BZI_LINHA_ AS LINHA_,       ';
  Result := Result + '    BZI_GRUPRO AS GRUPRO,       ';
  Result := Result + '    BZI_CODITE AS CODITE,       ';
  Result := Result + '    BZI_DESITE AS DESITE,       ';
  Result := Result + '    BZI_REFERE AS REFERE,       ';
  Result := Result + '    BZI_MD5KEY AS MD5KEY,       ';
  Result := Result + '    BZI_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosCAL }

function TImportaTintometricosTerceirosCAL.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosCAL.fCampoMD5: String;
begin
  Result := 'CAL_MD5KEY';
end;

function TImportaTintometricosTerceirosCAL.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    CAL_CODBAS,         ';
  Result := Result + '    CAL_CODEMB,         ';
  Result := Result + '    CAL_PRODUT,         ';
  Result := Result + '    CAL_COLECA,         ';
  Result := Result + '    CAL_KEY1__,         ';
  Result := Result + '    CAL_KEY2__,         ';
  Result := Result + '    CAL_KEY3__,         ';
  Result := Result + '    CAL_CODNFM,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    CAL_CODC' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    CAL_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    CAL_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    CAL_CADCAL          ';
  Result := Result + '  INNER JOIN CAL_CADBAS ON        ';
  Result := Result + '    CAL_CODBAS = BAS_CODBAS AND       ';
  Result := Result + '    CAL_CODEMB = BAS_CODEMB           ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    CAL_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosCAL.fNomeTabela: String;
begin
  Result := 'CAL_CADCAL_SIT';
end;

function TImportaTintometricosTerceirosCAL.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    CAL_CODBAS AS CODBAS,       ';
  Result := Result + '    CAL_CODEMB AS CODEMB,       ';
  Result := Result + '    CAL_PRODUT AS PRODUT,       ';
  Result := Result + '    CAL_COLECA AS COLECA,       ';
  Result := Result + '    CAL_KEY1__ AS KEY1__,       ';
  Result := Result + '    CAL_KEY2__ AS KEY2__,       ';
  Result := Result + '    CAL_KEY3__ AS KEY3__,       ';
  Result := Result + '    CAL_CODITE AS CODITE,       ';
  Result := Result + '    CAL_DESITE AS DESITE,       ';
  Result := Result + '    CAL_REFERE AS REFERE,       ';
  Result := Result + '    CAL_MD5KEY AS MD5KEY,       ';
  Result := Result + '    CAL_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosCIA }

function TImportaTintometricosTerceirosCIA.fCampoCodIte: String;
begin
  Result := 'CIA_CODITE';
end;

function TImportaTintometricosTerceirosCIA.fCampoMD5: String;
begin
  Result := 'CIA_MD5KEY';
end;

function TImportaTintometricosTerceirosCIA.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    CIA_DESCRI,         ';
  Result := Result + '    CIA_DTACAD,         ';
  Result := Result + '    CIA_UNIDAD,         ';
  Result := Result + '    CIA_CODBAS,         ';
  Result := Result + '    CIA_NOMCOR,         ';
  Result := Result + '    CIA_VOLUME,         ';
  Result := Result + '    CIA_PRODUT,         ';
  Result := Result + '    CIA_COLECA,         ';
  Result := Result + '    CIA_CODUNI,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    CIA_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    CIA_QTDB' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    CIA_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    CIA_CADCIA          ';
  Result := Result + '  INNER JOIN CIA_CADBAS ON        ';
  Result := Result + '    CIA_CODBAS = BAS_CODBAS AND       ';
  Result := Result + '    CIA_CODUNI = BAS_CODUNI AND       ';
  Result := Result + '    CIA_PRODUT = BAS_PRODUT           ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    CIA_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosCIA.fNomeTabela: String;
begin
  Result := 'CIA_CADCIA_SIT';
end;

function TImportaTintometricosTerceirosCIA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    CIA_CODBAS AS CODBAS,     ';
  Result := Result + '    CIA_DESCRI AS DESCRI,     ';
  Result := Result + '    CIA_PRODUT AS PRODUT,     ';
  Result := Result + '    CIA_CODUNI AS CODUNI,     ';
  Result := Result + '    CIA_UNIDAD AS UNIDAD,     ';
  Result := Result + '    CIA_COLECA AS COLECA,     ';
  Result := Result + '    CIA_NOMCOR AS NOMCOR,     ';
  Result := Result + '    CIA_VOLUME AS VOLUME,     ';
  Result := Result + '    CIA_CODITE AS CODITE,     ';
  Result := Result + '    CIA_DESITE AS DESITE,     ';
  Result := Result + '    CIA_REFERE AS REFERE,     ';
  Result := Result + '    CIA_MD5KEY AS MD5KEY,     ';
  Result := Result + '    CIA_PREVEN AS PREVEN      ';
end;

{ TImportaTintometricosTerceirosDUX }

function TImportaTintometricosTerceirosDUX.fCampoCodIte: String;
begin
  Result := 'DUX_CODITE';
end;

function TImportaTintometricosTerceirosDUX.fCampoMD5: String;
begin
  Result := 'DUX_MD5KEY';
end;

function TImportaTintometricosTerceirosDUX.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    DUX_CODDUX,           ';
  Result := Result + '    DUX_CODOEM,           ';
  Result := Result + '    DUX_LINHA_,           ';
  Result := Result + '    DUX_QUALID,           ';
  Result := Result + '    DUX_ALTERN,           ';
  Result := Result + '    DUX_REGIAO,           ';
  Result := Result + '    DUX_DESCRI,           ';
  Result := Result + '    DUX_MONTAD,           ';
  Result := Result + '    DUX_ANOCOR,           ';
  Result := Result + '    DUX_LITRAG,           ';
  Result := Result + '    DUX_DTACAD,           ';
  Result := Result + '    DUX_CODSEQ,           ';
  Result := Result + '    DUX_CODNFM,           ';
  Result := Result + '    DUX_ACRMOB,           ';
  Result := Result + '    DUX_OBSERV,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    DUX_BASE' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_QTDC' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_QTDD' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_TIPB' + fStrZero(intContador, 2) + ',       ';
  End;

  Result := Result + '    DUX_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    DUX_CADDUX            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    DUX_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosDUX.fNomeTabela: String;
begin
  Result := 'DUX_CADDUX_SIT';
end;

function TImportaTintometricosTerceirosDUX.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    DUX_CODDUX AS CODDUX,     ';
  Result := Result + '    DUX_CODOEM AS CODOEM,     ';
  Result := Result + '    DUX_LINHA_ AS LINHA_,     ';
  Result := Result + '    DUX_QUALID AS QUALID,     ';
  Result := Result + '    DUX_ALTERN AS ALTERN,     ';
  Result := Result + '    DUX_REGIAO AS REGIAO,     ';
  Result := Result + '    DUX_DESCRI AS DESCRI,     ';
  Result := Result + '    DUX_MONTAD AS MONTAD,     ';
  Result := Result + '    DUX_OBSERV AS OBSERV,     ';
  Result := Result + '    DUX_CODITE AS CODITE,     ';
  Result := Result + '    DUX_CODDIL AS CODDIL,     ';
  Result := Result + '    DUX_PORDIL AS PORDIL,     ';

  Result := Result + '    DUX_PRECLT AS PRECLT,     ';
  Result := Result + '    DUX_PRECGL AS PRECGL,     ';
  Result := Result + '    DUX_PRECLA AS PRECLA,     ';
  Result := Result + '    DUX_PRECTB AS PRECTB,     ';
  Result := Result + '    DUX_PRECBD AS PRECBD,     ';
  Result := Result + '    DUX_PRECCP AS PRECCP,     ';
  Result := Result + '    DUX_PRECSS AS PRECSS,     ';
  Result := Result + '    DUX_PRECSP AS PRECSP,     ';
  Result := Result + '    DUX_PRECSD AS PRECSD,     ';

  Result := Result + '    DUX_PREDLT AS PREDLT,     ';
  Result := Result + '    DUX_PREDGL AS PREDGL,     ';
  Result := Result + '    DUX_PREDLA AS PREDLA,     ';
  Result := Result + '    DUX_PREDTB AS PREDTB,     ';
  Result := Result + '    DUX_PREDBD AS PREDBD,     ';
  Result := Result + '    DUX_PREDCP AS PREDCP,     ';
  Result := Result + '    DUX_PREDSS AS PREDSS,     ';
  Result := Result + '    DUX_PREDSP AS PREDSP,     ';
  Result := Result + '    DUX_PREDSD AS PREDSD,     ';

  Result := Result + '    DUX_EMBALT AS EMBALT,     ';
  Result := Result + '    DUX_EMBAGL AS EMBAGL,     ';
  Result := Result + '    DUX_EMBALA AS EMBALA,     ';
  Result := Result + '    DUX_EMBATB AS EMBATB,     ';
  Result := Result + '    DUX_EMBABD AS EMBABD,     ';
  Result := Result + '    DUX_EMBACP AS EMBACP,     ';
  Result := Result + '    DUX_EMBASS AS EMBASS,     ';
  Result := Result + '    DUX_EMBASP AS EMBASP,     ';
  Result := Result + '    DUX_EMBASD AS EMBASD,     ';

  Result := Result + '    DUX_VOLULT AS VOLULT,     ';
  Result := Result + '    DUX_VOLUGL AS VOLUGL,     ';
  Result := Result + '    DUX_VOLULA AS VOLULA,     ';
  Result := Result + '    DUX_VOLUTB AS VOLUTB,     ';
  Result := Result + '    DUX_VOLUBD AS VOLUBD,     ';
  Result := Result + '    DUX_VOLUCP AS VOLUCP,     ';
  Result := Result + '    DUX_VOLUSS AS VOLUSS,     ';
  Result := Result + '    DUX_VOLUSP AS VOLUSP,     ';
  Result := Result + '    DUX_VOLUSD AS VOLUSD,     ';

  Result := Result + '    DUX_PREELT AS PREELT,     ';
  Result := Result + '    DUX_PREEGL AS PREEGL,     ';
  Result := Result + '    DUX_PREELA AS PREELA,     ';
  Result := Result + '    DUX_PREETB AS PREETB,     ';
  Result := Result + '    DUX_PREEBD AS PREEBD,     ';
  Result := Result + '    DUX_PREECP AS PREECP,     ';
  Result := Result + '    DUX_PREESS AS PREESS,     ';
  Result := Result + '    DUX_PREESP AS PREESP,     ';
  Result := Result + '    DUX_PREESD AS PREESD,     ';

  Result := Result + '    DUX_TIPOLT AS TIPOLT,     ';
  Result := Result + '    DUX_TIPOGL AS TIPOGL,     ';
  Result := Result + '    DUX_TIPOLA AS TIPOLA,     ';
  Result := Result + '    DUX_TIPOTB AS TIPOTB,     ';
  Result := Result + '    DUX_TIPOBD AS TIPOBD,     ';
  Result := Result + '    DUX_TIPOCP AS TIPOCP,     ';
  Result := Result + '    DUX_TIPOSS AS TIPOSS,     ';
  Result := Result + '    DUX_TIPOSP AS TIPOSP,     ';
  Result := Result + '    DUX_TIPOSD AS TIPOSD      ';
end;

{ TImportaTintometricosTerceirosFAR }

function TImportaTintometricosTerceirosFAR.fCampoCodIte: String;
begin
  Result := 'FAR_CODITE';
end;

function TImportaTintometricosTerceirosFAR.fCampoMD5: String;
begin
  Result := 'FAR_MD5KEY';
end;

function TImportaTintometricosTerceirosFAR.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    FAR_CODNFM,         ';
  Result := Result + '    FAR_DESCRI,         ';
  Result := Result + '    M.FAR_DESMON,       ';
  Result := Result + '    FAR_O_E_M_,         ';
  Result := Result + '    FAR_A_N_O_,         ';
  Result := Result + '    FAR_SETOR_,         ';
  Result := Result + '    FAR_LINHA_,         ';
  Result := Result + '    FAR_CODEMP,         ';
  Result := Result + '    FAR_MONTAD,         ';
  Result := Result + '    FAR_ACRMOB,         ';
  Result := Result + '    FAR_CODSEQ,         ';
  Result := Result + '    FAR_TIPPRG,         ';
  Result := Result + '    FAR_OBSERV,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    FAR_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    FAR_QTDC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    FAR_QTDD' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    FAR_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    FAR_CADFAR          ';
  Result := Result + '  LEFT JOIN FAR_CADMON M ON         ';
  Result := Result + '    (FAR_MONTAD = M.FAR_CODMON)     ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    FAR_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosFAR.fNomeTabela: String;
begin
  Result := 'FAR_CADFAR_SIT';
end;

function TImportaTintometricosTerceirosFAR.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    FAR_DESCRI AS DESCRI,         ';
  Result := Result + '    FAR_LINHA_ AS LINHA_,         ';
  Result := Result + '    FAR_O_E_M_ AS O_E_M_,         ';
  Result := Result + '    FAR_MONTAD AS MONTAD,         ';
  Result := Result + '    FAR_A_N_O_ AS A_N_O_,         ';
  Result := Result + '    FAR_SETOR_ AS SETOR_,         ';
  Result := Result + '    FAR_TIPPRG AS TIPPRG,         ';
  Result := Result + '    FAR_OBSERV AS OBSERV,         ';
  Result := Result + '    FAR_MD5KEY AS MD5KEY,         ';

  Result := Result + '    FAR_CODITE AS CODITE,         ';
  Result := Result + '    FAR_CODDIL AS CODDIL,         ';
  Result := Result + '    FAR_PORDIL AS PORDIL,         ';

  Result := Result + '    FAR_PRECLT AS PRECLT,         ';
  Result := Result + '    FAR_PRECGL AS PRECGL,         ';
  Result := Result + '    FAR_PRECLA AS PRECLA,         ';
  Result := Result + '    FAR_PRECCP AS PRECCP,         ';
  Result := Result + '    FAR_PRECTB AS PRECTB,         ';
  Result := Result + '    FAR_PRECSP AS PRECSP,         ';

  Result := Result + '    FAR_PREDLT AS PREDLT,         ';
  Result := Result + '    FAR_PREDGL AS PREDGL,         ';
  Result := Result + '    FAR_PREDLA AS PREDLA,         ';
  Result := Result + '    FAR_PREDCP AS PREDCP,         ';
  Result := Result + '    FAR_PREDTB AS PREDTB,         ';
  Result := Result + '    FAR_PREDSP AS PREDSP,         ';

  Result := Result + '    FAR_EMBALT AS EMBALT,         ';
  Result := Result + '    FAR_EMBAGL AS EMBAGL,         ';
  Result := Result + '    FAR_EMBALA AS EMBALA,         ';
  Result := Result + '    FAR_EMBACP AS EMBACP,         ';
  Result := Result + '    FAR_EMBATB AS EMBATB,         ';
  Result := Result + '    FAR_EMBASP AS EMBASP,         ';

  Result := Result + '    FAR_VOLULT AS VOLULT,         ';
  Result := Result + '    FAR_VOLUGL AS VOLUGL,         ';
  Result := Result + '    FAR_VOLULA AS VOLULA,         ';
  Result := Result + '    FAR_VOLUCP AS VOLUCP,         ';
  Result := Result + '    FAR_VOLUTB AS VOLUTB,         ';
  Result := Result + '    FAR_VOLUSP AS VOLUSP,         ';

  Result := Result + '    FAR_PREELT AS PREELT,         ';
  Result := Result + '    FAR_PREEGL AS PREEGL,         ';
  Result := Result + '    FAR_PREELA AS PREELA,         ';
  Result := Result + '    FAR_PREECP AS PREECP,         ';
  Result := Result + '    FAR_PREETB AS PREETB,         ';
  Result := Result + '    FAR_PREESP AS PREESP,         ';

  Result := Result + '    FAR_TIPOLT AS TIPOLT,         ';
  Result := Result + '    FAR_TIPOGL AS TIPOGL,         ';
  Result := Result + '    FAR_TIPOLA AS TIPOLA,         ';
  Result := Result + '    FAR_TIPOCP AS TIPOCP,         ';
  Result := Result + '    FAR_TIPOTB AS TIPOTB,         ';
  Result := Result + '    FAR_TIPOSP AS TIPOSP          ';
end;

{ TImportaTintometricosTerceirosGLO }

function TImportaTintometricosTerceirosGLO.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosGLO.fCampoMD5: String;
begin
  Result := 'GLO_MD5KEY';
end;

function TImportaTintometricosTerceirosGLO.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    GLO_DESCRI,           ';
  Result := Result + '    GLO_PRODUT,           ';
  Result := Result + '    GLO_UNIDAD,           ';
  Result := Result + '    GLO_CODBAS,           ';
  Result := Result + '    GLO_CODEMB,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    GLO_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    GLO_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    GLO_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    GLO_CADGLO            ';
  Result := Result + '  INNER JOIN GLO_CADBAS ON          ';
  Result := Result + '    GLO_CODBAS = BAS_BASE__ AND         ';
  Result := Result + '    GLO_PRODUT = BAS_DESCRI AND         ';
  Result := Result + '    GLO_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    GLO_MD5KEY = :MD5KEY                ';
end;

function TImportaTintometricosTerceirosGLO.fNomeTabela: String;
begin
  Result := 'GLO_CADGLO_SIT';
end;

function TImportaTintometricosTerceirosGLO.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    GLO_CODBAS AS CODBAS,         ';
  Result := Result + '    GLO_DESCRI AS DESCRI,         ';
  Result := Result + '    GLO_PRODUT AS PRODUT,         ';
  Result := Result + '    GLO_CODEMB AS CODEMB,         ';
  Result := Result + '    GLO_UNIDAD AS UNIDAD,         ';
  Result := Result + '    GLO_CODITE AS CODITE,         ';
  Result := Result + '    GLO_DESITE AS DESITE,         ';
  Result := Result + '    GLO_REFERE AS REFERE,         ';
  Result := Result + '    GLO_MD5KEY AS MD5KEY,         ';
  Result := Result + '    GLO_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosGRA }

function TImportaTintometricosTerceirosGRA.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosGRA.fCampoMD5: String;
begin
  Result := 'GRA_MD5KEY';
end;

function TImportaTintometricosTerceirosGRA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    GRA_CODIGO,         ';
  Result := Result + '    GRA_DESCRI,         ';
  Result := Result + '    GRA_NOME__,         ';
  Result := Result + '    GRA_REFERE,         ';
  Result := Result + '    GRA_DTACAD,         ';
  Result := Result + '    GRA_CODUNI,         ';
  Result := Result + '    GRA_BASE__,         ';
  Result := Result + '    GRA_PRODUT,         ';
  Result := Result + '    GRA_COLECA,         ';
  Result := Result + '    GRA_CODUNI,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    GRA_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    GRA_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    GRA_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    GRA_CADGRA          ';
  Result := Result + '  INNER JOIN GRA_CADBAS ON        ';
  Result := Result + '    GRA_BASE__ = BAS_CODBAS AND       ';
  Result := Result + '    GRA_CODUNI = BAS_CODUNI AND       ';
  Result := Result + '    GRA_PRODUT = BAS_PRODUT           ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    GRA_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosGRA.fNomeTabela: String;
begin
  Result := 'GRA_CADGRA_SIT';
end;

function TImportaTintometricosTerceirosGRA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    GRA_BASE__ AS BASE__,       ';
  Result := Result + '    GRA_DESCRI AS DESCRI,       ';
  Result := Result + '    GRA_PRODUT AS PRODUT,       ';
  Result := Result + '    GRA_REFERE AS REFERE,       ';
  Result := Result + '    GRA_NOME__ AS NOME__,       ';
  Result := Result + '    GRA_COLECA AS COLECA,       ';
  Result := Result + '    GRA_CODUNI AS CODUNI,       ';
  Result := Result + '    GRA_CODITE AS CODITE,       ';
  Result := Result + '    GRA_DESITE AS DESITE,       ';
  Result := Result + '    GRA_REFITE AS REFITE,       ';
  Result := Result + '    GRA_MD5KEY AS MD5KEY,       ';
  Result := Result + '    GRA_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosHYD }

function TImportaTintometricosTerceirosHYD.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosHYD.fCampoMD5: String;
begin
  Result := 'HYD_MD5KEY';
end;

function TImportaTintometricosTerceirosHYD.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    HYD_COLECA,       ';
  Result := Result + '    HYD_PRODUT,       ';
  Result := Result + '    HYD_C_O_R_,       ';
  Result := Result + '    HYD_CORLON,       ';
  Result := Result + '    HYD_BASE__,       ';
  Result := Result + '    HYD_CODNFM,       ';
  Result := Result + '    HYD_CODEMB,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For IntCont := 1 To 20 Do
  Begin
    Result := Result + '    HYD_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    HYD_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    HYD_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    HYD_CADHYD        ';
  Result := Result + '  INNER JOIN HYD_CADBAS ON        ';
  Result := Result + '    HYD_BASE__ = BAS_BASE__ AND         ';
  Result := Result + '    HYD_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    HYD_CODEMB = BAS_CODEMB             ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE               ';
  Result := Result + '    HYD_MD5KEY = :MD5KEY                ';
end;

function TImportaTintometricosTerceirosHYD.fNomeTabela: String;
begin
  Result := 'HYD_CADHYD_SIT';
end;

function TImportaTintometricosTerceirosHYD.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    HYD_BASE__ AS BASE__,       ';
  Result := Result + '    HYD_PRODUT AS PRODUT,       ';
  Result := Result + '    HYD_C_O_R_ AS C_O_R_,       ';
  Result := Result + '    HYD_CORLON AS CORLON,       ';
  Result := Result + '    HYD_COLECA AS COLECA,       ';
  Result := Result + '    HYD_CODEMB AS CODEMB,       ';
  Result := Result + '    HYD_CODITE AS CODITE,       ';
  Result := Result + '    HYD_DESITE AS DESITE,       ';
  Result := Result + '    HYD_REFERE AS REFERE,       ';
  Result := Result + '    HYD_MD5KEY AS MD5KEY,       ';
  Result := Result + '    HYD_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosINT }

function TImportaTintometricosTerceirosINT.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosINT.fCampoMD5: String;
begin
  Result := 'INT_MD5KEY';
end;

function TImportaTintometricosTerceirosINT.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    INT_DESCOR,         ';
  Result := Result + '    INT_CODBAS,         ';
  Result := Result + '    INT_CODNFM,         ';
  Result := Result + '    INT_CODEMB,         ';
  Result := Result + '    INT_LINHA_,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    INT_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    INT_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    INT_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    INT_CADINT          ';
  Result := Result + '  INNER JOIN INT_CADBAS ON      ';
  Result := Result + '    INT_CODBAS = BAS_CODBAS AND       ';
  Result := Result + '    INT_CODEMB = BAS_CODEMB           ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    INT_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosINT.fNomeTabela: String;
begin
  Result := 'INT_CADINT_SIT';
end;

function TImportaTintometricosTerceirosINT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    INT_CODBAS AS CODBAS,       ';
  Result := Result + '    INT_LINHA_ AS LINHA_,       ';
  Result := Result + '    INT_DESCOR AS DESCOR,       ';
  Result := Result + '    INT_CODEMB AS CODEMB,       ';
  Result := Result + '    INT_CODITE AS CODITE,       ';
  Result := Result + '    INT_DESITE AS DESITE,       ';
  Result := Result + '    INT_REFERE AS REFERE,       ';
  Result := Result + '    INT_MD5KEY AS MD5KEY,       ';
  Result := Result + '    INT_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosIQU }

function TImportaTintometricosTerceirosIQU.fCampoCodIte: String;
begin
  Result := 'IQU_CODITE';
end;

function TImportaTintometricosTerceirosIQU.fCampoMD5: String;
begin
  Result := 'IQU_MD5KEY';
end;

function TImportaTintometricosTerceirosIQU.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    IQU_UNIDAD,           ';
  Result := Result + '    IQU_CODIGO,           ';
  Result := Result + '    IQU_DESCRI,           ';
  Result := Result + '    IQU_CODBAS,           ';
  Result := Result + '    IQU_CODEMB,           ';
  Result := Result + '    IQU_PRODUT,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For IntContador := 1 To 20 Do
  Begin
    Result := Result + '    IQU_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    IQU_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    IQU_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    IQU_CADIQU            ';
  Result := Result + '  INNER JOIN IQU_CADBAS ON        ';
  Result := Result + '    IQU_CODBAS = BAS_BASE__ AND         ';
  Result := Result + '    IQU_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    IQU_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    IQU_MD5KEY = :MD5KEY                ';
end;

function TImportaTintometricosTerceirosIQU.fNomeTabela: String;
begin
  Result := 'IQU_CADIQU_SIT';
end;

function TImportaTintometricosTerceirosIQU.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    IQU_CODBAS AS CODBAS,       ';
  Result := Result + '    IQU_DESCRI AS DESCRI,       ';
  Result := Result + '    IQU_DESCRI AS NOMCOR,       ';
  Result := Result + '    IQU_PRODUT AS PRODUT,       ';
  Result := Result + '    IQU_UNIDAD AS UNIDAD,       ';
  Result := Result + '    IQU_CODEMB AS CODEMB,       ';
  Result := Result + '    IQU_CODITE AS CODITE,       ';
  Result := Result + '    IQU_DESITE AS DESITE,       ';
  Result := Result + '    IQU_REFERE AS REFERE,       ';
  Result := Result + '    IQU_MD5KEY AS MD5KEY,       ';
  Result := Result + '    IQU_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosJOT }

function TImportaTintometricosTerceirosJOT.fCampoCodIte: String;
begin
  Result := 'JOT_CODITE';
end;

function TImportaTintometricosTerceirosJOT.fCampoMD5: String;
begin
  Result := 'JOT_MD5KEY';
end;

function TImportaTintometricosTerceirosJOT.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    JOT_DESCRI,       ';
  Result := Result + '    JOT_CODUNI,       ';
  Result := Result + '    JOT_BASE__,       ';
  Result := Result + '    JOT_NOMCOR,       ';
  Result := Result + '    JOT_REFERE,       ';
  Result := Result + '    JOT_TIPO__,       ';
  Result := Result + '    JOT_EMBALA,       ';
  Result := Result + '    JOT_DTACAD,       ';
  Result := Result + '    JOT_DESCRI,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    JOT_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    JOT_QTDB' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    JOT_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    JOT_CADJOT        ';
  Result := Result + '  INNER JOIN JOT_CADBAS ON      ';
  Result := Result + '    JOT_BASE__ = BAS_CODBAS AND       ';
  Result := Result + '    JOT_CODUNI = BAS_CODUNI AND       ';
  Result := Result + '    JOT_EMBALA = BAS_EMBALA AND       ';
  Result := Result + '    JOT_TIPO__ = BAS_TIPO__           ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE           ';
  Result := Result + '  WHERE               ';
  Result := Result + '    JOT_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosJOT.fNomeTabela: String;
begin
  Result := 'JOT_CADJOT_SIT';
end;

function TImportaTintometricosTerceirosJOT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    JOT_BASE__ AS BASE__,       ';
  Result := Result + '    JOT_NOMCOR AS NOMCOR,       ';
  Result := Result + '    JOT_DESCRI AS DESCRI,       ';
  Result := Result + '    JOT_CODUNI AS CODUNI,       ';
  Result := Result + '    JOT_REFERE AS REFERE,       ';
  Result := Result + '    JOT_TIPO__ AS TIPO__,       ';
  Result := Result + '    JOT_EMBALA AS EMBALA,       ';
  Result := Result + '    JOT_CODITE AS CODITE,       ';
  Result := Result + '    JOT_DESITE AS DESITE,       ';
  Result := Result + '    JOT_REFITE AS REFITE,       ';
  Result := Result + '    JOT_MD5KEY AS MD5KEY,       ';
  Result := Result + '    JOT_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosKIL }

function TImportaTintometricosTerceirosKIL.fCampoCodIte: String;
begin
  Result := 'KIL_CODITE';
end;

function TImportaTintometricosTerceirosKIL.fCampoMD5: String;
begin
  Result := 'KIL_MD5KEY';
end;

function TImportaTintometricosTerceirosKIL.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    KIL_CODCOR,             ';
  Result := Result + '    KIL_DESCRI,             ';
  Result := Result + '    KIL_REFERE,             ';
  Result := Result + '    KIL_CODBAS,             ';
  Result := Result + '    KIL_CODUNI,             ';
  Result := Result + '    KIL_CODFML,             ';
  Result := Result + '    ITE_CODITE,             ';
  Result := Result + '    ITE_DESITE,             ';
  Result := Result + '    ITE_REFERE,             ';
  Result := Result + '    KIL_NOMCOR,             ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    KIL_FORM' + fStrZero(intCont, 2) + ',   ';
    Result := Result + '    KIL_QTDB' + fStrZero(intCont, 2) + ',   ';
  End;

  Result := Result + '    KIL_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    KILD_CADKIL             ';
  Result := Result + '  INNER JOIN KILD_CADBAS ON       ';
  Result := Result + '    KIL_CODBAS = BAS_CODBAS AND           ';
  Result := Result + '    KIL_CODUNI = BAS_CODUNI AND           ';
  Result := Result + '    KIL_CODFML = BAS_CODFML               ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    KIL_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosKIL.fNomeTabela: String;
begin
  Result := 'KILD_CADKIL_SIT';
end;

function TImportaTintometricosTerceirosKIL.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    KIL_CODBAS AS CODBAS,     ';
  Result := Result + '    KIL_DESCRI AS DESCRI,     ';
  Result := Result + '    KIL_NOMCOR AS NOMCOR,     ';
  Result := Result + '    KIL_CODUNI AS CODUNI,     ';
  Result := Result + '    KIL_REFERE AS REFERE,     ';
  Result := Result + '    KIL_CODFML AS CODFML,     ';
  Result := Result + '    KIL_CODITE AS CODITE,     ';
  Result := Result + '    KIL_DESITE AS DESITE,     ';
  Result := Result + '    KIL_REFITE AS REFITE,     ';
  Result := Result + '    KIL_MD5KEY AS MD5KEY,     ';
  Result := Result + '    KIL_PREVEN AS PREVEN      ';
end;

{ TImportaTintometricosTerceirosLIK }

function TImportaTintometricosTerceirosLIK.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosLIK.fCampoMD5: String;
begin
  Result := 'LIK_MD5KEY';
end;

function TImportaTintometricosTerceirosLIK.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    LIK_DESCRI,     ';
  Result := Result + '    LIK_UNIDAD,     ';
  Result := Result + '    LIK_CODIGO,     ';
  Result := Result + '    LIK_CODBAS,     ';
  Result := Result + '    LIK_PRODUT,     ';
  Result := Result + '    LIK_ACABAM,     ';
  Result := Result + '    LIK_CODEMB,     ';
  Result := Result + '    ITE_CODITE,     ';
  Result := Result + '    ITE_DESITE,     ';
  Result := Result + '    ITE_REFERE,     ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    LIK_FORM' + fStrZero(intCont, 2) + ',   ';
    Result := Result + '    LIK_QTDC' + fStrZero(intCont, 2) + ',   ';
  End;

  Result := Result + '    LIK_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    LIK_CADLIK      ';
  Result := Result + '  INNER JOIN LIK_CADBAS ON      ';
  Result := Result + '    LIK_CODBAS = BAS_BASE__ AND         ';
  Result := Result + '    LIK_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE             ';
  Result := Result + '    LIK_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosLIK.fNomeTabela: String;
begin
  Result := 'LIK_CADLIK_SIT';
end;

function TImportaTintometricosTerceirosLIK.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    LIK_CODBAS AS CODBAS,         ';
  Result := Result + '    LIK_DESCRI AS DESCRI,         ';
  Result := Result + '    LIK_PRODUT AS PRODUT,         ';
  Result := Result + '    LIK_UNIDAD AS UNIDAD,         ';
  Result := Result + '    LIK_ACABAM AS ACABAM,         ';
  Result := Result + '    LIK_CODEMB AS CODEMB,         ';
  Result := Result + '    LIK_CODITE AS CODITE,         ';
  Result := Result + '    LIK_DESITE AS DESITE,         ';
  Result := Result + '    LIK_REFERE AS REFERE,         ';
  Result := Result + '    LIK_MD5KEY AS MD5KEY,         ';
  Result := Result + '    LIK_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosLKS }

function TImportaTintometricosTerceirosLKS.fCampoCodIte: String;
begin
  Result := 'LKD_CODITE';
end;

function TImportaTintometricosTerceirosLKS.fCampoMD5: String;
begin
  Result := 'LKD_MD5KEY';
end;

function TImportaTintometricosTerceirosLKS.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    LKD_DESCRI,         ';
  Result := Result + '    LKD_CODIGO,         ';
  Result := Result + '    LKD_CODIG2,         ';
  Result := Result + '    LKD_UNIDAD,         ';
  Result := Result + '    LKD_SUBKEY,         ';
  Result := Result + '    LKD_BASE__,         ';
  Result := Result + '    LKD_PROKEY,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    LKD_FORM' + fStrZero(intCont, 2) + ',   ';
    Result := Result + '    LKD_QTDB' + fStrZero(intCont, 2) + ',   ';
  End;

  Result := Result + '  LKD_MD5KEY            ';
  Result := Result + '  FROM                  ';
  Result := Result + '    LKD_CADLKD          ';
  Result := Result + '  INNER JOIN LKD_CADBAS ON        ';
  Result := Result + '    LKD_BASE__ = BAS_BASE__ AND         ';
  Result := Result + '    LKD_PROKEY = BAS_PROKEY AND         ';
  Result := Result + '    LKD_SUBKEY = BAS_SUBKEY AND         ';
  Result := Result + '    LKD_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    LKD_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosLKS.fNomeTabela: String;
begin
  Result := 'LKD_CADLKD_SIT';
end;

function TImportaTintometricosTerceirosLKS.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    LKD_BASE__ AS BASE__,       ';
  Result := Result + '    LKD_PROKEY AS PROKEY,       ';
  Result := Result + '    LKD_SUBKEY AS SUBKEY,       ';
  Result := Result + '    LKD_UNIDAD AS UNIDAD,       ';
  Result := Result + '    LKD_DESCRI AS DESCRI,       ';
  Result := Result + '    LKD_DESCRI AS NOMCOR,       ';
  Result := Result + '    LKD_CODITE AS CODITE,       ';
  Result := Result + '    LKD_DESITE AS DESITE,       ';
  Result := Result + '    LKD_REFERE AS REFERE,       ';
  Result := Result + '    LKD_MD5KEY AS MD5KEY,       ';
  Result := Result + '    LKD_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosMZI }

function TImportaTintometricosTerceirosMZI.fCampoCodIte: String;
begin
  Result := 'MZI_CODITE';
end;

function TImportaTintometricosTerceirosMZI.fCampoMD5: String;
begin
  Result := 'MZI_MD5KEY'
end;

function TImportaTintometricosTerceirosMZI.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    MZI_CODMZI,       ';
  Result := Result + '    MZI_COLNAM,       ';
  Result := Result + '    MZI_COLNUM,       ';
  Result := Result + '    MZI_CODUNI,       ';
  Result := Result + '    MZI_CODBAS,       ';
  Result := Result + '    MZI_DTACAD,       ';
  Result := Result + '    MZI_PRODUT,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    MZI_CODC' + fStrZero(intCont, 2) + ',   ';
    Result := Result + '    MZI_QTDC' + fStrZero(intCont, 2) + ',   ';
  End;

  Result := Result + '    MZI_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    MZI_CADMZI        ';
  Result := Result + '  INNER JOIN MZI_CADBAS ON        ';
  Result := Result + '    MZI_CODBAS = BAS_CODBAS AND         ';
  Result := Result + '    MZI_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    MZI_CODUNI = BAS_CODUNI             ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE               ';
  Result := Result + '    MZI_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosMZI.fNomeTabela: String;
begin
  Result := 'MZI_CADMZI_SIT';
end;

function TImportaTintometricosTerceirosMZI.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    MZI_CODBAS AS CODBAS,     ';
  Result := Result + '    MZI_PRODUT AS DESCRI,     ';
  Result := Result + '    MZI_PRODUT AS NOMCOR,     ';
  Result := Result + '    MZI_COLNAM AS COLNAM,     ';
  Result := Result + '    MZI_COLNUM AS COLNUM,     ';
  Result := Result + '    MZI_CODUNI AS CODUNI,     ';
  Result := Result + '    MZI_CODITE AS CODITE,     ';
  Result := Result + '    MZI_DESITE AS DESITE,     ';
  Result := Result + '    MZI_REFERE AS REFERE,     ';
  Result := Result + '    MZI_MD5KEY AS MD5KEY,     ';
  Result := Result + '    MZI_PREVEN AS PREVEN      ';
end;

{ TImportaTintometricosTerceirosMZD }

function TImportaTintometricosTerceirosMZD.fCampoCodIte: String;
begin
  Result := 'MZD_CODITE';
end;

function TImportaTintometricosTerceirosMZD.fCampoMD5: String;
begin
  Result := 'MZD_MD5KEY';
end;

function TImportaTintometricosTerceirosMZD.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MZD_CODIGO,           ';
  Result := Result + '    MZD_DESCRI,           ';
  Result := Result + '    MZD_DTACAD,           ';
  Result := Result + '    MZD_VARIAC,           ';
  Result := Result + '    MZD_OBSERV,           ';
  Result := Result + '    MZD_ANOCOR,           ';
  Result := Result + '    MZD_PESCOR,           ';
  Result := Result + '    MZD_PESFOR,           ';
  Result := Result + '    MZD_LINHA_,           ';
  Result := Result + '    LIN_DESCRI,           ';
  Result := Result + '    MON_DESCRI,           ';
  Result := Result + '    MZD_CODNFM,           ';
  Result := Result + '    MZD_UNIVER,           ';
  Result := Result + '    MZD_CODMON,           ';
  Result := Result + '    MZD_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    MZD_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MZD_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    MZD_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MZD_CADMZD            ';
  Result := Result + '  LEFT JOIN MZD_CADMON ON             ';
  Result := Result + '    MON_CODMON = MZD_CODMON                 ';
  Result := Result + '  LEFT JOIN MZD_CADLIN ON             ';
  Result := Result + '    LIN_CODIGO = MZD_LINHA_                 ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    MZD_MD5KEY = :MD5KEY              ';
end;

function TImportaTintometricosTerceirosMZD.fNomeTabela: String;
begin
  Result := 'MZD_CADMZD_SIT';
end;

function TImportaTintometricosTerceirosMZD.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    MZD_CODIGO AS CODIGO,       ';
  Result := Result + '    MZD_DESCRI AS DESCRI,       ';
  Result := Result + '    MZD_DESCRI AS NOMCOR,       ';
  Result := Result + '    ITE_REFERE AS REFERE,       ';
  Result := Result + '    MZD_LINHA_ AS LINHA_,       ';
  Result := Result + '    MZD_VARIAC AS VARIAC,       ';
  Result := Result + '    MZD_OBSERV AS OBSERV,       ';
  Result := Result + '    MZD_UNIVER AS UNIVER,       ';
  Result := Result + '    MZD_CODMON AS CODMON,       ';
  Result := Result + '    MZD_CODITE AS CODITE,       ';
  Result := Result + '    MZD_CODDIL AS CODDIL,       ';
  Result := Result + '    MZD_PORDIL AS PORDIL,       ';
  Result := Result + '    MZD_PRECLT AS PRECLT,       ';
  Result := Result + '    MZD_PRECGL AS PRECGL,       ';
  Result := Result + '    MZD_PRECLA AS PRECLA,       ';
  Result := Result + '    MZD_PRECCP AS PRECCP,       ';
  Result := Result + '    MZD_PRECSP AS PRECSP,       ';
  Result := Result + '    MZD_PREDLT AS PREDLT,       ';
  Result := Result + '    MZD_PREDGL AS PREDGL,       ';
  Result := Result + '    MZD_PREDLA AS PREDLA,       ';
  Result := Result + '    MZD_PREDCP AS PREDCP,       ';
  Result := Result + '    MZD_PREDSP AS PREDSP,       ';
  Result := Result + '    MZD_EMBALT AS EMBALT,       ';
  Result := Result + '    MZD_EMBAGL AS EMBAGL,       ';
  Result := Result + '    MZD_EMBALA AS EMBALA,       ';
  Result := Result + '    MZD_EMBACP AS EMBACP,       ';
  Result := Result + '    MZD_EMBASP AS EMBASP,       ';
  Result := Result + '    MZD_VOLULT AS VOLULT,       ';
  Result := Result + '    MZD_VOLUGL AS VOLUGL,       ';
  Result := Result + '    MZD_VOLULA AS VOLULA,       ';
  Result := Result + '    MZD_VOLUCP AS VOLUCP,       ';
  Result := Result + '    MZD_VOLUSP AS VOLUSP,       ';
  Result := Result + '    MZD_PREELT AS PREELT,       ';
  Result := Result + '    MZD_PREEGL AS PREEGL,       ';
  Result := Result + '    MZD_PREELA AS PREELA,       ';
  Result := Result + '    MZD_PREECP AS PREECP,       ';
  Result := Result + '    MZD_PREESP AS PREESP,       ';
  Result := Result + '    MZD_TIPOLT AS TIPOLT,       ';
  Result := Result + '    MZD_TIPOGL AS TIPOGL,       ';
  Result := Result + '    MZD_TIPOLA AS TIPOLA,       ';
  Result := Result + '    MZD_TIPOCP AS TIPOCP,       ';
  Result := Result + '    MZD_TIPOSP AS TIPOSP        ';
end;

{ TImportaTintometricosTerceirosMEG }

function TImportaTintometricosTerceirosMEG.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosMEG.fCampoMD5: String;
begin
  Result := 'MEG_MD5KEY';
end;

function TImportaTintometricosTerceirosMEG.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MEG_CODIGO,           ';
  Result := Result + '    MEG_DESCRI,           ';
  Result := Result + '    MEG_REFERE,           ';
  Result := Result + '    MEG_DTACAD,           ';
  Result := Result + '    MEG_CODUNI,           ';
  Result := Result + '    MEG_BASE__,           ';
  Result := Result + '    MEG_PRODUT,           ';
  Result := Result + '    MEG_COLECA,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    MEG_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    MEG_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    MEG_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MEG_CADMEG            ';
  Result := Result + '  INNER JOIN MEG_CADBAS ON          ';
  Result := Result + '    MEG_BASE__ = BAS_CODBAS AND         ';
  Result := Result + '    MEG_CODUNI = BAS_CODUNI AND         ';
  Result := Result + '    MEG_PRODUT = BAS_PRODUT             ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    MEG_MD5KEY  = :MD5KEY           ';
end;

function TImportaTintometricosTerceirosMEG.fNomeTabela: String;
begin
  Result := 'MEG_CADMEG_SIT';
end;

function TImportaTintometricosTerceirosMEG.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    MEG_BASE__ AS BASE__,         ';
  Result := Result + '    MEG_DESCRI AS DESCRI,         ';
  Result := Result + '    MEG_PRODUT AS PRODUT,         ';
  Result := Result + '    MEG_CODUNI AS CODUNI,         ';
  Result := Result + '    MEG_REFERE AS REFERE,         ';
  Result := Result + '    MEG_CODITE AS CODITE,         ';
  Result := Result + '    MEG_DESITE AS DESITE,         ';
  Result := Result + '    MEG_REFITE AS REFITE,         ';
  Result := Result + '    MEG_MD5KEY AS MD5KEY,         ';
  Result := Result + '    MEG_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosMON }

function TImportaTintometricosTerceirosMON.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosMON.fCampoMD5: String;
begin
  Result := 'MON_MD5KEY';
end;

function TImportaTintometricosTerceirosMON.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '    SELECT                ';
  Result := Result + '      MON_CODSEQ,         ';
  Result := Result + '      MON_DESCOR,         ';
  Result := Result + '      MON_PRODUT,         ';
  Result := Result + '      MON_DESCRI,         ';
  Result := Result + '      MON_CODBAS,         ';
  Result := Result + '      BAS_DESCRI,         ';
  Result := Result + '      MON_ACABAM,         ';
  Result := Result + '      MON_DTACAD,         ';
  Result := Result + '      MON_UNIDAD,         ';
  Result := Result + '      ITE_CODITE,         ';
  Result := Result + '      ITE_DESITE,         ';
  Result := Result + '      ITE_REFERE,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '      MON_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '      MON_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '      MON_MD5KEY          ';
  Result := Result + '    FROM                  ';
  Result := Result + '      MON_CADMON          ';
  Result := Result + '    INNER JOIN MON_CADBAS ON        ';
  Result := Result + '      BAS_CODBAS = MON_CODBAS AND           ';
  Result := Result + '      BAS_UNIDAD = MON_UNIDAD AND           ';
  Result := Result + '      BAS_PRODUT = MON_PRODUT AND           ';
  Result := Result + '      BAS_ACABAM = MON_ACABAM               ';
  Result := Result + '    INNER JOIN CADITE ON            ';
  Result := Result + '      BAS_CODITE = ITE_CODITE               ';
end;

function TImportaTintometricosTerceirosMON.fNomeTabela: String;
begin
  Result := 'MON_CADMON_SIT';
end;

function TImportaTintometricosTerceirosMON.fSelect: String;
begin
  Result := '';
  Result := Result + '    SELECT                            ';
  Result := Result + '      MON_CODBAS AS CODBAS,           ';
  Result := Result + '      MON_UNIDAD AS UNIDAD,           ';
  Result := Result + '      MON_PRODUT AS PRODUT,           ';
  Result := Result + '      MON_DESCRI AS DESCRI,           ';
  Result := Result + '      MON_ACABAM AS ACABAM,           ';
  Result := Result + '      MON_CODITE AS CODITE,           ';
  Result := Result + '      MON_DESITE AS DESITE,           ';
  Result := Result + '      MON_REFERE AS REFERE,           ';
  Result := Result + '      MON_MD5KEY AS MD5KEY,           ';
  Result := Result + '      MON_PREVEN AS PREVEN            ';
end;

{ TImportaTIntometricosTerceirosNEX }

function TImportaTIntometricosTerceirosNEX.fCampoCodIte: String;
begin
  Result := 'NEX_CODITE';
end;

function TImportaTIntometricosTerceirosNEX.fCampoMD5: String;
begin
  Result := 'NEX_MD5KEY';
end;

function TImportaTIntometricosTerceirosNEX.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    NEX_DESCOR,         ';
  Result := Result + '    NEX_TIPO__,         ';
  Result := Result + '    BAS_TIPO__,         ';
  Result := Result + '    MON_DESCRI,         ';
  Result := Result + '    NEX_VEICUL,         ';
  Result := Result + '    SUBSTR(NEX_A_N_O_, 1, 4) AS ANO_INICIAL,      ';
  Result := Result + '    SUBSTR(NEX_A_N_O_, 6, 4) AS ANO_FINAL,        ';
  Result := Result + '    NEX_CODCOR,         ';
  Result := Result + '    NEX_CODATC,         ';
  Result := Result + '    NEX_MONTAD,         ';
  Result := Result + '    NEX_A_N_O_,         ';
  Result := Result + '    NEX_MARCA_,         ';
  Result := Result + '    NEX_VARIAN,         ';
  Result := Result + '    NEX_REFERE,         ';
  Result := Result + '    NEX_SISTEM,         ';
  Result := Result + '    NEX_PAISES,         ';
  Result := Result + '    NEX_ORIGEM,         ';
  Result := Result + '    NEX_UTILIZ,         ';
  Result := Result + '    NEX_EFEFIN,         ';
  Result := Result + '    NEX_ACRMOB,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    NEX_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    NEX_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    NEX_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    NEX_CADNEX          ';
  Result := Result + '  LEFT JOIN NEX_CADMON ON       ';
  Result := Result + '    NEX_MONTAD = MON_CODMON           ';
  Result := Result + '  INNER JOIN NEX_CADBAS ON      ';
  Result := Result + '    NEX_CODB01 = BAS_CODBAS AND       ';
  Result := Result + '    IFNULL(NEX_ATIVO_, "S") = "S"     ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    NEX_MD5KEY = :MD5KEY              ';
end;

function TImportaTIntometricosTerceirosNEX.fNomeTabela: String;
begin
  Result := 'NEX_CADNEX_SIT';
end;

function TImportaTIntometricosTerceirosNEX.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    NEX_DESCOR AS DESCOR,         ';
  Result := Result + '    NEX_CODCOR AS CODCOR,         ';
  Result := Result + '    NEX_CODATC AS CODATC,         ';
  Result := Result + '    NEX_MARCA_ AS MARCA_,         ';
  Result := Result + '    NEX_SISTEM AS SISTEM,         ';
  Result := Result + '    NEX_UTILIZ AS UTILIZ,         ';
  Result := Result + '    NEX_EFEFIN AS EFEFIN,         ';
  Result := Result + '    NEX_ORIGEM AS ORIGEM,         ';
  Result := Result + '    NEX_PAISES AS PAISES,         ';
  Result := Result + '    NEX_VEICUL AS VEICUL,         ';
  Result := Result + '    NEX_MONTAD AS MONTAD,         ';
  Result := Result + '    NEX_TIPO__ AS TIPO__,         ';
  Result := Result + '    NEX_MD5KEY AS MD5KEY,         ';
  Result := Result + '    NEX_CODITE AS CODITE,         ';
  Result := Result + '    NEX_CODDIL AS CODDIL,         ';
  Result := Result + '    NEX_PORDIL AS PORDIL,         ';
  Result := Result + '    NEX_PRECLT AS PRECLT,         ';
  Result := Result + '    NEX_PRECGL AS PRECGL,         ';
  Result := Result + '    NEX_PRECBD AS PRECBD,         ';
  Result := Result + '    NEX_PRECTB AS PRECTB,         ';
  Result := Result + '    NEX_PRECCP AS PRECCP,         ';
  Result := Result + '    NEX_PREDLT AS PREDLT,         ';
  Result := Result + '    NEX_PREDGL AS PREDGL,         ';
  Result := Result + '    NEX_PREDBD AS PREDBD,         ';
  Result := Result + '    NEX_PREDTB AS PREDTB,         ';
  Result := Result + '    NEX_PREDCP AS PREDCP,         ';
  Result := Result + '    NEX_EMBALT AS EMBALT,         ';
  Result := Result + '    NEX_EMBAGL AS EMBAGL,         ';
  Result := Result + '    NEX_EMBABD AS EMBABD,         ';
  Result := Result + '    NEX_EMBATB AS EMBATB,         ';
  Result := Result + '    NEX_EMBACP AS EMBACP,         ';
  Result := Result + '    NEX_VOLULT AS VOLULT,         ';
  Result := Result + '    NEX_VOLUGL AS VOLUGL,         ';
  Result := Result + '    NEX_VOLUBD AS VOLUBD,         ';
  Result := Result + '    NEX_VOLUTB AS VOLUTB,         ';
  Result := Result + '    NEX_VOLUCP AS VOLUCP,         ';
  Result := Result + '    NEX_PREELT AS PREELT,         ';
  Result := Result + '    NEX_PREEGL AS PREEGL,         ';
  Result := Result + '    NEX_PREEBD AS PREEBD,         ';
  Result := Result + '    NEX_PREETB AS PREETB,         ';
  Result := Result + '    NEX_PREECP AS PREECP,         ';
  Result := Result + '    NEX_TIPOLT AS TIPOLT,         ';
  Result := Result + '    NEX_TIPOGL AS TIPOGL,         ';
  Result := Result + '    NEX_TIPOBD AS TIPOBD,         ';
  Result := Result + '    NEX_TIPOTB AS TIPOTB,         ';
  Result := Result + '    NEX_TIPOCP AS TIPOCP          ';
end;

{ TImportaTintometricosTerceirosLKC }

function TImportaTintometricosTerceirosLKC.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosLKC.fCampoMD5: String;
begin
  Result := 'LKC_MD5KEY';
end;

function TImportaTintometricosTerceirosLKC.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    LKC_CODIGO,       ';
  Result := Result + '    LKC_NOMCOR,       ';
  Result := Result + '    LKC_CODBAS,       ';
  Result := Result + '    LKC_PRODUT,       ';
  Result := Result + '    LKC_UNIDAD,       ';
  Result := Result + '    LKC_COLECA,       ';
  Result := Result + '    LKC_SUBCOL,       ';
  Result := Result + '    LKC_DTACAD,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    LKC_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    LKC_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    LKC_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    LKC_CADLKC        ';
  Result := Result + '  INNER JOIN LKC_CADBAS ON      ';
  Result := Result + '    LKC_CODBAS = BAS_CODBAS AND         ';
  Result := Result + '    LKC_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    LKC_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE               ';
  Result := Result + '    LKC_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosLKC.fNomeTabela: String;
begin
  Result := 'LKC_CADLKC_SIT';
end;

function TImportaTintometricosTerceirosLKC.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    LKC_CODBAS AS CODBAS,       ';
  Result := Result + '    LKC_PRODUT AS PRODUT,       ';
  Result := Result + '    LKC_NOMCOR AS NOMCOR,       ';
  Result := Result + '    LKC_UNIDAD AS UNIDAD,       ';
  Result := Result + '    LKC_COLECA AS COLECA,       ';
  Result := Result + '    LKC_SUBCOL AS SUBCOL,       ';
  Result := Result + '    LKC_CODITE AS CODITE,       ';
  Result := Result + '    LKC_DESITE AS DESITE,       ';
  Result := Result + '    LKC_REFERE AS REFERE,       ';
  Result := Result + '    LKC_MD5KEY AS MD5KEY,       ';
  Result := Result + '    LKC_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosPPX }

function TImportaTintometricosTerceirosPPX.fCampoCodIte: String;
begin
  Result := 'PPX_CODITE';
end;

function TImportaTintometricosTerceirosPPX.fCampoMD5: String;
begin
  Result := 'PPX_MD5KEY';
end;

function TImportaTintometricosTerceirosPPX.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '     PPX_DESCOR,  ';
  Result := Result + '     PPX_CODCOR,  ';
  Result := Result + '     PPX_CODATC,  ';
  Result := Result + '     PPX_VARIAN,  ';
  Result := Result + '     PPX_REFERE,  ';
  Result := Result + '     PPX_MARCA_,  ';
  Result := Result + '     PPX_UTILIZ,  ';
  Result := Result + '     PPX_SISTEM,  ';
  Result := Result + '     PPX_EFEFIN,  ';
  Result := Result + '     PPX_ORIGEM,  ';
  Result := Result + '     PPX_PAISES,  ';
  Result := Result + '     PPX_VEICUL,  ';
  Result := Result + '     PPX_MONTAD,  ';
  Result := Result + '     PPX_A_N_O_,  ';
  Result := Result + '     PPX_TIPO__,  ';
  Result := Result + '     PPX_MD5KEY,  ';
  Result := Result + '     MON_DESCRI,  ';
  Result := Result + '     PPX_CODB01,  ';
  Result := Result + '     PPX_CODB02,  ';
  Result := Result + '     PPX_CODB03,  ';
  Result := Result + '     PPX_CODB04,  ';
  Result := Result + '     PPX_CODB05,  ';
  Result := Result + '     PPX_CODB06,  ';
  Result := Result + '     PPX_CODB07,  ';
  Result := Result + '     PPX_CODB08,  ';
  Result := Result + '     PPX_CODB09,  ';
  Result := Result + '     PPX_CODB10,  ';
  Result := Result + '     PPX_CODB11,  ';
  Result := Result + '     PPX_CODB12,  ';
  Result := Result + '     PPX_CODB13,  ';
  Result := Result + '     PPX_CODB14,  ';
  Result := Result + '     PPX_CODB15,  ';
  Result := Result + '     PPX_CODB16,  ';
  Result := Result + '     PPX_CODB17,  ';
  Result := Result + '     PPX_CODB18,  ';
  Result := Result + '     PPX_CODB19,  ';
  Result := Result + '     PPX_CODB20,  ';
  Result := Result + '     PPX_QTDB01,  ';
  Result := Result + '     PPX_QTDB02,  ';
  Result := Result + '     PPX_QTDB03,  ';
  Result := Result + '     PPX_QTDB04,  ';
  Result := Result + '     PPX_QTDB05,  ';
  Result := Result + '     PPX_QTDB06,  ';
  Result := Result + '     PPX_QTDB07,  ';
  Result := Result + '     PPX_QTDB08,  ';
  Result := Result + '     PPX_QTDB09,  ';
  Result := Result + '     PPX_QTDB10,  ';
  Result := Result + '     PPX_QTDB11,  ';
  Result := Result + '     PPX_QTDB12,  ';
  Result := Result + '     PPX_QTDB13,  ';
  Result := Result + '     PPX_QTDB14,  ';
  Result := Result + '     PPX_QTDB15,  ';
  Result := Result + '     PPX_QTDB16,  ';
  Result := Result + '     PPX_QTDB17,  ';
  Result := Result + '     PPX_QTDB18,  ';
  Result := Result + '     PPX_QTDB19,  ';
  Result := Result + '     PPX_QTDB20   ';
  Result := Result + ' FROM PPX_CADPPX  ';
  Result := Result + '   INNER JOIN PPX_CADBAS  ';
  Result := Result + '     ON PPX_CODB01 = BAS_CODBAS ';
  Result := Result + '   LEFT JOIN PPX_CADMON         ';
  Result := Result + '     ON PPX_MONTAD = MON_CODMON ';
  Result := Result + ' WHERE PPX_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosPPX.fNomeTabela: String;
begin
  Result := 'PPX_CADPPX_SIT';
end;

function TImportaTintometricosTerceirosPPX.fSelect: String;
begin
  Result := '     SELECT PPX_DESCOR AS NOMCOR, ';
  Result := Result + '   PPX_CODCOR AS CODCOR, ';
  Result := Result + '   PPX_CODATC AS DESCRI, ';
  Result := Result + '   ITE_REFERE AS REFERE, ';
  Result := Result + '   PPX_MARCA_ AS MARCA_, ';
  Result := Result + '   PPX_UTILIZ AS UTILIZ, ';
  Result := Result + '   PPX_SISTEM AS SISTEM, ';
  Result := Result + '   PPX_EFEFIN AS EFETIN, ';
  Result := Result + '   PPX_ORIGEM AS ORIGEM, ';
  Result := Result + '   PPX_PAISES AS PAISES, ';
  Result := Result + '   PPX_VEICUL AS VEICUL, ';
  Result := Result + '   PPX_MONTAD AS MONTAD, '; //descrição da montadora(PPG_CADMON)
  Result := Result + '   PPX_A_N_O_ AS A_N_O_, ';
  Result := Result + '   PPX_TIPO__ AS TIPO_,  ';
  Result := Result + '   PPX_MD5KEY AS MD5KEY, ';
  Result := Result + '   PPX_CODITE AS CODITE, '; //Produto para venda PPG

  //Campos referentes a preços concentrados de cada embalagem
  Result := Result + '   PPX_PRECLT AS PRECLT, ';
  Result := Result + '   PPX_PRECGL AS PRECGL, ';
  Result := Result + '   PPX_PRECCP AS PRECCP, ';
  Result := Result + '   PPX_PRECBD AS PRECBD, ';
  Result := Result + '   PPX_PRECTB AS PRECTB, ';

  //Campos referentes a preços diluidos de cada embalagem
  Result := Result + '   PPX_PREDLT AS PREDLT, ';
  Result := Result + '   PPX_PREDGL AS PREDGL, ';
  Result := Result + '   PPX_PREDCP AS PREDCP, ';
  Result := Result + '   PPX_PREDBD AS PREDBD, ';
  Result := Result + '   PPX_PREDTB AS PREDTB, ';

  //Campos referentes aos produtos de cada embalagem
  Result := Result + '   PPX_EMBALT AS EMBALT, ';
  Result := Result + '   PPX_EMBAGL AS EMBAGL, ';
  Result := Result + '   PPX_EMBACP AS EMBACP, ';
  Result := Result + '   PPX_EMBABD AS EMBABD, ';
  Result := Result + '   PPX_EMBATB AS EMBATB, ';

  //Campos referentes aos volumes de cada embalagem
  Result := Result + '   PPX_VOLULT AS VOLULT, ';
  Result := Result + '   PPX_VOLUGL AS VOLUGL, ';
  Result := Result + '   PPX_VOLUCP AS VOLUCP, ';
  Result := Result + '   PPX_VOLUBD AS VOLUBD, ';
  Result := Result + '   PPX_VOLUTB AS VOLUTB, ';

  //Campos referentes aos preços de cada embalagem
  Result := Result + '   PPX_PREELT AS PREELT, ';
  Result := Result + '   PPX_PREEGL AS PREEGL, ';
  Result := Result + '   PPX_PREECP AS PREECP, ';
  Result := Result + '   PPX_PREEBD AS PREEBD, ';
  Result := Result + '   PPX_PREETB AS PREETB, ';

  //Campos referentes aos tipos de cada embalagem
  Result := Result + '   PPX_TIPOLT AS TIPOLT, ';
  Result := Result + '   PPX_TIPOGL AS TIPOGL, ';
  Result := Result + '   PPX_TIPOCP AS TIPOCP, ';
  Result := Result + '   PPX_TIPOBD AS TIPOBD, ';
  Result := Result + '   PPX_TIPOTB AS TIPOTB  ';
end;

{ TImportaTintometricosTerceirosQUA }

function TImportaTintometricosTerceirosQUA.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosQUA.fCampoMD5: String;
begin
  Result := 'QUA_MD5KEY';
end;

function TImportaTintometricosTerceirosQUA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    QUA_DESCRI,           ';
  Result := Result + '    QUA_CODUNI,           ';
  Result := Result + '    QUA_CODBAS,           ';
  Result := Result + '    QUA_NOMCOR,           ';
  Result := Result + '    QUA_DTACAD,           ';
  Result := Result + '    QUA_PRODUT,           ';
  Result := Result + '    QUA_DESCRI,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    QUA_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    QUA_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    QUA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    QUA_CADQUA            ';
  Result := Result + '  INNER JOIN QUA_CADBAS ON          ';
  Result := Result + '    QUA_CODBAS = BAS_CODBAS AND             ';
  Result := Result + '    QUA_PRODUT = BAS_PRODUT AND             ';
  Result := Result + '    QUA_CODUNI = BAS_CODUNI                 ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                 ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    QUA_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosQUA.fNomeTabela: String;
begin
  Result := 'QUA_CADQUA_SIT';
end;

function TImportaTintometricosTerceirosQUA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    QUA_CODBAS AS CODBAS,       ';
  Result := Result + '    QUA_PRODUT AS PRODUT,       ';
  Result := Result + '    QUA_DESCRI AS DESCRI,       ';
  Result := Result + '    QUA_CODUNI AS CODUNI,       ';
  Result := Result + '    QUA_NOMCOR AS NOMCOR,       ';
  Result := Result + '    QUA_CODITE AS CODITE,       ';
  Result := Result + '    QUA_DESITE AS DESITE,       ';
  Result := Result + '    QUA_REFERE AS REFERE,       ';
  Result := Result + '    QUA_MD5KEY AS MD5KEY,       ';
  Result := Result + '    QUA_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosREC }

function TImportaTintometricosTerceirosREC.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosREC.fCampoMD5: String;
begin
  Result := 'REC_MD5KEY';
end;

function TImportaTintometricosTerceirosREC.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    REC_DESCRI,     ';
  Result := Result + '    REC_UNIDAD,     ';
  Result := Result + '    REC_CODIGO,     ';
  Result := Result + '    REC_CODEMB,     ';
  Result := Result + '    REC_CODBAS,     ';
  Result := Result + '    ITE_CODITE,     ';
  Result := Result + '    ITE_DESITE,     ';
  Result := Result + '    ITE_REFERE,     ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    REC_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    REC_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    REC_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    REC_CADREC      ';
  Result := Result + '  INNER JOIN REC_CADBAS ON      ';
  Result := Result + '    REC_CODBAS = BAS_BASE__ AND         ';
  Result := Result + '    REC_UNIDAD = BAS_UNIDAD             ';
  Result := Result + '  INNER JOIN CADITE ON          ';
  Result := Result + '    BAS_CODITE = ITE_CODITE             ';
  Result := Result + '  WHERE             ';
  Result := Result + '    REC_MD5KEY = :MD5KEY        ';
end;

function TImportaTintometricosTerceirosREC.fNomeTabela: String;
begin
  Result := 'REC_CADREC_SIT';
end;

function TImportaTintometricosTerceirosREC.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    REC_CODBAS AS CODBAS,       ';
  Result := Result + '    REC_DESCRI AS DESCRI,       ';
  Result := Result + '    REC_UNIDAD AS UNIDAD,       ';
  Result := Result + '    REC_CODEMB AS CODEMB,       ';
  Result := Result + '    REC_CODITE AS CODITE,       ';
  Result := Result + '    REC_DESITE AS DESITE,       ';
  Result := Result + '    REC_REFERE AS REFERE,       ';
  Result := Result + '    REC_MD5KEY AS MD5KEY,       ';
  Result := Result + '    REC_PREVEN AS PREVEN        ';
end;

{ TImportaTintometricosTerceirosREN }

function TImportaTintometricosTerceirosREN.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosREN.fCampoMD5: String;
begin
  Result := 'REN_MD5KEY';
end;

function TImportaTintometricosTerceirosREN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_DESCRI,         ';
  Result := Result + '    REN_UNIDAD,         ';
  Result := Result + '    REN_CODIGO,         ';
  Result := Result + '    REN_CODEMB,         ';
  Result := Result + '    REN_DESCRI,         ';
  Result := Result + '    REN_IDENTI,         ';
  Result := Result + '    REN_CODBAS,         ';
  Result := Result + '    REN_DESCRI,         ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    REN_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    REN_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    REN_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    REN_CADREN          ';
  Result := Result + '  INNER JOIN REN_CADBAS ON        ';
  Result := Result + '    REN_CODBAS = BAS_BASE__ AND           ';
  Result := Result + '    REN_UNIDAD = BAS_UNIDAD               ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE               ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    REN_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosREN.fNomeTabela: String;
begin
  Result := 'REN_CADREN_SIT';
end;

function TImportaTintometricosTerceirosREN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    REN_CODBAS AS CODBAS,         ';
  Result := Result + '    REN_DESCRI AS DESCRI,         ';
  Result := Result + '    REN_UNIDAD AS UNIDAD,         ';
  Result := Result + '    REN_IDENTI AS IDENTI,         ';
  Result := Result + '    REN_CODEMB AS CODEMB,         ';
  Result := Result + '    REN_CODITE AS CODITE,         ';
  Result := Result + '    REN_DESITE AS DESITE,         ';
  Result := Result + '    REN_REFERE AS REFERE,         ';
  Result := Result + '    REN_MD5KEY AS MD5KEY,         ';
  Result := Result + '    REN_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosSPA }

function TImportaTintometricosTerceirosSPA.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosSPA.fCampoMD5: String;
begin
  Result := 'SPA_MD5KEY';
end;

function TImportaTintometricosTerceirosSPA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    SPA_CODSPA,           ';
  Result := Result + '    SPA_DESCRI,           ';
  Result := Result + '    SPA_PRODUT,           ';
  Result := Result + '    SPA_REFERE,           ';
  Result := Result + '    SPA_CODUNI,           ';
  Result := Result + '    SPA_CODBAS,           ';
  Result := Result + '    SPA_DTACAD,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    SPA_CODC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    SPA_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    SPA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    SPA_CADSPA            ';
  Result := Result + '  INNER JOIN SPA_CADBAS ON          ';
  Result := Result + '    SPA_CODBAS = BAS_CODBAS AND           ';
  Result := Result + '    SPA_CODUNI = BAS_CODUNI AND           ';
  Result := Result + '    SPA_PRODUT = BAS_PRODUT               ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE               ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    SPA_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosSPA.fNomeTabela: String;
begin
  Result := 'SPA_CADSPA_SIT';
end;

function TImportaTintometricosTerceirosSPA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    SPA_CODBAS AS CODBAS,         ';
  Result := Result + '    SPA_DESCRI AS DESCRI,         ';
  Result := Result + '    SPA_PRODUT AS PRODUT,         ';
  Result := Result + '    SPA_CODUNI AS CODUNI,         ';
  Result := Result + '    SPA_REFERE AS REFERE,         ';
  Result := Result + '    SPA_CODITE AS CODITE,         ';
  Result := Result + '    SPA_DESITE AS DESITE,         ';
  Result := Result + '    SPA_REFITE AS REFITE,         ';
  Result := Result + '    SPA_MD5KEY AS MD5KEY,         ';
  Result := Result + '    SPA_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosDOX }

function TImportaTintometricosTerceirosDOX.fCampoCodIte: String;
begin
  Result := 'DOX_CODITE';
end;

function TImportaTintometricosTerceirosDOX.fCampoMD5: String;
begin
  Result := 'DOX_MD5KEY';
end;

function TImportaTintometricosTerceirosDOX.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    DOX_CODNFM,             ';
  Result := Result + '    DOX_MONTAD,             ';
  Result := Result + '    DOX_DESCRI,             ';
  Result := Result + '    DOX_ANOINI,             ';
  Result := Result + '    DOX_ANOFIN,             ';
  Result := Result + '    DOX_INFCOR,             ';
  Result := Result + '    DOX_PAINEL,             ';
  Result := Result + '    DOX_QUALID,             ';
  Result := Result + '    DOX_CATEGO,             ';
  Result := Result + '    DOX_VARIAN,             ';
  Result := Result + '    DOX_PAIS__,             ';
  Result := Result + '    DOX_CODSEQ,             ';
  Result := Result + '    DOX_CODDOX,             ';
  Result := Result + '    DOX_ACRMOB,             ';
  Result := Result + '    DOX_VERSAO,             ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    DOX_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    DOX_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    DOX_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    DOX_CADDOX              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    DOX_MD5KEY = :MD5KEY              ';
end;

function TImportaTintometricosTerceirosDOX.fNomeTabela: String;
begin
  Result := 'DOX_CADDOX_SIT';
end;

function TImportaTintometricosTerceirosDOX.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                            ';
  Result := Result + '    DOX_DESCRI AS DESCRI,           ';
  Result := Result + '    DOX_MONTAD AS MONTAD,           ';
  Result := Result + '    DOX_PAINEL AS PAINEL,           ';
  Result := Result + '    DOX_INFCOR AS INFCOR,           ';
  Result := Result + '    DOX_PAIS__ AS PAIS__,           ';
  Result := Result + '    DOX_ANOINI AS ANOINI,           ';
  Result := Result + '    DOX_ANOFIN AS ANOFIN,           ';
  Result := Result + '    DOX_QUALID AS QUALID,           ';
  Result := Result + '    DOX_CATEGO AS CATEGO,           ';
  Result := Result + '    DOX_VERSAO AS VERSAO,           ';
  Result := Result + '    DOX_CODITE AS CODITE,           ';
  Result := Result + '    DOX_CODDIL AS CODDIL,           ';
  Result := Result + '    DOX_PORDIL AS PORDIL,           ';
  Result := Result + '    DOX_PRECLT AS PRECLT,           ';
  Result := Result + '    DOX_PRECGL AS PRECGL,           ';
  Result := Result + '    DOX_PREDLT AS PREDLT,           ';
  Result := Result + '    DOX_PREDGL AS PREDGL,           ';
  Result := Result + '    DOX_EMBALT AS EMBALT,           ';
  Result := Result + '    DOX_EMBAGL AS EMBAGL,           ';
  Result := Result + '    DOX_VOLULT AS VOLULT,           ';
  Result := Result + '    DOX_VOLUGL AS VOLUGL,           ';
  Result := Result + '    DOX_PREELT AS PREELT,           ';
  Result := Result + '    DOX_PREEGL AS PREEGL,           ';
  Result := Result + '    DOX_TIPOLT AS TIPOLT,           ';
  Result := Result + '    DOX_TIPOGL AS TIPOGL            ';
end;

{ TImportaTintometricosTerceirosSTA }

function TImportaTintometricosTerceirosSTA.fCampoCodIte: String;
begin
  Result := 'STA_CODITE';
end;

function TImportaTintometricosTerceirosSTA.fCampoMD5: String;
begin
  Result := 'STA_MD5KEY';
end;

function TImportaTintometricosTerceirosSTA.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    STA_CODSEQ,             ';
  Result := Result + '    STA_NOMCOR,             ';
  Result := Result + '    STA_DTACAD,             ';
  Result := Result + '    STA_CODLIN,             ';
  Result := Result + '    STA_DESLIN,             ';
  Result := Result + '    STA_CODMON,             ';
  Result := Result + '    STA_MONTAD,             ';
  Result := Result + '    STA_UNIVER,             ';
  Result := Result + '    STA_ANOCOR,             ';
  Result := Result + '    STA_PESCOR,             ';
  Result := Result + '    STA_ACRMOB,             ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    STA_CODB' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    STA_QTDB' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    STA_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    STA_CADSTA              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    STA_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosSTA.fNomeTabela: String;
begin
  Result := 'STA_CADSTA_SIT';
end;

function TImportaTintometricosTerceirosSTA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    STA_NOMCOR AS NOMCOR,         ';
  Result := Result + '    STA_CODLIN AS CODLIN,         ';
  Result := Result + '    STA_DESLIN AS DESLIN,         ';
  Result := Result + '    STA_CODMON AS CODMON,         ';
  Result := Result + '    STA_MONTAD AS MONTAD,         ';
  Result := Result + '    STA_UNIVER AS UNIVER,         ';
  Result := Result + '    STA_CODITE AS CODITE,         ';
  Result := Result + '    STA_CODDIL AS CODDIL,         ';
  Result := Result + '    STA_PORDIL AS PORDIL,         ';
  Result := Result + '    STA_PRECLT AS PRECLT,         ';
  Result := Result + '    STA_PRECGL AS PRECGL,         ';
  Result := Result + '    STA_PRECLA AS PRECLA,         ';
  Result := Result + '    STA_PRECCP AS PRECCP,         ';
  Result := Result + '    STA_PRECSP AS PRECSP,         ';
  Result := Result + '    STA_PREDLT AS PREDLT,         ';
  Result := Result + '    STA_PREDGL AS PREDGL,         ';
  Result := Result + '    STA_PREDLA AS PREDLA,         ';
  Result := Result + '    STA_PREDCP AS PREDCP,         ';
  Result := Result + '    STA_PREDSP AS PREDSP,         ';
  Result := Result + '    STA_EMBALT AS EMBALT,         ';
  Result := Result + '    STA_EMBAGL AS EMBAGL,         ';
  Result := Result + '    STA_EMBALA AS EMBALA,         ';
  Result := Result + '    STA_EMBACP AS EMBACP,         ';
  Result := Result + '    STA_EMBASP AS EMBASP,         ';
  Result := Result + '    STA_VOLULT AS VOLULT,         ';
  Result := Result + '    STA_VOLUGL AS VOLUGL,         ';
  Result := Result + '    STA_VOLULA AS VOLULA,         ';
  Result := Result + '    STA_VOLUCP AS VOLUCP,         ';
  Result := Result + '    STA_VOLUSP AS VOLUSP,         ';
  Result := Result + '    STA_PREELT AS PREELT,         ';
  Result := Result + '    STA_PREEGL AS PREEGL,         ';
  Result := Result + '    STA_PREELA AS PREELA,         ';
  Result := Result + '    STA_PREECP AS PREECP,         ';
  Result := Result + '    STA_PREESP AS PREESP,         ';
  Result := Result + '    STA_TIPOLT AS TIPOLT,         ';
  Result := Result + '    STA_TIPOGL AS TIPOGL,         ';
  Result := Result + '    STA_TIPOLA AS TIPOLA,         ';
  Result := Result + '    STA_TIPOCP AS TIPOCP,         ';
  Result := Result + '    STA_TIPOSP AS TIPOSP          ';
end;

{ TImportaTintometricosTerceirosUNI }

function TImportaTintometricosTerceirosUNI.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosUNI.fCampoMD5: String;
begin
  Result := 'UNI_MD5KEY';
end;

function TImportaTintometricosTerceirosUNI.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    UNI_GRUPO_,         ';
  Result := Result + '    UNI_PRODUT,         ';
  Result := Result + '    UNI_CODNFM,         ';
  Result := Result + '    UNI_DESCOR,         ';
  Result := Result + '    UNI_CODBAS,         ';
  Result := Result + '    UNI_CODUNI,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';

  For intCont := 1 To 19 Do
  Begin
    Result := Result + '    UNI_CODC' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    UNI_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    UNI_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    UNI_CADUNI          ';
  Result := Result + '  INNER JOIN UNI_CADBAS ON          ';
  Result := Result + '    UNI_PRODUT = BAS_PRODUT AND             ';
  Result := Result + '    UNI_CODBAS = BAS_CODBAS AND             ';
  Result := Result + '    UNI_CODUNI = BAS_UNIDAD                 ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                 ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    UNI_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosUNI.fNomeTabela: String;
begin
  Result := 'UNI_CADUNI_SIT';
end;

function TImportaTintometricosTerceirosUNI.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    UNI_CODBAS AS CODBAS,         ';
  Result := Result + '    UNI_DESCOR AS DESCOR,         ';
  Result := Result + '    UNI_PRODUT AS PRODUT,         ';
  Result := Result + '    UNI_CODUNI AS CODUNI,         ';
  Result := Result + '    UNI_GRUPO_ AS GRUPO_,         ';
  Result := Result + '    UNI_CODITE AS CODITE,         ';
  Result := Result + '    UNI_DESITE AS DESITE,         ';
  Result := Result + '    UNI_REFERE AS REFERE,         ';
  Result := Result + '    UNI_MD5KEY AS MD5KEY,         ';
  Result := Result + '    UNI_PREVEN AS PREVEN          ';
end;

{ TImportaTintometricosTerceirosWEG }

function TImportaTintometricosTerceirosWEG.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosWEG.fCampoMD5: String;
begin
  Result := 'WEG_MD5KEY';
end;

function TImportaTintometricosTerceirosWEG.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    WEG_DESCRI,             ';
  Result := Result + '    WEG_CODIGO,             ';
  Result := Result + '    WEG_CODIG2,             ';
  Result := Result + '    BAS_DESCRI,             ';
  Result := Result + '    WEG_UNIDAD,             ';
  Result := Result + '    WEG_PROKEY,             ';
  Result := Result + '    WEG_SUBKEY,             ';
  Result := Result + '    WEG_NOMCOR,             ';
  Result := Result + '    WEG_BASE__,             ';
  Result := Result + '    ITE_CODITE,             ';
  Result := Result + '    ITE_DESITE,             ';
  Result := Result + '    ITE_REFERE,             ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    WEG_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    WEG_QTDB' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    WEG_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    WEG_CADWEG              ';
  Result := Result + '  INNER JOIN WEG_CADBAS ON            ';
  Result := Result + '    WEG_BASE__ = BAS_BASE__ AND                 ';
  Result := Result + '    WEG_PROKEY = BAS_PROKEY AND                 ';
  Result := Result + '    WEG_SUBKEY = BAS_SUBKEY AND                 ';
  Result := Result + '    WEG_UNIDAD = BAS_UNIDAD                     ';
  Result := Result + '  INNER JOIN CADITE ON                ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                     ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    WEG_MD5KEY = :MD5KEY              ';

end;

function TImportaTintometricosTerceirosWEG.fNomeTabela: String;
begin
  Result := 'WEG_CADWEG_SIT';
end;

function TImportaTintometricosTerceirosWEG.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    WEG_DESCRI AS DESCRI,             ';
  Result := Result + '    WEG_BASE__ AS BASE__,             ';
  Result := Result + '    WEG_PROKEY AS PROKEY,             ';
  Result := Result + '    WEG_SUBKEY AS SUBKEY,             ';
  Result := Result + '    WEG_UNIDAD AS UNIDAD,             ';
  Result := Result + '    WEG_CODITE AS CODITE,             ';
  Result := Result + '    WEG_DESITE AS DESITE,             ';
  Result := Result + '    WEG_REFERE AS REFERE,             ';
  Result := Result + '    WEG_MD5KEY AS MD5KEY,             ';
  Result := Result + '    WEG_PREVEN AS PREVEN              ';
end;

{ TImportaTintometricosTerceirosINK }

function TImportaTintometricosTerceirosINK.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosINK.fCampoMD5: String;
begin
  Result := 'INK_MD5KEY';
end;

function TImportaTintometricosTerceirosINK.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    INK_CODIGO,           ';
  Result := Result + '    INK_BASE__,           ';
  Result := Result + '    INK_DESCRI,           ';
  Result := Result + '    INK_PRODUT,           ';
  Result := Result + '    INK_DTACAD,           ';
  Result := Result + '    ITE_CODITE,           ';
  Result := Result + '    ITE_DESITE,           ';
  Result := Result + '    ITE_REFERE,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    INK_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    INK_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    INK_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    INK_CADINK            ';
  Result := Result + '  INNER JOIN INK_CADBAS ON          ';
  Result := Result + '    INK_BASE__ = BAS_BASE__ AND               ';
  Result := Result + '    INK_PRODUT = BAS_DESCRI AND               ';
  Result := Result + '    INK_UNIDAD = BAS_UNIDAD                   ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    INK_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosINK.fNomeTabela: String;
begin
  Result := 'INK_CADINK_SIT';
end;

function TImportaTintometricosTerceirosINK.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    INK_CODIGO AS CODIGO,         ';
  Result := Result + '    INK_BASE__ AS BASE__,         ';
  Result := Result + '    INK_DESCRI AS DESCRI,         ';
  Result := Result + '    INK_PRODUT AS PRODUT,         ';
  Result := Result + '    INK_UNIDAD AS UNIDAD,         ';
  Result := Result + '    INK_CODITE AS CODITE,         ';
  Result := Result + '    INK_DESITE AS DESITE,         ';
  Result := Result + '    INK_REFERE AS REFERE,         ';
  Result := Result + '    INK_MD5KEY AS MD5KEY,         ';
  Result := Result + '    INK_PREVEN AS PREVEN,         ';
  Result := Result + '    INK_PRECUS AS PRECUS,         ';
  Result := Result + '    INK_PREVE1 AS PREVE1,         ';
  Result := Result + '    INK_PREVE2 AS PREVE2,         ';
  Result := Result + '    INK_PREVE3 AS PREVE3,         ';
  Result := Result + '    INK_PREVE4 AS PREVE4,         ';
  Result := Result + '    INK_PREVE5 AS PREVE5,         ';
  Result := Result + '    INK_PREVE6 AS PREVE6,         ';
  Result := Result + '    INK_PREVE7 AS PREVE7          ';
end;

{ TImportaTintometricosTerceirosSTW }

function TImportaTintometricosTerceirosSTW.fCampoCodIte: String;
begin
  Result := 'STW_CODITE';
end;

function TImportaTintometricosTerceirosSTW.fCampoMD5: String;
begin
  Result := 'STW_MD5KEY';
end;

function TImportaTintometricosTerceirosSTW.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    STW_CODIGO,     ';
  Result := Result + '    STW_NOMCOR,     ';
  Result := Result + '    STW_DTACAD,     ';
  Result := Result + '    STW_CODLIN,     ';
  Result := Result + '    STW_DESLIN,     ';
  Result := Result + '    STW_CODMON,     ';
  Result := Result + '    STW_MONTAD,     ';
  Result := Result + '    STW_UNIVER,     ';
  Result := Result + '    STW_ANOCOR,     ';
  Result := Result + '    STW_PESCOR,     ';
  Result := Result + '    STW_PESFOR,     ';
  Result := Result + '    STW_ACRMOB,     ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '  STW_CODB' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '  STW_QTDB' + fStrZero(intContador, 2) + ',       ';
  End;

  Result := Result + '    STW_MD5KEY      ';
  Result := Result + '  FROM              ';
  Result := Result + '    STW_CADSTW      ';
  Result := Result + '  WHERE             ';
  Result := Result + '    STW_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosSTW.fNomeTabela: String;
begin
  Result := 'STW_CADSTW_SIT';
end;

function TImportaTintometricosTerceirosSTW.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    STW_NOMCOR AS NOMCOR,       ';
  Result := Result + '    STW_CODLIN AS CODLIN,       ';
  Result := Result + '    STW_DESLIN AS DESLIN,       ';
  Result := Result + '    STW_DESLIN AS DESCRI,       ';
  Result := Result + '    STW_CODMON AS CODMON,       ';
  Result := Result + '    STW_MONTAD AS MONTAD,       ';
  Result := Result + '    STW_UNIVER AS UNIVER,       ';
  Result := Result + '    STW_CODITE AS CODITE,       ';
  Result := Result + '    STW_CODDIL AS CODDIL,       ';
  Result := Result + '    STW_PORDIL AS PORDIL,       ';
  Result := Result + '    ITE_REFERE AS REFERE,       ';
  Result := Result + '    STW_PRECLT AS PRECLT,       ';
  Result := Result + '    STW_PRECGL AS PRECGL,       ';
  Result := Result + '    STW_PRECLA AS PRECLA,       ';
  Result := Result + '    STW_PRECCP AS PRECCP,       ';
  Result := Result + '    STW_PRECSP AS PRECSP,       ';

  Result := Result + '    STW_PREDLT AS PREDLT,       ';
  Result := Result + '    STW_PREDGL AS PREDGL,       ';
  Result := Result + '    STW_PREDLA AS PREDLA,       ';
  Result := Result + '    STW_PREDCP AS PREDCP,       ';
  Result := Result + '    STW_PREDSP AS PREDSP,       ';

  Result := Result + '    STW_PCUCLT AS PCUCLT,       ';
  Result := Result + '    STW_PCUDLT AS PCUDLT,       ';
  Result := Result + '    STW_PCUCGL AS PCUCGL,       ';
  Result := Result + '    STW_PCUDGL AS PCUDGL,       ';
  Result := Result + '    STW_PCUCLA AS PCUCLA,       ';
  Result := Result + '    STW_PCUDLA AS PCUDLA,       ';
  Result := Result + '    STW_PCUCCP AS PCUCCP,       ';
  Result := Result + '    STW_PCUDCP AS PCUDCP,       ';
  Result := Result + '    STW_PCUCSP AS PCUCSP,       ';
  Result := Result + '    STW_PCUDSP AS PCUDSP,       ';

  Result := Result + '    STW_PRCLT1 AS PRCLT1,       ';
  Result := Result + '    STW_PRCLT2 AS PRCLT2,       ';
  Result := Result + '    STW_PRCLT3 AS PRCLT3,       ';
  Result := Result + '    STW_PRCLT4 AS PRCLT4,       ';
  Result := Result + '    STW_PRCLT5 AS PRCLT5,       ';
  Result := Result + '    STW_PRCLT6 AS PRCLT6,       ';
  Result := Result + '    STW_PRCLT7 AS PRCLT7,       ';

  Result := Result + '    STW_PRDLT1 AS PRDLT1,       ';
  Result := Result + '    STW_PRDLT2 AS PRDLT2,       ';
  Result := Result + '    STW_PRDLT3 AS PRDLT3,       ';
  Result := Result + '    STW_PRDLT4 AS PRDLT4,       ';
  Result := Result + '    STW_PRDLT5 AS PRDLT5,       ';
  Result := Result + '    STW_PRDLT6 AS PRDLT6,       ';
  Result := Result + '    STW_PRDLT7 AS PRDLT7,       ';

  Result := Result + '    STW_PRCGL1 AS PRCGL1,       ';
  Result := Result + '    STW_PRCGL2 AS PRCGL2,       ';
  Result := Result + '    STW_PRCGL3 AS PRCGL3,       ';
  Result := Result + '    STW_PRCGL4 AS PRCGL4,       ';
  Result := Result + '    STW_PRCGL5 AS PRCGL5,       ';
  Result := Result + '    STW_PRCGL6 AS PRCGL6,       ';
  Result := Result + '    STW_PRCGL7 AS PRCGL7,       ';

  Result := Result + '    STW_PRDGL1 AS PRDGL1,       ';
  Result := Result + '    STW_PRDGL2 AS PRDGL2,       ';
  Result := Result + '    STW_PRDGL3 AS PRDGL3,       ';
  Result := Result + '    STW_PRDGL4 AS PRDGL4,       ';
  Result := Result + '    STW_PRDGL5 AS PRDGL5,       ';
  Result := Result + '    STW_PRDGL6 AS PRDGL6,       ';
  Result := Result + '    STW_PRDGL7 AS PRDGL7,       ';

  Result := Result + '    STW_PRCLA1 AS PRCLA1,       ';
  Result := Result + '    STW_PRCLA2 AS PRCLA2,       ';
  Result := Result + '    STW_PRCLA3 AS PRCLA3,       ';
  Result := Result + '    STW_PRCLA4 AS PRCLA4,       ';
  Result := Result + '    STW_PRCLA5 AS PRCLA5,       ';
  Result := Result + '    STW_PRCLA6 AS PRCLA6,       ';
  Result := Result + '    STW_PRCLA7 AS PRCLA7,       ';

  Result := Result + '    STW_PRDLA1 AS PRDLA1,       ';
  Result := Result + '    STW_PRDLA2 AS PRDLA2,       ';
  Result := Result + '    STW_PRDLA3 AS PRDLA3,       ';
  Result := Result + '    STW_PRDLA4 AS PRDLA4,       ';
  Result := Result + '    STW_PRDLA5 AS PRDLA5,       ';
  Result := Result + '    STW_PRDLA6 AS PRDLA6,       ';
  Result := Result + '    STW_PRDLA7 AS PRDLA7,       ';

  Result := Result + '    STW_PRCCP1 AS PRCCP1,       ';
  Result := Result + '    STW_PRCCP2 AS PRCCP2,       ';
  Result := Result + '    STW_PRCCP3 AS PRCCP3,       ';
  Result := Result + '    STW_PRCCP4 AS PRCCP4,       ';
  Result := Result + '    STW_PRCCP5 AS PRCCP5,       ';
  Result := Result + '    STW_PRCCP6 AS PRCCP6,       ';
  Result := Result + '    STW_PRCCP7 AS PRCCP7,       ';

  Result := Result + '    STW_PRDCP1 AS PRDCP1,       ';
  Result := Result + '    STW_PRDCP2 AS PRDCP2,       ';
  Result := Result + '    STW_PRDCP3 AS PRDCP3,       ';
  Result := Result + '    STW_PRDCP4 AS PRDCP4,       ';
  Result := Result + '    STW_PRDCP5 AS PRDCP5,       ';
  Result := Result + '    STW_PRDCP6 AS PRDCP6,       ';
  Result := Result + '    STW_PRDCP7 AS PRDCP7,       ';

  Result := Result + '    STW_PRCSP1 AS PRCSP1,       ';
  Result := Result + '    STW_PRCSP2 AS PRCSP2,       ';
  Result := Result + '    STW_PRCSP3 AS PRCSP3,       ';
  Result := Result + '    STW_PRCSP4 AS PRCSP4,       ';
  Result := Result + '    STW_PRCSP5 AS PRCSP5,       ';
  Result := Result + '    STW_PRCSP6 AS PRCSP6,       ';
  Result := Result + '    STW_PRCSP7 AS PRCSP7,       ';

  Result := Result + '    STW_PRDSP1 AS PRDSP1,       ';
  Result := Result + '    STW_PRDSP2 AS PRDSP2,       ';
  Result := Result + '    STW_PRDSP3 AS PRDSP3,       ';
  Result := Result + '    STW_PRDSP4 AS PRDSP4,       ';
  Result := Result + '    STW_PRDSP5 AS PRDSP5,       ';
  Result := Result + '    STW_PRDSP6 AS PRDSP6,       ';
  Result := Result + '    STW_PRDSP7 AS PRDSP7,       ';

  Result := Result + '    STW_EMBALT AS EMBALT,       ';
  Result := Result + '    STW_EMBAGL AS EMBAGL,       ';
  Result := Result + '    STW_EMBALA AS EMBALA,       ';
  Result := Result + '    STW_EMBACP AS EMBACP,       ';
  Result := Result + '    STW_EMBASP AS EMBASP,       ';

  Result := Result + '    STW_VOLULT AS VOLULT,       ';
  Result := Result + '    STW_VOLUGL AS VOLUGL,       ';
  Result := Result + '    STW_VOLULA AS VOLULA,       ';
  Result := Result + '    STW_VOLUCP AS VOLUCP,       ';
  Result := Result + '    STW_VOLUSP AS VOLUSP,       ';

  Result := Result + '    STW_PREELT AS PREELT,       ';
  Result := Result + '    STW_PREEGL AS PREEGL,       ';
  Result := Result + '    STW_PREELA AS PREELA,       ';
  Result := Result + '    STW_PREECP AS PREECP,       ';
  Result := Result + '    STW_PREESP AS PREESP,       ';

  Result := Result + '    STW_TIPOLT AS TIPOLT,       ';
  Result := Result + '    STW_TIPOGL AS TIPOGL,       ';
  Result := Result + '    STW_TIPOLA AS TIPOLA,       ';
  Result := Result + '    STW_TIPOCP AS TIPOCP,       ';
  Result := Result + '    STW_TIPOSP AS TIPOSP        ';
end;

{ TImportaTintometricosTerceirosKRE }

function TImportaTintometricosTerceirosKRE.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosKRE.fCampoMD5: String;
begin
  Result := 'KRE_MD5KEY';
end;

function TImportaTintometricosTerceirosKRE.fGetSelectConsultaPorMd5: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    KRE_CODIGO,         ';
  Result := Result + '    KRE_NOMCOR,         ';
  Result := Result + '    KRE_BASE__,         ';
  Result := Result + '    KRE_PRODUT,         ';
  Result := Result + '    KRE_UNIDAD,         ';
  Result := Result + '    KRE_COLECA,         ';
  Result := Result + '    ITE_CODITE,         ';
  Result := Result + '    ITE_DESITE,         ';
  Result := Result + '    ITE_REFERE,         ';
  Result := Result + '    KRE_FORM01,         ';
  Result := Result + '    KRE_QTDC01,         ';
  Result := Result + '    KRE_FORM02,         ';
  Result := Result + '    KRE_QTDC02,         ';
  Result := Result + '    KRE_FORM03,         ';
  Result := Result + '    KRE_QTDC03,         ';
  Result := Result + '    KRE_FORM04,         ';
  Result := Result + '    KRE_QTDC04,         ';
  Result := Result + '    KRE_FORM05,         ';
  Result := Result + '    KRE_QTDC05,         ';
  Result := Result + '    KRE_FORM06,         ';
  Result := Result + '    KRE_QTDC06,         ';
  Result := Result + '    KRE_FORM07,         ';
  Result := Result + '    KRE_QTDC07,         ';
  Result := Result + '    KRE_FORM08,         ';
  Result := Result + '    KRE_QTDC08,         ';
  Result := Result + '    KRE_FORM09,         ';
  Result := Result + '    KRE_QTDC09,         ';
  Result := Result + '    KRE_FORM10,         ';
  Result := Result + '    KRE_QTDC10,         ';
  Result := Result + '    KRE_FORM11,         ';
  Result := Result + '    KRE_QTDC11,         ';
  Result := Result + '    KRE_FORM12,         ';
  Result := Result + '    KRE_QTDC12,         ';
  Result := Result + '    KRE_FORM13,         ';
  Result := Result + '    KRE_QTDC13,         ';
  Result := Result + '    KRE_FORM14,         ';
  Result := Result + '    KRE_QTDC14,         ';
  Result := Result + '    KRE_FORM15,         ';
  Result := Result + '    KRE_QTDC15,         ';
  Result := Result + '    KRE_FORM16,         ';
  Result := Result + '    KRE_QTDC16,         ';
  Result := Result + '    KRE_FORM17,         ';
  Result := Result + '    KRE_QTDC17,         ';
  Result := Result + '    KRE_FORM18,         ';
  Result := Result + '    KRE_QTDC18,         ';
  Result := Result + '    KRE_FORM19,         ';
  Result := Result + '    KRE_QTDC19,         ';
  Result := Result + '    KRE_FORM20,         ';
  Result := Result + '    KRE_QTDC20,         ';
  Result := Result + '    KRE_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    KRE_CADKRE          ';
  Result := Result + '  INNER JOIN KRE_CADBAS ON          ';
  Result := Result + '    KRE_BASE__ = BAS_BASE__ AND           ';
  Result := Result + '    KRE_PRODUT = BAS_PRODUT AND           ';
  Result := Result + '    KRE_UNIDAD = BAS_UNIDAD               ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE               ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    KRE_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosKRE.fNomeTabela: String;
begin
  Result := 'KRE_CADKRE_SIT';
end;

function TImportaTintometricosTerceirosKRE.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    KRE_CODIGO AS CODIGO,       ';
  Result := Result + '    KRE_BASE__ AS BASE__,       ';
  Result := Result + '    KRE_PRODUT AS PRODUT,       ';
  Result := Result + '    KRE_UNIDAD AS UNIDAD,       ';
  Result := Result + '    KRE_NOMCOR AS NOMCOR,       ';
  Result := Result + '    KRE_COLECA AS COLECA,       ';
  Result := Result + '    KRE_CODITE AS CODITE,       ';
  Result := Result + '    KRE_DESITE AS DESITE,       ';
  Result := Result + '    KRE_REFERE AS REFERE,       ';
  Result := Result + '    KRE_MD5KEY AS MD5KEY,       ';
  Result := Result + '    KRE_PREVEN AS PREVEN,       ';
  Result := Result + '    KRE_PRECUS AS PRECUS,       ';
  Result := Result + '    KRE_PREVE1 AS PREVE1,       ';
  Result := Result + '    KRE_PREVE2 AS PREVE2,       ';
  Result := Result + '    KRE_PREVE3 AS PREVE3,       ';
  Result := Result + '    KRE_PREVE4 AS PREVE4,       ';
  Result := Result + '    KRE_PREVE5 AS PREVE5,       ';
  Result := Result + '    KRE_PREVE6 AS PREVE6,       ';
  Result := Result + '    KRE_PREVE7 AS PREVE7        ';
end;

{ TImportaTintometricosTerceirosKIN }

function TImportaTintometricosTerceirosKIN.fCampoCodIte: String;
begin
  Result := 'KIN_CODITE';
end;

function TImportaTintometricosTerceirosKIN.fCampoMD5: String;
begin
  Result := 'KIN_MD5KEY';
end;

function TImportaTintometricosTerceirosKIN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    KIN_CODIGO,               ';
  Result := Result + '    KIN_NOMCOR,               ';
  Result := Result + '    KIN_PRODUT,               ';
  Result := Result + '    KIN_SISTEM,               ';
  Result := Result + '    KIN_ORIGEM,               ';
  Result := Result + '    KIN_CODMON,               ';
  Result := Result + '    KIN_LINHA_,               ';
  Result := Result + '    KIN_DESMON,               ';
  Result := Result + '    KIN_DESLIN,               ';
  Result := Result + '    KIN_ANOCOR,               ';
  Result := Result + '    KIN_DTACAD,               ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    KIN_BASE' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    KIN_QTDB' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    KIN_MD5KEY                ';
  Result := Result + '  FROM                        ';
  Result := Result + '    KIN_CADKIN                ';
  Result := Result + '  LEFT JOIN KIN_CADMON ON           ';
  Result := Result + '    MON_CODMON = KIN_CODMON                 ';
  Result := Result + '  LEFT JOIN KIN_CADLIN ON           ';
  Result := Result + '    LIN_CODIGO = KIN_LINHA_                 ';
  Result := Result + '  WHERE                       ';
  Result := Result + '    KIN_MD5KEY = :MD5KEY            ';
end;

function TImportaTintometricosTerceirosKIN.fNomeTabela: String;
begin
  Result := 'KIN_CADKIN_SIT';
end;

function TImportaTintometricosTerceirosKIN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    KIN_CODIGO AS CODIGO,   ';
  Result := Result + '    KIN_NOMCOR AS NOMCOR,   ';
  Result := Result + '    KIN_PRODUT AS PRODUT,   ';
  Result := Result + '    KIN_SISTEM AS SISTEM,   ';
  Result := Result + '    KIN_ORIGEM AS ORIGEM,   ';
  Result := Result + '    KIN_CODMON AS CODMON,   ';
  Result := Result + '    KIN_LINHA_ AS LINHA_,   ';
  Result := Result + '    KIN_ANOCOR AS ANOCOR,   ';
  Result := Result + '    KIN_DESMON AS DESMON,   ';
  Result := Result + '    KIN_DESLIN AS DESLIN,   ';
  Result := Result + '    KIN_DESCRI AS DESCRI,   ';
  Result := Result + '    KIN_MD5KEY AS MD5KEY,   ';
  Result := Result + '    KIN_CODITE AS CODITE,   ';

  Result := Result + '    KIN_CODDIL AS CODDIL,   ';
  Result := Result + '    KIN_PORDIL AS PORDIL,   ';

  Result := Result + '    KIN_PRECLT AS PRECLT,   ';
  Result := Result + '    KIN_PRECGL AS PRECGL,   ';
  Result := Result + '    KIN_PRECLA AS PRECLA,   ';
  Result := Result + '    KIN_PRECCP AS PRECCP,   ';
  Result := Result + '    KIN_PRECSP AS PRECSP,   ';
  Result := Result + '    KIN_PREDLT AS PREDLT,   ';
  Result := Result + '    KIN_PREDGL AS PREDGL,   ';
  Result := Result + '    KIN_PREDLA AS PREDLA,   ';
  Result := Result + '    KIN_PREDCP AS PREDCP,   ';
  Result := Result + '    KIN_PREDSP AS PREDSP,   ';
  Result := Result + '    KIN_EMBALT AS EMBALT,   ';
  Result := Result + '    KIN_EMBAGL AS EMBAGL,   ';
  Result := Result + '    KIN_EMBALA AS EMBALA,   ';
  Result := Result + '    KIN_EMBACP AS EMBACP,   ';
  Result := Result + '    KIN_EMBASP AS EMBASP,   ';
  Result := Result + '    KIN_VOLULT AS VOLULT,   ';
  Result := Result + '    KIN_VOLUGL AS VOLUGL,   ';
  Result := Result + '    KIN_VOLULA AS VOLULA,   ';
  Result := Result + '    KIN_VOLUCP AS VOLUCP,   ';
  Result := Result + '    KIN_VOLUSP AS VOLUSP,   ';
  Result := Result + '    KIN_PREELT AS PREELT,   ';
  Result := Result + '    KIN_PREEGL AS PREEGL,   ';
  Result := Result + '    KIN_PREELA AS PREELA,   ';
  Result := Result + '    KIN_PREECP AS PREECP,   ';
  Result := Result + '    KIN_PREESP AS PREESP,   ';
  Result := Result + '    KIN_TIPOLT AS TIPOLT,   ';
  Result := Result + '    KIN_TIPOGL AS TIPOGL,   ';
  Result := Result + '    KIN_TIPOLA AS TIPOLA,   ';
  Result := Result + '    KIN_TIPOCP AS TIPOCP,   ';
  Result := Result + '    KIN_TIPOSP AS TIPOSP    ';
end;

{ TImportaTintometricosTerceirosMAX }

function TImportaTintometricosTerceirosMAX.fCampoCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TImportaTintometricosTerceirosMAX.fCampoMD5: String;
begin
  Result := 'MAX_MD5KEY';
end;

function TImportaTintometricosTerceirosMAX.fGetSelectConsultaPorMd5: String;
begin

end;

function TImportaTintometricosTerceirosMAX.fNomeTabela: String;
begin
  Result := 'MAX_CADMAX_SIT'
end;

function TImportaTintometricosTerceirosMAX.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    MAX_CODIGO AS CODIGO,     ';
  Result := Result + '    MAX_CODBAS AS CODBAS,     ';
  Result := Result + '    MAX_PRODUT AS PRODUT,     ';
  Result := Result + '    MAX_COLECA AS COLECA,     ';
  Result := Result + '    MAX_UNIDAD AS UNIDAD,     ';
  Result := Result + '    MAX_NOMCOR AS NOMCOR,     ';
  Result := Result + '    MAX_CODITE AS CODITE,     ';
  Result := Result + '    MAX_DESITE AS DESITE,     ';
  Result := Result + '    MAX_REFERE AS REFERE,     ';
  Result := Result + '    MAX_MD5KEY AS MD5KEY,     ';
  Result := Result + '    MAX_PREVEN AS PREVEN,     ';
  Result := Result + '    MAX_PRECUS AS PRECUS,     ';
  Result := Result + '    MAX_PREVE1 AS PREVE1,     ';
  Result := Result + '    MAX_PREVE2 AS PREVE2,     ';
  Result := Result + '    MAX_PREVE3 AS PREVE3,     ';
  Result := Result + '    MAX_PREVE4 AS PREVE4,     ';
  Result := Result + '    MAX_PREVE5 AS PREVE5,     ';
  Result := Result + '    MAX_PREVE6 AS PREVE6,     ';
  Result := Result + '    MAX_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosMZA }

function TImportaTintometricosTerceirosMZA.fCampoCodIte: String;
begin
  Result := 'MZA_CODITE';
end;

function TImportaTintometricosTerceirosMZA.fCampoMD5: String;
begin
  Result := 'MZA_MD5KEY';
end;

function TImportaTintometricosTerceirosMZA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MZA_CODIGO,           ';
  Result := Result + '    MZA_DESCRI,           ';
  Result := Result + '    MZA_DTACAD,           ';
  Result := Result + '    MZA_VARIAC,           ';
  Result := Result + '    MZA_OBSERV,           ';
  Result := Result + '    MZA_ANOCOR,           ';
  Result := Result + '    MZA_PESCOR,           ';
  Result := Result + '    MZA_PESFOR,           ';
  Result := Result + '    MZA_LINHA_,           ';
  Result := Result + '    LIN_DESCRI,           ';
  Result := Result + '    MON_DESCRI,           ';
  Result := Result + '    MZA_CODNFM,           ';
  Result := Result + '    MZA_UNIVER,           ';
  Result := Result + '    MZA_CODMON,           ';
  Result := Result + '    MZA_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    MZA_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MZA_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    MZA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MZA_CADMZA            ';
  Result := Result + '  LEFT JOIN MZA_CADMON ON             ';
  Result := Result + '    MON_CODMON = MZA_CODMON                 ';
  Result := Result + '  LEFT JOIN MZA_CADLIN ON             ';
  Result := Result + '    LIN_CODIGO = MZA_LINHA_                 ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    MZA_MD5KEY = :MD5KEY              ';
end;

function TImportaTintometricosTerceirosMZA.fNomeTabela: String;
begin
  Result := 'MZA_CADMZA_SIT';
end;

function TImportaTintometricosTerceirosMZA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    MZA_CODIGO AS CODIGO,       ';
  Result := Result + '    MZA_DESCRI AS DESCRI,       ';
  Result := Result + '    MZA_DESCRI AS NOMCOR,       ';
  Result := Result + '    ITE_REFERE AS REFERE,       ';
  Result := Result + '    MZA_LINHA_ AS LINHA_,       ';
  Result := Result + '    MZA_OBSERV AS OBSERV,       ';
  Result := Result + '    MZA_UNIVER AS UNIVER,       ';
  Result := Result + '    MZA_CODMON AS CODMON,       ';
  Result := Result + '    MZA_MD5KEY AS MD5KEY,       ';
  Result := Result + '    MZA_CODITE AS CODITE,       ';
  Result := Result + '    MZA_CODDIL AS CODDIL,       ';
  Result := Result + '    MZA_PORDIL AS PORDIL,       ';
  Result := Result + '    MZA_PRECLT AS PRECLT,       ';
  Result := Result + '    MZA_PRECGL AS PRECGL,       ';
  Result := Result + '    MZA_PRECLA AS PRECLA,       ';
  Result := Result + '    MZA_PRECCP AS PRECCP,       ';
  Result := Result + '    MZA_PRECSP AS PRECSP,       ';
  Result := Result + '    MZA_PREDLT AS PREDLT,       ';
  Result := Result + '    MZA_PREDGL AS PREDGL,       ';
  Result := Result + '    MZA_PREDLA AS PREDLA,       ';
  Result := Result + '    MZA_PREDCP AS PREDCP,       ';
  Result := Result + '    MZA_PREDSP AS PREDSP,       ';
  Result := Result + '    MZA_EMBALT AS EMBALT,       ';
  Result := Result + '    MZA_EMBAGL AS EMBAGL,       ';
  Result := Result + '    MZA_EMBALA AS EMBALA,       ';
  Result := Result + '    MZA_EMBACP AS EMBACP,       ';
  Result := Result + '    MZA_EMBASP AS EMBASP,       ';
  Result := Result + '    MZA_VOLULT AS VOLULT,       ';
  Result := Result + '    MZA_VOLUGL AS VOLUGL,       ';
  Result := Result + '    MZA_VOLULA AS VOLULA,       ';
  Result := Result + '    MZA_VOLUCP AS VOLUCP,       ';
  Result := Result + '    MZA_VOLUSP AS VOLUSP,       ';
  Result := Result + '    MZA_PREELT AS PREELT,       ';
  Result := Result + '    MZA_PREEGL AS PREEGL,       ';
  Result := Result + '    MZA_PREELA AS PREELA,       ';
  Result := Result + '    MZA_PREECP AS PREECP,       ';
  Result := Result + '    MZA_PREESP AS PREESP,       ';
  Result := Result + '    MZA_TIPOLT AS TIPOLT,       ';
  Result := Result + '    MZA_TIPOGL AS TIPOGL,       ';
  Result := Result + '    MZA_TIPOLA AS TIPOLA,       ';
  Result := Result + '    MZA_TIPOCP AS TIPOCP,       ';
  Result := Result + '    MZA_TIPOSP AS TIPOSP        ';
end;

{ TImportaTintometricosTerceirosBLT }

function TImportaTintometricosTerceirosBLT.fCampoCodIte: String;
begin
  Result := 'BLT_CODITE';
end;

function TImportaTintometricosTerceirosBLT.fCampoMD5: String;
begin
  Result := 'BLT_MD5KEY';
end;

function TImportaTintometricosTerceirosBLT.fGetSelectConsultaPorMd5: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    BLT_CODIGO,                   ';
  Result := Result + '    BLT_DESCOR,                   ';
  Result := Result + '    BLT_CODBAS,                   ';
  Result := Result + '    BLT_PRODUT,                   ';
  Result := Result + '    BLT_DTACAD,                   ';
  Result := Result + '    BLT_UNIDAD,                   ';
  Result := Result + '    BLT_COLECA,                   ';
  Result := Result + '    ITE_CODITE,                   ';
  Result := Result + '    ITE_DESITE,                   ';
  Result := Result + '    ITE_REFERE,                   ';
  Result := Result + '    BLT_ACRMOB,                   ';

  For intCont := 1 To 20 Do
  Begin
    Result := Result + '    BLT_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    BLT_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    BLT_MD5KEY                    ';
  Result := Result + '  FROM                            ';
  Result := Result + '    BLT_CADBLT                    ';
  Result := Result + '  INNER JOIN BLT_CADBAS ON              ';
  Result := Result + '    BLT_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    BLT_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    BLT_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                  ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    BLT_MD5KEY = :MD5KEY ';
end;

function TImportaTintometricosTerceirosBLT.fNomeTabela: String;
begin
  Result := 'BLT_CADBLT_SIT';
end;

function TImportaTintometricosTerceirosBLT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    BLT_CODIGO AS CODIGO,     ';
  Result := Result + '    BLT_DESCOR AS DESCRI,     ';
  Result := Result + '    BLT_CODBAS AS CODBAS,     ';
  Result := Result + '    BLT_PRODUT AS PRODUT,     ';
  Result := Result + '    BLT_PRODUT AS NOMCOR,     ';
  Result := Result + '    BLT_COLECA AS COLECA,     ';
  Result := Result + '    BLT_UNIDAD AS UNIDAD,     ';
  Result := Result + '    BLT_CODITE AS CODITE,     ';
  Result := Result + '    BLT_DESITE AS DESITE,     ';
  Result := Result + '    BLT_REFITE AS REFERE,     ';
  Result := Result + '    BLT_MD5KEY AS MD5KEY,     ';
  Result := Result + '    BLT_PREVEN AS PREVEN,     ';
  Result := Result + '    BLT_PRECUS AS PRECUS,     ';
  Result := Result + '    BLT_PREVE1 AS PREVE1,     ';
  Result := Result + '    BLT_PREVE2 AS PREVE2,     ';
  Result := Result + '    BLT_PREVE3 AS PREVE3,     ';
  Result := Result + '    BLT_PREVE4 AS PREVE4,     ';
  Result := Result + '    BLT_PREVE5 AS PREVE5,     ';
  Result := Result + '    BLT_PREVE6 AS PREVE6,     ';
  Result := Result + '    BLT_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosSHW }

function TImportaTintometricosTerceirosSHW.fCampoCodIte: String;
begin
  Result := 'SHW_CODITE';
end;

function TImportaTintometricosTerceirosSHW.fCampoMD5: String;
begin
  Result := 'SHW_MD5KEY';
end;

function TImportaTintometricosTerceirosSHW.fGetSelectConsultaPorMd5: String;
begin
  Result := Result + ' SELECT  ';
  Result := Result + '   SHW_BASE__, ';
  Result := Result + '   SHW_CODUNI, ';
  Result := Result + '   SHW_CODEMP, ';
  Result := Result + '   SHW_CODIGO, ';
  Result := Result + '   SHW_DESCRI, ';
  Result := Result + '   SHW_DTACAD, ';
  Result := Result + '   SHW_PRODUT, ';
  Result := Result + '   SHW_ATIVAD, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   ITE_REFERE, ';
  Result := Result + '   SHW_ACRMOB, ';
  Result := Result + '   SHW_FORM01, ';
  Result := Result + '   SHW_QTDC01, ';
  Result := Result + '   SHW_FORM02, ';
  Result := Result + '   SHW_QTDC02, ';
  Result := Result + '   SHW_FORM03, ';
  Result := Result + '   SHW_QTDC03, ';
  Result := Result + '   SHW_FORM04, ';
  Result := Result + '   SHW_QTDC04, ';
  Result := Result + '   SHW_FORM05, ';
  Result := Result + '   SHW_QTDC05, ';
  Result := Result + '   SHW_FORM06, ';
  Result := Result + '   SHW_QTDC06, ';
  Result := Result + '   SHW_FORM07, ';
  Result := Result + '   SHW_QTDC07, ';
  Result := Result + '   SHW_FORM08, ';
  Result := Result + '   SHW_QTDC08, ';
  Result := Result + '   SHW_FORM09, ';
  Result := Result + '   SHW_QTDC09, ';
  Result := Result + '   SHW_FORM10, ';
  Result := Result + '   SHW_QTDC10, ';
  Result := Result + '   SHW_FORM11, ';
  Result := Result + '   SHW_QTDC11, ';
  Result := Result + '   SHW_FORM12, ';
  Result := Result + '   SHW_QTDC12, ';
  Result := Result + '   SHW_FORM13, ';
  Result := Result + '   SHW_QTDC13, ';
  Result := Result + '   SHW_FORM14, ';
  Result := Result + '   SHW_QTDC14, ';
  Result := Result + '   SHW_FORM15, ';
  Result := Result + '   SHW_QTDC15, ';
  Result := Result + '   SHW_FORM16, ';
  Result := Result + '   SHW_QTDC16, ';
  Result := Result + '   SHW_FORM17, ';
  Result := Result + '   SHW_QTDC17, ';
  Result := Result + '   SHW_FORM18, ';
  Result := Result + '   SHW_QTDC18, ';
  Result := Result + '   SHW_FORM19, ';
  Result := Result + '   SHW_QTDC19, ';
  Result := Result + '   SHW_FORM20, ';
  Result := Result + '   SHW_QTDC20, ';
  Result := Result + '   SHW_MD5KEY  ';
  Result := Result + ' FROM SHW_CADSHW S ';
  Result := Result + ' INNER JOIN SHW_CADBAS B ';
  Result := Result + '    ON BAS_CODBAS = SHW_BASE__ ';
  Result := Result + '   AND BAS_CODUNI = SHW_CODUNI ';
  Result := Result + '   AND BAS_PRODUT = SHW_PRODUT ';
  Result := Result + ' INNER JOIN CADITE I ';
  Result := Result + '    ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE      ';
  Result := Result + '   SHW_MD5KEY = :MD5KEY   ';
end;

function TImportaTintometricosTerceirosSHW.fNomeTabela: String;
begin
  Result := 'SHW_CADSHW_SIT';
end;

function TImportaTintometricosTerceirosSHW.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    SHW_DESCRI AS DESCRI,     ';
  Result := Result + '    SHW_CODIGO AS CODIGO,     ';
  Result := Result + '    SHW_PRODUT AS PRODUT,     ';
  Result := Result + '    SHW_PRODUT AS NOMCOR,     ';
  Result := Result + '    SHW_CODUNI AS CODUNI,     ';
  Result := Result + '    SHW_BASE__ AS BASE__,     ';
  Result := Result + '    SHW_MD5KEY AS MD5KEY,     ';
  Result := Result + '    SHW_CODITE AS CODITE,     ';
  Result := Result + '    SHW_DESITE AS DESITE,     ';
  Result := Result + '    ITE_REFERE AS REFERE,     ';
  Result := Result + '    SHW_PREVEN AS PREVEN,     ';
  Result := Result + '    SHW_PRECUS AS PRECUS,     ';
  Result := Result + '    SHW_PREVE1 AS PREVE1,     ';
  Result := Result + '    SHW_PREVE2 AS PREVE2,     ';
  Result := Result + '    SHW_PREVE3 AS PREVE3,     ';
  Result := Result + '    SHW_PREVE4 AS PREVE4,     ';
  Result := Result + '    SHW_PREVE5 AS PREVE5,     ';
  Result := Result + '    SHW_PREVE6 AS PREVE6,     ';
  Result := Result + '    SHW_PREVE7 AS PREVE7      ';

end;

{ TImportaTintometricosTerceirosALK }

function TImportaTintometricosTerceirosALK.fCampoCodIte: String;
begin
  Result := 'ALK_CODITE';
end;

function TImportaTintometricosTerceirosALK.fCampoMD5: String;
begin
  Result := 'ALK_MD5KEY';
end;

function TImportaTintometricosTerceirosALK.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ALK_CODIGO,           ';
  Result := Result + '    ALK_DESCRI,           ';
  Result := Result + '    ALK_PRODUT,           ';
  Result := Result + '    ALK_ACABAM,           ';
  Result := Result + '    ALK_VARIAN,           ';
  Result := Result + '    ALK_CORMON,           ';
  Result := Result + '    ALK_ANOINI,           ';
  Result := Result + '    ALK_ANOFIN,           ';
  Result := Result + '    ALK_DTACAD,           ';
  Result := Result + '    ALK_VOLUME,           ';
  Result := Result + '    ALK_VARIAN,           ';
  Result := Result + '    ALK_GRAMA_,           ';
  Result := Result + '    ALK_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ALK_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALK_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ALK_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ALK_CADALK            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    ALK_MD5KEY = :MD5KEY; ';
end;

function TImportaTintometricosTerceirosALK.fNomeTabela: String;
begin
  Result := 'ALK_CADALK_SIT';
end;

function TImportaTintometricosTerceirosALK.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT          ';
  Result := Result + '    ALK_CODIGO AS CODIGO,   ';
  Result := Result + '    ALK_DESCRI AS DESCRI,   ';
  Result := Result + '    ALK_PRODUT AS PRODUT,   ';
  Result := Result + '    ALK_PRODUT AS NOMCOR,   ';
  Result := Result + '    ALK_ACABAM AS ACABAM,   ';
  Result := Result + '    ALK_VARIAN AS VARIAN,   ';
  Result := Result + '    ALK_ANOINI AS ANOINI,   ';
  Result := Result + '    ALK_ANOFIN AS ANOFIN,   ';
  Result := Result + '    ALK_CORMON AS CORMON,   ';
  Result := Result + '    ALK_VOLUME AS VOLUME,   ';
  Result := Result + '    ALK_GRAMA_ AS GRAMA_,   ';
  Result := Result + '    ALK_MD5KEY AS MD5KEY,   ';
  Result := Result + '    ITE_REFERE AS REFERE,   ';
  Result := Result + '    ALK_CODITE AS CODITE,   ';
  Result := Result + '    ALK_CODDIL AS CODDIL,   ';
  Result := Result + '    ALK_PORDIL AS PORDIL,   ';
  Result := Result + '    ALK_PRECLT AS PRECLT,   ';
  Result := Result + '    ALK_PRECGL AS PRECGL,   ';
  Result := Result + '    ALK_PRECLA AS PRECLA,   ';
  Result := Result + '    ALK_PREDLT AS PREDLT,   ';
  Result := Result + '    ALK_PREDGL AS PREDGL,   ';
  Result := Result + '    ALK_PREDLA AS PREDLA,   ';
  Result := Result + '    ALK_PCUCLT AS PCUCLT,   ';
  Result := Result + '    ALK_PCUCGL AS PCUCGL,   ';
  Result := Result + '    ALK_PCUCLA AS PCUCLA,   ';
  Result := Result + '    ALK_PCUDLT AS PCUDLT,   ';
  Result := Result + '    ALK_PCUDGL AS PCUDGL,   ';
  Result := Result + '    ALK_PCUDLA AS PCUDLA,   ';
  Result := Result + '    ALK_PRCLT1 AS PRCLT1,   ';
  Result := Result + '    ALK_PRCLT2 AS PRCLT2,   ';
  Result := Result + '    ALK_PRCLT3 AS PRCLT3,   ';
  Result := Result + '    ALK_PRCLT4 AS PRCLT4,   ';
  Result := Result + '    ALK_PRCLT5 AS PRCLT5,   ';
  Result := Result + '    ALK_PRCLT6 AS PRCLT6,   ';
  Result := Result + '    ALK_PRCLT7 AS PRCLT7,   ';
  Result := Result + '    ALK_PRDLT1 AS PRDLT1,   ';
  Result := Result + '    ALK_PRDLT2 AS PRDLT2,   ';
  Result := Result + '    ALK_PRDLT3 AS PRDLT3,   ';
  Result := Result + '    ALK_PRDLT4 AS PRDLT4,   ';
  Result := Result + '    ALK_PRDLT5 AS PRDLT5,   ';
  Result := Result + '    ALK_PRDLT6 AS PRDLT6,   ';
  Result := Result + '    ALK_PRDLT7 AS PRDLT7,   ';
  Result := Result + '    ALK_PRCGL1 AS PRCGL1,   ';
  Result := Result + '    ALK_PRCGL2 AS PRCGL2,   ';
  Result := Result + '    ALK_PRCGL3 AS PRCGL3,   ';
  Result := Result + '    ALK_PRCGL4 AS PRCGL4,   ';
  Result := Result + '    ALK_PRCGL5 AS PRCGL5,   ';
  Result := Result + '    ALK_PRCGL6 AS PRCGL6,   ';
  Result := Result + '    ALK_PRCGL7 AS PRCGL7,   ';
  Result := Result + '    ALK_PRDGL1 AS PRDGL1,   ';
  Result := Result + '    ALK_PRDGL2 AS PRDGL2,   ';
  Result := Result + '    ALK_PRDGL3 AS PRDGL3,   ';
  Result := Result + '    ALK_PRDGL4 AS PRDGL4,   ';
  Result := Result + '    ALK_PRDGL5 AS PRDGL5,   ';
  Result := Result + '    ALK_PRDGL6 AS PRDGL6,   ';
  Result := Result + '    ALK_PRDGL7 AS PRDGL7,   ';
  Result := Result + '    ALK_PRCLA1 AS PRCLA1,   ';
  Result := Result + '    ALK_PRCLA2 AS PRCLA2,   ';
  Result := Result + '    ALK_PRCLA3 AS PRCLA3,   ';
  Result := Result + '    ALK_PRCLA4 AS PRCLA4,   ';
  Result := Result + '    ALK_PRCLA5 AS PRCLA5,   ';
  Result := Result + '    ALK_PRCLA6 AS PRCLA6,   ';
  Result := Result + '    ALK_PRCLA7 AS PRCLA7,   ';
  Result := Result + '    ALK_PRDLA1 AS PRDLA1,   ';
  Result := Result + '    ALK_PRDLA2 AS PRDLA2,   ';
  Result := Result + '    ALK_PRDLA3 AS PRDLA3,   ';
  Result := Result + '    ALK_PRDLA4 AS PRDLA4,   ';
  Result := Result + '    ALK_PRDLA5 AS PRDLA5,   ';
  Result := Result + '    ALK_PRDLA6 AS PRDLA6,   ';
  Result := Result + '    ALK_PRDLA7 AS PRDLA7,   ';
  Result := Result + '    ALK_EMBALT AS EMBALT,   ';
  Result := Result + '    ALK_EMBAGL AS EMBAGL,   ';
  Result := Result + '    ALK_EMBALA AS EMBALA,   ';
  Result := Result + '    ALK_VOLULT AS VOLULT,   ';
  Result := Result + '    ALK_VOLUGL AS VOLUGL,   ';
  Result := Result + '    ALK_VOLULA AS VOLULA,   ';
  Result := Result + '    ALK_PREELT AS PREELT,   ';
  Result := Result + '    ALK_PREEGL AS PREEGL,   ';
  Result := Result + '    ALK_PREELA AS PREELA,   ';
  Result := Result + '    ALK_TIPOLT AS TIPOLT,   ';
  Result := Result + '    ALK_TIPOGL AS TIPOGL,   ';
  Result := Result + '    ALK_TIPOLA AS TIPOLA    ';
end;

{ TImportaTintometricosTerceirosCHR }

function TImportaTintometricosTerceirosCHR.fCampoCodIte: String;
begin
  Result := 'CHR_CODITE';
end;

function TImportaTintometricosTerceirosCHR.fCampoMD5: String;
begin
  Result := 'CHR_MD5KEY';
end;

function TImportaTintometricosTerceirosCHR.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    CHR_CODIGO,           ';
  Result := Result + '    CHR_DESCRI,           ';
  Result := Result + '    CHR_CODBAS,           ';
  Result := Result + '    CHR_PRODUT,           ';
  Result := Result + '    CHR_COLECA,           ';
  Result := Result + '    CHR_UNIDAD,           ';
  Result := Result + '    CHR_PALETA,           ';
  Result := Result + '    CHR_NOMCOR,           ';
  Result := Result + '    CHR_DTACAD,           ';
  Result := Result + '    CHR_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    CHR_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    CHR_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    CHR_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    CHR_CADCHR            ';
  Result := Result + '  INNER JOIN CHR_CADBAS ON                    ';
  Result := Result + '    CHR_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    CHR_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    CHR_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    CHR_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosCHR.fNomeTabela: String;
begin
  Result := 'CHR_CADCHR_SIT';
end;

function TImportaTintometricosTerceirosCHR.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    CHR_CODIGO AS CODIGO,     ';
  Result := Result + '    CHR_DESCRI AS DESCRI,     ';
  Result := Result + '    CHR_PRODUT AS PRODUT,     ';
  Result := Result + '    CHR_NOMCOR AS NOMCOR,     ';
  Result := Result + '    CHR_UNIDAD AS UNIDAD,     ';
  Result := Result + '    CHR_CODBAS AS CODBAS,     ';
  Result := Result + '    CHR_MD5KEY AS MD5KEY,     ';
  Result := Result + '    CHR_PALETA AS PALETA,     ';
  Result := Result + '    CHR_COLECA AS COLECA,     ';
  Result := Result + '    CHR_CODITE AS CODITE,     ';
  Result := Result + '    CHR_DESITE AS DESITE,     ';
  Result := Result + '    ITE_REFERE AS REFERE,     ';
  Result := Result + '    CHR_PREVEN AS PREVEN,     ';
  Result := Result + '    CHR_PRECUS AS PRECUS,     ';
  Result := Result + '    CHR_PREVE1 AS PREVE1,     ';
  Result := Result + '    CHR_PREVE2 AS PREVE2,     ';
  Result := Result + '    CHR_PREVE3 AS PREVE3,     ';
  Result := Result + '    CHR_PREVE4 AS PREVE4,     ';
  Result := Result + '    CHR_PREVE5 AS PREVE5,     ';
  Result := Result + '    CHR_PREVE6 AS PREVE6,     ';
  Result := Result + '    CHR_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosADS }

function TImportaTintometricosTerceirosADS.fCampoCodIte: String;
begin
  Result := 'ADS_CODITE';
end;

function TImportaTintometricosTerceirosADS.fCampoMD5: String;
begin
  Result := 'ADS_MD5KEY';
end;

function TImportaTintometricosTerceirosADS.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ADS_CODIGO,           ';
  Result := Result + '    ADS_DESCRI,           ';
  Result := Result + '    ADS_CODBAS,           ';
  Result := Result + '    ADS_PRODUT,           ';
  Result := Result + '    ADS_LINHA_,           ';
  Result := Result + '    ADS_UNIDAD,           ';
  Result := Result + '    ADS_NOMCOR,           ';
  Result := Result + '    ADS_DTACAD,           ';
  Result := Result + '    ADS_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ADS_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ADS_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ADS_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ADS_CADADS            ';
  Result := Result + '  INNER JOIN ADS_CADBAS ON                    ';
  Result := Result + '    ADS_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    ADS_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    ADS_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN ADS_CADLIN ON                    ';
  Result := Result + '    ADS_LINHA_ = LIN_DESCRI                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    ADS_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosADS.fNomeTabela: String;
begin
   Result := 'ADS_CADADS_SIT';
end;

function TImportaTintometricosTerceirosADS.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    ADS_CODIGO AS CODIGO,     ';
  Result := Result + '    ADS_DESCRI AS DESCRI,     ';
  Result := Result + '    ADS_PRODUT AS PRODUT,     ';
  Result := Result + '    ADS_NOMCOR AS NOMCOR,     ';
  Result := Result + '    ADS_UNIDAD AS UNIDAD,     ';
  Result := Result + '    ADS_CODBAS AS CODBAS,     ';
  Result := Result + '    ADS_MD5KEY AS MD5KEY,     ';
  Result := Result + '    ADS_LINHA_ AS LINHA_,     ';
  Result := Result + '    ADS_CODITE AS CODITE,     ';
  Result := Result + '    ADS_DESITE AS DESITE,     ';
  Result := Result + '    ITE_REFERE AS REFERE,     ';
  Result := Result + '    ADS_PREVEN AS PREVEN,     ';
  Result := Result + '    ADS_PRECUS AS PRECUS,     ';
  Result := Result + '    ADS_PREVE1 AS PREVE1,     ';
  Result := Result + '    ADS_PREVE2 AS PREVE2,     ';
  Result := Result + '    ADS_PREVE3 AS PREVE3,     ';
  Result := Result + '    ADS_PREVE4 AS PREVE4,     ';
  Result := Result + '    ADS_PREVE5 AS PREVE5,     ';
  Result := Result + '    ADS_PREVE6 AS PREVE6,     ';
  Result := Result + '    ADS_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosADT }

function TImportaTintometricosTerceirosADT.fCampoCodIte: String;
begin
  Result := 'ADT_CODITE';
end;

function TImportaTintometricosTerceirosADT.fCampoMD5: String;
begin
  Result := 'ADT_MD5KEY';
end;

function TImportaTintometricosTerceirosADT.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ADT_IDFORM,       ';
  Result := Result + '    ADT_CODCOR,       ';
  Result := Result + '    ADT_CODTEC,       ';
  Result := Result + '    ADT_PRODUT,       ';
  Result := Result + '    ADT_CODBAS,       ';
  Result := Result + '    ADT_CODEMB,       ';
  Result := Result + '    ADT_CODCAT,       ';
  Result := Result + '    ADT_QTDFIN,       ';
  Result := Result + '    ADT_QTDBAS,       ';
  Result := Result + '    ADT_QTDCAT,       ';
  Result := Result + '    ADT_QTD_ML,       ';
  Result := Result + '    BAS_DESCRI,       ';
  Result := Result + '    BAS_CODEMB,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';
  Result := Result + '    EMB_DESCRI,       ';
  Result := Result + '    UNI_CODUNI,       ';
  Result := Result + '    UNI_DESUNI,       ';
  Result := Result + '    UNI_SIGUNI,       ';
  Result := Result + '    ADT_ACRMOB,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '     ADT_CODC' + fStrZero(intContador, 2) + ',    ';
    Result := Result + '     ADT_QTDC' + fStrZero(intContador, 2) + ',    ';
  End;

  Result := Result + '    ADT_MD5KEY        ';
  Result := Result + '  FROM                   ';
  Result := Result + '    ADT_CADADT           ';
  Result := Result + '  INNER JOIN ADT_CADBAS ON         ';
  Result := Result + '    ADT_CODBAS = BAS_CODBAS AND            ';
  Result := Result + '    ADT_PRODUT = BAS_PRODUT AND            ';
  Result := Result + '    ADT_CODEMB = BAS_CODEMB                ';
  Result := Result + '  INNER JOIN ADT_CADEMB ON         ';
  Result := Result + '    BAS_CODEMB = EMB_CODEMB                ';
  Result := Result + '  INNER JOIN CADUNI ON             ';
  Result := Result + '    EMB_CODUNI = UNI_CODUNI                ';
  Result := Result + '  INNER JOIN CADITE ON             ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                ';
  Result := Result + '  WHERE                  ';
  Result := Result + '     ADT_MD5KEY = :MD5KEY;                ';
end;

function TImportaTintometricosTerceirosADT.fNomeTabela: String;
begin
  Result := 'ADT_CADADT_SIT';
end;

function TImportaTintometricosTerceirosADT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    ADT_IDFORM AS CODIGO,     ';
  Result := Result + '    ADT_PRODUT AS DESCRI,     ';
  Result := Result + '    ADT_PRODUT AS PRODUT,     ';
  Result := Result + '    ADT_CODCOR AS NOMCOR,     ';
  Result := Result + '    ADT_UNIDAD AS UNIDAD,     ';
  Result := Result + '    ADT_CODBAS AS CODBAS,     ';
  Result := Result + '    ADT_MD5KEY AS MD5KEY,     ';
  Result := Result + '    ADT_VOLUME AS VOLUME,     ';
  Result := Result + '    ADT_CODITE AS CODITE,     ';
  Result := Result + '    ADT_DESITE AS DESITE,     ';
  Result := Result + '    ADT_REFERE AS REFERE,     ';
  Result := Result + '    ADT_PREVSC AS PREVEN,     ';
  Result := Result + '    ADT_PREVCC AS PREVCC,     ';
  Result := Result + '    ADT_PRCUSC AS PRECUS,     ';
  Result := Result + '    ADT_PRCUCC AS PRCUCC,     ';
  Result := Result + '    ADT_PREVS1 AS PREVE1,     ';
  Result := Result + '    ADT_PREVS2 AS PREVE2,     ';
  Result := Result + '    ADT_PREVS3 AS PREVE3,     ';
  Result := Result + '    ADT_PREVS4 AS PREVE4,     ';
  Result := Result + '    ADT_PREVS5 AS PREVE5,     ';
  Result := Result + '    ADT_PREVS6 AS PREVE6,     ';
  Result := Result + '    ADT_PREVS7 AS PREVE7,     ';
  Result := Result + '    ADT_PREVC1 AS PREVC1,     ';
  Result := Result + '    ADT_PREVC2 AS PREVC2,     ';
  Result := Result + '    ADT_PREVC3 AS PREVC3,     ';
  Result := Result + '    ADT_PREVC4 AS PREVC4,     ';
  Result := Result + '    ADT_PREVC5 AS PREVC5,     ';
  Result := Result + '    ADT_PREVC6 AS PREVC6,     ';
  Result := Result + '    ADT_PREVC7 AS PREVC7      ';
end;

{ TImportaTintometricosTerceirosLEI }

function TImportaTintometricosTerceirosLEI.fCampoCodIte: String;
begin
  Result := 'LEI_CODITE';
end;

function TImportaTintometricosTerceirosLEI.fCampoMD5: String;
begin
  Result := 'LEI_MD5KEY';
end;

function TImportaTintometricosTerceirosLEI.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    LEI_CODIGO,           ';
  Result := Result + '    LEI_DESCRI,           ';
  Result := Result + '    LEI_CODBAS,           ';
  Result := Result + '    LEI_PRODUT,           ';
  Result := Result + '    LEI_COLECA,           ';
  Result := Result + '    LEI_UNIDAD,           ';
  Result := Result + '    LEI_NOMCOR,           ';
  Result := Result + '    LEI_DTACAD,           ';
  Result := Result + '    LEI_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    LEI_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LEI_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    LEI_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    LEI_CADLEI            ';
  Result := Result + '  INNER JOIN LEI_CADBAS ON                    ';
  Result := Result + '    LEI_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    LEI_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    LEI_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    LEI_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosLEI.fNomeTabela: String;
begin
  Result := 'LEI_CADLEI_SIT';
end;

function TImportaTintometricosTerceirosLEI.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    LEI_CODIGO AS CODIGO,     ';
  Result := Result + '    LEI_DESCRI AS DESCRI,     ';
  Result := Result + '    LEI_PRODUT AS PRODUT,     ';
  Result := Result + '    LEI_NOMCOR AS NOMCOR,     ';
  Result := Result + '    LEI_UNIDAD AS UNIDAD,     ';
  Result := Result + '    LEI_CODBAS AS CODBAS,     ';
  Result := Result + '    LEI_MD5KEY AS MD5KEY,     ';
  Result := Result + '    LEI_COLECA AS COLECA,     ';
  Result := Result + '    LEI_CODITE AS CODITE,     ';
  Result := Result + '    LEI_DESITE AS DESITE,     ';
  Result := Result + '    ITE_REFERE AS REFERE,     ';
  Result := Result + '    LEI_PREVEN AS PREVEN,     ';
  Result := Result + '    LEI_PRECUS AS PRECUS,     ';
  Result := Result + '    LEI_PREVE1 AS PREVE1,     ';
  Result := Result + '    LEI_PREVE2 AS PREVE2,     ';
  Result := Result + '    LEI_PREVE3 AS PREVE3,     ';
  Result := Result + '    LEI_PREVE4 AS PREVE4,     ';
  Result := Result + '    LEI_PREVE5 AS PREVE5,     ';
  Result := Result + '    LEI_PREVE6 AS PREVE6,     ';
  Result := Result + '    LEI_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosMAE }

function TImportaTintometricosTerceirosMAE.fCampoCodIte: String;
begin
  Result := 'MAE_CODITE';
end;

function TImportaTintometricosTerceirosMAE.fCampoMD5: String;
begin
  Result := 'MAE_MD5KEY';
end;

function TImportaTintometricosTerceirosMAE.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MAE_CODIGO,           ';
  Result := Result + '    MAE_DESCRI,           ';
  Result := Result + '    MAE_CODBAS,           ';
  Result := Result + '    MAE_PRODUT,           ';
  Result := Result + '    MAE_COLECA,           ';
  Result := Result + '    MAE_UNIDAD,           ';
  Result := Result + '    MAE_NOMCOR,           ';
  Result := Result + '    MAE_DTACAD,           ';
  Result := Result + '    MAE_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    MAE_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MAE_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    MAE_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MAE_CADMAE            ';
  Result := Result + '  INNER JOIN MAE_CADBAS ON                    ';
  Result := Result + '    MAE_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    MAE_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    MAE_PRODUT = BAS_PRODUT AND               ';
  Result := Result + '    MAE_EMBALA = BAS_EMBALA                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    MAE_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosMAE.fNomeTabela: String;
begin
  Result := 'MAE_CADMAE_SIT';
end;

function TImportaTintometricosTerceirosMAE.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    MAE_CODIGO AS CODIGO,     ';
  Result := Result + '    MAE_DESCRI AS DESCRI,     ';
  Result := Result + '    MAE_PRODUT AS PRODUT,     ';
  Result := Result + '    MAE_NOMCOR AS NOMCOR,     ';
  Result := Result + '    MAE_UNIDAD AS UNIDAD,     ';
  Result := Result + '    MAE_CODBAS AS CODBAS,     ';
  Result := Result + '    MAE_MD5KEY AS MD5KEY,     ';
  Result := Result + '    MAE_COLECA AS COLECA,     ';
  Result := Result + '    MAE_CODITE AS CODITE,     ';
  Result := Result + '    MAE_DESITE AS DESITE,     ';
  Result := Result + '    MAE_REFERE AS REFERE,     ';
  Result := Result + '    MAE_PREVEN AS PREVEN,     ';
  Result := Result + '    MAE_PRECUS AS PRECUS,     ';
  Result := Result + '    MAE_PREVE1 AS PREVE1,     ';
  Result := Result + '    MAE_PREVE2 AS PREVE2,     ';
  Result := Result + '    MAE_PREVE3 AS PREVE3,     ';
  Result := Result + '    MAE_PREVE4 AS PREVE4,     ';
  Result := Result + '    MAE_PREVE5 AS PREVE5,     ';
  Result := Result + '    MAE_PREVE6 AS PREVE6,     ';
  Result := Result + '    MAE_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosSIN }

function TImportaTintometricosTerceirosSIN.fCampoCodIte: String;
begin
  Result := 'SIN_CODITE';
end;

function TImportaTintometricosTerceirosSIN.fCampoMD5: String;
begin
  Result := 'SIN_MD5KEY';
end;

function TImportaTintometricosTerceirosSIN.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    SIN_CODIGO,           ';
  Result := Result + '    SIN_DESCRI,           ';
  Result := Result + '    SIN_CODBAS,           ';
  Result := Result + '    SIN_PRODUT,           ';
  Result := Result + '    SIN_UNIDAD,           ';
  Result := Result + '    SIN_NOMCOR,           ';
  Result := Result + '    SIN_DTACAD,           ';
  Result := Result + '    SIN_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    SIN_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    SIN_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    SIN_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    SIN_CADSIN            ';
  Result := Result + '  INNER JOIN SIN_CADBAS ON                    ';
  Result := Result + '    SIN_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    SIN_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    SIN_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    SIN_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosSIN.fNomeTabela: String;
begin
  Result := 'SIN_CADSIN_SIT';
end;

function TImportaTintometricosTerceirosSIN.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    SIN_CODIGO AS CODIGO,     ';
  Result := Result + '    SIN_DESCRI AS DESCRI,     ';
  Result := Result + '    SIN_PRODUT AS PRODUT,     ';
  Result := Result + '    SIN_NOMCOR AS NOMCOR,     ';
  Result := Result + '    SIN_UNIDAD AS UNIDAD,     ';
  Result := Result + '    SIN_CODBAS AS CODBAS,     ';
  Result := Result + '    SIN_MD5KEY AS MD5KEY,     ';
  Result := Result + '    SIN_CODITE AS CODITE,     ';
  Result := Result + '    SIN_DESITE AS DESITE,     ';
  Result := Result + '    SIN_REFERE AS REFERE,     ';
  Result := Result + '    SIN_PREVEN AS PREVEN,     ';
  Result := Result + '    SIN_PRECUS AS PRECUS,     ';
  Result := Result + '    SIN_PREVE1 AS PREVE1,     ';
  Result := Result + '    SIN_PREVE2 AS PREVE2,     ';
  Result := Result + '    SIN_PREVE3 AS PREVE3,     ';
  Result := Result + '    SIN_PREVE4 AS PREVE4,     ';
  Result := Result + '    SIN_PREVE5 AS PREVE5,     ';
  Result := Result + '    SIN_PREVE6 AS PREVE6,     ';
  Result := Result + '    SIN_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosDCA }

function TImportaTintometricosTerceirosDCA.fCampoCodIte: String;
begin
  Result := 'DCA_CODITE';
end;

function TImportaTintometricosTerceirosDCA.fCampoMD5: String;
begin
  Result := 'DCA_MD5KEY';
end;

function TImportaTintometricosTerceirosDCA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    DCA_CODIGO,           ';
  Result := Result + '    DCA_CODBAS,           ';
  Result := Result + '    DCA_PRODUT,           ';
  Result := Result + '    DCA_COLECA,           ';
  Result := Result + '    DCA_UNIDAD,           ';
  Result := Result + '    DCA_NOMCOR,           ';
  Result := Result + '    DCA_DTACAD,           ';
  Result := Result + '    DCA_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    DCA_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    DCA_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    DCA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    DCA_CADDCA            ';
  Result := Result + '  INNER JOIN DCA_CADBAS ON                    ';
  Result := Result + '    DCA_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    DCA_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    DCA_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    DCA_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosDCA.fNomeTabela: String;
begin
  Result := 'DCA_CADDCA_SIT';
end;

function TImportaTintometricosTerceirosDCA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    DCA_CODIGO AS CODIGO,     ';
  Result := Result + '    DCA_PRODUT AS PRODUT,     ';
  Result := Result + '    DCA_PRODUT AS DESCRI,     ';
  Result := Result + '    DCA_NOMCOR AS NOMCOR,     ';
  Result := Result + '    DCA_UNIDAD AS UNIDAD,     ';
  Result := Result + '    DCA_CODBAS AS CODBAS,     ';
  Result := Result + '    DCA_MD5KEY AS MD5KEY,     ';
  Result := Result + '    DCA_COLECA AS COLECA,     ';
  Result := Result + '    DCA_CODITE AS CODITE,     ';
  Result := Result + '    DCA_DESITE AS DESITE,     ';
  Result := Result + '    DCA_REFERE AS REFERE,     ';
  Result := Result + '    DCA_PREVEN AS PREVEN,     ';
  Result := Result + '    DCA_PRECUS AS PRECUS,     ';
  Result := Result + '    DCA_PREVE1 AS PREVE1,     ';
  Result := Result + '    DCA_PREVE2 AS PREVE2,     ';
  Result := Result + '    DCA_PREVE3 AS PREVE3,     ';
  Result := Result + '    DCA_PREVE4 AS PREVE4,     ';
  Result := Result + '    DCA_PREVE5 AS PREVE5,     ';
  Result := Result + '    DCA_PREVE6 AS PREVE6,     ';
  Result := Result + '    DCA_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosLUZ }

function TImportaTintometricosTerceirosLUZ.fCampoCodIte: String;
begin
  Result := 'LUZ_CODITE';
end;

function TImportaTintometricosTerceirosLUZ.fCampoMD5: String;
begin
  Result := 'LUZ_MD5KEY';
end;

function TImportaTintometricosTerceirosLUZ.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    LUZ_CODIGO,           ';
  Result := Result + '    LUZ_CODBAS,           ';
  Result := Result + '    LUZ_PRODUT,           ';
  Result := Result + '    LUZ_COLECA,           ';
  Result := Result + '    LUZ_UNIDAD,           ';
  Result := Result + '    LUZ_NOMCOR,           ';
  Result := Result + '    LUZ_DTACAD,           ';
  Result := Result + '    LUZ_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    LUZ_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LUZ_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    DCA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    LUZ_CADLUZ            ';
  Result := Result + '  INNER JOIN LUZ_CADBAS ON                    ';
  Result := Result + '    LUZ_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    LUZ_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    LUZ_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    LUZ_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosLUZ.fNomeTabela: String;
begin
  Result := 'LUZ_CADLUZ_SIT';
end;

function TImportaTintometricosTerceirosLUZ.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    LUZ_CODIGO AS CODIGO,     ';
  Result := Result + '    LUZ_PRODUT AS PRODUT,     ';
  Result := Result + '    LUZ_PRODUT AS DESCRI,     ';
  Result := Result + '    LUZ_NOMCOR AS NOMCOR,     ';
  Result := Result + '    LUZ_UNIDAD AS UNIDAD,     ';
  Result := Result + '    LUZ_CODBAS AS CODBAS,     ';
  Result := Result + '    LUZ_MD5KEY AS MD5KEY,     ';
  Result := Result + '    LUZ_COLECA AS COLECA,     ';
  Result := Result + '    LUZ_CODITE AS CODITE,     ';
  Result := Result + '    LUZ_DESITE AS DESITE,     ';
  Result := Result + '    LUZ_REFERE AS REFERE,     ';
  Result := Result + '    LUZ_PREVEN AS PREVEN,     ';
  Result := Result + '    LUZ_PRECUS AS PRECUS,     ';
  Result := Result + '    LUZ_PREVE1 AS PREVE1,     ';
  Result := Result + '    LUZ_PREVE2 AS PREVE2,     ';
  Result := Result + '    LUZ_PREVE3 AS PREVE3,     ';
  Result := Result + '    LUZ_PREVE4 AS PREVE4,     ';
  Result := Result + '    LUZ_PREVE5 AS PREVE5,     ';
  Result := Result + '    LUZ_PREVE6 AS PREVE6,     ';
  Result := Result + '    LUZ_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosLEC }

function TImportaTintometricosTerceirosLEC.fCampoCodIte: String;
begin
  Result := 'LEC_CODITE';
end;

function TImportaTintometricosTerceirosLEC.fCampoMD5: String;
begin
  Result := 'LEC_MD5KEY';
end;

function TImportaTintometricosTerceirosLEC.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    LEC_CODBAS,           ';
  Result := Result + '    LEC_CODNFM,           ';
  Result := Result + '    LEC_CODEMB,           ';
  Result := Result + '    LEC_CODCOR,           ';
  Result := Result + '    LEC_DESCOR,           ';
  Result := Result + '    LEC_EFECOR,           ';
  Result := Result + '    LEC_MASIND,           ';
  Result := Result + '    LEC_ANOINI,           ';
  Result := Result + '    LEC_ANOFIN,           ';
  Result := Result + '    LEC_DESCRI,           ';
  Result := Result + '    LEC_QTDTOT,           ';
  Result := Result + '    LEC_QTDB01,           ';
  Result := Result + '    LEC_PERB01,           ';
  Result := Result + '    LEC_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    LEC_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LEC_QTDC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LEC_PERC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    LEC_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    LEC_CADLEC            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    LEC_MD5KEY = :MD5KEY; ';

end;

function TImportaTintometricosTerceirosLEC.fNomeTabela: String;
begin
  Result := 'LEC_CADLEC_SIT';
end;

function TImportaTintometricosTerceirosLEC.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    LEC_CODBAS AS CODBAS,       ';
  Result := Result + '    LEC_CODNFM AS CODNFM,       ';
  Result := Result + '    LEC_CODEMB AS CODEMB,       ';
  Result := Result + '    LEC_CODCOR AS CODCOR,       ';
  Result := Result + '    LEC_DESCOR AS DESCOR,       ';
  Result := Result + '    LEC_DESCOR AS NOMCOR,       ';
  Result := Result + '    LEC_EFECOR AS EFECOR,       ';
  Result := Result + '    LEC_MASIND AS MASIND,       ';
  Result := Result + '    LEC_ANOINI AS ANOINI,       ';
  Result := Result + '    LEC_ANOFIN AS ANOFIN,       ';
  Result := Result + '    LEC_DESCRI AS DESCRI,       ';
  Result := Result + '    LEC_MD5KEY AS MD5KEY,       ';
  Result := Result + '    LEC_CODITE AS CODITE,       ';
  Result := Result + '    ITE_REFERE AS REFERE,       ';
  Result := Result + '    LEC_CODDIL AS CODDIL,       ';
  Result := Result + '    LEC_PORDIL AS PORDIL,       ';
  Result := Result + '    LEC_PRECLT AS PRECLT,       ';
  Result := Result + '    LEC_PRECGL AS PRECGL,       ';
  Result := Result + '    LEC_PRECLA AS PRECLA,       ';
  Result := Result + '    LEC_PRECBD AS PRECBD,       ';
  Result := Result + '    LEC_PREDLT AS PREDLT,       ';
  Result := Result + '    LEC_PREDGL AS PREDGL,       ';
  Result := Result + '    LEC_PREDLA AS PREDLA,       ';
  Result := Result + '    LEC_PREDBD AS PREDBD,       ';
  Result := Result + '    LEC_EMBALT AS EMBALT,       ';
  Result := Result + '    LEC_EMBAGL AS EMBAGL,       ';
  Result := Result + '    LEC_EMBALA AS EMBALA,       ';
  Result := Result + '    LEC_EMBABD AS EMBABD,       ';
  Result := Result + '    LEC_VOLULT AS VOLULT,       ';
  Result := Result + '    LEC_VOLUGL AS VOLUGL,       ';
  Result := Result + '    LEC_VOLULA AS VOLULA,       ';
  Result := Result + '    LEC_VOLUBD AS VOLUBD,       ';
  Result := Result + '    LEC_PREELT AS PREELT,       ';
  Result := Result + '    LEC_PREEGL AS PREEGL,       ';
  Result := Result + '    LEC_PREELA AS PREELA,       ';
  Result := Result + '    LEC_PREEBD AS PREEBD,       ';
  Result := Result + '    LEC_TIPOLT AS TIPOLT,       ';
  Result := Result + '    LEC_TIPOGL AS TIPOGL,       ';
  Result := Result + '    LEC_TIPOLA AS TIPOLA,       ';
  Result := Result + '    LEC_TIPOBD AS TIPOBD        ';
end;
{ TImportaTintometricosTerceirosREP }

function TImportaTintometricosTerceirosREP.fCampoCodIte: String;
begin
  Result := 'REP_CODITE';
end;

function TImportaTintometricosTerceirosREP.fCampoMD5: String;
begin
  Result := 'REP_MD5KEY';
end;

function TImportaTintometricosTerceirosREP.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    REP_CODIGO,           ';
  Result := Result + '    REP_NOMCOR,           ';
  Result := Result + '    REP_PADRAO,           ';
  Result := Result + '    REP_CODBAS,           ';
  Result := Result + '    REP_QTDBAS,           ';
  Result := Result + '    REP_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    REP_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    REP_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    REP_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    REP_CADREP            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE AND              ';
  Result := Result + '    REP_MD5KEY = :MD5KEY  ';
end;

function TImportaTintometricosTerceirosREP.fNomeTabela: String;
begin
  Result := 'REP_CADREP_SIT';
end;

function TImportaTintometricosTerceirosREP.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    REP_CODIGO AS CODIGO, ';
  Result := Result + '    REP_NOMCOR AS NOMCOR, ';
  Result := Result + '    REP_PADRAO AS DESCRI, ';
  Result := Result + '    REP_CODBAS AS CODBAS, ';
  Result := Result + '    REP_MD5KEY AS MD5KEY, ';
  Result := Result + '    REP_CODITE AS CODITE, ';
  Result := Result + '    ITE_DESITE AS DESITE, ';
  Result := Result + '    ITE_REFERE AS REFERE, ';
  Result := Result + '    REP_CODDIL AS CODDIL, ';
  Result := Result + '    REP_PORDIL AS PORDIL, ';
  Result := Result + '    REP_PRECLT AS PRECLT, ';
  Result := Result + '    REP_PRECGL AS PRECGL, ';
  Result := Result + '    REP_PREDLT AS PREDLT, ';
  Result := Result + '    REP_PREDGL AS PREDGL, ';
  Result := Result + '    REP_PCUCLT AS PCUCLT, ';
  Result := Result + '    REP_PCUDLT AS PCUCLT, ';
  Result := Result + '    REP_PCUCGL AS PCUCGL, ';
  Result := Result + '    REP_PCUDGL AS PCUDGL, ';
  Result := Result + '    REP_PRCLT1 AS PRCLT1, ';
  Result := Result + '    REP_PRCLT2 AS PRCLT2, ';
  Result := Result + '    REP_PRCLT3 AS PRCLT3, ';
  Result := Result + '    REP_PRCLT4 AS PRCLT4, ';
  Result := Result + '    REP_PRCLT5 AS PRCLT5, ';
  Result := Result + '    REP_PRCLT6 AS PRCLT6, ';
  Result := Result + '    REP_PRCLT7 AS PRCLT7, ';
  Result := Result + '    REP_PRCGL1 AS PRCGL1, ';
  Result := Result + '    REP_PRCGL2 AS PRCGL2, ';
  Result := Result + '    REP_PRCGL3 AS PRCGL3, ';
  Result := Result + '    REP_PRCGL4 AS PRCGL4, ';
  Result := Result + '    REP_PRCGL5 AS PRCGL5, ';
  Result := Result + '    REP_PRCGL6 AS PRCGL6, ';
  Result := Result + '    REP_PRCGL7 AS PRCGL7, ';
  Result := Result + '    REP_PRDLT1 AS PRDLT1, ';
  Result := Result + '    REP_PRDLT2 AS PRDLT2, ';
  Result := Result + '    REP_PRDLT3 AS PRDLT3, ';
  Result := Result + '    REP_PRDLT4 AS PRDLT4, ';
  Result := Result + '    REP_PRDLT5 AS PRDLT5, ';
  Result := Result + '    REP_PRDLT6 AS PRDLT6, ';
  Result := Result + '    REP_PRDLT7 AS PRDLT7, ';
  Result := Result + '    REP_PRDGL1 AS PRDGL1, ';
  Result := Result + '    REP_PRDGL2 AS PRDGL2, ';
  Result := Result + '    REP_PRDGL3 AS PRDGL3, ';
  Result := Result + '    REP_PRDGL4 AS PRDGL4, ';
  Result := Result + '    REP_PRDGL5 AS PRDGL5, ';
  Result := Result + '    REP_PRDGL6 AS PRDGL6, ';
  Result := Result + '    REP_PRDGL7 AS PRDGL7, ';
  Result := Result + '    REP_EMBALT AS EMBALT, ';
  Result := Result + '    REP_EMBAGL AS EMBAGL, ';
  Result := Result + '    REP_VOLULT AS VOLULT, ';
  Result := Result + '    REP_VOLUGL AS VOLUGL, ';
  Result := Result + '    REP_PREELT AS PREELT, ';
  Result := Result + '    REP_PREEGL AS PREEGL, ';
  Result := Result + '    REP_TIPOLT AS TIPOLT, ';
  Result := Result + '    REP_TIPOGL AS TIPOGL  ';
end;

{ TImportaTintometricosTerceirosMIF }

function TImportaTintometricosTerceirosMIF.fCampoCodIte: String;
begin
  Result := 'MIF_CODITE';
end;

function TImportaTintometricosTerceirosMIF.fCampoMD5: String;
begin
  Result := 'MIF_MD5KEY';
end;

function TImportaTintometricosTerceirosMIF.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MIF_CODIGO,           ';
  Result := Result + '    MIF_DESCRI,           ';
  Result := Result + '    MIF_ANOCOR,           ';
  Result := Result + '    MIF_MONTAD,           ';
  Result := Result + '    MIF_REFERE,           ';
  Result := Result + '    MIF_CODCLI,           ';
  Result := Result + '    MIF_CLIENT,           ';
  Result := Result + '    MIF_LINHA_,           ';
  Result := Result + '    MIF_DTACAD,           ';
  Result := Result + '    MIF_ACRMOB,           ';
  Result := Result + '    MIF_PADREF,           ';
  Result := Result + '    MIF_ORIGEM,           ';
  Result := Result + '    MIF_TMPCF4,           ';
  Result := Result + '    MIF_ESPDEM,           ';
  Result := Result + '    MIF_ESPSEC,           ';
  Result := Result + '    MIF_SECAGD,           ';
  Result := Result + '    MIF_SECAGM,           ';
  Result := Result + '    MIF_SECAGT,           ';
  Result := Result + '    MIF_CATALI,           ';
  Result := Result + '    MIF_ITEMCB,           ';
  Result := Result + '    MIF_ITEMCC,           ';
  Result := Result + '    MIF_BRIL20,           ';
  Result := Result + '    MIF_BRIL60,           ';
  Result := Result + '    MIF_BRIL85,           ';
  Result := Result + '    MIF_OBSERV,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    MIF_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MIF_QTDC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MIF_QTDD' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    MIF_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MIF_CADMIF            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE AND              ';
  Result := Result + '    MIF_MD5KEY = :MD5KEY  ';
end;

function TImportaTintometricosTerceirosMIF.fNomeTabela: String;
begin
  Result := 'MIF_CADMIF_SIT';
end;

function TImportaTintometricosTerceirosMIF.fSelect: String;
begin
  Result := Result + '  SELECT                          ';
  Result := Result + '    MIF_CODIGO AS CODIGO,         ';
  Result := Result + '    MIF_DESCRI AS DESCRI,         ';
  Result := Result + '    MIF_DESCRI AS NOMCOR,         ';
  Result := Result + '    MIF_ANOCOR AS ANOCOR,         ';
  Result := Result + '    MIF_MONTAD AS MONTAD,         ';
  Result := Result + '    MIF_REFERE AS REFERE,         ';
  Result := Result + '    MIF_CODCLI AS CODCLI,         ';
  Result := Result + '    MIF_CLIENT AS CLIENT,         ';
  Result := Result + '    MIF_LINHA_ AS LINHA_,         ';
  Result := Result + '    MIF_PADREF AS PADREF,         ';
  Result := Result + '    MIF_ORIGEM AS ORIGEM,         ';
  Result := Result + '    MIF_TMPCF4 AS TMPCF4,         ';
  Result := Result + '    MIF_ESPDEM AS ESPDEM,         ';
  Result := Result + '    MIF_ESPSEC AS ESPSEC,         ';
  Result := Result + '    MIF_SECAGD AS SECAGD,         ';
  Result := Result + '    MIF_SECAGM AS SECAGM,         ';
  Result := Result + '    MIF_SECAGT AS SECAGT,         ';
  Result := Result + '    MIF_CATALI AS CATALI,         ';
  Result := Result + '    MIF_ITEMCB AS ITEMCB,         ';
  Result := Result + '    MIF_ITEMCC AS ITEMCC,         ';
  Result := Result + '    MIF_OBSERV AS OBSERV,         ';
  Result := Result + '    MIF_BRIL20 AS BRIL20,         ';
  Result := Result + '    MIF_BRIL60 AS BRIL60,         ';
  Result := Result + '    MIF_BRIL85 AS BRIL85,         ';
  Result := Result + '    MIF_MD5KEY AS MD5KEY,         ';
  Result := Result + '    MIF_CODITE AS CODITE,         ';
  Result := Result + '    MIF_CODDIL AS CODDIL,         ';
  Result := Result + '    MIF_PORDIL AS PORDIL,         ';
  Result := Result + '    MIF_PRECLT AS PRECLT,         ';
  Result := Result + '    MIF_PRECGL AS PRECGL,         ';
  Result := Result + '    MIF_PRECLA AS PRECLA,         ';
  Result := Result + '    MIF_PRECTB AS PRECTB,         ';
  Result := Result + '    MIF_PRECSP AS PRECSP,         ';
  Result := Result + '    MIF_PREDLT AS PREDLT,         ';
  Result := Result + '    MIF_PREDGL AS PREDGL,         ';
  Result := Result + '    MIF_PREDLA AS PREDLA,         ';
  Result := Result + '    MIF_PREDTB AS PREDTB,         ';
  Result := Result + '    MIF_PREDSP AS PREDSP,         ';
  Result := Result + '    MIF_EMBALT AS EMBALT,         ';
  Result := Result + '    MIF_EMBAGL AS EMBAGL,         ';
  Result := Result + '    MIF_EMBALA AS EMBALA,         ';
  Result := Result + '    MIF_EMBATB AS EMBATB,         ';
  Result := Result + '    MIF_EMBASP AS EMBASP,         ';
  Result := Result + '    MIF_VOLULT AS VOLULT,         ';
  Result := Result + '    MIF_VOLUGL AS VOLUGL,         ';
  Result := Result + '    MIF_VOLULA AS VOLULA,         ';
  Result := Result + '    MIF_VOLUTB AS VOLUTB,         ';
  Result := Result + '    MIF_VOLUSP AS VOLUSP,         ';
  Result := Result + '    MIF_PREELT AS PREELT,         ';
  Result := Result + '    MIF_PREEGL AS PREEGL,         ';
  Result := Result + '    MIF_PREELA AS PREELA,         ';
  Result := Result + '    MIF_PREETB AS PREETB,         ';
  Result := Result + '    MIF_PREESP AS PREESP,         ';
  Result := Result + '    MIF_TIPOLT AS TIPOLT,         ';
  Result := Result + '    MIF_TIPOGL AS TIPOGL,         ';
  Result := Result + '    MIF_TIPOLA AS TIPOLA,         ';
  Result := Result + '    MIF_TIPOTB AS TIPOTB,         ';
  Result := Result + '    MIF_TIPOSP AS TIPOSP          ';
end;

{ TImportaTintometricosTerceirosPRT }

function TImportaTintometricosTerceirosPRT.fCampoCodIte: String;
begin
  Result := 'PRT_CODITE';
end;

function TImportaTintometricosTerceirosPRT.fCampoMD5: String;
begin
  Result := 'PRT_MD5KEY';
end;

function TImportaTintometricosTerceirosPRT.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    PRT_CODIGO,           ';
  Result := Result + '    PRT_CODBAS,           ';
  Result := Result + '    PRT_PRODUT,           ';
  Result := Result + '    PRT_LINHA_,           ';
  Result := Result + '    PRT_UNIDAD,           ';
  Result := Result + '    PRT_NOMCOR,           ';
  Result := Result + '    PRT_DTACAD,           ';
  Result := Result + '    PRT_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    PRT_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    PRT_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    PRT_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    PRT_CADPRT            ';
  Result := Result + '  INNER JOIN PRT_CADBAS ON                    ';
  Result := Result + '    PRT_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    PRT_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    PRT_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    PRT_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosPRT.fNomeTabela: String;
begin
  Result := 'PRT_CADPRT_SIT';
end;

function TImportaTintometricosTerceirosPRT.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    PRT_CODIGO AS CODIGO,     ';
  Result := Result + '    PRT_PRODUT AS PRODUT,     ';
  Result := Result + '    PRT_PRODUT AS DESCRI,     ';
  Result := Result + '    PRT_NOMCOR AS NOMCOR,     ';
  Result := Result + '    PRT_UNIDAD AS UNIDAD,     ';
  Result := Result + '    PRT_CODBAS AS CODBAS,     ';
  Result := Result + '    PRT_MD5KEY AS MD5KEY,     ';
  Result := Result + '    PRT_LINHA_ AS LINHA_,     ';
  Result := Result + '    PRT_CODITE AS CODITE,     ';
  Result := Result + '    PRT_DESITE AS DESITE,     ';
  Result := Result + '    PRT_REFERE AS REFERE,     ';
  Result := Result + '    PRT_PREVEN AS PREVEN,     ';
  Result := Result + '    PRT_PRECUS AS PRECUS,     ';
  Result := Result + '    PRT_PREVE1 AS PREVE1,     ';
  Result := Result + '    PRT_PREVE2 AS PREVE2,     ';
  Result := Result + '    PRT_PREVE3 AS PREVE3,     ';
  Result := Result + '    PRT_PREVE4 AS PREVE4,     ';
  Result := Result + '    PRT_PREVE5 AS PREVE5,     ';
  Result := Result + '    PRT_PREVE6 AS PREVE6,     ';
  Result := Result + '    PRT_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosAN2 }

function TImportaTintometricosTerceirosAN2.fCampoCodIte: String;
begin
  Result := 'AN2_CODITE';
end;

function TImportaTintometricosTerceirosAN2.fCampoMD5: String;
begin
  Result := 'AN2_MD5KEY';
end;

function TImportaTintometricosTerceirosAN2.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    AN2_CODIGO,           ';
  Result := Result + '    AN2_CODBAS,           ';
  Result := Result + '    AN2_PRODUT,           ';
  Result := Result + '    AN2_COLECA,           ';
  Result := Result + '    AN2_UNIDAD,           ';
  Result := Result + '    AN2_NOMCOR,           ';
  Result := Result + '    AN2_DTACAD,           ';
  Result := Result + '    AN2_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    AN2_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    AN2_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    AN2_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    AN2_CADAN2            ';
  Result := Result + '  INNER JOIN AN2_CADBAS ON                    ';
  Result := Result + '    AN2_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    AN2_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    AN2_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    AN2_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosAN2.fNomeTabela: String;
begin
  Result := 'AN2_CADAN2_SIT';
end;

function TImportaTintometricosTerceirosAN2.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    AN2_CODIGO AS CODIGO,     ';
  Result := Result + '    AN2_PRODUT AS PRODUT,     ';
  Result := Result + '    AN2_PRODUT AS DESCRI,     ';
  Result := Result + '    AN2_NOMCOR AS NOMCOR,     ';
  Result := Result + '    AN2_UNIDAD AS UNIDAD,     ';
  Result := Result + '    AN2_CODBAS AS CODBAS,     ';
  Result := Result + '    AN2_MD5KEY AS MD5KEY,     ';
  Result := Result + '    AN2_COLECA AS COLECA,     ';
  Result := Result + '    AN2_CODITE AS CODITE,     ';
  Result := Result + '    AN2_DESITE AS DESITE,     ';
  Result := Result + '    AN2_REFERE AS REFERE,     ';
  Result := Result + '    AN2_PREVEN AS PREVEN,     ';
  Result := Result + '    AN2_PRECUS AS PRECUS,     ';
  Result := Result + '    AN2_PREVE1 AS PREVE1,     ';
  Result := Result + '    AN2_PREVE2 AS PREVE2,     ';
  Result := Result + '    AN2_PREVE3 AS PREVE3,     ';
  Result := Result + '    AN2_PREVE4 AS PREVE4,     ';
  Result := Result + '    AN2_PREVE5 AS PREVE5,     ';
  Result := Result + '    AN2_PREVE6 AS PREVE6,     ';
  Result := Result + '    AN2_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosRS2 }

function TImportaTintometricosTerceirosRS2.fCampoCodIte: String;
begin
  Result := 'RS2_CODITE';
end;

function TImportaTintometricosTerceirosRS2.fCampoMD5: String;
begin
  Result := 'RS2_MD5KEY';
end;

function TImportaTintometricosTerceirosRS2.fGetSelectConsultaPorMd5: String;
Var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    RS2_CODIGO,           ';
  Result := Result + '    RS2_CODBAS,           ';
  Result := Result + '    RS2_PRODUT,           ';
  Result := Result + '    RS2_COLECA,           ';
  Result := Result + '    RS2_EMBALA,           ';
  Result := Result + '    RS2_UNIDAD,           ';
  Result := Result + '    RS2_NOMCOR,           ';
  Result := Result + '    RS2_DTACAD,           ';
  Result := Result + '    RS2_ACRMOB,           ';
  Result := Result + '    RS2_OBSERV,           ';

  For LContador := 1 To 20 Do
  Begin
    Result := Result + '    RS2_FORM' + fStrZero(LContador, 2) + ',     ';
    Result := Result + '    RS2_QTDC' + fStrZero(LContador, 2) + ',     ';
  End;

  Result := Result + '    RS2_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    RS2_CADRS2            ';
  Result := Result + '  INNER JOIN RS2_CADBAS ON                    ';
  Result := Result + '    RS2_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    RS2_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    RS2_PRODUT = BAS_PRODUT AND               ';
  Result := Result + '    RS2_EMBALA = BAS_EMBALA                   ';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    RS2_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosRS2.fNomeTabela: String;
begin
  Result := 'RS2_CADRS2_SIT';
end;

function TImportaTintometricosTerceirosRS2.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    RS2_CODIGO AS CODIGO,     ';
  Result := Result + '    RS2_PRODUT AS PRODUT,     ';
  Result := Result + '    RS2_PRODUT AS DESCRI,     ';
  Result := Result + '    RS2_NOMCOR AS NOMCOR,     ';
  Result := Result + '    RS2_UNIDAD AS UNIDAD,     ';
  Result := Result + '    RS2_EMBALA AS EMBALA,     ';
  Result := Result + '    RS2_CODBAS AS CODBAS,     ';
  Result := Result + '    RS2_COLECA AS COLECA,     ';
  Result := Result + '    RS2_OBSERV AS OBSERV,     ';
  Result := Result + '    RS2_MD5KEY AS MD5KEY,     ';
  Result := Result + '    RS2_CODITE AS CODITE,     ';
  Result := Result + '    RS2_DESITE AS DESITE,     ';
  Result := Result + '    RS2_REFERE AS REFERE,     ';
  Result := Result + '    RS2_PREVEN AS PREVEN,     ';
  Result := Result + '    RS2_PRECUS AS PRECUS,     ';
  Result := Result + '    RS2_PREVE1 AS PREVE1,     ';
  Result := Result + '    RS2_PREVE2 AS PREVE2,     ';
  Result := Result + '    RS2_PREVE3 AS PREVE3,     ';
  Result := Result + '    RS2_PREVE4 AS PREVE4,     ';
  Result := Result + '    RS2_PREVE5 AS PREVE5,     ';
  Result := Result + '    RS2_PREVE6 AS PREVE6,     ';
  Result := Result + '    RS2_PREVE7 AS PREVE7      ';
end;

{ TImportaTintometricosTerceirosALV }

function TImportaTintometricosTerceirosALV.fCampoCodIte: String;
begin
  Result := 'ALV_CODITE';
end;

function TImportaTintometricosTerceirosALV.fCampoMD5: String;
begin
  Result := 'ALV_MD5KEY';
end;

function TImportaTintometricosTerceirosALV.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ALV_CODIGO,           ';
  Result := Result + '    ALV_CODBAS,           ';
  Result := Result + '    ALV_PRODUT,           ';
  Result := Result + '    ALV_SISTEM,           ';
  Result := Result + '    ALV_UNIDAD,           ';
  Result := Result + '    ALV_DESCOR,           ';
  Result := Result + '    ALV_DTACAD,           ';
  Result := Result + '    ALV_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ALV_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALV_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ALV_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ALV_CADALV            ';
  Result := Result + '  INNER JOIN ALV_CADBAS ON                    ';
  Result := Result + '    ALV_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    ALV_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    ALV_PRODUT = BAS_PRODUT AND               ';
  Result := Result + '	  ALV_VOLUME = BAS_EMBALA 					';
  Result := Result + '  INNER JOIN CADITE ON                        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    ALV_MD5KEY = :MD5KEY          ';
end;

function TImportaTintometricosTerceirosALV.fNomeTabela: String;
begin
  Result := 'ALV_CADALV_SIT';
end;

function TImportaTintometricosTerceirosALV.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    ALV_CODIGO AS CODIGO,     ';
  Result := Result + '    ALV_PRODUT AS PRODUT,     ';
  Result := Result + '    ALV_PRODUT AS DESCRI,     ';
  Result := Result + '    ALV_DESCOR AS NOMCOR,     ';
  Result := Result + '    ALV_UNIDAD AS UNIDAD,     ';
  Result := Result + '    ALV_CODBAS AS CODBAS,     ';
  Result := Result + '    ALV_MD5KEY AS MD5KEY,     ';
  Result := Result + '    ALV_SISTEM AS SISTEM,     ';
  Result := Result + '    ALV_CODITE AS CODITE,     ';
  Result := Result + '    ALV_DESITE AS DESITE,     ';
  Result := Result + '    ALV_REFERE AS REFERE,     ';
  Result := Result + '    ALV_PREVEN AS PREVEN,     ';
  Result := Result + '    ALV_PRECUS AS PRECUS,     ';
  Result := Result + '    ALV_PREVE1 AS PREVE1,     ';
  Result := Result + '    ALV_PREVE2 AS PREVE2,     ';
  Result := Result + '    ALV_PREVE3 AS PREVE3,     ';
  Result := Result + '    ALV_PREVE4 AS PREVE4,     ';
  Result := Result + '    ALV_PREVE5 AS PREVE5,     ';
  Result := Result + '    ALV_PREVE6 AS PREVE6,     ';
  Result := Result + '    ALV_PREVE7 AS PREVE7      ';
end;


{ TImportaTintometricosTerceirosPFA }

function TImportaTintometricosTerceirosPFA.fCampoCodIte: String;
begin
  Result := 'PFA_CODITE';
end;

function TImportaTintometricosTerceirosPFA.fCampoMD5: String;
begin
  Result := 'PFA_MD5KEY';
end;

function TImportaTintometricosTerceirosPFA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    PFA_CODIGO,             ';
  Result := Result + '    PFA_DESCRI,             ';
  Result := Result + '    PFA_NOMCOR,             ';
  Result := Result + '    PFA_A_N_O_,             ';
  Result := Result + '    PFA_LINHA_,             ';
  Result := Result + '    PFA_TIPLIN,             ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    PFA_CODB' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    PFA_QTDB' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    PFA_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    PFA_CADPFA              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    PFA_MD5KEY = :MD5KEY    ';
end;

function TImportaTintometricosTerceirosPFA.fNomeTabela: String;
begin
  Result := 'PFA_CADPFA_SIT';
end;

function TImportaTintometricosTerceirosPFA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    PFA_CODIGO AS CODIGO,                 ';
  Result := Result + '    PFA_DESCRI AS DESCRI,                 ';
  Result := Result + '    PFA_NOMCOR AS NOMCOR,                 ';
  Result := Result + '    ITE_REFERE AS REFERE,                 ';
  Result := Result + '    ITE_DESITE AS DESITE,                 ';
  Result := Result + '    PFA_CODITE AS CODITE,                 ';
  Result := Result + '    PFA_A_N_O_ AS A_N_O_,                 ';
  Result := Result + '    PFA_LINHA_ AS LINHA_,                 ';
  Result := Result + '    PFA_TIPLIN AS TIPLIN,                 ';
  Result := Result + '    PFA_MD5KEY AS MD5KEY,                 ';

  Result := Result + '    PFA_CODDIL AS CODDIL,                 ';
  Result := Result + '    PFA_PORDIL AS PORDIL,                 ';

  Result := Result + '    PFA_PRECLT AS PRECLT,                 ';
  Result := Result + '    PFA_PRECGL AS PRECGL,                 ';
  Result := Result + '    PFA_PRECLA AS PRECLA,                 ';


  Result := Result + '    PFA_PREDLT AS PREDLT,                 ';
  Result := Result + '    PFA_PREDGL AS PREDGL,                 ';
  Result := Result + '    PFA_PREDLA AS PREDLA,                 ';


  Result := Result + '    PFA_EMBALT AS EMBALT,                 ';
  Result := Result + '    PFA_EMBAGL AS EMBAGL,                 ';
  Result := Result + '    PFA_EMBALA AS EMBALA,                 ';

  Result := Result + '    PFA_VOLULT AS VOLULT,                 ';
  Result := Result + '    PFA_VOLUGL AS VOLUGL,                 ';
  Result := Result + '    PFA_VOLULA AS VOLULA,                 ';

  Result := Result + '    PFA_PREELT AS PREELT,                 ';
  Result := Result + '    PFA_PREEGL AS PREEGL,                 ';
  Result := Result + '    PFA_PREELA AS PREELA,                 ';

  Result := Result + '    PFA_TIPOLT AS TIPOLT,                 ';
  Result := Result + '    PFA_TIPOGL AS TIPOGL,                 ';
  Result := Result + '    PFA_TIPOLA AS TIPOLA                  ';
end;

{ TImportaTintometricosTerceirosALA }

function TImportaTintometricosTerceirosALA.fCampoCodIte: String;
begin
  Result := 'ALA_CODITE';
end;

function TImportaTintometricosTerceirosALA.fCampoMD5: String;
begin
  Result := 'ALA_MD5KEY';
end;

function TImportaTintometricosTerceirosALA.fGetSelectConsultaPorMd5: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ALA_CODIGO,           ';
  Result := Result + '    ALA_DESCRI,           ';
  Result := Result + '    ALA_SYSTEM,           ';
  Result := Result + '    ALA_TONALI,           ';
  Result := Result + '    ALA_TECNOL,           ';
  Result := Result + '    ALA_DTACAD,           ';
  Result := Result + '    ALA_ACRMOB,           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ALA_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALK_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ALA_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ALA_CADALA            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    ALA_MD5KEY = :MD5KEY; ';
end;

function TImportaTintometricosTerceirosALA.fNomeTabela: String;
begin
  Result := 'ALA_CADALA_SIT';
end;

function TImportaTintometricosTerceirosALA.fSelect: String;
begin
  Result := '';
  Result := Result + '  SELECT          ';
  Result := Result + '    ALA_CODIGO AS CODIGO,   ';
  Result := Result + '    ALA_DESCRI AS DESCRI,   ';
  Result := Result + '    ALA_DESCRI AS PRODUT,   ';
  Result := Result + '    ALA_DESCRI AS NOMCOR,   ';
  Result := Result + '    ALA_SYSTEM AS SYSTEM,   ';
  Result := Result + '    ALA_TONALI AS TONALI,   ';
  Result := Result + '    ALA_MD5KEY AS MD5KEY,   ';
  Result := Result + '    ITE_REFERE AS REFERE,   ';
  Result := Result + '    ALA_CODITE AS CODITE,   ';
  Result := Result + '    ALA_CODDIL AS CODDIL,   ';
  Result := Result + '    ALA_PORDIL AS PORDIL,   ';
  Result := Result + '    ALA_PRECLT AS PRECLT,   ';
  Result := Result + '    ALA_PRECGL AS PRECGL,   ';
  Result := Result + '    ALA_PRECLA AS PRECLA,   ';
  Result := Result + '    ALA_PREDLT AS PREDLT,   ';
  Result := Result + '    ALA_PREDGL AS PREDGL,   ';
  Result := Result + '    ALA_PREDLA AS PREDLA,   ';
  Result := Result + '    ALA_PCUCLT AS PCUCLT,   ';
  Result := Result + '    ALA_PCUCGL AS PCUCGL,   ';
  Result := Result + '    ALA_PCUCLA AS PCUCLA,   ';
  Result := Result + '    ALA_PCUDLT AS PCUDLT,   ';
  Result := Result + '    ALA_PCUDGL AS PCUDGL,   ';
  Result := Result + '    ALA_PCUDLA AS PCUDLA,   ';
  Result := Result + '    ALA_PRCLT1 AS PRCLT1,   ';
  Result := Result + '    ALA_PRCLT2 AS PRCLT2,   ';
  Result := Result + '    ALA_PRCLT3 AS PRCLT3,   ';
  Result := Result + '    ALA_PRCLT4 AS PRCLT4,   ';
  Result := Result + '    ALA_PRCLT5 AS PRCLT5,   ';
  Result := Result + '    ALA_PRCLT6 AS PRCLT6,   ';
  Result := Result + '    ALA_PRCLT7 AS PRCLT7,   ';
  Result := Result + '    ALA_PRDLT1 AS PRDLT1,   ';
  Result := Result + '    ALA_PRDLT2 AS PRDLT2,   ';
  Result := Result + '    ALA_PRDLT3 AS PRDLT3,   ';
  Result := Result + '    ALA_PRDLT4 AS PRDLT4,   ';
  Result := Result + '    ALA_PRDLT5 AS PRDLT5,   ';
  Result := Result + '    ALA_PRDLT6 AS PRDLT6,   ';
  Result := Result + '    ALA_PRDLT7 AS PRDLT7,   ';
  Result := Result + '    ALA_PRCGL1 AS PRCGL1,   ';
  Result := Result + '    ALA_PRCGL2 AS PRCGL2,   ';
  Result := Result + '    ALA_PRCGL3 AS PRCGL3,   ';
  Result := Result + '    ALA_PRCGL4 AS PRCGL4,   ';
  Result := Result + '    ALA_PRCGL5 AS PRCGL5,   ';
  Result := Result + '    ALA_PRCGL6 AS PRCGL6,   ';
  Result := Result + '    ALA_PRCGL7 AS PRCGL7,   ';
  Result := Result + '    ALA_PRDGL1 AS PRDGL1,   ';
  Result := Result + '    ALA_PRDGL2 AS PRDGL2,   ';
  Result := Result + '    ALA_PRDGL3 AS PRDGL3,   ';
  Result := Result + '    ALA_PRDGL4 AS PRDGL4,   ';
  Result := Result + '    ALA_PRDGL5 AS PRDGL5,   ';
  Result := Result + '    ALA_PRDGL6 AS PRDGL6,   ';
  Result := Result + '    ALA_PRDGL7 AS PRDGL7,   ';
  Result := Result + '    ALA_PRCLA1 AS PRCLA1,   ';
  Result := Result + '    ALA_PRCLA2 AS PRCLA2,   ';
  Result := Result + '    ALA_PRCLA3 AS PRCLA3,   ';
  Result := Result + '    ALA_PRCLA4 AS PRCLA4,   ';
  Result := Result + '    ALA_PRCLA5 AS PRCLA5,   ';
  Result := Result + '    ALA_PRCLA6 AS PRCLA6,   ';
  Result := Result + '    ALA_PRCLA7 AS PRCLA7,   ';
  Result := Result + '    ALA_PRDLA1 AS PRDLA1,   ';
  Result := Result + '    ALA_PRDLA2 AS PRDLA2,   ';
  Result := Result + '    ALA_PRDLA3 AS PRDLA3,   ';
  Result := Result + '    ALA_PRDLA4 AS PRDLA4,   ';
  Result := Result + '    ALA_PRDLA5 AS PRDLA5,   ';
  Result := Result + '    ALA_PRDLA6 AS PRDLA6,   ';
  Result := Result + '    ALA_PRDLA7 AS PRDLA7,   ';
  Result := Result + '    ALA_EMBALT AS EMBALT,   ';
  Result := Result + '    ALA_EMBAGL AS EMBAGL,   ';
  Result := Result + '    ALA_EMBALA AS EMBALA,   ';
  Result := Result + '    ALA_VOLULT AS VOLULT,   ';
  Result := Result + '    ALA_VOLUGL AS VOLUGL,   ';
  Result := Result + '    ALA_VOLULA AS VOLULA,   ';
  Result := Result + '    ALA_PREELT AS PREELT,   ';
  Result := Result + '    ALA_PREEGL AS PREEGL,   ';
  Result := Result + '    ALA_PREELA AS PREELA,   ';
  Result := Result + '    ALA_TIPOLT AS TIPOLT,   ';
  Result := Result + '    ALA_TIPOGL AS TIPOGL,   ';
  Result := Result + '    ALA_TIPOLA AS TIPOLA    ';
end;

end.
