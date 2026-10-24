unit untCadConciliaAcumuloNetpoints;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.Mask, MaskEditFocus, Datasnap.Provider,
  UniDataSetProvider, Datasnap.DBClient, UniClientDataSet, EditFocus, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadConciliaAcumuloNetpoints = class(TfrmPai)
    pnlGrid: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1TableView1: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    dtsDados: TDataSource;
    btnConfirmar: TBitBtnLocked;
    btnDesmarcarRegistros: TBitBtnLocked;
    btnMarcarRegistros: TBitBtnLocked;
    pnlFiltro: TPanel;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnCarregar: TBitBtnLocked;
    Label1: TLabel;
    cxGridCitel1TableView1NPS_DTAARQ: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_NOMARQ: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_CNPMAT: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_CPFCLI: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_TIPTRA: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_CNPFIL: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_NUMDOC: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_PEDCMP: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_CODITE: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_DESITE: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_VALPRO: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_DTACMP: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_DTAPRO: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_QTDNPS: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_REGVAR: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_REGCAR: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_CODCON: TcxGridDBColumn;
    cxGridCitel1TableView1NPS_FATNPS: TcxGridDBColumn;
    cxGridCitel1TableView1MARCADO: TcxGridDBColumn;
    pnlTotais: TPanel;
    edtTotSel: TEditFocus;
    Label2: TLabel;
    procedure cxGridCitel1TableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxGridCitel1TableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridCitel1TableView1DblClick(Sender: TObject);
    procedure btnMarcarRegistrosClick(Sender: TObject);
    procedure btnDesmarcarRegistrosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryConNps : TUniQuery;
    dspConNps : TUniDataSetProvider;
    cdsConNps : TUniClientDataSet;
    procedure pCarregarDados;
    procedure pBaixaConNps(strAutIncS: String);
    function fGetDtaVencto: TDateTime;
    procedure pSelecionaRegistro;
    procedure pTodos(blnMarcar: Boolean);
    procedure pGetInfoSel(var intQtdSel: Integer; var fltTotSel: Double);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untCadPag, untFuncoesSimples, untFuncoes, DateUtils, System.UITypes;

procedure TfrmCadConciliaAcumuloNetpoints.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  pCarregarDados;
end;

procedure TfrmCadConciliaAcumuloNetpoints.btnConfirmarClick(Sender: TObject);
  Var
    dtaDtaVen : TDateTime;
    strAutIncS : String;
    intQtdSel: Integer;
    fltTotSel: Double;
    strNumDup: String;
