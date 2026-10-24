unit untImpressorCupom;

interface

uses  untFiscal, untFunTef, Uni, SysUtils,
      StrUtils, Classes, Forms, Controls, untFuncFatTypes, UniClientDataSet, DB,
      Windows, untTypesSistema;

Type
  TModalidadeNovoEvent = procedure(objFiscal: TFiscalBrd; arrParametros: Array Of TObject) of object;
  TModalidadeVelhoEvent = procedure(objFiscal: TUntFiscal; arrParametros: Array Of TObject) of object;

Type
  TImpressorCupom = class(TObject)
    protected
      FParametros: Array Of TObject;
      cdsModalidades: TUniClientDataSet;
      
      procedure pCarregarItensDocumento(qryItens: TUniQuery; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie: String);
      function fGetSqlItens(strTabela: String): String;
      function fCupomJaImpresso(strTabela, strNumDoc, strEspDoc, strCodEmp,
        strCodCli, strSerie: String): Boolean;
      procedure pEncontraModalidadeDinheiro(var strCodMod, strDesMod: String;
        strCodEcf: String);
    public
      procedure pAdicionaParametro(objParametro: TObject);
      procedure pImprimirCupom(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie: String); overload; virtual; abstract;
      procedure pImprimirCupom(fltTotal: Double; arrMatItens: TMatrizFechamento); overload; virtual; abstract;
      procedure pCancelarCupom; virtual; abstract;
      function fNumeroSerie: String; virtual; abstract;
      function fNumeroCoo: String; virtual; abstract;
      function fVerificaCupomAberto: Boolean; virtual; abstract;

      procedure pAdicionarModalidade(const strCodMod, strDesMod, strVencim: String;
        const fltValMod: Double);

  End;

Type
  TBlocoImpressao = (biItens, biFechamento);
  TBlocosImpressao = set of TBlocoImpressao;

  TImpressorCupomNovo = class(TImpressorCupom)
    private
      objFiscal: TFiscalBrd;
      FEventoModalidade: TModalidadeNovoEvent;
      FInterromper: Boolean;
      FAbriuCupom: Boolean;
      FSomenteProdutos: Boolean;

      fltTotal: Double;
      fltDesEsp: Double;
      fltTotalImpr: Double;
      procedure pDisparaEventoImpressaoModalidades(fltTotal: Double);
      procedure pImprimirCupomInterna(qryItens: TDataSet);
      procedure pImprimeModalidadesInformadas;

      procedure pChecaInterrupcao;
      procedure pImpressaoTotal;
    public
      bimBlocosImpressao: TBlocosImpressao;

      constructor Create(objFiscal: TFiscalBrd;
        EventoModalidade: TModalidadeNovoEvent);
      procedure pImprimirCupom(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie: String); overload; override;
      procedure pImprimirCupom(fltTotal: Double; arrMatItens: TMatrizFechamento); overload; override;
      procedure pCancelarCupom; override;
      function fNumeroSerie: String; override;
      function fNumeroCoo: String; override;
      function fVerificaCupomAberto: Boolean; override;

      procedure pInterromper;
      procedure pCancelarSeFoiAberto;
      procedure pFecharCupom;

      procedure pAbreCupomERegistraItens(qryItens: TDataSet);
      procedure pTotalizaEFechaCupom;

      procedure pSetDesconto(fltValor, fltTotGer: Double);
  End;

Type
  TImpressorCupomVelho = class(TImpressorCupom)
    private
      objFiscal: TUntFiscal;
      FEventoModalidade: TModalidadeVelhoEvent;
      fltTotGerSav: Double;
      strObserv: String;
      procedure pDisparaEventoImpressaoModalidades(fltTotal: Double);
      function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; strEstCli,
        strIesCli: String; intTipRet: Integer=1): String;
      procedure pImprimirCupomInterna(qryItens: TDataSet);
    public
      constructor Create(objFiscal: TUntFiscal;
        EventoModalidade: TModalidadeVelhoEvent; fltTotGerSav: Double;
        strObserv: String);
      procedure pImprimirCupom(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie: String); overload; override;
      procedure pImprimirCupom(fltTotal: Double; arrMatItens: TMatrizFechamento); overload; override;
      procedure pCancelarCupom; override;
      function fNumeroSerie: String; override;
      function fNumeroCoo: String; override;
      function fVerificaCupomAberto: Boolean; override;
  End;

Type
  EInterrupcaoException = class(Exception);

Type
  EErroNaImpressaoException = class(Exception);
  
  TImpressorDeCupons = class(TObject)
    private
      qryDocs: TUniQuery;
      stlProblemas: TStringList;
      blnMostraMsg: Boolean;
      procedure pCarregaCuponsPendentes;
      procedure pImprimeCupomAtual;
      function fGeraObservacoes(ecfFiscal: TUntFiscal): String;

      function fAtualizarDadosCupom(impressorCupom: TImpressorCupom): Boolean;
      procedure pLogarECancelar(impressorCupom: TImpressorCupom; ExcecaoAbort: EAbort);
    public
      constructor Create;
      destructor Destroy; override;

      procedure pImrpimeCupons;
      function fProblemas: TStringList;
      procedure SetMostraMsg(blnMostra: Boolean);
  End;

  function fMensagemEcfNaoCadastrado(strCodEcf: String): String;
  function fRetornaCodigoEcfConfigurado: String;
  function fCriaClientDataSet(fltTotal: Double; arrMatItens: TMatrizFechamento): TUniClientDataSet;
  function fCriaClientDataSetModalidades: TUniClientDataSet;

Const
  ERRO_ABERTURA_CUPOM = 1;
  DESLOCAMENTO_MSG = -150;

implementation

uses untFuncTinta, untFuncoes, untFuncoesSimples, untConstantes, untConstantesNFe;

procedure pAddField(cds: TUniClientDataSet; strNome: String; tipo: TFieldType; intTamanho: Integer);
begin
  With cds.FieldDefs.AddFieldDef Do
  Begin
    Name := strNome;
    DataType := tipo;
    If (tipo = ftString) Then
      Size := intTamanho;
  End;
end;

function fMensagemEcfNaoCadastrado(strCodEcf: String): String;
begin
  Result := 'Atenção: é necessário cadastrar um ECF de código ' + strCodEcf + '. Caso já ' +
    'exista um cadastro para este ECF, por favor, corrigir o número de série em Principal -> Cadastros -> Auxiliares -> ' +
    'Impressora Fiscal.';
end;

function fRetornaCodigoEcfConfigurado: String;
begin
  Result := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', fCfgSis('DIRINI') + '/opcoes_fiscal.ini' );
end;

function fCriaClientDataSet(fltTotal: Double; arrMatItens: TMatrizFechamento): TUniClientDataSet;
  Var
    intContador: Integer;
