unit untTFuncMacro;

interface

uses Classes, untICamposUso, Uni, untInterfacedObjectNoCount, untIFuncMacro,
  untFuncMacro;

Type
  TFuncMacro = Class(TInterfacedObjectNoCount, IFuncMacro)
  Public
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

{ TFuncMacro }

uses untFuncoesSimples;

function TFuncMacro.fExecutaSQL(strMacro: String; blnReformataNumeros: Boolean): String;
begin
  Result := untFuncMacro.fExecutaSQL(strMacro, blnReformataNumeros);
end;

function TFuncMacro.fIsNumber(strString: String): Boolean;
begin
  Result := untFuncMacro.fIsNumber(strString);
end;

function TFuncMacro.fIsVarDeclared(strNomVar: String): Boolean;
begin
  Result := untFuncMacro.fIsVarDeclared(strNomVar);
end;

function TFuncMacro.fProcessaMacro(Sender: TObject; cpuCampos: ICamposUso; strMacro: String): String;
begin
  Result := untFuncMacro.fProcessaMacro(Sender, TCamposUso(cpuCampos), strMacro);
end;

function TFuncMacro.fReformataNumeros(strString: String): String;
begin
  Result := untFuncMacro.fReformataNumeros(strString);
end;

function TFuncMacro.fReplaceValues(Sender: TObject; strMacro, strNomPro, strValPro: String): String;
begin
  Result := untFuncMacro.fReplaceValues(Sender, strMacro, strNomPro, strValPro);
end;

function TFuncMacro.fRetNumeros(strString: STring): TStringList;
begin
  Result := untFuncMacro.fRetNumeros(strString);
end;

function TFuncMacro.fRetPalavras(strString: String): TStringList;
begin
  Result := untFuncMacro.fRetPalavras(strString);
end;

function TFuncMacro.fStrSpace(strString: String; intTamanho: Integer): String;
begin
  Result := untFuncMacro.fStrSpace(strString, intTamanho);
end;

procedure TFuncMacro.pEscreveLinha(var strNomArq: String; strValLin: AnsiString;
  blnUltimoReg: Boolean; strNomImp, strNomPro, strDesPro: String);
begin
  untFuncMacro.pEscreveLinha(strArqTxt, strValLin, blnUltimoReg, strNomImp, strNomPro, strDesPro);
  strNomArq := strArqTxt;
end;

procedure TFuncMacro.pGravaLogErro(strErro: String);
begin
  untFuncMacro.pGravaLogErro(strErro);
end;

procedure TFuncMacro.pInicializaVariaveis;
begin
  untFuncMacro.pInicializaVariaveis;
end;

procedure TFuncMacro.pI_Linhas(Sender: TObject; cpuCampos: ICamposUso;
  var intLinAtu, intLinha: Integer; strNomImp, strNomPro, strDesPro: String; qryCnfGen: TUniQuery;
  intColuna: Integer);
begin
  untFuncMacro.pI_Linhas(Sender, TCamposUso(cpuCampos), intLinAtu, intLinha, strNomImp, strNomPro, strDesPro, qryCnfGen,
    intColuna);
end;

procedure TFuncMacro.pI_LinhasEti(Sender: TObject; cpuCampos: ICamposUso;
  var strLinha: String; var intLinAtu, intLinha: Integer; strNomImp, strNomPro, strDesPro: String;
  intColuna: Integer; qryCnfEti: TUniQuery);
begin
  untFuncMacro.pI_LinhasEti(Sender, TCamposUso(cpuCampos), strLinha, intLinAtu, intLinha,
    strNomImp, strNomPro, strDesPro, intColuna, qryCnfEti);
end;

procedure TFuncMacro.pMontaLinha(var strLinha: String; strValor: String; intColuna: Integer);
begin
  untFuncMacro.pMontaLinha(strLinha, strValor, intColuna);
end;

end.
