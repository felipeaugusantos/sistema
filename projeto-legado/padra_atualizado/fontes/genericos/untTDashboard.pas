{*******************************************************************}
{* CÓDIGOS UTILIZADOS NO EDITOR DE RELATÓRIOS                      *}
{*******************************************************************}
{* Projeção de Faaturamento (Dashboard)	              18797  	398  *}
{* Projeção de Margem (Dashboard)	                    18798  	399  *}
{* Total de Vendas (Dashboard)	                      18799  	400  *}
{* Pedidos de Venda Não Faturados (Dashboard)	        18800  	401  *}
{* Resumo de Vendedor/Gerente (Dashboard)	            18801  	402  *}
{* Meta x Realizado Diário (Dashboard)	              18802	  403  *}
{* Total de Vendas por Forma de Pagamento (Dashboard)	18803	  404  *}
{* Top 5 Cliente (Dashboard)	                        18804  	405  *}
{* Construção da Meta (Dashboard)	                    18805  	406  *}
{* Faturamento x Metas Filiais (Dashboard)	          18806  	407  *}
{* Margem x Metas Filiais (Dashboard)	                18807  	408  *}
{*******************************************************************}

unit untTDashboard;

interface

uses
  System.SysUtils, Principal.View.Interfaces, Uni, untFuncoesRel, FMX.Dialogs,
  System.Classes, System.Generics.Collections;

type
  TAba = class(TInterfacedObject, IAba)
  private
    FTitulo: String;
    FNomeBotao: String;
    FAtalho: Integer;
    FChave: Integer;
    FTipo: String;
    FTipoVisao: String;
  protected
    constructor Create(strTitulo, strNomeBotao, strTipo, strTipoVisao: String;
                       intAtalho, intChave: Integer);
  public
    function Titulo: String;
    function NomeBotao: String;
    function Atalho: Integer;
    function Chave: Integer;
    function Tipo: String;
    function TipoVisao: String;
  end;

  TDashboard = class(TInterfacedObject, IDashboard)
  private
    //
    strTemporarias: String;
    FAbas: TList<IAba>;
    FListAbasNovas: TStringList;

    function RetornaComCus_Empresa: String;
    procedure CarregaAbasDinamicas;
    procedure pSalvarAbasNovas;
    Procedure pApagaTemporarias;
    procedure pInsereNovaAba(strTitulo, strBotao, strAtalho, strChave, strTipoVisao: String);

  public
    procedure RetornaDadosProjecaoFaturamento(Var arrValores: Array of Double;
                                              Var ValorMaior: Double;
                                              dtaMes: TDatetime;
                                              strTipEmp: String;
                                              strCodEmp: String;
                                              strTipVis: String);

    procedure RetornaDadosProjecaoMargem(Var Meta, MargemAtual: Double;
                                         dtaMes: TDatetime; strTipEmp: String;
                                         strCodEmp: String;
                                         strComCus: String;
                                         strTipVis: String);

    procedure RetornaDadosTotalVendas(Var arrMeses: Array of Double;
                                      Var ValorMaior: Double;
                                      dtaMes: TDatetime;
                                      strTipEmp: String;
                                      strCodEmp: String;
                                      strTipVis: String);

    procedure RetornaDadosPedidosNaoFaturados(Var arrMeses: Array of Double;
                                              Var ValorMaior: Double;
                                              dtaMes: TDatetime;
                                              strTipEmp: String;
                                              strCodEmp: String;
                                              strTipVis: String);

    function RetornaSQLConstrucaoMeta(dtaMes: TDatetime; strTipEmp: String;
                                      strCodEmp: String): String;

    function RetornaSQLFaturamentoXMetas(dtaMes: TDatetime; strTipEmp: String): String;

    function RetornaSQLMargemXMetas(dtaMes: TDatetime; strTipEmp: String; strComCus: String): String;

    function RetornaSQLTotalVendedores(dtaMes: TDatetime; strTipEmp: String;
                                       strCodEmp: String; strTipVis: String): String;

    function RetornaSQLVendasXMetasDiarias(dtaMes: TDatetime; strTipEmp: String;
                                           strCodEmp: String; strTipVis: String): String;

    function RetornaSQLTotalFormaPagamento(dtaMes: TDatetime; strTipEmp: String; strCodEmp: String): String;

    function RetornaSQLTopClientes(dtaMes: TDatetime; strTipEmp: String; strCodEmp: String): String;

    function RetornaJsonEditorDashBoard(intCodigoAtalho,
                                        intChaveDefault: integer;
                                        arrParametros: Array Of String;
                                        arrValores: Array Of String;
                                        blnMostrarProgresso: Boolean): string;

    Procedure ApagaTemporarias;
    procedure SalvarAbasNovas(lstAbas: TStringList);
    function TemRelatorioConfiguradoParaDashboard: Boolean;
    function EhFeriado(dteData: TDate): Boolean;
    function CfgSis(strCodCfg: String): Variant;
    function RetornaTipoEmpresa: String;
    function ListaEmpresas(ApenasAsQueUsuarioTemAcesso: Boolean = False): TArray<String>;
    function UsuarioTemAcessoAEmpresa(ACodEmp : String): Boolean;
    function NomeEmpresa(ACodigoEmpresa: String): String;
    function ListaCompCusto: TArray<String>;
    function MostrarFiltros: Boolean;
    function fRetornaTipoOperador: String;
    function Abas: TList<IAba>;
    function OperadorLogado: String;
    function NomeMotorista(ACodigoMotorista: String): String;
    function ListaMotoristas: TArray<String>;
    function UtilizaDashboardWeb: Boolean;
    Procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.StrUtils,
  untfuncoesSimples;

