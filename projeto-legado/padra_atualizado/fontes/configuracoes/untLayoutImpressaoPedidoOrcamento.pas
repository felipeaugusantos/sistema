unit untLayoutImpressaoPedidoOrcamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, EditFocus, Datasnap.Provider, UniDataSetProvider,
  Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni;

type
  TfrmLayoutImpressaoPedidoOrcamento = class(TfrmPaiSimples)
    Panel1: TPanel;
    lblCodigo: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodLay: TEditFocus;
    btnInserir: TBitBtnLocked;
    edtDescri: TEditFocus;
    memWhere: TMemo;
    grdLayImp: TDBGridCitel;
    cdsLayImp: TUniClientDataSet;
    dspLayImp: TUniDataSetProvider;
    dtsLayImp: TDataSource;
    UniQuery1: TUniQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure grdLayImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure memWhereKeyPress(Sender: TObject; var Key: Char);
    procedure memWhereEnter(Sender: TObject);
    procedure grdLayImpDblClick(Sender: TObject);
    procedure edtCodLayExit(Sender: TObject);
  private
    { Private declarations }
    qryLayImp: TUniQuery;

    procedure pInsereLayoutImp;
    procedure pAlteraLayoutImp;
    procedure pCarregaLayoutImp;
    procedure pDeletaLayoutImp(strAutInc: string);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untPai, untTypesSistema, untMemo;


{$R *.dfm}

procedure TfrmLayoutImpressaoPedidoOrcamento.btnInserirClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    if (Not fEmptyStr(edtDescri.Text)) then
    begin
      if (grdLayImp.Enabled) then
      begin
        cdsLayImp.Append;
        cdsLayImp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('IMPDOR', VS_strCodEmp);
        cdsLayImp.FieldByName('DOR_CODEMP').AsString := VS_strCodEmp;
        cdsLayImp.FieldByName('DOR_CODLAY').AsString := edtCodLay.Text;
        cdsLayImp.FieldByName('DOR_DESCRI').AsString := edtDescri.Text;
        cdsLayImp.FieldByName('DOR_WHERE_').AsString := memWhere.Text;
        cdsLayImp.Post;

        pInsereLayoutImp;

        edtCodLay.Clear;
        edtDescri.Clear;
        memWhere.Clear;

        pSetFocus(edtDescri);
      end
      else
      begin
        cdsLayImp.Edit;
        cdsLayImp.FieldByName('DOR_CODLAY').AsString := edtCodLay.Text;
        cdsLayImp.FieldByName('DOR_DESCRI').AsString := edtDescri.Text;
        cdsLayImp.FieldByName('DOR_WHERE_').AsString := memWhere.Text;
        cdsLayImp.Post;

        pAlteraLayoutImp;

        grdLayImp.Enabled := True;
        edtCodLay.Clear;
        edtDescri.Clear;
        memWhere.Clear;

        pSetFocus(edtDescri);
      end;
    end;
  End;

end;

procedure TfrmLayoutImpressaoPedidoOrcamento.edtCodLayExit(Sender: TObject);
begin
  inherited;
  edtCodLay.Text := fStrZero(edtCodLay.Text, 6);
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescri);
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryLayImp);
  inherited;

end;

procedure TfrmLayoutImpressaoPedidoOrcamento.FormShow(Sender: TObject);
begin
  inherited;
  qryLayImp := fCriaQuery(Self);
  dspLayImp.DataSet := qryLayImp;
  cdsLayImp.SetProvider(dspLayImp);
  dtsLayImp.DataSet := cdsLayImp;

  pCarregaLayoutImp;
end;

