unit Fulfillment.Classes.NotaRemessaVsPedidoVenda;

interface

Uses
  Uni, UniClientDataSet, Data.DB, System.SysUtils, System.Classes, System.StrUtils,
  XMLDoc, XMLIntf, untEntNfeXml, untZClient, System.Variants,

  FulFillment.Classes.NotaFiscal,
  FulFillment.Classes.Empresa,
  FulFillment.Funcoes,
  FulFillment.Types;

type
  TNotaRemessaVsPedidoVenda = class
  private

    FPREFIXO_HUBMKP : String;

    FItensGD : TUniClientDataSet; {** Guardar consolidado **}
    FItensTA : TUniClientDataSet; {**  Guardar analítico  **}
    FItensNF : TUniClientDataSet;
    FItensPD : TUniClientDataSet;
    FItensLT : TUniClientDataSet;
    FItensValidacao : TUniClientDataSet;

    FArqXML : String;
    FChaAce : String;

    FNumFat : String;
    FEspFat : String;
    FEmpFat : String;

    FNumPedNovo   : String;
    FNumPedAntigo : String;

    FCodEmp : String;

    FExcedePD : Boolean;
    FExcedeNF : Boolean;

    FBloque : Boolean;

    FMSGErr : TStringList;

    FEmValidacao: Boolean;

    FDecQtd: Integer;

  private

    function CarregarItensNF() : Boolean;
    function CarregarItensPD() : Boolean;
    function CriarDataSet : TUniClientDataSet;
    function CriarDataSetValidacao : TUniClientDataSet;
    function RetornaXML(AChaAce : String): String;
    function NaoHouveBloqueioExisteQuantidadeExcedentesPD : Boolean;

    function BuscaLotesSeparados(var AQryLotes : TUniQuery; ASeqFdo : String) : Boolean;
    procedure GuardaLotesSeparados(var AQryLotes : TUniQuery; var AQtdGuardar : Double; ACodIte : String);

    procedure RegistraDivergencia(ADivergencia : String);
    function ProcessarFull_CodIte : Boolean;

    procedure GuardarItem(ACodIte, ASeqFdo : String; AQtdIte : Double);
    procedure GuardarItemTA(ACodIte, ANumLot : String; AQtdIte : Double);

    function EhItemEstruturaBaixandoSubItens(ACodIte : String) : Boolean;
    function ValidaSeLocalizouItemNaVenda(ACodIte : String) : Boolean;
    procedure ValidaQuantidade;

    procedure ValidaItensNF;
    procedure ValidaItensPD;
    procedure ValidaEstrutura;

    function ExisteREMFIL(AChaAce, AHubMkp, ACodIte : String) : Boolean;

    procedure GerarTL;

    procedure ProcessarComparacao;
    procedure AgruparPorCodigoAutcomEProcessarNaoEncontrados;

    procedure AddItensValidacao(ADados : TUniClientDataSet; AInconsistencia : TStatusNotaRemessaVsPedidoVenda);

    procedure ProcessarLOTDOR();
    procedure ProcessarGeracaoTAGuardarItens();

    procedure ProcessarVinculoComOPedido();
    procedure GravarLogExcedentes();

  public

    constructor New(AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp : String);
    destructor Destroy(); Override;

    procedure Executar;
    procedure PreValidacao;
    procedure CarregarItensNFComCodFull;

    property ExisteBloqueio : Boolean     read FBloque;
    property MSG_Bloqueio   : TStringList read FMSGErr;
    property ItensValidacao : TUniClientDataSet read FItensValidacao write FItensValidacao;
    property ItensNF        : TUniClientDataSet read FItensNF        write FItensNF;

    class function ItemDaNFExcedenteEmRelacaoAoPD(AChaAce, AHubMkp, ACodIte : String; Out AQtdPed : Double) : Boolean;
    class procedure CriaDataSetItensTL(var ACds: TUniClientDataSet);

  end;

implementation

{ TNotaRemessaVsPedidoVenda }

uses untConstantes, untFuncoes, untFuncoesSimples, untCadLote,
  untTransferenciaArmazens, untTSituacaoPedidoVenda,
  Faturamento.Classes.TAlterarPedido, untFuncFat,
  Fulfillment.RegrasMovimentacaoEstoque;

procedure TNotaRemessaVsPedidoVenda.AddItensValidacao(ADados: TUniClientDataSet; AInconsistencia: TStatusNotaRemessaVsPedidoVenda);
  var
    LSigla : String;
    LLocalizouItemNFnoPD : Boolean;
