unit untLuksColorDinamicaNova;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants,
  ADODB, IdIcmpClient, StrUtils, TypInfo, untTintadeMaquina;

Type
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;
  TipoIdIcmpClient = Class(TIdIcmpClient);
  TLuksColorDinamicaNova = class(TTintadeMaquina)
  private
    strPat: String;
    intOpcao: Integer;

  protected
    {*******************************************}
    {* FUINCOES PARA IMPORTAR OS ARQUIVOS      *}
    {****************************************PH*}
    function fImportarCadBas: Boolean;
    function fImportarCadCol: Boolean;
    function fImportarTintas: Boolean;
    function fImportarCadEmb: boolean;

    {***********************************************}
    {* RETORNA A UNIDADE DO CADASTRO DE EMBALAGENS *}
    {********************************************PH*}
    function fRetUnidadeEmbalagem(strCodEmb: String): String;

    {******************************************************}
    {* VERIFICA SE TODAS AS EMBALAGENS ESTAO CONFIGURADAS *}
    {***************************************************PH*}
    function fVerificaCadEbm: Boolean;

  public
    function fImportarArquivos: Boolean;
    constructor Create(intOpcao: Integer); reintroduce; overload;
    constructor Create(AOwner: TComponent); overload; override; 

    {*******************************************}
    {* VERIFICA SE EXISTE IP/PATH/ARQUIVO      *}
    {****************************************PH*}
    function fVerificaIP(strPath: String): Boolean;

    {*******************************************}
    {* CRIA UMA ADOQUERY                       *}
    {****************************************PH*}
    function fCriaAdoQuery(AOwner: TComponent = Nil): TADOQuery;

    {*******************************************}
    {* GRAVA TODAS AS NOVAS FORMULAS           *}
    {****************************************PH*}
    function fGravarNovasFormulas(): Boolean; override;

end;

implementation

uses untFuncoesSimples, untLukscolorImobiliaria, untFuncTinta;

{ TLuksColorDinamicaNova }

constructor TLuksColorDinamicaNova.Create(intOpcao: Integer);
begin
  Self.intOpcao := intOpcao;
  strPat :=  fGetConfTinta('LKS').fGet('PATPRI');
end;

constructor TLuksColorDinamicaNova.Create(AOwner: TComponent);
begin
  NomeTinta := 'LuksColor Imobiliária';
  inherited;
end;

function TLuksColorDinamicaNova.fCriaAdoQuery(AOwner: TComponent = Nil): TADOQuery;
begin
  Result := TADOQuery.Create(Application.Owner);
  Result.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPat +
                              ';Persist Security Info=True';
end;

function TLuksColorDinamicaNova.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM LKD_CADNFM';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    fGravaNovaFormula(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TLuksColorDinamicaNova.fImportarArquivos: Boolean;
begin

  Result := True;
  If Not fVerificaIP(strPat) Then
  Begin
    fMensagem('ATENÇÃO', 'O arquivo não foi encontrado!', ['OK']);
    Result := False;
    Exit;
  End;

  case intOpcao of
    1: Result := fImportarCadEmb;
    2: Result := fImportarCadBas And fImportarCadCol;
    3: Result := fImportarTintas;
  end;

end;

function TLuksColorDinamicaNova.fImportarCadBas: Boolean;
  Var
    qryGen: TADOQuery;
    qryCadBas: TUniQuery;
