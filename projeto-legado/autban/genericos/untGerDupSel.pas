unit untGerDupSel;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, StdCtrls, Buttons, ExtCtrls, DB, StrUtils,
  Menus, EditFocus, AppEvnts, Uni, BitBtnLockedIncrem, untCadRec, frxClass,
  frxExportCSVTestabilidade, DBGridCitel, DBGrids, untMemo, untTypesSistema, DateUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxDropDownEdit, cxGridCitel,
  cxDBLookupComboBox, untConstantes, untGravando,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.DBCtrls,
  cxCurrencyEdit,untTLock,cxProgressBar;

type
  TfrmGerDupSel = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    pnlDadosDup: TPanel;
    lblCliente: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblProtesta: TLabel;
    edtCodCliBai: TEdit;
    edtNomCliBai: TEdit;
    edtCodPorBai: TEdit;
    edtNomPorBai: TEdit;
    edtNosNum: TEdit;
    edtDesProtesta: TEdit;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    edtCodVel: TEdit;
    Label1: TLabel;
    gpbLegenda: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    shp2: TShape;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    btnConfirma: TBitBtnLocked;
    Label2: TLabel;
    edtEndere: TEdit;
    Label3: TLabel;
    edtBairro: TEdit;
    Label4: TLabel;
    edtCidade: TEdit;
    Label5: TLabel;
    edtCep: TEdit;
    btnDigVal: TBitBtnLocked;
    btnSelTodos: TBitBtnLocked;
    btnProtesta: TBitBtnLocked;
    btnOrdem: TBitBtnLocked;
    btnBusca: TBitBtnLocked;
    btnProximo: TBitBtnLocked;
    btnVerCred: TBitBtnLocked;
    btnProtestaTodas: TBitBtnLocked;
    edtLinDig: TEdit;
    lblLinDig: TLabel;
    lblCodBar: TLabel;
    edtCodBar: TEdit;
    edtHistor: TMemo;
    spbAmpliar: TSpeedButton;
    Shape1: TShape;
    Label6: TLabel;
    Label8: TLabel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasDBTableView1CTR_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_ESPDOC: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_CODEMP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALDUP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALCOR: TcxGridDBColumn;
    dbgDuplicatasDBTableView1DEPOSI: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatasDBTableView1MARCAD: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CREDIT: TcxGridDBColumn;
    dbgDuplicatasDBTableView1DTAREC: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTP_DEPOSI: TcxGridDBColumn;
    btnDesmarcaTodos: TBitBtnLocked;
    dbgDuplicatasDBTableView1CODTED: TcxGridDBColumn;
    edtGuia: TEdit;
    lblGuia: TLabel;
    edtCodRecTributo: TEdit;
    lblCodRecTributo: TLabel;
    dbgDuplicatasDBTableView1CTR_OCORRE: TcxGridDBColumn;
    lblContaFornecedor: TLabel;
    dsContaFornecedor: TDataSource;
    CBContaFornecedor: TComboBox;
    pnlValoresDuplicata: TPanel;
    edtValorDuplicata: TEdit;
    Label13: TLabel;
    edtValorDesconto: TEdit;
    lblValorDesconto: TLabel;
    edtOutrasEntidades: TEdit;
    Label16: TLabel;
    Label11: TLabel;
    lblMensagem: TLabel;
    lblFanSob: TLabel;
    edtFanSob: TEdit;
    dbgDuplicatasDBTableView1CTR_DTACAD: TcxGridDBColumn;
    dbgDuplicatasDBTableView1PROTESTO: TcxGridDBColumn;
    dbgDuplicatasDBTableView1FOR_NOMFOR: TcxGridDBColumn;
    procedure pAtualizaDados;
    function fRetTotDupSel: String;
    function fRetornaPortadorRemessa(strCodEmp, strCodban, strCodCfg, strNumPos: String; intCodCar : Integer) : String;
    procedure dbgDuplicatassKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    function fSelecionaDuplicata: Boolean;
    procedure dbgDuplicatassDblClick(Sender: TObject);
    procedure dbgDuplicatassKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSelTodosClick(Sender: TObject);
    procedure btnProtestaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOrdemClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVerCredClick(Sender: TObject);
    procedure btnProtestaTodasClick(Sender: TObject);
    procedure btnDigValClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spbAmpliarClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1DblClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasDBTableView1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasDBTableView1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dbgDuplicatasDBTableView1DEPOSIPropertiesChange(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CODTEDPropertiesChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure CBContaFornecedorChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasDBTableView1CTR_OCORREPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    { Private declarations }

    strValorFiltro: String;
    strCampoFiltro: String;
    strBanIni     : String;
    intCodCar     : Integer;
    intQtdSel     : Integer;
    blnOnShow     : Boolean;

    //Usada no botao F12
    intCartei     : Integer;
    strBanco_     : String;

    lstGravaBcoFor: TStringList;
    FblnEnvPro    : Boolean;

    objLock: TLock;
    strDupTravada : String;
    strDupJaTravada : String;

    FEhOcorrenciaDeBaixa : Boolean;

    FContasAPagarAPI,
    FBancoArquivoPix: Boolean;

    FBoleCode : Boolean;
    FTipoRemessa : Integer;

    procedure pEstornaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCartei, AStatusSPCAtual: String);
    procedure pEstornaDuplicataContasPagar(strNumDup, strParcel, strCodEmp, strCodFor, strSerie_: String; intSeqBai: Integer; ACarteiraBancoEnvio : String);

    procedure pMudaOrdem;
    procedure pMudaOrdemContasPagar;
    procedure pMudaOrdemContasReceber;

    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    procedure pAtualizaDadosContasPagar;
    procedure pAtualizaDadosContasReceber;

    function fDuplicataVencida(dtaDatVen: TDate): Boolean;

    function FoiGeradaOutraRemessaSPCAntes(
      ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: String;
      out ADtaSPCAntes: TDate;
      out ACodEveAntes: Variant): Boolean;

    function RetornaStatusRemessaSPCAtual(
      ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: String): String;

    function fSelecionaDuplicataContasPagar: Boolean;
    function fSelecionaDuplicataContasReceber: Boolean;
    function fValidaDuplicata(blnMostraMensagemTrava: Boolean): Boolean;

    function  fSelTodosContasPagar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fSelTodosContasReceber(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pDesmarcaTodos(strTipo: String);

    procedure pProtestaContasPagar;
    procedure pProtestaContasReceber;

    function ConfirmaContasPagar(prgStatus: TcxProgressBar): Boolean;
    function ConfirmaContasReceber(prgStatus: TcxProgressBar): Boolean;

    procedure pMudaCamposGrid;

    procedure pAfterScroll(DataSet: TDataSet);

    procedure pDesmarcarTodas;

    procedure pCarregaComboOcorrencias(strCodBco : String; stlValores : TStrings);
    procedure pCarregaComboOcorrenciasAlteracoes(strCodBco : String; stlValores : TStrings);

    procedure pGravaOcorrencia(strTexto : String);

    procedure pGravaFormaPgto(strTexto : String);
    procedure pGravaCodFinalidadeTED(strTexto : String);

    procedure pGravaLogCtp(AAutoIncrem, strDescricaoLog: String);
    procedure GravaDadosBancariosFornecedor(ATexto: String);

    function fAtualizaNomeGuia(ACodigoGuia: String): string;
    procedure CarregaDadosBancariosFornecedor(AFornecedor: String; ASequencial: String = '');
    procedure PosicionaContaFornecedor(AAutoincremFornecedor: String = '');
    procedure pPesquisaBanco(qryTabOri, qryTabela: TUniQuery; strCodBco: String);
    function  fTravaDuplicataNaLCKATC(strNumDup,strParcel,strEspDoc,
                                      strCodEmp,strCodCli,strAutoin : String): Boolean;
    procedure pDestravaDuplicataNaLCKATC(strNumDup,strParcel,strEspDoc,
                                         strCodEmp,strCodCli,strAutoin : String);
    function  fDestravaTodasAsDuplicatas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pDestravarDuplicatas;
    function  fVerificaUltimaAlteracaoCadRec: Boolean;

    function AlgumRegistroMarcado: Boolean;
    procedure pRedimensionaFormPag;

    function SelecionandoDuplicatasGeradasPorAPI(ACarteiraBoleto: String): Boolean;
    function fRetornaCalculoCTPTotal(ARemessa: TDataset; AOutEnt:Boolean = False): Double;
    function fDeveMostrarValorCorrigido: Boolean;

  public
    { Public declarations }
    strCodBco : String;
    strJuros  : String;
    blnEstorno: Boolean;
    strTipGer : String;
    qryDuplic: TUniQuery;
    dtsDuplic: TDataSource;
    blnBB6d  : Boolean;
    blnCEF400: Boolean;
    blnEstEnvSPC          : Boolean;
    blnGlobalCob          : Boolean;
    blnApenasCadRec       : Boolean;
    strLog                : String;
    strTipoBanco          : String;
    blnMosTED             : Boolean;
    blnOcorrencias        : Boolean;
    blnOcorrenciaAlteracao: Boolean;
    blnPGG: Boolean;

    property BOLECODE : Boolean read FBoleCode write FBoleCode;
    property TipoRemessa : Integer read FTipoRemessa write FTipoRemessa;

    property EhOcorrenciaDeBaixa : Boolean read FEhOcorrenciaDeBaixa write FEhOcorrenciaDeBaixa;
    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;

    property ContasAPagarAPI: Boolean read FContasAPagarAPI write FContasAPagarAPI;
    property BancoArquivoPix: Boolean read FBancoArquivoPix write FBancoArquivoPix;
  end;

var
  frmGerDupSel: TfrmGerDupSel;
  intOrdem: Integer;
  strOrdem: String;

implementation

uses  untFuncoes, untfuncoesSimples, untPedePortador, untModuloCadCbi,
  untBaixaBusca, untModuloCadPgi, untPesqAux, untFuncAutban, System.UITypes,
  untLogCtp, untLogCtr, untFuncoesBoleto, untBancos, untDigDataPagamento,
  untAtualizaOcorrenciasCRM, untTypesCRM, untVerCreditos, untRelRelDuplicatas,
  untGerDup, untCadPag;

{$R *.dfm}

procedure TfrmGerDupSel.pAtualizaDados;
Begin

  If strTipGer = 'P' Then
    pAtualizaDadosContasPagar
  Else
    pAtualizaDadosContasReceber;

End;

procedure TfrmGerDupSel.pAfterScroll(DataSet: TDataSet);
Begin
  btnVerCred.Enabled := (DataSet.FindField('CTR_CREDIT') <> Nil) And
                        (DataSet.FieldByName('CTR_CREDIT').AsInteger > 0);
  If strTipGer <> 'P' Then
    pAtualizaDados;
End;

function TfrmGerDupSel.fRetornaPortadorRemessa(strCodEmp, strCodban, strCodCfg, strNumPos: String; intCodCar : Integer) : String;
Var
  strSQL   : String;
  qryPorRem: TUniQuery;
begin

   Try
    qryPorRem := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT                 ';
    strSQL := strSQL + '   SIS_VALCFG           ';
    strSQL := strSQL + ' FROM                   ';
    strSQL := strSQL + '   CFGBAN               ';
    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '   SIS_CODEMP = :CODEMP ';
    strSQL := strSQL + ' AND  SIS_CODBAN = :CODBAN ';
    strSQL := strSQL + ' AND  SIS_CODCFG = :CODCFG ';
    strSQL := strSQL + ' AND  SIS_NUMPOS = :NUMPOS ';
    strSQL := strSQL + ' AND  SIS_CARTEI = :CARTEI ';

    qryPorRem.Close;
    qryPorRem.SQL.Clear;
    qryPorRem.SQL.Add(strSQL);
    qryPorRem.ParamByName('CODEMP').AsString := strCodEmp;
    qryPorRem.ParamByName('CODBAN').AsString := strCodban;
    qryPorRem.ParamByName('CODCFG').AsString := strCodCfg;
    qryPorRem.ParamByName('NUMPOS').AsString := strNumPos;
    qryPorRem.ParamByName('CARTEI').AsInteger := intCodCar;
    qryPorRem.Open;
    Result := qryPorRem.FieldByName('SIS_VALCFG').AsString;
    Close;

   Finally
    FreeAndNil(qryPorRem);
    End;
end;

{***************************************}
{* RETORNA O VALOR TOTAL DA DUPLICATAS *}
{* SELECIONADAS                        *}
{************************************AF*}

function TfrmGerDupSel.fRetTotDupSel: String;
  Var
    strSQL: String;
    qryTotDupSel: TUniQuery;
Begin

  Result := '';

  Try

    qryTotDupSel := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    If strTipGer = 'P' Then
    Begin
      strSQL := strSQL + '  SUM(CTP_VALDUP) AS VALOR ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  TMP_ATBPAG ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTP_MARCAD = "M" ';
    End
    Else
    Begin
      strSQL := strSQL + '  SUM(CTR_VALDUP) AS VALOR ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  TMP_ATBREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_MARCAD = "M" ';
    End;

    With qryTotDupSel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Result := FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,15,2);

      Close;
    End;

  Finally
    FreeAndNil(qryTotDupSel);
  End;

End;

procedure TfrmGerDupSel.dbgDuplicatassKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pAtualizaDados;
end;

function TfrmGerDupSel.fValidaDuplicata(blnMostraMensagemTrava: Boolean): Boolean;
begin
  Result := True;
  If fCfgSis('CTPLBB', varBoolean) And (qryDuplic.FieldByName('CTP_DTALIB').IsNull) Then
  Begin
    If blnMostraMensagemTrava Then
      fMensagem('ATENÇÃO', 'Esta duplicata ainda não foi liberada para baixa.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fDuplicataVencida(qryDuplic.FieldByName('CTP_DTAVEN').AsDateTime) Then
  Begin
    If blnMostraMensagemTrava Then
      fMensagem('ATENÇÃO', 'Duplicata vencida portanto não poderá ser enviada para o banco.', ['&Ok']);
    Result := False;
    Exit;
  End;

  {**************************************************************************}
  {* VALIDAÇÕES EM RELAÇÃO A ENVIO DE TED ***********************************}
  {* SE FOR SOMENTE DEPÓSITO E A CONTA DO FORNECEDOR ESTIVER VAZIA, TRAVA ***}
  {* SE FOR TRIBUTOS E NÃO TIVER A GUIA DO TRIBUTO PREENCHIDO, TRAVA TAMBÉM *}
  {***********************************************************************MO*}
  If ((AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) = 'DEP') And
      (qryDuplic.FieldByName('CTP_TIPDOC').AsString <> '2') and
      ((CBContaFornecedor.ItemIndex = -1) and fEmptyStr(qryDuplic.FieldByName('CTP_BCOFOR').AsString))
     ) OR
     ((AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) = 'DEP') And
      (qryDuplic.FieldByName('CTP_TIPDOC').AsString = '2') and (fEmptyStr(qryDuplic.FieldByName('CTP_Q_GUIA').AsString) Or
      (CBContaFornecedor.ItemIndex = -1))
     ) Then
  Begin
    If blnMostraMensagemTrava Then
      fMensagem('ATENÇÃO', 'Fornecedor não possui dados bancários para depósito, portanto essa duplicata não poderá ser enviada para o banco.', ['&Ok']);
    Result := False;
    Exit;
  End;

  if (not fEmptyStr(qryDuplic.FieldByName('CTP_BCOFOR').AsString)) and
     (AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) <> 'DEP') then
  begin
    If blnMostraMensagemTrava Then
      fMensagem('ATENÇÃO', 'O campo "Forma Pgto." deve ser configurado como "Depósito".', ['&Ok']);
    Result := False;
    Exit;
  end;

  If ((AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) <> 'DEP') And
      (qryDuplic.FieldByName('CTP_TIPDOC').AsString <> '2')) Then
  Begin
    If fEmptyStr(qryDuplic.FieldByName('CTP_CODBAR').AsString) then
    Begin
      If blnMostraMensagemTrava Then
        fMensagem('ATENÇÃO', 'Duplicata selecionada está sem cod. de barras, portanto não poderá ser enviada para o banco.', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  // valida se o codigo de barras é de concessionaria
  If ((AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) <> 'DEP') And
      (qryDuplic.FieldByName('CTP_TIPDOC').AsString = '3')) Then
  Begin
    If Not fEmptyStr(qryDuplic.FieldByName('CTP_CODBAR').AsString) then
    Begin
      If Copy(qryDuplic.FieldByName('CTP_CODBAR').AsString, 1, 1) <> '8' then
      Begin
        If strCodBco = '341' Then
        Begin
          If blnMostraMensagemTrava Then
            fMensagem('ATENÇÃO', 'O código de barras não é valido para o tipo de documento concessionaria.', ['&Ok']);
          Result := False;
          Exit;
        End;
      End;
    End;
  End;
end;

function TfrmGerDupSel.fVerificaUltimaAlteracaoCadRec: Boolean;
begin
  Result := True;
  If Not (fRetUltimaAlteracaoCadRec(qryDuplic.FieldByName('NUMDUP').AsString,
                                    qryDuplic.FieldByName('CTR_PARCEL').AsString,
                                    qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                    qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                    qryDuplic.FieldByName('CTR_CODEMP').AsString) < qryDuplic.FieldByName('HRAFIL').AsDateTime) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível selecionar a duplicata, pois a mesma sofreu uma alteração. Recarregue os títulos novamente.', ['&OK'], 0);
    Result := False;
  End;
end;

procedure TfrmGerDupSel.GravaDadosBancariosFornecedor(ATexto: String);
Var
  strSQL   : String;
  intRecNro: Integer;
  qryAtbRec: TUniQuery;
