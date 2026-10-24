unit untConsultaLoteEmp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxGridCustomView, cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  UniClientDataSet, Uni, StrUtils, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaLoteEmp = class(TfrmPai)
    dtsConsula: TDataSource;
    cxgConsulta: TcxGrid;
    cxgConsultaView: TcxGridDBBandedTableView;
    cxgConsultaNomEmp: TcxGridDBBandedColumn;
    cxgConsultaFanEmp: TcxGridDBBandedColumn;
    cxgConsultaDesIte: TcxGridDBBandedColumn;
    cxgConsultaNumLot: TcxGridDBBandedColumn;
    cxgConsultaLotSal: TcxGridDBBandedColumn;
    cxgConsultaLevel1: TcxGridLevel;
    cxStyleRepository: TcxStyleRepository;
    cxsTitulo1: TcxStyle;
    shpLotBlo: TShape;
    lblLotBlo: TLabel;
    cxgConsultaLOT_STATUS: TcxGridDBBandedColumn;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgConsultaViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgConsultaViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cdsConsulta: TUniClientDataSet;
    FCodIte,
    FCodEmp,
    FLotAba: String;
    FUtiEmpAce: Boolean;
    FEmpCons: string;
    FEmpLoct: string;

    procedure pPreencheDadosConsulta;
    procedure pAfterOpen(DataSet: TDataSet);
  public
    { Public declarations }
    property strCodIte: String Read FCodIte Write FCodIte;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strLotAba: String Read FLotAba Write FLotAba;
    property blnUtiEmpAce: Boolean Read FUtiEmpAce write FUtiEmpAce;
    property strEmpCons: string read FEmpCons write FEmpCons;
    property strEmpLoct: string read FEmpLoct write FEmpLoct;
    
  end;

var
  frmConsultaLoteEmp: TfrmConsultaLoteEmp;

implementation

{$R *.dfm}

uses untFuncoesSimples, untIFatReservaSaldo, untTFatReservaSaldo,
  untIFatEntregaFutura, untTFatEntregaFutura;

{ TfrmConsultaLoteEmp }

procedure TfrmConsultaLoteEmp.cxgConsultaViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  If (Not cdsConsulta.IsEmpty) Then
  Begin
    strCodEmp := Copy(Sender.DataController.Values[ACellViewInfo.GridRecord.RecordIndex, cxgConsultaView.GetColumnByFieldName('NOMEMP').Index], 1, 3);

    If cdsConsulta.FindField('NUMLOT') <> Nil Then
      strLotAba := Sender.DataController.Values[ACellViewInfo.GridRecord.RecordIndex, cxgConsultaView.GetColumnByFieldName('NUMLOT').Index];

    Close;
  End;
end;