begin
  inherited;

  If fEmptyStr(fCfgSis('FORNPS')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor Preencher o Fornecedor para gravação do contas a pagar da Comissão Netpoints, Configuração: "CFG_FORNPS"!', ['&OK']);
    Exit;
  End;

  If fEmptyStr(fCfgSis('DFXNPS')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor Preencher o Dia fixo para gerar contas a pagar da Comissão Netpoints, Configuração: "CFG_DFXNPS"!', ['&OK']);
    Exit;
  End;

  If fEmptyStr(fCfgSis('CTANPS')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor Preencher o Plano de Contas para gravação do contas a pagar da Comissão Netpoints, Configuração: "CFG_CTANPS"!', ['&OK']);
    Exit;
  End;

  pGetInfoSel(intQtdSel, fltTotSel);

  If (intQtdSel <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum registro selecionado!', ['&OK']);
    Exit;
  End;

  If (fFormataFloat(fltTotSel, 2) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'A soma dos selecionados deve ser um valor positivo!', ['&OK']);
    Exit;
  End;

  dtaDtaVen := fGetDtaVencto;

  If ffrmData(dtaDtaVen, 'Data Contas Pagar', 'Data Contas Pagar:') Then
  Begin
    fStartTransaction;
    Try
      strNumDup := fRetSequencialCadPag;

      If fGravaCadPag('TNetpointsInterfaceConciliacao', // Nome do Form - LogCtp
                      'INCLUSÃO DA COMISSÃO NETPOINTS', // Descrição LOGCTP
                      fCfgSis('FORNPS'), // strCodFor
                      strNumDup, // strNumDup
                      'A', // strParcel
                      VS_strCodEmp, // strCodEmp
                      fCfgSis('CTANPS'), // strCodCta
                      '', // strSerie
                      0, // intSeqBai
                      VS_Date, // dtaDtaCad
                      dtaDtaVen, // dtaDtaVen
                      fltTotSel, // fltValDup
                      fltTotSel, // fltValOri
                      'N', // strPrevis
                      'N', // strVeioBo
                      'N', // strDeposi
                      'INCLUSÃO DA COMISSÃO NETPOINTS', // strHist01
                      '', // strHist02
                      '', // strHisBai
                      '', // strPorBai
                      '', // strCtaBai
                      '', // strDocBai
                      '', // strOpeBai
                      0, // dtaDtaPag
                      0, // fltValPag
                      0, // fltValJur
                      0, // fltValDes
                      VS_strCodEmp, // strEmpGer
                      fCfgSis('EVENPS'), // strCodEve
                      'N', // strUsaChq
                      '', // strCodPor
                      '', // strNumDoc
                      0, // fltJurSuj
                      0, // fltDesSuj
                      0,  // intSeqCon
                      False,
                      0,
                      '',
                      0,
                      'N',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      'N',
                      '',
                      '',
                      '',
                      '',
                      '',
                      0,
                      0,
                      0,
                      0,
                      '',
                      0,
                      0,
                      '',
                      '',
                      '',
                      '',
                      '',
                      '0',
                      '',
                      '',
                      '',
                      '',
                      'N') Then
      Begin
        cdsConNps.DisableControls;

        Try
          cdsConNps.Filter := 'MARCADO = ' + QuotedStr('S');
          cdsConNps.Filtered := True;

          strAutIncS := '';

          cdsConNps.First;
          While Not cdsConNps.Eof Do
          Begin
            If fEmptyStr(strAutIncS) Then
              strAutIncS := QuotedStr(cdsConNps.FieldByName('AUTOINCREM').AsString)
            Else
              strAutIncS := strAutIncS + ', ' + QuotedStr(cdsConNps.FieldByName('AUTOINCREM').AsString);
            cdsConNps.Next;
          End;

          pBaixaConNps(strAutIncS);

          fCommit;
        Finally
          cdsConNps.Filter := '';
          cdsConNps.Filtered := False;
          cdsConNps.EnableControls;
        End;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadConciliaAcumuloNetpoints.btnConfirmarClick]');
      End;
    End;

    pCarregarDados;
  End;
end;

procedure TfrmCadConciliaAcumuloNetpoints.btnDesmarcarRegistrosClick(
  Sender: TObject);
begin
  inherited;
  pTodos(False);
end;

procedure TfrmCadConciliaAcumuloNetpoints.btnMarcarRegistrosClick(
  Sender: TObject);
begin
  inherited;
  pTodos(True);
end;

procedure TfrmCadConciliaAcumuloNetpoints.cxGridCitel1TableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsConNps Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('MARCADO') = Nil) Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridCitel1TableView1MARCADO.Index]) = 'S' Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End
  End;
end;

procedure TfrmCadConciliaAcumuloNetpoints.cxGridCitel1TableView1DblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaRegistro;
end;

procedure TfrmCadConciliaAcumuloNetpoints.cxGridCitel1TableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pSelecionaRegistro
  Else If (Key = VK_F8) Then
    btnMarcarRegistros.Click
  Else If (Key = VK_F9) Then
    btnDesmarcarRegistros.Click
  Else If (Key = VK_F10) Then
    btnConfirmar.Click;
end;

function TfrmCadConciliaAcumuloNetpoints.fGetDtaVencto: TDateTime;
  Var
    blnDataValida : Boolean;
    intIteracoes : Integer;
    dtaDtaHoje : TDateTime;
begin
  intIteracoes := 0;
  Result := 0;

  dtaDtaHoje := VS_Date;
  dtaDtaHoje := IncMonth(dtaDtaHoje, 1);

  Repeat
    intIteracoes := intIteracoes + 1;

    Try
      Result := EncodeDateTime(YearOf(dtaDtaHoje), MonthOf(dtaDtaHoje), fCfgSis('DFXNPS', varInteger), 0, 0, 0, 0);
      blnDataValida := fDataValida(Result);
    Except
      blnDataValida := False;
    End;

  Until blnDataValida Or (intIteracoes >= 5);

  If Not fDataValida(Result) Then
    Result := VS_Date;
end;