begin
  If FContasAPagarAPI Or FBancoArquivoPix Then
    Exit;

  If Not qryDuplic.FieldByName('CTP_FORPIX').AsString.IsEmpty Then
  Begin
    If fMensagem('ATENÇÃO', 'Essa duplicata possui chave Pix vinculada. ' + #13 +
                            'Caso confirme a operação, a chave Pix será substituída pela conta selecionada.' + #13 +
                            'Deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      CBContaFornecedor.ItemIndex := -1;
      pSetFocus(CBContaFornecedor);
      Exit;
    End;
  End;
  
  intRecNro := qryDuplic.RecNo;

  Try
    qryAtbRec := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_ATBPAG ';
    strSQL := strSQL + 'SET CTP_BCOFOR = :BCOFOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    qryAtbRec.SQL.Text := strSQL;
    qryAtbRec.ParamByName('NUMDUP').AsString  := qryDuplic.FieldByName('CTP_NUMDUP').AsString;
    qryAtbRec.ParamByName('PARCEL').AsString  := qryDuplic.FieldByName('CTP_PARCEL').AsString;
    qryAtbRec.ParamByName('CODEMP').AsString  := qryDuplic.FieldByName('CTP_CODEMP').AsString;
    qryAtbRec.ParamByName('CODFOR').AsString  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
    qryAtbRec.ParamByName('SERIE_').AsString  := qryDuplic.FieldByName('CTP_SERIE_').AsString;
    qryAtbRec.ParamByName('SEQBAI').AsInteger := qryDuplic.FieldByName('CTP_SEQBAI').AsInteger;
    qryAtbRec.ParamByName('BCOFOR').AsString  := ATexto.Replace('CONTA', EmptyStr);
    qryAtbRec.ExecSQL;
    qryAtbRec.Close;

  Finally
    FreeAndNil(qryAtbRec);

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;
  End;
end;

function TfrmGerDupSel.fDuplicataVencida(dtaDatVen: TDate): Boolean;
  function fVericadoPeriodo_Exite_Feriado_DataNaoUtil(dtaDtaIni,
    dtaDtaFin: TDate): Boolean;
    Var
      dtaDtaCor: TDate;
      blnEncontrou_Nao_Util: Boolean;
  Begin
    Result := True;
    dtaDtaCor := dtaDtaIni;
    While dtaDtaCor < dtaDtaFin Do
    Begin
      blnEncontrou_Nao_Util := False;

      If (fEhFeriado(dtaDtaCor)) Then
        blnEncontrou_Nao_Util := True
      Else If ((dayofweek(dtaDtaCor) = 1)) Then
        blnEncontrou_Nao_Util := True
      Else If ((dayofweek(dtaDtaCor) = 7)) Then
        blnEncontrou_Nao_Util := True;

      If blnEncontrou_Nao_Util Then
      Begin
        dtaDtaCor := IncDay(dtaDtaCor);
        Continue;
      End;

      Result := False;
      Break;
    End;
  End;
Begin
  If fVericadoPeriodo_Exite_Feriado_DataNaoUtil(dtaDatVen, VS_Date) Then
    Result := False
  Else
    Result := True;
End;

{***********************}
{* MARCA AS DUPLICATAS *}
{********************AF*}
function TfrmGerDupSel.fSelecionaDuplicata: Boolean;
Begin

  Result := False;

  If strTipGer = 'P' Then
  Begin
    if not blnEstorno then
    begin
      if not fValidaDuplicata(True) then
        Exit;
    END;

    Result := fSelecionaDuplicataContasPagar;
  End
  Else
  Begin
    Result := fSelecionaDuplicataContasReceber;
    If Not (blnEstorno) Then
    Begin
      If (qryDuplic.FieldByName('CTR_MARCAD').AsString <> 'M') And
      (Pos(qryDuplic.FieldByName('AUTOINCREM').AsString, strDupTravada) > 0)  Then
      Begin
        pDestravaDuplicataNaLCKATC(qryDuplic.FieldByName('NUMDUP').AsString,
                                   qryDuplic.FieldByName('CTR_PARCEL').AsString,
                                   qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                   qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                   qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                   qryDuplic.FieldByName('AUTOINCREM').AsString);
      End;
    End;
  End;

End;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAtualizaDados;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1CODTEDPropertiesChange(
  Sender: TObject);
var
  AFocusedColumnIndex: Integer;
  texto: string;
begin
  inherited;
  If blnOnShow Then
    Exit;

  pSetFocus(dbgDuplicatas);
  with dbgDuplicatasDBTableView1.Controller do
  begin
    AFocusedColumnIndex := FocusedColumnIndex;
    try
      FocusedColumn := dbgDuplicatasDBTableView1CODTED;
      EditingController.ShowEdit();
      Caption       := IntToStr(TcxComboBox(EditingController.Edit).ItemIndex);
      texto         := (TcxComboBox(EditingController.Edit).Text);

      If qryDuplic.FieldByName('CTP_MARCAD').AsString = 'M' Then
      Begin
        qryDuplic.Edit;
        qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
        qryDuplic.Post;
      End;

      pGravaCodFinalidadeTED(Texto);
    finally
      FocusedColumnIndex := AFocusedColumnIndex;
    end;
  end;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1CTR_OCORREPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  AFocusedColumnIndex: Integer;
  texto: string;
begin
  inherited;
  pSetFocus(dbgDuplicatas);
  with dbgDuplicatasDBTableView1.Controller do
  begin
    AFocusedColumnIndex := FocusedColumnIndex;
    try
      FocusedColumn := dbgDuplicatasDBTableView1CTR_OCORRE;
      EditingController.ShowEdit();
      Caption       := IntToStr(TcxComboBox(EditingController.Edit).ItemIndex);
      texto         := (TcxComboBox(EditingController.Edit).Text);

      If qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M' Then
      Begin
        qryDuplic.Edit;
        qryDuplic.FieldByName('CTR_MARCAD').AsString := 'D';
        qryDuplic.Post;
      End;

      pGravaOcorrencia(Texto);
    finally
      FocusedColumnIndex := AFocusedColumnIndex;
    end;
  end;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

 If strTipGer = 'P' Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1MARCAD.Index]) = 'M' Then
      ACanvas.Font.Color := clBlue;
  End
  Else
  Begin
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1CREDIT.Index] > 0 Then
      ACanvas.Font.Color := clGreen;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1DTAREC.Index] > 0) And
       (not blnOcorrencias) Then
      ACanvas.Font.Color := clRed;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1MARCAD.Index]) = 'M' Then
      ACanvas.Font.Color := clBlue;
  End;

  If qryDuplic.IsEmpty Then
    Exit;

  If ACanvas.Brush.Color = clHighLight Then
  Begin
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1CREDIT.Index] > 0 Then
    Begin
      ACanvas.Font.Color := clMoneyGreen;
    End
    Else
      ACanvas.Font.Color := clHighLightText;
  End;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  intCartei := 0;
  strBanco_ := '';
  fSelecionaDuplicata;
  pAtualizaDados;
  qryDuplic.AfterScroll    := pAfterScroll;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1DEPOSIPropertiesChange(
  Sender: TObject);
var
  AFocusedColumnIndex: Integer;
  texto: string;
begin
  inherited;

  if blnOnShow Then
    Exit;

  pSetFocus(dbgDuplicatas);
  with dbgDuplicatasDBTableView1.Controller do
  begin
    AFocusedColumnIndex := FocusedColumnIndex;
    try
      FocusedColumn := dbgDuplicatasDBTableView1DEPOSI;
      EditingController.ShowEdit();
      Caption       := IntToStr(TcxComboBox(EditingController.Edit).ItemIndex);
      texto         := (TcxComboBox(EditingController.Edit).Text);

      If qryDuplic.FieldByName('CTP_MARCAD').AsString = 'M' Then
      Begin
        qryDuplic.Edit;
        qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
        qryDuplic.Post;
      End;

      If (Not fEmptyStr(qryDuplic.FieldByName('PAG_AUTCTP').AsString)) And (Texto='Boleto') Then
      Begin
        Texto := 'Depósito';
        fMensagem('ATENÇÃO', 'Esta duplicata é referente à folha de pagamento e não pode ser paga por boleto.', ['&Ok']);
      End;

      pGravaFormaPgto(Texto);
    finally
      FocusedColumnIndex := AFocusedColumnIndex;
      If strTipGer = 'P' Then
        pAtualizaDados;
    end;
  end;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : Begin
                 fSelecionaDuplicata;
               End;

    VK_Return: Begin
                 qryDuplic.AfterScroll := nil;
                 fSelecionaDuplicata;
                 pSetFocus(dbgDuplicatas);
                 qryDuplic.AfterScroll := pAfterScroll;
               End;

  End;

  dbgDuplicatas.Refresh;

end;

procedure TfrmGerDupSel.dbgDuplicatassDblClick(Sender: TObject);
begin
  inherited;
  intCartei := 0;
  strBanco_ := '';
  fSelecionaDuplicata;
  pAtualizaDados;
end;

procedure TfrmGerDupSel.dbgDuplicatasDBTableView1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pAtualizaDados;

end;

procedure TfrmGerDupSel.dbgDuplicatassKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : Begin
                 intCartei := 0;
                 strBanco_ := '';
                 fSelecionaDuplicata;
               End;

    VK_Return: Begin
                 intCartei := 0;
                 strBanco_ := '';
                 fSelecionaDuplicata;
                 pSetFocus(dbgDuplicatas);
               End;

    VK_F3    : btnOrdem.Click;
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;  
    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F4    : If btnProtesta.Visible Then btnProtesta.Click;
    VK_F9    : If btnVerCred.Enabled Then btnVerCred.Click;
    VK_F10   : btnConfirma.Click;
    VK_F11   : If btnProtestaTodas.Visible Then btnProtestaTodas.Click;
    VK_F12   : btnDigVal.Click;
  End;

  dbgDuplicatas.Refresh;

end;

procedure TfrmGerDupSel.btnSairClick(Sender: TObject);
begin
  inherited;
  qryDuplic.EnableControls;
end;

procedure TfrmGerDupSel.btnSelTodosClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando,frmGravando);

  If strTipGer = 'P' Then
    frmGravando.fExecutarAcao := fSelTodosContasPagar
  Else
    frmGravando.fExecutarAcao := fSelTodosContasReceber;

  frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Duplicatas';
  frmGravando.ShowModal;

end;

procedure TfrmGerDupSel.btnProtestaClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  If Not btnProtesta.Visible Then
    Exit;

  If strTipGer = 'P' Then
    pProtestaContasPagar
  Else
    pProtestaContasReceber;

  pAtualizaDados;
  qryDuplic.AfterScroll    := pAfterScroll;

end;

procedure TfrmGerDupSel.btnProtestaTodasClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  Screen.Cursor := crSQLWait;

  With qryDuplic Do
  Begin
    First;

    While Not Eof Do
    Begin
      If strTipGer = 'P' Then
        pProtestaContasPagar
      Else
        pProtestaContasReceber;

      Next;
    End;

  End;

  Screen.Cursor := crDefault;

  qryDuplic.First;
  qryDuplic.AfterScroll    := pAfterScroll;
end;

procedure TfrmGerDupSel.btnConfirmaClick(Sender: TObject);

begin
  inherited;

  pCriarFormularios(TfrmGravando, frmGravando);

  If strTipGer = 'P' Then
    frmGravando.fExecutarAcao := ConfirmaContasPagar
  Else
    frmGravando.fExecutarAcao := ConfirmaContasReceber;

  frmGravando.lblGravando.Caption := IIF(blnEstorno, 'Aguarde... Cancelando Duplicatas.', 'Aguarde... Confirmando Duplicatas.');
  frmGravando.ShowModal;
end;

procedure TfrmGerDupSel.btnDigValClick(Sender: TObject);
  Var
    fltValor : Double;
    fltAcumu : Double;
    strFieldValDup : String;
    strFieldMarDes : String;
    intRecNo : Integer;
    intOcoVazias: integer;
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  fltAcumu  := 0;
  fltValor  := 0;
  intCartei := 0;
  strBanco_ := '';
  intOcoVazias := 0;

  If strTipGer = 'P' Then
  Begin
    strFieldValDup := 'VALORTOTAL';
    strFieldMarDes := 'CTP_MARCAD';
  End
  Else
  Begin
    strFieldValDup := 'CTR_VALDUP';
    strFieldMarDes := 'CTR_MARCAD';
  End;

  If fDigitaValor(fltValor, 'Valor aproximado para seleção') Then
  Begin
    With dbgDuplicatasDBTableView1.DataController.DataSet Do
    Begin
      intRecNo := dbgDuplicatasDBTableView1.DataController.DataSet.RecNo;
      DisableControls;
      First;
      pDesmarcarTodas;
      Refresh;
      First;
      If RecordCount > 0 Then
      Begin
        While Not Eof Do
        Begin
          If strTipGer = 'P' Then
          Begin
            If fDuplicataVencida(FieldByName('CTP_DTAVEN').AsDateTime) Then
            Begin
              Next;

              Continue;
            End;
          End;

          If FieldByName(strFieldMarDes).AsString <> 'M' Then
          Begin
            If Not (blnOcorrencias And (fEmptyStr(FieldByName('CTR_OCORRE').AsString))) Then
            Begin
              If Not ((FieldByName(strFieldValDup).AsFloat + fltAcumu) > fltValor) Then
              Begin
                fltAcumu := fltAcumu + FieldByName(strFieldValDup).AsFloat;
                If Not fSelecionaDuplicata Then
                Begin
                  pMensagemOk('Acerte as duplicatas antes de usar esse recurso.');
                  pDesmarcarTodas;
                  Break;
                End;
              End;
            End
            else
              inc(intOcoVazias);
          End;

          Next;
        End;
      End;

      RecNo := intRecNo;
      EnableControls;

      if intOcoVazias > 0 then
        fMensagem('','Não foi possível selecionar uma duplicata, informe primeiro as ocorrências para enviar ao banco!',['&O K']);

    End;
  End;
  qryDuplic.AfterScroll    := pAfterScroll;

end;

procedure TfrmGerDupSel.pRedimensionaFormPag;
Var
  intCont: Integer;
begin
  Self.Width := 1000;
  pnlDadosDup.Width   := 310;
  dbgDuplicatas.Width := 952;
  dbgDuplicatasDBTableView1CTR_CODEMP.Width := 50;
  dbgDuplicatasDBTableView1CTR_ESPDOC.Width := 50;
  dbgDuplicatasDBTableView1CTR_VALDUP.Width := 81;
  dbgDuplicatasDBTableView1CTR_NUMDUP.Width := 100;

  For intCont := Self.ComponentCount -1 DownTo 0 Do
  Begin
    If (Self.Components[intCont].Tag = 999) Then
      If (Self.Components[intCont] is TEdit) Then
        (Self.Components[intCont] as TEdit).Width := 220
      Else  If (Self.Components[intCont] is TMemo) Then
        (Self.Components[intCont] as TMemo).Width := 220
  End;

  spbAmpliar.Left :=  287;
  CBContaFornecedor.Width := 220;
  edtGuia.Width := 80;
  lblCodRecTributo.Left := 120;
  lblCodRecTributo.Caption := 'Cód. Rec. Trib.:';
  edtCodRecTributo.Left := 233;
  lblMensagem.Left := 91;
  edtValorDuplicata.Width := 80;
  edtOutrasEntidades.Width := 80;
  lblValorDesconto.Left := 143;
  lblValorDesconto.Caption := 'Vl. Desconto:';
  edtValorDesconto.Left := 227;
  edtValorDesconto.Width := 60;
  pnlValoresDuplicata.Width := 308;

  For intCont := Self.ComponentCount -1 DownTo 0 Do
  Begin
    If (Self.Components[intCont].Tag = 999) Then
    Begin
      If (Self.Components[intCont] is TEdit) Then
        (Self.Components[intCont] as TEdit).Width := 220
      Else  If (Self.Components[intCont] is TMemo) Then
        (Self.Components[intCont] as TMemo).Width := 220;
    End
    Else If (Self.Components[intCont] is TBitBtnLocked) Then
        (Self.Components[intCont] as TBitBtnLocked).Width := (Self.Components[intCont] as TBitBtnLocked).Width + 15;
  End;

  btnSair.Left := btnVerCred.Left + 3;
end;

procedure TfrmGerDupSel.FormShow(Sender: TObject);
Var
  intCont: Integer;
  prcScroll: TprcScroll;