begin
  Result := TUniClientDataSet.Create(Nil);
  pAddField(Result, 'DET_NUM_PD', ftString, 12);
  pAddField(Result, 'DET_CODITE', ftString, fTamCodIte);
  pAddField(Result, 'DET_CODACA', ftString, 06);
  pAddField(Result, 'DET_EMPACA', ftString, 03);
  pAddField(Result, 'DET_DESCRI', ftString, 200);
  pAddField(Result, 'DET_UNIDAD', ftString, 10);
  pAddField(Result, 'DET_QTDITE', ftFloat, 0);
  pAddField(Result, 'DET_UNITAR', ftFloat, 0);
  pAddField(Result, 'DET_PREEMB', ftFloat, 0);
  pAddField(Result, 'DET_PROEMB', ftString, 01);
  pAddField(Result, 'DET_CODFIS', ftString, 03);
  pAddField(Result, 'DET_ALQICM', ftFloat, 0);
  pAddField(Result, 'DET_CODMAR', ftString, 06);
  pAddField(Result, 'DET_DESESP', ftFloat, 0);
  pAddField(Result, 'DET_IDEPRO', ftString, 03);
  pAddField(Result, 'DET_TOTITE', ftFloat, 0);
  pAddField(Result, 'GER_VLRCON', ftFloat, 0);
  pAddField(Result, 'TABGER', ftString, 10);

  Result.CreateDataSet;

  For intContador := Low(arrMatItens) To High(arrMatItens) Do
  Begin
    Result.Append;
    Result.FieldByName('DET_NUM_PD').AsString := arrMatItens[intContador].strNumOrc;
    Result.FieldByName('DET_CODITE').AsString := arrMatItens[intContador].strCodIte;
    Result.FieldByName('DET_CODACA').AsString := arrMatItens[intContador].strCodAca;
    Result.FieldByName('DET_EMPACA').AsString := arrMatItens[intContador].strEmpAca;    

    Result.FieldByName('DET_DESCRI').AsString := IIF(arrMatItens[intContador].strIdePro<>'NOR', arrMatItens[intContador].strIdePro + ' - ', '') +
                                                   arrMatItens[intContador].strDesIte;

    Result.FieldByName('DET_UNIDAD').AsString := arrMatItens[intContador].strUnidad;
    Result.FieldByName('DET_QTDITE').AsFloat  := arrMatItens[intContador].fltQtdIte;
    Result.FieldByName('DET_UNITAR').AsFloat  := arrMatItens[intContador].fltUniTar;
    Result.FieldByName('DET_PREEMB').AsFloat  := 0.00;
    Result.FieldByName('DET_PROEMB').AsString := 'N';
    Result.FieldByName('DET_CODFIS').AsString := arrMatItens[intContador].strCodFis;
    Result.FieldByName('DET_ALQICM').AsFloat  := arrMatItens[intContador].fltAlqIcm;
    Result.FieldByName('DET_CODMAR').AsString := arrMatItens[intContador].strCodMar;
    Result.FieldByName('DET_DESESP').AsFloat  := arrMatItens[intContador].fltDesEsp;
    Result.FieldByName('DET_IDEPRO').AsString := arrMatItens[intContador].strIdePro;
    Result.FieldByName('DET_TOTITE').AsFloat  := arrMatItens[intContador].fltTotIte;
    Result.FieldByName('GER_VLRCON').AsFloat  := fltTotal;
    Result.FieldByName('TABGER').AsString     := '';
    Result.Post;
  End;
end;

function fCriaClientDataSetModalidades: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  pAddField(Result, 'CODMOD', ftString, 10);
  pAddField(Result, 'DESMOD', ftString, 50);
  pAddField(Result, 'VALMOD', ftFloat, 0);
  pAddField(Result, 'VENCIM', ftString, 50);

  Result.CreateDataSet;
end;

{ TImpressorCupomNovo }

function TImpressorCupomNovo.fNumeroCoo: String;
begin
  Result := objFiscal.fRetornaCOO;
end;

function TImpressorCupomNovo.fNumeroSerie: String;
begin
  Result := objFiscal.fNumeroSerie;
end;

function TImpressorCupomNovo.fVerificaCupomAberto: Boolean;
begin
  Result := objFiscal.fVerificaCupomAberto;
end;

procedure TImpressorCupomNovo.pCancelarCupom;
begin
  objFiscal.fCancelaCupom;
end;

procedure TImpressorCupomNovo.pCancelarSeFoiAberto;
begin
  If FAbriuCupom Then
  Begin
    Try
      objFiscal.fCancelaCupom;
    Except
      On E: EErroImpressaoECF Do
      Begin
        //
      End;
    End;
  End;
end;

procedure TImpressorCupomNovo.pChecaInterrupcao;
begin
  If FInterromper Then
  Begin
    Raise EInterrupcaoException.Create('Processo interrompido.');
  End;
end;

procedure TImpressorCupomNovo.pDisparaEventoImpressaoModalidades(fltTotal: Double);
  Var
    strCodMod: String;
    strDesMod: String;
begin
  If Assigned(FEventoModalidade) Then
  Begin
    FEventoModalidade(objFiscal, FParametros);

    pChecaInterrupcao;
  End
  Else If (Assigned(cdsModalidades)) And (cdsModalidades.RecordCount > 0) Then
  Begin
    pImprimeModalidadesInformadas;
  End
  Else
  Begin
    pEncontraModalidadeDinheiro(strCodMod, strDesMod, fRetornaCodigoEcfConfigurado);
    If Not objFiscal.fRegistraModalidades(strCodMod, strDesMod, fltTotal, '') Then
    Begin
      Abort;
    End;

    pChecaInterrupcao;
  End;
end;

procedure TImpressorCupomNovo.pFecharCupom;
begin
  pChecaInterrupcao;

  {*****************************************}
  {* TOTALIZA CUPOM                        *}
  {**************************************AF*}
  If Not VS_objFiscal.fFechaCupom Then
    Abort;
end;

procedure TImpressorCupomNovo.pImprimeModalidadesInformadas;
begin
  cdsModalidades.First;

  While Not cdsModalidades.Eof Do
  Begin
    If Not objFiscal.fRegistraModalidades(cdsModalidades.FieldByName('CODMOD').AsString,
                                          cdsModalidades.FieldByName('DESMOD').AsString,
                                          cdsModalidades.FieldByName('VALMOD').AsFloat,
                                          cdsModalidades.FieldByName('VENCIM').AsString) Then
    Begin
      Abort;
    End;

    pChecaInterrupcao;

    cdsModalidades.Next;
  End;
end;

procedure TImpressorCupomNovo.pImprimirCupom(fltTotal: Double; arrMatItens: TMatrizFechamento);
  Var
    cdsItens: TUniClientDataSet;
begin
  cdsItens := fCriaClientDataSet(fltTotal, arrMatItens);
  Self.fltTotal := fltTotal;
  
  Try
    pImprimirCupomInterna(cdsItens);
  Finally
    FreeAndNil(cdsItens);
  End;
end;

constructor TImpressorCupomNovo.Create(objFiscal: TFiscalBrd;
  EventoModalidade: TModalidadeNovoEvent);
begin
  Self.objFiscal := objFiscal;
  Self.FEventoModalidade := EventoModalidade;
  Self.cdsModalidades := fCriaClientDataSetModalidades;
  Self.FInterromper := False;
  Self.FAbriuCupom := False;
  Self.FSomenteProdutos := False;

  pImpressaoTotal;
