unit untVerificadorDeCupons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, StdCtrls, Buttons, ExtCtrls, Mask, FilenameEditFocus,
  Uni, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, ComCtrls, Menus, untFuncFat,
  BitBtnLockedIncrem, Math, Types, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, untTypesSistema,
  Datasnap.DBClient;

Type
  VerificacaoException = class(Exception);

type
  TStatus = (st400, st405, stOutrosRegistros, st460, st470, st490);
  TTipoDivergencia = (tpItemAutcomNaoEcf, tpItemEcfNaoAutcom);

Type
  TDadosItem = Record
    strCodIte: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    blnUtilizado: Boolean;
  End;

type
  TfrmVerificadorDeCupons = class(TfrmPai)
    pnlCentro: TPanel;
    Label1: TLabel;
    pnlRelatorio: TPanel;
    dbgRelatorio: TDBGridCitel;
    cdsDivergencias: TUniClientDataSet;
    cdsDivergenciasNUMSER: TStringField;
    cdsDivergenciasNUMCOO: TStringField;
    cdsDivergenciasCODITE: TStringField;
    cdsDivergenciasDIVERGENCIA: TStringField;
    dtsDivergencia: TDataSource;
    cdsDivergenciasDTAENT: TDateField;
    cdsDivergenciasQTDITE: TFloatField;
    cdsDivergenciasUNITAR: TFloatField;
    pgbProgresso: TProgressBar;
    cdsDivergenciasSUGESTAO: TStringField;
    lblSugestao: TLabel;
    cdsDivergenciasCOR: TIntegerField;
    btnGerarCupomEspecial: TBitBtnLocked;
    cdsDivergenciasGERAIF: TIntegerField;
    cdsDivergenciasCPF: TStringField;
    cdsDivergenciasNOME: TStringField;
    btnImportar: TBitBtnLocked;
    edtArquivo: TFilenameEditFocus;
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgRelatorioDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure cdsDivergenciasAfterScroll(DataSet: TDataSet);
    procedure dbgRelatorioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgRelatorioDblClick(Sender: TObject);
    procedure btnGerarCupomEspecialClick(Sender: TObject);
  private
    { Private declarations }
    status: TStatus;
    strNumeroSerie: String;
    dtaDtaAtual: TDateTime;
    strSituacaoDocumento: String;
    strNumeroCoo: String;
    fltValorDocumento: Double;
    arrItens: Array Of TDadosItem;
    strNumCooAnterior: String;
    strCpfConsumidor: String;
    strNomeConsumidor: String;

    corInicial: TColor;
    corAtual: TColor;

    procedure pProcessaArquivo;
    procedure pInicializaVariaveis;
    procedure pProcessaLinhaAtual(const strLinha: String;
      const strRegistroDaFrente: String);

    function fRetRegistro(const strLinha: String): String;
    function fCampoDataSped(const strLinha: String;
      const intColuna: Integer): TDateTime;
    function fCampoValorSped(const strLinha: String;
      const intColuna: Integer): Double;

    procedure pInicializaDadosCupom;
    procedure pAdicionaItem(const strLinha: String);
    function fGetValorLinhaSped(strLinha: String;
      intColuna: Integer): String;

    procedure pRealizaTarefaDocumentoCancelado;
    procedure pRealizaTarefaDocumentoCadastrado;
    procedure pGravarCupomEspecial;
    procedure pCarregaDadosClienteConsumidor(fatVenda: TFatVenda);
    procedure pCarregaDadosItem(qryItens: TUniQuery; strCodIte: String);
    procedure pAtualizaDadosCupomNoLivro(fatVenda: TFatVenda;
      strNumCoo: String; dtaDtaDoc: TDateTime);
    procedure pAcertaDadosDoDocumento(fatVenda: TFatVenda;
      dtaDtaDoc: TDateTime);
    procedure pGravaDivergencia(strCodIte: String; fltQtdIte, fltUnitar: Double;
      tpDivergencia: TTipoDivergencia);
    function fItemEstaNoSped(qryItens: TUniQuery): Boolean;
    function fCupomJaFoiGerado: Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, StrUtils, untFuncFatTypes, untFuncoes, untMemo, System.UITypes;