begin
  inherited;

  dbgDuplicatasDBTableView1PROTESTO.visible := False;

  If strTipGer = 'R' Then
    (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := fMskDigitos(2);

  blnOnShow := True;

  If strCodBco <> '104' Then
  Begin
    btnProtesta.Visible     := False;
    edtDesProtesta.Visible  := False;
    lblProtesta.Visible     := False;
    btnProtestaTodas.Visible:= False;
  End;

  if (not blnEstorno) then
  begin
    Label6.Visible := False;
    Shape1.Visible := False;
    Label8.Visible := False;
    gpbLegenda.Width := 133;
  end;

  If (not blnEstorno) and (strTipGer = 'R') Then
      dbgDuplicatasDBTableView1PROTESTO.Visible := True;

  gpbLegenda.Visible := strTipGer = 'R';

  If blnOcorrencias Then
  Begin
    dbgDuplicatasDBTableView1CTR_NUMDUP.Width   := 86;
    dbgDuplicatasDBTableView1CTR_ESPDOC.Width   := 46;
    dbgDuplicatasDBTableView1CTR_CODEMP.Width   := 48;
    dbgDuplicatasDBTableView1CTR_DTAVEN.Width   := 65;
    dbgDuplicatasDBTableView1CTR_VALDUP.Width   := 80;
    dbgDuplicatasDBTableView1CTR_OCORRE.Width   := 160;
    dbgDuplicatasDBTableView1CTR_OCORRE.Visible := True;
    pnlDadosDup.Width                           := 310;
    Self.Width                                  := 1022;
  End;

  lblFanSob.visible := True;
  edtFanSob.Visible := True;

  If strTipGer = 'P' Then
  Begin
    //REDIMENSIONANDO A TELA PARA APRESENTAR OS DADOS DE FORMA DE PAGAMENTO E CÓDIGO DO TED
    If (blnMosTED) Then
    Begin
      dbgDuplicatasDBTableView1DEPOSI.Visible := True;

      //SE FOR ESTORNO DESABILITA PARA EDIÇÃO O CAMPO DE FORMA DE PAGTO.
      If blnEstorno Then
      Begin
        dbgDuplicatasDBTableView1DEPOSI.Editing       := False;
        dbgDuplicatasDBTableView1.OptionsData.Editing := False;
      End
      Else
        dbgDuplicatasDBTableView1CODTED.Visible := True;
    End;

    pRedimensionaFormPag;

    If blnEstorno Then
      CBContaFornecedor.Enabled := False;

    pnlValoresDuplicata.Visible := True;

    dbgDuplicatasDBTableView1CTR_VALDUP.Caption := 'Valor Total';
    dbgDuplicatasDBTableView1CTR_VALDUP.DataBinding.FieldName := 'VALORTOTAL';

    lblFanSob.visible := False;
    edtFanSob.Visible := False;
  End;

  if blnOcorrenciaAlteracao then
    pCarregaComboOcorrenciasAlteracoes(strCodBco, TcxComboBoxProperties(dbgDuplicatasDBTableView1CTR_OCORRE.Properties).Items)
  else
    pCarregaComboOcorrencias(strCodBco, TcxComboBoxProperties(dbgDuplicatasDBTableView1CTR_OCORRE.Properties).Items);

  qryDuplic.First;
  qryDuplic.OnFilterRecord := pFilterRecord;
  qryDuplic.AfterScroll    := pAfterScroll;

  dtsDuplic         := TDataSource.Create(Self);
  dtsDuplic.DataSet := qryDuplic;
  dbgDuplicatasDBTableView1.DataController.DataSource := dtsDuplic;

  pAtualizaDados;
  pSetFocus(dbgDuplicatas);

  if strTipGer = 'P' then
    pMudaCamposGrid;

  {********************************************************}
  {* CARREGANDO AS INFORMAÇÕES DO COMBO DE FINALIDADE TED *}
  {*****************************************************MO*}
  If (strTipGer = 'P') And
     (dbgDuplicatasDBTableView1CODTED.Visible) Then
  begin
    pDisableControls(qryDuplic, prcScroll);

    For intCont := Low(ARR_CODIGO_FINALIDADE_TED) to High(ARR_CODIGO_FINALIDADE_TED) Do
    begin
      TcxComboBoxProperties(dbgDuplicatasDBTableView1CODTED.Properties).Items.Add(ARR_CODIGO_FINALIDADE_TED[intCont][1]);
    end;

    dtsDuplic.DataSet.First;

    pEnableControls(qryDuplic, prcScroll);
  End;

  dbgDuplicatasDBTableView1CTR_NUMDUP.Focused := True;
  blnOnShow := False;

  dbgDuplicatasDBTableView1CTR_VALCOR.Visible := fDeveMostrarValorCorrigido;
end;

{*********************}
{* ESTORNA DUPLICATA *}
{******************AF*}
procedure TfrmGerDupSel.pEstornaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCartei, AStatusSPCAtual: String);
  Var
    strSQL       : String;
    qryUpdDel    : TUniQuery;
    LEstornarValoresSPC: Boolean;
    LDtaSPCAntes: TDate;
    LStsSPCAntes: String;
    LCodEveAntes: Variant;
Begin

  Try

    qryUpdDel := fCriaQuery(Self);

    if (strCodBco <> 'SPC') and (strCodBco <> 'SER') and (strCodBco <> 'BOA') then
    begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE CADREC ';
      strSQL := strSQL + '  LEFT JOIN CADCBI ';
      strSQL := strSQL + '    ON CBI_NUMDUP = CTR_NUMDUP ';
      strSQL := strSQL + '   AND CBI_PARCEL = CTR_PARCEL ';
      strSQL := strSQL + '   AND CBI_ESPDOC = CTR_ESPDOC ';
      strSQL := strSQL + '   AND CBI_CODCLI = CTR_CODCLI ';
      strSQL := strSQL + '   AND CBI_CODEMP = CTR_CODEMP ';
      strSQL := strSQL + '  LEFT JOIN REMDET ';
      strSQL := strSQL + '    ON DET_DUPLIC = CADREC.AUTOINCREM ';
      strSQL := strSQL + '   AND DET_DTAREC IS NOT NULL ';
      strSQL := strSQL + ' SET ';

      If (Not FblnEnvPro) Then
      Begin
        strSQL := strSQL + '  CTR_BCOENV = IF((CBI_CODOCO IS NOT NULL AND CBI_CODOCO<>"01") OR (DET_DUPLIC IS NOT NULL),CTR_BCOENV,NULL), ';
        strSQL := strSQL + '  CTR_DTAENV = IF((CBI_CODOCO IS NOT NULL AND CBI_CODOCO<>"01") OR (DET_DUPLIC IS NOT NULL),CTR_DTAENV,NULL), ';
      End
      Else
        strSQL := strSQL + '  CTR_DTAPRO = NULL, ';

      strSQL := strSQL + '  CTR_CTREME = NULL,  ';
      strSQL := strSQL + '  CTR_TARTED = 0.00,  ';
      strSQL := strSQL + '  CTR_PERALP = 0.00,  ';
      strSQL := strSQL + '  CTR_DTAALP = NULL   ';

      if fGetBancoConfig(0, Copy(strCartei, 1, Length(strCartei) - 4), 'RESPONS', '') = 'B' then
      begin
        if pos('CONFIG070p400', strCartei) > 0 then
          strSQL := strSQL + ' ,CTR_CONREM = NULL ';

        strSQL := strSQL + '  ,CTR_CARTEI = IF((DET_DUPLIC IS NULL AND CTR_NOSNUM IS NULL), "", CTR_CARTEI)   ';
        strSQL := strSQL + '  ,CTR_BCOBOL = IF((DET_DUPLIC IS NULL AND CTR_NOSNUM IS NULL), NULL, CTR_BCOBOL) ';
      end;

      If (strCodBco = '033') Then
      Begin
        If (fGetBancoConfig(0,Copy(strCartei, 1, Length(strCartei) - 4),'ENVNOSN','') = 'S') And
           (fGetBancoConfig(0,Copy(strCartei, 1, Length(strCartei) - 4),'RESPONS','') = 'B') Then
        Begin
          strSQL := strSQL + '  ,CTR_NOSNUM = NULL ';
          strSQL := strSQL + '  ,CTR_DTABOL = NULL ';
          strSQL := strSQL + '  ,CTR_LINDIG = NULL ';
        End;
      End;

      If (strCodBco = '021') and (fGetBancoConfig(0,Copy(strCartei, 1, Length(strCartei) - 4),'RESPONS','') = 'B') Then
      Begin
        strSQL := strSQL + '  ,CTR_NOSNUM = NULL ';
        strSQL := strSQL + '  ,CTR_DTABOL = NULL ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

      With qryUpdDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;
    end
    else
    if blnEstEnvSPC then
    begin
      If fEmptyStr(AStatusSPCAtual) Then
        AStatusSPCAtual := RetornaStatusRemessaSPCAtual(strNumDup,
                                                        strParcel,
                                                        strEspDoc,
                                                        strCodEmp,
                                                        strCodCli);

      LEstornarValoresSPC := False;
      If AStatusSPCAtual = 'E' Then
      Begin
        LStsSPCAntes := 'I';
        LEstornarValoresSPC := FoiGeradaOutraRemessaSPCAntes(strNumDup,
                                                                   strParcel,
                                                                   strEspDoc,
                                                                   strCodEmp,
                                                                   strCodCli,
                                                                   LDtaSPCAntes,
                                                                   LCodEveAntes);
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE CADREC SET ';
      strSQL := strSQL + '  CTR_DTASPC = :DTASPC, ';
      strSQL := strSQL + '  CTR_STSSPC = :STSSPC, ';
      strSQL := strSQL + '  CTR_CODEVE = :CODEVE  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

      With qryUpdDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;

        ParamByName('DTASPC').Clear;
        ParamByName('STSSPC').Clear;
        ParamByName('CODEVE').Clear;

        If LEstornarValoresSPC Then
        Begin
          ParamByName('DTASPC').AsDate := LDtaSPCAntes;
          ParamByName('STSSPC').AsString := LStsSPCAntes;
          ParamByName('CODEVE').Value := LCodEveAntes;
        End;

        ExecSQL;
        Close;
      End;

      strSQL := AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC');
      With qryUpdDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;

        ParamByName('DTASPC').Clear;
        ParamByName('STSSPC').Clear;
        ParamByName('CODEVE').Clear;

        If LEstornarValoresSPC Then
        Begin
          ParamByName('DTASPC').AsDate := LDtaSPCAntes;
          ParamByName('STSSPC').AsString := LStsSPCAntes;
          ParamByName('CODEVE').Value := LCodEveAntes;
        End;

        ExecSQL;
        Close;
      End;
    end
    else
    If ((strCodBco = 'SER') Or (strCodBco = 'BOA')) and (blnApenasCadRec) Then
    begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE DEL_CADREC SET ';
      If (strCodBco = 'SER') Then
      Begin
        strSQL := strSQL + '   CTR_DTASER = IF(CTR_DTAREC IS NULL AND CTR_SEREXC IS NULL,NULL,CTR_DTASER) ';
        strSQL := strSQL + ' , CTR_DTASE2 = IF(CTR_DTAREC IS NOT NULL AND CTR_SEREXC IS NULL,NULL,CTR_DTASE2) ';
        strSQL := strSQL + ' , CTR_SEREXC = IF(CTR_SEREXC IS NOT NULL,NULL,CTR_SEREXC) ';
      End
      Else
      Begin
        strSQL := strSQL + '   CTR_DTABOA = IF(CTR_DTAREC IS NULL AND CTR_BOAEXC IS NULL,NULL,CTR_DTABOA) ';
        strSQL := strSQL + ' , CTR_DTABO2 = IF(CTR_DTAREC IS NOT NULL AND CTR_BOAEXC IS NULL,NULL,CTR_DTABO2) ';
        strSQL := strSQL + ' , CTR_BOAEXC = IF(CTR_BOAEXC IS NOT NULL,NULL,CTR_BOAEXC) ';
      End;
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

      With qryUpdDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;

      // Estorna a CADREC para as devoluções enviadas ao Serasa com Exclusão
      With qryUpdDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(AnsiReplaceStr(strSQL, 'DEL_CADREC', 'CADREC'));
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;
    end;

    {****************}
    {* GRAVA LOGCTR *}
    {*************JS*}
    untLogCtr.GravaLogCtr(strNumDup, strEspDoc, strCodCli,
                          strCodEmp, strParcel, 0,
                          IIF((Not fEmptyStr(strLog)) And (Not FblnEnvPro),
                               strLog,
                               IIF(FblnEnvPro,
                                   'CANC. DE DUPLICATAS ENVIADAS PARA PROTESTO',
                                   'CANC. DE DUPLICATAS'
                                )
                           ), Self.Name);
 
    strSQL := '';
    strSQL := strSQL + 'DELETE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CBI_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CBI_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CBI_CODCLI = :CODCLI ';

    With qryUpdDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryUpdDel);
  End;  

End;


procedure TfrmGerDupSel.FormCreate(Sender: TObject);
begin
  inherited;
  intOrdem  := 0;
  intCartei := 0;
  intQtdSel := 0;
  strBanco_ := '';
  intCodCar := 0;
  strBanIni := '';
  blnMosTED := False;
  lstGravaBcoFor := TStringList.Create;
  FblnEnvPro:= False;
  edtTotalSelecionado.Text := '0,00';
  objLock := TLock.Create;

  FContasAPagarAPI := False;
  BancoArquivoPix := False;
  FBoleCode := False;
end;

procedure TfrmGerDupSel.FormDestroy(Sender: TObject);
begin
  inherited;
  lstGravaBcoFor.Free;
  objLock.Free;
end;

procedure TfrmGerDupSel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F3    : btnOrdem.Click;
    VK_F5    : btnBusca.Click;
    VK_F6    : btnProximo.Click;
    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F4    : If btnProtesta.Visible Then btnProtesta.Click;
    VK_F9    : If btnVerCred.Enabled Then btnVerCred.Click;
    VK_F10   : btnConfirma.Click;
    VK_F11   : If btnProtestaTodas.Visible Then btnProtestaTodas.Click;
    VK_F12   : btnDigVal.Click;
  end;
end;

procedure TfrmGerDupSel.pMudaOrdem;
begin
  If strTipGer = 'P' Then
    pMudaOrdemContasPagar
  Else
    pMudaOrdemContasReceber;
End;

procedure TfrmGerDupSel.pMudaOrdemContasReceber;
  Var
    strSql: String;