end;

procedure TImpressorCupomNovo.pImprimirCupom(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie: String);
  Var
    qryItens: TUniQuery;
begin
  qryItens := fCriaQuery(Nil);
  Try
    pCarregarItensDocumento(qryItens, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie);

    If fCupomJaImpresso(qryItens.FieldByName('TABGER').AsString, strNumDoc,
      strEspDoc, strCodEmp, strCodCli, strSerie) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cupom já foi impresso por outra estação. Por favor verifique.', ['&Ok'],
        1, False, 1, 0, False, DESLOCAMENTO_MSG);
      Exit;
    End;

    pImprimirCupomInterna(qryItens);
  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TImpressorCupomNovo.pImprimirCupomInterna(qryItens: TDataSet);
begin
  If bimBlocosImpressao = [] Then
  Begin
    pImpressaoTotal;
  End;

  If biItens In bimBlocosImpressao Then
  Begin
    pAbreCupomERegistraItens(qryItens);
  End;

  If biFechamento In bimBlocosImpressao Then
  Begin
    pTotalizaEFechaCupom;
  End;
end;

procedure TImpressorCupomNovo.pImpressaoTotal;
begin
  bimBlocosImpressao := [biItens, biFechamento];
end;

procedure TImpressorCupomNovo.pAbreCupomERegistraItens(qryItens: TDataSet);
  Var
    blnCupMar: Boolean;
    blnCodBar: Boolean;
    strCodIte: String;
    strDesIte: String;
    strCodBar: String;
begin
    blnCupMar := fCfgSis('CUPMAR', VarBoolean);
    blnCodBar := fCfgSis('CBCODE', VarBoolean);

    fltTotal := qryItens.FieldByName('GER_VLRCON').AsFloat;

    VS_objFiscal.strMenPaf01 := 'MD-5:' + fRetMD5Laudo;
    VS_objFiscal.strMenPaf02 := '';

  pChecaInterrupcao;

    If (Not fEmptyStr(qryItens.FieldByName('DET_NUM_PD').AsString)) Then
    Begin
      If fCfgSis('IDAVPF', varBoolean) Then
      Begin
        VS_objFiscal.strMenPaf02 := 'DAV' + fStrZero(qryItens.FieldByName('DET_NUM_PD').AsString, 13);
      End;
    End;

  pChecaInterrupcao;

  If fEmptyStr(VS_objFiscal.strCpfClie) Then
  Begin
    VS_objFiscal.strCpfClie := fRetornaCpfCnpfVazio('2');
    If Pos('MP4200FI', VS_objFiscal.strModEcf) > 0 Then
    Begin
      VS_objFiscal.strCpfClie := '';
    End;
  End;

  {**************************************}
    {* ABRE CUPOM                         *}
    {***********************************AF*}
    If Not VS_objFiscal.fAbreCupom Then
      Raise EAbort.CreateHelp('', ERRO_ABERTURA_CUPOM);

  FAbriuCupom := True;

  pChecaInterrupcao;

    {*****************************************}
    {* PROCESSA OS ITENS IMPRIMINDO CUPOM    *}
    {**************************************AF*}
    qryItens.First;
    fltTotalImpr := 0.0;
    fltDesEsp := 0;
    While Not qryItens.Eof Do
    Begin

      If (qryItens.FieldByName('DET_PROEMB').AsString = 'S') Then
      Begin

        qryItens.Next;
        Continue;

      End;

      pChecaInterrupcao;

      strDesIte := qryItens.FieldByName('DET_DESCRI').AsString;

      If blnCupMar Then
        strDesIte := Concat(strDesIte, ' - ', fRetNomMarca(qryItens.FieldByName('DET_CODMAR').AsString));

      If blnCodBar Then
      Begin
        strCodBar := fRetCodBarMovCdb(qryItens.FieldByName('AUTINC').AsString,
                                      qryItens.FieldByName('DET_CODITE').AsString);

        If Not fEmptyStr(strCodBar) Then
          strCodBar := ' - Cod.Barra: ' + strCodBar;

        strDesIte := Concat(strDesIte, strCodBar);
      End;

      strCodIte := qryItens.FieldByName('DET_CODITE').AsString;
      //Quando configurado para imprimir o codigo do produto acabado
      If (fCfgSis('CODTIN') = '2') And Not fEmptyStr(qryItens.FieldByName('DET_CODACA').AsString) Then
        strCodIte := qryItens.FieldByName('DET_CODACA').AsString + '-' + qryItens.FieldByName('DET_EMPACA').AsString
      //Quando configurado para imprimir o código único do tintométrico
      Else If (fCfgSis('CODTIN') = '3') And Not fEmptyStr(qryItens.FieldByName('DET_CODACA').AsString) Then
        strCodIte := fRetCodigoUnicoProdutoAcabado(
          qryItens.FieldByName('DET_CODACA').AsString, qryItens.FieldByName('DET_EMPACA').AsString);

      If Not fEmptyStr(qryItens.FieldByName('DET_NUMLOT').AsString) Then
      Begin
        strDesIte := strDesIte + ' - LOTE: ' + Trim(qryItens.FieldByName('DET_NUMLOT').AsString);
      End;

      Begin
        If Not (VS_objFiscal.fRegistraItem(strCodIte,
                                           strDesIte,
                                           fRetSiglaUnidadeIF(qryItens.FieldByName('DET_UNIDAD').AsString),
                                           qryItens.FieldByName('DET_ALQICM').AsFloat,
                                           qryItens.FieldByName('DET_QTDITE').AsFloat,

                                           IIF(qryItens.FieldByName( 'DET_PROEMB' ).AsString = 'S',
                                               qryItens.FieldByName( 'DET_PREEMB' ).AsFloat / qryItens.FieldByName( 'DET_QTDITE' ).AsFloat,
                                               qryItens.FieldByName( 'DET_UNITAR' ).AsFloat),

                                           qryItens.FieldByName('DET_CODFIS').AsString,
                                           qryItens.FieldByName('DET_DESESP').AsFloat,

                                           IIF(qryItens.FieldByName( 'DET_PROEMB' ).AsString = 'S',
                                               qryItens.FieldByName( 'DET_PREEMB' ).AsFloat,
                                               qryItens.FieldByName('DET_TOTITE').AsFloat - qryItens.FieldByName('DET_DESESP').AsFloat) )) Then

        Begin
          Abort;
        End;

      pChecaInterrupcao;

        If qryItens.FieldByName( 'DET_PROEMB' ).AsString = 'S' Then
        Begin
          fltTotalImpr := fltTotalImpr + fFormataFloat(qryItens.FieldByName('DET_QTDITE').AsFloat *
                                                       (qryItens.FieldByName( 'DET_PREEMB' ).AsFloat / qryItens.FieldByName( 'DET_QTDITE' ).AsFloat), 2);
        End
        Else
        Begin
          fltTotalImpr := fltTotalImpr + VS_objFiscal.fRetTotalEcf(qryItens.FieldByName('DET_QTDITE').AsFloat,
                                                                   qryItens.FieldByName('DET_UNITAR').AsFloat,
                                                                   qryItens.FieldByName('DET_TOTITE').AsFloat,
                                                                   qryItens.FieldByName('DET_DESESP').AsFloat);
        End;

        pChecaInterrupcao;
      End;

      qryItens.Next;
      pChecaInterrupcao;
    End;