{ TDashboard }

function TDashboard.Abas: TList<IAba>;
begin
  Result := FAbas;
end;

procedure TDashboard.ApagaTemporarias;
begin
  fExecutarModal(pApagaTemporarias, 'Apagando tabelas temporarias, Aguarde ...', '');
end;

procedure TDashboard.CarregaAbasDinamicas;
var
  qryAba: TUniQuery;
begin
  qryAba := fCriaQuery(nil);
  Try
    qryAba.Close;
    qryAba.SQL.Text :=
    ' SELECT * FROM DASHAB '+
    ' ORDER BY AUTOINCREM ';
    qryAba.Open;

    FAbas.Clear;
    while not qryAba.Eof do
    begin
      FAbas.Add(TAba.Create(qryAba.FieldByName('DAS_TITULO').AsString,
                            qryAba.FieldByName('DAS_NOMBTN').AsString,
                            qryAba.FieldByName('DAS_TIPABA').AsString,
                            qryAba.FieldByName('DAS_TIPVIS').AsString,
                            qryAba.FieldByName('DAS_CODATA').AsInteger,
                            qryAba.FieldByName('DAS_CHAVE_').AsInteger));
      qryAba.Next;
    end;
  Finally
    FreeAndNil(qryAba);
  End;
end;

function TDashboard.CfgSis(strCodCfg: String): Variant;
begin
  Result := fCfgSis(strCodCfg);
end;

constructor TDashboard.Create;
begin
  FAbas := TList<IAba>.Create;
  CarregaAbasDinamicas;
end;

destructor TDashboard.Destroy;
begin
  FAbas.Clear;
  FreeAndNil(FAbas);
  inherited;
end;

