unit untFatLotePedRom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untfuncoesSimples, untTypesSistema, Data.DB,
  MemDS, DBAccess, Uni, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, untIFatReservaSaldo,
  UniClientDataSet, cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel,
  cxButtonEdit, cxTextEdit, StrUtils, Math, untMovimentacaoProgramada, untTFatReservaSaldo,
  Datasnap.Provider, UniDataSetProvider, untFatDefinirLotePedRom, untTLock;

Type
  TDadosEstoqueLote = record
    fltSaldo : double;
    fltSaldoReservado : double;
    fltMovimentacaoEntrada : double;
    fltMovimentacaoSaida : double;
  end;

type
  TAcao = (TpInserir, TpAlterar);
  TResulAlt = (TpVazio, TpErro, TpAlterou);

  TItemMovProg = Record
    strCodIte: String;
    strLocPic: String;
    strLotBuf: String;
    fltQtdMov: Double;
    fltQtdDif: Double;
  end;

  TArrayItemMovProg = Array of TItemMovProg;

type
  TfrmFatLotePedRom = class(TfrmPaiConfirma)
    pnlNumLot: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lblLote: TLabel;
    lblEmpresa: TLabel;
    edtCodLot: TEditFocus;
    edtDesLot: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblQtdDocDes: TLabel;
    lblQtdDocVlr: TLabel;
    lblPesBruDes: TLabel;
    lblPesBruVlr: TLabel;
    lblQtdProDes: TLabel;
    lblQtdProVlr: TLabel;
    lblPesLiqDes: TLabel;
    lblPesLiqVlr: TLabel;
    lblSequencia: TLabel;
    edtSequencia: TEditFocus;
    btnSequencia: TBitBtnLocked;
    cdsLoteSep: TUniClientDataSet;
    dtsLoteSep: TDataSource;
    cdsLoteSepSEQSEP: TIntegerField;
    cdsLoteSepCODSEP: TStringField;
    grdLoteSepDBTableView: TcxGridDBTableView;
    grdLoteSepLevel1: TcxGridLevel;
    grdLoteSep: TcxGrid;
    grdLoteSepDBTableViewSEQSEP: TcxGridDBColumn;
    grdLoteSepDBTableViewCODSEP: TcxGridDBColumn;
    grdLoteSepDBTableViewOPESEP: TcxGridDBColumn;
    cdsDefineLote: TUniClientDataSet;
    cdsDefineLoteCODITE: TStringField;
    cdsDefineLoteDESITE: TStringField;
    cdsDefineLoteQTDITE: TFloatField;
    cdsDefineLoteNUMDOC: TStringField;
    cdsDefineLoteNUMLOT: TStringField;
    cdsDefineLoteCODSEP: TStringField;
    cdsDefineLoteSEQSEP: TIntegerField;
    lblProDisDes: TLabel;
    lblProDisVlr: TLabel;
    cdsConsulta: TUniClientDataSet;
    dspConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsDefineLoteAUTINC: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLotKeyPress(Sender: TObject; var Key: Char);
    procedure edtSequenciaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnSequenciaClick(Sender: TObject);
    procedure grdLoteSepDBTableViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdLoteSepDBTableViewOPESEPPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cdsLoteSepBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FParametroPicking: Boolean;
    FAcao: TAcao;
    objLock: TLock;
    objLockMovProg: TLock;

    procedure pRetInfItens(var AQtdIte, APesBru, APesLiq: Double; ACocumentos: string);
    procedure pRetInfDoc(ANumLot, ACodEmp: string);
    procedure pLimpaDoc;
    procedure pPreencheInfDoc(AQtdDoc: integer; AQtdIte, APesBru, APesLiq: Double);
    procedure pCriaSeparacao;
    function fValidaSeparador(ACodOpe: string; var AMensagem: string): Boolean;
    function fValidaTodosSeparadores: Boolean;
    procedure pDefineLotesItens(ANumRom, ACodEmp: String);
    function fValidaLotes: Boolean;
    function fAtualizaLote(AfrmDefinirLotePedRom: TfrmDefinirLotePedRom): Boolean;
    procedure pDefineSeparadorPorItem;
    function fRetSaldoLote(ACodIte, ANumLot, ACodEmp, ANumPed: String) : TDadosEstoqueLote;
    function fPreparaRegistroCadLot(ACodIte, ANumLot, ACodSep, ANumRom, ACodEmp: string; ASeqSep: integer; AQtdIte: Double; AFdoAutInc: String): Boolean;
    function fGravaCadLot(ANumLot, AAutInc, ACodSep, ACodEmp: string; AQtdIte: Double; ADadosEstoqueLote: TDadosEstoqueLote): Boolean;
    function fAlteraExtDor(AAutInc, ACodSep: string; ASeqSep: integer): Boolean;
    function fGravaLoteSeparacao(ANumLot, ACodEmp: string; ANumSeq: integer): Boolean;
    function fGravaMovimentacao: Boolean;
    procedure pCarregaMovimentacao(ACodEmp, ANumLot: string);
    function fAlteraSeparador: TResulAlt;
    function fAlteraLoteSeparacao(ASeqSep: integer; ACodSep: string): Boolean;
    function fAlteraExtDorLotDor(ASeqSep: integer; ACodSep: string):Boolean;
    function fGravaLogAlteracao(AOpeAnt, AOpeAtu: string): Boolean;
    function fLimpaSeparacao(ASeqSep: integer; ACodSep: string): Boolean;
    procedure pLimpaSeparacao;
    procedure pImprimeSeparacao(ANumLot, ACodEmp, ACodSep: string; ASeqSep: integer);
    function fRetornaTotalProdutosDistintos: integer;
    function fGravaSeparacao(ANumLot, AAutINc, ACodSep, ACodEmp, ANumDoc, AEspDoc: string; ASeqSep: integer; AQtdIte: Double; ADadosEstoqueLote: TDadosEstoqueLote): Boolean;
    procedure pGravaMovimentacao;
    function fRetornaEmpresaDocumento(ANumDoc, AEspDoc, ACodEmp: string): string;
    function fLimpaLOTDOR(AstrSeqFdo, AstrCodLot, AstrCodEmp: String): Boolean;

    function fRetDocumentos(ANumRom, ACodEmp, AstrCodIte: String): String;
    procedure pConfirma;

    function fValidaLoteSeparacao(ANumLot, ACodEmp: string): Boolean;

    function fVerificarMovimentacaoProgramada: Boolean;
    function fMovimentacaoProgramadaManual(arrMovProg: TArrayItemMovProg): Boolean;
    function fMontaArrMovProg: TArrayItemMovProg;

    function fDefinirLotePedRom: Boolean;
    function fRetornaSaldoDisp(strCodIte, strIdePro: string; strPicking: string = ''): Double;
    function fRetornaLote(strCodIte: string; strPicking: string = ''; blnLocFis: Boolean = False): String;

    function fRetQtdLotDorPicking(strCodIte: string): Double;
    function fRetQtdMovLotPicking(strCodIte: string): Double;

    procedure pCarregaLotesBuffer(strCodIte: string; qyrSelect: TUniQuery);

    function fRetMaxLocFis(strCodIte, strLocFis: String): Double;

    function fTravaLoteSeparacao: Boolean;
    function fTravaMovProgramada: Boolean;
    function fImprimeOrdemDeProducao(AAposDefinirSeparador : Boolean = False) : Boolean;
    procedure pImprimeOrdemDeProducao(ANumLot, ACodEmp, ACodSep: String; ASeqSep: Integer);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnExpedicao: Boolean;
    blnUtilizaImpressaoSeparacao: Boolean;
  end;

implementation

uses
  untConsultas, untObservacao, untQckLoteSeparacaoWMS, untDefineLotesWMS, untGravando,
  untMovimentacaoProgramadaManual, untTSituacaoPedidoVenda, untFatOrdProTintaMaquina,
  untFuncTinta;

{$R *.dfm}

procedure TfrmFatLotePedRom.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if not btnConfirma.Enabled then
    Exit;

  ModalResult := mrNone;

  TFrmGravando.fExecutarModal( pConfirma, 'Aguarde... Confirmando!', '');
end;

procedure TfrmFatLotePedRom.btnSequenciaClick(Sender: TObject);
begin
  inherited;
  pCriaSeparacao;
end;

procedure TfrmFatLotePedRom.cdsLoteSepBeforePost(DataSet: TDataSet);
var LMensagem: String;
begin
  inherited;
  if fEmptyStr(cdsLoteSep.FieldByName('CODSEP').AsString) then
    Exit;

  if not fValidaSeparador(cdsLoteSep.FieldByName('CODSEP').AsString, LMensagem) then
  begin
    fMensagem('ATENÇÃO!', LMensagem, ['&Ok']);
    cdsLoteSep.FieldByName('CODSEP').AsString := EmptyStr;
  end
  else
  begin
    if FAcao = TpAlterar then
    begin
      pSetFocus(grdLoteSep);
      grdLoteSepDBTableViewCODSEP.Options.Editing:= False;
    end;
  end;

end;

procedure TfrmFatLotePedRom.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrEmp: TConsultasArray;
begin
  inherited;
  If Key = #13 Then
    fValidaCampos(edtCodEmp)
  Else If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);

  End;
end;

procedure TfrmFatLotePedRom.edtCodLotKeyPress(Sender: TObject; var Key: Char);
var
  LArrLote: TConsultasArray;
  LPesquisaLote: Boolean;
  LQryConsulta: TUniQuery;
begin
  inherited;

  LPesquisaLote := True;

  If fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtCodEmp.Text := VS_strCodEmp;
    LPesquisaLote := fValidaCampos(edtCodEmp);
  End;

  If Key = #13 Then
  Begin
    If fValidaCampos(edtCodLot) Then
    Begin
      if not fValidaLoteSeparacao(edtCodLot.Text, edtCodEmp.Text) then
        pLimpaDoc
      else
        pCarregaMovimentacao(edtCodEmp.Text, edtCodLot.Text);
    End;
    Exit;
  End;

  If LPesquisaLote Then
  Begin
    LQryConsulta := fCriaQuery(Self);
    If fPesqRomaneioLoteSeparacao(Self, edtCodLot, LQryConsulta, Key, LArrLote, True, edtCodEmp.Text) Then
    Begin
      If fValidaCampos(edtCodLot) Then
      Begin
        pCarregaMovimentacao(edtCodEmp.Text, edtCodLot.Text);
      End;
    End;
    FreeAndNil(LQryConsulta);
  End;
end;

procedure TfrmFatLotePedRom.edtSequenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    fValidaCampos(edtSequencia);
end;

function TfrmFatLotePedRom.fPreparaRegistroCadLot(ACodIte, ANumLot, ACodSep, ANumRom,
  ACodEmp: string; ASeqSep: integer; AQtdIte: Double; AFdoAutInc: String): Boolean;
var
  LdadosEstoqueLote : TDadosEstoqueLote;
  LNumDoc: String;
  LEspDoc: String;
begin
  if fEmptyStr(ANumLot) then
    Exit(True);

  Result := False;

  LNumDoc := fCampoTabela('FDO_NUMDOC', 'FATDOR', ['AUTOINCREM'], [AFdoAutInc]);
  LEspDoc := fCampoTabela('FDO_ESPDOC', 'FATDOR', ['AUTOINCREM'], [AFdoAutInc]);
  LdadosEstoqueLote := fRetSaldoLote(ACodIte, ANumLot, ACodEmp, LNumDoc);

  if not fGravaSeparacao(ANumLot,
                         AFdoAutInc,
                         ACodSep,
                         ACodEmp,
                         LNumDoc,
                         LEspDoc,
                         ASeqSep,
                         AQtdIte,
                         LdadosEstoqueLote) then
    Exit;

  Result := True;
end;

function TfrmFatLotePedRom.fGravaCadLot(ANumLot, AAutInc, ACodSep, ACodEmp: string;
  AQtdIte: Double; ADadosEstoqueLote: TDadosEstoqueLote): Boolean;