begin

  LSigla := IIF(ADados = FItensPD, 'PD', 'NF');

  If LSigla.Equals('PD') Then
  Begin
    If FItensValidacao.Locate('CODITE_PD;ESTRUTURA', VarArrayOf([ADados.FieldByName('CODAUT').AsString, ADados.FieldByName('ITEEST').AsString]), []) Then
      FItensValidacao.Edit
    Else
      FItensValidacao.Append;

    FItensValidacao.FieldByName('CODITE_PD').AsString := ADados.FieldByName('CODAUT').AsString;
    FItensValidacao.FieldByName('ESTRUTURA').AsString := ADados.FieldByName('ITEEST').AsString;
  End;

  If LSigla.Equals('NF') Then
  Begin
    If FItensValidacao.Locate('CODITE_NF', ADados.FieldByName('CODAUT').AsString, []) Then
      FItensValidacao.Edit
    Else
      FItensValidacao.Append;

    FItensValidacao.FieldByName('CODITE_NF').AsString := IIF(fEmptyStr(ADados.FieldByName('CODAUT').AsString), ADados.FieldByName('CODNFE').AsString, ADados.FieldByName('CODAUT').AsString);

    LLocalizouItemNFnoPD := FItensPD.Locate('CODAUT;ITEEST', VarArrayOf([ADados.FieldByName('CODAUT').AsString, EmptyStr]), []);

    If LLocalizouItemNFnoPD Then
    Begin
      FItensValidacao.FieldByName('CODITE_PD').AsString := FItensPD.FieldByName('CODAUT').AsString;
      FItensValidacao.FieldByName('DESITE_PD').AsString := AnsiUpperCase(FItensPD.FieldByName('DESITE').AsString);
      FItensValidacao.FieldByName('QTDITE_PD').AsFloat  := FItensPD.FieldByName('QTDITE').AsFloat;
    End;
  End;

  FItensValidacao.FieldByName('DESITE_' + LSigla).AsString := ADados.FieldByName('DESITE').AsString;
  FItensValidacao.FieldByName('QTDITE_' + LSigla).AsFloat  := ADados.FieldByName('QTDITE').AsFloat;
  FItensValidacao.FieldByName('INCONSISTENCIA').AsInteger  := AInconsistencia.RetIdx;
  FItensValidacao.Post;

end;

function TNotaRemessaVsPedidoVenda.BuscaLotesSeparados(var AQryLotes: TUniQuery; ASeqFdo : String) : Boolean;
  var
    LField : String;
begin

  Result := False;

  If Not Assigned(AQryLotes) Then
    Exit;

  If ASeqFdo.IsEmpty Then
    Exit;

  AQryLotes.Close;
  AQryLotes.SQL.Clear;

  LField := IIF(fUsaRotinaWMS, 'QTDSEP', 'QTDITE');

  AQryLotes.SQL.Add('SELECT IFNULL(LDO_'+LField+', 0) AS QTDSEP, LOTDOR.* FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO ORDER BY LDO_NUMLOT');

  AQryLotes.ParamByName('SEQFDO').AsString := ASeqFdo;
  AQryLotes.Open;

  Result := Not AQryLotes.IsEmpty;

end;

function TNotaRemessaVsPedidoVenda.CarregarItensNF: Boolean;
  var
    LNFE: TNFeXml;
    LCDS: TZClient;
    LATU: TNotaFiscal;
    LEMP: TEmpresa;
    LITE: TItemNota;
begin

  if FArqXML.IsEmpty then
    Exit(False);

  LCDS := TZClient.Create(nil);
  LNFE := TNFeXml.Create(nil, True);
  LEMP := TEmpresa.Create(fCadEmp('C_G_C_'));

  Try

    If LNFE.fCarregarDoArquivo(FArqXML, LCDS, True) Then
    Begin

      LATU := LEMP.fAdicionaNota(LNFE, fCadEmp('C_G_C_'));
      LATU.pAdicionaItem(LNFE);

      For LITE In LATU.arrItemNota Do
      Begin

        If FItensNF.Locate('CODNFE', LITE.strCodXml, []) Then
        Begin
          FItensNF.Edit;
          FItensNF.FieldByName('QTDITE').AsFloat := (FItensNF.FieldByName('QTDITE').AsFloat + LITE.fltQtdIte);
          FItensNF.Post;
        End
        Else
        Begin
          FItensNF.Append;
          FItensNF.FieldByName('CODAUT').AsString := '';
          FItensNF.FieldByName('CODNFE').AsString := LITE.strCodXml;
          FItensNF.FieldByName('CODBAR').AsString := LITE.strEANTri;
          FItensNF.FieldByName('QTDITE').AsFloat  := LITE.fltQtdIte;
          FItensNF.FieldByName('DESITE').AsString := LITE.strDescri;
          FItensNF.Post;
        End;

      End;

    End;

  Finally

    If Assigned(LCDS) Then
      FreeAndNil(LCDS);

    If Assigned(LNFE) Then
      FreeAndNil(LNFE);

    If Assigned(LEMP) Then
      FreeAndNil(LEMP);

  End;

  Result := not FItensNF.IsEmpty;

end;

function TNotaRemessaVsPedidoVenda.CarregarItensPD: Boolean;
  var
    LQry : TUniQuery;

  function CampoQuantidade : String;
  begin

    If (fUsaRotinaWMS) And (ModeloDeMovimentacaoDeSaldo = fmmQuantidadeSeparada) Then
      Exit('FDO_QTDSEP');

    Result := 'FDO_QTDITE';

  end;