end;

procedure TImpressorCupomNovo.pTotalizaEFechaCupom;
begin
  {*****************************************}
  {* REGISTRA ACRES. DESC. (TOTALIZA ITENS)*}
  {**************************************AF*}
  If Not VS_objFiscal.fRegistraAcrDes('D', '$', FloatToStr(fltDesEsp), fltTotal, fltTotalImpr) Then
    Abort;

  pChecaInterrupcao;

  pDisparaEventoImpressaoModalidades(fltTotal);

  pFecharCupom;
end;

procedure TImpressorCupomNovo.pInterromper;
begin
  FInterromper := True;
end;

procedure TImpressorCupomNovo.pSetDesconto(fltValor, fltTotGer: Double);
begin
  Self.fltDesEsp := fltValor;
  Self.fltTotal := fltTotGer;
  Self.fltTotalImpr := fltTotGer+fltValor;
end;

{ TImpressorCupomNovo }

procedure TImpressorCupom.pAdicionaParametro(objParametro: TObject);
begin
  SetLength(FParametros, Length(FParametros)+1);
  FParametros[Length(FParametros)-1] := objParametro;
end;

procedure TImpressorCupom.pAdicionarModalidade(const strCodMod, strDesMod,
  strVencim: String; const fltValMod: Double);
begin
  If (Assigned(cdsModalidades)) Then
  Begin
    cdsModalidades.Append;
    cdsModalidades.FieldByName('CODMOD').AsString := strCodMod;
    cdsModalidades.FieldByName('DESMOD').AsString := strDesMod;
    cdsModalidades.FieldByName('VALMOD').AsFloat := fltValMod;
    cdsModalidades.FieldByName('VENCIM').AsString := strVencim;
    cdsModalidades.Post;
  End;
end;

procedure TImpressorCupom.pCarregarItensDocumento(qryItens: TUniQuery;
  strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String);
  procedure pAbreQuery;
  begin
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('CODCLI').AsString := strCodCli;
    qryItens.ParamByName('SERIE_').AsString := strSerie;
    qryItens.Open;
  end;
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add(fGetSqlitens('MOVDET'));
  pAbreQuery;

  If qryItens.IsEmpty Then
  Begin
    qryItens.SQL.Clear;
    qryItens.SQL.Add(fGetSqlitens('NOTDET'));
    pAbreQuery;
  End;  
end;

function TImpressorCupom.fGetSqlItens(strTabela: String): String;
  Var
    strTabGer: String;
begin
  strTabGer := IIF(strTabela = 'MOVDET', 'MOVGER', 'NOTGER');

  Result := Result + ' SELECT ';
  Result := Result + '   ' + strTabela + '.AUTOINCREM AS AUTINC, ';
  Result := Result + '   DET_NUM_PD, ';
  Result := Result + '   DET_CODITE, ';
  Result := Result + '   DET_CODACA, ';
  Result := Result + '   DET_EMPACA, ';
  Result := Result + '   CONCAT(IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DET_DESCRI, ';
  Result := Result + '   DET_UNIDAD, ';
  Result := Result + '   DET_QTDITE, ';
  Result := Result + '   DET_UNITAR, ';
  Result := Result + '   DET_PREEMB, ';
  Result := Result + '   DET_PROEMB, ';
  Result := Result + '   DET_CODFIS, ';
  Result := Result + '   DET_ALQICM, ';
  Result := Result + '   DET_CODMAR, ';
  Result := Result + '   DET_DESESP, ';
  Result := Result + '   DET_IDEPRO, ';
  Result := Result + '   DET_TOTITE, ';
  Result := Result + '   GER_VLRCON, ';
  Result := Result + '   DET_NUMLOT, ';
  Result := Result + '   ' + QuotedStr(strTabGer) + ' AS TABGER ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + strTabela + ' ';
  Result := Result + '   JOIN ' + strTabGer + ' ON ' + strTabGer + '.AUTOINCREM = ' + strTabela + '.DET_SEQGER ';
  Result := Result + ' WHERE ';
  Result := Result + '   DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '   DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '   DET_CODEMP = :CODEMP AND ';
  Result := Result + '   DET_CODCLI = :CODCLI AND ';
  Result := Result + '   IFNULL(DET_SERIE_, "") = :SERIE_ ';
end;

