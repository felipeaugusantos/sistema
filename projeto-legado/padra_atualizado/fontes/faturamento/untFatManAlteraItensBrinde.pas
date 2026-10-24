unit untFatManAlteraItensBrinde;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.StdCtrls, EditFocus, QColorLabel, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, System.UITypes, strUtils;

type
  TfrmFatManAlteraItensBrinde = class(TfrmPaiConfirma)
    dtsGrid: TDataSource;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    pnlBottom: TPanel;
    Panel1: TPanel;
    chkBrindePro: TCheckBox;
    pnlTipBriPrd: TPanel;
    lblTipBriPrd: TLabel;
    clbTipBriPrd: TColorLabel;
    edtTipBriPrd: TEditFocus;
    dbgGrid: TDBGridCitel;
    procedure dbgGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgGridDblClick(Sender: TObject);
    procedure dbgGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkBrindeProClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pMarcaDesmarca;
    procedure pDesmarcarTudo(aMarcar: Integer);
    procedure pFormataValores;
    procedure pFormataValoresServico;
    procedure pAlteraFormServico;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnBrinde,
    blnServic: Boolean;
    strCodPar,
    strTipBri: String;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untDigInfBrinde;

procedure TfrmFatManAlteraItensBrinde.btnConfirmaClick(Sender: TObject);
var
  blnMarcados: Boolean;
begin
  inherited;

  dtsGrid.DataSet.DisableControls;

  try
    Self.modalResult := mrNone;
    blnMarcados := dtsGrid.DataSet.Locate('MARDES', '1', []);

    if not blnMarcados then
    begin
      pMensagemOk('Selecione um produto para alteração.');
      Exit;
    end;

    if (not fVerificaCampos) then
      Exit;

    blnBrinde := chkBrindePro.Checked;

    if chkBrindePro.Checked then
    begin
      if not fPedeDadosBrinde(chkBrindePro.Checked, strCodPar, strTipBri) then
        Exit;

      if (pnlTipBriPrd.Visible) then
        strTipBri := edtTipBriPrd.Text;
    end;

    Self.ModalResult := mrOk
  finally
    dtsGrid.DataSet.EnableControls;
  end;
end;

procedure TfrmFatManAlteraItensBrinde.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  pDesmarcarTudo(0);
end;

procedure TfrmFatManAlteraItensBrinde.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pDesmarcarTudo(1);
end;

procedure TfrmFatManAlteraItensBrinde.chkBrindeProClick(Sender: TObject);
begin
  inherited;

  if (chkBrindePro.Checked) and (not fCfgSis('USAPAR', varBoolean)) then
    pnlTipBriPrd.Visible := True
  else
    pnlTipBriPrd.Visible := False;
end;

procedure TfrmFatManAlteraItensBrinde.dbgGridDblClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmFatManAlteraItensBrinde.dbgGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  if (dbgGrid.DataSource.DataSet.FieldByName('MARDES').AsString = '1') then
  begin
    if dbgGrid.Canvas.Brush.Color = clHighLight then
      dbgGrid.Canvas.Font.Color := clHighLightText
    else
      dbgGrid.Canvas.Brush.Color := clAqua;

    dbgGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

  if (Column.FieldName = 'BRINDE') then
  begin
    dbgGrid.Canvas.Font.Color  := clBlack;

    if (Column.Field.AsString = 'S') then
    begin
      dbgGrid.Canvas.Brush.Color := clYellow;
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'SIM');
    end
    else
    begin
      dbgGrid.Canvas.Brush.Color := clWhite;
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NAO');
    end;
  end;

  if (Column.FieldName = 'TIPBRI') then
  begin
    dbgGrid.Canvas.Font.Color  := clBlack;
    dbgGrid.Canvas.FillRect(Rect);

    case AnsiIndexStr(Column.Field.AsString, ['G', 'C', 'R', 'M']) of
      0: dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Garantia');
      1: dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Cortesia');
      2: dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Revisão');
      3: dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Montagem');
    end;
  end;
end;

procedure TfrmFatManAlteraItensBrinde.dbgGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
    pMarcaDesmarca;
end;

procedure TfrmFatManAlteraItensBrinde.FormCreate(Sender: TObject);
begin
  inherited;
  blnBrinde := False;
  blnServic := False;
  strCodPar := '';
  strTipBri := '';
end;

