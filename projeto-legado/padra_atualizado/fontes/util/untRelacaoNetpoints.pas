unit untRelacaoNetpoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  Uni, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  frxExportCSVTestabilidade, frxClass, Vcl.Mask,
  MaskEditFocus, MemDS, DBAccess, cxMemo,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelacaoNetpoints = class(TfrmPai)
    pnlFiltros: TPanel;
    cxDadosDBTableView: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    cxDadosDBTableViewDTAENT: TcxGridDBColumn;
    cxDadosDBTableViewCODOPE: TcxGridDBColumn;
    btnReenviar: TBitBtnLocked;
    cxDadosDBTableViewCODCLI: TcxGridDBColumn;
    cxDadosDBTableViewNOMCLI: TcxGridDBColumn;
    cxDadosDBTableViewCPFCLI: TcxGridDBColumn;
    cxDadosDBTableViewFONCLI: TcxGridDBColumn;
    cxDadosDBTableViewCODEMP: TcxGridDBColumn;
    cxDadosDBTableViewNPSCAL: TcxGridDBColumn;
    cxDadosDBTableViewOBSERV: TcxGridDBColumn;
    cmbStatus: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    btnRefresh: TBitBtnLocked;
    cxDadosDBTableViewSTATUS: TcxGridDBColumn;
    UniQuery1: TUniQuery;
    procedure FormCreate(Sender: TObject);
    procedure cxDadosDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnReenviarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryCadNps : TUniQuery;
    dtsCadNps : TDataSource;
    procedure pCarregarDados;
    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untNetpointsTypes, untNetpoints, System.StrUtils;

{$R *.dfm}

procedure TfrmRelacaoNetpoints.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadNps := fCriaQuery(Self);
  dtsCadNps := TDataSource.Create(Self);
  dtsCadNps.DataSet := qryCadNps;

  qryCadNps.AfterScroll := pAfterScroll;

  cxDadosDBTableView.DataController.DataSource := dtsCadNps;
end;

procedure TfrmRelacaoNetpoints.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadNps);
  FreeAndNil(dtsCadNps);
end;

procedure TfrmRelacaoNetpoints.FormShow(Sender: TObject);
  Var
    intCnt : Integer;
begin
  inherited;
  cmbStatus.Items.Clear;

  cmbStatus.Items.Add('TODOS');

  For intCnt := 0 To Ord(High(TTipoStatusNps)) Do
    cmbStatus.Items.Add(STATUS_NPS[TTipoStatusNps(intCnt)]);

  cmbStatus.ItemIndex := CODSTS_NPS[tsnPendenteDeAcumulo];

  pCarregarDados;
end;

function TfrmRelacaoNetpoints.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)));

      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear;
    End
    Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
              (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmRelacaoNetpoints.pAfterScroll(DataSet: TDataSet);
begin
  btnReenviar.Enabled := False;

  If (DataSet.Active) And (Not DataSet.IsEmpty) Then
  Begin
    btnReenviar.Enabled := (DataSet.FieldByName('CODSTS').AsInteger = CODSTS_NPS[tsnPendenteDeAcumulo]) Or
                           (DataSet.FieldByName('CODSTS').AsInteger = CODSTS_NPS[tsnPendenteDesfazimento]);
  End;
end;

procedure TfrmRelacaoNetpoints.pCarregarDados;
  Var
    strSQL : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT NPS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '        NPS_CODCLI AS CODCLI, ';
    strSQL := strSQL + '        CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '        NPS_DTAENT AS DTAENT, ';
    strSQL := strSQL + '        NPS_CODOPE AS CODOPE, ';
    strSQL := strSQL + '        NPS_CPFCLI AS CPFCLI, ';
    strSQL := strSQL + '        NPS_FONCLI AS FONCLI, ';
    strSQL := strSQL + '        NPS_NPSCAL AS NPSCAL, ';
    strSQL := strSQL + '        NPS_STATUS AS STATUS, ';
    strSQL := strSQL + '        NPS_CODSTS AS CODSTS, ';
    strSQL := strSQL + '        NPS_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '        NPS_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '        NPS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '        NPS_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '        "CADNPS"   AS TABELA, ';
    strSQL := strSQL + ' REPLACE(NPS_OBSERV, "\n", " ") AS OBSERV ';
    strSQL := strSQL + '   FROM CADNPS ';
    strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = NPS_CODCLI ';
    strSQL := strSQL + '  WHERE TRUE ';

    If (cmbStatus.ItemIndex > 0) Then
      strSQL := strSQL + '  AND NPS_CODSTS = ' + IntToStr(CODSTS_NPS[TTipoStatusNps(cmbStatus.ItemIndex-1)]);

    If (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
       (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))) Then
      strSQL := strSQL + ' AND NPS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  UNION ALL ' + AnsiReplaceStr(strSQL, 'CADNPS', 'DEL_CADNPS') ;

    With qryCadNps Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Params.FindParam('DTAINI') <> Nil) Then
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);

      If (Params.FindParam('DTAFIN') <> Nil) Then
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

      Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelacaoNetpoints.pCarregarDados]');
  End;
end;

procedure TfrmRelacaoNetpoints.btnReenviarClick(Sender: TObject);
begin
  inherited;

  If (Not btnReenviar.Enabled) Then
    Exit;

  If (Not qryCadNps.Active) Or
     (qryCadNps.IsEmpty) Then
    fMensagem('ATENÇÃO!', 'Selecione um documento para enviar!', ['&OK'])
  Else
  Begin
    If (qryCadNps.FieldByName('TABELA').AsString = 'CADNPS') Then
      TNetpoints.pTransmitirNetpoints(qryCadNps.FieldByName('NUMDOC').AsString,
                                      qryCadNps.FieldByName('ESPDOC').AsString,
                                      qryCadNps.FieldByName('CODEMP').AsString,
                                      qryCadNps.FieldByName('CODCLI').AsString,
                                      qryCadNps.FieldByName('SERIE_').AsString)
    Else
      TNetpoints.pTransmitirNetpointsCancelados(qryCadNps.FieldByName('NUMDOC').AsString,
                                                qryCadNps.FieldByName('ESPDOC').AsString,
                                                qryCadNps.FieldByName('CODEMP').AsString,
                                                qryCadNps.FieldByName('CODCLI').AsString,
                                                qryCadNps.FieldByName('SERIE_').AsString);

    btnRefresh.Click;
  End;
end;

procedure TfrmRelacaoNetpoints.btnRefreshClick(Sender: TObject);
begin
  inherited;
  pCarregarDados;
end;

procedure TfrmRelacaoNetpoints.cxDadosDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_F5    : btnRefresh.Click;
    VK_F6    : btnReenviar.Click;
  End;
end;

end.