function TImpressorCupom.fCupomJaImpresso(strTabela, strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_IMPRES ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ' + strTabela + ' ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.Open;

  if qryAux.FieldByName('GER_IMPRES').DataType = ftInteger then
    Result :=  (Not qryAux.IsEmpty) And (qryAux.FieldByName('GER_IMPRES').AsInteger = 1)
  else
    Result :=  (Not qryAux.IsEmpty) And (qryAux.FieldByName('GER_IMPRES').AsBoolean);

  FreeAndNil(qryAux);
end;

procedure TImpressorCupom.pEncontraModalidadeDinheiro(Var strCodMod, strDesMod: String;
  strCodEcf: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  ECFMOD.ECF_CODMOD, ');
  qryAux.SQL.Add('  ECFMOD.ECF_DESMOD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ECFMOD ');
  qryAux.SQL.Add('JOIN CADECF ON CADECF.ECF_CODECF = ECFMOD.ECF_CODECF ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  CADECF.ECF_CODECF = :CODECF AND ');
  qryAux.SQL.Add('  ECFMOD.ECF_IDENTI = "1" ');

  qryAux.ParamByName('CODECF').AsString := strCodEcf;
  qryAux.Open;

  If qryAux.IsEmpty Then
  Begin
    FreeAndNil(qryAux);
    Raise Exception.Create('Não foi encontrada nenhuma modalidade dinheiro para o ECF ' + strCodEcf + #13#10 +
      'Por favor, verifique no cadastro de ECF:' + #13#10 +
      '1) Se o número de série está cadastrado corretamente, ou' + #13#10 +
      '2) Se as modalidades estão cadastradas corretamente.');
  End;

  strCodMod := qryAux.FieldByName('ECF_CODMOD').AsString;
  strDesMod := qryAux.FieldByName('ECF_DESMOD').AsString;

  FreeAndNil(qryAux);
end;

{ TImpressorCupomVelho }

constructor TImpressorCupomVelho.Create(objFiscal: TUntFiscal;
  EventoModalidade: TModalidadeVelhoEvent; fltTotGerSav: Double;
  strObserv: String);
begin
  Self.objFiscal := objFiscal;
  Self.FEventoModalidade := EventoModalidade;

  Self.fltTotGerSav := fltTotGerSav;
  Self.strObserv := strObserv;
end;

procedure TImpressorCupomVelho.pCancelarCupom;
  Var
    strCodErr: String;
begin
  strCodErr := '';
  objFiscal.fCancelaCupom(strCodErr);
end;

procedure TImpressorCupomVelho.pDisparaEventoImpressaoModalidades(
  fltTotal: Double);
  Var
    strCodMod: String;
    strDesMod: String;
    strCodErr: String;
begin
  If Assigned(FEventoModalidade) Then
  Begin
    FEventoModalidade(objFiscal, FParametros);
  End
  Else
  Begin
    pEncontraModalidadeDinheiro(strCodMod, strDesMod, fRetornaCodigoEcfConfigurado);
    If Not objFiscal.fPagamento(strCodErr, strCodMod, strDesMod, fltTotal, False, '') Then
    Begin
      objFiscal.fCancelaCupom( strCodErr );
      fMensagem('ATENÇÃO!', 'Formas de Pagamento: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok'],
        1, False, 1, 0, False, DESLOCAMENTO_MSG);
      Abort;
    End;
  End;
end;

procedure TImpressorCupomVelho.pImprimirCupom(fltTotal: Double; arrMatItens: TMatrizFechamento);
  Var
    cdsItens: TUniClientDataSet;
begin
  cdsItens := fCriaClientDataSet(fltTotal, arrMatItens);
  Try
    pImprimirCupomInterna(cdsItens);
  Finally
    FreeAndNil(cdsItens);
  End;
end;

procedure TImpressorCupomVelho.pImprimirCupom(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie: String);
  Var
    qryItens: TUniQuery;
begin
  qryItens := fCriaQuery(Nil);

  Try
    pCarregarItensDocumento(qryItens, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie);
    pImprimirCupomInterna(qryItens);
  Finally
    FreeAndNil(qryItens);
  End;
End;

procedure TImpressorCupomVelho.pImprimirCupomInterna(qryItens: TDataSet);
  Var
    strCodErr: String;
    fltTotalImpr: Double;
    fltDesEsp: Double;
    fltTotal: Double;
    strAliquo: String;
    strCodIte: String;
    strDesIte: String;
    blnCupMar: Boolean;
    strCodBar: String;
    blnCodBar: Boolean;
begin
    fltTotalImpr := 0;
    fltDesEsp := 0;

    blnCupMar := fCfgSis('CUPMAR', VarBoolean);
    blnCodBar := fCfgSis('CBCODE', VarBoolean);

    fltTotal := qryItens.FieldByName('GER_VLRCON').AsFloat;
    If Not objFiscal.fAbreCupom( strCodErr, objFiscal.strCgcCpf ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Abertura de Cupom: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok'],
        1, False, 1, 0, False, DESLOCAMENTO_MSG);
      Raise EAbort.CreateHelp('', ERRO_ABERTURA_CUPOM);
    End;

    While Not qryItens.Eof Do
    Begin
      strDesIte := qryItens.FieldByName('DET_DESCRI').AsString;

      If blnCupMar Then
        strDesIte := Concat(strDesIte, ' - ', fRetNomMarca(qryItens.FieldByName('DET_CODMAR').AsString));

      If blnCodBar Then
      Begin
        strCodBar := fRetCodBarMovCdb(qryItens.FieldByName('AUTINC').AsString,
                                      qryItens.FieldByName('DET_CODITE').AsString);

        If Not fEmptyStr(strCodBar) Then
          strCodBar := ' - Cod.Barra: ' + strCodBar;

        strDesIte := Concat(strDesIte, strCodBar);
      End;

      strCodIte := qryItens.FieldByName('DET_CODITE').AsString;
      //Quando configurado para imprimir o codigo do produto acabado
      If (fCfgSis('CODTIN') = '2') And Not fEmptyStr(qryItens.FieldByName('DET_CODACA').AsString) Then
        strCodIte := qryItens.FieldByName('DET_CODACA').AsString + '-' + qryItens.FieldByName('DET_EMPACA').AsString
      Else If (fCfgSis('CODTIN') = '3') And Not fEmptyStr(qryItens.FieldByName('DET_CODACA').AsString) Then
        strCodIte := fRetCodigoUnicoProdutoAcabado(
          qryItens.FieldByName('DET_CODACA').AsString, qryItens.FieldByName('DET_EMPACA').AsString);

      If Not fEmptyStr(qryItens.FieldByName('DET_NUMLOT').AsString) Then
      Begin
        strDesIte := strDesIte + ' - LOTE: ' + Trim(qryItens.FieldByName('DET_NUMLOT').AsString);
      End;

      If qryItens.FieldByName('DET_PROEMB').AsString <> 'S' Then
      Begin
        strAliquo := fCalcAliquota( qryItens.FieldByName('DET_CODFIS').AsString,
                                    qryItens.FieldByName('DET_ALQICM').AsFloat,
                                    objFiscal.strEstCli,
                                    objFiscal.strIesCli,
                                    1);

        If Not (objFiscal.fVendeItem(strCodErr,
                                     qryItens.FieldByName('DET_QTDITE').AsFloat,
                                     qryItens.FieldByName('DET_UNITAR').AsFloat,
                                     strAliquo,
                                     qryItens.FieldByName('DET_DESESP').AsFloat,
                                     fRetSiglaUnidadeIF(qryItens.FieldByName('DET_UNIDAD').AsString),
                                     strCodIte,
                                     strDesIte,
                                     '')) Then
        Begin
          objFiscal.fCancelaCupom( strCodErr );
          fMensagem('ATENÇÃO!', 'Vende Item: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok'],
            1, False, 1, 0, False, DESLOCAMENTO_MSG);
          Abort;
        End;

        fltTotalImpr := fltTotalImpr + objFiscal.fRetTotalImpressora(qryItens.FieldByName('DET_QTDITE').AsFloat,
                                                                     qryItens.FieldByName('DET_UNITAR').AsFloat,
                                                                     qryItens.FieldByName('DET_TOTITE').AsFloat,
                                                                     qryItens.FieldByName('DET_DESESP').AsFloat);

      End;

      qryItens.Next;
    End;

  //If Not objFiscal.fTotalizaItens( strCodErr, fltDesEsp, fltTotalImpr, fStrToFloat(edtTotGer.Text)) Then
  If Not objFiscal.fTotalizaItens( strCodErr, fltDesEsp, fltTotalImpr, fltTotGerSav) Then
  Begin
    objFiscal.fCancelaCupom( strCodErr );
    fMensagem('ATENÇÃO!', 'Totaliza Itens: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok'],
      1, False, 1, 0, False, DESLOCAMENTO_MSG);
    Abort;
  End;

  pDisparaEventoImpressaoModalidades(fltTotal);

  {*****************************************}
  {* TOTALIZA CUPOM                        *}
  {**************************************MA*}
  If Not objFiscal.fTotalizaCupom( strCodErr, strObserv ) Then
  Begin
    objFiscal.fCancelaCupom( strCodErr );
    fMensagem('ATENÇÃO!', 'Totaliza Cupom: ' + #13#10 + objFiscal.fRetMensErro( strCodErr ), ['&Ok'],
      1, False, 1, 0, False, DESLOCAMENTO_MSG);
    Abort;
  End;