begin

  LQry := fCriaQuery;
  FItensPD.EmptyDataSet;

  try

    LQry.SQL.Add('SELECT');
    LQry.SQL.Add('  AUTOINCREM,');
    LQry.SQL.Add('  FDO_CODITE,');
    LQry.SQL.Add('  FDO_DESCRI,');
    LQry.SQL.Add('  IFNULL(FDO_QTDITE, 0) AS FDO_QTDITE,');
    LQry.SQL.Add('  IFNULL(FDO_QTDSEP, 0) AS FDO_QTDSEP,');
    LQry.SQL.Add('  IFNULL(FDO_SEQEST, 0) AS FDO_SEQEST,');
    LQry.SQL.Add('  FDO_ITEEST');
    LQry.SQL.Add('FROM');
    LQry.SQL.Add('  FATDOR');
    LQry.SQL.Add('  INNER JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM)');
    LQry.SQL.Add('WHERE');
    LQry.SQL.Add('  FDO_NUMDOC = :NUMDOC AND');
    LQry.SQL.Add('  FDO_ESPDOC = :ESPDOC AND');
    LQry.SQL.Add('  FDO_CODEMP = :CODEMP');

    LQry.ParamByName('NUMDOC').AsString := FNumPedNovo;
    LQry.ParamByName('ESPDOC').AsString := 'PD';
    LQry.ParamByName('CODEMP').AsString := FCodEmp;
    LQry.Open;

    LQry.First;
    while not LQry.Eof do
    begin

      If FItensPD.Locate('CODAUT;ITEEST', VarArrayOf([LQry.FieldByName('FDO_CODITE').AsString, LQry.FieldByName('FDO_ITEEST').AsString]), []) Then
      Begin
        FItensPD.Edit;
        FItensPD.FieldByName('QTDITE').AsFloat := (FItensPD.FieldByName('QTDITE').AsFloat + LQry.FieldByName(CampoQuantidade).AsFloat);
      End Else
      Begin
        FItensPD.Append;
        FItensPD.FieldByName('SEQFDO').AsString := LQry.FieldByName('AUTOINCREM').AsString;
        FItensPD.FieldByName('CODAUT').AsString := LQry.FieldByName('FDO_CODITE').AsString;
        FItensPD.FieldByName('QTDITE').AsFloat  := LQry.FieldByName(CampoQuantidade).AsFloat;
        FItensPD.FieldByName('DESITE').AsString := LQry.FieldByName('FDO_DESCRI').AsString;
        FItensPD.FieldByName('NUMLOT').AsString := '';
        FItensPD.FieldByName('SEQEST').AsInteger := LQry.FieldByName('FDO_SEQEST').AsInteger;
        FItensPD.FieldByName('ITEEST').AsString  := LQry.FieldByName('FDO_ITEEST').AsString;
      End;

      FItensPD.Post;
      LQry.Next;

    end;

  finally
    FreeAndNil(LQry);
  end;

  Result := not FItensPD.IsEmpty;

end;

class procedure TNotaRemessaVsPedidoVenda.CriaDataSetItensTL(var ACds: TUniClientDataSet);
begin
  ACds := TUniClientDataSet.Create(nil);

  ACds.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  ACds.FieldDefs.Add('ARMDES', ftString, 30);
  ACds.FieldDefs.Add('ARMORI', ftString, 30);
  ACds.FieldDefs.Add('QTDITE', ftFloat);
  ACds.CreateDataSet;
  ACds.Open;
end;

function TNotaRemessaVsPedidoVenda.CriarDataSet : TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('CODAUT', ftString, fTamCodIte);
  Result.FieldDefs.Add('CODNFE', ftString, 100);
  Result.FieldDefs.Add('CODBAR', ftString, 100);
  Result.FieldDefs.Add('NUMLOT', ftString,  VS_Size_NumLot);
  Result.FieldDefs.Add('SEQFDO', ftString,  20);
  Result.FieldDefs.Add('QTDITE', ftFloat);
  Result.FieldDefs.Add('DESITE', ftString, 100);

  Result.FieldDefs.Add('ITEEST', ftString, fTamCodIte);
  Result.FieldDefs.Add('SEQEST', ftInteger);

  Result.CreateDataSet;
  Result.Open;

end;

function TNotaRemessaVsPedidoVenda.CriarDataSetValidacao : TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('CODITE_PD', ftString, fTamCodIte);
  Result.FieldDefs.Add('DESITE_PD', ftString, 100);
  Result.FieldDefs.Add('QTDITE_PD', ftFloat);
  Result.FieldDefs.Add('CODITE_NF', ftString, fTamCodIte);
  Result.FieldDefs.Add('DESITE_NF', ftString, 100);
  Result.FieldDefs.Add('QTDITE_NF', ftFloat);

  Result.FieldDefs.Add('ESTRUTURA', ftString, fTamCodIte);

  Result.FieldDefs.Add('INCONSISTENCIA', ftInteger);
  Result.CreateDataSet;
  Result.Open;

  Result.IndexFieldNames := 'CODITE_NF;ESTRUTURA';

end;

destructor TNotaRemessaVsPedidoVenda.Destroy;
begin

  If Assigned(FItensNF) Then
    FreeAndNil(FItensNF);

  If Assigned(FItensPD) Then
    FreeAndNil(FItensPD);

  If Assigned(FMSGErr) Then
    FreeAndNil(FMSGErr);

  If Assigned(FItensGD) Then
    FreeAndNil(FItensGD);

  If Assigned(FItensTA) Then
    FreeAndNil(FItensTA);

  If Assigned(FItensLT) Then
    FreeAndNil(FItensLT);

  If Assigned(FItensValidacao) Then
    FreeAndNil(FItensValidacao);

end;

function TNotaRemessaVsPedidoVenda.EhItemEstruturaBaixandoSubItens(ACodIte: String): Boolean;
begin
  Result := ((Not fEmptyStr(fRetItemEstrutura(ACodIte))) And MatchStr(fCfgSis('BXSBIT'), ['2','3']));
end;

procedure TNotaRemessaVsPedidoVenda.Executar;
begin

  fStartTransaction;

  Try

    If fUsaRotinaWMS() Then
      ProcessarComparacao();

    If (NaoHouveBloqueioExisteQuantidadeExcedentesPD) Then
    Begin

      if (fUsaRotinaWMS) And (ModeloDeMovimentacaoDeSaldo = fmmGerarPedidoParaGuardarAsDiferencas) then
      begin
        ProcessarLOTDOR();
        ProcessarGeracaoTAGuardarItens();
      end;

      GravarLogExcedentes();

    End;

    ProcessarVinculoComOPedido();

    If FBloque Then
      fRollback
    Else
      fCommit;

  Except

    On E: Exception Do
    Begin
      fRollBack();
      RegistraDivergencia('Não foi possível vincular o pedido a nota de remessa - Erro: ' + E.Message);
    End;

  End;