begin
  If fVerificaCadEbm Then
  Begin
     fMensagem('', 'As embalagens não estão configuradas', ['OK']);
    Result := False;
    Exit;
  End;

  qryGen := fCriaAdoQuery(Self);

  qryGen.SQL.Add('SELECT DISTINCT');
  qryGen.SQL.Add('	TBLCOLECAO.COD_COLECAO, ');
  qryGen.SQL.Add('	TBLCOLECAO.NOME_COLECAO, ');
  qryGen.SQL.Add('	TBLPRODUTO.COD_PRODUTO, ');
  qryGen.SQL.Add('	UCASE(TBLPRODUTO.NOME_PRODUTO) AS NOME_PRODUTO, ');
  qryGen.SQL.Add('	TBLBASE.COD_BASE, ');
  qryGen.SQL.Add('	UCASE(TBLBASE.NOME_BASE) AS NOME_BASE, ');
  qryGen.SQL.Add('	TBLEMBALAGEM.COD_EMBALAGEM, ');
  qryGen.SQL.Add('	UCASE(TBLEMBALAGEM.NOME_EMBALAGEM) AS NOME_EMBALAGEM, ');
  qryGen.SQL.Add('	TBLEMBALAGEM.TAMANHO_EMBALAGEM');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	(');
  qryGen.SQL.Add('		(');
  qryGen.SQL.Add('			TBLPRODUTO ');
  qryGen.SQL.Add('			INNER JOIN (');
  qryGen.SQL.Add('				TBLCOLECAO ');
  qryGen.SQL.Add('				INNER JOIN TBLRELCOLECAOPRODUTO ON TBLCOLECAO.COD_COLECAO = TBLRELCOLECAOPRODUTO.COD_COLECAO');
  qryGen.SQL.Add('			) ON TBLPRODUTO.COD_PRODUTO = TBLRELCOLECAOPRODUTO.COD_PRODUTO');
  qryGen.SQL.Add('		) ');
  qryGen.SQL.Add('		INNER JOIN (');
  qryGen.SQL.Add('			TBLBASE ');
  qryGen.SQL.Add('			INNER JOIN TBLRELPRODUTOBASE ON TBLBASE.COD_BASE = TBLRELPRODUTOBASE.COD_BASE');
  qryGen.SQL.Add('		) ON TBLPRODUTO.COD_PRODUTO = TBLRELPRODUTOBASE.COD_PRODUTO');
  qryGen.SQL.Add('	) ');
  qryGen.SQL.Add('	INNER JOIN (');
  qryGen.SQL.Add('		TBLEMBALAGEM ');
  qryGen.SQL.Add('		INNER JOIN TBLRELPRODUTOEMBALAGEM ON TBLEMBALAGEM.COD_EMBALAGEM = TBLRELPRODUTOEMBALAGEM.COD_EMBALAGEM');
  qryGen.SQL.Add('	) ON TBLPRODUTO.COD_PRODUTO = TBLRELPRODUTOEMBALAGEM.COD_PRODUTO');
  qryGen.SQL.Add('ORDER BY TBLCOLECAO.COD_COLECAO, TBLPRODUTO.COD_PRODUTO, TBLBASE.COD_BASE;');

  qryGen.Open;

  qryCadBas := fCriaQuery(nil);
  qryCadBas.SQL.Text := 'SELECT * FROM LKD_CADBAS';
  qryCadBas.Open;

  pRegistraAcao('Cadastrando bases...');

  While Not qryGen.Eof Do
  Begin
    If Not qryCadBas.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
      VarArrayOf([fStrZero(qryGen.FieldByName('COD_BASE').AsString, 2), fStrZero(qryGen.FieldByName('COD_PRODUTO').AsString, 2),
        fStrZero(qryGen.FieldByName('COD_EMBALAGEM').AsString, 2), fRetUnidadeEmbalagem(qryGen.FieldByName('COD_EMBALAGEM').AsString)]), []) Then
    Begin
      qryCadBas.Insert;
      qryCadBas.FieldByName('BAS_BASE__').AsString := fStrZero(qryGen.FieldByName('COD_BASE').AsInteger, 2);
      qryCadBas.FieldByName('BAS_PROKEY').AsString := fStrZero(qryGen.FieldByName('COD_PRODUTO').AsString, 2);
      qryCadBas.FieldByName('BAS_SUBKEY').AsString := fStrZero(qryGen.FieldByName('COD_EMBALAGEM').AsString, 2);
      qryCadBas.FieldByName('BAS_UNIDAD').AsString := fRetUnidadeEmbalagem(qryGen.FieldByName('COD_EMBALAGEM').AsString);
      qryCadBas.FieldByName('BAS_DESCRI').AsString := qryGen.FieldByName('NOME_PRODUTO').AsString + ' ' + qryGen.FieldByName('NOME_BASE').AsString + ' ' + qryGen.FieldByName('NOME_EMBALAGEM').AsString;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;

    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
    qryGen.Next;
  End;

  pRegistraAcao('Cadastro realizado com sucesso!');

  Result := True;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryGen);
end;

function TLuksColorDinamicaNova.fImportarCadCol: Boolean;
  Var
    qryGen: TADOQuery;
    qryCadCol: TUniQuery;