end;

{************************************}
{* CALCULA ALIQUOTA                 *}
{*********************************MA*}
function TImpressorCupomVelho.fCalcAliquota(strCodFiscal: String; fltAliquota: Double;
  strEstCli, strIesCli: String; intTipRet: Integer=1): String;
  Var strAliquota: String;
      strCODSTB: String;
      strCODISE: String;
      strCODNIN: String;

      strCodAlq: String;
      fltValAlq: Double;
      strIdeSer: String;
      strCod018: String;
      strCodAtu: String;
      strPriCod: String;
      blnPrimei: Boolean;
      strSql   : String;
      qryGenEcf: TUniQuery;
      strCodEcf: String;
Begin
  qryGenEcf := fCriaQuery(Nil);

  strAliquota := '';
  Result := '';

  With qryGenEcf Do
  Begin

    strSql := '';
    strSql := strSql + ' SELECT * ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADECF ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   ECF_CODECF = :CODECF ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := fRetornaCodigoEcfConfigurado;
    Open;

    If IsEmpty Then
    Begin
      Raise Exception.Create(fMensagemEcfNaoCadastrado(fRetornaCodigoEcfConfigurado));
    End;

    strCODSTB := FieldByName( 'ECF_CODSTB' ).AsString;
    strCODISE := FieldByName( 'ECF_CODISE' ).AsString;
    strCODNIN := FieldByName( 'ECF_CODNIN' ).AsString;
    strCodEcf := FieldByName( 'ECF_CODECF' ).AsString;

    Close;

  End;

  {*****************************************}
  {* ISENTO                                *}
  {**************************************MA*}
  If Pos( strCodFiscal, CST_ISENTO ) > 0 Then
    strAliquota := 'I'
  {*****************************************}
  {* NÃO TRIBUTADO                         *}
  {**************************************AF*}
  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO ) > 0 Then
    strAliquota := 'N'
  {*****************************************}
  {* SUBSTITUICAO                          *}
  {**************************************MA*}
  Else If Pos( strCodFiscal, CST_SUBSTITUICAO ) > 0 Then
    strAliquota := 'F'
  {*****************************************}
  {* SERVICOS                              *}
  {**************************************MA*}
  Else If Pos( strCodFiscal, '_SSS_' ) > 0 Then
    strAliquota := 'S'
  {*****************************************}
  {* TRIBUTADO                             *}
  {**************************************MA*}
  Else
  Begin

    If ( fCfgSis('SIMPAU') = 'S' ) Then
//      strAliquota := FloatToStrF( fCfgSis('ICMSIM', varDouble), ffNumber, 5, 2 )
      strAliquota := FloatToStrF(fRetornaAliquotaIcmsInternaDoEstado(fCadEmp('ESTADO')), ffNumber, 5, 2)
    Else
    Begin

      If ( strEstCli = fCadEmp('ESTADO') ) Or fEmptyStr( strIESCli ) Then
        strAliquota := FloatToStrF( fltAliquota, ffNumber, 5, 2 )
      Else
      Begin

        strAliquota := FloatToStrF( 0.00, ffNumber, 5, 2 );
        If ( strEstCli = fCadEmp('ESTADO') ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 )
        Else If ( Pos( strEstCli, '_PR_RJ_MG_RS_SC_SP_' ) > 0 ) Then
          strAliquota := FloatToStrF( 12.00, ffNumber, 5, 2 )
        Else
          strAliquota := FloatToStrF( 7.00, ffNumber, 5, 2 );

        If fEmptyStr( strIesCli ) And ( Not ( strEstCli = fCadEmp('ESTADO') ) ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 );

      End;

      If ( intTipRet = 2 ) Then
      Begin
        strAliquota := RightStr( '00000' + strAliquota, 5 );
        strAliquota := 'T' + LeftStr( strAliquota, 2 ); 
      End;

    End;

  End;

  {*****************************************}
  {* SE O TIPO DE RETORNO É 1              *}
  {* PROCURA INDICE                        *}
  {**************************************MA*}
  If ( intTipRet = 1 ) Then
  Begin

    {*****************************************}
    {* VERIFICA ALIQUOTA COM CADASTRO DE     *}
    {* IMPRESSORAS FISCAIS                   *}
    {**************************************MA*}
    If strAliquota = 'F' Then
      strAliquota := fPadR( strCODSTB, 2 )
    Else If strAliquota = 'I' Then
      strAliquota := fPadR( strCODISE, 2 )
    Else If strAliquota = 'N' Then
      strAliquota := fPadR( strCODNIN, 2 )
    Else
    Begin

      With qryGenEcf Do
      Begin

        strSql := '';
        strSql := strSql + ' SELECT * ';
        strSql := strSql + ' FROM ';
        strSql := strSql + '   ECFALQ ';
        strSql := strSql + ' WHERE ';
        strSql := strSql + '   ECF_CODECF = :CODECF ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODECF').AsString := strCodEcf;
        Open;

        If IsEmpty() Then
          Exit;
        
        First;

        strCod018 := '';
        strCodAtu := '';
        blnPrimei := True;

        While Not Eof Do
        Begin

          If blnPrimei Then
          Begin
            strPriCod := FieldByName( 'ECF_CODALQ' ).AsString;
            blnPrimei := True;
          End;

          strCodAlq := FieldByName( 'ECF_CODALQ' ).AsString;
          fltValAlq := FieldByName( 'ECF_PERALQ' ).AsFloat;
          strIdeSer := FieldByName( 'ECF_SERVIC' ).AsString;

          If fEmptyStr( strCod018 ) Then
            If FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = FloatToStrF( 18.00, ffNumber, 5, 2 ) Then
              strCod018 := strCodAlq;

          If strAliquota = 'S' Then
          Begin

            If fEmptyStr( strCodAtu ) Then
              strCodAtu := strCodAlq;

          End
          Else
          Begin

            If Pos( strAliquota, 'FIN' ) <= 0 Then
            Begin

              If ( FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = strAliquota ) Then
              Begin
                strCodAtu := strCodAlq;
                Break;
              End;

            End;

          End;

          Next;
        End;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strCod018;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strPriCod;

        strAliquota := strCodAtu;

        Close;

      End;

    End;

  End;

  Result := AnsiReplaceStr( strAliquota, '.', ',' );

  FreeAndNil(qryGenEcf);

End;


function TImpressorCupomVelho.fNumeroCoo: String;
  Var
    strCodErr: String;
begin
  Result := fstrEspaco('', 6);
  objFiscal.fRetornaCoo(Result, strCodErr);
end;

function TImpressorCupomVelho.fNumeroSerie: String;
  Var
    strCodErr: String;
begin
  Result := fstrEspaco('', 20);
  objFiscal.fNumeroSerie(Result, strCodErr);
end;

function TImpressorCupomVelho.fVerificaCupomAberto: Boolean;
begin
  Result := objFiscal.fVerificaCupomAberto;
end;

{ TImpressorDeCupons }

