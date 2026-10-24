unit untCadControleProducao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiConfirma, AppEvnts, Menus, StdCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, UniClientDataSet, UniDataSetProvider, MaskEditFocus, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  Provider, Mask, cxDataControllerConditionalFormattingRulesManagerDialog,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadControleProducao = class(TfrmPaiConfirma)
    dbgHorariosDBTableView1: TcxGridDBTableView;
    dbgHorariosLevel1: TcxGridLevel;
    dbgHorarios: TcxGrid;
    dtsHorarios: TDataSource;
    dspHorarios: TUniDataSetProvider;
    cdsHorarios: TUniClientDataSet;
    qryHorarios: TUniQuery;
    cdsHorariosPPR_CODEMP: TStringField;
    cdsHorariosPPR_HORPPR: TTimeField;
    cdsHorariosPPR_QTDPPR: TFloatField;
    dbgHorariosDBTableView1PPR_HORPPR: TcxGridDBColumn;
    dbgHorariosDBTableView1PPR_QTDPPR: TcxGridDBColumn;
    qryHorariosPPR_CODEMP: TStringField;
    qryHorariosPPR_HORPPR: TTimeField;
    qryHorariosPPR_QTDPPR: TFloatField;
    qryHorariosAUTOINCREM: TStringField;
    cdsHorariosAUTOINCREM: TStringField;
    dbgHorariosDBTableView1PPR_CODEMP: TcxGridDBColumn;
    dbgHorariosDBTableView1AUTOINCREM: TcxGridDBColumn;
    pnl1: TPanel;
    lblPreVis: TLabel;
    mskDtaPPR: TMaskEditFocus;
    dtfldHorariosPPR_DTAPPR: TDateField;
    dtfldHorariosPPR_DTAPPR1: TDateField;
    btnHeranca: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsHorariosBeforePost(DataSet: TDataSet);
    procedure cdsHorariosAfterPost(DataSet: TDataSet);
    procedure cdsHorariosAfterDelete(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure mskDtaPPREnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAbrirTabela;
    procedure pFecharTabela;
    procedure pIniciaProcesso;
    procedure pSalvar;
    procedure pCancelar;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;override;    
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untFuncoes;

{$R *.dfm}

procedure TfrmCadControleProducao.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  pSalvar;
end;

procedure TfrmCadControleProducao.btnHerancaClick(Sender: TObject);
  Var
    qryTemp: TUniQuery;
    dtaTemp: TDateTime;
begin
  inherited;
  If Not btnHeranca.Enabled Then
    Exit;

  If ffrmData(dtaTemp, '', 'Informe a data de Produção') Then
  Begin
    qryTemp := fCriaQuery;

    With qryTemp Do
    Begin
      Close;
      SQL := qryHorarios.SQL;
      ParamByName('DTAPPR').AsDate := dtaTemp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        While Not cdsHorarios.IsEmpty Do
          cdsHorarios.Delete;

        First;

        While Not Eof Do
        Begin
          cdsHorarios.Append;
          cdsHorarios.FieldByName('PPR_HORPPR').AsDateTime := FieldByName('PPR_HORPPR').AsDateTime;
          cdsHorarios.FieldByName('PPR_QTDPPR').AsFloat    := FieldByName('PPR_QTDPPR').AsFloat;
          cdsHorarios.Post;
          Next;
        End;

      End
      Else
        pMensagemOk('Não há registros na data informada!');
    End;

    FreeAndNil(qryTemp);
  End;

end;

procedure TfrmCadControleProducao.btnSairClick(Sender: TObject);
begin
  inherited;
  pCancelar;
end;

procedure TfrmCadControleProducao.cdsHorariosAfterDelete(DataSet: TDataSet);
begin
  cdsHorarios.ApplyUpdates(-1);
  inherited;
end;

procedure TfrmCadControleProducao.cdsHorariosAfterPost(DataSet: TDataSet);
begin
  cdsHorarios.ApplyUpdates(-1);
  inherited;
end;

procedure TfrmCadControleProducao.cdsHorariosBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert] then
  begin
    cdsHorarios.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CONPPR', VS_strCodEmp);
    cdsHorarios.FieldByName('PPR_CODEMP').AsString   := VS_strCodEmp;
    cdsHorarios.FieldByName('PPR_DTAPPR').AsDateTime := StrToDateDef(mskDtaPPR.Text, VS_Date);
  end;
  inherited;
end;

procedure TfrmCadControleProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pFecharTabela;
end;

procedure TfrmCadControleProducao.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaPPR.Text := DateToStr(VS_Date);
end;

procedure TfrmCadControleProducao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And (ActiveControl <> mskDtaPPR) Then
    pSetFocus(mskDtaPPR)
  Else
    inherited;
end;

procedure TfrmCadControleProducao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaPPR);
end;

function TfrmCadControleProducao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If Sender = mskDtaPPR Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaPPR.Text)) Then
      Begin
        pMensagemOk('Informe a data de produção!');
        Result := False;
      End
      Else If StrToDateDef(mskDtaPPR.Text, 0) = 0 Then
      Begin
        pMensagemOk('Informe uma data válida!');
        Result := False;
      End
      Else
      Begin
        blnMudarFoco := False;
        dbgHorarios.Enabled := True;
        btnHeranca.Enabled  := True;
        pAbrirTabela;
        pIniciaProcesso;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadControleProducao.mskDtaPPREnter(Sender: TObject);
begin
  inherited;
  pFecharTabela;
  dbgHorarios.Enabled := False;
  btnHeranca.Enabled  := False;
end;

procedure TfrmCadControleProducao.pAbrirTabela;
begin
  with qryHorarios do
  begin
    cdsHorarios.Close;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CONPPR WHERE PPR_DTAPPR = :DTAPPR AND PPR_CODEMP = :CODEMP');
    ParamByName('DTAPPR').AsDateTime := strToDateDef(mskDtaPPR.Text, VS_Date);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    cdsHorarios.Open;
  end;
end;

procedure TfrmCadControleProducao.pCancelar;
begin
  if dtsHorarios.State in [dsInsert,dsEdit] then
    cdsHorarios.Cancel;
end;

procedure TfrmCadControleProducao.pFecharTabela;
begin
  qryHorarios.Close;
  cdsHorarios.Close;
end;

procedure TfrmCadControleProducao.pIniciaProcesso;
begin
  pSetFocus(dbgHorarios);
  cdsHorarios.Append;
end;

procedure TfrmCadControleProducao.pSalvar;
begin
  if dtsHorarios.State in [dsInsert,dsEdit] then
    cdsHorarios.Post;
end;

end.