procedure TfrmCadConciliaAcumuloNetpoints.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmCadConciliaAcumuloNetpoints.FormCreate(Sender: TObject);
begin
  inherited;
  qryConNps := fCriaQuery(Self);

  cdsConNps := TUniClientDataSet.Create(Self);
  dspConNps := TUniDataSetProvider.Create(Self);

  dspConNps.DataSet := qryConNps;

  cdsConNps.SetProvider(dspConNps);

  dtsDados.DataSet := cdsConNps;
end;

procedure TfrmCadConciliaAcumuloNetpoints.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConNps);
  FreeAndNil(cdsConNps);
  FreeAndNil(dspConNps);
end;

function TfrmCadConciliaAcumuloNetpoints.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited  fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        mskDtaFin.Clear;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
        (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadConciliaAcumuloNetpoints.pBaixaConNps(strAutIncS: String);
  Var
    qryBaiCon : TUniQuery;
begin
  qryBaiCon := fCriaQuery(Self);
  Try
    With qryBaiCon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE CONNPS SET NPS_DTACON = :DTABAI WHERE AUTOINCREM IN (' + strAutIncS + ')');
      ParamByName('DTABAI').AsDateTime := VS_Date;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryBaiCon);
  End;
end;

procedure TfrmCadConciliaAcumuloNetpoints.pCarregarDados;

  procedure pFormataFloats(DataSet: TDataSet);
  begin
    With DataSet Do
    Begin
      (FieldByName('NPS_FATNPS') As TFloatField).DisplayFormat := '#,###0.00';
      (FieldByName('NPS_VALPRO') As TFloatField).DisplayFormat := '#,###0.00';
    End;
  end;

begin
  With qryConNps Do
  Begin
    cdsConNps.Close;

    Close;
    SQL.Clear;
    SQL.Add(' SELECT CONNPS.*, "N" AS MARCADO FROM CONNPS WHERE NPS_DTACON IS NULL ');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      SQL.Add(' AND NPS_DTAPRO BETWEEN :DTAINI AND :DTAFIN ');
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    Open;

    pFormataFloats(qryConNps);

    pSetaClient(qryConNps);

    cdsConNps.SetProvider(dspConNps);
    cdsConNps.Open;

    pFormataFloats(cdsConNps);

    First;

    edtTotSel.Text := FloatToStrF(0, ffFixed, 12, 2);
  End;
end;

procedure TfrmCadConciliaAcumuloNetpoints.pGetInfoSel(var intQtdSel: Integer;
  var fltTotSel: Double);
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsClone, cdsConNps);
    cdsClone.Filter := 'MARCADO = ' + QuotedStr('S');
    cdsClone.Filtered := True;

    intQtdSel := 0;
    fltTotSel := 0;

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin
      intQtdSel := intQtdSel + 1;
      fltTotSel := fltTotSel + cdsClone.FieldByName('NPS_FATNPS').AsFloat;
      cdsClone.Next;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadConciliaAcumuloNetpoints.pSelecionaRegistro;
  Var
    intQtdSel: Integer;
    fltTotSel: Double;
begin
  If (cdsConNps.IsEmpty) Or
     (Not cdsConNps.Active) Then
    Exit;

  cdsConNps.Edit;
  cdsConNps.FieldByName('MARCADO').AsString := IIF(cdsConNps.FieldByName('MARCADO').AsString = 'S', 'N', 'S');
  cdsConNps.Post;

  pGetInfoSel(intQtdSel, fltTotSel);
  edtTotSel.Text := FloatToStrF(fltTotSel, ffFixed, 12, 2);
end;

procedure TfrmCadConciliaAcumuloNetpoints.pTodos(blnMarcar: Boolean);
  Var
    intQtdSel: Integer;
    fltTotSel: Double;
begin
  If (Not cdsConNps.Active) Or (cdsConNps.IsEmpty) Then
    Exit;

  cdsConNps.DisableControls;
  Try
    cdsConNps.First;
    While Not cdsConNps.Eof Do
    Begin
      cdsConNps.Edit;
      cdsConNps.FieldByName('MARCADO').AsString := IIF(blnMarcar, 'S', 'N');
      cdsConNps.Post;

      cdsConNps.Next;
    End;

    intQtdSel := 0;
    fltTotSel := 0;

    If blnMarcar Then
      pGetInfoSel(intQtdSel, fltTotSel);

    edtTotSel.Text := FloatToStrF(fltTotSel, ffFixed, 12, 2);
  Finally
    cdsConNps.EnableControls;
  End;
end;

end.