constructor TImpressorDeCupons.Create;
begin
  qryDocs := fCriaQuery(Nil);
  stlProblemas := TStringList.Create;
  blnMostraMsg := True;
end;

destructor TImpressorDeCupons.Destroy;
begin
  FreeAndNil(qryDocs);
  FreeAndNil(stlProblemas);
  inherited;
end;

function TImpressorDeCupons.fAtualizarDadosCupom(impressorCupom: TImpressorCupom): Boolean;
  Var
    qryAux: TUniQuery;
    strTabDet: String;

  procedure pParametrosFiltro;
  begin
    qryAux.ParamByName('NUMDOC').AsString := qryDocs.FieldByName('GER_NUMDOC').AsString;
    qryAux.ParamByName('ESPDOC').AsString := qryDocs.FieldByName('GER_ESPDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryDocs.FieldByName('GER_CODEMP').AsString;
    qryAux.ParamByName('CODCLI').AsString := qryDocs.FieldByName('GER_CODCLI').AsString;
    qryAux.ParamByName('SERIE_').AsString := qryDocs.FieldByName('GER_SERIE_').AsString;
  end;
begin
  qryAux := fCriaQuery(Nil);
  fStartTransaction;
  Result:= True;

  Try
    Try
      strTabDet := IIF(qryDocs.FieldByName('NOMTAB').AsString='MOVGER', 'MOVDET', 'NOTDET');
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add(strTabDet);
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  DET_DTAENT = :DTAENT ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  DET_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  DET_CODCLI = :CODCLI AND ');
      qryAux.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ ');

      qryAux.ParamByName('DTAENT').AsDateTime := VS_Date;
      pParametrosFiltro;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add(qryDocs.FieldByName('NOMTAB').AsString);
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  GER_IMPRES = 1, ');
      qryAux.SQL.Add('  GER_DTAENT = :DTAENT ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
      qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

      qryAux.ParamByName('DTAENT').AsDateTime := VS_Date;
      pParametrosFiltro;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add('  CADFIS ');
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  FIS_NUMSER = :NUMSER, ');
      qryAux.SQL.Add('  FIS_NUMCOO = :NUMCOO, ');
      qryAux.SQL.Add('  FIS_DTAENT = :DTAENT ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
      qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

      qryAux.ParamByName('DTAENT').AsDateTime := VS_Date;
      qryAux.ParamByName('NUMSER').AsString := impressorCupom.fNumeroSerie;
      qryAux.ParamByName('NUMCOO').AsString := impressorCupom.fNumeroCoo;
      pParametrosFiltro;
      qryAux.ExecSQL;

      FreeAndNil(qryAux);
      fCommit;
    Except
      On E: Exception Do
      Begin
        Result:= False;
        fRollBack;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TImpressorDeCupons.pCarregaCuponsPendentes;
  function fGetSql(const strTabela: String): String;
  begin
    Result := 'SELECT ' +
              '  GER_NUMDOC,  ' +
              '  GER_ESPDOC, ' +
              '  GER_CODEMP, ' +
              '  GER_CODCLI, ' +
              '  GER_SERIE_, ' +
              '  GER_VLRCON, ' +
              '  IFNULL(GER_NOMCON, CLI_NOMCLI) AS GER_NOMCLI, ' +
              '  GER_TOTICM, ' +
              '  "' + strTabela + '" AS NOMTAB ' +
              'FROM ' +
              '  ' + strTabela + ' ' +
              '  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ' +
              'WHERE ' +
              '  GER_ESPDOC IN ("IF", "IV") AND ' +
              '  GER_CODEMP = :CODEMP AND ' +
              '  GER_IMPRES = 0 AND ' +
              '  GER_DTAENT < :DTABAS ';

  end;
begin
  qryDocs.SQL.Clear;
  qryDocs.SQL.Add(fGetSql('MOVGER') + ' UNION ALL ' + fGetSql('NOTGER'));

  qryDocs.ParamByName('CODEMP').AsString   := VS_strCodEmp;
  qryDocs.ParamByName('DTABAS').AsDateTime := VS_Date;
  qryDocs.Open;
end;

procedure TImpressorDeCupons.pImprimeCupomAtual;
  Var
    impressorCupom: TImpressorCupom;
    objEcfVelho: TUntFiscal;

    blnErroAbertura: Boolean;
begin
  blnErroAbertura := False;

  If Assigned(VS_objFiscal) Then
  Begin
    VS_objFiscal.strNumDoc := qryDocs.FieldByName('GER_NUMDOC').AsString;
    VS_objFiscal.strCodCli := qryDocs.FieldByName('GER_CODCLI').AsString;
    VS_objFiscal.strNomCli := qryDocs.FieldByName('GER_NOMCLI').AsString;
    VS_objFiscal.strNomVen := 'IMPRESSO AUTOMATICAMENTE';

    impressorCupom := TImpressorCupomNovo.Create(VS_objFiscal, Nil);
  End
  Else
  Begin
    objEcfVelho := fCriaEcfModeloVelho;
    If Not Assigned(objEcfVelho) Then
    Begin
      Raise EErroNaImpressaoException.Create('Não foi possível conectar ao ECF. ' +
        'Verifique se a impressora está ligada e está configurada corretamente no sistema.');
    End;
    impressorCupom := TImpressorCupomVelho.Create(objEcfVelho, Nil,
      qryDocs.FieldByName('GER_VLRCON').AsFloat, fGeraObservacoes(objEcfVelho));
  End;

  Try
    Try
      impressorCupom.pImprimirCupom(qryDocs.FieldByName('GER_NUMDOC').AsString,
                                    qryDocs.FieldByName('GER_ESPDOC').AsString,
                                    qryDocs.FieldByName('GER_CODEMP').AsString,
                                    qryDocs.FieldByName('GER_CODCLI').AsString,
                                    qryDocs.FieldByName('GER_SERIE_').AsString);

      If Not fAtualizarDadosCupom(impressorCupom) Then
      Begin
        pLogarECancelar(impressorCupom, Nil);
      End;
    Except
      On E: EAbort Do
      Begin
        pLogarECancelar(impressorCupom, E);
        If (E.HelpContext = ERRO_ABERTURA_CUPOM) Then
        Begin
          blnErroAbertura := True;
        End;
      End;

      On E: Exception Do
      Begin
        pLogarECancelar(impressorCupom, Nil);
      End;
    End;
  Finally
    FreeAndNIl(impressorCupom);
  End;

  If blnErroAbertura Then
  Begin
    Raise EInterrupcaoException.Create('Erro na abertura do cupom. Verifique se a impressora está ligada e se não há redução Z pendente.');
  End;

end;

procedure TImpressorDeCupons.pLogarECancelar(impressorCupom: TImpressorCupom; ExcecaoAbort: EAbort);
begin
  stlProblemas.Add(qryDocs.FieldByName('GER_NUMDOC').AsString + '-' +
                   qryDocs.FieldByName('GER_ESPDOC').AsString + '-' +
                   qryDocs.FieldByName('GER_CODEMP').AsString + ' ' +
                   'CLIENTE: ' + qryDocs.FieldByName('GER_CODCLI').AsString + '-' +
                   qryDocs.FieldByName('GER_NOMCLI').AsString);
  If (Not Assigned(ExcecaoAbort)) Or (ExcecaoAbort.HelpContext <> ERRO_ABERTURA_CUPOM) Then
  Begin
    impressorCupom.pCancelarCupom;
  End;
end;

procedure TImpressorDeCupons.SetMostraMsg(blnMostra: Boolean);
begin
  blnMostraMsg := blnMostra;
end;

function TImpressorDeCupons.fGeraObservacoes(ecfFiscal: TUntFiscal): String;
  Var
    strNumDoc: String;
    strCodCli: String;
    strCliNom: String;
    fltTotIcm: Double;
    intLinMsg: Integer;
    strChrIni: String;
    strSerie_: String;
    strCodEmp: String;
    intQtdNps: Integer;

  procedure pAddMensagem(strValue: String);
  begin
    If (Not fEmptyStr(strValue)) Then
    Begin
      Result := Result + strValue;
      intLinMsg := intLinMsg + 1;
    End;
  end;

  function fTemLinhaDisponivel: Boolean;
  begin
    Result := (intLinMsg < fCfgSis('QMXMCU', varInteger));
  end;

begin
  intLinMsg := 0;
  strNumDoc := qryDocs.FieldByname('GER_NUMDOC').AsString;
  strCodCli := qryDocs.FieldByname('GER_CODCLI').AsString;
  strCliNom := qryDocs.FieldByname('GER_NOMCLI').AsString;
  fltTotIcm := qryDocs.FieldByname('GER_TOTICM').AsFloat;
  strSerie_ := qryDocs.FieldByname('GER_SERIE_').AsString;
  strCodEmp := qryDocs.FieldByName('GER_CODEMP').AsString;

  Result := '';

  If Pos( ecfFiscal.fGetModEcf, 'SWEDA-9000' ) > 0 Then
  Begin
    strChrIni := '0';

    If fCfgSis('IMPCAC', varBoolean) Then
      pAddMensagem('2' + fPadR( 'Cupom Fiscal: ' + strNumDoc + '-IF', 40 ));

    pAddMensagem('0' + fPadR( LeftStr( strCliNom, 31 ) + '-' + strCodCli, 40 ));

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      pAddMensagem('0' + fPadR( 'MINAS LEGAL', 40))
    Else
    If fCfgSis('CUPMAN', varBoolean) Then
    Begin
      pAddMensagem('0' + fPadR( 'VALIDO PARA O CUPOM MANIA', 40));
      pAddMensagem('0' + fPadR( 'ICMS DEVIDO: ' + FormatFloat('#0.00', fltTotIcm), 40));
    End;
    pAddMensagem('0' + fPadR( 'IMPRESSO AUTOMATICAMENTE', 40 ));
  End
  Else If Pos( ecfFiscal.fGetModEcf, 'SWEDA-7000' ) > 0 Then
  Begin
    strChrIni := '0';

    If fCfgSis('IMPCAC', varBoolean) Then
      pAddMensagem('0' + fPadR( 'Cupom Fiscal: ' + strNumDoc + '-IF', 40 ));

    pAddMensagem('0' + fPadR( LeftStr( strCliNom, 31 ) + '-' + strCodCli, 40 ));

    If fCfgSis('SIMNAC') = 'S' Then
      pAddMensagem('0' + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 40 ));

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      pAddMensagem('0' + fPadR( 'MINAS LEGAL', 40))
    Else
    If fCfgSis('CUPMAN', varBoolean) Then
      pAddMensagem('0' + fPadR( 'VALIDO P/CUPOM MANIA.ICMS DEV: ' + FormatFloat('#0.00', fltTotIcm), 40));

    pAddMensagem('0' + fPadR( 'IMPRESSO AUTOMATICAMENTE', 40 ));
  End
  Else
  Begin
    strChrIni := '';

    If fCfgSis('IMPCAC', varBoolean) Then
      pAddMensagem(fPadR( 'Cupom Fiscal: ' + strNumDoc + '-IF', 48 ));

    pAddMensagem(fPadR( LeftStr( strCliNom, 31 ) + '-' + strCodCli, 48 ));

    If fCfgSis('SIMNAC') = 'S' Then
      pAddMensagem(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48 ));

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      pAddMensagem('0' + fPadR( 'MINAS LEGAL', 40))
    Else
    If fCfgSis('CUPMAN', varBoolean) Then
      pAddMensagem(fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', fltTotIcm), 48));

    pAddMensagem(fPadR( 'IMPRESSO AUTOMATICAMENTE', 48 ));
  End;

  If (fTemLinhaDisponivel) And
     (fCfgSis('UTINPS', varBoolean)) And
     (fGanhouNetpoints(strNumDoc,
                       'IF',
                       strCodEmp,
                       strCodCli,
                       strSerie_,
                       intQtdNps)) Then
  Begin
    pAddMensagem(strChrIni + Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]));
  End;
