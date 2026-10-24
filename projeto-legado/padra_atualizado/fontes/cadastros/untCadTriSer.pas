unit untCadTriSer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Grids,
  DBGridCitel, DBGrids, untTriSer, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTriSer = class(TfrmPai)
    pnlTopo: TPanel;
    lbl6: TLabel;
    edtTriMun: TEditFocus;
    Label3: TLabel;
    edtCdLsSe: TEditFocus;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    Label1: TLabel;
    dbgDados: TDBGridCitel;
    Label2: TLabel;
    edtUfCid: TEditFocus;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDadosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDadosDblClick(Sender: TObject);
  private
    intCorZeb : Integer;
    procedure pLimpaEdits;
    procedure pCarregaDados;
    { Private declarations }
  public
    objTriSer : TTriSer;

  Protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean = True):Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadTriSer.pCarregaDados;
begin
  edtCodCid.Text := objTriSer.FieldByName('TSE_CODCID').AsString;
  edtNomCid.Text := objTriSer.FieldByName('CID_NOMCID').AsString;
  edtUfCid.Text  := objTriSer.FieldByName('CID_ESTADO').AsString;
  edtTriMun.Text := objTriSer.FieldByName('TSE_TRIMUN').AsString;
  edtCdLsSe.Text := objTriSer.FieldByName('TSE_CDLSSE').AsString;
  pSetFocus(edtCodCid);

end;

procedure TfrmCadTriSer.pLimpaEdits;
Begin
  edtCodCid.Clear;
  edtUfCid.Clear;
  edtTriMun.Clear;
  edtCdLsSe.Clear;
  pSetFocus(edtCodCid);
End;

procedure TfrmCadTriSer.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
  Begin
    objTriSer.pGravaRegistro(edtCodCid.Text, edtCdLsSe.Text, edtTriMun.Text);
    pLimpaEdits;
  End;

end;

procedure TfrmCadTriSer.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
end;

procedure TfrmCadTriSer.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmCadTriSer.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if dbgDados.DataSource.DataSet.Active And (dbgDados.DataSource.DataSet.RecordCount > 0) then
    if Odd(dbgDados.DataSource.DataSet.RecNo) then
    Begin
      dbgDados.Canvas.Brush.Color := intCorZeb;
      dbgDados.Canvas.FillRect(Rect);
      dbgDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

end;

procedure TfrmCadTriSer.dbgDadosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    objTriSer.Delete
  Else
  if (Key = VK_RETURN) and (objTriSer.Active) and (objTriSer.RecordCount > 0) then
    pCarregaDados;

end;

procedure TfrmCadTriSer.edtCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqCidade(Self, edtCodCid, edtNomCid, nil, Nil, Key, arrSel) then
  Begin
    if fValidaCampos(edtCodCid) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadTriSer.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCid);

end;

procedure TfrmCadTriSer.FormShow(Sender: TObject);
begin
  inherited;
  dbgDados.DataSource := objTriSer.dtsSource;
  intCorZeb := fCfgSis('CORZEB', varInteger);

end;

function TfrmCadTriSer.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  if Inherited fValidaCampos(Sender, blnBuscaPOrChave) then
  Begin
    if (Sender = edtCodCid) then
    Begin
      edtNomCid.Text := fRetNomCidade(edtCodCid.Text);
      edtUfCid.Text  := fRetNomCidade(edtCodCid.Text, 1);
      if fEmptyStr(edtNomCid.Text) then
      Begin
        Result := False;
        if fEmptyStr(edtCodCid.Text) then
          fMensagem('', 'Preencha o Código da Cidade', ['&OK'])
        Else
          fMensagem('', 'Código da Cidade não encontrado!', ['&OK'])
      End;

    End

    Else
    If (Sender = edtTriMun) then
    Begin
      if fEmptyStr(edtTriMun.Text) then
      Begin
        Result := False;
        fMensagem('', 'Digite o Código de Tributação no Município!', ['&OK']);
      End;
    End

    Else
    if (Sender = edtCdLsSe) then
    Begin
      if fEmptyStr(edtCdLsSe.Text) then
      Begin
        Result := False;
        fMensagem('', 'Digite o Código da lista LC 116/03:!', ['&OK']);
      End;
    End;


  End;

  if not Result then
    pSetFocus(Sender);

end;

end.