var
  LQryCadLot: TUniQuery;
  LSaldos,
  LSalRes,
  LSalDis: Double;
begin
  Result := False;
  LQryCadLot := fCriaQuery;

  try
    try
      LSaldos := ADadosEstoqueLote.fltSaldo + ADadosEstoqueLote.fltMovimentacaoEntrada;
      LSalRes := ADadosEstoqueLote.fltSaldoReservado + ADadosEstoqueLote.fltMovimentacaoSaida;
      LSalDis := LSaldos - LSalRes - AQtdIte;

      LQryCadLot.Close;
      LQryCadLot.SQL.Clear;
      LQryCadLot.SQL.Add('INSERT INTO LOTDOR(AUTOINCREM, LDO_NUMLOT, LDO_QTDITE, LDO_SEQFDO, LDO_CODSEP, LDO_SALCAL, LDO_MOVENT, LDO_MOVSAI)');
      LQryCadLot.SQL.Add('VALUES(:AUTINC, :NUMLOT, :QTDITE, :SEQFDO, :CODSEP, :SALCAL, :MOVENT, :MOVSAI)');
      LQryCadLot.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOTDOR', ACodEmp);
      LQryCadLot.ParamByName('NUMLOT').AsString := ANumLot;
      LQryCadLot.ParamByName('QTDITE').AsFloat  := AQtdIte;
      LQryCadLot.ParamByName('SEQFDO').AsString := AAutInc;
      LQryCadLot.ParamByName('CODSEP').AsString := ACodSep;
      LQryCadLot.ParamByName('SALCAL').AsFloat  := LSalDis;
      LQryCadLot.ParamByName('MOVENT').AsFloat  := ADadosEstoqueLote.fltMovimentacaoEntrada;
      LQryCadLot.ParamByName('MOVSAI').AsFloat  := ADadosEstoqueLote.fltMovimentacaoSaida;
      LQryCadLot.ExecSQL;

      Result := True;
    except
      On E: Exception Do
        Showmessage(E.Message);
    end;
  finally
    FreeAndNil(LQryCadLot);
  end;
end;

function TfrmFatLotePedRom.fGravaLogAlteracao(AOpeAnt,
  AOpeAtu: string): Boolean;
var
  LQryLog: TUniQuery;
begin
  LQryLog := fCriaQuery;

  try
    Result := False;
    LQryLog.Close;
    LQryLog.SQL.Clear;
    LQryLog.SQL.Add('INSERT INTO LOGSLP(AUTOINCREM, LOG_CODEMP, LOG_NUMDOC, LOG_OPEATU, LOG_OPEANT, LOG_OPEALT, LOG_DTAALT, LOG_HORALT)');
    LQryLog.SQL.Add('VALUES(:AUTINC, :CODEMP, :NUMDOC, :OPEATU, :OPEANT, :OPEALT, :DTAALT, :HORALT)');
    LQryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGSLP', edtCodEmp.Text);
    LQryLog.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    LQryLog.ParamByName('NUMDOC').AsString := edtCodLot.Text;
    LQryLog.ParamByName('OPEATU').AsString := strLoginUsuarioLogado;
    LQryLog.ParamByName('OPEANT').AsString := AOpeAnt;
    LQryLog.ParamByName('OPEALT').AsString := AOpeAtu;
    LQryLog.ParamByName('DTAALT').AsDateTime := VS_Date;
    LQryLog.ParamByName('HORALT').AsDateTime := fTime();
    LQryLog.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryLog);
  end;
end;

function TfrmFatLotePedRom.fGravaLoteSeparacao(ANumLot, ACodEmp: string;
  ANumSeq: integer): Boolean;
var
  LQryLote: TUniQuery;
  LAutInc: string;
begin
  Result := False;
  LAutInc := fRetAutoIncrem('SLPROM', ACodEmp);

  LQryLote := fCriaQuery;

  try
    try
      LQryLote.Close;
      LQryLote.SQL.Clear;
      LQryLote.SQL.Add('INSERT INTO SLPROM(AUTOINCREM, ROM_NUMLOT, ROM_QTDSEQ, ROM_CODEMP)');
      LQryLote.SQL.Add('VALUES(:AUTINC, :NUMLOT, :QTDSEQ, :CODEMP)');
      LQryLote.ParamByName('AUTINC').AsString := LAutInc;
      LQryLote.ParamByName('NUMLOT').AsString := ANumLot;
      LQryLote.ParamByName('QTDSEQ').AsInteger := ANumSeq;
      LQryLote.ParamByName('CODEMP').AsString := ACodEmp;
      LQryLote.ExecSQL;

      LQryLote.Close;
      LQryLote.SQL.Clear;
      LQryLote.SQL.Add('INSERT INTO SLPDOC(AUTOINCREM, DOC_SEQROM, DOC_SEQSEP, DOC_CODSEP)');
      LQryLote.SQL.Add('VALUES(:AUTINC, :SEQROM, :SEQSEP, :CODSEP)');

      cdsLoteSep.DisableControls;
      cdsLoteSep.First;

      while not cdsLoteSep.Eof do
      begin
        LQryLote.ParamByName('AUTINC').AsString := fRetAutoIncrem('SLPDOC', ACodEmp);
        LQryLote.ParamByName('SEQROM').AsString := LAutInc;
        LQryLote.ParamByName('SEQSEP').AsInteger := cdsLoteSepSEQSEP.AsInteger;
        LQryLote.ParamByName('CODSEP').AsString := cdsLoteSepCODSEP.AsString;
        LQryLote.ExecSQL;

        cdsLoteSep.Next;
      end;

      Result := True;
    except
      On E: Exception Do
        Showmessage(E.Message);
    end;
  finally
    cdsLoteSep.First;
    cdsLoteSep.EnableControls;
    FreeAndNil(LQryLote);
  end;
end;

function TfrmFatLotePedRom.fGravaMovimentacao: Boolean;
var
  strSeqFdo: String;
begin

  cdsDefineLote.First;
  cdsDefineLote.DisableControls;

  try
    try
      fStartTransaction;

      if FAcao = TpInserir then
      begin
        if not fGravaLoteSeparacao(edtCodLot.Text, edtCodEmp.Text, StrToInt(edtSequencia.Text)) then
        begin
          Result := False;
          Exit;
        end;

        strSeqFdo := '';
        while not cdsDefineLote.Eof do
        begin
          if not fEmptyStr(cdsDefineLoteNUMLOT.AsString) then
            strSeqFdo := strSeqFdo + QuotedStr(cdsDefineLoteAUTINC.AsString) + ',';

          cdsDefineLote.Next;
        end;

        if not fEmptyStr(strSeqFdo) then
        begin
          Delete(strSeqFdo, Length(strSeqFdo), 1);

          if not fLimpaLOTDOR(strSeqFdo, edtCodLot.Text, edtCodEmp.Text) then
          begin
            Result := False;
            fRollBack;
            Exit;
          end;
        end;

        cdsDefineLote.First;
        while not cdsDefineLote.Eof do
        begin
          if not fPreparaRegistroCadLot(
            cdsDefineLoteCODITE.AsString,
            cdsDefineLoteNUMLOT.AsString,
            cdsDefineLoteCODSEP.AsString,
            edtCodLot.Text,
            edtCodEmp.Text,
            cdsDefineLoteSEQSEP.AsInteger,
            cdsDefineLoteQTDITE.AsFloat,
            cdsDefineLoteAUTINC.AsString) then
          begin
            Result := False;
            fRollBack;
            Exit;
          end;
          cdsDefineLote.Next;
        end;
      end
      else
      begin

        case fAlteraSeparador of
          TpVazio:begin
                    fRollBack;
                    Result := False;
                    Exit;
                  end;

          TpErro:begin
                    fMensagem('ATENÇÃO!', 'Ocorreu ao alterar separador!', ['&Ok']);
                    fRollBack;
                    Result := False;
                    Exit;
                  end;

          TpAlterou: fMensagem('ATENÇÃO!', 'Alteração concluída com sucesso!', ['&Ok']);

        end;
      end;

      Result := fCommit;
    except
      Result := False;
      fRollBack;
    end;
  finally
    cdsDefineLote.First;
    cdsDefineLote.EnableControls;
  end;
end;

function TfrmFatLotePedRom.fGravaSeparacao(ANumLot, AAutINc, ACodSep, ACodEmp,
  ANumDoc, AEspDoc: string; ASeqSep: integer; AQtdIte: Double;
  ADadosEstoqueLote: TDadosEstoqueLote): Boolean;
var
  LEmpFat: string;
begin
  Result := False;

  if not fGravaCadLot(ANumLot,AAutInc, ACodSep, ACodEmp, AQtdIte, ADadosEstoqueLote) then
    Exit;

  if not fAlteraExtDor(AAutInc, ACodSep, ASeqSep) then
    Exit;

  LEmpFat := fRetornaEmpresaDocumento(ANumDoc, AEspDoc, ACodEmp);

  if not fMarcarPedidoComoImpresso(ANumDoc, AEspDoc, LEmpFat, False, True, ACodSep) then
    Exit;

  TUpdateStatus.New(TParamStatus.New()
    .NumDoc(ANumDoc)
    .EspDoc(AEspDoc)
    .CodEmp(LEmpFat)
  ).pExecute();

  Result := True;
end;

function TfrmFatLotePedRom.fImprimeOrdemDeProducao(
  AAposDefinirSeparador: Boolean): Boolean;
begin

  Result := False;

  If Not (fVerificaAcessoSistema('IMPORD')) Then
    Exit;

  If (blnUtilizaImpressaoSeparacao) And (fCfgSis('IMPOPM', varBoolean)) Then
    Exit(True);

  If (AAposDefinirSeparador) And (fCfgSis('IOPTMS', varBoolean)) Then
    Exit(True);

end;

function TfrmFatLotePedRom.fLimpaSeparacao(ASeqSep: integer;
  ACodSep: string): Boolean;
var
  LQryLimpa: TUniQuery;
  LSQL: string;
begin
  LSQL := EmptyStr;
  LQryLimpa := fCriaQuery;

  try
    try
      fStartTransaction;

      LSQL := LSQL + 'UPDATE FATGOR F ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN EXTGOR E ' + sLineBreak;
      LSQL := LSQL + 'ON(F.AUTOINCREM = E.FGO_SEQFGO) ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN FATDOR D ' + sLineBreak;
      LSQL := LSQL + 'ON(F.AUTOINCREM = D.FDO_SEQGER) ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN EXTDOR ED ' + sLineBreak;
      LSQL := LSQL + 'ON(D.AUTOINCREM = ED.FDO_SEQFDO) ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN LOTDOR L ' + sLineBreak;
      LSQL := LSQL + 'ON(D.AUTOINCREM = L.LDO_SEQFDO) ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN ROMLDE RL ' + sLineBreak;
      LSQL := LSQL + 'ON(D.FDO_NUMDOC = RL.RLD_NUMDOC AND D.FDO_ESPDOC = RL.RLD_ESPDOC AND D.FDO_CODEMP = RL.RLD_CODEMP) ' + sLineBreak;
      LSQL := LSQL + 'INNER JOIN ROMLGE G ' + sLineBreak;
      LSQL := LSQL + 'ON(RL.RLD_SEQRLG = G.AUTOINCREM) ' + sLineBreak;
      LSQL := LSQL + 'SET E.FGO_DTIMSE = NULL, ' + sLineBreak;
      LSQL := LSQL + 'E.FGO_HRIMSE = NULL, ' + sLineBreak;
      LSQL := LSQL + 'E.FGO_OPBXSE = NULL  ' + sLineBreak;
      LSQL := LSQL + 'WHERE G.RLG_NUMLOT = :NUMDOC ' + sLineBreak;
      LSQL := LSQL + 'AND G.RLG_CODEMP = :CODEMP ' + sLineBreak;
      LSQL := LSQL + 'AND ED.FDO_OPESEP = :CODSEP ' + sLineBreak;
      LSQL := LSQL + 'AND ED.FDO_SEQSEP = :SEQSEP ' + sLineBreak;
      LSQL := LSQL + 'AND ED.FDO_QTDEXP <= 0 ';

      LQryLimpa.Close;
      LQryLimpa.SQL.Clear;
      LQryLimpa.SQL.Add(LSQL);
      LQryLimpa.ParamByName('NUMDOC').AsString := edtCodLot.Text;
      LQryLimpa.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      LQryLimpa.ParamByName('CODSEP').AsString := ACodSep;
      LQryLimpa.ParamByName('SEQSEP').AsInteger := ASeqSep;
      LQryLimpa.ExecSQL;

      Result := fCommit;
    except
      On E: Exception Do
      begin
        fRollBack;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(LQryLimpa);
  end;
