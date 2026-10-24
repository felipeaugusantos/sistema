unit untAltPrecoGlobalMargemNeg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCurrencyEdit, untFuncoesSimples, DBClient, Grids, DBGrids, Uni, UniClientDataSet, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit;

type
  TfrmAltPrecoGlobalMargemNeg = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxvItensView: TcxGridDBTableView;
    cxlGrid1Level1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensMARBR1: TcxGridDBColumn;
    cxgItensPREVE1: TcxGridDBColumn;
    cxgItensMARBR2: TcxGridDBColumn;
    cxgItensPREVE2: TcxGridDBColumn;
    cxgItensMARBR3: TcxGridDBColumn;
    cxgItensPREVE3: TcxGridDBColumn;
    cxgItensMARBR4: TcxGridDBColumn;
    cxgItensPREVE4: TcxGridDBColumn;
    cxgItensMARBR5: TcxGridDBColumn;
    cxgItensPREVE5: TcxGridDBColumn;
    cxgItensMARBR6: TcxGridDBColumn;
    cxgItensPREVE6: TcxGridDBColumn;
    cxgItensMARBR7: TcxGridDBColumn;
    cxgItensPREVE7: TcxGridDBColumn;
    cxgItensMARLQ1: TcxGridDBColumn;
    cxgItensMARLQ2: TcxGridDBColumn;
    cxgItensMARLQ3: TcxGridDBColumn;
    cxgItensMARLQ4: TcxGridDBColumn;
    cxgItensMARLQ5: TcxGridDBColumn;
    cxgItensMARLQ6: TcxGridDBColumn;
    cxgItensMARLQ7: TcxGridDBColumn;
    cxs1: TcxStyleRepository;
    cxs2: TcxStyle;
    dtsMarNeg: TDataSource;
    cxvItensViewColumn1: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvItensViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    Procedure pEscondeTabelasNaoUsadas;
  public
    { Public declarations }
    cdsIteGlo: TUniClientDataSet;
    strFilter: String;
  end;

var
  frmAltPrecoGlobalMargemNeg: TfrmAltPrecoGlobalMargemNeg;

implementation

{$R *.dfm}

Procedure TfrmAltPrecoGlobalMargemNeg.pEscondeTabelasNaoUsadas;
  Var
    intContador: Integer;
Begin
  For intContador := 1 To 7 Do
    if VS_strTabPrc[intContador] <> 'S' Then
    With cxvItensView Do
    Begin
      Columns[intContador * 3 - 1].Visible := False;
      Columns[intContador * 3 + 0].Visible := False;
      Columns[intContador * 3 + 1].Visible := False;
    End;
End;

procedure TfrmAltPrecoGlobalMargemNeg.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If cdsIteGlo.State = dsEdit Then
    cdsIteGlo.Post;

end;

procedure TfrmAltPrecoGlobalMargemNeg.cxvItensViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If cdsIteGlo.State = dsEdit Then
                 cdsIteGlo.Post;
  End;
end;

procedure TfrmAltPrecoGlobalMargemNeg.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    strCodIte: String;
begin
  inherited;

  With cdsIteGlo Do
  Begin
    Try

      If ModalResult = mrOk Then
      Begin
        DisableControls;
        Filter   := strFilter;
        Filtered := True;
        First;
        strCodIte := FieldByName('ITE_CODITE').AsString;

        If Not IsEmpty Then
        Begin
          pMensagemOk('Há item(s) com Margem Líquida Negativa!');
          Action := caNone;
        End;

        Filter := 'MARNEG = 1';
        Filtered := True;
        Locate('ITE_CODITE', strCodIte, []);
      End;

    Except
      On E: Exception Do
      Begin
        Action := caNone;
        pMensagensErro(E.Message, '[TfrmAltPrecoGlobalMargemNeg.FormClose]');
      End;
    End;

    EnableControls;
  End;
end;

procedure TfrmAltPrecoGlobalMargemNeg.FormShow(Sender: TObject);
begin
  inherited;

  dtsMarNeg.DataSet := cdsIteGlo;

  cxvItensView.DataController.DataSource := dtsMarNeg;

  pEscondeTabelasNaoUsadas;
end;

end.