begin
  If fVerificaCadEbm Then
  Begin
    fMensagem('', 'As embalagens não estão configuradas', ['OK']);
    Result := False;
    Exit;
  End;

  qryGen := fCriaAdoQuery(Self);
  qryGen.SQL.Text := 'SELECT DISTINCT COD_CORANTE, SNOME_CORANTE FROM TblCorante';
  qryGen.Open;

  qryCadCol := fCriaQuery(nil);
  qryCadCol.SQL.Text := 'SELECT * FROM LKD_CADCOL';
  qryCadCol.Open;

  pRegistraAcao('Cadastrando colorantes...');

  While Not qryGen.Eof Do
  Begin
    If Not qryCadCol.Locate('COL_CODCOL', qryGen.FieldByName('COD_CORANTE').AsString, []) Then
    Begin
      qryCadCol.Insert;
      qryCadCol.FieldByName('COL_CODCOL').AsString := qryGen.FieldByName('COD_CORANTE').AsString;
      qryCadCol.FieldByName('COL_DESCRI').AsString := qryGen.FieldByName('SNOME_CORANTE').AsString;      
      qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADCOL', VS_strCodEmp);
      qryCadCol.Post;
    End;

    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
    qryGen.Next;
  End;

  pRegistraAcao('Cadastro realizado com sucesso!');
  Result := True;
  FreeAndNil(qryCadCol);
  FreeAndNil(qryGen);
end;

function TLuksColorDinamicaNova.fImportarCadEmb: boolean;
  Var
    qryGen: TADOQuery;
    qryCadEmb: TUniQuery;
begin

  qryGen := fCriaAdoQuery(Self);

  qryGen.SQL.Text := 'SELECT DISTINCT * FROM TblEmbalagem';
  qryGen.Open;

  qryCadEmb := fCriaQuery(nil);
  qryCadEmb.SQL.Text := 'SELECT * FROM LKD_CADEMB';
  qryCadEmb.Open;

  pRegistraAcao('Cadastrando Embalagens...');

  While Not qryGen.Eof Do
  Begin
    If Not qryCadEmb.Locate('EMB_CODEMB', qryGen.FieldByName('cod_embalagem').AsString, []) Then
    Begin
      qryCadEmb.Insert;
      qryCadEmb.FieldByName('EMB_CODEMB').AsString := qryGen.FieldByName('cod_embalagem').AsString;
      qryCadEmb.FieldByName('EMB_QTDEMB').AsFloat := qryGen.FieldByName('tamanho_embalagem').AsFloat * 1000;
      qryCadEmb.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
      qryCadEmb.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADEMB', VS_strCodEmp);
      qryCadEmb.Post;
    End;

    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);

    qryGen.Next;
  End;

  pRegistraAcao('Cadastro realizado com sucesso!');

  Result := True;
  FreeAndNil(qryCadEmb);
  FreeAndNil(qryGen);
end;

function TLuksColorDinamicaNova.fImportarTintas: Boolean;
  Var
    qryGen : TADOQuery;
    qryCadLkd: TUniQuery;
    qryCadNfm: TUniQuery;

    intCodSeq: Integer;

    intCodForm: Integer;
    intCodBas: Integer;
    intCodEmb: Integer;

    intCodCol: Integer;