end;

function TImpressorDeCupons.fProblemas: TStringList;
begin
  Result := TStringList.Create;
  Result.Assign(stlProblemas);
end;

procedure TImpressorDeCupons.pImrpimeCupons;
  function fCupomOriginadoF3CheckOut(strNumDoc, strCodEmp: String): Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  Begin
    Result := False;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DISTINCT DET_IND_PD AS ORI_PD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '    DET_ESPDOC = "IF" AND ';
    strSQL := strSQL + '    DET_CODEMP = :CODEMP ';

    Try
      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('ORI_PD').AsInteger = -1;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;
begin
  If fLock_Unlock('CUPONS_ATRASADOS', True, False) Then
  Begin
    Screen.Cursor := crHourGlass;
    Try
      Try
        stlProblemas.Clear;
        pCarregaCuponsPendentes;

        If (Not qryDocs.IsEmpty) And (blnMostraMsg) Then
        Begin
          fMensagem('ATENÇÃO!', 'Há cupons não impressos do dia anterior. Eles serão impressos automáticamente agora.', ['&Ok'],
            1, False, 1, 0, False, DESLOCAMENTO_MSG);
        End;

        qryDocs.First;
        While (Not qryDocs.Eof) Do
        Begin
          If fCupomOriginadoF3CheckOut(qryDocs.FieldByName('GER_NUMDOC').AsString,
                                       qryDocs.FieldByName('GER_CODEMP').AsString) Then
          Begin
            If Assigned(VS_objFiscal) Then
              VS_objFiscal.blnApenasItensCheckOutF11 := True;
          End;

          pImprimeCupomAtual;

          If Assigned(VS_objFiscal) Then
            VS_objFiscal.blnApenasItensCheckOutF11 := False;

          qryDocs.Next;
        End;
      Except
        On E: EInterrupcaoException Do
        Begin
          pMensagemOk(E.Message);
        End;
      End;
    Finally
      Screen.Cursor := crDefault;
      fLock_Unlock('CUPONS_ATRASADOS', False, False);
    End;
  End;
end;

end.