end;

procedure TNotaRemessaVsPedidoVenda.PreValidacao;
begin

  FEmValidacao := True;

  Try
    ProcessarComparacao;
  Finally
    FEmValidacao := False;
  End;

end;

procedure TNotaRemessaVsPedidoVenda.CarregarItensNFComCodFull;
begin
  if not CarregarItensNF then
    Exit;

  ProcessarFull_CodIte;
end;

function TNotaRemessaVsPedidoVenda.ExisteREMFIL(AChaAce, AHubMkp, ACodIte: String): Boolean;
  var
    LREMFIL : TUniQuery;
begin

  Result := False;

  If AChaAce.IsEmpty Then
    Exit;

  If AHubMkp.IsEmpty Then
    Exit;

  If ACodIte.IsEmpty Then
    Exit;

  LREMFIL := fCriaQuery;

  Try

    LREMFIL.SQL.Add('SELECT * FROM REMFIL WHERE REM_ACESSO = :ACESSO AND REM_HUBMKP = :HUBMKP AND REM_CODITE = :CODITE');
    LREMFIL.ParamByName('ACESSO').AsString := AChaAce;
    LREMFIL.ParamByName('HUBMKP').AsString := AHubMkp;
    LREMFIL.ParamByName('CODITE').AsString := ACodIte;
    LREMFIL.Open;

    Result := Not LREMFIL.IsEmpty;

  Finally
    FreeAndNil(LREMFIL);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.GravarLogExcedentes;
  var
    LQry : TUniQuery;
begin

  LQry := fCriaQuery();

  Try

    LQry.SQL.Text := 'SELECT * FROM FULL_LOGSOB WHERE FALSE';
    LQry.Open;

    FItensTA.First;
    while not FItensTA.Eof do
    begin
      LQry.Append;
      LQry.FieldByName('LOG_NUMDOC').AsString := FNumPedNovo;
      LQry.FieldByName('LOG_ESPDOC').AsString := 'PD';
      LQry.FieldByName('LOG_CODEMP').AsString := FCodEmp;
      LQry.FieldByName('LOG_CHAACE').AsString := FChaAce;
      LQry.FieldByName('LOG_HUBMKP').AsString := FPREFIXO_HUBMKP;
      LQry.FieldByName('LOG_CODITE').AsString := FItensTA.FieldByName('CODAUT').AsString;
      LQry.FieldByName('LOG_NUMLOT').AsString := FItensTA.FieldByName('NUMLOT').AsString;
      LQry.FieldByName('LOG_QTDITE').AsFloat  := FItensTA.FieldByName('QTDITE').AsFloat;
      LQry.Post;

      FItensTA.Next;
    end;

  Finally
    FreeAndNil(LQry);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.GuardaLotesSeparados(var AQryLotes: TUniQuery; var AQtdGuardar: Double; ACodIte : String);
  var
    LGuardarTudo : Boolean;
begin


  If Not Assigned(AQryLotes) Then
    Exit;

  If fFormataFloat(AQtdGuardar, FDecQtd) <= 0 Then
    Exit;

  If ACodIte.IsEmpty Then
    Exit;

  LGuardarTudo := (fFormataFloat(AQtdGuardar, FDecQtd) >= fFormataFloat(AQryLotes.FieldByName('QTDSEP').AsFloat, FDecQtd));

  If (LGuardarTudo) Then
  Begin

    GuardarItemTA(ACodIte,
                  AQryLotes.FieldByName('LDO_NUMLOT').AsString,
                  AQryLotes.FieldByName('QTDSEP').AsFloat);

    AQtdGuardar := (AQtdGuardar - AQryLotes.FieldByName('QTDSEP').AsFloat);

    AQryLotes.Edit;
    AQryLotes.FieldByName('LDO_QTDSEP').AsFloat := 0;
    AQryLotes.Post;

  End
  Else
  Begin

    GuardarItemTA(ACodIte,
                  AQryLotes.FieldByName('LDO_NUMLOT').AsString,
                  AQtdGuardar);

    AQryLotes.Edit;
    AQryLotes.FieldByName('LDO_QTDSEP').AsFloat := AQryLotes.FieldByName('QTDSEP').AsFloat - AQtdGuardar;
    AQryLotes.Post;

    AQtdGuardar := 0;

  End;

end;

procedure TNotaRemessaVsPedidoVenda.GuardarItem(ACodIte, ASeqFdo: String; AQtdIte: Double);
begin

  If fFormataFloat(AQtdIte, FDecQtd) <= 0 Then
    Exit;

  FItensGD.Append;
  FItensGD.FieldByName('CODAUT').AsString := ACodIte;
  FItensGD.FieldByName('SEQFDO').AsString := ASeqFdo;
  FItensGD.FieldByName('QTDITE').AsFloat  := AQtdIte;
  FItensGD.Post;

  FExcedePD := FItensGD.RecordCount > 0;

end;

procedure TNotaRemessaVsPedidoVenda.GuardarItemTA(ACodIte, ANumLot: String; AQtdIte: Double);
begin

  If fFormataFloat(AQtdIte, FDecQtd) <= 0 Then
    Exit;

  FItensTA.Append;
  FItensTA.FieldByName('CODAUT').AsString := ACodIte;
  FItensTA.FieldByName('NUMLOT').AsString := ANumLot;
  FItensTA.FieldByName('QTDITE').AsFloat  := AQtdIte;
  FItensTA.Post;
