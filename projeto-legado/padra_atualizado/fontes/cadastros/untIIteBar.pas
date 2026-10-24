unit untIIteBar;

interface

Uses untTypesSistema, Classes;

Type
  IIteBar = Interface
  ['{F468C6E4-6DB9-4552-A3B2-B89E58FAA4FF}']

    Function fGeraCodBarAuto(fltEmbala: Double): String;
    Function fQuantidadeEmbalagem(strCodIte, strCodBar: String): Double;
    function fValidaCodigoBarras(strCodBar, strCodIte: String; Var strItem: String): Boolean;
    Function fValidaCodBar(strCodBar: String; blnRollback: Boolean = False): Boolean;
    Function fVerificaCodBar(strItem: String; blnRollback: Boolean = False): Boolean;

    function fGeraCodigoBarrasUnidades(strCodIte, strCodGru: String; fltQtdIte: Double): String;
    function fLerCodigoBarrasUnidades(strCodBar: String; Var strCodIte, strCodGru: String; Var fltQtdIte: Double): Boolean;

    function fLerCodigoFabricaMaiorFornecedor(strCodBar: String; var strCodIte: String;
                        var fltQtdIte: Double): Boolean;

    function fCalculaUnidadesRestante(fltQtdIte: Double): Double; overload;
    function fCalculaUnidadesRestante(fltQtdIte: Double; Var strSugestao: String): Double; overload;
    procedure pImprimeEtiquetaUnidadesRestante(arrItens: TArrItensEtiqUnRestante;
                                               opcEtique: TOpcaoEtiqueta;
                                               strNumDoc: String = '';
                                               strEspDoc: String = '';
                                               strCodEmp: String = '';
                                               strCodCon: String = '';
                                               intQuaEti: Integer = 1;
                                               blnImprime: Boolean = True;
                                               blnCadEmb: Boolean = False;
                                               strCodCli: String = '');

    Procedure pRetCodBarPrincipal;

    Procedure pGeraCodigoBarras(strCodGru: String; strItem: String);
    Procedure pExcluiRegistro;
    Procedure pCarregaDados(strCodIteP: String);
    Procedure pSalvaDados(strCodigoItem: String; blnUpdIte: Boolean = False);
    Procedure pCancela;

    Procedure pIncluiCodigo(strCodBar: String; fltEmbala: Double;
                            blnPrinci, blnCompra, blnExbFat: Boolean;
                            fltPreVen: Double; strDescri: String;
                            strTabPre,
                            strCodFor: String;
                            fltAltura, fltLargur, fltProfun : Double;
                            intLastro, intCamada, intEmpMax : Integer;
                            fltPesoBR, fltPesoLQ : Double;
                            blnAtuCodBarCadIte: Boolean = False;
                            strStatusGTIN: String = '';
                            strEanTrib: String = '');

    Procedure pAjustaPrincipalCompra;
    Procedure pIncluiCodigoBarrasCatalogo(strIteCat, strCodBar, strBarEmb: String; fltEmbala: Double);
    Procedure pHabilitaEdicao(blnHabil: Boolean);
    Procedure pFocaCodBarras;
    Procedure pFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    Procedure IncluiPrincipalParaCompras(strCodIte, strCodBar: String; fltEmbala: Double;
                                         var  blnPrincipal: Boolean);
End;


implementation

end.