end;

function TfrmFatLotePedRom.fMontaArrMovProg: TArrayItemMovProg;
var
  qryItens: TUniQuery;
  fltSalPic: Double;
  fltSalBuf: Double;
  fltMaxPic: Double;
  arrMovProg: TArrayItemMovProg;
  intIdx: Integer;
  qryBuf: TUniQuery;
  strLocPic: String;
  fltSumQtdMov: Double;
begin
  fltSumQtdMov := 0;
  SetLength(arrMovProg , 0);

  qryItens := fCriaQuery;
  qryBuf := fCriaQuery;
  try
    qryItens.SQL.Add('SELECT FDO_CODITE AS CODITE, FDO_IDEPRO AS IDEPRO, ');
    qryItens.SQL.Add('       SUM(I.RLI_QTDSEP) - SUM(I.RLI_QTDBAI) AS QTDITE');
    qryItens.SQL.Add(' FROM ROMLGE G');
    qryItens.SQL.Add('INNER JOIN ROMLDE D ON D.RLD_SEQRLG = G.AUTOINCREM');
    qryItens.SQL.Add('INNER JOIN ROMLIT I ON I.RLI_SEQRLD = D.AUTOINCREM');
    qryItens.SQL.Add('INNER JOIN FATDOR FD ON FD.AUTOINCREM = RLI_SEQFDO');
    qryItens.SQL.Add('WHERE G.RLG_NUMLOT = :NUMLOT');
    qryItens.SQL.Add('  AND G.RLG_CODEMP = :CODEMP');
    qryItens.SQL.Add('  AND NOT EXISTS (SELECT AUTOINCREM ');
    qryItens.SQL.Add('                  FROM LOTDOR ');
    qryItens.SQL.Add('                  WHERE LDO_SEQFDO = FD.AUTOINCREM)');
    qryItens.SQL.Add('GROUP BY FDO_CODITE');

    qryItens.ParamByName('NUMLOT').AsString := edtCodLot.Text;
    qryItens.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryItens.Open;

    while not qryItens.Eof do
    begin
      fltSalPic := fRetornaSaldoDisp(qryItens.FieldByName('CODITE').AsString, qryItens.FieldByName('IDEPRO').AsString, 'S') -
                   fRetQtdLotDorPicking(qryItens.FieldByName('CODITE').AsString) +
                   fRetQtdMovLotPicking(qryItens.FieldByName('CODITE').AsString);
      fltSalBuf := fRetornaSaldoDisp(qryItens.FieldByName('CODITE').AsString, qryItens.FieldByName('IDEPRO').AsString, 'N');

      if (fltSalPic < qryItens.FieldByName('QTDITE').AsFloat) and
         (fltSalBuf >= 0) then
      begin
        strLocPic := fRetornaLote(qryItens.FieldByName('CODITE').AsString, 'S', True);

        pCarregaLotesBuffer(qryItens.FieldByName('CODITE').AsString, qryBuf);
        while not qryBuf.Eof do
        begin
          SetLength(arrMovProg, Length(arrMovProg) + 1);
          intIdx := Pred(Length(arrMovProg));

          arrMovProg[intIdx].strCodIte := qryItens.FieldByName('CODITE').AsString;
          arrMovProg[intIdx].strLocPic := strLocPic;
          arrMovProg[intIdx].strLotBuf := qryBuf.FieldByName('LOT_NUMLOT').AsString;
          fltMaxPic := fRetMaxLocFis(qryItens.FieldByName('CODITE').AsString, arrMovProg[intIdx].strLocPic);
          arrMovProg[intIdx].fltQtdMov := fltMaxPic + (qryItens.FieldByName('QTDITE').AsFloat - fltSalPic);
          arrMovProg[intIdx].fltQtdDif := (qryItens.FieldByName('QTDITE').AsFloat - fltSalPic);

          if arrMovProg[intIdx].fltQtdMov > qryBuf.FieldByName('LOT_SALDOS').AsFloat then
            arrMovProg[intIdx].fltQtdMov := qryBuf.FieldByName('LOT_SALDOS').AsFloat;

         fltSumQtdMov := fltSumQtdMov + arrMovProg[intIdx].fltQtdMov;

          if fltSumQtdMov >= qryItens.FieldByName('QTDITE').AsFloat then
            Break;

          qryBuf.Next;
        end;
      end;

      qryItens.Next;
    end;
  finally
    FreeAndNil(qryItens);
    FreeAndNil(qryBuf);
  end;

  Result := arrMovProg;
end;

function TfrmFatLotePedRom.fMovimentacaoProgramadaManual(arrMovProg: TArrayItemMovProg): Boolean;
var
  frmMovimentacaoProgramadaManual: TfrmMovimentacaoProgramadaManual;
  intCnt: Integer;
begin
  try
    pCriarFormularios(TfrmMovimentacaoProgramadaManual, frmMovimentacaoProgramadaManual);
    Try
      frmMovimentacaoProgramadaManual.blnOrigemFaturamento := True;
      frmMovimentacaoProgramadaManual.blnCarregando := True;
      frmMovimentacaoProgramadaManual.blnSepPedRom := True;
      frmMovimentacaoProgramadaManual.strCodEmpPedRom := edtCodEmp.Text;
      frmMovimentacaoProgramadaManual.strCodLotPedRom := edtCodLot.Text;

      for intCnt := Low(arrMovProg) to High(arrMovProg) do
      begin
        frmMovimentacaoProgramadaManual.dbeCodIte.Field.DataSet.Append;

        frmMovimentacaoProgramadaManual.dbeCodIte.Field.AsString := arrMovProg[intCnt].strCodIte;
        frmMovimentacaoProgramadaManual.dbeLotOri.Field.AsString := arrMovProg[intCnt].strLotBuf;
        frmMovimentacaoProgramadaManual.dbeLocDes.Field.AsString := arrMovProg[intCnt].strLoCPic;
        frmMovimentacaoProgramadaManual.dbeQtdIte.Field.AsFloat  := arrMovProg[intCnt].fltQtdMov;

        frmMovimentacaoProgramadaManual.dbeCodIte.Text := arrMovProg[intCnt].strCodIte;
        frmMovimentacaoProgramadaManual.dbeLotOri.Text := arrMovProg[intCnt].strLotBuf;
        frmMovimentacaoProgramadaManual.dbeLocDes.Text := arrMovProg[intCnt].strLocPic;
        frmMovimentacaoProgramadaManual.dbeQtdIte.Text := FloatToStr(arrMovProg[intCnt].fltQtdMov);

        frmMovimentacaoProgramadaManual.dbeCodIte.Field.DataSet.FieldByName('QTDDIF').AsFloat := arrMovProg[intCnt].fltQtdDif;

        frmMovimentacaoProgramadaManual.fValidarProduto(True);
        frmMovimentacaoProgramadaManual.btnAdicionar.Click;
      end;

      frmMovimentacaoProgramadaManual.blnCarregando := False;
      frmMovimentacaoProgramadaManual.WindowState := wsMaximized;
      Result := frmMovimentacaoProgramadaManual.ShowModal = MrOk;

      if (not Result) and (frmMovimentacaoProgramadaManual.blnLiberouTravaPerRom) then
        Result := True;
    Finally
      pFreeAndNil(frmMovimentacaoProgramadaManual);
    End;
  except
    On E: Exception Do
    begin
      Result := False;
      pMensagemOk(E.Message);
    end;
  end;
end;

procedure TfrmFatLotePedRom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
  FreeAndNil(objLockMovProg);
end;

procedure TfrmFatLotePedRom.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLoteSep.CreateDataSet;
  cdsDefineLote.CreateDataSet;
  FParametroPicking := False;
  FAcao := TpInserir;
  blnExpedicao := False;

  if (fCfgSis('WMSPIC', varBoolean)) then
    if (fCfgSis('MOSPUL', varBoolean)) then
      FParametroPicking := True;

  objLock := TLock.Create;
  objLockMovProg := TLock.Create;
end;

procedure TfrmFatLotePedRom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10: btnConfirma.Click;  
  end;
end;

procedure TfrmFatLotePedRom.FormShow(Sender: TObject);
begin
  inherited;

  //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
  if (blnExpedicao) and (not fVerificaAcessoSistema('WMSBUF')) then
    FParametroPicking := True;

  pSetFocus(edtCodEmp);
end;

function TfrmFatLotePedRom.fRetDocumentos(ANumRom, ACodEmp, AstrCodIte: String): String;
var
   LQryLote: TUniQuery;
   LSQL: String;
begin
  LSQL := LSQL + 'SELECT CAST(GROUP_CONCAT(F.FGO_NUMDOC) AS CHAR(1000)) AS DOCUMENTOS ' + sLineBreak;
  LSQL := LSQL + '  FROM FATGOR F '                                                     + sLineBreak;
  LSQL := LSQL + ' INNER JOIN FATDOR T ON(F.AUTOINCREM = T.FDO_SEQGER) '                + sLineBreak;
  LSQL := LSQL + ' INNER JOIN CADITE C ON(T.FDO_CODITE = C.ITE_CODITE) '                + sLineBreak;
  LSQL := LSQL + ' INNER JOIN ROMLDE D ON(F.FGO_NUMDOC = D.RLD_NUMDOC '                 + sLineBreak;
  LSQL := LSQL + '                    AND F.FGO_ESPDOC = D.RLD_ESPDOC '                 + sLineBreak;
  LSQL := LSQL + '                    AND F.FGO_CODEMP = D.RLD_CODEMP) '                + sLineBreak;
  LSQL := LSQL + ' INNER JOIN ROMLGE G ON(D.RLD_SEQRLG = G.AUTOINCREM) '                + sLineBreak;
  LSQL := LSQL + 'WHERE G.RLG_NUMLOT = :NUMROM '                                        + sLineBreak;
  LSQL := LSQL + '  AND G.RLG_CODEMP = :CODEMP '                                        + sLineBreak;
  LSQL := LSQL + '  AND T.FDO_CODITE = :CODITE '                                        + sLineBreak;
  LSQL := LSQL + '  AND NOT EXISTS (SELECT AUTOINCREM '                                 + sLineBreak;
  LSQL := LSQL + '                    FROM LOTDOR '                                     + sLineBreak;
  LSQL := LSQL + '                   WHERE LDO_SEQFDO = T.AUTOINCREM) '                 + sLineBreak;
  LSQL := LSQL + 'GROUP BY T.FDO_CODITE, C.ITE_DESITE ';

  LQryLote := fCriaQuery;
  try
    LQryLote.Close;
    LQryLote.SQL.Clear;
    LQryLote.SQL.Add(LSQL);
    LQryLote.ParamByName('NUMROM').AsString := ANumRom;
    LQryLote.ParamByName('CODEMP').AsString := ACodEmp;
    LQryLote.ParamByName('CODITE').AsString := AstrCodIte;
    LQryLote.Open;

    Result := LQryLote.FieldByName('DOCUMENTOS').AsString;
  finally
    FreeAndNil(LQryLote);
  end;
end;