end;

class function TNotaRemessaVsPedidoVenda.ItemDaNFExcedenteEmRelacaoAoPD(AChaAce, AHubMkp, ACodIte: String; Out AQtdPed : Double): Boolean;
  const
    SQL = 'SELECT REM_QTD_PD FROM REMFIL WHERE REM_ACESSO = :ACESSO AND REM_HUBMKP = :HUBMKP AND REM_CODITE = :CODITE';
  var
    LREMFIL : TUniQuery;
begin

  Result  := False;
  AQtdPed := 0;

  If AChaAce.IsEmpty Then
    Exit;

  If AHubMkp.IsEmpty Then
    Exit;

  If ACodIte.IsEmpty Then
    Exit;

  LREMFIL := fCriaQuery;

  Try

    LREMFIL.Close;
    LREMFIL.SQL.Clear;
    LREMFIL.SQL.Add(SQL);

    LREMFIL.ParamByName('ACESSO').AsString := AChaAce;
    LREMFIL.ParamByName('HUBMKP').AsString := AHubMkp;
    LREMFIL.ParamByName('CODITE').AsString := ACodIte;

    LREMFIL.Open;

    Result := (LREMFIL.RecordCount > 0);

    If Result Then
      AQtdPed := LREMFIL.FieldByName('REM_QTD_PD').AsFloat;

  Finally
    FreeAndNil(LREMFIL);
  End;

end;

function TNotaRemessaVsPedidoVenda.NaoHouveBloqueioExisteQuantidadeExcedentesPD: Boolean;
begin

  Result := False;

  If FBloque Then
    Exit;

  If Not FExcedePD Then
    Exit;

  Result := True;

end;

constructor TNotaRemessaVsPedidoVenda.New(AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp : String);
  var
    LREMFIL : TUniQuery;
begin

  FChaAce := AChaAce;
  FArqXML := RetornaXML(AChaAce);

  FNumPedNovo   := IIF(Not ANumPedNovo.IsEmpty, fStrZero(ANumPedNovo, 12), '');
  FNumPedAntigo := ANumPedAntigo;

  FCodEmp := ACodEmp;
  FPREFIXO_HUBMKP := AHubMkp;

  FExcedePD := False;
  FExcedeNF := False;

  FBloque := False;

  FItensGD := CriarDataSet;
  FItensTA := CriarDataSet;
  FItensNF := CriarDataSet;
  FItensPD := CriarDataSet;
  FItensLT := TUniClientDataSet.Create(nil);

  FItensValidacao := CriarDataSetValidacao;
  FEmValidacao    := False;

  FMSGErr  := TStringList.Create;

  FNumFat := '';
  FEspFat := '';
  FEmpFat := '';

  FDecQtd := fCfgSis('DECQTD', varInteger);

  If FChaAce.IsEmpty Then
    Exit;

  LREMFIL := fCriaQuery;

  Try

    LREMFIL.Close;
    LREMFIL.SQL.Clear;
    LREMFIL.SQL.Add('SELECT * FROM NFEIMP WHERE NFE_ACESSO = :ACESSO AND NFE_STATUS = "AT"');
    LREMFIL.ParamByName('ACESSO').AsString := FChaAce;
    LREMFIL.Open;

    If Not LREMFIL.IsEmpty Then
    Begin

      FNumFat := LREMFIL.FieldByName('NFE_NUMDOC').AsString;
      FEspFat := LREMFIL.FieldByName('NFE_ESPDOC').AsString;
      FEmpFat := LREMFIL.FieldByName('NFE_CODEMP').AsString;

      FNumFat := fStrZero(FNumFat, 12);

    End;

  Finally
    FreeAndNil(LREMFIL);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.GerarTL;
var
  LNumLot,
  LLocFis  : String;
  LItensTL : TUniClientDataSet;
  LCadLot  : TCadLot;
  LTransf  : TTransferenciaArmazens;
begin

  LCadLot := TCadLot.Create(nil);

  LNumLot := fCfgSis('LTTAPC', varString);
  LLocFis := fCfgSis('LCTAPC', varString);

  CriaDataSetItensTL(LItensTL);
  LTransf := TTransferenciaArmazens.Create(nil, LItensTL, nil, nil);

  try

    try

      FItensTA.First;
      while not FItensTA.Eof do
      begin

        if (not LCadLot.fExisteLote(FItensTA.FieldByName('CODAUT').AsString, FCodEmp, LNumLot, False, False)) then
          LCadLot.GeraLoteAtivo(FItensTA.FieldByName('CODAUT').AsString, LNumLot, LLocFis, FCodEmp);

        LItensTL.Append;
        LItensTL.FieldByName('CODITE').AsString := FItensTA.FieldByName('CODAUT').AsString;
        LItensTL.FieldByName('ARMDES').AsString := LNumLot;
        LItensTL.FieldByName('ARMORI').AsString := FItensTA.FieldByName('NUMLOT').AsString;
        LItensTL.FieldByName('QTDITE').AsFloat  := FItensTA.FieldByName('QTDITE').AsFloat;
        LItensTL.Post;

        FItensTA.Next;
      end;

      LTransf.strDocFat := FNumFat;
      LTransf.strEspFat := FEspFat;
      LTransf.strEmpFat := FEmpFat;
      LTransf.strCliFat := '';

      LTransf.fGeraTransferencia(True, False);

    finally
      FreeAndNil(LCadLot);
      FreeAndNil(LItensTL);
      FreeAndNil(LTransf);
    end;

  except
    on E: Exception do
    begin
      raise;
    end;
  end;

