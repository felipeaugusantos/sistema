unit untIFuncMacro;

interface

uses Classes, untICamposUso, Uni;

Type
  IFuncMacro = Interface
  ['{1988A524-DE91-4A85-8F40-78D9182FE831}']
    function  fIsNumber(strString: String): Boolean;
    function  fStrSpace(strString: String; intTamanho: Integer): String;
    function  fIsVarDeclared(strNomVar: String): Boolean;
    function  fRetPalavras(strString: String): TStringList;
    function  fRetNumeros(strString: STring): TStringList;

    procedure pEscreveLinha(Var strNomArq: String; strValLin: AnsiString; blnUltimoReg: Boolean;
      strNomImp: String = ''; strNomPro: String = ''; strDesPro: String = '');
    function  fProcessaMacro(Sender: TObject; cpuCampos: ICamposUso; strMacro: String): String;
    procedure pMontaLinha(Var strLinha: String; strValor: String; intColuna: Integer);
    procedure pInicializaVariaveis;

    procedure pI_Linhas(Sender: TObject; cpuCampos: ICamposUso;  Var intLinAtu: Integer;
      Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String; qryCnfGen: TUniQuery; intColuna: Integer = 0);

    procedure pI_LinhasEti(Sender: TObject; cpuCampos: ICamposUso; Var strLinha: String;
      Var intLinAtu: Integer; Var intLinha: Integer; strNomImp, strNomPro, strDesPro: String;
      intColuna: Integer; qryCnfEti: TUniQuery);

    procedure pGravaLogErro(strErro: String);
    function fExecutaSQL(strMacro: String; blnReformataNumeros: Boolean = True): String;
    function fReplaceValues(Sender: TObject; strMacro, strNomPro,
      strValPro: String): String;

    function fReformataNumeros(strString: String): String;
  End;

implementation

end.