function TfrmFatLotePedRom.fRetMaxLocFis(strCodIte, strLocFis: String): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;
  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;

    qrySaldos.SQL.Add('SELECT I.LCI_QTDMAX AS QTDMAX');
    qrySaldos.SQL.Add('  FROM CADLOC B ');
    qrySaldos.SQL.Add(' LEFT JOIN LOCITE I ON LCI_LOCFIS = B.AUTOINCREM ');
    qrySaldos.SQL.Add('WHERE B.LOC_CODLOC = :CODLOC');
    qrySaldos.SQL.Add('  AND I.LCI_CODITE = :CODITE');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODLOC').AsString := strLocFis;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
      Result := qrySaldos.FieldByName('QTDMAX').AsFloat;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatLotePedRom.fRetornaEmpresaDocumento(ANumDoc, AEspDoc,
  ACodEmp: string): string;
var
  LQryEmpresa: TUniQuery;
  LSQL: string;
begin
  Result := ACodEmp;
  LSQL := EmptyStr;
  LQryEmpresa := fCriaQuery;

  try
    LSQL := LSQL + 'SELECT F.FGO_CODEMP ' + sLineBreak;
    LSQL := LSQL + 'FROM FATGOR F ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN EXTGOR E ' + sLineBreak;
    LSQL := LSQL + 'ON(F.AUTOINCREM = E.FGO_SEQFGO) ' + sLineBreak;
    LSQL := LSQL + 'WHERE F.FGO_NUMDOC = :NUMDOC ' + sLineBreak;
    LSQL := LSQL + 'AND F.FGO_ESPDOC = :ESPDOC ' + sLineBreak;
    LSQL := LSQL + 'AND E.FGO_EMPEXP = :CODEMP ';

    LQryEmpresa.Close;
    LQryEmpresa.SQL.Clear;
    LQryEmpresa.SQL.Add(LSQL);
    LQryEmpresa.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryEmpresa.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryEmpresa.ParamByName('CODEMP').AsString := ACodEmp;
    LQryEmpresa.Open;

    if LQryEmpresa.IsEmpty then
      Exit;

    if fEmptyStr(LQryEmpresa.FieldByName('FGO_CODEMP').AsString) then
      Exit;

    Result := LQryEmpresa.FieldByName('FGO_CODEMP').AsString;
  finally
    FreeAndNil(LQryEmpresa);
  end;
end;

function TfrmFatLotePedRom.fRetornaTotalProdutosDistintos: integer;
var
  LQryTotal: TUniQuery;
  LSQL: string;
begin
  LSQL := EmptyStr;
  LQryTotal := fCriaQuery;

  try
    Result := 0;

    LSQL := LSQL + 'SELECT COUNT(DISTINCT(T.FDO_CODITE)) AS TOTITE ' + sLineBreak;
    LSQL := LSQL + 'FROM FATDOR T ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN ROMLDE D ' + sLineBreak;
    LSQL := LSQL + 'ON(T.FDO_NUMDOC = D.RLD_NUMDOC AND T.FDO_ESPDOC = D.RLD_ESPDOC AND T.FDO_CODEMP = D.RLD_CODEMP) ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN ROMLGE G ' + sLineBreak;
    LSQL := LSQL + 'ON(D.RLD_SEQRLG = G.AUTOINCREM) ' + sLineBreak;
    LSQL := LSQL + 'WHERE G.RLG_NUMLOT = :NUMLOT ' + sLineBreak;
    LSQL := LSQL + 'AND G.RLG_CODEMP = :CODEMP ';

    LQryTotal.Close;
    LQryTotal.SQL.Clear;
    LQryTotal.SQL.Add(LSQL);
    LQryTotal.ParamByName('NUMLOT').AsString := edtCodLot.Text;
    LQryTotal.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    LQryTotal.Open;

    if LQryTotal.IsEmpty then
      Exit;

    Result := LQryTotal.FieldByName('TOTITE').AsInteger;
  finally
    FreeAndNil(LQryTotal);
  end;
end;