Begin

  if not dbgDuplicatasDBTableView1.Columns[ intOrdem ].Visible then
  begin
    intOrdem := 0;
  end;


  strOrdem := dbgDuplicatasDBTableView1.Columns[ intOrdem ].DataBinding.FieldName;

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '  * ';
  strSql := strSql + ' FROM   ';
  strSql := strSql + '  TMP_ATBREC ';
  strSql := strSql + ' ORDER BY ';
  strSql := strSql + strOrdem;

  With qryDuplic Do
  Begin

    Close;
    Sql.Clear;
    Sql.Add( strSql );
    Open;
    (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
  End;

//  if intOrdem >= ( dbgDuplicatas.FieldCount - 1 ) Then
  if intOrdem >= ( dbgDuplicatasDBTableView1.DataController.DataSet.FieldCount - 1 ) Then
    intOrdem := 0
  Else
    inc( intOrdem );

End;

procedure TfrmGerDupSel.PosicionaContaFornecedor(AAutoincremFornecedor: String = '');
begin
  if fEmptyStr(AAutoincremFornecedor) then
    CBContaFornecedor.ItemIndex := lstGravaBcoFor.IndexOf(IIF(qryDuplic.FieldByName('CTP_BCOFOR').AsString.IsEmpty,
                                                              'PIX' + qryDuplic.FieldByName('CTP_FORPIX').AsString,
                                                              'CONTA' + qryDuplic.FieldByName('CTP_BCOFOR').AsString))
  else
    CBContaFornecedor.ItemIndex := lstGravaBcoFor.IndexOf(AAutoincremFornecedor);
end;

procedure TfrmGerDupSel.pMudaOrdemContasPagar;
  Var
    strSql: String;
Begin

  pMudaCamposGrid;

//  strOrdem := dbgDuplicatas.Fields[ intOrdem ].FieldName;

  if not dbgDuplicatasDBTableView1.Columns[ intOrdem ].Visible then
  begin
    intOrdem := 0;
  end;

  strOrdem := dbgDuplicatasDBTableView1.Columns[ intOrdem ].DataBinding.FieldName;

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '  * ';
  strSql := strSql + ' FROM   ';
  strSql := strSql + '  TMP_ATBPAG ';
  strSql := strSql + ' ORDER BY ';
  strSql := strSql + strOrdem;

  With qryDuplic Do
  Begin

    Close;
    Sql.Clear;
    Sql.Add( strSql );
    Open;
    (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';
  End;

//  if intOrdem >= ( dbgDuplicatas.FieldCount - 1 ) Then
  if intOrdem >= ( dbgDuplicatasDBTableView1.DataController.DataSet.FieldCount - 1 ) Then
    intOrdem := 0
  Else
    inc( intOrdem );


End;

procedure TfrmGerDupSel.btnOrdemClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  pMudaOrdem;
  qryDuplic.AfterScroll    := pAfterScroll;
end;

procedure TfrmGerDupSel.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  pDesmarcaTodos(strTipGer);
  qryDuplic.AfterScroll    := pAfterScroll;
end;

function TfrmGerDupSel.AlgumRegistroMarcado: Boolean;
  Var
    LCampoFiltro: String;

    LprcScroll: TprcScroll;
begin
  inherited;

  Result := True;

  pDisableControls(qryDuplic, LprcScroll);

  Try
    LCampoFiltro := IIF(strTipGer = 'P', 'CTP_MARCAD', 'CTR_MARCAD');

    qryDuplic.Filter   := LCampoFiltro + '=''M'' ';
    qryDuplic.Filtered := True;

    If qryDuplic.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Nenhuma duplicata foi selecionada!', ['&OK']);
      Exit(False);
    End;
  Finally
    qryDuplic.Filtered := False;
    pEnableControls(qryDuplic, LprcScroll);
  End;
end;

procedure TfrmGerDupSel.btnBuscaClick(Sender: TObject);
  Var
    frmBaixaBusca : TfrmBaixaBusca;
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  If (Not qryDuplic.Active) Or
     (qryDuplic.IsEmpty)    Then
  Begin
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.strTipGer := strTipGer;
    frmBaixaBusca.ShowModal;
  Finally
    If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBaixaBusca.strValorFiltro;
      strCampoFiltro := frmBaixaBusca.strCampoFiltro;
      qryDuplic.FindFirst;
    End;
    FreeAndNil(frmBaixaBusca);
  End;
  qryDuplic.AfterScroll    := pAfterScroll;

end;

procedure TfrmGerDupSel.btnProximoClick(Sender: TObject);
begin
  inherited;
  qryDuplic.AfterScroll    := nil;
  If (qryDuplic.Active) And (Not fEmptyStr(strCampoFiltro)) Then
    qryDuplic.FindNext;
  qryDuplic.AfterScroll    := pAfterScroll;

end;

procedure TfrmGerDupSel.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
    Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmGerDupSel.pAtualizaDadosContasPagar;
begin

  lblCliente.Caption := 'Fornecedor';

  edtCodCliBai.Text  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
  edtNomCliBai.Text  := qryDuplic.FieldByName('FOR_NOMFOR').AsString;

  edtEndere.Text     := qryDuplic.FieldByName('FOR_ENDCOB').AsString;
  edtBairro.Text     := qryDuplic.FieldByName('FOR_BAICOB').AsString;
  edtCidade.Text     := qryDuplic.FieldByName('FOR_NOMCID').AsString + ' - ' + qryDuplic.FieldByName('FOR_ESTADO').AsString;
  edtCep.Text        := qryDuplic.FieldByName('FOR_CEPCOB').AsString;

  edtHistor.Text     := AnsiReplaceStr(qryDuplic.FieldByName('CTP_HIST01').AsString, '<<csq>>', #13#10) + #13 + #13 +
                        AnsiReplaceStr(qryDuplic.FieldByName('CTP_HIST02').AsString, '<<csq>>', #13#10);

  If qryDuplic.FieldByName('CTP_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else If qryDuplic.FieldByName('CTP_PROTES').AsString = 'S' Then
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End
  Else
  Begin
    edtDesProtesta.Visible := False;
    lblProtesta.Visible    := False;
  End;

  edtCodVel.Text           := qryDuplic.FieldByName('CTP_CODVEL').AsString;
  edtCodBar.Text           := qryDuplic.FieldByName('CTP_CODBAR').AsString;
  edtLinDig.Text           := qryDuplic.FieldByName('CTP_LINDIG').AsString;
  edtGuia.Text             := fAtualizaNomeGuia(qryDuplic.FieldByName('CTP_Q_GUIA').AsString);
  edtCodRecTributo.Text    := qryDuplic.FieldByName('CTP_CODREC').AsString;
  edtValorDuplicata.Text   := FormatFloat('#,##0.00;-#,##0.00', qryDuplic.FieldByName('CTP_VALDUP').AsFloat);
  edtValorDesconto.Text    := FormatFloat('#,##0.00;-#,##0.00', qryDuplic.FieldByName('CTP_VALDES').AsFloat);
  edtOutrasEntidades.Text  := FormatFloat('#,##0.00;-#,##0.00', qryDuplic.FieldByName('CTP_OUTENT').AsFloat);
  edtTotalSelecionado.Text := fRetTotDupSel;

  CBContaFornecedor.Clear;
  CBContaFornecedor.Enabled := True;
  if fEmptyStr(qryDuplic.FieldByName('CTP_BCOFOR').AsString) Then
  begin
    CarregaDadosBancariosFornecedor(qryDuplic.FieldByName('CTP_CODFOR').AsString);
  end
  else
  begin
    if fEmptyStr(qryDuplic.FieldByName('CONTAFOR').AsString) Then
    begin
      CarregaDadosBancariosFornecedor(qryDuplic.FieldByName('CTP_CODFOR').AsString, qryDuplic.FieldByName('CTP_BCOFOR').AsString);
    end
    else
    begin
      CBContaFornecedor.Items.Add(qryDuplic.FieldByName('CONTAFOR').AsString);
      CBContaFornecedor.ItemIndex := 0;
    end;
  end;


  If (AnsiUpperCase(Copy(qryDuplic.FieldByName('DEPOSI').AsString, 1, 3)) <> 'BOL') And fEmptyStr(qryDuplic.FieldByName('CONTAFOR').AsString)Then
  Begin
    CBContaFornecedor.Enabled := Not (FContasAPagarAPI Or FBancoArquivoPix);
    CarregaDadosBancariosFornecedor(qryDuplic.FieldByName('CTP_CODFOR').AsString);
  End
  Else
    CBContaFornecedor.Enabled := False;
end;

procedure TfrmGerDupSel.pAtualizaDadosContasReceber;
begin

  edtCodCliBai.Text := qryDuplic.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := qryDuplic.FieldByName('CLI_NOMCLI').AsString;

  edtCodPorBai.Text := qryDuplic.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := qryDuplic.FieldByName('POR_NOMPOR').AsString;

  edtEndere.Text    := qryDuplic.FieldByName('CLI_ENDCOB').AsString;
  edtBairro.Text    := qryDuplic.FieldByName('CLI_BAICOB').AsString;
  edtCidade.Text    := qryDuplic.FieldByName('CLI_NOMCID').AsString + ' - ' + qryDuplic.FieldByName('CLI_ESTADO').AsString;
  edtCep.Text       := qryDuplic.FieldByName('CLI_CEPCOB').AsString;

  edtNosNum.Text    := qryDuplic.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := AnsiReplaceStr(qryDuplic.FieldByName('CTR_HIST01').AsString, '<<csq>>', #13#10) + #13 + #13 +
                       AnsiReplaceStr(qryDuplic.FieldByName('CTR_HIST02').AsString, '<<csq>>', #13#10);

  edtFanSob.Text    := qryDuplic.FieldByName('CLI_FANSOB').AsString;

  If qryDuplic.FieldByName('CTR_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else If qryDuplic.FieldByName('CTR_PROTES').AsString = 'S' Then
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End
  Else
  Begin
    edtDesProtesta.Visible := False;
    lblProtesta.Visible    := False;
  End;

  edtCodVel.Text           := qryDuplic.FieldByName('CTR_CODVEL').AsString;
end;

function TfrmGerDupSel.fSelecionaDuplicataContasPagar: Boolean;
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryAtbPag: TUniQuery;
  Const
    CODIGO_RECEITA_PGG: Array of String = ['100064','100013','100110','100102','100145','150010',
                                           '100021','100137','100129','100056','100072','100080',
                                           '100048','100099','100030','500011','600016'];
begin

  Try

    If ((qryDuplic.FieldByName('CTP_TIPDOC').AsString='2') And
        (fEmptyStr(qryDuplic.FieldByName('CTP_Q_GUIA').AsString))) Then
    Begin
      fMensagem('ATENÇÃO', 'Esse tributo está sem a indicação da guia e código de receita. Verifique.', ['&O K'], 1, True);
      Abort;
    End
    Else If (qryDuplic.FieldByName('CTP_TIPDOC').AsString='2') And
            (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '7') And
            (fEmptyStr(qryDuplic.FieldByName('CTP_CODBAR').AsString)) Then
    Begin
      fMensagem('ATENÇÃO', 'Para tributos de guia GNRE, é necessário possuir o código de barras cadastrado. Verifique.', ['&O K'], 1, True);
      Abort;
    End
    Else If  (blnPGG And ((qryDuplic.FieldByName('CTP_TIPDOC').AsString <> '2') Or
                          (qryDuplic.FieldByName('CTP_Q_GUIA').AsString <> '7')))  Then
    Begin
      fMensagem('ATENÇÃO', 'Pagamento exclusivo para tributos de guia GNRE!', ['&O K'], 1, True);
      Abort;
    End
    Else If  (blnPGG And Not MatchStr(qryDuplic.FieldByName('CTP_CODREC').AsString,CODIGO_RECEITA_PGG))  Then
    Begin

      fMensagem('ATENÇÃO', 'Código da receita estadual não permitido!', ['&O K'], 1, True);
      Abort;
    End
    Else If (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '8') Or
            (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '9') Or
            (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '10') Then
    Begin
      fMensagem('ATENÇÃO', 'Os tributos ISS, IPTU e FGTS não são tratados no AUTBAN. Portanto não poderão ser selecionados.', ['&O K'], 1, True);
      Abort;
    End;

    qryAtbPag := fCriaQuery(Self);

    intRecNro := qryDuplic.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'SET ';

    If qryDuplic.FieldByName('CTP_MARCAD').AsString = 'M' Then
      strSQL := strSQL + '  CTP_MARCAD = "D" '
    Else
      strSQL := strSQL + '  CTP_MARCAD = "M" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    With qryAtbPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := qryDuplic.FieldByName('CTP_NUMDUP').AsString;
      ParamByName('PARCEL').AsString  := qryDuplic.FieldByName('CTP_PARCEL').AsString;
      ParamByName('CODEMP').AsString  := qryDuplic.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
      ParamByName('SERIE_').AsString  := qryDuplic.FieldByName('CTP_SERIE_').AsString;
      ParamByName('SEQBAI').AsInteger := qryDuplic.FieldByName('CTP_SEQBAI').AsInteger;
      ExecSQL;
      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;

    Result := True;

  Finally
    FreeAndNil(qryAtbPag);

    edtTotalSelecionado.Text := fRetTotDupSel;
  End;

end;

function TfrmGerDupSel.fSelecionaDuplicataContasReceber: Boolean;
  Var
    strSQL   : String;
    strChave : String;
    intRecNro: Integer;
    qryAtbRec: TUniQuery;
begin
  Result := false;
  intRecNro := qryDuplic.RecNo;

  If qryDuplic.State = dsEdit Then
    qryDuplic.Post;

  If (Not blnEstorno) And
     (Not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryDuplic.FieldByName('CTR_ESPDOC').AsString)) Then
    Exit;

  {***************************************************************************************************}
  {* NO CASO DO USUÁRIO SOMENTE CARREGAR O GRID E NESSE MOMENTO A DUPLICATA SOFREU ALGUMA ALTERAÇÃO, *}
  {* QUANDO FOR MARCAR O SISTEMA VERIFICA SE A MESMA FOI ALTERADA. ***********************************}
  {***********************************************************************REQ:117920***************MT*}
  If Not fVerificaUltimaAlteracaoCadRec Then
    Exit;

  If Not blnEstorno THen
  Begin
    If qryDuplic.FieldByName('CTR_DTAREC').AsString.IsEmpty Then
    Begin
      If Not qryDuplic.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'Essa duplicata não pode ser selecionada pois possui Pix gerado e ativo.', ['&Ok']);

        Exit;
      End;

      //MF: 282523 e 279633 - 16/05/2023 - ini
      If qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'NF' Then
      Begin
        If Not fVerificaContRecNFAutorizadaSefaz(qryDuplic.FieldByName('NUMDUP').AsString,
                                                 qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                                 qryDuplic.FieldByName('CTR_CODEMP').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este boleto não pode ser emitido, pois a nota fiscal não foi autorizada na SEFAZ. ' + #13#10 +
                                'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&OK']);
          Exit;
        End;
      End;
      //MF: 282523 e 279633 - 16/05/2023 - fim

      If qryDuplic.FieldByName('CLI_C_G_C_').AsString.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'Essa duplicata não pode ser selecionada pois o cliente não possui CPF/CNPJ cadastrado.', ['&Ok']);

        Exit;
      End;
    End;

  End
  Else If SelecionandoDuplicatasGeradasPorAPI(qryDuplic.FieldByName('CTR_CARTEI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este boleto não pode ser estornado por essa rotina, pois foi gerado através da API. ' + #13#10 +
                          'Para cancelar o documento, deve acessar Cancelar Boletos e selecionar a carteira em que foi gerado o boleto.', ['&OK']);

    Exit;
  End;

  If (blnGlobalCob) or ((Not blnEstorno) And FblnEnvPro) Then
  begin

    {*********************************************}
    {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
    {******************************************MO*}
    If fTemNaCadCbi(qryDuplic.FieldByName('NUMDUP').AsString,
                    qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                    qryDuplic.FieldByName('CTR_PARCEL').AsString,
                    qryDuplic.FieldByName('CTR_CODEMP').AsString,
                    qryDuplic.FieldByName('CTR_CODCLI').AsString,
                    '')                                        Then
    Begin
      fMensagem('','Essa duplicata já foi selecinada para ser enviada ao banco!', ['&OK']);
      Exit;
    End;
  end;

  Try

    qryAtbRec := fCriaQuery(Self);

    IF (NOT blnEstorno) THEN
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT CBI_NUMDUP, CBI_PARCEL, CBI_ESPDOC, CBI_CODEMP, CBI_CODBCO ';
      strSQL := strSQL + 'FROM CADCBI ';
      strSQL := strSQL + 'WHERE  ';
      strSQL := strSQL + '  CBI_CODBCO IS NULL AND ';
      strSQL := strSQL + '  CBI_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CBI_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CBI_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CBI_CODCLI = :CODCLI     ';

      With qryAtbRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qryDuplic.FieldByName('CTR_PARCEL').AsString;
        ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
        Open;
      End;

      if not qryAtbRec.IsEmpty then
      begin
        Result := False;
        fMensagem('','Essa duplicata já foi selecionada para protesto!',['&O K']);
        Exit;
      end;

       {**********************************
       * TRAVA AS DUPLICATAS NA LCKATC   *
       **********Req: 117920************MT}
      If Not(qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M') Then
      Begin
        If Not fTravaDuplicataNaLCKATC(qryDuplic.FieldByName('NUMDUP').AsString,
                                       qryDuplic.FieldByName('CTR_PARCEL').AsString,
                                       qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                       qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                       qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                       qryDuplic.FieldByName('AUTOINCREM').AsString) Then
        Begin
          Exit;
        End;
      End;
    end;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';

    If qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M' Then
      strSQL := strSQL + '  CTR_MARCAD = "D", '
    Else
      strSQL := strSQL + '  CTR_MARCAD = "M", ';

    strSQL := strSQL + '  CTR_CODCAR = :CODCAR ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

    If (Not FblnEnvPro) Then
      strSQL := strSQL + '  AND CTR_CARTEI = :CARTEI ';

    If (Not blnEstorno) And (Not FblnEnvPro) Then
    Begin
      If (Not blnGlobalCob)  And (strCodBco<>'SER') then
      begin
        {**********************************************************}
        { Não permite a seleção de duplicatas sem o Nosso Número   }
        { caso o responsável pela emissão do Boleto seja a Empresa }
        {*******************************************************RV*}

        {***********************************************}
        {* CHAVE PARA NÃO FICAR PERGUNTANDO A CARTEIRA *}
        {********************************************AF*}
        If (Not fEmptyStr(strBanIni)) And (intCodCar > 0) Then
          strChave := 'CONFIG' + strBanIni + '-' + IntToStr(intCodCar) + '-' + VS_strCodEmp
        Else
          strChave := '';

        If qryDuplic.FieldByName('CTR_MARCAD').AsString <> 'M' Then
        Begin
          fVer_Banco_Carteira(strCodBco, strChave, strBanIni, intCodCar, False);
          Inc(intQtdSel);
        End
        Else
          intQtdSel := intQtdSel - 1;

        If intQtdSel = 0 Then
          intCodCar := 0;
      end;
    End;

    intCartei := intCodCar;
    strBanco_ := strBanIni;

    if FBoleCode then
    begin
      if fGetBancoConfig(0, 'CONFIG341-' +  IntToStr(intCartei), 'GERAPIX', '') = 'N' then
      begin
        fMensagem('ATENÇÃO', 'Carteira não configurada para Gerar Boletos Pix QRCode.', ['&Ok']);
        intQtdSel := intQtdSel - 1;
        If intQtdSel = 0 Then
          intCodCar := 0;
        Exit;
      end;
    end;

    If blnOcorrencias And
       fEmptyStr(qryDuplic.FieldByName('CTR_OCORRE').AsString) And
       (qryDuplic.FieldByName('CTR_MARCAD').AsString <> 'M') Then
    Begin
      Result := False;
      fMensagem('','Não foi possível selecionar esta duplicata, escolha uma ocorrência para enviar ao banco!',['&O K']);
      Exit;
    End;

    if (not blnEstEnvSPC) and (not blnGlobalCob) and (strCodBco<>'SER') and (not blnOcorrencias) and (Not FblnEnvPro) then
    begin
      If  (strCodBco = '021') Or (strBanIni = '033B') Or
          (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'B') Or
         ((fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'E') And
          (qryDuplic.FieldByName('CTR_NOSNUM').AsString <> EmptyStr))                            Or
          (qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M')                                   Or
          (blnEstorno)                                                                           Then
      Begin
        If ((strCodBco = '341') or (strCodBco = '995'))                                              And
           (Length(qryDuplic.FieldByName('CTR_NOSNUM').AsString) <> 9)                              And
           ((fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'E')) And
           Not (blnEstorno)                                                                         Then
        Begin
          intQtdSel := intQtdSel - 1;
          fMensagem('', 'Nosso número gravado incorretamente, reimprima o boleto recalculando o nosso número!', ['&Ok']);

          If intQtdSel = 0 Then
            intCodCar := 0;

          Exit;
        End;


        {**********************************************************}
        { Não permite a seleção de duplicatas caso o responsável   }
        { pela emissão do Boleto seja o Banco e o nosso número     }
        { esteja preenchido                                        }
        {*******************************************************LE*}
        If (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'B') And
        (qryDuplic.FieldByName('CTR_NOSNUM').AsString <> EmptyStr) Then
        Begin
          If (Not fEmptyStr(strBanco_)) And (intCartei > 0) Then
            fMensagem('','Não é permitido a geração de duplicatas com Nosso Número quando o responsável é o Banco!',['&O K']);

          intQtdSel := intQtdSel - 1;

          If intQtdSel = 0 Then
            intCodCar := 0;

          Exit;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  TMP_ATBREC ';
        strSQL := strSQL + 'SET ';

        If qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M' Then
          strSQL := strSQL + '  CTR_MARCAD = "D" '
        Else
          strSQL := strSQL + '  CTR_MARCAD = "M" ';

        if (strCodBco<>'SER') And (Not blnOcorrencias) then
          strSQL := strSQL + ',  CTR_CODCAR = :CODCAR ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  CTR_CODCLI = :CODCLI  ';

        If Not (blnEstorno) And (Not blnOcorrencias)                                              And
           (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'E') Then
        begin
          strSQL := strSQL + ' AND CTR_CARTEI = :CARTEI ';
          strSQL := strSQL + ' AND CTR_NOSNUM IS NOT NULL ';
        end;

        If Not (blnEstorno)                                                                       And
           (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'B') Then
        begin
          strSQL := strSQL + ' AND ((CTR_CARTEI IS NULL) OR (CTR_CARTEI = "")) ';
          strSQL := strSQL + ' AND ((CTR_NOSNUM IS NULL) OR (CTR_NOSNUM = "")) ';
        end;


        With qryAtbRec Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
          ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
          If (strCodBco<>'SER') And (Not blnOcorrencias) Then
            ParamByName('CODCAR').AsInteger:= intCodCar;

          if FindParam('CARTEI') <> nil then
            ParamByName('CARTEI').AsString := qryDuplic.FieldByName('CTR_CARTEI').AsString;

          ExecSQL;
          Close;
        End;

        If (qryAtbRec.RowsAffected <= 0) Then
        Begin
          Result := False;
          fMensagem('','Não é permitido a Geração de Duplicatas sem Nosso Número quando o responsável é a empresa!',['&O K']);
            intQtdSel := intQtdSel - 1;

            If intQtdSel = 0 Then
              intCodCar := 0;

            Exit;
        End;

        Result := True;
      End
      Else
      Begin
        Result := False;
        intQtdSel := intQtdSel - 1;

        If (Not fEmptyStr(strBanco_)) And (intCartei > 0) Then
          fMensagem('','Não é permitido a geração de duplicatas sem Nosso Número quando o responsável é a Empresa!',['&O K']);

        If intQtdSel = 0 Then
          intCodCar := 0;
      End;
    end
    else
    begin
      With qryAtbRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;

        If (Not FblnEnvPro) Then
        Begin
          ParamByName('CODCAR').AsInteger:= intCodCar;
          ParamByName('CARTEI').AsString := qryDuplic.FieldByName('CTR_CARTEI').AsString;
        End;

        ExecSQL;
        Close;
      End;

      If qryAtbRec.RowsAffected <= 0 Then
      Begin
        Result := False;
        fMensagem('','Não foi possível selecionar esta duplicata, verifique se os dados estão corretos e se a carteira selecionada é compatível com os dados!',['&O K']);
        Exit;
      End;

      Result := True;
    end;
  Finally
    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    qryDuplic.RecNo := intRecNro;

    edtTotalSelecionado.Text := fRetTotDupSel;

    FreeAndNil(qryAtbRec);
  End;

end;

function TfrmGerDupSel.fSelTodosContasPagar(pgbStatus: TcxProgressBar): Boolean;
  Var
    strSQL      : String;
    intRecNro   : Integer;
    qryUptAtbPag: TUniQuery;
    blnInconsistencia,
    blnInconsistenciaGNRE,
    AInconsistenciaNaoTratada: Boolean;
begin
  Result := True;

  blnInconsistencia     := False;
  blnInconsistenciaGNRE := False;
  AInconsistenciaNaoTratada := False;
  qryDuplic.AfterScroll := nil;
  Try
    qryUptAtbPag := fCriaQuery(Self);
    intRecNro := qryDuplic.RecNo;
    qryDuplic.DisableControls;

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_ATBPAG ';
    strSQL := strSQL + 'SET CTP_MARCAD = "M" ';
    strSQL := strSQL + 'WHERE TRUE '; //(IFNULL(CTP_CODBAR, "") <> "")';

    If fCfgSis('CTPLBB', varBoolean) Then
      strSQL := strSQL + '  AND CTP_DTALIB IS NOT NULL ';

    With qryUptAtbPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;

      qryUptAtbPag.RowsAffected;
      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;

    pgbStatus.Properties.Max := qryDuplic.RecordCount;
    qryDuplic.First;
    While Not qryDuplic.Eof Do
    Begin
      If qryDuplic.FieldByName('CTP_MARCAD').AsString = 'M' Then
      Begin
        If not blnEstorno Then
        Begin
          If Not fValidaDuplicata(False) Then
          Begin
            blnInconsistencia := True;
            qryDuplic.Edit;
            qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
            qryDuplic.Post;
          End;
        End;

        {******************************************}
        { VERIFICA SE MARCOU TRIBUTO INDEVIDAMENTE }
        {***************************************CH*}
        If ((qryDuplic.FieldByName('CTP_TIPDOC').asString='2') And
            ((qryDuplic.FieldByName('CTP_Q_GUIA').asString='') Or
             (qryDuplic.FieldByName('CTP_CODREC').asString=''))) Then
        Begin
          blnInconsistencia := True;
          qryDuplic.Edit;
          qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
          qryDuplic.Post;
        End

        {********************************}
        {* VALIDA CÓDIGO DE BARRAS GNRE *}
        {*****************************AJ*}
        Else If ((qryDuplic.FieldByName('CTP_TIPDOC').asString = '2') And
                 (qryDuplic.FieldByName('CTP_Q_GUIA').asString = '7') And
                 (fEmptyStr(qryDuplic.FieldByName('CTP_CODBAR').asString))) Then
        Begin
          blnInconsistenciaGNRE := True;
          qryDuplic.Edit;
          qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
          qryDuplic.Post;
        End

        {***********************************************}
        {* ISS, IPTU E FGTS NÃO SÃO TRATADOS NO AUTBAN *}
        {********************************************MO*}
        Else If (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '8') Or
                (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '9') Or
                (qryDuplic.FieldByName('CTP_Q_GUIA').AsString = '10') Then
        Begin
          AInconsistenciaNaoTratada := True;
          qryDuplic.Edit;
          qryDuplic.FieldByName('CTP_MARCAD').AsString := 'D';
          qryDuplic.Post;
        End;

      End;

      qryDuplic.Next;
      pStep(pgbStatus);
    End;

    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';
    qryDuplic.RecNo := intRecNro;
    qryDuplic.EnableControls;

    If blnInconsistencia Then
      fMensagem('','Existem duplicatas com inconsistências nos dados. Portanto, as mesmas não foram marcadas.', ['&OK']);

    If blnInconsistenciaGNRE Then
      fMensagem('ATENÇÃO','Algumas duplicatas GNRE não foram marcadas pois estão faltando cadastrar o código de barras.', ['&OK']);

    If AInconsistenciaNaoTratada Then
      fMensagem('ATENÇÃO', 'Algumas duplicatas de tributos ISS, IPTU e/ou FGTS não são tratadas no AUTBAN. Portanto não foram marcadas.', ['&O K'], 1, True);

    pAtualizaDados;
    pSetFocus(dbgDuplicatas);
  Finally
    edtTotalSelecionado.Text := fRetTotDupSel;
    FreeAndNil(qryUptAtbPag);
  End;
  qryDuplic.AfterScroll    := pAfterScroll;

end;

function TfrmGerDupSel.fSelTodosContasReceber(pgbStatus: TcxProgressBar): Boolean;
  Var
    strSQL,
    strEspDocPermitido: String;

    intRecNro   : Integer;
    qryUptAtbRec: TUniQuery;

    blnMarcou,
    blnEspDocNaoPermitido,
    LDuplicataComPixGerado,
    LDuplicataComClienteSemCNPJCPF: Boolean;
    blnDuplicatasNFNaoAutSefaz: Boolean;//MF: 282523 e 279633 - 16/05/2023
    strDuplicatasNFNaoAutSefaz: String;//MF: 282523 e 279633 - 16/05/2023
begin
  Result := True;
  qryDuplic.AfterScroll := nil;
  blnEspDocNaoPermitido := False;
  strEspDocPermitido    := TEspecieParaArquivoRemessa.New.fRetornaEspeciesPermitidas();
  LDuplicataComPixGerado := False;
  LDuplicataComClienteSemCNPJCPF := False;
  blnDuplicatasNFNaoAutSefaz := False;//MF: 282523 e 279633 - 16/05/2023
  strDuplicatasNFNaoAutSefaz := ''; //MF: 282523 e 279633 - 16/05/2023

  Try
    If (blnGlobalCob) or (FblnEnvPro)Then
    begin
      qryDuplic.First;

      while not qryDuplic.Eof do
      begin
        {*********************************************}
        {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
        {******************************************MO*}
        If fTemNaCadCbi(qryDuplic.FieldByName('NUMDUP').AsString,
                        qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                        qryDuplic.FieldByName('CTR_PARCEL').AsString,
                        qryDuplic.FieldByName('CTR_CODEMP').AsString,
                        qryDuplic.FieldByName('CTR_CODCLI').AsString,
                        '')                                        Then
        Begin
          fMensagem('','Existe(m) duplicata(s) já selecionada(s) para geração!', ['&OK']);
          Exit;
        End;
        qryDuplic.Next;
      end;
    end;

    If  edtTotalSelecionado.Text <> '0,00' Then
    Begin
      fMensagem('','Existem marcações pendentes! Finalize a operação para nova seleção.',['&O K']);
      Exit;
    End;

    {***************************************************************************************************}
    {* NO CASO DO USUÁRIO SOMENTE CARREGAR O GRID E NESSE MOMENTO A DUPLICATA SOFREU ALGUMA ALTERAÇÃO, *}
    {* QUANDO FOR MARCAR O SISTEMA VERIFICA SE A MESMA FOI ALTERADA. ***********************************}
    {***********************************************************************REQ:117920***************MT*}
    If Not fVerificaUltimaAlteracaoCadRec Then
      Exit;

    qryUptAtbRec := fCriaQuery(Self);

    intRecNro := qryDuplic.RecNo;

    IF (NOT blnEstorno) THEN
    begin
      qryDuplic.DisableControls;
      pgbStatus.Properties.Max := qryDuplic.RecordCount;
      qryDuplic.First;

      while not qryDuplic.Eof do
      begin
        strSQL := '';
        strSQL := strSQL + 'SELECT CBI_NUMDUP, CBI_PARCEL, CBI_ESPDOC, CBI_CODEMP, CBI_CODBCO ';
        strSQL := strSQL + 'FROM CADCBI ';
        strSQL := strSQL + 'WHERE  ';
        strSQL := strSQL + '  CBI_CODBCO IS NULL AND ';
        strSQL := strSQL + '  CBI_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '  CBI_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '  CBI_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  CBI_CODCLI = :CODCLI     ';

        With qryUptAtbRec Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('NUMDUP').AsString;
          ParamByName('PARCEL').AsString := qryDuplic.FieldByName('CTR_PARCEL').AsString;
          ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
          Open;
        End;

        if not qryUptAtbRec.IsEmpty then
        begin
          fMensagem('','Existe(m) duplicata(s) já selecionada(s) para protesto!',['&O K']);
          pDestravarDuplicatas;
          Exit;
        end;

        If Not qryDuplic.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          LDuplicataComPixGerado := True;

          qryDuplic.Next;
          pStep(pgbStatus);
          Continue;
        End;

        If qryDuplic.FieldByName('CLI_C_G_C_').AsString.IsEmpty Then
        Begin
          LDuplicataComClienteSemCNPJCPF := True;

          qryDuplic.Next;
          pStep(pgbStatus);
          Continue;
        End;

        //MF: 282523 e 279633 - 15/05/2023 - ini
        If qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'NF' Then
        Begin
          If Not fVerificaContRecNFAutorizadaSefaz(qryDuplic.FieldByName('NUMDUP').AsString,
                                                   qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                                   qryDuplic.FieldByName('CTR_CODEMP').AsString) Then
          Begin
            blnDuplicatasNFNaoAutSefaz := True;
            strDuplicatasNFNaoAutSefaz := strDuplicatasNFNaoAutSefaz + qryDuplic.FieldByName('AUTOINCREM').AsString + '_';

            qryDuplic.Next;
            pStep(pgbStatus);
            Continue;
          End;
        End;
        //MF: 282523 e 279633 - 15/05/2023 - fim

        {**********************************
        * TRAVA AS DUPLICATAS NA LCKATC   *
        **********Req: 117920************MT}
        fTravaDuplicataNaLCKATC(qryDuplic.FieldByName('NUMDUP').AsString,
                                qryDuplic.FieldByName('CTR_PARCEL').AsString,
                                qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                qryDuplic.FieldByName('AUTOINCREM').AsString);

        If (Pos(qryDuplic.FieldByName('CTR_ESPDOC').AsString, strEspDocPermitido) <= 0) Then
          blnEspDocNaoPermitido := True;

        qryDuplic.Next;
        pStep(pgbStatus);
      end;
      qryDuplic.EnableControls;
    end;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_MARCAD = "M" ';

    if (not blnEstEnvSPC) and (not blnGlobalCob) and (strCodBco<>'SER') and (not blnOcorrencias) and (Not FblnEnvPro) then
      strSQL := strSQL + '  , CTR_CODCAR = :CODCAR ';

    {***************************************}
    {* SÓ FAZ A VERIFICAÇÃO DO RESPONSÁVEL *}
    {* PELA EMISSÃO SE FOR ENVIO           *}
    {************************************JU*}
    If (Not blnEstorno) and (not blnGlobalCob) and (strCodBco<>'SER') and (not blnOcorrencias) and (Not FblnEnvPro) Then
    Begin
      {**********************************************************}
      { Não permite a seleção de duplicatas sem o Nosso Número   }
      { caso o responsável pela emissão do Boleto seja a Empresa }
      {*******************************************************RV*}
      {**********************************************************}
      {* CRIADOS PARAMETROS PARA QUANDO FOR BB OU CEF TRAZER SÓ *}
      {* AS CARTEIRAS PREENCHIDAS DO BANCO SELECIONADO          *}
      {*******************************************************JU*}
      fVer_Banco_Carteira(strCodBco, '', strBanIni, intCodCar, False);

      If (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'GERAPIX','') = 'N') and FBoleCode Then
      begin
        fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois possui(em) carteira não configurada para Gerar Boletos Pix QRCode!', ['&OK']);
        pDestravarDuplicatas;
        Exit;
      end;

      If  (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'E') Then
      Begin
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  IFNULL(CTR_NOSNUM, "") <> ""';
      End;

      {**********************************************************}
      { Não permite a seleção de duplicatas caso o responsável   }
      { pela emissão do Boleto seja o Banco e o nosso número     }
	    { esteja preenchido                                        }
      {*******************************************************LE*}
      If fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'B' Then
      Begin
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + ' CTR_NOSNUM IS NULL';
      End;

      If (fEmptyStr(strBanIni)) And (intCodCar = 0) Then
      Begin
        pDestravarDuplicatas;
        Exit;
      End;
    End;

    If blnOcorrencias Then
      strSQL := strSQL + ' WHERE IFNULL(CTR_OCORRE,"") <> "" ';

    {**************************************}
    {* MARCA APENAS OS ESPDOCS PERMITIDOS *}
    {***********************************AJ*}
    If (not blnEstorno) Then
    Begin
      strSQL := strSQL + ' AND CTR_ESPDOC IN (' + fRetStrToSQLIn(strEspDocPermitido) + ') ';
     {*********************************************************
     * NÃO DEIXAR MARCAR DUPLICATAS TRAVADAS NA LCKATC POR    *
     *  OUTRO OPERADOR.                                       *
     ******************************Req: 117920***************MT}
      If Not fEmptyStr(strDupJaTravada) Then
        strSQL := strSQL + ' AND AUTOINCREM NOT IN (' + fRetStrToSQLIn(strDupJaTravada) + ') ';

      //MF: 282523 e 279633 - 16/05/2023
      If (blnDuplicatasNFNaoAutSefaz) Then
        strSQL := strSQL + ' AND AUTOINCREM NOT IN (' + fRetStrToSQLIn(strDuplicatasNFNaoAutSefaz) + ') ';

      strSQL := strSQL + ' AND CTR_TX_PIX IS NULL ';
      strSQL := strSQL + ' AND IFNULL(CLI_C_G_C_, "") <> "" ';
    End
    Else
    Begin
      If Not blnOcorrencias Then
        strSQL := strSQL + ' WHERE TRUE ';

      strSQL := strSQL + ' AND (                                           '+
                         '       LOCATE("341API-", CTR_CARTEI) <= 0        '+
                         '       AND LOCATE("001API-", CTR_CARTEI) <= 0    '+
                           '       AND LOCATE("748API-", CTR_CARTEI) <= 0    '+
                           '       AND LOCATE("756API-", CTR_CARTEI) <= 0    '+
                           '       AND LOCATE("033API-", CTR_CARTEI) <= 0    '+
                           '       AND LOCATE("237API-", CTR_CARTEI) <= 0    '+
                           '     )                                           ';
    End;

    With qryUptAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      if (not blnEstEnvSPC) and (not blnGlobalCob) and (strCodBco<>'SER') and (not blnOcorrencias) and (Not FblnEnvPro) then
        ParamByName('CODCAR').AsInteger := intCodCar;

      ExecSQL;

      intQtdSel := RowsAffected;
      blnMarcou := RowsAffected > 0;

      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    qryDuplic.RecNo := intRecNro;

     pDestravarDuplicatas;

    If (blnOcorrencias) And (Not blnMarcou) Then
      fMensagem('','Não foi possível selecionar uma duplicata, informe primeiro as ocorrências para enviar ao banco!', ['&OK']);

    If (blnEspDocNaoPermitido) Then
      fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois possui(em) espécie de documento não permitida!', ['&OK']);

    If LDuplicataComPixGerado Then
      fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois possui(em) Pix gerado e ativo!', ['&OK']);

    If LDuplicataComClienteSemCNPJCPF Then
      fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s) pois possui(em) o cliente sem CPF/CNPJ cadastrado!', ['&OK']);

    //MF: 282523 e 279633 - 16/05/2023
    If blnDuplicatasNFNaoAutSefaz Then
      fMensagem('ATENÇÃO', 'Existem boletos não selecionados, pois suas respectivas notas fiscais não foram autorizadas na SEFAZ.'+ #13#10 +
                     'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&Ok']);

    pAtualizaDados;
    pSetFocus(dbgDuplicatas);

  Finally
    edtTotalSelecionado.Text := fRetTotDupSel;
    FreeAndNil(qryUptAtbRec);
  End;

  qryDuplic.AfterScroll    := pAfterScroll;
end;

procedure TfrmGerDupSel.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmGerDupSel.fRetornaCalculoCTPTotal(ARemessa: TDataset;
  AOutEnt: Boolean): Double;
begin
  try
    Result := ARemessa.FieldByName('CTP_VALDUP').AsFloat;
    if not MatchStr(strCodBco,['001','033']) then
      Exit;

    if fCfgSis('TOTCTP', varBoolean) then
      Result := ARemessa.FieldByName('CTP_VALDUP').AsFloat +
                ARemessa.FieldByName('CTP_JURSUJ').AsFloat +
                ARemessa.FieldByName('CTP_MULSUJ').AsFloat -
                ARemessa.FieldByName('CTP_VALDES').AsFloat +
                ARemessa.FieldByName('CTP_VENDOR').AsFloat +
                ARemessa.FieldByName('CTP_OUTENT').AsFloat
    else
      Result := ARemessa.FieldByName('CTP_VALDUP').AsFloat +
                IIF(AOutEnt,ARemessa.FieldByName('CTP_OUTENT').AsFloat, 0);
  Except
    Result := 0;
  end;
end;

function TfrmGerDupSel.SelecionandoDuplicatasGeradasPorAPI(
  ACarteiraBoleto: String): Boolean;
begin
  Result := False;

  If ACarteiraBoleto.Contains('CONFIG341API') Then
    Exit(True);

  If ACarteiraBoleto.Contains('CONFIG748API') Then
    Exit(True);

  If ACarteiraBoleto.Contains('CONFIG001API') Then
    Exit(True);

  If ACarteiraBoleto.Contains('CONFIG756API') Then
    Exit(True);

  If ACarteiraBoleto.Contains('CONFIG033API') Then
    Exit(True);

  If ACarteiraBoleto.Contains('CONFIG237API') Then
    Exit(True);
end;

function TfrmGerDupSel.fTravaDuplicataNaLCKATC(strNumDup, strParcel,strEspDoc,
                                               strCodEmp, strCodCli,strAutoin:String): Boolean;
  Var
    strChave : String;
begin
  Result := True;
  strChave :='CADCBI'+strAutoin+strNumDup+strParcel+
                      strEspDoc+strCodEmp+strCodCli;

  If Not objLock.fLock_Unlock(strChave, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'A duplicata: '+strNumDup+'-'+strParcel+'-'+
                                         strEspDoc+'-'+strCodEmp+'-'+strCodCli+' está sendo utilizada por outra estação: ' + fGetHostLock(strChave), ['&Ok']);
    Result := False;
    If Not(Pos(strAutoin, strDupJaTravada) > 0) Then
      strDupJaTravada := strDupJaTravada+strAutoin+'_';
  End
  Else
  Begin
    If Not(Pos(strAutoin, strDupTravada) > 0) Then
      strDupTravada := strDupTravada+strAutoin+'_';

    If (Pos(strAutoin, strDupJaTravada) > 0) Then
      strDupJaTravada := StringReplace(strDupJaTravada,strAutoin+'_','',[]);
  End;

end;

procedure TfrmGerDupSel.spbAmpliarClick(Sender: TObject);
begin
  inherited;
  If (dbgDuplicatasDBTableView1.DataController.DataSource.DataSet.Active) And (Not dbgDuplicatasDBTableView1.DataController.DataSource.DataSet.IsEmpty) Then
    TfrmMemo.pShowMessage(AnsiReplaceStr(edtHistor.Text,
                                         '<<csq>>', #13#10), 11);
end;

procedure TfrmGerDupSel.pProtestaContasPagar;
  Var
    strSQL      : String;
    intRecNro   : Integer;
    qryUptAtbPag: TUniQuery;

begin
  Try

    qryUptAtbPag := fCriaQuery(Self);

    intRecNro := qryDuplic.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'SET ';

    If qryDuplic.FieldByName('CTP_PROTES').AsString = 'N' Then
      strSQL := strSQL + '  CTP_PROTES = "S" '
    Else
      strSQL := strSQL + '  CTP_PROTES = "N" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    With qryUptAtbPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := qryDuplic.FieldByName('CTP_NUMDUP').AsString;
      ParamByName('PARCEL').AsString  := qryDuplic.FieldByName('CTP_PARCEL').AsString;
      ParamByName('CODEMP').AsString  := qryDuplic.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
      ParamByName('SERIE_').AsString  := qryDuplic.FieldByName('CTP_SERIE_').AsString;
      ParamByName('SEQBAI').AsInteger := qryDuplic.FieldByName('CTP_SEQBAI').AsInteger;
      ExecSQL;
      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';
    qryDuplic.RecNo := intRecNro;

    pSetFocus(dbgDuplicatas);

  Finally
    FreeAndNil(qryUptAtbPag);
  End;

end;

procedure TfrmGerDupSel.pProtestaContasReceber;
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryUptAtbRec: TUniQuery;

begin

  Try

    qryUptAtbRec := fCriaQuery(Self);

    intRecNro := qryDuplic.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';

    If qryDuplic.FieldByName('CTR_PROTES').AsString = 'N' Then
      strSQL := strSQL + '  CTR_PROTES = "S" '
    Else
      strSQL := strSQL + '  CTR_PROTES = "N" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryUptAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    qryDuplic.RecNo := intRecNro;

    pSetFocus(dbgDuplicatas);

  Finally
    FreeAndNil(qryUptAtbRec);
  End;

end;

function TfrmGerDupSel.ConfirmaContasPagar(prgStatus: TcxProgressBar): Boolean;
  Var
    blnSucesso: Boolean;
    prcScroll : TprcScroll;
    strFormaPgto: String;
    strCodTED   : String;
    datDataPag  : TDate;
    LCodBco: String;

    LInicioCFG: String;
    LCarteiraBancoEnvio : String;
begin
  Result := True;

  If Not AlgumRegistroMArcado Then
    Exit(False);

  prgStatus.Properties.Max := qryDuplic.RecordCOunt;
  prgStatus.Position := 0;

  LCarteiraBancoEnvio := 'CNAB';
  if FContasAPagarAPI then
    LCarteiraBancoEnvio := 'API';

  If Not qryDuplic.IsEmpty Then
  Begin
    If FContasAPagarAPI Then
    Begin
      If strLog.Contains('CANC. DE DUPLICATAS ENVIADAS') Then
      Begin
        If MatchStr(strCodBco, ['001']) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O cancelamento de duplicatas faz a limpeza apenas dos dados da geração/envio ao banco.' + #13 +
                                         'Caso as duplicatas já estejam no banco e aceitas para pagamento, essas devem ser ' +
                                         'canceladas seu agendamento de pagamento junto ao banco.' + #13 +
                                         'Deseja realmente continuar?', ['&Sim', '&Não'], 1) = 1;

          If Not Result Then
            Exit;
        End;
      End;
    End;

    {*************************}
    {* ESTORNO DE DUPLICATAS *}
    {**********************AF*}
    If blnEstorno Then
    Begin
      fStartTransaction;
      Try

        With qryDuplic Do
        Begin
          pDisableControls(qryDuplic, prcScroll);

          First;

          While Not Eof Do
          Begin
            untFuncoesSimples.pStepStatusGravacao(prgStatus);

            {***********************************}
            {* PASSA APENAS SE ESTIVER MARCADO *}
            {********************************AF*}
            If FieldByName('CTP_MARCAD').AsString = 'M' Then
            Begin

              pEstornaDuplicataContasPagar(LeftStr(FieldByName('CTP_NUMDUP').AsString,
                                           Length(FieldByName('CTP_NUMDUP').AsString)-1),
                                           FieldByName('CTP_PARCEL').AsString,
                                           FieldByName('CTP_CODEMP').AsString,
                                           FieldByName('CTP_CODFOR').AsString,
                                           FieldByName('CTP_SERIE_').AsString,
                                           FieldByName('CTP_SEQBAI').AsInteger,
                                           LCarteiraBancoEnvio);

            End;
            Next;
          End;

          fCommit;

          {****************}
          {* GRAVA LOGCTP *}
          {*47667**********}
          First;
          While Not Eof Do
          begin
            If FieldByName('CTP_MARCAD').AsString = 'M' Then
              pGravaLogCtp(FieldByName('AUTOINCREM').AsString,
                           'ESTORNO DE DUPLICATA ENVIADA PARA BANCO - AUTBAN');

            Next;
          end;
          fMensagem('','Cancelamento efetuado com sucesso!',['&O K']);
          btnSair.Click;
          pEnableControls(qryDuplic, prcScroll);
        End;

      Except
        pEnableControls(qryDuplic, prcScroll);
        fRollBack;
      End;

      Exit;
    End;

    {**********************}
    {* SE NÃO FOR EXTORNO *}
    {*******************AF*}
    Try
      {*******************}
      {* PEGA O PORTADOR *}
      {****************AF*}
      {Try
        pCriarFormularios(TfrmPedePortador,frmPedePortador);
        frmPedePortador.ShowModal;

        blnSucesso := frmPedePortador.blnConfirma;
        strCodPor  := frmPedePortador.strCodPor;
      Finally
        FreeAndNil(frmPedePortador);
      End;}

      blnSucesso := True;

      {************************************}
      {* SE PEGOU CORRETAMENTE O PORTADOR *}
      {* CONTINUA                         *}
      {*********************************AF*}
      If blnSucesso Then
      Begin
        datDataPag := 0;
        LCodBco := strCodBco;

        If Not fEmptyStr(strTipoBanco) Then
          LCodBco := Concat(strCodBco,'_',strTipoBanco);

        LInicioCFG := 'CONFIGCTA';
        If blnPGG Then
          LInicioCFG := 'CONFIGPGG';

        If FContasAPagarAPI Then
        BEgin
          LInicioCFG := 'CONFIGCTAAPI';
          LCodBco := strCodBco;
        End;

        If MatchStr(LCodBco,['341','001','237_240p','041']) Then
        Begin
          //seleciona a carteira para ler a configuração abaixo
          If Not fVer_Banco_Carteira(LCodBco, '', strBanIni, intCodCar, False, '', LInicioCFG) Then
            Exit;

          {********************************}
          {* SOLICITA A DATA DE PAGAMENTO *}
          {*REQ*145181******************RP*}
          If (fGetBancoConfig(0, LInicioCFG + LCodBco + '-' + IntToStr(intCodCar), 'SOLICDT', '') = 'S') Then
          Begin
            Try
              pCriarFormularios(TfrmDigDataPagamento, frmDigDataPagamento);
              frmDigDataPagamento.ShowModal;
              If frmDigDataPagamento.ModalResult = mrOk Then
              Begin
                If frmDigDataPagamento.rgpTipoData.ItemIndex = 1 Then
                  datDataPag := frmDigDataPagamento.dtmData.Date;
              End
              Else
                Exit;
            Finally
              FreeAndNil(frmDigDataPagamento);
            End;
          End;
        End;

        If fStartTransaction Then
        Begin

          With qryDuplic Do
          Begin
            pDisableControls(qryDuplic, prcScroll);
            First;

            While Not Eof Do
            Begin
              untFuncoesSimples.pStepStatusGravacao(prgStatus);

              strFormaPgto := AnsiUpperCase(Copy(FieldByName('DEPOSI').AsString, 1, 3));
              strCodTED    := AnsiUpperCase(Copy(FieldByName('CODTED').AsString, 1, 5));

              {***********************************}
              {* PASSA APENAS SE ESTIVER MARCADO *}
              {********************************AF*}
              If FieldByName('CTP_MARCAD').AsString = 'M' Then
              Begin

                frmModuloCadPgi.pGravaCadPagGer(LeftStr(FieldByName('CTP_NUMDUP').AsString,
                                                        Length(FieldByName('CTP_NUMDUP').AsString)-1),
                                                        FieldByName('CTP_PARCEL').AsString,
                                                        FieldByName('CTP_CODEMP').AsString,
                                                        FieldByName('CTP_CODFOR').AsString,
                                                        strCodBco,
                                                        FieldByName('CTP_SERIE_').AsString,
                                                        FieldByName('CTP_CODBAR').AsString,
                                                        FieldByName('CTP_LINDIG').AsString,
                                                        FieldByName('CTP_SEQBAI').AsInteger,
                                                        strFormaPgto,
                                                        FieldByName('CTP_BCOFOR').AsString,
                                                        LCarteiraBancoEnvio);

                frmModuloCadPgi.qryCadPgi.Open;

                frmModuloCadPgi.pGravaCadPgiGer(LeftStr(FieldByName('CTP_NUMDUP').AsString,
                                                Length(FieldByName('CTP_NUMDUP').AsString)-1),
                                                FieldByName('CTP_PARCEL').AsString,
                                                FieldByName('CTP_CODEMP').AsString,
                                                FieldByName('CTP_CODFOR').AsString,
                                                strCodBco,
                                                FieldByName('CTP_CODCTA').AsString,
                                                FieldByName('CTP_CODBAR').AsString,
                                                FieldByName('CTP_LINDIG').AsString,
                                                FieldByName('CTP_PROTES').AsString,
                                                FieldByName('CTP_SERIE_').AsString,
                                                FieldByName('AUTOINCREM').AsString,
                                                FieldByName('CTP_DTACAD').AsDateTime,
                                                FieldByName('CTP_DTAVEN').AsDateTime,
                                                IIF(datDataPag > 0, datDataPag, FieldByName('CTP_DTAPAG').AsDateTime),
                                                FieldByName('CTP_DTAENV').AsDateTime,
                                                fRetornaCalculoCTPTotal(qryDuplic), //FieldByName('CTP_VALDUP').AsFloat,
                                                fStrToFloat(strJuros), //FieldByName('CTP_VALJUR').AsFloat
                                                FieldByName('CTP_VALDES').AsFloat,
                                                FieldByName('CTP_VALDUP').AsFloat,
                                                FieldByName('CTP_SEQBAI').AsInteger,
                                                FieldByName('CTP_QTDDIA').AsInteger,
                                                strFormaPgto,
                                                strCodTED,
                                                FieldByName('CTP_Q_GUIA').AsString,
                                                FieldByName('CTP_CODREC').AsString,
                                                FieldByName('CTP_COMPET').AsString,
                                                FieldByName('CTP_BCOFOR').AsString,
                                                FieldByName('CTP_TIPDOC').asString,
                                                FieldByName('CTP_OUTENT').AsFloat,
                                                FieldByName('PAG_AUTCTP').asString,
                                                blnPGG,
                                                LCarteiraBancoEnvio);

                frmModuloCadPgi.qryCadPgi.Close;
              End;

              Next;

            End;

            fCommit;

            {****************}
            {* GRAVA LOGCTP *}
            {*47667**********}
            First;
            While Not Eof Do
            begin
              If FieldByName('CTP_MARCAD').AsString = 'M' Then
                pGravaLogCtp(FieldByName('AUTOINCREM').AsString,
                             'ENVIO DE DUPLICATA PARA O BANCO - AUTBAN');
              Next;
            end;

            fMensagem('','Geração efetuada com sucesso!',['&O K']);
            btnSair.Click;
            //pEnableControls(qryDuplic, prcScroll);
          End;

        End
        Else
        Begin
          fRollBack;
        End;

      End;

    Except
      On E:Exception Do
      Begin
        fRollBack;
        Raise Exception.Create(E.Message);
      End;
    End;

  End;

end;

procedure TfrmGerDupSel.pGravaCodFinalidadeTED(strTexto: String);
Var
  strSQL   : String;
  intRecNro: Integer;
  qryAtbRec: TUniQuery;
begin
  intRecNro := qryDuplic.RecNo;

  Try
    qryAtbRec := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_ATBPAG ';
    strSQL := strSQL + 'SET CODTED = :CODTED ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    With qryAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := qryDuplic.FieldByName('CTP_NUMDUP').AsString;
      ParamByName('PARCEL').AsString  := qryDuplic.FieldByName('CTP_PARCEL').AsString;
      ParamByName('CODEMP').AsString  := qryDuplic.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
      ParamByName('SERIE_').AsString  := qryDuplic.FieldByName('CTP_SERIE_').AsString;
      ParamByName('SEQBAI').AsInteger := qryDuplic.FieldByName('CTP_SEQBAI').AsInteger;
      ParamByName('CODTED').AsString  := strTexto;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryAtbRec);

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;
  End;
end;

procedure TfrmGerDupSel.pGravaFormaPgto(strTexto: String);
Var
  strSQL   : String;
  intRecNro: Integer;
  qryAtbRec: TUniQuery;
begin
  intRecNro := qryDuplic.RecNo;

  Try
    qryAtbRec := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE TMP_ATBPAG ';
    strSQL := strSQL + 'SET DEPOSI = :DEPOSI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    With qryAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := qryDuplic.FieldByName('CTP_NUMDUP').AsString;
      ParamByName('PARCEL').AsString  := qryDuplic.FieldByName('CTP_PARCEL').AsString;
      ParamByName('CODEMP').AsString  := qryDuplic.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString  := qryDuplic.FieldByName('CTP_CODFOR').AsString;
      ParamByName('SERIE_').AsString  := qryDuplic.FieldByName('CTP_SERIE_').AsString;
      ParamByName('SEQBAI').AsInteger := qryDuplic.FieldByName('CTP_SEQBAI').AsInteger;
      ParamByName('DEPOSI').AsString := strTexto;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryAtbRec);

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;
  End;
end;

procedure TfrmGerDupSel.pGravaLogCtp(AAutoincrem, strDescricaoLog: String);
begin
  Try
    untLogCtp.GravaLogCtp(AAutoincrem, strDescricaoLog, Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmGerDupSel.pGravaLogCtp]');
  End;
end;


function TfrmGerDupSel.ConfirmaContasReceber(prgStatus: TcxProgressBar): Boolean;
  Var
    blnSucesso: Boolean;
    strCodPor : String;
    strNosNum : String;
    strCtrEme : String;
    strCartei : String;
    dtaDtaBol : TDate;
    qryConBco : TUniQuery;
    prcScroll : TprcScroll;
    strSeqGeral: String;
    fltVlrTit : Double;
    strLinDig : String;
    strEmpSemAcesso: String;
    strVarProtesto : String;
    strPorRem, strNumPos, strCodBan : String;
    strOcPadraoInc : String;
    LStatusSPC: String;

    procedure pIncArrLogCtr;
    Begin
      {****************}
      {* GRAVA LOGCTR *}
      {*************JS*}
      untLogCtr.GravaLogCtr(qryDuplic.FieldByName('AUTOINCREM').AsString,
                            IIF((Not fEmptyStr(strLog)) And (Not FblnEnvPro),
                                 strLog,
                                 IIF(FblnEnvPro,
                                     'GERAÇÃO DE DUPLICATAS PARA PROTESTO',
                                     'GERAÇÃO DE DUPLICATAS'
                                 )
                            ), Self.Name);
    End;

begin
  Result := True;

  If Not AlgumRegistroMArcado Then
    Exit(False);

  qryDuplic.AfterScroll    := nil;
  dtaDtaBol := 0;
  strCartei := '';
  strVarProtesto := '';
  strPorRem := '';
  strNumPos := '';
  strCodBan := '';


  prgStatus.Properties.Max := qryDuplic.RecordCOunt;
  prgStatus.Position := 0;

  Try
    If Not qryDuplic.IsEmpty Then
    Begin
      {*************************}
      {* ESTORNO DE DUPLICATAS *}
      {**********************AF*}
      If blnEstorno Then
      Begin
        fStartTransaction;
        Try

          With qryDuplic Do
          Begin
            pDisableControls(qryDuplic, prcScroll);

            First;
            While Not Eof Do
            Begin
              untFuncoesSimples.pStepStatusGravacao(prgStatus);

              {***********************************}
              {* PASSA APENAS SE ESTIVER MARCADO *}
              {********************************AF*}
              If FieldByName('CTR_MARCAD').AsString = 'M' Then
              Begin
                IF Not fEmptyStr(FieldByName('CTR_CARTEI').AsString) then
                  strCartei := FieldByName('CTR_CARTEI').AsString
                else
                  strCartei := '';

                LStatusSPC := '';
                If blnEstEnvSPC And Assigned(qryDuplic.FindField('CTR_STSSPC')) Then
                  LStatusSPC := FieldByName('CTR_STSSPC').AsString;

                pEstornaDuplicata(FieldByName('NUMDUP').AsString,
                                  FieldByName('CTR_PARCEL').AsString,
                                  FieldByName('CTR_ESPDOC').AsString,
                                  FieldByName('CTR_CODEMP').AsString,
                                  FieldByName('CTR_CODCLI').AsString,
                                  strCartei,
                                  LStatusSPC);

                if strCodBco <> 'SER' Then
                Begin
                  pGravaDelRemDet('CANCELAMENTO DE REMESSA BANCARIA',
                                  FieldByName('AUTOINCREM').AsString,
                                  strSeqGeral);
                  pGravaDelRemGer(strSeqGeral, 'CANCELAMENTO DE REMESSA BANCARIA');

                  strSeqGeral := '';
                  if fVerificaRetorno(FieldByName('AUTOINCREM').AsString) then
                  begin
                    pGravaDelRetDet('CANCELAMENTO DE RETORNO BANCARIO UNTGERDUPSEL',
                                    FieldByName('AUTOINCREM').AsString,
                                    strSeqGeral);
                    pGravaDelRetGer(strSeqGeral, 'CANCELAMENTO DE RETORNO BANCARIO UNTGERDUPSEL');
                  End;
                End;

                If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
                Begin
                  TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('NUMDUP').AsString,
                                                           FieldByName('CTR_ESPDOC').AsString,
                                                           FieldByName('CTR_CODEMP').AsString,
                                                           FieldByName('CTR_CODCLI').AsString,
                                                           FieldByName('CTR_PARCEL').AsString,
                                                           strLoginUsuarioLogado,
                                                           fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                           IIF(blnApenasCadRec,afcCancelaEnvioDuplicataBanco,afcCancelaRemessaBancaria));
                End;
              End;
              Next;
            End;

            fCommit;
            fMensagem('','Cancelamento efetuado com sucesso!',['&O K']);
            pEnableControls(qryDuplic, prcScroll);
            btnSair.Click;
          End;

        Except
          On E: Exception Do
          Begin
            fRollBack;
            fMensagem('','Ocorreu um erro ao tentar gravar os dados!' + #13#10 + E.Message,['&O K']);
            pEnableControls(qryDuplic, prcScroll);
          End;
        End;

        Exit;
      End;

      {**********************}
      {* SE NÃO FOR EXTORNO *}
      {*******************AF*}
      Try
        qryConBco := fCriaQuery;

        {*******************}
        {* PEGA O PORTADOR *}
        {****************AF*}
        if not FEhOcorrenciaDeBaixa then
        begin
          Try

            pCriarFormularios(TfrmPedePortador,frmPedePortador);
            frmPedePortador.blnVerificPortador := True;
            strNumPos := frmGerDup.strNumPos ;
            strPorRem := fRetornaPortadorRemessa(VS_strCodEmp, LeftStr(strCodBco, 3), 'PORREM_', strNumPos, intCodCar);

            If strPorRem <> '' Then
            Begin
              frmPedePortador.edtPortador.Text := strPorRem;
              frmPedePortador.edtDesPortador.Text := fRetNomPortador(fStrZero(strPorRem,5));
              frmPedePortador.ShowModal;
            End
            Else
              frmPedePortador.ShowModal;

            blnSucesso := frmPedePortador.blnConfirma;
            strCodPor  := frmPedePortador.strCodPor;
          Finally
            FreeAndNil(frmPedePortador);
          End
        end
        else
        begin
          strCodPor  := '';
          blnSucesso := True;
        end;

        {************************************}
        {* SE PEGOU CORRETAMENTE O PORTADOR *}
        {* CONTINUA                         *}
        {*********************************AF*}
        If blnSucesso Then
        Begin
          {*REQ*145940**********RP*}
          If Not fEmpresasTemAcessoPortador(strCodPor, qryDuplic, 'CTR_CODEMP', strEmpSemAcesso, 'CTR_MARCAD = ''M''') Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
            Exit;
          End;

          pDisableControls(qryDuplic, prcScroll);

          With qryDuplic Do
          Begin
            First;

            While Not Eof Do
            Begin
              untFuncoesSimples.pStepStatusGravacao(prgStatus);

              {***********************************}
              {* PASSA APENAS SE ESTIVER MARCADO *}
              {********************************AF*}
              If FieldByName('CTR_MARCAD').AsString = 'M' Then
              Begin
                fStartTransaction;

                {*****************************************}
                {* CALCULA NOSSO NUMERO PARA SANTANDER   *}
                {**************************************AF*}
                strNosNum := '';
                If (Pos(strCodBco,'353_021_033_') > 0) And fEmptyStr(FieldByName('CTR_NOSNUM').AsString) Then
                Begin

                  If intCodCar = 0 Then
                  Begin
                    If Not fVer_Banco_Carteira(strCodBco, '', strBanIni, intCodCar, False) Then
                    Begin
                      FreeAndNil(qryConBco);
                      Exit;
                    End;
                  End;

                  If (strCodBco = '353') Or (strBanIni = '033B') Then
                  Begin

                    If (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'ENVNOSN','') = 'S') And
                       (fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS','') = 'B') Then
                    Begin
                      pPesquisaBanco(Nil, qryConBco, strCodBco);
                      strNosNum := qryConBco.FieldByName('BCO_PRONUM').AsString;
                      strNosNum := fRetNossoNumeroDisponivel(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);

                      strNosNum := fCalcNossoNumero(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);
                      strNosNum := strNosNum + fCalcDigito(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);

                      dtaDtaBol := VS_Date;
                      {******************************************}
                      {* CALCULA LINHA DIGITAVEL PARA SANTANDER *}
                      {***************************************PA*}
                      untFuncoesBoleto.strNosNum := strNosNum;
                      untFuncoesBoleto.strIdeBan := strCodBco;
                      untFuncoesBoleto.strMoeda1 := '9';
                      untFuncoesBoleto.strCodCed := fGetBancoConfig(0, 'CONFIG' + strBanIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '');
                      untFuncoesBoleto.strCodCar := fGetBancoConfig(0, 'CONFIG' + strBanIni + '-' +  IntToStr(intCodCar), 'CODCART', '');
                      untFuncoesBoleto.strFatVen := CalcularFatorVencimento(StrToDateTime(FieldByName('CTR_DTAVEN').AsString));
                      untFuncoesBoleto.strVlrTit :=  AnsiReplaceStr( FieldByName('CTR_VALDUP').AsString, '.', ',') ;
                      fltVlrTit := fStrToFloat(untFuncoesBoleto.strVlrTit);
                      untFuncoesBoleto.strVlrTit := fPadL(FloatToStr(fFormataFloat(fltVlrTit, 02) * 100), 14, '0');
                      untFuncoesBoleto.strVlrTit := RightStr(untFuncoesBoleto.strVlrTit,10);
                      If( fGeLiDi033B )Then
                      Begin
                        strLinDig := untFuncoesBoleto.strLinDig;
                        strLinDig := AnsiReplaceStr(strLinDig, '.', '');
                        strLinDig := AnsiReplaceStr(strLinDig, ' ', '');
                      End;
                      qryConBco.Edit;
                      qryConBco.FieldByName('BCO_PRONUM').AsString := IntToStr(StrToInt64(LeftStr(strNosNum, Length(strNosNum)-1)) + 1);
                      qryConBco.Post;
                    End;

                  End
                  Else If strCodBco = '021' Then
                  Begin

                    pPesquisaBanco(Nil, qryConBco, strCodBco);
                    strNosNum := qryConBco.FieldByName('BCO_PRONUM').AsString;
                    strNosNum := fRetNossoNumeroDisponivel(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);

                    strNosNum := fCalcNossoNumero(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);
                    strNosNum := strNosNum + fCalcDigito(strCodBco, strNosNum, strBanIni, intCodCar, VS_strCodEmp);

                    dtaDtaBol := VS_Date;

                    qryConBco.Edit;
                    qryConBco.FieldByName('BCO_PRONUM').AsString := IntToStr(StrToInt64(LeftStr(strNosNum, Length(strNosNum)-2)) + 1);
                    qryConBco.Post;
                  End;

                End;

                If (strCodBco = '001') Then
                  strCtrEme := strCodBco + IIF(blnBB6d, '6d', '7d') + '-' + FieldByName('CTR_CODCAR').AsString
                Else If (strCodBco = '104') Then
                  strCtrEme := strCodBco + IIF(blnCEF400, '400p', '240p') + '-' + FieldByName('CTR_CODCAR').AsString
                Else IF (strCodBco = '237') then
                  strCtrEme := strCodBco + IIF(Pos('VENDOR', strBanIni) > 0, '_VENDOR', '') + '-' + FieldByName('CTR_CODCAR').AsString
                Else
                  strCtrEme := strCodBco + '-' + FieldByName('CTR_CODCAR').AsString;

                If fEmptyStr(FieldByName('CTR_CARTEI').AsString) Then
                  strCartei := 'CONFIG' + strBanIni + '-' + IntToStr(intCodCar) + '-' + VS_strCodEmp
                Else
                  strCartei := '';

                frmModuloCadCbi.pGravaCadRecGer(FieldByName('NUMDUP').AsString,
                                                FieldByName('CTR_PARCEL').AsString,
                                                FieldByName('CTR_ESPDOC').AsString,
                                                FieldByName('CTR_CODEMP').AsString,
                                                FieldByName('CTR_CODCLI').AsString,
                                                LeftStr(strCodBco, 3),
                                                strCodPor,
                                                strCtrEme,
                                                strNosNum,
                                                strCartei,
                                                dtaDtaBol,
                                                fGetBancoConfig(0,'CONFIG' + strBanIni + '-' + IntToStr(intCodCar),'RESPONS',''),
                                                blnGlobalCob,
                                                fStrToFloat(strJuros),
                                                strLinDig,
                                                FblnEnvPro);
                                                pIncArrLogCtr;

                If fEmptyStr(strNosNum) Then
                  strNosNum := FieldByName('CTR_NOSNUM').AsString;

                strVarProtesto := IIF(FieldByName('CLI_PROPER').AsString = 'Sim', 'S','N');

                strOcPadraoInc := '01';
                if FBoleCode then
                  strOcPadraoInc := '71';

                If (strBanIni = '748') Then
                Begin
                   strOcPadraoInc := fGetBancoConfig(0, 'CONFIG' + strBanIni + '-' +  IntToStr(intCodCar), 'INSTRU1', '01');
                End;

                frmModuloCadCbi.pGravaCadCbiGer(FieldByName('NUMDUP').AsString,
                                                IIF( strCodBco = '104', FieldByName('CTR_PROTES').AsString, strVarProtesto),
                                                fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                FieldByName('CTR_PARCEL').AsString,
                                                FieldByName('CTR_ESPDOC').AsString,
                                                FieldByName('CTR_CODEMP').AsString,
                                                FieldByName('CTR_CODCLI').AsString,
                                                LeftStr(strCodBco, 3),
                                                strJuros,
                                                strNosNum,
                                                IIF(strCodPor <> '', strCodPor, FieldByName('CTR_CODPOR').AsString),
                                                FieldByName('CTR_DTACAD').AsDateTime,
                                                FieldByName('CTR_DTAVEN').AsDateTime,
                                                FieldByName('CTR_VALDUP').AsCurrency,
                                                FieldByName('CTR_DESSUJ').AsCurrency,
                                                FieldByName('CTR_OBSAG1').AsString,
                                                FieldByName('CTR_OBSAG2').AsString,
                                                FieldByName('CTR_OBSAG3').AsString,
                                                FieldByName('CTR_BCOCRR').AsString,
                                                FieldByName('CTR_NN_CRR').AsString,
                                                0,
                                                IIF(fEmptyStr(FieldByName('CTR_CARTEI').AsString), strCartei, FieldByName('CTR_CARTEI').AsString),
                                                IIF(fCfgSis('USACND', VarBoolean), FieldByName('CTR_CODCND').AsString, ''),
                                                '',
                                                0,
                                                0,
                                                '',
                                                blnGlobalCob,
                                                0,
                                                IIF(fEmptyStr(FieldByName('CTR_OCORRE').AsString),strOcPadraoInc,LeftStr(FieldByName('CTR_OCORRE').AsString,2)),
                                                TipoRemessa);

                If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
                Begin
                  TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('NUMDUP').AsString,
                                                           FieldByName('CTR_ESPDOC').AsString,
                                                           FieldByName('CTR_CODEMP').AsString,
                                                           FieldByName('CTR_CODCLI').AsString,
                                                           FieldByName('CTR_PARCEL').AsString,
                                                           strLoginUsuarioLogado,
                                                           fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                           afcGeraRemessaBancaria);
                End;

                fCommit;
              End;

              Next;
            End;

            fMensagem('','Geração efetuada com sucesso!',['&O K']);
            btnSair.Click;
          End;
          pEnableControls(qryDuplic, prcScroll);

        End;

      Except
        On E:Exception Do
        Begin
          If fInTransaction Then
            fRollBack;
          fMensagem('','Ocorreu um erro ao tentar gravar os dados!' + #13#10 + E.Message,['&O K']);
          pEnableControls(qryDuplic, prcScroll);
        End;
      End;

      FreeAndNil(qryConBco);
    End;
  Finally
    qryDuplic.AfterScroll    := pAfterScroll;
  End;
end;

procedure TfrmGerDupSel.pDesmarcarTodas;
  Var
    qryTmp : TUniQuery;
    strSQL : String;
begin

  strSQL := '';
  qryTmp := fCriaQuery(Self);

  With qryTmp Do
  begin
    If strTipGer = 'P' Then
    Begin
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  TMP_ATBPAG ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTP_MARCAD = "D" ';
    End
    Else
    Begin
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  TMP_ATBREC ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTR_MARCAD = "D" ';
    End;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
  End;

  FreeAndNil(qryTmp);

end;

procedure TfrmGerDupSel.pDesmarcaTodos(strTipo: String);
Var
  strSQL      : String;
  intRecNro   : Integer;
  qryUptAtbPag: TUniQuery;
begin
  Try
    qryUptAtbPag := fCriaQuery(Self);
    intRecNro := qryDuplic.RecNo;
    qryDuplic.DisableControls;

    strSQL := '';

    If strTipo = 'P' Then
    Begin
      strSQL := strSQL + 'UPDATE TMP_ATBPAG ';
      strSQL := strSQL + 'SET CTP_MARCAD = "D" ';
    end
    Else
    Begin
      strSQL := strSQL + 'UPDATE TMP_ATBREC ';
      strSQL := strSQL + 'SET CTR_MARCAD = "D" ';
      qryDuplic.DisableControls;
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fDestravaTodasAsDuplicatas;
      frmGravando.lblGravando.Caption := 'Aguarde... Checando e Desmarcando Duplicatas';
      frmGravando.ShowModal;
      qryDuplic.EnableControls;
    End;

    With qryUptAtbPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      qryUptAtbPag.RowsAffected;
      Close;
    End;

    qryDuplic.Close;
    qryDuplic.Open;
    qryDuplic.First;

    If strTipo = 'P' Then
    Begin
      (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
      (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := '#,##0.00';
    End
    Else
      (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;
    qryDuplic.EnableControls;

    pAtualizaDados;
    pSetFocus(dbgDuplicatas);
  Finally
    edtTotalSelecionado.Text := fRetTotDupSel;
    FreeAndNil(qryUptAtbPag);
  End;
end;

procedure TfrmGerDupSel.pDestravaDuplicataNaLCKATC(strNumDup, strParcel, strEspDoc,
                                                   strCodEmp, strCodCli, strAutoin: String);
  Var
    strChave : String;
begin
  strChave :='CADCBI'+strAutoin+strNumDup+strParcel+
                      strEspDoc+strCodEmp+strCodCli;

  If (Pos(strAutoin, strDupTravada) > 0) Then
  Begin
    objLock.fLock_Unlock(strChave, False);
    strDupTravada := StringReplace(strDupTravada,strAutoin+'_','',[]);
  End;

end;

procedure TfrmGerDupSel.pDestravarDuplicatas;
begin
  {*********************************************************
  * DESTRAVA DA LCKATC TODAS AS DUPLICATAS QUE NÃO FORAM   *
  * MARCADAS.                                              *
  ******************************Req: 117920***************MT}
  With qryDuplic Do
  Begin
    DisableControls;
    Filtered := False;
    Filter   := 'CTR_MARCAD <> ' + QuotedStr('M');
    Filtered := True;

    First;
    While Not Eof Do
    Begin
      If (qryDuplic.FieldByName('CTR_MARCAD').AsString <> 'M') And
         (Pos(FieldByName('AUTOINCREM').AsString, strDupTravada) > 0) Then
      Begin
         pDestravaDuplicataNaLCKATC(FieldByName('NUMDUP').AsString,
                                    FieldByName('CTR_PARCEL').AsString,
                                    FieldByName('CTR_ESPDOC').AsString,
                                    FieldByName('CTR_CODEMP').AsString,
                                    FieldByName('CTR_CODCLI').AsString,
                                    FieldByName('AUTOINCREM').AsString);
      End;
      Next;
    End;
    Filtered:=False;
    EnableControls;
  End;
end;

function TfrmGerDupSel.fDestravaTodasAsDuplicatas(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  With qryDuplic Do
  Begin
    Result := True;
    pgbStatus.Properties.Max := qryDuplic.RecordCount;
    DisableControls;
    First;
    While Not qryDuplic.Eof Do
    Begin
      If (qryDuplic.FieldByName('CTR_MARCAD').AsString = 'M') And
         (Pos(FieldByName('AUTOINCREM').AsString, strDupTravada) > 0) Then
      Begin
        pDestravaDuplicataNaLCKATC(FieldByName('NUMDUP').AsString,
                                   FieldByName('CTR_PARCEL').AsString,
                                   FieldByName('CTR_ESPDOC').AsString,
                                   FieldByName('CTR_CODEMP').AsString,
                                   FieldByName('CTR_CODCLI').AsString,
                                   FieldByName('AUTOINCREM').AsString);
      End;
      Next;
      pStep(pgbStatus);
    End;
   EnableControls;
  End;
end;

function TfrmGerDupSel.fDeveMostrarValorCorrigido: Boolean;
begin
 Result := False;
  if strTipGer <> 'R' then Exit;
  if LeftStr(strCodBco, 3) <> '756' then Exit;
  if qryDuplic.FindField('CTR_VALCOR') = nil then Exit;
  Result := fCfgSis('VALIMP', varBoolean);
end;

procedure TfrmGerDupSel.pEstornaDuplicataContasPagar(strNumDup, strParcel, strCodEmp, strCodFor, strSerie_: String; intSeqBai: Integer; ACarteiraBancoEnvio : String);
  Var
    strSQL: String;
    qryUpdDel: TUniQuery;

begin

  Try

    qryUpdDel := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADPAG ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '  CTP_BCOENV = NULL, ';
    strSQL := strSQL + '  CTP_DTAENV = NULL, ';
    strSQL := strSQL + '  CTP_CARTEI = NULL  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI     ';

    if fEmptyStr(ACarteiraBancoEnvio) then
      strSQL := strSQL + ' AND CTP_CARTEI = :CARTEIRA ';

    With qryUpdDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      ParamByName('SERIE_').AsString  := strSerie_;
      ParamByName('SEQBAI').AsInteger := intSeqBai;

      if fEmptyStr(ACarteiraBancoEnvio) then
        ParamByName('CARTEIRA').AsString  := ACarteiraBancoEnvio;

      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'DELETE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPGI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PGI_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  PGI_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  PGI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PGI_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  PGI_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  PGI_SEQBAI = :SEQBAI     ';

    if not fEmptyStr(ACarteiraBancoEnvio) then
      strSQL := strSQL + '  AND PGI_CARTEI = :CARTEIRA ';

    With qryUpdDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      ParamByName('SERIE_').AsString  := strSerie_;
      ParamByName('SEQBAI').AsInteger := intSeqBai;

      if not fEmptyStr(ACarteiraBancoEnvio) then
        ParamByName('CARTEIRA').AsString := ACarteiraBancoEnvio;

      ExecSQL;
      Close;
    End;

    FreeAndNil(qryUpdDel);

  Except
    On E:Exception Do
    Begin
      FreeAndNil(qryUpdDel);
      Raise Exception.Create(E.Message);
    End;
  End;

{  Finally
    FreeAndNil(qryUpdDel);
  End;
}
end;

procedure TfrmGerDupSel.pMudaCamposGrid;
begin

  qryDuplic.Close;
  dbgDuplicatasDBTableView1CTR_NUMDUP.DataBinding.FieldName := 'CTP_NUMDUP';
  dbgDuplicatasDBTableView1CTR_ESPDOC.DataBinding.FieldName := 'CTP_PARCEL';
  dbgDuplicatasDBTableView1CTR_ESPDOC.Caption               := 'Parcela';
  dbgDuplicatasDBTableView1CTR_CODEMP.DataBinding.FieldName := 'CTP_CODEMP';
  dbgDuplicatasDBTableView1CTR_DTAVEN.DataBinding.FieldName := 'CTP_DTAVEN';
  dbgDuplicatasDBTableView1MARCAD.DataBinding.FieldName     := 'CTP_MARCAD';
  dbgDuplicatasDBTableView1CTR_VALDUP.DataBinding.FieldName := 'VALORTOTAL';
  dbgDuplicatasDBTableView1CTR_DTACAD.DataBinding.FieldName := 'CTP_DTACAD';
  dbgDuplicatasDBTableView1FOR_NOMFOR.DataBinding.FieldName := 'FOR_NOMFOR';
  dbgDuplicatasDBTableView1FOR_NOMFOR.Visible := True;

  qryDuplic.Open;
  (qryDuplic.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := fMskDigitos(2);
  (qryDuplic.FieldByName('VALORTOTAL') As TFloatField).DisplayFormat := fMskDigitos(2);
end;

function TfrmGerDupSel.RetornaStatusRemessaSPCAtual(ANumDup, AParcel, AEspDoc,
  ACodEmp, ACodCli: String): String;
var
  LConsulta: TUniQuery;
begin
  Result := '';
  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Add('SELECT ');
    LConsulta.SQL.Add('  CTR_STSSPC ');
    LConsulta.SQL.Add('FROM ');
    LConsulta.SQL.Add('  CADREC ');
    LConsulta.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP ');
    LConsulta.SQL.Add('  AND CTR_PARCEL = :PARCEL ');
    LConsulta.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
    LConsulta.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
    LConsulta.SQL.Add('  AND CTR_CODCLI = :CODCLI ');
    LConsulta.SQL.Add('  AND CTR_SEQBAI = 0 ');

    LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('ESPDOC').AsString := AEspDoc;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    LConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LConsulta.Open;
    LConsulta.First;

    If Not LConsulta.IsEmpty Then
      Result := LConsulta.FieldByName('CTR_STSSPC').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmGerDupSel.FoiGeradaOutraRemessaSPCAntes(
  ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: String;
  out ADtaSPCAntes: TDate;
  out ACodEveAntes: Variant): Boolean;
var
  LConsulta: TUniQuery;
begin
  Result := False;
  ADtaSPCAntes := 0;
  ACodEveAntes := NULL;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Add('SELECT ');
    LConsulta.SQL.Add('  CTR_DTASPC, ');
    LConsulta.SQL.Add('  CTR_CODEVE  ');
    LConsulta.SQL.Add('FROM ');
    LConsulta.SQL.Add('  LOGCTR ');
    LConsulta.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP ');
    LConsulta.SQL.Add('  AND CTR_PARCEL = :PARCEL ');
    LConsulta.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
    LConsulta.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
    LConsulta.SQL.Add('  AND CTR_CODCLI = :CODCLI ');
    LConsulta.SQL.Add('  AND CTR_DESCRI = "REMESSA DE INCLUSÃO SPC BRASIL LD" ');
    LConsulta.SQL.Add('ORDER BY CTR_DTALOG DESC, CTR_HORLOG DESC LIMIT 1');

    LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('ESPDOC').AsString := AEspDoc;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    LConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LConsulta.Open;
    LConsulta.First;

    If LConsulta.IsEmpty Then
      Exit;    

    Result := True;
    ADtaSPCAntes := LConsulta.FieldByName('CTR_DTASPC').AsDateTime;
    ACodEveAntes := LConsulta.FieldByName('CTR_CODEVE').Value;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmGerDupSel.FormActivate(Sender: TObject);
begin
  inherited;

  lblCodBar.Visible := (strTipGer = 'P');
  edtCodBar.Visible := (strTipGer = 'P');
  lblLinDig.Visible := (strTipGer = 'P');
  edtLinDig.Visible := (strTipGer = 'P');
  lblGuia.Visible   := (strTipGer = 'P');
  edtGuia.Visible   := (strTipGer = 'P');
  lblCodRecTributo.Visible := (strTipGer = 'P');
  edtCodRecTributo.Visible := (strTipGer = 'P');

  if ((strTipGer = 'P') and (blnMosTED)) then
  begin
    CBContaFornecedor.Visible  := True;
    lblContaFornecedor.Visible := True;
  end
  else
  begin
    CBContaFornecedor.Visible  := False;
    lblContaFornecedor.Visible := False;
  end;

end;

procedure TfrmGerDupSel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  qryDuplic.AfterScroll    := Nil;
  qryDuplic.OnFilterRecord := Nil;
  If fEmptyStr(strDupTravada) Then
    Exit;
  qryDuplic.DisableControls;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDestravaTodasAsDuplicatas;
  frmGravando.lblGravando.Caption := 'Aguarde... Checando e Desmarcando Duplicatas';
  frmGravando.ShowModal;
  qryDuplic.EnableControls;
end;

procedure TfrmGerDupSel.btnVerCredClick(Sender: TObject);
  Var
    strSQL  : String;
    qryGen  : TUniQuery;
begin
  inherited;

  qryGen := fCriaQuery;
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + '  CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CTR_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CTR_VALDUP AS VALDUP  ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL   AND ';
  strSQL := strSQL + '  CTR_VALDUP < 0 ';

  If Not fEmptyStr(fCfgSis('POOCRE')) Then
    strSQL := strSQL + 'AND IFNULL(CTR_CODPOR,"") <> ' + String(fCfgSis('POOCRE')).QuotedString;

  strSQL := strSQL + 'ORDER BY  ';
  strSQL := strSQL + '  NUMDUP, ';
  strSQL := strSQL + '  PARCEL, ';
  strSQL := strSQL + '  DTAVEN  ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
    Open;

    If Not IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmVerCreditos,frmVerCreditos);

        First;
        While Not Eof Do
        Begin
          frmVerCreditos.cdsCreditos.Append;
          frmVerCreditos.cdsCreditos.FieldByName('NUMDUP').AsString   := FieldByName('NUMDUP').AsString;
          frmVerCreditos.cdsCreditos.FieldByName('PARCEL').AsString   := FieldByName('PARCEL').AsString;
          frmVerCreditos.cdsCreditos.FieldByName('ESPDOC').AsString   := FieldByName('ESPDOC').AsString;
          frmVerCreditos.cdsCreditos.FieldByName('CODEMP').AsString   := FieldByName('CODEMP').AsString;
          frmVerCreditos.cdsCreditos.FieldByName('DTACAD').AsDateTime := FieldByName('DTACAD').AsDateTime;
          frmVerCreditos.cdsCreditos.FieldByName('DTAVEN').AsDateTime := FieldByName('DTAVEN').AsDateTime;
          frmVerCreditos.cdsCreditos.FieldByName('VALDUP').AsFloat    := FieldByName('VALDUP').AsFloat;
          frmVerCreditos.cdsCreditos.Post;
          Next;
        End;

        First;
        frmVerCreditos.lblCliente.Caption := qryDuplic.FieldByName('CLI_NOMCLI').AsString;
        frmVerCreditos.ShowModal;
      Finally
        pFreeAndNil(frmVerCreditos);
      End;
    End
    Else
      fMensagem('','Não há dados para serem exibidos!',['&O k']);

  End;

  FreeAndNil(qryGen);

end;

procedure TfrmGerDupSel.CarregaDadosBancariosFornecedor(AFornecedor: String; ASequencial: String = '');
Var
  qryContaFornecedor: TUniQuery;
begin
  qryContaFornecedor := fCriaQuery;

  Try
    CBContaFornecedor.Clear;
    lstGravaBcoFor.Clear;

    qryContaFornecedor.Close;
    qryContaFornecedor.SQL.Text := untCadPag.getSQLDadosBancariosFornecedor(FContasAPagarAPI Or BancoArquivoPix);

    qryContaFornecedor.ParamByName('CODFOR').AsString := AFornecedor;
    qryContaFornecedor.Open;

    While Not qryContaFornecedor.Eof Do
    Begin
      CBContaFornecedor.Items.Add(Trim(qryContaFornecedor.FieldByName('DESC_CONTA').AsString));
      lstGravaBcoFor.Add(qryContaFornecedor.FieldByName('TIPO_CONTA').AsString + qryContaFornecedor.FieldByName('AUTOINCREM').AsString);
      qryContaFornecedor.Next;
    End;

    qryContaFornecedor.Close;
  Finally
    PosicionaContaFornecedor(ASequencial);

    qryContaFornecedor.Close;
    FreeAndNil(qryContaFornecedor);
  End;
end;

procedure TfrmGerDupSel.CBContaFornecedorChange(Sender: TObject);
begin
  inherited;
  If CBContaFornecedor.ItemIndex > -1 Then
    GravaDadosBancariosFornecedor(lstGravaBcoFor[CBContaFornecedor.ItemIndex]);

  CarregaDadosBancariosFornecedor(qryDuplic.FieldByName('CTP_CODFOR').AsString);
end;

function TfrmGerDupSel.fAtualizaNomeGuia(ACodigoGuia: String): string;
var
  qryTipoTributo: TUniQuery;
begin
  Result := '';

  If (ACodigoGuia.IsEmpty) Or
     (ACodigoGuia = '0') Then
    Exit;

  qryTipoTributo := fCriaQuery(Self);
  qryTipoTributo.Close;
  qryTipoTributo.SQL.Clear;
  qryTipoTributo.SQL.Add('SELECT GUI_DESCRI ');
  qryTipoTributo.SQL.Add('FROM GUITRI ');
  qryTipoTributo.SQL.Add('WHERE GUI_CODGUI = :CODGUI ');
  qryTipoTributo.ParamByName('CODGUI').AsString := ACodigoGuia;
  qryTipoTributo.Open;

  If qryTipoTributo.RecordCount > 0 Then
    Result := qryTipoTributo.FieldByName('GUI_DESCRI').AsString;
end;

procedure TfrmGerDupSel.pCarregaComboOcorrencias(strCodBco : String; stlValores : TStrings);
begin
  stlValores.Add('');
  If (Pos(strCodBco,'756_237_341_033_001_001D7_089_748-_') > 0) Then
  Begin
    stlValores.Add('02 - Solicitação de Baixa');
  End;
end;

procedure TfrmGerDupSel.pCarregaComboOcorrenciasAlteracoes(strCodBco: String;
  stlValores: TStrings);
begin
  stlValores.Add('');
  If (Pos(strCodBco,'237_341_033_001_001D7_089_748-_') > 0) Then
  Begin
    stlValores.Add('06 - Alteração de Vencimento');
    If (Pos(strCodBco,'237_') > 0) Then
    begin
      stlValores.Add('19 - Sustar Protesto');
      stlValores.Add('20 - Alteração de Valor');
    end;
    If (Pos(strCodBco,'001_001D7_') > 0) Then
    Begin
       stlValores.Add('12 - Alteração de nome e endereço do Pagador');
    End;
    If (Pos(strCodBco,'748-_') > 0) Then
    Begin
      stlValores.Add('04 - Concessão de abatimento');
      stlValores.Add('05 - Cancelamento do abatimento concedido');
      stlValores.Add('09 - Pedido de protesto');
      stlValores.Add('18 - Sustar protesto e baixar título');
      stlValores.Add('19 - Sustar Protesto');
      stlValores.Add('31 - Alteração de Outros Dados');
    end;
  End;
end;

procedure TfrmGerDupSel.pGravaOcorrencia(strTexto : String);
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryAtbRec: TUniQuery;
begin
  intRecNro := qryDuplic.RecNo;
  Try

    qryAtbRec := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_OCORRE = :OCORRE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

    With qryAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryDuplic.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := qryDuplic.FieldByName('CTR_CODCLI').AsString;
      ParamByName('OCORRE').AsString := strTexto;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryAtbRec);

    qryDuplic.Close;
    qryDuplic.Open;
    (qryDuplic.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    qryDuplic.RecNo := intRecNro;
  End;

end;

procedure TfrmGerDupSel.pPesquisaBanco(qryTabOri, qryTabela: TUniQuery; strCodBco: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADBCO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BCO_CODBCO = :CODBCO FOR UPDATE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := strCodBco;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

end.