procedure TfrmFatManAlteraItensBrinde.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F5:
      btnMarcar.Click;
    VK_F6:
      btnDesmarcar.CLick;
    VK_F10:
      btnConfirma.Click;
    VK_ESCAPE:
      btnSair.Click;
  end;
end;

procedure TfrmFatManAlteraItensBrinde.FormShow(Sender: TObject);
begin
  inherited;

  if (not blnServic) then
    pFormataValores
  else
  begin
    pAlteraFormServico;
    pFormataValoresServico;
  end;

  dbgGrid.DataSource := dtsGrid;
end;

function TfrmFatManAlteraItensBrinde.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtTipBriPrd) and pnlTipBriPrd.Visible then
  begin
    if (edtTipBriPrd.Text <> 'G') and (edtTipBriPrd.Text <> 'C') then
    begin
      fMensagem('','O Tipo de Brinde deve ser G ou C!', ['&Ok']);
      Result := False;
    end;
  end;
end;

procedure TfrmFatManAlteraItensBrinde.pDesmarcarTudo(aMarcar: Integer);
begin
  dtsGrid.DataSet.First;

  while not dtsGrid.DataSet.Eof do
  begin
    dtsGrid.DataSet.Edit;
    dtsGrid.DataSet.FieldByName('MARDES').AsInteger := aMarcar;
    dtsGrid.DataSet.Post;

    dtsGrid.DataSet.Next;
  end;

  dtsGrid.DataSet.First;
end;

procedure TfrmFatManAlteraItensBrinde.pFormataValores;
begin
  (dtsGrid.DataSet.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (dtsGrid.DataSet.FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  (dtsGrid.DataSet.FieldByName('UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (dtsGrid.DataSet.FieldByName('UNITAR') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

  (dtsGrid.DataSet.FieldByName('TOTITE') As TFloatField).DisplayFormat := fMskDigitos(2);
  (dtsGrid.DataSet.FieldByName('TOTITE') As TFloatField).EditFormat    := fMskDigitos(2);
end;

procedure TfrmFatManAlteraItensBrinde.pFormataValoresServico;
begin
  (dtsGrid.DataSet.FieldByName('QTDSER') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (dtsGrid.DataSet.FieldByName('QTDSER') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  (dtsGrid.DataSet.FieldByName('VALUNI') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (dtsGrid.DataSet.FieldByName('VALUNI') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

  (dtsGrid.DataSet.FieldByName('VALSER') As TFloatField).DisplayFormat := fMskDigitos(2);
  (dtsGrid.DataSet.FieldByName('VALSER') As TFloatField).EditFormat    := fMskDigitos(2);
end;

procedure TfrmFatManAlteraItensBrinde.pMarcaDesmarca;
begin
  dtsGrid.DataSet.Edit;

  if (dtsGrid.DataSet.FieldByName('MARDES').AsInteger = 0) then
    dtsGrid.DataSet.FieldByName('MARDES').AsInteger := 1
  else
    dtsGrid.DataSet.FieldByName('MARDES').AsInteger := 0;

  dtsGrid.DataSet.Post;
end;

procedure TfrmFatManAlteraItensBrinde.pAlteraFormServico;
begin
  Self.Caption := 'Alteração de serviços para brinde';
  pnlBottom.Caption := '[ENTER] ou Duplo Clique -  Marca / Desmarca Serviço';

  fFindColumnByName(dbgGrid, 'CODITE').FieldName := 'CODSER';
  fFindColumnByName(dbgGrid, 'DESITE').FieldName := 'DESSER';
  fFindColumnByName(dbgGrid, 'QTDITE').FieldName := 'QTDSER';
  fFindColumnByName(dbgGrid, 'UNITAR').FieldName := 'VALUNI';
  fFindColumnByName(dbgGrid, 'TOTITE').FieldName := 'VALSER';
  fFindColumnByName(dbgGrid, 'DESMAR').Visible := False;
  fFindColumnByName(dbgGrid, 'ENTRET').Visible := False;
  fFindColumnByName(dbgGrid, 'REFERE').Visible := False;
  fFindColumnByName(dbgGrid, 'UNIDAD').Visible := False;

  fFindColumnByName(dbgGrid, 'CODSER').Title.Caption := 'Cód. Serv.';
  fFindColumnByName(dbgGrid, 'DESSER').Width := 350;
end;

end.
