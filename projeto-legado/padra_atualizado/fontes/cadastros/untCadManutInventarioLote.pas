unit untCadManutInventarioLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  untZClient, cxCheckBox, cxDropDownEdit, cxCurrencyEdit, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadManutInventarioLote = class(TfrmPaiConfirma)
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxvItens: TcxGridDBBandedTableViewCitel;
    cxvItensCODITE: TcxGridDBBandedColumn;
    cxvItensNUMLOT: TcxGridDBBandedColumn;
    cxvItensDESITE: TcxGridDBBandedColumn;
    shpAltera: TShape;
    Label1: TLabel;
    cxvItensSTATUS: TcxGridDBBandedColumn;
    cxvItensCODGRU: TcxGridDBBandedColumn;
    cxvItensCODABF: TcxGridDBBandedColumn;
    cxvItensPREMED: TcxGridDBBandedColumn;
    cxvItensREFERE: TcxGridDBBandedColumn;
    cxvItensSALDOS: TcxGridDBBandedColumn;
    cxvItensPRECOM: TcxGridDBBandedColumn;
    cxvItensPRECUS: TcxGridDBBandedColumn;
    cxvItensPREULT: TcxGridDBBandedColumn;
    cxvItensIMPULT: TcxGridDBBandedColumn;
    cxvItensSALBAL: TcxGridDBBandedColumn;
    btnAjustar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cxvItensSALDOSCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAjustarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    cdsTabLot: TZClient;

    Function fSQLLote: String;

    Function fCarregaDados(pgbStatus: TcxProgressBar): Boolean;

    Procedure pBeforePost(DataSet: TDataSet);

    Procedure pCarregaDados;

  public
    { Public declarations }

    strAnoTab,
    strNomTab: String;

    Class Function fCampoPreco: String;
  end;

var
  frmCadManutInventarioLote: TfrmCadManutInventarioLote;

implementation

{$R *.dfm}

Uses
  StrUtils, System.UITypes, untGravando,
  untFuncoesSimples, untCadManutInvFatorLote;

procedure TfrmCadManutInventarioLote.pBeforePost(DataSet: TDataSet);
Begin
  With DataSet Do
  Begin

    If FieldByName('STATUS').AsString = 'ATIVO' Then
      FieldByName('LOT_STATUS').AsString := 'S'

    Else If FieldByName('STATUS').AsString = 'INATIVO' Then
      FieldByName('STATUS').AsString := 'N'

    Else If FieldByName('STATUS').AsString = 'BLOQUEADO' Then
      FieldByName('LOT_STATUS').AsString := 'B';

  End;
End;

procedure TfrmCadManutInventarioLote.btnAjustarClick(Sender: TObject);
begin
  inherited;

  cdsTabLot.fSalva;

  Try
    pCriarFormularios(TfrmCadManutInvFatorLote, frmCadManutInvFatorLote);
    frmCadManutInvFatorLote.strNomTab := strNomTab;
    frmCadManutInvFatorLote.strPreInv := RightStr(fCampoPreco, 3);

    frmCadManutInvFatorLote.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadManutInventarioLote.btnAjustarClick]');
    End;
  End;
  pFreeAndNil(frmCadManutInvFatorLote);

  pCarregaDados;
end;

procedure TfrmCadManutInventarioLote.cxvItensSALDOSCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Font.Color :=  ShpAltera.Brush.Color;
end;

procedure TfrmCadManutInventarioLote.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsTabLot.fSalva;

  (*
  If ModalResult = mrOk Then
  Begin

    If cdsTabLot.fSalva Then
      pMensagemOk('Operação realizada com sucesso!')
    Else
      Action := caNone;

  End

  Else If cdsTabLot.ChangeCount > 0 Then
  Begin

    If Not fPergunta('Há alterações nos dados. Deseja sair sem salvá-las?') Then
    Begin
      Action := caNone;
    End;

  End;
  *)

end;

procedure TfrmCadManutInventarioLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F4    : btnAjustar.Click;
    VK_F10   : btnConfirma.Click;

    VK_RETURN: If cdsTabLot.State = dsEdit Then
                 cdsTabLot.fSalva;
  End;

end;

procedure TfrmCadManutInventarioLote.FormShow(Sender: TObject);
begin
  inherited;

  Caption := Caption + ' - ' + strAnoTab;

  cdsTabLot := TZClient.Create(Self, fSQLLote);

  cdsTabLot.BeforePost := pBeforePost;

  cdsTabLot.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  pCarregaDados;
end;

Class Function TfrmCadManutInventarioLote.fCampoPreco: String;
  Var
    strPreInv,
    strCamPre: String;
Begin
  Try
    strPreInv := fCfgSis('PREINV');

    If strPreInv =  'IMPULT' Then
      strCamPre := 'ITE_IMPULT'
//    Else If strPreInv =  'PRELIQ' Then
//       fldCampoPre := qrySalInv.FieldByName('ITE_PRELIQ')
    Else if Length(strPreInv) = 3 Then
      strCamPre := 'ITE_PRE' + strPreInv
//    Else
//      fldCampoPre := qrySalInv.FieldByName('ULTFED');
  Except
    strCamPre := 'ITE_PRECUS';
  End;

  If fEmptyStr(strCamPre) Then
    strCamPre := 'ITE_PRECUS';

  Result := strCamPre;
End;



Procedure TfrmCadManutInventarioLote.pCarregaDados;
Begin

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaDados;
    frmGravando.pgbStatus.Visible := False;
    frmGravando.lblGravando.Caption := 'Carregando informações, aguarde...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

End;

Function TfrmCadManutInventarioLote.fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
  Var
    strCamPre: String;
Begin
  strCamPre := fCampoPreco;

  Result := cdsTabLot.fAbreClient(True);

  cdsTabLot.pAlinhaCampoCentro('LOT_CODITE');
  cdsTabLot.pAlinhaCampoCentro('LOT_STATUS');
  cdsTabLot.pAlinhaCampoCentro('ITE_CODABF');
  cdsTabLot.pAlinhaCampoCentro('LOT_NUMLOT');

  cxvItens.DataController.DataSource := cdsTabLot.dtsSource;

  // deixar editar o campo preço
  If cxvItens.GetColumnByFieldName(strCamPre) <> Nil Then
  Begin
    cxvItens.GetColumnByFieldName(strCamPre).Options.Editing := True;
    cxvItens.GetColumnByFieldName(strCamPre).OnCustomDrawCell := cxvItensSALDOSCustomDrawCell;
  End;

  cxvItens.NavigatorButtons.First.Click;
End;

Function TfrmCadManutInventarioLote.fSQLLote: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '  CASE LOT_STATUS ';
  strSQL := strSQL + '    WHEN "S" THEN "ATIVO" ';
  strSQL := strSQL + '    WHEN "N" THEN "INATIVO" ';
  strSQL := strSQL + '    WHEN "B" THEN "BLOQUEADO" ';
  strSQL := strSQL + '  END AS STATUS, ';

  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  LOT_CODITE, ';
  strSQL := strSQL + '  LOT_NUMLOT, ';
  strSQL := strSQL + '  LOT_CODEMP, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  ITE_CODABF, ';
  strSQL := strSQL + '  ITE_CODUNI, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  ITE_REFERE, ';
  strSQL := strSQL + '  LOT_STATUS, ';

  strSQL := strSQL + '  ITE_PREMED, ';
  strSQL := strSQL + '  ITE_PREULT, ';
  strSQL := strSQL + '  ITE_IMPULT, ';
  strSQL := strSQL + '  ITE_PRECOM, ';
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  LOT_SALDOS, ';
  strSQL := strSQL + '  LOT_SALBAL  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomTab + ' L ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + ' L.LOT_CODEMP = :CODEMP ';

  Result := strSQL;
End;

end.