end;

procedure TNotaRemessaVsPedidoVenda.ProcessarComparacao;
begin

  if not CarregarItensNF then
  begin
    RegistraDivergencia('Não foi possível carregar os itens do arquivo XML da nota de remessa!');
    Exit;
  end;

  if not CarregarItensPD then
  begin
    RegistraDivergencia('Não foi possível carregar os itens do pedido!');
    Exit;
  end;

  if not ProcessarFull_CodIte then
  begin
    RegistraDivergencia('Não foi possível vincular o pedido à nota de remessa porque há itens na nota sem relacionamento com o AutCom. '+
                        'Para fazer o ajuste, vá até a aba "Não foi encontrado o item" e relacione os produtos.');
    Exit;
  end;

  AgruparPorCodigoAutcomEProcessarNaoEncontrados;

  ValidaItensNF;
  ValidaItensPD;
  ValidaEstrutura;

end;

function TNotaRemessaVsPedidoVenda.ProcessarFull_CodIte : Boolean;
  var
    LCodIte : String;
begin

  Result := True;

  Try

    FItensNF.First;
    while not FItensNF.Eof do
    begin

      LCodIte := LocalizaCodIte(FItensNF.FieldByName('CODBAR').AsString,
                                FItensNF.FieldByName('CODNFE').AsString,
                                FPREFIXO_HUBMKP,
                                FCodEmp);

      FItensNF.Edit;
      FItensNF.FieldByName('CODAUT').AsString := LCodIte;
      FItensNF.Post;

      If (Result) Then
        If fEmptyStr(FItensNF.FieldByName('CODAUT').AsString) Then
          Result := False;

      FItensNF.Next;

    end;

  Finally

  End;

end;

procedure TNotaRemessaVsPedidoVenda.ProcessarGeracaoTAGuardarItens;
begin

  inherited;

  if FItensTA.IsEmpty then
    Exit;

  GerarTL;

end;

procedure TNotaRemessaVsPedidoVenda.ProcessarLOTDOR;
  var
    LQryLOTDOR : TUniQuery;
    LQtdGuarda : Double;
begin

  LQryLOTDOR := fCriaQuery();

  Try

    FItensGD.First;
    while not FItensGD.Eof do
    begin

      LQtdGuarda := FItensGD.FieldByName('QTDITE').AsFloat;

      If BuscaLotesSeparados(LQryLOTDOR, FItensGD.FieldByName('SEQFDO').AsString) Then
      Begin

        LQryLOTDOR.First;
        While Not LQryLOTDOR.Eof Do
        Begin

          GuardaLotesSeparados(LQryLOTDOR, LQtdGuarda, FItensGD.FieldByName('CODAUT').AsString);

          If fFormataFloat(LQtdGuarda, FDecQtd) = 0 Then
            Break;

          LQryLOTDOR.Next;

        End;

      End;

      FItensGD.Next;

    end;

  Finally
    If Assigned(LQryLOTDOR) Then
      FreeAndNil(LQryLOTDOR);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.AgruparPorCodigoAutcomEProcessarNaoEncontrados;
  var
    LProcessa : TUniClientDataSet;
begin

  If FItensNF.IsEmpty Then
    Exit;

  LProcessa := CriarDataSet;

  Try

    //agrupa itens duplicados na nota
    FItensNF.First;
    While Not FItensNF.Eof Do
    Begin

      If fEmptyStr(FItensNF.FieldByName('CODAUT').AsString) Then
        AddItensValidacao(FItensNF, staProdutoNaoEncontrado);

      If LProcessa.Locate('CODAUT', FItensNF.FieldByName('CODAUT').AsString, []) Then
      Begin

        LProcessa.Edit;
        LProcessa.FieldByName('QTDITE').AsFloat := (LProcessa.FieldByName('QTDITE').AsFloat + FItensNF.FieldByName('QTDITE').AsFloat);
        LProcessa.Post;

      End Else Begin

        pCloneRegistro(LProcessa, FItensNF, True);

      End;

      FItensNF.Next;

    End;

    FItensNF.EmptyDataSet;
    FItensNF.Data := LProcessa.Data;

    LProcessa.EmptyDataSet;

    //agrupa itens duplicados no pedido
    FItensPD.First;
    While Not FItensPD.Eof Do
    Begin

      //Há casos onde o item do pedido é subitem estrutura, mas na nota também é subitem.
      //Nesses casos, deve limpar o item pai e considerar como subitem na comparação
      If (Not fEmptyStr(FItensPD.FieldByName('ITEEST').AsString)) And
         (Not FItensNF.Locate('CODAUT', FItensPD.FieldByName('ITEEST').AsString, [])) Then
      Begin
        FItensPD.Edit;
        FItensPD.FieldByName('ITEEST').AsString := EmptyStr;
        FItensPD.FieldByName('SEQEST').AsInteger := 0;
        FItensPD.Post;
      End;

      If LProcessa.Locate('CODAUT;ITEEST', VarArrayOf([FItensPD.FieldByName('CODAUT').AsString,
                                                       FItensPD.FieldByName('ITEEST').AsString]), []) Then
      Begin

        LProcessa.Edit;
        LProcessa.FieldByName('QTDITE').AsFloat := (LProcessa.FieldByName('QTDITE').AsFloat + FItensPD.FieldByName('QTDITE').AsFloat);
        LProcessa.Post;

      End Else Begin

        pCloneRegistro(LProcessa, FItensPD, True);

      End;

      FItensPD.Next;

    End;

    FItensPD.EmptyDataSet;
    FItensPD.Data := LProcessa.Data;

  Finally
    FreeAndNil(LProcessa);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.ProcessarVinculoComOPedido;
