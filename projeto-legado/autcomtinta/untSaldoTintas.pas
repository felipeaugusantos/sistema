unit untSaldoTintas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, UniClientDataSet, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  untTMatrizSaldosColorantes, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSaldoTintas = class(TfrmPai)
    dbgTintas: TcxGrid;
    cdsFormulas: TUniClientDataSet;
    dtsFormulas: TDataSource;
    dbgTintasDBTableView1: TcxGridDBTableView;
    dbgTintasLevel1: TcxGridLevel;
    dbgTintasDBTableView1COLORANTE: TcxGridDBColumn;
    dbgTintasDBTableView1QUANTIDADE: TcxGridDBColumn;
    dbgTintasDBTableView1QUANTACUMU: TcxGridDBColumn;
    dbgTintasDBTableView1SALDO: TcxGridDBColumn;
    dbgTintasDBTableView1GRUPO: TcxGridDBColumn;
    dbgTintasDBTableView1TIPO: TcxGridDBColumn;
    cdsSemSaldo: TUniClientDataSet;
    cdsSemSaldoIDTINTA: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure dbgTintasDBTableView1KeyPress(Sender: TObject;
      var Key: Char);
    procedure dbgTintasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    procedure pVerificaFormulacaoSemSaldos;
  public
    Formulas  : TClassMatrizSaldosColorantes;
    strDescrCompleta : String ;
    { Public declarations }
  end;

var
  frmSaldoTintas: TfrmSaldoTintas;

implementation

uses StrUtils, untFuncoesSimples;



{$R *.dfm}

procedure TfrmSaldoTintas.FormShow(Sender: TObject);
  Var
    intCont     : Integer;
    intLargura  : Integer;
    blnSemEst   : Boolean;
begin
  inherited;
  cdsFormulas.CreateDataSet;
  cdsFormulas.Open;

  pVerificaFormulacaoSemSaldos;


  For intCont := 0 To Formulas.Count - 1 Do
  Begin

    blnSemEst := false;

    If (Formulas[intCont].fltSaldoML <= 0) Or (Formulas[intCont].fltSaldoML < Formulas[intCont].fltQtdFormAcu) Then
    begin
      blnSemEst := true;
    end;

    if blnSemEst Then
    begin
      If (cdsSemSaldo.Locate('IDTINTA', Formulas[intCont].intIDTinta, [])) Then
      Begin
        cdsFormulas.Insert;

        if strDescrCompleta <> '' then
        begin
          cdsFormulas.FieldByName('ID').AsInteger   := IIF(Formulas[intCont].strBasCol = EMBALAGEM, (Formulas[intCont].intIDTinta - 1), Formulas[intCont].intIDTinta);

          if cdsFormulas.FieldByName('ID').AsInteger < 10 then
            cdsFormulas.FieldByName('GRUPO').AsString := '0' + IntToStr( IIF(Formulas[intCont].strBasCol = EMBALAGEM, (Formulas[intCont].intIDTinta -1),Formulas[intCont].intIDTinta )  ) + ') ' + strDescrCompleta
          else
            cdsFormulas.FieldByName('GRUPO').AsString := IntToStr( IIF(Formulas[intCont].strBasCol = EMBALAGEM, (Formulas[intCont].intIDTinta -1),Formulas[intCont].intIDTinta )  ) + ') ' + strDescrCompleta;
        end
        else
        begin
          cdsFormulas.FieldByName('ID').AsInteger   := Formulas[intCont].intIDTinta;

          if cdsFormulas.FieldByName('ID').AsInteger < 10 then
            cdsFormulas.FieldByName('GRUPO').AsString := '0' + IntToStr(Formulas[intCont].intIDTinta ) + ') '  + Formulas[intCont].strDescTinta
          else
            cdsFormulas.FieldByName('GRUPO').AsString := IntToStr(Formulas[intCont].intIDTinta ) + ') '  + Formulas[intCont].strDescTinta ;
        end;

        cdsFormulas.FieldByName('DESCRICAO').AsString := Formulas[intCont].strDesIte;
        cdsFormulas.FieldByName('COLORANTE').AsString := Formulas[intCont].strCodIte + ' - ' + Formulas[intCont].strDesIte;
        cdsFormulas.FieldByName('QUANTIDADE').AsFloat := Formulas[intCont].fltQtdFormula;
        cdsFormulas.FieldByName('QUANTACUMU').AsFloat := Formulas[intCont].fltQtdFormAcu;
        cdsFormulas.FieldByName('SALDO').AsFloat      := Formulas[intCont].fltSaldoML;
        cdsFormulas.FieldByName('TIPO').AsString      := IfThen(((Formulas[intCont].strBasCol = COLORANTE) Or (Formulas[intCont].strBasCol = CATALISADOR)), 'Colorante', IfThen(Formulas[intCont].strBasCol = EMBALAGEM, 'Embalagem', 'Base'));
        cdsFormulas.Post;
      End;
    End;
  End;

  TFloatField(cdsFormulas.FieldByName('QUANTIDADE')).DisplayFormat := '0.000';
  TFloatField(cdsFormulas.FieldByName('QUANTACUMU')).DisplayFormat := '0.000';
  TFloatField(cdsFormulas.FieldByName('SALDO')).DisplayFormat      := '0.000';

  dbgTintasDBTableView1.ViewData.Expand(True);
  pSetFocus(dbgTintas);
  dbgTintasDBTableView1.NavigatorButtons.First.Click;

  intLargura := 0;
  For intCont := 0 To dbgTintasDBTableView1.VisibleColumnCount - 1 Do
  Begin
    dbgTintasDBTableView1.VisibleColumns[intCont].ApplyBestFit();
    intLargura := intLargura + dbgTintasDBTableView1.VisibleColumns[intCont].Width;
  End;

  Self.ClientWidth := intLargura + 55;


end;

procedure TfrmSaldoTintas.pVerificaFormulacaoSemSaldos;
  Var
    intCont   : Integer;
    blnSemEst : Boolean;
begin
  cdsSemSaldo.CreateDataSet;
  cdsSemSaldo.Open;

  For intCont := 0 To Formulas.Count - 1 Do
  Begin
    blnSemEst := false;

    If (Formulas[intCont].fltSaldoML <= 0) Or (Formulas[intCont].fltSaldoML < Formulas[intCont].fltQtdFormAcu) Then
      blnSemEst := true;

    if (blnSemEst) Then
    Begin
      If (Not cdsSemSaldo.Locate('IDTINTA', Formulas[intCont].intIDTinta, [])) Then
      Begin
        cdsSemSaldo.Append;
        cdsSemSaldoIDTINTA.AsInteger := Formulas[intCont].intIDTinta;
        cdsSemSaldo.Post;
      End;
    End;

  End;
End;

procedure TfrmSaldoTintas.dbgTintasDBTableView1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    btnSair.Click;
end;

procedure TfrmSaldoTintas.dbgTintasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltSaldo: Double;
    fltQuantidade: Double;
begin
  inherited;

  fltSaldo := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgTintasDBTableView1SALDO.Index];
  fltQuantidade := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgTintasDBTableView1QUANTACUMU.Index];
  If (fltSaldo < fltQuantidade) and (fltQuantidade > 0) Then
  Begin
    ACanvas.Font.Color := clRed;
  End;

end;

end.