function TfrmFatLotePedRom.fRetQtdLotDorPicking(strCodIte: string): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;

  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('SELECT SUM(LDO_QTDITE) AS QTDITE');
    qrySaldos.SQL.Add('FROM LOTDOR');
    qrySaldos.SQL.Add('INNER JOIN FATDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qrySaldos.SQL.Add('INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT AND LOT_CODITE = FDO_CODITE AND LOT_CODEMP = FDO_CODEMP');
    qrySaldos.SQL.Add('INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('WHERE FDO_CODITE = :CODITE');
    qrySaldos.SQL.Add('  AND FDO_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('  AND LOT_STATUS = "S"');
    qrySaldos.SQL.Add('  AND LOC_PICKIN = "S"');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
    begin
      Result := qrySaldos.FieldByName('QTDITE').AsFloat;
    end;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatLotePedRom.fRetQtdMovLotPicking(strCodIte: string): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;

  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;

    qrySaldos.SQL.Add('SELECT SUM(MLT_QTDMOV) AS QTDMOV');
    qrySaldos.SQL.Add('FROM MOVLOT');
    qrySaldos.SQL.Add('INNER JOIN CADLOT ON LOT_NUMLOT = MLT_LOTDES AND LOT_CODITE = MLT_CODITE AND LOT_CODEMP = MLT_CODEMP');
    qrySaldos.SQL.Add('INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('WHERE MLT_CODITE = :CODITE');
    qrySaldos.SQL.Add('  AND MLT_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('  AND LOT_STATUS = "S"');
    qrySaldos.SQL.Add('  AND LOC_PICKIN = "S"');
    qrySaldos.SQL.Add('  AND MLT_DTAREA IS NULL');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
    begin
      Result := qrySaldos.FieldByName('QTDMOV').AsFloat;
    end;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatLotePedRom.fRetSaldoLote(ACodIte,
  ANumLot, ACodEmp, ANumPed: String): TDadosEstoqueLote;
Var
  LQryCadLot: TUniQuery;
Begin
  result.fltSaldo := 0;
  result.fltSaldoReservado := 0;
  result.fltMovimentacaoEntrada := 0;
  result.fltMovimentacaoSaida := 0;

  LQryCadLot := fCriaQuery;
  try
    LQryCadLot.SQL.Add('SELECT * FROM CADLOT');
    LQryCadLot.SQL.Add('WHERE');
    LQryCadLot.SQL.Add('  LOT_CODITE = :CODITE AND ');
    LQryCadLot.SQL.Add('  LOT_NUMLOT = :NUMLOT AND ');
    LQryCadLot.SQL.Add('  LOT_CODEMP = :CODEMP     ');

    LQryCadLot.ParamByName('CODITE').AsString := ACodIte;
    LQryCadLot.ParamByName('NUMLOT').AsString := ANumLot;
    LQryCadLot.ParamByName('CODEMP').AsString := ACodEmp;

    LQryCadLot.Open;

    If not LQryCadLot.IsEmpty Then
    Begin
      result.fltSaldo := LQryCadLot.FieldByName('LOT_SALDOS').AsFloat;
      result.fltMovimentacaoEntrada := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(ACodIte, ANumLot, tmEntrada);

      //Quando nao tem saldo nao faz o select do saldo reservado para ficar mais rápido
      if (result.fltSaldo = 0) then
        if (result.fltMovimentacaoEntrada <= 0) then
          Exit;

      result.fltSaldoReservado := TSaldoReservado.New(
                                   TReservaParametros.New()
                                     .EmpresaItem(ACodEmp)
                                     .CodigoItem(ACodIte)
                                     .CodEmpresa(ACodEmp)
                                     .NumeroLote(ANumLot)
                                     .NumeroDocumento(ANumPed)
                                     .TipoFiltroDocumento(tfdIgnorarDocumento)
                                   ).fGetQuantidade();
      result.fltMovimentacaoSaida := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(ACodIte, ANumLot, tmSaida);
    End;
  finally
    FreeAndNil(LQryCadLot);
  end;
End;

function TfrmFatLotePedRom.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
        edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3);

      If fCfgSis('NOMEMP') = '2' Then
      Begin
        edtNomEmp.Text := fRetFantasiaEmpresa(edtCodEmp.Text);
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
      End;


      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Empresa!', ['&Ok']);
        Result := False;
      End

      Else If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodLot) Then
    Begin
      If Not fEmptyStr(edtCodLot.Text) Then
        edtCodLot.Text := fStrZero(edtCodLot.Text, 8);

      edtDesLot.Text := fRetDescLoteSeparacao(edtCodLot.Text, IIF(fEmptyStr(edtCodEmp.Text), VS_strCodEmp, edtCodEmp.Text));

      If fEmptyStr(edtCodLot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Lote de Separação!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtDesLot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Lote de Separação não encontrado!', ['&Ok']);
        Result := False;
      End
      Else
        pRetInfDoc(edtCodLot.Text, IIF(fEmptyStr(edtCodEmp.Text), VS_strCodEmp, edtCodEmp.Text));
    End

    Else If (Sender = edtSequencia) Then
    Begin
      If (edtSequencia.Enabled) Then
      Begin
        If (fEmptyStr(edtSequencia.Text)) Then
        Begin
          edtSequencia.Text := '0';
          Result := False;
        End;

        If (StrToIntDef(edtSequencia.Text,0) < 0) Then
        Begin
          edtSequencia.Text := '0';
          Result := False;
        End;

        If ((fRetornaTotalProdutosDistintos) < (StrToIntDef(edtSequencia.Text, 0))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de sequência não pode ser maior que a quantidade de produtos!', ['&Ok']);
          edtSequencia.Text :=  IntToStr(fRetornaTotalProdutosDistintos);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatLotePedRom.fValidaLoteSeparacao(ANumLot, ACodEmp: string): Boolean;
var
  qrySelect: TUniQuery;
begin
  Result := True;

  qrySelect := fCriaQuery;
  try
    qrySelect.Close;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('FROM ROMLGE');
    qrySelect.SQL.Add('INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('INNER JOIN ROMLIT ON RLI_SEQRLD = ROMLDE.AUTOINCREM');
    qrySelect.SQL.Add('WHERE RLG_CODEMP = :CODEMP');
    qrySelect.SQL.Add('  AND RLG_NUMLOT = :NUMLOT');
    qrySelect.SQL.Add('  AND RlI_JAFATU = 0');
    qrySelect.ParamByName('CODEMP').AsString := ACodEmp;
    qrySelect.ParamByName('NUMLOT').AsString := ANumLot;
    qrySelect.Open;

    if qrySelect.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'Não foi possível carregar o lote informado pois todos os itens estão baixados!', ['&Ok']);
      Exit(False);
    end;

    qrySelect.Close;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('FROM ROMLGE');
    qrySelect.SQL.Add('INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('WHERE RLG_CODEMP = :CODEMP');
    qrySelect.SQL.Add('  AND RLG_NUMLOT = :NUMLOT');
    qrySelect.SQL.Add('  AND (SELECT COUNT(*) FROM ROMLIT WHERE RLI_SEQRLD = ROMLDE.AUTOINCREM) = 0;');
    qrySelect.ParamByName('CODEMP').AsString := ACodEmp;
    qrySelect.ParamByName('NUMLOT').AsString := ANumLot;
    qrySelect.Open;

    if not qrySelect.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'Não foi possível carregar o lote informado, não há itens no documento!' + sLineBreak +
                            'Exclua o lote de separação e inclua um novo lote para os documentos!', ['&Ok']);
      Exit(False);
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

function TfrmFatLotePedRom.fValidaLotes: Boolean;
begin
  Result := True;

  if cdsDefineLote.IsEmpty then
    Exit;

  cdsDefineLote.Filtered := False;
  cdsDefineLote.Filter := 'NUMLOT = ''''';
  cdsDefineLote.Filtered := True;
  try
    if not cdsDefineLote.IsEmpty then
    begin
      if not fDefinirLotePedRom then
        Exit(False);
    end;

  finally
    cdsDefineLote.Filtered := False;
  end;


  if FAcao = TpAlterar then
  begin
    cdsDefineLote.Filtered := False;
    cdsDefineLote.Filter := 'NUMLOT <> ''''';
    cdsDefineLote.Filtered := True;
    try
      if not cdsDefineLote.IsEmpty then
      begin
        try
          fStartTransaction;
          cdsDefineLote.First;
          while not cdsDefineLote.Eof do
          begin
            if not fPreparaRegistroCadLot(
                     cdsDefineLoteCODITE.AsString,
                     cdsDefineLoteNUMLOT.AsString,
                     cdsLoteSepCODSEP.AsString,
                     edtCodLot.Text,
                     edtCodEmp.Text,
                     cdsLoteSepSEQSEP.AsInteger,
                     cdsDefineLoteQTDITE.AsFloat,
                     cdsDefineLoteAUTINC.AsString) then
            begin
              Result := False;
              fRollBack;
              Exit;
            end;

            cdsDefineLote.Next;
          end;

          Result := fCommit;
        except
          Result := False;
          fRollBack;
        end;
      end;
    finally
      cdsDefineLote.Filtered := False;
    end;
  end;
end;

function TfrmFatLotePedRom.fValidaSeparador(ACodOpe: string;
  var AMensagem: string): Boolean;
var
  LQrySeparador: TUniQuery;
begin
  Result := False;
  AMensagem := EmptyStr;

  LQrySeparador := fCriaQuery;

  try
    LQrySeparador.Close;
    LQrySeparador.SQL.Clear;
    LQrySeparador.SQL.Add('SELECT OPE_STATUS');
    LQrySeparador.SQL.Add('FROM CADOPE');
    LQrySeparador.SQL.Add('WHERE OPE_CODOPE = :CODOPE');

    LQrySeparador.ParamByName('CODOPE').AsString := ACodOpe;

    LQrySeparador.Open;

    if LQrySeparador.IsEmpty then
    begin
      AMensagem := 'Separador '+ACodOpe+' não cadastrado.';
      Exit;
    end;

    if LQrySeparador.FieldByName('OPE_STATUS').AsString <> 'A' then
    begin
      AMensagem := 'O separador '+ACodOpe+' está inativo.';
      Exit;
    end;

    Result := True;
  finally
    FreeAndNil(LQrySeparador);
  end;
end;

function TfrmFatLotePedRom.fValidaTodosSeparadores: Boolean;
var
  LMensagem: string;
begin
  Result := False;
  
  cdsLoteSep.DisableControls;

  try
    if not cdsLoteSep.Active then
      Exit;

    if cdsLoteSep.IsEmpty then
      Exit;

    cdsLoteSep.First;

    while not cdsLoteSep.Eof do
    begin
      if fEmptyStr(cdsLoteSepCODSEP.AsString) then
      begin
        LMensagem := 'É obrigatório preencher o separador de todos os sequenciais do grid antes de continuar.';
        fMensagem('ATENÇÃO!', LMensagem, ['&Ok']);
        Result := False;
        Exit;
      end;
    
      Result := fValidaSeparador(cdsLoteSepCODSEP.AsString, LMensagem);

      if not Result then
      begin
        fMensagem('ATENÇÃO!', LMensagem, ['&Ok']);
        Exit;
      end;

      cdsLoteSep.Next;
    end;
  finally
    cdsLoteSep.First;
    cdsLoteSep.EnableControls;
  end;
end;

function TfrmFatLotePedRom.fRetornaSaldoDisp(strCodIte, strIdePro: string; strPicking: string = ''): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;
  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('SELECT SUM(LOT_SALDOS) AS SALDOS');
    qrySaldos.SQL.Add('  FROM CADLOT');
    qrySaldos.SQL.Add('  JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add(' WHERE LOT_CODITE = :CODITE');
    qrySaldos.SQL.Add('   AND LOT_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('   AND LOT_STATUS = "S"');
    qrySaldos.SQL.Add('   AND LOT_NUMLOT <> "A DEFINIR"');

    //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
    if (blnExpedicao) and (not fVerificaAcessoSistema('WMSBUF')) then
    begin
      strPicking := 'S';
      qrySaldos.SQL.Add('   AND LOC_PICKIN = "' + strPicking + '"');
    end
    else
    begin
      if (fCfgSis('WMSPIC', varBoolean)) and (not fCfgSis('MOSPUL', varBoolean)) then
      begin
        if fEmptyStr(strPicking) then
          strPicking := 'S';

        qrySaldos.SQL.Add('   AND LOC_PICKIN = "' + strPicking + '"');
      end;
    end;

    If fUsaRotinaWMS Then
      qrySaldos.SQL.Add('AND IFNULL(LOC_PICKIN,"N") <> "E"');

    qrySaldos.SQL.Add('   AND IFNULL(LOC_CRITIC,"N") = "N"');
    qrySaldos.SQL.Add('   AND IFNULL(LOC_TRANSI,"N") = "N"');
    qrySaldos.SQL.Add('   AND IFNULL(LOC_BALCAO,"N") = "N"');
    qrySaldos.SQL.Add('   AND LOT_STATUS = "S"');

    If (fEhTintaAutomotiva(strIdePro)) Then
      qrySaldos.SQL.Add('  AND IFNULL(LOT_PRITIN,"N") = "S"  ');

    qrySaldos.SQL.Add('   AND LOT_SALDOS > 0');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
      Result := qrySaldos.FieldByName('SALDOS').AsFloat;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatLotePedRom.fRetornaLote(strCodIte: string; strPicking: string = ''; blnLocFis: Boolean = False): String;
var
  qrySaldos: TUniQuery;
  strSelect: String;
begin
  Result := '';

  strSelect := '';
  strSelect := strSelect + ' SELECT ';
  if blnLocFis then
    strSelect := strSelect + '   LOC_CODLOC AS NUMLOT'
  else
    strSelect := strSelect + '   LOT_NUMLOT AS NUMLOT';
  strSelect := strSelect + ' FROM CADLOT';
  strSelect := strSelect + ' JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP';
  strSelect := strSelect + ' WHERE LOT_CODITE = :CODITE';
  strSelect := strSelect + '   AND LOT_CODEMP = :CODEMP';
  strSelect := strSelect + '   AND LOT_STATUS = "S"';
  strSelect := strSelect + '   AND LOT_NUMLOT <> "A DEFINIR"';
  strSelect := strSelect + '   AND IFNULL(LOC_CRITIC,"N") = "N"';
  strSelect := strSelect + '   AND IFNULL(LOC_TRANSI,"N") = "N"';
  strSelect := strSelect + '   AND IFNULL(LOC_BALCAO,"N") = "N"';
  strSelect := strSelect + '   AND LOT_PRITIN <> "S"';

  //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
  if (blnExpedicao) and (not fVerificaAcessoSistema('WMSBUF')) then
  begin
    strPicking := 'S';
    strSelect := strSelect + '   AND LOC_PICKIN = "' + strPicking + '"';
  end
  else
  begin
    if (fCfgSis('WMSPIC', varBoolean)) and (not fCfgSis('MOSPUL', varBoolean)) then
    begin
      if fEmptyStr(strPicking) then
        strPicking := 'S';

      strSelect := strSelect + '   AND LOC_PICKIN = "' + strPicking + '"';
    end;
  end;

  If fUsaRotinaWMS Then
    strSelect := strSelect + '  AND (IFNULL(LOC_PICKIN,"N") <> "E") ';


  qrySaldos := fCriaQuery;
  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add(strSelect);
    qrySaldos.SQL.Add('AND LOT_SALDOS > 0');

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if qrySaldos.IsEmpty then
    begin
      qrySaldos.Close;
      qrySaldos.SQL.Clear;
      qrySaldos.SQL.Add(strSelect);

      qrySaldos.ParamByName('CODITE').AsString := strCodIte;
      qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qrySaldos.Open;
    end;

    Result := qrySaldos.FieldByName('NUMLOT').AsString;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatLotePedRom.fVerificarMovimentacaoProgramada: Boolean;
var
  arrMovProg: TArrayItemMovProg;
begin
  Result := True;

  if fCfgSis('WMSMOV', varBoolean) then
    Exit;

  arrMovProg := fMontaArrMovProg;

  if Length(arrMovProg) > 0 then
  begin
    If (fMensagem('Atenção!',
                  'Há produtos que não tem saldo suficiente no picking mas tem no buffer.' + sLineBreak +
                  'Deseja abrir a tela de geração de movimentação programada para realizar a transferência entre as localizações?',
                  ['&Sim', '&Não']) = 1) Then
    begin
      if not fVerificaAcessoSistema('frmMovimentacaoProgramadaManual') then
      begin
        fMensagem('ATENÇÃO!', 'Operador não possui acesso liberado à rotina de geração de movimentação programada. ' +
                  'Verifique o acesso com o responsável e depois tente novamente.', ['&Ok']);
        Result := False;
      end
      else
      begin
        Result := fTravaMovProgramada;
        try
          if not Result then
            Exit;

          Result := fMovimentacaoProgramadaManual(arrMovProg);
        finally
          objLockMovProg.pDestravarTodos;
        end;
      end;
    end;
  end;

end;

procedure TfrmFatLotePedRom.grdLoteSepDBTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  LColuna: TcxCustomGridTableItem;
  arrSel : TConsultasArray;
begin
  inherited;
  if key = '/' then
  begin
    LColuna := Sender.FindItemByName(Sender.Name + 'CODSEP');
    if AItem = LColuna then
    begin
      if fPesqOperador(Self, nil, nil, nil, key, arrSel, True, True) then
      begin
        TcxGridDBBandedTableView(Sender).DataController.DataSet.Edit;
        TcxGridDBBandedColumn(LColuna).DataBinding.Field.AsString := arrSel[0].strCodigo;
      end;
    end;
  end;
end;


procedure TfrmFatLotePedRom.grdLoteSepDBTableViewOPESEPPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  case AButtonIndex of
    0: Begin
         grdLoteSepDBTableViewCODSEP.Options.Editing := True;
         grdLoteSepDBTableViewCODSEP.FocusWithSelection;
         btnConfirma.Enabled := True;
       End;
    1: pImprimeSeparacao(edtCodLot.Text, edtCodEmp.Text, cdsLoteSepCODSEP.AsString, cdsLoteSepSEQSEP.AsInteger);
    2: pLimpaSeparacao;
  end;
end;

function TfrmFatLotePedRom.fAlteraExtDor(AAutInc, ACodSep: string;
  ASeqSep: integer): Boolean;
var
  LQryExtDor: TUniQuery;
begin
  Result := False;
  LQryExtDor := fCriaQuery;

  try
    try
      LQryExtDor.Close;
      LQryExtDor.SQL.Clear;
      LQryExtDor.SQL.Add('UPDATE EXTDOR');
      LQryExtDor.SQL.Add('SET FDO_OPESEP = :CODSEP,');
      LQryExtDor.SQL.Add('    FDO_SEQSEP = :SEQSEP');
      LQryExtDor.SQL.Add('WHERE FDO_SEQFDO = :AUTINC');

      LQryExtDor.ParamByName('CODSEP').AsString := ACodSep;
      LQryExtDor.ParamByName('SEQSEP').AsInteger := ASeqSep;
      LQryExtDor.ParamByName('AUTINC').AsString := AAutInc;

      LQryExtDor.ExecSQL;

      Result := True;
    except
      On E: Exception Do
        Showmessage(E.Message);
    end;
  finally
    FreeAndNil(LQryExtDor);
  end;
end;

function TfrmFatLotePedRom.fAlteraExtDorLotDor(ASeqSep: integer;
  ACodSep: string): Boolean;
var
  LQryAltera: TUniQuery;
  LSQL: string;
begin
  LSQL := EmptyStr;
  LQryAltera := fCriaQuery;

  try
    Result := False;

    LSQL := LSQL + 'UPDATE EXTDOR E ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN LOTDOR L ' + sLineBreak;
    LSQL := LSQL + 'ON(E.FDO_SEQFDO = L.LDO_SEQFDO) ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN FATDOR T ' + sLineBreak;
    LSQL := LSQL + 'ON(T.AUTOINCREM = E.FDO_SEQFDO) ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN ROMLDE D ' + sLineBreak;
    LSQL := LSQL + 'ON(T.FDO_NUMDOC = D.RLD_NUMDOC AND T.FDO_ESPDOC = D.RLD_ESPDOC AND T.FDO_CODEMP = D.RLD_CODEMP) ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN ROMLGE G ' + sLineBreak;
    LSQL := LSQL + 'ON(G.AUTOINCREM = D.RLD_SEQRLG) ' + sLineBreak;
    LSQL := LSQL + 'SET E.FDO_OPESEP = :CODSEP, ' + sLineBreak;
    LSQL := LSQL + 'L.LDO_CODSEP = :CODSEP ' + sLineBreak;
    LSQL := LSQL + 'WHERE G.RLG_NUMLOT = :NUMDOC ' + sLineBreak;
    LSQL := LSQL + 'AND G.RLG_CODEMP = :CODEMP ' + sLineBreak;
    LSQL := LSQL + 'AND E.FDO_SEQSEP = :SEQSEP ' + sLineBreak;
    LSQL := LSQL + 'AND E.FDO_OPBXSE IS NULL ';

    LQryAltera.Close;
    LQryAltera.SQL.Clear;
    LQryAltera.SQL.Add(LSQL);
    LQryAltera.ParamByName('CODSEP').AsString := ACodSep;
    LQryAltera.ParamByName('SEQSEP').AsInteger := ASeqSep;
    LQryAltera.ParamByName('NUMDOC').AsString := edtCodLot.Text;
    LQryAltera.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    LQryAltera.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryAltera);
  end;
end;

function TfrmFatLotePedRom.fAlteraLoteSeparacao(ASeqSep: integer;
  ACodSep: string): Boolean;
var
  LQryAltera: TUniQuery;
  LSQL: string;
begin

  LSQL := EmptyStr;
  LQryAltera := fCriaQuery;

  try
    Result := False;

    LSQL := LSQL + 'UPDATE SLPDOC D ' + sLineBreak;
    LSQL := LSQL + 'INNER JOIN SLPROM R ' + sLineBreak;
    LSQL := LSQL + 'ON D.DOC_SEQROM = R.AUTOINCREM ' + sLineBreak;
    LSQL := LSQL + 'SET DOC_CODSEP = :CODSEP ' + sLineBreak;
    LSQL := LSQL + 'WHERE R.ROM_NUMLOT = :NUMDOC ' + sLineBreak;
    LSQL := LSQL + 'AND R.ROM_CODEMP = :CODEMP ' + sLineBreak;
    LSQL := LSQL + 'AND D.DOC_SEQSEP = :CODSEQ ';

    LQryAltera.Close;
    LQryAltera.SQL.Clear;
    LQryAltera.SQL.Add(LSQL);
    LQryAltera.ParamByName('CODSEP').AsString := ACodSep;
    LQryAltera.ParamByName('NUMDOC').AsString := edtCodLot.Text;
    LQryAltera.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    LQryAltera.ParamByName('CODSEQ').AsInteger := ASeqSep;
    LQryAltera.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryAltera);
  end;
end;

function TfrmFatLotePedRom.fAlteraSeparador: TResulAlt;
begin
  Result := TpVazio;
  cdsLoteSep.First;
  cdsLoteSep.DisableControls;

  try
    while not cdsLoteSep.Eof do
    begin
      if cdsLoteSepCODSEP.OldValue <> cdsLoteSepCODSEP.Value then
      begin
        if not fAlteraLoteSeparacao(cdsLoteSepSEQSEP.AsInteger, cdsLoteSepCODSEP.AsString) then
        begin
          Result := TpErro;
          Exit;
        end;

        if not fAlteraExtDorLotDor(cdsLoteSepSEQSEP.AsInteger, cdsLoteSepCODSEP.AsString) then
        begin
          Result := TpErro;
          Exit;
        end;

        if not fGravaLogAlteracao(VarToStr(cdsLoteSepCODSEP.OldValue), VarToStr(cdsLoteSepCODSEP.Value)) then
        begin
          Result := TpErro;
          Exit;
        end;

        Result := TpAlterou;
      end;
      cdsLoteSep.Next;
    end;
  finally
    cdsLoteSep.First;
    cdsLoteSep.EnableControls;
  end;
end;

function TfrmFatLotePedRom.fAtualizaLote(AfrmDefinirLotePedRom: TfrmDefinirLotePedRom): Boolean;
var
  strSeqFdo: String;
begin
  try
    fStartTransaction;
    strSeqFdo := '';

    AfrmDefinirLotePedRom.cdsDefineLote.First;
    while not AfrmDefinirLotePedRom.cdsDefineLote.Eof do
    begin
      AfrmDefinirLotePedRom.cdsLotesSel.Filter := 'AUTINC = ' + QuotedStr(AfrmDefinirLotePedRom.cdsDefineLoteAUTINC.AsString);
      AfrmDefinirLotePedRom.cdsLotesSel.Filtered := True;
      try

        while not AfrmDefinirLotePedRom.cdsLotesSel.Eof do
        begin
          strSeqFdo := strSeqFdo + AfrmDefinirLotePedRom.cdsLotesSelAUTINC.AsString + ',';

          AfrmDefinirLotePedRom.cdsLotesSel.Next;
        end;

      finally
        AfrmDefinirLotePedRom.cdsLotesSel.Filtered := False;
      end;

      AfrmDefinirLotePedRom.cdsDefineLote.Next;
    end;

    if not fEmptyStr(strSeqFdo) then
    begin
      Delete(strSeqFdo, Length(strSeqFdo), 1);

      if not fLimpaLOTDOR(strSeqFdo, edtCodLot.Text, edtCodEmp.Text) then
      begin
        Result := False;
        fRollBack;
        Exit;
      end;
    end;

    AfrmDefinirLotePedRom.cdsDefineLote.First;
    while not AfrmDefinirLotePedRom.cdsDefineLote.Eof do
    begin
      AfrmDefinirLotePedRom.cdsLotesSel.Filter := 'AUTINC = ' + QuotedStr(AfrmDefinirLotePedRom.cdsDefineLoteAUTINC.AsString);
      AfrmDefinirLotePedRom.cdsLotesSel.Filtered := True;
      try

        while not AfrmDefinirLotePedRom.cdsLotesSel.Eof do
        begin

          if not fPreparaRegistroCadLot(
                   AfrmDefinirLotePedRom.cdsLotesSelCODITE.AsString,
                   AfrmDefinirLotePedRom.cdsLotesSelNUMLOT.AsString,
                   cdsLoteSepCODSEP.AsString,
                   edtCodLot.Text,
                   edtCodEmp.Text,
                   cdsLoteSepSEQSEP.AsInteger,
                   AfrmDefinirLotePedRom.cdsLotesSelQTDLOT.AsFloat,
                   AfrmDefinirLotePedRom.cdsDefineLoteAUTINC.AsString) then
          begin
            Result := False;
            fRollBack;
            Exit;
          end;

          AfrmDefinirLotePedRom.cdsLotesSel.Next;
        end;

      finally
        AfrmDefinirLotePedRom.cdsLotesSel.Filtered := False;
      end;

      AfrmDefinirLotePedRom.cdsDefineLote.Next;
    end;

    Result := fCommit;
  except
    Result := False;
    fRollBack;
  end;
end;

procedure TfrmFatLotePedRom.pCarregaLotesBuffer(strCodIte: string;
  qyrSelect: TUniQuery);
begin
  qyrSelect.Close;
  qyrSelect.SQL.Clear;
  qyrSelect.SQL.Add('SELECT LOT_NUMLOT, LOT_SALDOS');
  qyrSelect.SQL.Add('  FROM CADLOT');
  qyrSelect.SQL.Add('  JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
  qyrSelect.SQL.Add(' WHERE LOT_CODITE = :CODITE');
  qyrSelect.SQL.Add('   AND LOT_CODEMP = :CODEMP');
  qyrSelect.SQL.Add('   AND LOT_STATUS = "S"');
  qyrSelect.SQL.Add('   AND LOT_NUMLOT <> "A DEFINIR"');
  qyrSelect.SQL.Add('   AND LOC_PICKIN = "N"');
  qyrSelect.SQL.Add('   AND IFNULL(LOC_CRITIC,"N") = "N"');
  qyrSelect.SQL.Add('   AND IFNULL(LOC_TRANSI,"N") = "N"');
  qyrSelect.SQL.Add('   AND IFNULL(LOC_BALCAO,"N") = "N"');
  qyrSelect.SQL.Add('   AND LOT_PRITIN <> "S"');
  qyrSelect.SQL.Add('   AND LOT_SALDOS > 0');
  qyrSelect.SQL.Add(' ORDER BY LOT_DTAVAL, LOT_SALDOS ');

  qyrSelect.ParamByName('CODITE').AsString := strCodIte;
  qyrSelect.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qyrSelect.Open;
end;

procedure TfrmFatLotePedRom.pCarregaMovimentacao(ACodEmp,
  ANumLot: string);
var
  LQryMovimento: TUniQuery;
  AAutInc,
  LSQL: string;
  ANumSeq: integer;
begin
  objLock.pDestravarTodos;

  LSQL := EmptyStr;
  LQryMovimento := fCriaQuery;

  try
    cdsLoteSep.DisableControls;
    cdsLoteSep.EmptyDataSet;
    edtSequencia.Enabled := True;
    btnSequencia.Enabled := True;
    grdLoteSepDBTableViewOPESEP.Options.ShowEditButtons := isebNever;
    grdLoteSepDBTableViewOPESEP.Options.Editing:= False;
    grdLoteSepDBTableViewCODSEP.Options.Editing:= True;
    btnConfirma.Enabled := True;

    LSQL := LSQL + 'SELECT * FROM SLPROM ' + sLineBreak;
    LSQL := LSQL + 'WHERE ROM_CODEMP = :CODEMP ' + sLineBreak;
    LSQL := LSQL + 'AND ROM_NUMLOT = :NUMLOT ' + sLineBreak;

    LQryMovimento.Close;
    LQryMovimento.SQL.Clear;
    LQryMovimento.SQL.Add(LSQL);
    LQryMovimento.ParamByName('CODEMP').AsString := ACodEmp;
    LQryMovimento.ParamByName('NUMLOT').AsString := ANumLot;
    LQryMovimento.Open;

    if LQryMovimento.IsEmpty then
      Exit;

    AAutInc := LQryMovimento.FieldByName('AUTOINCREM').AsString;
    ANumSeq := LQryMovimento.FieldByName('ROM_QTDSEQ').AsInteger;

    LQryMovimento.Close;
    LQryMovimento.SQL.Clear;
    LQryMovimento.SQL.Add('SELECT * FROM SLPDOC');
    LQryMovimento.SQL.Add('WHERE DOC_SEQROM = :AUTINC');
    LQryMovimento.ParamByName('AUTINC').AsString := AAutInc;
    LQryMovimento.Open;

    if LQryMovimento.IsEmpty then
      Exit;

    if not fTravaLoteSeparacao then
    begin
      pLimpaDoc;
      Exit;
    end;

    while not LQryMovimento.Eof do
    begin
      cdsLoteSep.Append;
      cdsLoteSepSEQSEP.AsInteger := LQryMovimento.FieldByName('DOC_SEQSEP').AsInteger;
      cdsLoteSepCODSEP.AsString := LQryMovimento.FieldByName('DOC_CODSEP').AsString;
      cdsLoteSep.Post;
      LQryMovimento.Next;
    end;

    edtSequencia.Text := IntToStr(ANumSeq);
    edtSequencia.Enabled := False;
    btnSequencia.Enabled := False;
    grdLoteSepDBTableViewOPESEP.Options.ShowEditButtons := isebAlways;
    grdLoteSepDBTableViewOPESEP.Options.Editing:= True;
    grdLoteSepDBTableViewCODSEP.Options.Editing:= False;
    btnConfirma.Enabled := False;
    FAcao := TpAlterar;
  finally
    cdsLoteSep.EnableControls;
    FreeAndNil(LQryMovimento);
  end;
end;

procedure TfrmFatLotePedRom.pConfirma;
begin
  if fVerificaCampos then
  begin
    if fValidaTodosSeparadores then
    begin
      if not fVerificarMovimentacaoProgramada then
        Exit;

      pDefineLotesItens(edtCodLot.Text, edtCodEmp.Text);
      if fValidaLotes then
      begin
        pDefineSeparadorPorItem;
        pGravaMovimentacao;

        If fImprimeOrdemDeProducao(True) Then
          pImprimeOrdemDeProducao(edtCodLot.Text, edtCodEmp.Text, cdsLoteSepCODSEP.AsString, cdsLoteSepSEQSEP.AsInteger);
      end;
    end;
    pSetFocus(edtCodEmp);
  end;
end;

procedure TfrmFatLotePedRom.pCriaSeparacao;
var
  LTotal,
  LContador: integer;
begin
  LTotal := StrToIntDef(edtSequencia.Text, 0);

  if LTotal < 1 then
    exit;

  cdsLoteSep.DisableControls;

  try
    cdsLoteSep.EmptyDataSet;
    for LContador := 1 to LTotal do
    begin
      cdsLoteSep.Append;
      cdsLoteSepSEQSEP.AsInteger := LContador;
      cdsLoteSep.Post;
    end;
    edtSequencia.Enabled := False;
    btnSequencia.Enabled := False;

  finally
    cdsLoteSep.First;
    cdsLoteSep.EnableControls;

    if not cdsLoteSep.IsEmpty then
    begin
      pSetFocus(grdLoteSep);
      //grdLoteSepDBTableView.GetColumnByFieldName('CODSEP').FocusWithSelection;
    end;
  end;
end;

procedure TfrmFatLotePedRom.pDefineLotesItens(ANumRom, ACodEmp: String);
var
  LSQL: string;
  blnUsaWMSRastreavelTinta: Boolean;
  intIndex: Integer;
  objDefineLotes: TDefineLotesWMS;
  cdsLotSel: TUniClientDataSet;
begin
  cdsDefineLote.EmptyDataSet;
  LSQL := EmptyStr;

  blnUsaWMSRastreavelTinta := fUsaRotinaWMS And
                            (fCfgSis('TMWMSR', varBoolean)) And
                            (fCfgSis('EXIDOC') = 'PD');

  objDefineLotes := TDefineLotesWMS.CreateInstance(Self, ANumRom, ACodEmp, blnUsaWMSRastreavelTinta, True);
  try
    qryConsulta.Close;
    cdsConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(objDefineLotes.fGetSqlItensPedido);
    qryConsulta.Open;

    If Assigned(dspConsulta.DataSet) Then
      pSetaClient(dspConsulta.DataSet);

    cdsConsulta.Open;

    For intIndex := 0 To cdsConsulta.FieldDefs.Count - 1 Do
      cdsConsulta.FieldDefs[intIndex].Required := FALSE;

    objDefineLotes.pAtualizaLotes(cdsConsulta, True);

    qryConsulta.First;
    while not qryConsulta.Eof do
    begin
      objDefineLotes.pCarregaLotesDigitados(
        qryConsulta.FieldByName('FDO_CODITE').AsString,
        qryConsulta.FieldByName('AUTOINCREM').AsString,
        cdsLotSel);

      if cdsLotSel.IsEmpty then
      begin
        cdsDefineLote.Append;
        cdsDefineLoteCODITE.AsString := qryConsulta.FieldByName('FDO_CODITE').AsString;
        cdsDefineLoteDESITE.AsString := qryConsulta.FieldByName('FDO_DESCRI').AsString;
        cdsDefineLoteQTDITE.AsFloat  := qryConsulta.FieldByName('FDO_QTDITE').AsFloat;
        cdsDefineLoteNUMDOC.AsString := fRetDocumentos(ANumRom, ACodEmp, qryConsulta.FieldByName('FDO_CODITE').AsString);
        cdsDefineLoteNUMLOT.AsString := '';
        cdsDefineLoteAUTINC.AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        cdsDefineLote.Post;
      end
      else
      begin
        while not cdsLotSel.Eof do
        begin
          cdsDefineLote.Append;
          cdsDefineLoteCODITE.AsString := qryConsulta.FieldByName('FDO_CODITE').AsString;
          cdsDefineLoteDESITE.AsString := qryConsulta.FieldByName('FDO_DESCRI').AsString;
          cdsDefineLoteQTDITE.AsFloat  := cdsLotSel.FieldByName('QTDITE').AsFloat;
          cdsDefineLoteNUMDOC.AsString := fRetDocumentos(ANumRom, ACodEmp, qryConsulta.FieldByName('FDO_CODITE').AsString);
          cdsDefineLoteNUMLOT.AsString := cdsLotSel.FieldByName('NUMLOT').AsString;
          cdsDefineLoteAUTINC.AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
          cdsDefineLote.Post;

          cdsLotSel.Next;
        end;

      end;

      qryConsulta.Next;
    end;
  finally
    FreeAndNil(objDefineLotes);
  end;

  if not cdsDefineLote.IsEmpty then
    cdsDefineLote.IndexFieldNames := 'NUMLOT';
end;

procedure TfrmFatLotePedRom.pDefineSeparadorPorItem;
var
  LContador,
  LPorporcao: integer;
begin
  LPorporcao := Ceil(cdsDefineLote.RecordCount / cdsLoteSep.RecordCount);
  LContador := 0;

  cdsDefineLote.DisableControls;

  try
    cdsDefineLote.First;
    cdsLoteSep.First;

    while not cdsDefineLote.Eof do
    begin
      Inc(LContador);

      cdsDefineLote.Edit;
      cdsDefineLoteCODSEP.AsString := cdsLoteSepCODSEP.AsString;
      cdsDefineLoteSEQSEP.AsInteger := cdsLoteSepSEQSEP.AsInteger;
      cdsDefineLote.Post;

      if LContador = LPorporcao then
      begin
        LContador := 0;
        cdsLoteSep.Next;
      end;

      cdsDefineLote.Next;
    end;
  finally
    cdsDefineLote.First;
    cdsDefineLote.EnableControls;
  end;
end;

function TfrmFatLotePedRom.fDefinirLotePedRom: Boolean;
var
  LfrmDefinirLotePedRom: TfrmDefinirLotePedRom;
begin
  pCriarFormularios(TfrmDefinirLotePedRom, LfrmDefinirLotePedRom);
  try
    pCloneDataSet(LfrmDefinirLotePedRom.cdsDefineLote, cdsDefineLote);
    LfrmDefinirLotePedRom.FCodLot := edtCodLot.Text;
    LfrmDefinirLotePedRom.FCodEmp := edtCodEmp.Text;
    Result := LfrmDefinirLotePedRom.ShowModal = MrOk;

    if Result then
      Result := fAtualizaLote(LfrmDefinirLotePedRom);
  finally
    pFreeAndNil(LfrmDefinirLotePedRom);
  end;
end;

procedure TfrmFatLotePedRom.pGravaMovimentacao;
begin
  if fGravaMovimentacao then
  begin
    grdLoteSepDBTableViewOPESEP.Options.ShowEditButtons := isebAlways;
    grdLoteSepDBTableViewOPESEP.Options.Editing := True;
    grdLoteSepDBTableViewCODSEP.Options.Editing := False;
    btnConfirma.Enabled := False;
    if FAcao = TpInserir then
    begin
      FAcao := TpAlterar;
      fMensagem('ATENÇÃO!', 'Gravação efetuada com sucesso!', ['&Ok']);
    end;
  end
  else
  begin
    if FAcao = TpInserir then
      fMensagem('ATENÇÃO!', 'Ocorreu um erro na gravação da movimentação!', ['&Ok']);
  end;
end;

procedure TfrmFatLotePedRom.pImprimeOrdemDeProducao(ANumLot, ACodEmp,
  ACodSep: String; ASeqSep: Integer);
Var
  oprOdemProducao: TFatOrdProTintaMaquina;
  strMsgOpr: String;
  qryDocs: TUniQuery;
begin
  qryDocs := fCriaQuery();
  Try
    qryDocs.SQL.Add('  SELECT                                ');
    qryDocs.SQL.Add('    FDO_NUMDOC NUMDOC,                  ');
    qryDocs.SQL.Add('    FDO_ESPDOC ESPDOC,                  ');
    qryDocs.SQL.Add('    FDO_CODEMP CODEMP,                  ');
    qryDocs.SQL.Add('    FDO_CODCLI CODCLI                   ');
    qryDocs.SQL.Add('  FROM                                  ');
    qryDocs.SQL.Add('    EXTDOR E                            ');
    qryDocs.SQL.Add('    INNER JOIN FATDOR T                 ');
    qryDocs.SQL.Add('      ON  T.AUTOINCREM = E.FDO_SEQFDO   ');
    qryDocs.SQL.Add('    INNER JOIN ROMLDE D                 ');
    qryDocs.SQL.Add('      ON  T.FDO_NUMDOC = D.RLD_NUMDOC   ');
    qryDocs.SQL.Add('      AND T.FDO_ESPDOC = D.RLD_ESPDOC   ');
    qryDocs.SQL.Add('      AND T.FDO_CODEMP = D.RLD_CODEMP   ');
    qryDocs.SQL.Add('    INNER JOIN ROMLGE G                 ');
    qryDocs.SQL.Add('      ON (G.AUTOINCREM = D.RLD_SEQRLG)  ');
    qryDocs.SQL.Add('  WHERE G.RLG_NUMLOT =:NUMLOT           ');
    qryDocs.SQL.Add('    AND G.RLG_CODEMP =:CODEMP           ');
    qryDocs.SQL.Add('    AND E.FDO_SEQSEP =:SEQSEP           ');
    qryDocs.SQL.Add('  GROUP BY                              ');
    qryDocs.SQL.Add('    FDO_NUMDOC,                         ');
    qryDocs.SQL.Add('    FDO_ESPDOC,                         ');
    qryDocs.SQL.Add('    FDO_CODEMP,                         ');
    qryDocs.SQL.Add('    FDO_CODCLI                          ');
    qryDocs.ParamByName('NUMLOT').AsString  := ANumLot;
    qryDocs.ParamByName('CODEMP').AsString  := ACodEmp;
    qryDocs.ParamByName('SEQSEP').AsInteger := ASeqSep;
    qryDocs.Open;

    qryDocs.First;
    While Not qryDocs.Eof Do
    Begin
      If Pos(qryDocs.FieldByName('ESPDOC').AsString, 'OR_PD_') > 0 Then
        strMsgOpr := 'Imprimir ordem de produção preliminar'
      Else
        strMsgOpr := 'Imprimir ordem de produção';

      strMsgOpr := strMsgOpr + ' do documento: ' + qryDocs.FieldByName('NUMDOC').AsString + '-' +
                                                   qryDocs.FieldByName('ESPDOC').AsString + '-' +
                                                   qryDocs.FieldByName('CODEMP').AsString + '?';

      oprOdemProducao := TFatOrdProTintaMaquina.Create;
      oprOdemProducao.pSetaDocumento(qryDocs.FieldByName('NUMDOC').AsString,
                                     qryDocs.FieldByName('ESPDOC').AsString,
                                     qryDocs.FieldByName('CODEMP').AsString,
                                     qryDocs.FieldByName('CODCLI').AsString,
                                     VS_strCodEmp,
                                     '',  //codaca
                                     ''); //empaca
      Try
        If (oprOdemProducao.blnTemFormula) Then
        Begin
          If (fMensagem('ATENÇÃO!', strMsgOpr, ['&Sim', '&Não']) = 1) Then
          Begin
            oprOdemProducao.pImprimeOrdProdTmp;
          End;
        End;
      Finally
        FreeAndNil(oprOdemProducao);
      End;

      qryDocs.Next;
    End;
  Finally
    FreeAndNil(qryDocs);
  End;
end;

procedure TfrmFatLotePedRom.pImprimeSeparacao(ANumLot, ACodEmp, ACodSep: string; ASeqSep: integer);
begin
  TfrmQckLoteSeparacaoWMS.pImprime(ANumLot, ACodEmp, ACodSep, ASeqSep);

  If fImprimeOrdemDeProducao Then
    pImprimeOrdemDeProducao(ANumLot, ACodEmp, ACodSep, ASeqSep);
end;

procedure TfrmFatLotePedRom.pLimpaDoc;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodLot.Clear;
  edtDesLot.Clear;
  lblQtdDocVlr.Caption := '99999';
  lblQtdDocVlr.Visible := False;
  lblQtdProVlr.Caption := '0000,0000';
  lblQtdProVlr.Visible := False;
  lblProDisVlr.Caption := '0';
  lblProDisVlr.Visible := False;
  lblPesBruVlr.Caption := '0,000';
  lblPesBruVlr.Visible := False;
  lblPesLiqVlr.Caption := '0,000';
  lblPesLiqVlr.Visible := False;
  edtSequencia.Clear;
  edtSequencia.Enabled := False;
  btnSequencia.Enabled := False;
  pSetFocus(edtCodEmp);

  objLock.pDestravarTodos;
  objLockMovProg.pDestravarTodos;
end;

procedure TfrmFatLotePedRom.pLimpaSeparacao;
begin
  If fMensagem('', 'Deseja limpar a separação?', ['&Sim', '&Não'], 2) = 1 Then
  begin
    if fLimpaSeparacao(cdsLoteSepSEQSEP.AsInteger, cdsLoteSepCODSEP.AsString) then
    begin
      fMensagem('ATENÇÃO!', 'Separação limpa com sucesso!', ['&Ok']);
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'Erro ao limpar separação!', ['&Ok']);
    end;
  end;
end;

procedure TfrmFatLotePedRom.pPreencheInfDoc(AQtdDoc: integer; AQtdIte, APesBru,
  APesLiq: Double);
begin
  lblQtdDocVlr.Caption := IntToStr(AQtdDoc);
  lblQtdDocVlr.Visible := True;
  lblQtdProVlr.Caption := FloatToStrF(AQtdIte, ffFixed,12, fCfgSis('DECQTD', varInteger));
  lblQtdProVlr.Visible := True;
  lblProDisVlr.Caption := IntToStr(fRetornaTotalProdutosDistintos);
  lblProDisVlr.Visible := True;
  lblPesBruVlr.Caption := FloatToStrF(APesBru, ffFixed,12, fCfgSis('DECBRU', varInteger));
  lblPesBruVlr.Visible := True;
  lblPesLiqVlr.Caption := FloatToStrF(APesLiq, ffFixed,12, 3);
  lblPesLiqVlr.Visible := True;
  edtSequencia.Enabled := cdsLoteSep.IsEmpty;
  btnSequencia.Enabled := edtSequencia.Enabled;
  pSetFocus(edtSequencia);
end;

procedure TfrmFatLotePedRom.pRetInfDoc(ANumLot, ACodEmp: string);
var
  LQryDoc: TUniQuery;
  LQtdDoc: integer;
  LQtdIte,
  LPesBru,
  LPesLiq: Double;
  LSQL,
  LDocumentos: String;
begin
  LQtdDoc := 0;
  LQtdIte := 0;
  LPesBru := 0;
  LPesLiq := 0;
  LSQL := EmptyStr;
  LDocumentos := EmptyStr;

  LQryDoc := fCriaQuery;

  LSQL := LSQL + 'SELECT F.AUTOINCREM ' + sLineBreak;
  LSQL := LSQL + 'FROM FATGOR F ' + sLineBreak;
  LSQL := LSQL + 'INNER JOIN ROMLDE D ' + sLineBreak;
  LSQL := LSQL + 'ON(F.FGO_NUMDOC = D.RLD_NUMDOC AND F.FGO_ESPDOC = D.RLD_ESPDOC AND F.FGO_CODEMP = D.RLD_CODEMP) ' + sLineBreak;
  LSQL := LSQL + 'INNER JOIN ROMLGE G ' + sLineBreak;
  LSQL := LSQL + 'ON(D.RLD_SEQRLG = G.AUTOINCREM) ' + sLineBreak;
  LSQL := LSQL + 'WHERE G.RLG_NUMLOT = :NUMLOT ' + sLineBreak;
  LSQL := LSQL + 'AND G.RLG_CODEMP = :CODEMP ';

  try
    LQryDoc.Close;
    LQryDoc.SQL.Clear;
    LQryDoc.SQL.Add(LSQL);
    LQryDoc.ParamByName('NUMLOT').AsString := ANumLot;
    LQryDoc.ParamByName('CODEMP').AsString := ACodEmp;
    LQryDoc.Open;

    if LQryDoc.IsEmpty then
    begin
      pLimpaDoc;
      fMensagem('ATENÇÃO','Lote de separação não encontrado!',['&OK']);
    end
    else
    begin
      while not LQryDoc.Eof do
      begin
        Inc(LQtdDoc);
        pIncrementaListaStr(LQryDoc.FieldByName('AUTOINCREM').AsString, LDocumentos, True, True, ',', False, False);
        LQryDoc.Next;
      end;

      pRetInfItens(LQtdIte, LPesBru, LPesLiq, LDocumentos);
      pPreencheInfDoc(LQtdDoc, LQtdIte, LPesBru, LPesLiq);
    end;
  finally
    FreeAndNil(LQryDoc);
  end;
end;

procedure TfrmFatLotePedRom.pRetInfItens(var AQtdIte, APesBru, APesLiq: Double;
  ACocumentos: string);
var
  LQryInfItens: TUniQuery;
begin
  AQtdIte := 0;
  APesBru := 0;
  APesLiq := 0;

  LQryInfItens := fCriaQuery;

  try
    LQryInfItens.Close;
    LQryInfItens.SQL.Clear;
    LQryInfItens.SQL.Add('SELECT FDO_CODITE, FDO_QTDITE, FDO_TOTPES ');
    LQryInfItens.SQL.Add('FROM FATDOR');
    LQryInfItens.SQL.Add('WHERE FDO_SEQGER IN('+ACocumentos+')');
    LQryInfItens.Open;

    if LQryInfItens.IsEmpty then
      Exit;

    while not LQryInfItens.Eof do
    begin
      AQtdIte := AQtdIte + LQryInfItens.FieldByName('FDO_QTDITE').AsFloat;
      APesBru := APesBru + LQryInfItens.FieldByName('FDO_TOTPES').AsFloat;

      if fCfgSis('PESLIQ') = 'SOMA' then
        APesLiq := APesLiq + (LQryInfItens.FieldByName('FDO_QTDITE').AsFloat * fRetPesLiq(LQryInfItens.FieldByName('FDO_CODITE').AsString))
      else
        APesLiq := APesLiq + (LQryInfItens.FieldByName('FDO_QTDITE').AsFloat * (fRetPesBru(LQryInfItens.FieldByName('FDO_CODITE').AsString) * fStrToFloat(fCfgSis('FATPLI', varDouble))));
      LQryInfItens.Next;
    end;
  finally
    FreeAndNil(LQryInfItens);
  end;
end;

function TfrmFatLotePedRom.fLimpaLOTDOR(AstrSeqFdo, AstrCodLot, AstrCodEmp: String): Boolean;
var
  qryDelete: TUniQuery;
begin
  if fEmptyStr(AstrSeqFdo) then
    Exit(True);

  qryDelete := fCriaQuery;
  try
    qryDelete.SQL.Add('DELETE LOTDOR FROM LOTDOR');
    qryDelete.SQL.Add('INNER JOIN FATDOR T ON LDO_SEQFDO = T.AUTOINCREM');
    qryDelete.SQL.Add('INNER JOIN FATGOR F ON F.AUTOINCREM = T.FDO_SEQGER');
    qryDelete.SQL.Add('INNER JOIN ROMLDE D ON F.FGO_NUMDOC = D.RLD_NUMDOC');
    qryDelete.SQL.Add('                   AND F.FGO_ESPDOC = D.RLD_ESPDOC');
    qryDelete.SQL.Add('                   AND F.FGO_CODEMP = D.RLD_CODEMP');
    qryDelete.SQL.Add('INNER JOIN ROMLGE G ON D.RLD_SEQRLG = G.AUTOINCREM');
    qryDelete.SQL.Add('WHERE G.RLG_NUMLOT = :NUMLOT');
    qryDelete.SQL.Add('  AND G.RLG_CODEMP = :CODEMP');
    qryDelete.SQL.Add('  AND LDO_SEQFDO IN (' + AstrSeqFdo + ')');

    qryDelete.ParamByName('NUMLOT').AsString := AstrCodLot;
    qryDelete.ParamByName('CODEMP').AsString := AstrCodEmp;
    qryDelete.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryDelete);
  end;

end;

function TfrmFatLotePedRom.fTravaLoteSeparacao: Boolean;
var
  strChave: String;
begin
  strChave:= 'LOTE_SEPARACAO_' + edtCodLot.Text + '_' + edtCodEmp.Text;
  Result := objLock.fLock_Unlock(strChave, True, False);
  If Not Result Then
    fMensagem('ATENÇÃO!', 'Este lote de separação está sendo utilizado por outra estação: ' + fGetHostLock(strChave), ['&Ok']);
end;

function TfrmFatLotePedRom.fTravaMovProgramada: Boolean;
const
  CHAVE = 'LOTE_SEPARACAO_ITEM_%s_%s';
var
  strChave: String;
  qrySelect: TUniQuery;
  stlItens: TStringList;
  strChaveTmp: String;
begin
  Result := True;
  qrySelect := fCriaQuery;
  stlItens := TStringList.Create;
  try
    qrySelect.SQL.Add('SELECT COALESCE(FDO_CODITE, DET_CODITE) AS CODITE');
    qrySelect.SQL.Add('  FROM ROMLGE');
    qrySelect.SQL.Add(' INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add(' INNER JOIN ROMLIT ON RLI_SEQRLD = ROMLDE.AUTOINCREM');
    qrySelect.SQL.Add('  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = RLI_SEQFDO');
    qrySelect.SQL.Add('  LEFT JOIN MOVDET ON MOVDET.AUTOINCREM = RLI_SEQDET');
    qrySelect.SQL.Add(' WHERE RLG_CODEMP = :CODEMP');
    qrySelect.SQL.Add('   AND RLG_NUMLOT = :NUMLOT');
    qrySelect.SQL.Add(' GROUP BY COALESCE(FDO_CODITE, DET_CODITE)');

    qrySelect.ParamByName('NUMLOT').AsString := edtCodLot.Text;
    qrySelect.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qrySelect.Open;

    strChaveTmp := '';

    while not qrySelect.Eof do
    begin
      strChave := Format(CHAVE, [edtCodEmp.Text, qrySelect.FieldByName('CODITE').AsString]);

      Result := objLockMovProg.fLock_Unlock(strChave, True, False);

      if not Result then
      begin
        stlItens.Add(qrySelect.FieldByName('CODITE').AsString);
        if fEmptyStr(strChaveTmp) then
          strChaveTmp := strChave;
      end;

      qrySelect.Next;
    end;

    if stlItens.Count > 0 then
    begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Há produtos que não tem saldo suficiente no picking mas tem no buffer. Contudo, o(s) ' +
                            'produto(s) ' + stlItens.Text + ' já estão sendo utilizados em outra estação para gerar ' +
                            'a movimentação programada (' + fGetHostLock(strChaveTmp) + ').', ['&Ok']);
    end;

  finally
    FreeAndNil(qrySelect);
    FreeAndNil(stlItens);
  end;

  if not Result then
    objLockMovProg.pDestravarTodos;
end;

end.