{$R *.dfm}

procedure TfrmVerificadorDeCupons.btnGerarCupomEspecialClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma a geração de cupom especial?', ['&Sim', '&Não']) = 2 Then
    Exit;

  If fCupomJaFoiGerado Then
  Begin
    fMensagem('', 'O cupom para este Número de Série e COO já foi gerado!', ['&Ok']);
    Exit;
  End;

  btnGerarCupomEspecial.Enabled := False;
  Screen.Cursor := crHourGlass;
  Try
    pGravarCupomEspecial;
  Except
    On E: VerificacaoException Do
    Begin
      MessageDlg(E.Message, mtInformation, [mbOk], 0);
    End;
  End;
  Screen.Cursor := crDefault;
  btnGerarCupomEspecial.Enabled := True;
end;

function TfrmVerificadorDeCupons.fCupomJaFoiGerado: Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CADFIS WHERE FIS_NUMSER = :NUMSER AND FIS_NUMCOO = :NUMCOO');
  qryAux.ParamByName('NUMSER').AsString := cdsDivergenciasNUMSER.AsString;
  qryAux.ParamByName('NUMCOO').AsString := cdsDivergenciasNUMCOO.AsString;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

procedure TfrmVerificadorDeCupons.pGravarCupomEspecial;
  Var
    strNumCoo: String;
    dtaDtaDoc: TDateTime;
    fatVenda: TFatVenda;

    qryDadosItens: TUniQuery;
    forTin: TForTin;
    recMadeira: TDadosMadeira;
