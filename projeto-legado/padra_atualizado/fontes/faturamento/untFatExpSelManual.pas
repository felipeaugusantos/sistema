unit untFatExpSelManual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TProcMarcTodos = procedure (blnExpAut: Boolean = False; blnMarcaRegAtual : Boolean = False; fltQtdPar: Double = 0; blnVerificaNecessidadeDeExpedicaoDoProduto: Boolean = False) of object;

type
  TfrmFatExpSelManual = class(TfrmPai)
    pnlGeral: TPanel;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    cxGridCitelLevel1: TcxGridLevel;
    cxGridCitelTableView1: TcxGridDBTableViewCitel;
    cxGridCitel: TcxGridCitel;
    cxGridCitelTableView1CODITE: TcxGridDBColumn;
    cxGridCitelTableView1DESITE: TcxGridDBColumn;
    cxGridCitelTableView1UNIDAD: TcxGridDBColumn;
    cxGridCitelTableView1SALDOS: TcxGridDBColumn;
    cxGridCitelTableView1SALEST: TcxGridDBColumn;
    cxGridCitelTableView1QTDITE: TcxGridDBColumn;
    cxGridCitelTableView1QTDEXP: TcxGridDBColumn;
    dtsItens: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnDesTodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxGridCitelTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    intDecQtd : Integer;
    procedure pFormataCamposFloat;
    function fGetExpOri(strAutInc: String): Double;
  public
    { Public declarations }
    procMarcTodos : TProcMarcTodos;
    cdsItens : TUniClientDataSet;
    cdsClone : TUniClientDataSet;
    blnConfirma : Boolean;
    blnHouveModificacao : Boolean;
  end;

var
  frmFatExpSelManual: TfrmFatExpSelManual;

implementation

{$R *.dfm}

uses untFuncoesSimples, System.UITypes;

procedure TfrmFatExpSelManual.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmFatExpSelManual.btnDesTodClick(Sender: TObject);
begin
  inherited;
  If (blnHouveModificacao) Then
  Begin
    cdsItens.DisableControls;
    Try
      cdsItens.EmptyDataSet;
      cdsClone.First;
      While Not cdsClone.Eof Do
      Begin
        pCopiaRegistroDataSet(cdsClone, cdsItens);
        cdsClone.Next;
      End;
    Finally
      pFormataCamposFloat;
      cdsItens.EnableControls;
    End;
    blnHouveModificacao := False;
  End;
end;

procedure TfrmFatExpSelManual.btnMarTodClick(Sender: TObject);
begin
  inherited;
  If Assigned(procMarcTodos) Then
  Begin
    blnHouveModificacao := True;
    procMarcTodos(False, False);
  End;
end;

procedure TfrmFatExpSelManual.cxGridCitelTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltQtdIte : Double;
    fltQtdExp : Double;
begin
  inherited;
  If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
    Exit;

  fltQtdIte := IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridCitelTableView1QTDITE.Index], 0);
  fltQtdExp := IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridCitelTableView1QTDEXP.Index], 0);

  If (fFormataFloat(fltQtdIte, 2) = fFormataFloat(fltQtdExp, 2)) Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clBlack;

    ACanvas.Brush.Color := $0096CFA7;
  End
  Else
  Begin
    If (fFormataFloat(fltQtdIte, 2) > fFormataFloat(fltQtdExp, 2)) And
       (fFormataFloat(fltQtdExp, 2) <> 0) Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $00CCFFFF;
    end;
  End;
end;

function TfrmFatExpSelManual.fGetExpOri(strAutInc: String): Double;
begin
  Result := 0;
  If cdsClone.Locate('AUTOINCREM', strAutInc, []) Then
    Result := cdsClone.FieldByName('QTDEXP').AsFloat;
end;

procedure TfrmFatExpSelManual.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxGridCitel);
end;

procedure TfrmFatExpSelManual.FormCreate(Sender: TObject);
begin
  inherited;
  procMarcTodos := Nil;
  blnConfirma := False;
  blnHouveModificacao := False;
  intDecQtd := fCfgSis('DECQTD', varInteger);
end;

procedure TfrmFatExpSelManual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    fltQtdDig : Double;
begin
  fltQtdDig := 0;

  Case Key Of
    VK_F2 : If (Assigned(procMarcTodos)) And
               (fDigQuantidade('Informar Qtd.Exp.', 'Qtd.Exp.', fltQtdDig,
                               fGetExpOri(cdsItens.FieldByName('AUTOINCREM').AsString) + 1,
                               cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd)) And
               (fFormataFloat(fltQtdDig, intDecQtd) > 0) Then
            Begin
              blnHouveModificacao := True;

              If (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) > (fFormataFloat(fltQtdDig, intDecQtd)) Then
              Begin
                If cdsClone.Locate('AUTOINCREM', cdsItens.FieldByName('AUTOINCREM').AsString, []) Then
                  pCopiaRegistroDataSet(cdsClone, cdsItens, True);
              End;

              procMarcTodos(False, True, fltQtdDig);
            End;
    VK_F5 : If btnMarTod.Visible Then btnMarTod.Click;
    VK_F6 : If btnDesTod.Visible Then btnDesTod.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirmar.Click;
            End;
    VK_ESCAPE: Begin
                 If (fMensagem('', 'Deseja sair?', ['&Sim', '&Não']) = 1) Then
                   btnSair.Click
                 Else
                   Key := 0;
               End;
    VK_SPACE:  Begin
                 If Assigned(procMarcTodos) Then
                 Begin
                   blnHouveModificacao := True;
                   If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) =
                       fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) Then
                   Begin
                     If cdsClone.Locate('AUTOINCREM', cdsItens.FieldByName('AUTOINCREM').AsString, []) Then
                       pCopiaRegistroDataSet(cdsClone, cdsItens, True);
                   End
                   Else
                   Begin
                     procMarcTodos(False, True);
                   End;
                 End;
               End;
    Else
      inherited;
  End;
end;

procedure TfrmFatExpSelManual.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet := cdsItens;
  pFormataCamposFloat;
end;

procedure TfrmFatExpSelManual.pFormataCamposFloat;
begin
  TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(cdsItens.FieldByName('SALEST')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(cdsItens.FieldByName('QTDEXP')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(cdsItens.FieldByName('SALDOS')).DisplayFormat := fMskDigitos(intDecQtd);
end;

end.
