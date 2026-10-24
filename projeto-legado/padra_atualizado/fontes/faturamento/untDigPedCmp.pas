unit untDigPedCmp;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, untFuncFatTypes,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigPedCmp = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    Label6: TLabel;
    pnlPedidos: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    edtNumCmp: TEditFocus;
    dbgItensPedCmp: TDBGridCitel;
    cdsPedCmp: TUniClientDataSet;
    dtsPedCmp: TDataSource;
    cdsPedCmpCMP_NUMCMP: TStringField;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    cdsPedCmpCMP_DTACMP: TDateField;
    lblDtaCmp: TLabel;
    mskDtaCmp: TMaskEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    function fExistePedido(strCodCli: String; strNumCmp: String): Boolean;
  protected
  public
    fatVenda : TFatVenda;
    npcNumCmp : TNumerosPedidoCompras;
    procedure pCarregarPedidosCompra;
  end;

var
  frmDigPedCmp: TfrmDigPedCmp;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmDigPedCmp.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDigPedCmp.btnConfirmaDadosClick(Sender: TObject);
  Var
    intCnt : Integer;
begin
  inherited;

  If cdsPedCmp.RecordCount > 0 Then
  Begin
    SetLength(npcNumCmp, cdsPedCmp.RecordCount);

    intCnt := 0;

    cdsPedCmp.First;
    While Not cdsPedCmp.Eof Do
    Begin
      npcNumCmp[intCnt].NumCmp := cdsPedCmpCMP_NUMCMP.Value;
      npcNumCmp[intCnt].DtaCmp := cdsPedCmpCMP_DTACMP.Value;

      Inc(intCnt);

      cdsPedCmp.Next;
    End;
  End
  Else
    npcNumCmp := Nil;
end;

procedure TfrmDigPedCmp.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNumCmp.Text) Then
  Begin
    fMensagem('', 'O Número do Pedido deve ser preenchido!', ['&Ok']);
    pSetFocus(edtNumCmp);
    Exit;
  End;

  If (cdsPedCmp.Locate('CMP_NUMCMP',edtNumCmp.Text,[])) Then
  Begin
    fMensagem('', 'Número de Pedido já adicionado!', ['&Ok']);
    pSetFocus(edtNumCmp);
    Exit;
  End;

  If fExistePedido(fatVenda.strCodCli, edtNumCmp.Text) Then
  Begin
    fMensagem('', 'Número do pedido de compra já existe para esse cliente!', ['&Ok']);
  End;

  if (mskDtaCmp.Visible) and (StrToDateDef(mskDtaCmp.Text, 0) = 0) then
  begin
    fMensagem('', 'A data do pedido deve ser preenchida!', ['&Ok']);
    pSetFocus(mskDtaCmp);
    Exit;
  end;

  cdsPedCmp.Append;
  cdsPedCmpCMP_NUMCMP.AsString := edtNumCmp.Text;

  if (mskDtaCmp.Visible) then
    cdsPedCmpCMP_DTACMP.AsDateTime := StrToDate(mskDtaCmp.Text);

  cdsPedCmp.Post;

  edtNumCmp.Clear;
  mskDtaCmp.Clear;
  pSetFocus(edtNumCmp);
end;

procedure TfrmDigPedCmp.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Deseja excluir o número de pedido "'+ String(cdsPedCmpCMP_NUMCMP.Value) + '" ?', ['&Sim', '&Não']) = 1 Then
    cdsPedCmp.Delete;
end;

function TfrmDigPedCmp.fExistePedido(strCodCli: String; strNumCmp: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);
  Result := false;
  Try
    qryTmp.SQL.Add(' SELECT *                    ');
    qryTmp.SQL.Add(' FROM                        ');
    qryTmp.SQL.Add('   NUMCMP                    ');
    qryTmp.SQL.Add(' WHERE CMP_CODCLI = :CODCLI  ');
    qryTmp.SQL.Add('   AND CMP_NUMCMP = :NUMCMP  '); 
    qryTmp.ParambyName('CODCLI').AsString := strCodCli;
    qryTmp.ParambyName('NUMCMP').AsString := strNumCmp; 
    qryTmp.Open;
    Result := (qryTmp.RecordCount > 0);
    qryTmp.Close; 
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmDigPedCmp.fExistePedido]');
    End; 
  End;

  FreeAndNiL(qryTmp); 
end;

procedure TfrmDigPedCmp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  cdsPedCmp.Close;
end;

procedure TfrmDigPedCmp.FormCreate(Sender: TObject);
begin
  inherited;

  if (not fCfgSis('SDTRPC', varBoolean)) then
  begin
    fFindColumnByName(dbgItensPedCmp, 'CMP_DTACMP').Visible := False;
    mskDtaCmp.Visible := False;
    Self.Width := 343;
  end;

  cdsPedCmp.CreateDataSet;
end;

procedure TfrmDigPedCmp.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarPedidosCompra;
end;

procedure TfrmDigPedCmp.pCarregarPedidosCompra;
  Var
    intCnt : Integer;
begin
  cdsPedCmp.EmptyDataSet;

  If fatVenda.npcNumCmp <> Nil Then
  Begin
    For intCnt := Low(fatVenda.npcNumCmp) To High(fatVenda.npcNumCmp) Do
    Begin
      cdsPedCmp.Append;
      cdsPedCmpCMP_NUMCMP.Value := fatVenda.npcNumCmp[intCnt].NumCmp;

      if (fatVenda.npcNumCmp[intCnt].DtaCmp <> 0) then
        cdsPedCmpCMP_DTACMP.Value := fatVenda.npcNumCmp[intCnt].DtaCmp;

      cdsPedCmp.Post;
    End;
  End;
end;

end.