function TfrmLayoutImpressaoPedidoOrcamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtDescri) Then
  Begin
    If (fEmptyStr(edtDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A descrição deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodLay) Then
  Begin
    If (fEmptyStr(edtCodLay.Text)) Then
    Begin
      fMensagem('ATENÇÃO','O código do layout deve ser preenchido !', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = memWhere) Then
  Begin
    If (fEmptyStr(memWhere.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A condição where do sql deve deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.grdLayImpDblClick(Sender: TObject);
Var
  Key: Word;
begin
  inherited;
  Key := VK_RETURN;
  grdLayImpKeyDown(Sender, Key, []);
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.grdLayImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strAutInc: string;
begin
  inherited;

  strAutInc := EmptyStr;

  If (Key = VK_DELETE) Then
  Begin
    if (Not cdsLayImp.IsEmpty) then
    begin
      If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Layout de impressão "' +
        cdsLayImp.FieldByName('DOR_DESCRI').AsString + '" ?', ['&Sim','&Não'], 2) = 1) Then
      Begin
        strAutInc := cdsLayImp.FieldByName('AUTOINCREM').AsString;

        cdsLayImp.Delete;

        pDeletaLayoutImp(strAutInc);
      End;
    end;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    if (Not cdsLayImp.IsEmpty) then
    begin
      edtCodLay.Text    := cdsLayImp.FieldByName('DOR_CODLAY').AsString;
      edtDescri.Text    := cdsLayImp.FieldByName('DOR_DESCRI').AsString;
      memWhere.Text     := cdsLayImp.FieldByName('DOR_WHERE_').AsString;
      grdLayImp.Enabled := False;
      grdLayImp.Repaint;
      pSetFocus(edtDescri);
    end;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtCodLay.Clear;
    edtDescri.Clear;
    memWhere.Clear;

    pSetFocus(edtDescri);
  End;
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.memWhereEnter(Sender: TObject);
begin
  inherited;
  memWhere.SelectAll;
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.memWhereKeyPress(Sender: TObject;
  var Key: Char);
Var
  strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
  If (Key = #13) Then
  Begin
    If memWhere.SelText = memWhere.Text Then
    Begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;
procedure TfrmLayoutImpressaoPedidoOrcamento.pAlteraLayoutImp;
var
  qryAltera: TUniQuery;
begin
  qryAltera := fCriaQuery;

  try
    qryAltera.Close;
    qryAltera.SQL.Clear;
    qryAltera.SQL.Add('UPDATE IMPDOR');
    qryAltera.SQL.Add('SET DOR_CODLAY = :CODLAY,');
    qryAltera.SQL.Add('DOR_DESCRI = :DESCRI,');
    qryAltera.SQL.Add('DOR_WHERE_ = :WHERE_');
    qryAltera.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryAltera.ParamByName('CODLAY').AsString := cdsLayImp.FieldByName('DOR_CODLAY').AsString;
    qryAltera.ParamByName('DESCRI').AsString := cdsLayImp.FieldByName('DOR_DESCRI').AsString;
    qryAltera.ParamByName('WHERE_').AsString := cdsLayImp.FieldByName('DOR_WHERE_').AsString;
    qryAltera.ParamByName('AUTINC').AsString := cdsLayImp.FieldByName('AUTOINCREM').AsString;

    qryAltera.ExecSQL;
  finally
    FreeAndNil(qryAltera);
  end;
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.pCarregaLayoutImp;
begin
  qryLayImp.Close;
  qryLayImp.SQL.Clear;
  qryLayImp.SQL.Add('SELECT * FROM IMPDOR');
  qryLayImp.SQL.Add('WHERE DOR_CODEMP = :CODEMP');
  qryLayImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryLayImp.Open;

  pSetaClient(qryLayImp);

  cdsLayImp.Close;
  cdsLayImp.Open;
  pSetaClient(cdsLayImp);
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.pDeletaLayoutImp(
  strAutInc: string);
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;

  try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM IMPDOR');
    qryDelete.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryDelete.ParamByName('AUTINC').AsString := strAutInc;
    qryDelete.ExecSQL;
  finally
    FreeAndNil(qryDelete);
  end;
end;

procedure TfrmLayoutImpressaoPedidoOrcamento.pEscapePressed;
begin
  If Not grdLayImp.Enabled Then
  Begin
    grdLayImp.Enabled := True;
    edtCodLay.Clear;
    edtDescri.Clear;
    memWhere.Clear;
    pSetFocus(edtDescri);
  End
  Else
    inherited;

end;

procedure TfrmLayoutImpressaoPedidoOrcamento.pInsereLayoutImp;
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery;

  try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO IMPDOR(AUTOINCREM, DOR_CODEMP, DOR_CODLAY, DOR_DESCRI, DOR_WHERE_)');
    qryInsert.SQL.Add('VALUES(:AUTINC, :CODEMP, :CODLAY, :DESCRI, :WHERE_)');

    qryInsert.ParamByName('AUTINC').AsString := cdsLayImp.FieldByName('AUTOINCREM').AsString;
    qryInsert.ParamByName('CODEMP').AsString := cdsLayImp.FieldByName('DOR_CODEMP').AsString;
    qryInsert.ParamByName('CODLAY').AsString := cdsLayImp.FieldByName('DOR_CODLAY').AsString;
    qryInsert.ParamByName('DESCRI').AsString := cdsLayImp.FieldByName('DOR_DESCRI').AsString;
    qryInsert.ParamByName('WHERE_').AsString := cdsLayImp.FieldByName('DOR_WHERE_').AsString;

    qryInsert.ExecSQL;
  finally
    FreeAndNil(qryInsert);
  end;
end;

end.