begin

  If FArqXML.Contains('<xPed>' + FNumPedAntigo + '</xPed>') Then
    fExecutaSQL(
      'UPDATE NFEIMP ' +
      '  SET NFE_IMPORT = "N", ' +
      '      NFE_ARQXML = REPLACE(NFE_ARQXML, ' +
      '                           CONCAT("<xPed>","' + FNumPedAntigo + '","</xPed>"), ' +
      '                           CONCAT("<xPed>","' + FNumPedNovo + '","</xPed>")) ' +
      ' WHERE NFE_ACESSO = "' + FChaAce + '" ' +
      '   AND NFE_IMPORT = "E" ')
  Else
    fExecutaSQL(
      'UPDATE NFEIMP ' +
      '  SET NFE_IMPORT = "N", ' +
      '      NFE_ARQXML = REPLACE(NFE_ARQXML, ' +
      '                           "</cProd>", ' +
      '                           CONCAT("</cProd><xPed>","' + FNumPedNovo + '","</xPed>")) ' +
      ' WHERE NFE_ACESSO = "' + FChaAce + '" ' +
      '   AND NFE_IMPORT = "E" ');

  fExecutaSQL('DELETE FROM FULL_LOGERR WHERE LOG_ACESSO = "' + FChaAce + '"');

end;

procedure TNotaRemessaVsPedidoVenda.RegistraDivergencia(ADivergencia: String);
begin
  FMSGErr.Add(FormatDateTime('dd/mm/yyyy hh:mm', fNow) + ' - ' + ADivergencia);
  FBloque := True;
end;

function TNotaRemessaVsPedidoVenda.RetornaXML(AChaAce: String): String;
  var
    LQry : TUniQuery;
begin

  Result := '';

  if AChaAce.IsEmpty then
    Exit;

  LQry := fCriaQuery();

  Try

    LQry.SQL.Add('SELECT NFE_ARQXML FROM NFEIMP WHERE NFE_ACESSO = ' + QuotedStr(AChaAce));
    LQry.Open;

    if LQry.IsEmpty then
      Exit;

    Result := LQry.FieldByName('NFE_ARQXML').AsString;

  Finally
    FreeAndNil(LQry);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.ValidaEstrutura;
  var
    LEstrutura : TUniQuery;

    LLocalizouItemNFnoPD : Boolean;
    LQtdNFDiferQueNoPD   : Boolean;

    LTemInconsistencia      : Boolean;
    LTemInconsistenciaGeral : Boolean;

    LSubItem : String;
    LSubQtde : Double;

    LCodigoDoItem : String;
    LQtdEstrutura : Double;

begin

  FItensNF.First;
  while not FItensNF.Eof do
  begin

    LCodigoDoItem := FItensNF.FieldByName('CODAUT').AsString;
    LQtdEstrutura := FItensNF.FieldByName('QTDITE').AsFloat;

    If Not EhItemEstruturaBaixandoSubItens(LCodigoDoItem) Then
    Begin
      FItensNF.Next;
      Continue;
    End;

    {** Localiza pelo Pai **}
    LLocalizouItemNFnoPD := FItensPD.Locate('CODAUT;ITEEST', VarArrayOf([LCodigoDoItem, EmptyStr]), []);
    LQtdNFDiferQueNoPD   := LLocalizouItemNFnoPD And
                            (fFormataFloat(LQtdEstrutura, FDecQtd) <> fFormataFloat(FItensPD.FieldByName('QTDITE').AsFloat, FDecQtd));

    LTemInconsistencia := ((Not LLocalizouItemNFnoPD) Or (LQtdNFDiferQueNoPD));

    If (Not LTemInconsistencia) Then
    Begin
      AddItensValidacao(FItensNF, staQtdCondizenteEntrePedidoENota);
      FItensNF.Next;
      Continue;
    End;

    {** Localiza pelo(s) Filho(s) **}
    LEstrutura := RetornaEstrutura(LCodigoDoItem);

    Try

      LTemInconsistenciaGeral := False;

      LEstrutura.First;
      While Not LEstrutura.Eof Do
      Begin

        LSubItem := LEstrutura.FieldByName('DMT_ITESUB').AsString;
        LSubQtde := LEstrutura.FieldByName('DMT_QTDITE').AsFloat;

        LLocalizouItemNFnoPD := FItensPD.Locate('CODAUT;ITEEST', VarArrayOf([LSubItem, LCodigoDoItem]), []);
        LQtdNFDiferQueNoPD   := LLocalizouItemNFnoPD And
                                (fFormataFloat((LQtdEstrutura * LSubQtde), FDecQtd) <> fFormataFloat(FItensPD.FieldByName('QTDITE').AsFloat, FDecQtd));

        LTemInconsistencia := ((Not LLocalizouItemNFnoPD) Or (LQtdNFDiferQueNoPD));

        If LTemInconsistencia Then
          LTemInconsistenciaGeral := True;

        If (LTemInconsistencia) Then
          AddItensValidacao(FItensPD, IIF(LQtdNFDiferQueNoPD, staQtdDivergente, staProdutoDivergente))
        Else
          AddItensValidacao(FItensPD, staQtdCondizenteEntrePedidoENota);

        LEstrutura.Next;

      End;

      If (LTemInconsistenciaGeral) Then
        AddItensValidacao(FItensNF, staQtdDivergente)
      Else
        AddItensValidacao(FItensNF, staQtdCondizenteEntrePedidoENota);

    Finally
      FreeAndNil(LEstrutura);
    End;

    FItensNF.Next;

  end;