begin
  intCodSeq := 0;
  qryGen := fCriaAdoQuery(Self);

  {*************************************************************************}
  {* EXECUTANDO ESSA QUERE EU RETORNO TODAS AS BASES E TODAS AS EMBALAGENS *}
  {* DAS BASES                                                             *}
  {**********************************************************************PH*}

  qryGen.SQL.Add('SELECT DISTINCT ');
  qryGen.SQL.Add('	FORMULA.COD_COLECAO, ');
  qryGen.SQL.Add('	FORMULA.COD_FORMULA, ');
  qryGen.SQL.Add('	FORMULA.COD_COR, ');
  qryGen.SQL.Add('	UCASE(FORMULA.NOME_COR) AS NOME_COR, ');
  qryGen.SQL.Add('	PRODUTOS.COD_PRODUTO, ');
  qryGen.SQL.Add('	UCASE(PRODUTOS.NOME_PRODUTO) AS NOME_PRODUTO, ');
  qryGen.SQL.Add('	BASES.COD_BASE, ');
  qryGen.SQL.Add('	BASES.NOME_BASE, ');
  qryGen.SQL.Add('	EMBBASES.COD_EMBALAGEM, ');
  qryGen.SQL.Add('	EMBBASES.NOME_EMBALAGEM, ');
  qryGen.SQL.Add('	EMBBASES.TAMANHO_EMBALAGEM, ');
  qryGen.SQL.Add('	COLORANTES.COD_CORANTE, ');
  qryGen.SQL.Add('	COLORANTES.QTD_CORANTE, ');
  qryGen.SQL.Add('	EMBORI.TAMANHO_EMBALAGEM AS TAMORI');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	(');
  qryGen.SQL.Add('		TBLEMBALAGEM AS EMBORI ');
  qryGen.SQL.Add('		INNER JOIN ');
  qryGen.SQL.Add('			(');
  qryGen.SQL.Add('				(');
  qryGen.SQL.Add('					TBLPRODUTO AS PRODUTOS ');
  qryGen.SQL.Add('					INNER JOIN TBLFORMULA AS FORMULA ON PRODUTOS.COD_PRODUTO = FORMULA.COD_PRODUTO');
  qryGen.SQL.Add('				) INNER JOIN TBLRELFORMULACORANTE AS COLORANTES ON FORMULA.COD_FORMULA = COLORANTES.COD_FORMULA');
  qryGen.SQL.Add('			) ON EMBORI.COD_EMBALAGEM = FORMULA.COD_EMBALAGEM');
  qryGen.SQL.Add('	) ');
  qryGen.SQL.Add('	INNER JOIN ');
  qryGen.SQL.Add('		(');
  qryGen.SQL.Add('			TBLBASE AS BASES ');
  qryGen.SQL.Add('			INNER JOIN ');
  qryGen.SQL.Add('				(');
  qryGen.SQL.Add('					TBLEMBALAGEM AS EMBBASES ');
  qryGen.SQL.Add('					INNER JOIN ');
  qryGen.SQL.Add('						(');
  qryGen.SQL.Add('							TBLRELPRODUTOEMBALAGEM AS PRODEMB ');
  qryGen.SQL.Add('							INNER JOIN TBLRELPRODUTOBASE AS PRODBASES ON PRODEMB.COD_PRODUTO = PRODBASES.COD_PRODUTO');
  qryGen.SQL.Add('						) ON EMBBASES.COD_EMBALAGEM = PRODEMB.COD_EMBALAGEM');
  qryGen.SQL.Add('				) ON BASES.COD_BASE = PRODBASES.COD_BASE');
  qryGen.SQL.Add('		) ON (PRODUTOS.COD_PRODUTO = PRODEMB.COD_PRODUTO) AND (PRODUTOS.COD_PRODUTO = PRODBASES.COD_PRODUTO) AND (FORMULA.COD_BASE = PRODBASES.COD_BASE)');
  qryGen.SQL.Add('ORDER BY FORMULA.COD_FORMULA, BASES.COD_BASE;');
  qryGen.Open;

  qryCadLkd := fCriaQuery(Self);
  qryCadLkd.SQL.Text := 'TRUNCATE TABLE LKD_CADLKD';
  qryCadLkd.ExecSQL;

  qryCadLkd.SQL.Text := 'SELECT * FROM LKD_CADLKD';
  qryCadLkd.Open;

  pRegistraAcao('Cadasntrando tintas...');

  While Not qryGen.Eof Do
  Begin
    intCodForm := qryGen.FieldByName('COD_FORMULA').AsInteger;
    intCodBas := qryGen.FieldByName('COD_BASE').AsInteger;
    intCodEmb := qryGen.FieldByName('COD_EMBALAGEM').AsInteger;

    qryCadLkd.Insert;
    qryCadLkd.FieldByName('LKD_CODSEQ').AsString := fStrZero(intCodSeq, 6);
    qryCadLkd.FieldByName('LKD_DESCRI').AsString := qryGen.FieldByName('COD_COR').AsString + ' ' + qryGen.FieldByName('NOME_PRODUTO').AsString + ' ' + qryGen.FieldByName('NOME_COR').AsString;
    qryCadLkd.FieldByName('LKD_CODIGO').AsString := qryGen.FieldByName('COD_COR').AsString;
    qryCadLkd.FieldByName('LKD_CODIG2').AsString := qryGen.FieldByName('NOME_COR').AsString;
    qryCadLkd.FieldByName('LKD_UNIDAD').AsString := fRetUnidadeEmbalagem(qryGen.FieldByName('COD_EMBALAGEM').AsString);

    qryCadLkd.FieldByName('LKD_PROKEY').AsString := fStrZero(qryGen.FieldByName('COD_PRODUTO').AsString, 2);
    qryCadLkd.FieldByName('LKD_SUBKEY').AsString := fStrZero(qryGen.FieldByName('COD_EMBALAGEM').AsString, 2);
    qryCadLkd.FieldByName('LKD_BASE__').AsString := fStrZero(qryGen.FieldByName('COD_BASE').AsString, 2);

    qryCadLkd.FieldByName('LKD_CODEMP').AsString := VS_strCodEmp;
    qryCadLkd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADLKD', VS_strCodEmp);
    intCodCol := 1;

    While ((Not qryGen.Eof) And (intCodform = qryGen.FieldByName('COD_FORMULA').AsInteger)
      And (intCodBas = qryGen.FieldByName('COD_BASE').AsInteger) And (intCodEmb = qryGen.FieldByName('COD_EMBALAGEM').AsInteger)) Do
    Begin
      qryCadLkd.FieldByName('LKD_FORM' + fStrZero(intCodCol, 2)).AsString := qryGen.FieldByName('COD_CORANTE').AsString;

      {***************************************************}
      {* TODAS AS FORMULAS DO ARQUIVO SAO PARA UM QUARTO *}
      {************************************************PH*}
      qryCadLkd.FieldByName('LKD_QTDB' + fStrZero(intCodCol, 2)).AsFloat := fStrToFloat(AnsiReplaceStr(qryGen.FieldByName('QTD_CORANTE').AsString, '.', ',')) *
                      qryGen.FieldByName('TAMANHO_EMBALAGEM').AsFloat / qryGen.FieldByName('TAMORI').AsFloat;

      qryGen.Next;
      intCodCol := intCodCol + 1;
    End;

    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);

    intCodSeq := intCodSeq + 1;
    qryCadLkd.Post;
  End;

  qryCadNfm := fCriaQuery(Self);
  qryCadNfm.SQL.Text := 'SELECT * FROM LKD_CADNFM';
  qryCadNfm.Open;

  While Not qryCadNfm.Eof Do
  Begin
    fGravaNovaFormula(qryCadNfm);
    qryCadNfm.Next;
  End;

  pRegistraAcao('Cadastro realizado com sucesso!');
  Result := True;
  FreeAndNil(qryCadLkd);
  FreeAndNil(qryGen);
  FreeAndNil(qryCadNfm);