procedure TfrmConsultaLoteEmp.cxgConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not cdsConsulta.IsEmpty) then
  begin
    If AViewInfo.GridRecord.Values[cxgConsultaLOT_STATUS.Index] = 'B' then
      ACanvas.Brush.Color := shpLotBlo.Brush.Color
    else if (AViewInfo.GridRecord.RecordIndex Mod 2) = 0 Then
      ACanvas.Brush.Color := clMoneyGreen;
  end;

  If AViewInfo.Selected Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmConsultaLoteEmp.cxgConsultaViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (Not cdsConsulta.IsEmpty) And (Key = #13) Then
  Begin
    strCodEmp := Copy(cdsConsulta.FieldByName('NOMEMP').AsString, 1, 3);

    If cdsConsulta.FindField('NUMLOT') <> Nil Then
      strLotAba := cdsConsulta.FieldByName('NUMLOT').AsString;

    Close;
  End;
end;

procedure TfrmConsultaLoteEmp.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaLoteEmp.FormCreate(Sender: TObject);
begin
  inherited;
  shpLotBlo.Visible := fUsaRotinaWMS;
  lblLotBlo.Visible := fUsaRotinaWMS;
  blnUtiEmpAce := False;
  strEmpCons := EmptyStr;
  strEmpLoct := EmptyStr;
end;

procedure TfrmConsultaLoteEmp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    pEscapePressed;
end;

procedure TfrmConsultaLoteEmp.FormShow(Sender: TObject);
begin
  inherited;
  pPreencheDadosConsulta;
  cxgConsultaView.ViewData.Expand(True);

  If Not fEmptyStr(strEmpLoct) Then 
    cdsConsulta.Locate('CODEMP', strEmpLoct, []);
end;

procedure TfrmConsultaLoteEmp.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('LOTSAL') <> Nil Then
      TFloatField(FieldByName('LOTSAL')).DisplayFormat := '#,##0.000';
  End;
end;

procedure TfrmConsultaLoteEmp.pPreencheDadosConsulta;
  Var
    strSQL: String;
    qryLotEmp: TUniQuery;
    blnTemLote: Boolean;

    procedure pAtualizaSaldoLote;
      Var
        fltSaldoLote: Double;
    Begin
      With cdsConsulta Do
      Begin
        If Not IsEmpty Then
        Begin
          First;

          While Not Eof Do
          Begin
            fltSaldoLote := FieldByName('LOTSAL').AsFloat;

            If fUsaQtdPendenteEntregaFutura Then
              fltSaldoLote := fltSaldoLote + TEntregaFutura.New(
                                               TParamEF.New()
                                                 .CodIte(FieldByName('CODITE').AsString)
                                                 .CodEmp(FieldByName('CODEMP').AsString)
                                                 .Lote(FieldByName('NUMLOT').AsString)
                                                 .Faturamento(True)
                                               ).Total();

            fltSaldoLote := fltSaldoLote - TSaldoReservado.New(
                                             TReservaParametros.New()
                                               .EmpresaItem(FieldByName('CODEMP').AsString)
                                               .CodigoItem(FieldByName('CODITE').AsString)
                                               .CodEmpresa(FieldByName('CODEMP').AsString)
                                               .NumeroLote(FieldByName('NUMLOT').AsString)
                                             ).fGetQuantidade();

            Edit;
            FieldByName('LOTSAL').AsFloat := fltSaldoLote;
            Post;

            Next;
          End;
        End;
      End;
    End;
begin
  blnTemLote := frmConsultaLoteEmp.cxgConsultaView.Bands[1].Visible;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS NOMEMP, ';
  strSQL := strSQL + '   EMP_NOMFAN AS NOMFAN, ';

  If blnTemLote Then
  Begin
    strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '   CONCAT(ITE_CODITE, "-", ITE_DESITE) AS DESITE, ';
    strSQL := strSQL + '   LOT_NUMLOT AS NUMLOT, ';
    strSQL := strSQL + '   LOT_STATUS, ';
    strSQL := strSQL + '   LOT_SALDOS AS LOTSAL ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADLOT ';
    strSQL := strSQL + ' JOIN CADITE ON (CADITE.ITE_CODITE = CADLOT.LOT_CODITE) ';
    strSQL := strSQL + ' JOIN CADEMP ON (CADEMP.EMP_CODEMP = CADLOT.LOT_CODEMP) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   LOT_CODITE = :CODITE AND ';
    strSQL := strSQL + '   LOT_NUMLOT <> "A DEFINIR" ';

    If (fCfgSis('ABSPML', varBoolean)) And (Not fEmptyStr(strEmpCons)) Then
    Begin
      strSQL := strSQL + '   AND EMP_CODEMP = '+QuotedStr(strEmpCons)+' ';
    End
    Else
    If blnUtiEmpAce Then
    Begin
      strSQL := strSQL + '   AND LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

  End
  Else
  Begin
    cxgConsultaView.Bands[0].Width := 790;
    cxgConsultaNomEmp.GroupIndex   := -1;
    cxgConsultaView.OptionsView.Footer := False;

    strSQL := strSQL + '   (SELECT CONCAT(ITE_CODITE, "-", ITE_DESITE) FROM CADITE WHERE ITE_CODITE = :CODITE) AS DESITE ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE             ';

    If (fCfgSis('ABSPML', varBoolean)) And (Not fEmptyStr(strEmpCons)) Then
    Begin
      strSQL := strSQL + '  EMP_CODEMP = '+QuotedStr(strEmpCons)+' ';
    End
    Else
    Begin
      strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;
  End;

  Try
    qryLotEmp := fCriaQuery(Self);

    With qryLotEmp Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      If Not IsEmpty Then
      Begin
        cdsConsulta := fCriaClientDatset(qryLotEmp);
        cdsConsulta.AfterOpen := pAfterOpen;

        If blnTemLote Then
          pAtualizaSaldoLote;

        cdsConsulta.Close;
        cdsConsulta.Open;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmConsultaLoteEmp.pPreencheDadosConsulta]');
  End;

  FreeAndNil(qryLotEmp);
  dtsConsula.DataSet := cdsConsulta;
end;

end.