end;

procedure TNotaRemessaVsPedidoVenda.ValidaItensNF;
  var
    LLocalizouItemNFnoPD : Boolean;
    LQtdNFMaiorQueNoPD   : Boolean;
    LTemInconsistencia   : Boolean;
    LCodigoItem : String;
    LREMFIL     : TUniQuery;
begin

  LREMFIL := fCriaQuery;

  LREMFIL.Close;
  LREMFIL.SQL.Clear;
  LREMFIL.SQL.Add('SELECT * FROM REMFIL WHERE FALSE');
  LREMFIL.Open;

  Try

    FItensNF.First;
    while not FItensNF.Eof do
    begin

      LCodigoItem := FItensNF.FieldByName('CODAUT').AsString;

      If EhItemEstruturaBaixandoSubItens(LCodigoItem) Then
      Begin
        FItensNF.Next;
        Continue;
      End;

      LLocalizouItemNFnoPD := FItensPD.Locate('CODAUT;ITEEST', VarArrayOf([LCodigoItem, EmptyStr]), []);
      LQtdNFMaiorQueNoPD   := LLocalizouItemNFnoPD And
                              (fFormataFloat(FItensNF.FieldByName('QTDITE').AsFloat, FDecQtd) > fFormataFloat(FItensPD.FieldByName('QTDITE').AsFloat, FDecQtd));

      LTemInconsistencia := ((Not LLocalizouItemNFnoPD) Or (LQtdNFMaiorQueNoPD));

      If (Not LTemInconsistencia) Then
        AddItensValidacao(FItensNF, staQtdCondizenteEntrePedidoENota);

      If (LTemInconsistencia) Then
      Begin

        AddItensValidacao(FItensNF, IIF(LQtdNFMaiorQueNoPD, staQtdDivergente, staProdutoDivergente));

        If Not FEmValidacao Then
        Begin

          If Not ExisteREMFIL(FChaAce, FPREFIXO_HUBMKP, LCodigoItem) Then
          Begin
            LREMFIL.Append;
            LREMFIL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REMFIL', VS_strCodEmp);
            LREMFIL.FieldByName('REM_ACESSO').AsString := FChaAce;
            LREMFIL.FieldByName('REM_NUMDOC').AsString := FNumFat;
            LREMFIL.FieldByName('REM_ESPDOC').AsString := FEspFat;
            LREMFIL.FieldByName('REM_CODEMP').AsString := FEmpFat;
            LREMFIL.FieldByName('REM_HUBMKP').AsString := FPREFIXO_HUBMKP;
            LREMFIL.FieldByName('REM_CODITE').AsString := LCodigoItem;
            LREMFIL.FieldByName('REM_QTD_PD').AsFloat  := IIF(LQtdNFMaiorQueNoPD, FItensPD.FieldByName('QTDITE').AsFloat, 0);
            LREMFIL.FieldByName('REM_QTD_NF').AsFloat  := FItensNF.FieldByName('QTDITE').AsFloat;
            LREMFIL.Post;
          End;

        End;

        FExcedeNF := True;

      End;

      FItensNF.Next;

    end;

  Finally
    FreeAndNil(LREMFIL);
  End;

end;

procedure TNotaRemessaVsPedidoVenda.ValidaItensPD;
  var
    LCodigoItem      : String;
    LCompoeEstrutura : Boolean;
begin

  FItensPD.First;
  while not FItensPD.Eof do
  begin

    LCodigoItem      := (FItensPD.FieldByName('CODAUT').AsString);
    LCompoeEstrutura := (FItensPD.FieldByName('SEQEST').AsInteger > 0) Or (Not fEmptyStr(FItensPD.FieldByName('ITEEST').AsString));

    If EhItemEstruturaBaixandoSubItens(LCodigoItem) Or (LCompoeEstrutura) Then
    Begin
      FItensPD.Next;
      Continue;
    End;

    if ValidaSeLocalizouItemNaVenda(LCodigoItem) then
      ValidaQuantidade;

    FItensPD.Next;

  end;

end;

procedure TNotaRemessaVsPedidoVenda.ValidaQuantidade;
  var
    LQtdNF  : Double;
    LQtdPD  : Double;
begin

  LQtdNF := FItensNF.FieldByName('QTDITE').AsFloat;
  LQtdPD := FItensPD.FieldByName('QTDITE').AsFloat;

  If fFormataFloat(LQtdPD, FDecQtd) > fFormataFloat(LQtdNF, FDecQtd) Then
  Begin

    AddItensValidacao(FItensPD, staQtdDivergente);

    GuardarItem(FItensPD.FieldByName('CODAUT').AsString,
                FItensPD.FieldByName('SEQFDO').AsString,
                (LQtdPD - LQtdNF));
  End;

end;

function TNotaRemessaVsPedidoVenda.ValidaSeLocalizouItemNaVenda(ACodIte: String): Boolean;
begin

  Result := FItensNF.Locate('CODAUT', ACodIte, []);

  If Not Result Then
  Begin

    AddItensValidacao(FItensPD, staProdutoDivergente);

    GuardarItem(FItensPD.FieldByName('CODAUT').AsString,
                FItensPD.FieldByName('SEQFDO').AsString,
                FItensPD.FieldByName('QTDITE').AsFloat);

  End;

end;

end.