function TDashboard.EhFeriado(dteData: TDate): Boolean;
var
  strCodCid: String;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD ');
  qryAux.SQL.Add('FROM CADFER ');
  qryAux.SQL.Add('WHERE FER_DTAFER = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteData)));
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  If Not Result Then
  Begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT EMP_CODCID ');
    qryAux.SQL.Add('FROM CADEMP ');
    qryAux.SQL.Add('WHERE EMP_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryAux.Open;
    If qryAux.FieldByName('EMP_CODCID').AsString <> EmptyStr Then
      strCodCid := qryAux.FieldByName('EMP_CODCID').AsString
    Else
      strCodCid := '';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD ');
    qryAux.SQL.Add('FROM FERCID ');
    qryAux.SQL.Add('WHERE FCI_DTAFER = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteData)));
    qryAux.SQL.Add('  AND FCI_CODCID = ' + QuotedStr(strCodCid));
    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryAux);
end;

function TDashboard.fRetornaTipoOperador: String;
begin
  Result := fRetTipoOperador(strLoginUsuarioLogado);
end;

function TDashboard.ListaCompCusto: TArray<String>;
Var
  qryGen : TUniQuery;
  strEmpCus : String;
begin
  Try
    strEmpCus := RetornaComCus_Empresa;

    SetLength(Result, 0);
    qryGen := fCriaQuery;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMCUS ');
    qryGen.SQL.Add('ORDER BY AUTOINCREM, COM_DESCRI, COM_COMPOS ');
    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin
      qryGen.First;
      while Not qryGen.EOF Do
      Begin
        If Not strEmpCus.IsEmpty Then
          pAddDados(Result, IIF(qryGen.FieldByName('AUTOINCREM').AsString = strEmpCus, '*', '') + qryGen.FieldByName('COM_DESCRI').AsString)
        Else
          pAddDados(Result, IIF(qryGen.FieldByName('COM_SUGERI').AsString = 'S', '*', '') + qryGen.FieldByName('COM_DESCRI').AsString);

        qryGen.Next;
      End;
    End;

  Except
    On E : Exception Do
      pMensagensErro(E.Message,'[pCarregaComposicaoCusto]');
  End;

  FreeAndNil(qryGen);
end;

function TDashboard.ListaEmpresas(
  ApenasAsQueUsuarioTemAcesso: Boolean): TArray<String>;
begin
  Result := untfuncoesSimples.fListaEmpresas(ApenasAsQueUsuarioTemAcesso);
end;

function TDashboard.ListaMotoristas: TArray<String>;
begin
  Result := String(fCampoTabela('GROUP_CONCAT(MOT_CODMOT ORDER BY MOT_NOMMOT)', 'CADMOT', ['LENGTH(MOT_CODMOT)'], ['5'])).Split([',']);
end;

function TDashboard.MostrarFiltros: Boolean;
begin
  Result := fCfgSis('SOFIDA', varString) = 'S';
end;

function TDashboard.NomeEmpresa(ACodigoEmpresa: String): String;
begin
  Result := fRetNomeEmpresaSelec(ACodigoEmpresa);
end;

function TDashboard.NomeMotorista(ACodigoMotorista: String): String;
begin
  Result := fRetNomeMotorista(ACodigoMotorista);
end;

function TDashboard.OperadorLogado: String;
begin
  Result := strLoginUsuarioLogado;
end;

function TDashboard.RetornaComCus_Empresa: String;
Var
  qryEmp : TUniQuery;
begin
  Result := '';

  Try
    qryEmp := fCriaQuery;

    qryEmp.SQL.Clear;
    qryEmp.SQL.Add('SHOW TABLES LIKE "COMCUS_EMP"');
    qryEmp.Open;

    If Not qryEmp.IsEmpty Then
    Begin
      qryEmp.Close;
      qryEmp.SQL.Clear;
      qryEmp.SQL.Add('SELECT COM_AUTCUS FROM COMCUS_EMP ');
      qryEmp.SQL.Add('WHERE COM_CODEMP = :CODEMP ');
      qryEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryEmp.Open;

      If Not qryEmp.IsEmpty Then
        Result := qryEmp.FieldByName('COM_AUTCUS').AsString;
    End;

  Finally
    FreeAndNil(qryEmp);
  End;
end;

procedure TDashboard.RetornaDadosPedidosNaoFaturados(Var arrMeses: Array of Double;
                                              Var ValorMaior: Double;
                                              dtaMes: TDatetime;
                                              strTipEmp: String;
                                              strCodEmp: String;
                                              strTipVis: String);
Var
  qryGrafico: TUniQuery;
  SQLGrafico: String;
Begin
  if Assigned(fncRetornaSelectEditorDashBoard) then
    SQLGrafico := fncRetornaSelectEditorDashBoard(401, 18800,
                                                  ['DTAFIN','CODOPE','RDGEMP', 'CODEMP', 'TIPVIS'],
                                                  [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strCodEmp, strTipVis],
                                                  strTemporarias);

  ValorMaior := 0;

  If (SQLGrafico <> EmptyStr) Then
  Begin
    Try
      qryGrafico := fCriaQuery(nil);

      qryGrafico.Close;
      qryGrafico.SQL.Clear;
      qryGrafico.SQL.Add(SQLGrafico);
      qryGrafico.Open;

      If Not qryGrafico.IsEmpty Then
      Begin
        qryGrafico.First;
        While Not qryGrafico.Eof Do
        Begin
          arrMeses[qryGrafico.RecNo-1] := qryGrafico.FieldByName('TOTITE_NFAT').AsFloat;

          If (qryGrafico.FieldByName('TOTITE_NFAT').AsFloat > ValorMaior) Then
            ValorMaior := qryGrafico.FieldByName('TOTITE_NFAT').AsFloat;

          qryGrafico.Next;
        End;
      End;

      FreeAndNil(qryGrafico);
    Except
      On E: Exception Do
        pMensagemOk(E.Message);
    End;
  End;
end;

procedure TDashboard.RetornaDadosProjecaoFaturamento(Var arrValores: Array of Double;
                                                     Var ValorMaior: Double;
                                                     dtaMes: TDatetime;
                                                     strTipEmp: String;
                                                     strCodEmp: String;
                                                     strTipVis: String);
Var
  qryGrafico: TUniQuery;
  SQLGrafico: String;
Begin
  if Assigned(fncRetornaSelectEditorDashBoard) then
    SQLGrafico := fncRetornaSelectEditorDashBoard(398, 18797,
                                                  ['DTAFIN','CODOPE','RDGEMP','CODEMP','TIPVIS'],
                                                  [DatetimeToStr(dtaMes), strLoginUsuarioLogado, strTipEmp, strCodEmp, strTipVis],
                                                  strTemporarias);

  ValorMaior := 0;

  If (SQLGrafico <> EmptyStr) Then
  Begin
    Try
      qryGrafico := fCriaQuery(nil);

      qryGrafico.Close;
      qryGrafico.SQL.Clear;
      qryGrafico.SQL.Add(SQLGrafico);
      qryGrafico.Open;

      If Not qryGrafico.IsEmpty Then
      Begin
        qryGrafico.First;
        While Not qryGrafico.Eof Do
        Begin
          arrValores[0] := qryGrafico.FieldByName('VLRFAT').AsFloat;
          arrValores[1] := qryGrafico.FieldByName('VLRMET').AsFloat;
          arrValores[2] := qryGrafico.FieldByName('PROFAT').AsFloat;

          ValorMaior  := arrValores[0];

          If (ValorMaior < arrValores[1]) Then
            ValorMaior := arrValores[1];

          If (ValorMaior < arrValores[2]) Then
            ValorMaior := arrValores[2];

          qryGrafico.Next;
        End;
      End;

      FreeAndNil(qryGrafico);

    Except
      On E: Exception Do
        pMensagemOk(E.Message);
    End;
  End;

end;

procedure TDashboard.RetornaDadosProjecaoMargem(Var Meta, MargemAtual: Double;
                                         dtaMes: TDatetime; strTipEmp: String;
                                         strCodEmp: String;
                                         strComCus: String;
                                         strTipVis: String);
Var
  qryGrafico: TUniQuery;
  SQLGrafico: String;
Begin

  if Assigned(fncRetornaSelectEditorDashBoard) then
    SQLGrafico := fncRetornaSelectEditorDashBoard(399, 18798,
                                                  ['DTAFIN','CODOPE', 'RDGEMP', 'CODEMP','VS_FLTPRECUS','TIPVIS'],
                                                  [DatetimeToStr(dtaMes), strLoginUsuarioLogado, strTipEmp, strCodEmp, strComCus, strTipVis],
                                                  strTemporarias);

  If (SQLGrafico <> EmptyStr) Then
  Begin
    Try
      qryGrafico := fCriaQuery(nil);

      qryGrafico.SQL.Clear;
      qryGrafico.SQL.Add(SQLGrafico);
      qryGrafico.Open;

      If Not qryGrafico.IsEmpty Then
      Begin
        Meta        := qryGrafico.FieldByName('METMAR').AsFloat;
        MargemAtual := qryGrafico.FieldByName('MARATU').AsFloat;
      End;

      FreeAndNil(qryGrafico);
    Except
      On E: Exception Do
        pMensagemOk(E.Message);
    End;
  End;
end;

procedure TDashboard.RetornaDadosTotalVendas(Var arrMeses: Array of Double;
                                      Var ValorMaior: Double;
                                      dtaMes: TDatetime;
                                      strTipEmp: String;
                                      strCodEmp: String;
                                      strTipVis: String);
Var
  qryGrafico: TUniQuery;
  SQLGrafico: String;
Begin
  if Assigned(fncRetornaSelectEditorDashBoard) then
    SQLGrafico := fncRetornaSelectEditorDashBoard(400, 18799,
                                                  ['DTAFIN','CODOPE','RDGEMP', 'CODEMP', 'TIPVIS'],
                                                  [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strCodEmp, strTipVis],
                                                  strTemporarias);

  ValorMaior := 0;

  If (SQLGrafico <> EmptyStr) Then
  Begin
    Try
      qryGrafico := fCriaQuery(nil);

      qryGrafico.Close;
      qryGrafico.SQL.Clear;
      qryGrafico.SQL.Add(SQLGrafico);
      qryGrafico.Open;

      If Not qryGrafico.IsEmpty Then
      Begin
        qryGrafico.First;
        While Not qryGrafico.Eof Do
        Begin
          arrMeses[qryGrafico.RecNo-1] := qryGrafico.FieldByName('VALOR').AsFloat;

          If (qryGrafico.FieldByName('VALOR').AsFloat > ValorMaior) Then
            ValorMaior := qryGrafico.FieldByName('VALOR').AsFloat;

          qryGrafico.Next;
        End;
      End;

      FreeAndNil(qryGrafico);
    Except
      On E: Exception Do
        pMensagemOk(E.Message);
    End;
  End;
end;

function TDashboard.RetornaJsonEditorDashBoard(intCodigoAtalho,
  intChaveDefault: integer; arrParametros, arrValores: array of String;
  blnMostrarProgresso: Boolean): string;
begin
  Result := '';

  if Assigned(fncRetornaJsonEditorDashBoard) then
    Result := fncRetornaJsonEditorDashBoard(intCodigoAtalho,
                                            intChaveDefault,
                                            arrParametros,
                                            arrValores,
                                            blnMostrarProgresso);
end;

function TDashboard.RetornaSQLConstrucaoMeta(dtaMes: TDatetime; strTipEmp: String;
                                      strCodEmp: String): String;
Begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(406, 18805,
                                             ['DTAFIN','CODOPE','RDGEMP','CODEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strCodEmp],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLFaturamentoXMetas(dtaMes: TDatetime; strTipEmp: String): String;
Begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(407, 18806,
                                             ['DTAFIN','CODOPE','RDGEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLMargemXMetas(dtaMes: TDatetime; strTipEmp: String; strComCus: String): String;
Begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(408, 18807,
                                             ['DTAFIN','CODOPE','RDGEMP','VS_FLTPRECUS'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strComCus],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLTopClientes(dtaMes: TDatetime; strTipEmp,
  strCodEmp: String): String;
begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(405, 18804,
                                             ['DTAFIN','CODOPE','RDGEMP','CODEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strCodEmp],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLTotalFormaPagamento(dtaMes: TDatetime; strTipEmp,
  strCodEmp: String): String;
begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(404, 18803,
                                             ['DTAFIN','CODOPE','RDGEMP','CODEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strCodEmp],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLTotalVendedores(dtaMes: TDatetime; strTipEmp,
  strCodEmp, strTipVis: String): String;
begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(402, 18801,
                                             ['DTAFIN','CODOPE','RDGEMP','TIPVIS','CODEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strTipVis, strCodEmp],
                                             strTemporarias);
end;

function TDashboard.RetornaSQLVendasXMetasDiarias(dtaMes: TDatetime; strTipEmp,
  strCodEmp, strTipVis: String): String;
begin
  Result := '';

  if Assigned(fncRetornaSelectEditorDashBoard) then
    Result := fncRetornaSelectEditorDashBoard(403, 18802,
                                             ['DTAFIN','CODOPE','RDGEMP','TIPVIS','CODEMP'],
                                             [DatetimeToStr(dtaMes),strLoginUsuarioLogado, strTipEmp, strTipVis, strCodEmp],
                                             strTemporarias);
end;

Procedure TDashboard.pApagaTemporarias;
  Var
    stlTemporarias: TStringList;
    intContador: Integer;
Begin
  stlTemporarias := TStringList.Create;
  stlTemporarias.Text := strTemporarias;

  For intContador := 0 To stlTemporarias.Count - 1 Do
    fExecutaSQL(Concat('DROP TABLE IF EXISTS ',
                RightStr(stlTemporarias[intContador], Length(stlTemporarias[intContador])- Pos(';', stlTemporarias[intContador]))));

  FreeAndNil(stlTemporarias);

  strTemporarias := '';
End;

procedure TDashboard.pInsereNovaAba(strTitulo, strBotao, strAtalho, strChave,
  strTipoVisao: String);
Var
  qryInsert : TUniQuery;
  strAutInc : String;
begin
  qryInsert := fCriaQuery;

  try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Text :=
    ' INSERT INTO DASHAB '+
    '  (AUTOINCREM, '+
    '   DAS_TITULO, '+
    '   DAS_NOMBTN, '+
    '   DAS_CODATA, '+
    '   DAS_TIPVIS, '+
    '   DAS_CHAVE_) '+
    ' VALUES '+
    '  (:AUTINC, '+
    '   :TITULO, '+
    '   :NOMBTN, '+
    '   :CODATA, '+
    '   :TIPVIS, '+
    '   :CHAVE_) ';

    strAutInc := fRetAutoIncrem('DASHAB', VS_strCodEmp);

    qryInsert.ParamByName('AUTINC').AsString := strAutInc;
    qryInsert.ParamByName('TITULO').AsString := strTitulo;
    qryInsert.ParamByName('NOMBTN').AsString := strBotao;
    qryInsert.ParamByName('CODATA').AsString := strAtalho;
    qryInsert.ParamByName('TIPVIS').AsString := strTipoVisao;
    qryInsert.ParamByName('CHAVE_').AsString := strChave;
    qryInsert.ExecSql;

  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TDashboard.pMensagemOk(strMensagem: String; intWidth,
  intHeight: Integer);
begin
  untFuncoesSimples.pMensagemOk(strMensagem, intWidth, intHeight);
end;

procedure TDashboard.pSalvarAbasNovas;
Var
  lstColunas : TStringList;
  i : Integer;
  qryDel : TUniQuery;
begin
  lstColunas                 := TStringList.Create;
  lstColunas.Delimiter       := '|';
  lstColunas.StrictDelimiter := True;

  try
    qryDel := fCriaQuery;

    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM DASHAB');
    qryDel.SQL.Add('WHERE DAS_TIPABA = "D" ');
    qryDel.ExecSql;
  Finally
    FreeAndNil(qryDel);
  End;

  For i := 0 to FListAbasNovas.Count-1 Do
  Begin
    lstColunas.DelimitedText := FListAbasNovas[i];

    pInsereNovaAba(lstColunas[0],
                   lstColunas[1],
                   lstColunas[2],
                   lstColunas[3],
                   lstColunas[4]);
  End;

  lstColunas.Free;
  FListAbasNovas := Nil;
end;

function TDashboard.RetornaTipoEmpresa: String;
Var
  qryGrafico: TUniQuery;
begin
  Result := 'Origem';

  Try
    qryGrafico := fCriaQuery(nil);

    qryGrafico.Close;
    qryGrafico.SQL.Clear;
    qryGrafico.SQL.Add('SELECT VAL_ULTVAL FROM CADVAL    ');
    qryGrafico.SQL.Add('WHERE VAL_CODOPE = :CODOPE       ');
    qryGrafico.SQL.Add('AND   VAL_NOMPAR = "RDGEMP"      ');
    qryGrafico.SQL.Add('ORDER BY VAL_SEQGER DESC LIMIT 1 ');
    qryGrafico.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryGrafico.Open;

    If Not qryGrafico.IsEmpty Then
      Result := qryGrafico.FieldByName('VAL_ULTVAL').AsString;

    FreeAndNil(qryGrafico);

  Except
    On E: Exception Do
      pMensagemOk(E.Message);
  End;
end;

procedure TDashboard.SalvarAbasNovas(lstAbas: TStringList);
begin
  FListAbasNovas := lstAbas;
  fExecutarModal(pSalvarAbasNovas, 'Salvando abas da tela Dashboard, Aguarde ...', '');
end;

function TDashboard.TemRelatorioConfiguradoParaDashboard: Boolean;
Var
  qryGrafico: TUniQuery;
begin
  Result := False;

  Try
    qryGrafico := fCriaQuery(nil);

    qryGrafico.Close;
    qryGrafico.SQL.Clear;

    If (fCfgSis('DASWEB',varString) = 'S') Then
      qryGrafico.SQL.Add('SELECT * FROM DASHAB ')
    Else
    Begin
      qryGrafico.SQL.Add('SELECT * FROM ATAREL ');
      qryGrafico.SQL.Add('WHERE ATA_CHAVE_ IN (18797, 18798, 18799, 18800, 18801, 18802, 18803, 18804, 18805, 18806, 18807) ');
      qryGrafico.SQL.Add('  AND ATA_CODATA IN (398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408) ');
    End;

    qryGrafico.Open;

    Result := Not qryGrafico.IsEmpty;

    FreeAndNil(qryGrafico);

  Except
    On E: Exception Do
      pMensagemOk(E.Message);
  End;
end;

function TDashboard.UsuarioTemAcessoAEmpresa(ACodEmp: String): Boolean;
begin
  Result := strEmpAcessoUsuarioLogado.Contains(ACodEmp);
end;

function TDashboard.UtilizaDashboardWeb: Boolean;
begin
  Result := fCfgSis('DASWEB', varString) = 'S';
end;

{ TAba }

function TAba.Atalho: Integer;
begin
  Result := FAtalho;
end;

function TAba.Chave: Integer;
begin
  Result := FChave;
end;

constructor TAba.Create(strTitulo, strNomeBotao, strTipo, strTipoVisao: String;
  intAtalho, intChave: Integer);
begin
  FTitulo    := strTitulo;
  FNomeBotao := strNomeBotao;
  FAtalho    := intAtalho;
  FChave     := intChave;
  FTipo      := strTipo;
  FTipoVisao := strTipoVisao;
end;

function TAba.NomeBotao: String;
begin
  Result := FNomeBotao;
end;

function TAba.Tipo: String;
begin
  Result := FTipo;
end;

function TAba.TipoVisao: String;
begin
  Result := FTipoVisao;
end;

function TAba.Titulo: String;
begin
  Result := FTitulo;
end;


end.