begin
  FillChar(forTin, SizeOf(TForTin), #0);
  FillChar(recMadeira, SizeOf(TDadosMadeira), #0);
  strNumCoo := cdsDivergencias.FieldByName('NUMCOO').AsString;
  dtaDtaDoc := cdsDivergencias.FieldByName('DTAENT').AsDateTime;

  cdsDivergencias.Locate('NUMCOO', strNumCoo, []);

  pCriarCdsVenda(Self);
  qryDadosItens := fCriaQuery(Self);

  fatVenda := TFatVenda.CreateInstance('VN');
  fatVenda.strOpcDocTrue  := 'VI';
  fatVenda.strNomeForm := 'frmFatVendas';
  fatVenda.strEspDoc := 'IF';
  fatVenda.blnCupEsp := True;
  fatVenda.strCodVen := strLoginUsuarioLogado;
  fatVenda.strCodDig := strLoginUsuarioLogado;
  fatVenda.strConPag := '01000';
  pCarregaDadosClienteConsumidor(fatVenda);

  fatVenda.strCliOri := cdsDivergenciasNOME.AsString;
  fatVenda.strCliNom := cdsDivergenciasNOME.AsString;
  fatVenda.strCliCgc := cdsDivergenciasCPF.AsString;

  While (Not cdsDivergencias.Eof) And
        (strNumCoo = cdsDivergencias.FieldByName('NUMCOO').AsString)  Do
  Begin

    If cdsDivergenciasGERAIF.AsInteger = 1 Then
    Begin
      pCarregaDadosItem(qryDadosItens, cdsDivergenciasCODITE.AsString);

      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
        Nil, 'NOR',
        qryDadosItens.FieldByName('ITE_CODGRU').AsString,
        cdsDivergenciasCODITE.AsString,
        qryDadosItens.FieldByName('ITE_DESITE').AsString,
        qryDadosItens.FieldByName('ITE_DESITE').AsString,
        '',
        qryDadosItens.FieldByName('ITE_CODUNI').AsString,
        qryDadosItens.FieldByName('ITE_CODUNI').AsString,
        qryDadosItens.FieldByName('ITE_CODMAR').AsString,
        qryDadosItens.FieldByName('ITE_CODFOR').AsString,
        '',
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        0,
        cdsDivergenciasQTDITE.AsFloat,
        cdsDivergenciasQTDITE.AsFloat * cdsDivergenciasUNITAR.AsFloat,
        'S',
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasQTDITE.AsFloat * cdsDivergenciasUNITAR.AsFloat,
        'N',
        0,
        0,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasUNITAR.AsFloat,
        0,
        0,
        qryDadosItens.FieldByName('ITE_INCPIS').AsString,
        0,
        0,
        0,
        '',
        '',
        '',
        0,
        0,
        '',
        0,
        0,
        0,
        0,
        qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
        '',
        '',
        '',
        '',
        0,
        '',
        0,
        0,
        0,
        0,
        0,
        '',
        '',
        0,
        0,
        qryDadosItens.FieldByName('ITE_CODABF').AsString,
        0,
        0,
        'N',
        0,
        0,
        0,
        0,
        '',
        0,
        '',
        0,
        0,
        '',
        '',
        '',
        0,
        0,
        0,                
        '',
        '',
        0,
        0,
        '',
        '',
        '',
        0,
        '',
        '',
        '',
        0,
        0,
        0,
        '',
        '',
        'N',
        '',
        '',
        '',
        0,
        0,
        '',
        '',
        '',
        False,
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        '',
        '',
        '',
        '1',
        0,
        0,
        '',
        0,
        '',
        0,
        '',
        '',
        'N',
        '',
        0,
        0,
        0,
        0,
        'N',
        '',
        cdsDivergenciasUNITAR.AsFloat,
        cdsDivergenciasQTDITE.AsFloat * cdsDivergenciasUNITAR.AsFloat,
        0,
        0,
        0,
        0,
        0,
        0,
        forTin,
        '',
        '',
        '',
        '',
        '',
        False,
        '',
        '',
        0,
        '',
        '',
        '',
        0,
        0,
        0,
        '',
        0,
        False,
        '',
        '',
        '',        
        0,
        0,
        '',
        '',
        recMadeira,
        0,
        0,
        0,
        '',
        0,
        '',
        '',
        0,
        0,
        '',
        '',
        0,
        '',
        'N',
        0,
        0,
        0,
        False,
        False,
        'N',
        '',
        0,
        0,
        '',
        'N',
        0,
        '',
        '',
        '',
        '',
        qryDadosItens.FieldByName('ITE_EXCIPI').AsString);
    End;

    cdsDivergencias.Next;
  End;

  fatVenda.blnComTansacao := False;
  fatVenda.pPreencheMatrizFechamento;
  fatVenda.pCalculaTotGer;

  fStartTransaction;
  Try
    If fatVenda.fGravaArquivos Then
    Begin
      pAtualizaDadosCupomNoLivro(fatVenda, strNumCoo, dtaDtaDoc);
      pAcertaDadosDoDocumento(fatVenda, dtaDtaDoc);
      fCommit;
      fMensagem('', 'Cupom especial ' + fatVenda.strNumDoc + ' gerada com sucesso!', ['&Ok']);
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      fMensagem('', 'Houve um erro ao gerar a nota especial: ' + E.Message, ['&Ok']);
    End;
  End;

  FreeAndNil(fatVenda);
end;

procedure TfrmVerificadorDeCupons.pAtualizaDadosCupomNoLivro(fatVenda: TFatVenda;
  strNumCoo: String; dtaDtaDoc: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  FIS_DTADOC = :DTAENT, ');
  qryAux.SQL.Add('  FIS_NUMSER = :NUMSER, ');
  qryAux.SQL.Add('  FIS_NUMCOO = :NUMCOO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  FIS_TIP_FC = "C" AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  qryAux.ParamByName('NUMSER').AsString := strNumeroSerie;
  qryAux.ParamByName('NUMCOO').AsString := strNumCoo;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmVerificadorDeCupons.pAcertaDadosDoDocumento(fatVenda: TFatVenda;
  dtaDtaDoc: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE NOTGER SET ');
  qryAux.SQL.Add('  GER_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  GER_IMPRES = 1 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  GER_TIP_FC = "C" AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE NOTDET SET ');
  qryAux.SQL.Add('  DET_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  DET_IMPRES = 1 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  DET_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  DET_TIP_FC = "C" AND ');
  qryAux.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmVerificadorDeCupons.pCarregaDadosClienteConsumidor(fatVenda: TFatVenda);
  Var
    qryCli: TUniQuery;
begin
  qryCli := fCriaQuery(Self);
  qryCli.SQL.Add('SELECT ');
  qryCli.SQL.Add('  CLI_CODCLI, CLI_NOMCLI, CLI_NOMCLI, CLI_ENDNUM, CLI_ENDCOM, ');
  qryCli.SQL.Add('  CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM, CLI_BAIRRO, CLI_C_E_P_, ');
  qryCli.SQL.Add('  CLI_CODCID, CLI_FONE01, CLI_EMAIL3, CLI_EMAIL2, CLI_CLUFID, ');
  qryCli.SQL.Add('  CLI_CLIFID, CLI_CODATI, CLI_CODATI, CLI_NUMR_G, CLI_C_G_C_, ');
  qryCli.SQL.Add('  CLI_OBSERV, CLI_CODEAC ');
  qryCli.SQL.Add('FROM ');
  qryCli.SQL.Add('  CADCLI ');
  qryCli.SQL.Add('WHERE ');
  qryCli.SQL.Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" LIMIT 1');
  qryCli.Open;

  If qryCli.IsEmpty Then
    Raise VerificacaoException.Create('Cliente consumidor não cadastrado. Favor cadastrar antes de continuar.');

  fatVenda.strCodCli := qryCli.FieldByName('CLI_CODCLI').AsString;

  fatVenda.strCliNum := qryCli.FieldByName('CLI_ENDNUM').AsString;
  fatVenda.strCliCom := qryCli.FieldByName('CLI_ENDCOM').AsString;
  fatVenda.strCliEnd := qryCli.FieldByName('CLI_ENDERE').AsString + ', ' +
                        qryCli.FieldByName('CLI_ENDNUM').AsString + '  ' +
                        qryCli.FieldByName('CLI_ENDCOM').AsString;

  fatVenda.strCliBai := qryCli.FieldByName('CLI_BAIRRO').AsString;
  fatVenda.strCliCep := qryCli.FieldByName('CLI_C_E_P_').AsString;
  fatVenda.strCodCid := qryCli.FieldByName('CLI_CODCID').AsString;
  fatVenda.strCliTel := qryCli.FieldByName('CLI_FONE01').AsString;
  fatVenda.strCliEma := qryCli.FieldByName('CLI_EMAIL3').AsString;
  fatVenda.strCliEm2 := qryCli.FieldByName('CLI_EMAIL2').AsString;
  fatVenda.strCluFid := qryCli.FieldByName('CLI_CLUFID').AsString;
  fatVenda.strCliFid := qryCli.FieldByName('CLI_CLIFID').AsString;

  fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
  fatVenda.strCliEst := fRetNomCidade(fatVenda.strCodCid, 1);

  fatVenda.strCliAti := qryCli.FieldByName('CLI_CODATI').AsString;
  fatVenda.blnConstr := (fAtividadeConstrutora(qryCli.FieldByName('CLI_CODATI').AsString));
  fatVenda.strCli_Rg := qryCli.FieldByName('CLI_NUMR_G').AsString;

  fatVenda.strObserv := qryCli.FieldByName('CLI_OBSERV').AsString;

  fatVenda.strCliDAc := qryCli.FieldByName('CLI_CODEAC').AsString;

  FreeAndNil(qryCli);
end;

procedure TfrmVerificadorDeCupons.pCarregaDadosItem(qryItens: TUniQuery;
  strCodIte: String);
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  ITE_CODGRU, ');
  qryItens.SQL.Add('  ITE_DESITE, ');
  qryItens.SQL.Add('  ITE_CODUNI, ');
  qryItens.SQL.Add('  ITE_CODMAR, ');
  qryItens.SQL.Add('  ITE_CODFOR, ');
  qryItens.SQL.Add('  ITE_INCPIS, ');
  qryItens.SQL.Add('  ITE_CLAIPI, ');
  qryItens.SQL.Add('  ITE_EXCIPI, ');
  qryItens.SQL.Add('  ITE_CODABF  ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  ITE_CODITE = :CODITE ');

  qryItens.ParamByName('CODITE').AsString := strCodIte;
  qryItens.Open;
end;

procedure TfrmVerificadorDeCupons.btnImportarClick(Sender: TObject);
begin
  inherited;
  pProcessaArquivo;
end;

procedure TfrmVerificadorDeCupons.pProcessaArquivo;
  Var
    intContador: Integer;
    stlArquivo: TStringList;
    strRegistroDaFrente: String;
begin

  edtArquivo.Text := AnsiReplaceStr(edtArquivo.Text, '"', '');
  If Not FileExists(edtArquivo.Text) Then
  Begin
    fMensagem('', 'Este arquivo não existe.', ['&Ok']);
    Exit;
  End;

  pInicializaVariaveis;
  cdsDivergencias.EmptyDataSet;

  stlArquivo := TStringList.Create;
  stlArquivo.LoadFromFile(edtArquivo.Text);
  pgbProgresso.Max := stlArquivo.Count;
  pgbProgresso.Position := 0;

  Try
    cdsDivergencias.DisableControls;
    For intContador := 0 To stlArquivo.Count -1 Do
    Begin
      strRegistroDaFrente := '';
      If (intContador < stlArquivo.Count -1) Then
        strRegistroDaFrente := fRetRegistro(stlArquivo[intContador+1]);

      pProcessaLinhaAtual(stlArquivo[intContador], strRegistroDaFrente);
      pgbProgresso.StepBy(1);

      Application.ProcessMessages;
    End;

    cdsDivergencias.First;
    fMensagem('', 'Verificação Concluída.' + #13#10 +
      'Quando estiver acertando movimentação de SPED, NÃO EMITA CUPONS NO ECF para acertar movimento.', ['&Ok']);
    cdsDivergencias.EnableControls;
  Except
    On E: VerificacaoException Do
    Begin
      MessageDlg(E.Message, mtWarning, [mbOk], 0);
    End;
  End;

  FreeAndNil(stlArquivo);
end;

procedure TfrmVerificadorDeCupons.pProcessaLinhaAtual(const strLinha: String;
  const strRegistroDaFrente: String);
  Var
    strRegistro: String;
  Const
    COLUNA_DATA_405 = 2;
    COLUNA_VALOR_460 = 6;
begin

  If status = st400 Then
  Begin
    strRegistro := fRetRegistro(strLinha);
    If (strRegistro = 'C400') Then
    Begin
      strNumeroSerie := fGetValorLinhaSped(strLinha, 4);
      status := st405;
    End
    Else
    Begin
      Raise VerificacaoException.Create('Arquivo Inválido. Deve iniciar com o registro C400.');
    End;
  End
  Else If status = st405 Then
  Begin
    dtaDtaAtual := fCampoDataSped(strLinha, COLUNA_DATA_405);

    If strRegistroDaFrente = 'C460' Then
      status := st460
    else
      status := stOutrosRegistros;
  End
  Else If status = stOutrosRegistros Then
  Begin
    If strRegistroDaFrente = 'C460' Then
      status := st460;
  End
  Else If status = st460 Then
  Begin

    pInicializaDadosCupom;

    strSituacaoDocumento := fGetValorLinhaSped(strLinha, 3);
    strNumeroCoo := fGetValorLinhaSped(strLinha, 4);
    fltValorDocumento := fCampoValorSped(strLinha, COLUNA_VALOR_460);
    strCpfConsumidor := fGetValorLinhaSped(strLinha, 9);
    strNomeConsumidor := fGetValorLinhaSped(strLinha, 10);

    If strNumCooAnterior <> cdsDivergenciasNUMCOO.AsString Then
    Begin
      corAtual := IIF(corAtual = corInicial, clMoneyGreen, corInicial);
      strNumCooAnterior := cdsDivergenciasNUMCOO.AsString;
    End;

    If strRegistroDaFrente = 'C470' Then
    Begin
      status := st470;
    End
    Else
    Begin
      pRealizaTarefaDocumentoCancelado;
      If strRegistroDaFrente = 'C460' Then
        status := st460
      Else If (strRegistroDaFrente = 'C490') Or (strRegistroDaFrente = 'C495') Then
        status := st490
      Else If strRegistroDaFrente = 'C405' Then
        status := st405;
    End;

  End
  Else If status = st470 Then
  Begin
    pAdicionaItem(strLinha);
    If strRegistroDaFrente <> 'C470' Then
    Begin
      pRealizaTarefaDocumentoCadastrado;
      If strRegistroDaFrente = 'C460' Then
        status := st460
      Else If strRegistroDaFrente = 'C490' Then
        status := st490
      Else If strRegistroDaFrente = 'C405' Then
        status := st405;
    End;
  End
  Else if status = st490 Then
  Begin
    If strRegistroDaFrente = 'C405' Then
      status := st405;
  End;

end;

function TfrmVerificadorDeCupons.fGetValorLinhaSped(strLinha: String; intColuna: Integer): String;
begin
  Result := fGetValorLinha(strLinha, '|', intColuna, True);
end;

function TfrmVerificadorDeCupons.fRetRegistro(const strLinha: String): String;
begin
  Result := fGetValorLinhaSped(strLinha, 1);
end;

procedure TfrmVerificadorDeCupons.pAdicionaItem(const strLinha: String);
  Var
    intTamArr: Integer;
  Const
    CAMPO_QTD_470 = 3;
    CAMPO_UNITAR_470 = 6;
begin
  intTamArr := Length(arrItens);
  SetLength(arrItens, intTamArr+1);

  arrItens[intTamArr].strCodIte := RightStr(fGetValorLinhaSped(strLinha, 2), fTamCodIte);
  arrItens[intTamArr].fltQtdIte := fCampoValorSped(strLinha, CAMPO_QTD_470);
  arrItens[intTamArr].fltUnitar := fFormataFloat(fCampoValorSped(strLinha, CAMPO_UNITAR_470) / arrItens[intTamArr].fltQtdIte, 2);
  arrItens[intTamArr].blnUtilizado := False;
end;

procedure TfrmVerificadorDeCupons.pInicializaVariaveis;
begin
  status := st400;
  strNumeroSerie := '';
  dtaDtaAtual := 0;
  pInicializaDadosCupom;
end;

procedure TfrmVerificadorDeCupons.pInicializaDadosCupom;
begin
  strSituacaoDocumento := '';
  strNumeroCoo := '';
  strCpfConsumidor := '';
  strNomeConsumidor := '';
  fltValorDocumento := 0;
  SetLength(arrItens, 0);
end;

function TfrmVerificadorDeCupons.fCampoDataSped(
  const strLinha: String; const intColuna: Integer): TDateTime;
  Var
    strData: String;
    strDia: String;
    strMes: String;
    strAno: String;
begin
  strData := fGetValorLinhaSped(strLinha, intColuna);
  strDia := RightStr(strData, 2);
  strMes := Copy(strData, 5, 2);
  strAno := LeftStr(strData, 4);

  Result := EncodeDate(StrToInt(strAno), StrToInt(strMes), StrToInt(strDia));
end;

function TfrmVerificadorDeCupons.fCampoValorSped(const strLinha: String;
  const intColuna: Integer): Double;
Begin
  Result := fStrToFloat(fGetValorLinhaSped(strLinha, intColuna));
End;

procedure TfrmVerificadorDeCupons.pRealizaTarefaDocumentoCancelado;
  Var
    qryAux: TUniQuery;

  function fCupomOk: Boolean;
  begin
    Result := (qryAux.IsEmpty) Or
              (AnsiContainsText(qryAux.FieldByName('FIS_HISTOR').AsString, 'CANCELADO'));
  end;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_HISTOR ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMCOO = :NUMCOO AND ');
  qryAux.SQL.Add('  REPLACE(FIS_NUMSER, "\0", "") = :NUMSER ');

  qryAux.ParamByName('NUMCOO').AsString := strNumeroCoo;
  qryAux.ParamByName('NUMSER').AsString := strNumeroSerie;
  qryAux.Open;

  If Not fCupomOk Then
  Begin
    cdsDivergencias.Append;
    cdsDivergencias.FieldByName('NUMSER').AsString   := strNumeroSerie;
    cdsDivergencias.FieldByName('NUMCOO').AsString   := strNumeroCoo;
    cdsDivergencias.FieldByName('DTAENT').AsDateTime := dtaDtaAtual;
    cdsDivergencias.FieldByName('CODITE').AsString := '';
    cdsDivergencias.FieldByName('DIVERGENCIA').AsString := 'Cupom está cancelado no ECF mas não está cancelado no Autcom.';
    cdsDivergencias.FieldByName('SUGESTAO').AsString := 'Altere o número de série do cupom no livro fiscal para SPED-XXXXX, ' +
      'onde XXXXX é o CÓDIGO DO ECF NO AUTCOM.' + #13#10 + 'Desta forma, o cupom não irá mais para os arquivos do SPED.';
    cdsDivergencias.FieldByName('COR').AsInteger := corAtual;
    cdsDivergencias.Post;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmVerificadorDeCupons.pRealizaTarefaDocumentoCadastrado;
  Var
    qryItens: TUniQuery;
    intContador: Integer;
    itemSped: TDadosItem;
begin
  qryItens := fCriaQuery(Self);
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  DET_CODITE, ');
  qryItens.SQL.Add('  DET_QTDITE, ');
  qryItens.SQL.Add('  DET_UNITAR ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  MOVDET ');
  qryItens.SQL.Add('JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC AND ');
  qryItens.SQL.Add('               FIS_ESPDOC = DET_ESPDOC AND ');
  qryItens.SQL.Add('               FIS_CODEMP = DET_CODEMP AND ');
  qryItens.SQL.Add('               FIS_FORCLI = DET_CODCLI AND ');
  qryItens.SQL.Add('               IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  FIS_NUMCOO = :NUMCOO AND ');
  qryItens.SQL.Add('  REPLACE(FIS_NUMSER, "\0", "") = :NUMSER ');
  qryItens.SQL.Add('ORDER BY ');
  qryItens.SQL.Add('  MOVDET.AUTOINCREM ');

  qryItens.ParamByName('NUMCOO').AsString := strNumeroCoo;
  qryItens.ParamByName('NUMSER').AsString := strNumeroSerie;
  qryItens.Open;

  If (qryItens.IsEmpty) Then
  Begin
    qryItens.SQL.Text := AnsiReplaceText(qryItens.SQL.Text, 'MOVDET', 'NOTDET');
    qryItens.ParamByName('NUMCOO').AsString := strNumeroCoo;
    qryItens.ParamByName('NUMSER').AsString := strNumeroSerie;
    qryItens.Open;
  End;

  If Not qryItens.IsEmpty Then
  Begin
    While (Not qryItens.Eof) Do
    Begin
      If Not fItemEstaNoSped(qryItens) Then
      Begin
        pGravaDivergencia(qryItens.FieldByName('DET_CODITE').AsString,
                          qryItens.FieldByName('DET_QTDITE').AsFloat,
                          qryItens.FieldByName('DET_UNITAR').AsFloat,
                          tpItemAutcomNaoEcf);
      End;

      qryItens.Next;

    End;

    For itemSped In arrItens Do
    Begin
      If Not itemSped.blnUtilizado Then
      Begin
        pGravaDivergencia(itemSped.strCodIte,
                          itemSped.fltQtdIte,
                          itemSped.fltUnitar,
                          tpItemEcfNaoAutcom);
      End;
    End;
  End
  Else
  Begin
    For intContador := Low(arrItens) To High(arrItens) Do
    Begin
      pGravaDivergencia(arrItens[intContador].strCodIte,
                        arrItens[intContador].fltQtdIte,
                        arrItens[intContador].fltUnitar,
                        tpItemEcfNaoAutcom);
    End;

  End;

  FreeAndNil(qryItens);
end;

procedure TfrmVerificadorDeCupons.pGravaDivergencia(strCodIte: String;
  fltQtdIte, fltUnitar: Double; tpDivergencia: TTipoDivergencia);
  Var
    strMsg: String;
    strSug: String;
    intPermiteGerarIF: Integer;
begin
  strMsg := '';
  strSug := '';

  intPermiteGerarIF := 0;

  If (tpDivergencia = tpItemAutcomNaoEcf) Then
  Begin
    strMsg := 'Item está na base do Autcom mas não está registrado no ECF.';
    strSug := 'Caso apenas alguns itens não foram registrados no ECF, entre em contato com a Citel, ' +
      'para uma análise mais profunda.';
    intPermiteGerarIF := 0;
  End
  Else If (tpDivergencia = tpItemEcfNaoAutcom) Then
  Begin
    strMsg := 'Item está registrado no ECF mas não está na base do Autcom.';
    strSug := 'Utilize a função de geração de cupom especial, disponível nesta rotina.';
    intPermiteGerarIF := 1;
  End;

  cdsDivergencias.Append;
  cdsDivergencias.FieldByName('NUMSER').AsString   := strNumeroSerie;
  cdsDivergencias.FieldByName('NUMCOO').AsString   := strNumeroCoo;
  cdsDivergencias.FieldByName('DTAENT').AsDateTime := dtaDtaAtual;
  cdsDivergencias.FieldByName('CODITE').AsString := strCodIte;
  cdsDivergencias.FieldByName('QTDITE').AsFloat  := fltQtdIte;
  cdsDivergencias.FieldByName('UNITAR').AsFloat  := fltUnitar;
  cdsDivergencias.FieldByName('DIVERGENCIA').AsString := strMsg;
  cdsDivergencias.FieldByName('SUGESTAO').AsString := strSug;
  cdsDivergencias.FieldByName('COR').AsInteger := corAtual;
  cdsDivergencias.FieldByName('GERAIF').AsInteger := intPermiteGerarIF;
  cdsDivergencias.FieldByName('CPF').AsString := strCpfConsumidor;
  cdsDivergencias.FieldByName('NOME').AsString := strNomeConsumidor;
  cdsDivergencias.Post;
end;

function TfrmVerificadorDeCupons.fItemEstaNoSped(qryItens: TUniQuery): Boolean;
  Var
    itemSped: TDadosItem;
    intContador: Integer;
begin
  Result := False;
  For intContador := Low(arrItens) To High(arrItens) Do
  Begin
    itemSped := arrItens[intContador];
    If (itemSped.strCodIte = qryItens.FieldByName('DET_CODITE').AsString) And
       (CompareValue(itemSped.fltQtdIte, qryItens.FieldByName('DET_QTDITE').AsFloat, 0.01) = EqualsValue) And
       (CompareValue(itemSped.fltUnitar, qryItens.FieldByName('DET_UNITAR').AsFloat, 0.01) = EqualsValue) And
       (Not itemSped.blnUtilizado) Then
    Begin
      Result := True;
      arrItens[intContador].blnUtilizado := True;
      Break;
    End;
  End;
end;

procedure TfrmVerificadorDeCupons.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDivergencias.CreateDataSet;
  corInicial := dbgRelatorio.Canvas.Brush.Color;
  corAtual := corInicial;
  strNumCooAnterior := '';
end;

procedure TfrmVerificadorDeCupons.cdsDivergenciasAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (Not cdsDivergencias.Active) Or
     (cdsDivergencias.IsEmpty) Then
  Begin
   Exit;
  End;

  btnGerarCupomEspecial.Visible := (cdsDivergencias.FieldByName('GERAIF').AsInteger = 1);
end;

procedure TfrmVerificadorDeCupons.dbgRelatorioDblClick(Sender: TObject);
begin
  inherited;
  If (Not cdsDivergencias.Active) Or
     (cdsDivergencias.IsEmpty)    Then
  Begin
    Exit;
  End;

  cdsDivergencias.DisableControls;

  pCriarFormularios(TfrmMemo, frmMemo);
  frmMemo.cxMemo.Lines.Add(cdsDivergencias.FieldByName('SUGESTAO').AsString);
  frmMemo.ShowModal;
  pFreeAndNil(frmMemo);

  cdsDivergencias.EnableControls;
end;

procedure TfrmVerificadorDeCupons.dbgRelatorioDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If cdsDivergencias.IsEmpty Then
    Exit;
  
  If dbgRelatorio.Canvas.Brush.Color = clHighLight Then
  Begin
    dbgRelatorio.Canvas.Font.Color := clHighLightText;
  End Else
  Begin
    dbgRelatorio.Canvas.Brush.Color := cdsDivergencias.FieldByName('COR').AsInteger;
  End;

  dbgRelatorio.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmVerificadorDeCupons.dbgRelatorioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    pSetFocus(edtArquivo);
  End;
end;

end.