end;

function TLuksColorDinamicaNova.fRetUnidadeEmbalagem(
  strCodEmb: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT EMB_UNIDAD FROM LKD_CADEMB WHERE EMB_CODEMB = :CODEMB';
  qryGen.ParamByName('CODEMB').AsString := strCodEmb;
  qryGen.Open;
  Result := IfThen(qryGen.IsEmpty, '', qryGen.FieldByName('EMB_UNIDAD').AsString);
  FreeAndNil(qryGen);
end;

function TLuksColorDinamicaNova.fVerificaCadEbm: Boolean;
  Var
    qryCadEmb: TUniQuery;
begin
  qryCadEmb := fCriaQuery(Self);

  qryCadEmb.SQL.Add('SELECT ');
  qryCadEmb.SQL.Add('	* ');
  qryCadEmb.SQL.Add('FROM ');
  qryCadEmb.SQL.Add('	LKD_CADEMB ');
  qryCadEmb.SQL.Add('WHERE ');
  qryCadEmb.SQL.Add('	EMB_UNIDAD IS NULL');
  qryCadEmb.SQL.Add('	OR EMB_UNIDAD = ""');
  qryCadEmb.Open;

  Result := qryCadEmb.RecordCount > 0;
  FreeAndNil(qryCadEmb);
end;

function TLuksColorDinamicaNova.fVerificaIP(strPath: String): Boolean;
  Var
    IPTesta: TipoIdIcmpClient;
    strIP: String;
    intPos: Integer;
begin
  If Copy(strPath, 1, 2) = '\\' Then
  Begin

    intPos := PosEx('\', strPath, 3);
    strIP := Copy(strPath, 3, intPos - 3);

    IPTesta := TipoIdIcmpClient.Create(nil);
    IPTesta.Host := strIP;
    Try
      IPTesta.ReceiveTimeout := 5000;
      IPTesta.Ping();
    Except
    End;

    case IPTesta.ReplyStatus.ReplyStatusType of
      rsError: Result := False;
      rsErrorTTLExceeded: Result := False;
      rsErrorUnreachable: Result := False;
      rsTimeOut: Result := False;
    Else
      Result := True;
    End;

    If Result Then
    Begin
      Result := FileExists(strPath);

      If Not Result Then
        Result := DirectoryExists(strPath);
    End;

    FreeAndNil(IPTesta);

  End
  Else
  Begin
    Result := FileExists(strPath);

    If Not Result Then
      Result := DirectoryExists(strPath);
  End;
end;

end.
