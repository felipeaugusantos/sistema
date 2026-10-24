unit untConfiguracoesCodigosRecolhimentoST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, StdCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem, EditFocus, ComboBoxFocus, Grids, DBGrids, DBGridCitel,
  Uni, Provider, DB, DBClient,
  MemDS, DBAccess, frxClass, frxExportCSVTestabilidade, Vcl.Menus, Vcl.Mask,
  MaskEditFocus;

type
  TfrmConfiguracoesCodigosRecolhimentoST = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgCodigos: TDBGridCitel;
    Label1: TLabel;
    cmbEstado: TComboBoxFocus;
    Label2: TLabel;
    edtCodigo: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dtsTbRcST: TDataSource;
    Label212: TLabel;
    edtDiaVen: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgCodigosDblClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgCodigosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryTbRcST: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesCodigosRecolhimentoST: TfrmConfiguracoesCodigosRecolhimentoST;

implementation

uses
  untFuncoes, untConstantes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfiguracoesCodigosRecolhimentoST.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryTbRcST);
end;

procedure TfrmConfiguracoesCodigosRecolhimentoST.FormCreate(
  Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  qryTbRcST := fCriaQuery;

  qryTbRcST.SQL.Clear;
  qryTbRcST.SQL.Add('SELECT * FROM TBRCST WHERE REC_CODEMP = :CODEMP');
  qryTbRcST.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTbRcST.Open;

  dtsTbRcST.DataSet := qryTbRcST;

  cmbEstado.Items.Add('');
  For intContador := Low(ESTADOS) To High(ESTADOS) Do
  Begin
    cmbEstado.Items.Add(String(AnsiString(ESTADOS[intContador])));
  End;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoST.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(cmbEstado.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Estado.', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(edtCodigo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário informar um código.' + #13#10 +
      'Consulte a contabilidade caso tenha dúvidas no preenchimento deste campo.', ['&Ok']);
    Exit;
  End;

  If Not fEmptyStr(Trim(edtDiaVen.Text)) Then
  Begin
    if (StrToIntDef(Trim(edtDiaVen.Text), 0) = 0) Or (StrToIntDef(Trim(edtDiaVen.Text), 0) > 31) Then
    Begin
      fMensagem('ATENÇÃO!', 'Favor informar um Vencimento válido (Entre 1 e 31).', ['&Ok']);
      Exit;
    End;
  End;

  If qryTbRcST.State <> dsEdit Then
  Begin
    If qryTbRcST.Locate('REC_ESTADO', cmbEstado.Text, []) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este Estado já está cadastrado.', ['&Ok']);
      Exit;
    End;

    qryTbRcST.Append;
  End;

  qryTbRcST.FieldByName('REC_CODEMP').AsString := VS_strCodEmp;
  qryTbRcST.FieldByName('REC_ESTADO').AsString := cmbEstado.Text;
  qryTbRcST.FieldByName('REC_CODIGO').AsString := edtCodigo.Text;
  If Not fEmptyStr(Trim(edtDiaVen.Text)) Then
    qryTbRcST.FieldByName('REC_DIAVEN').AsInteger := StrToInt(Trim(edtDiaVen.Text))
  Else
    qryTbRcST.FieldByName('REC_DIAVEN').Clear;

  fStartTransaction;
  Try
    qryTbRcST.Post;
    fCommit;
  finally
    fRollBack;
  end;

  btnCancelaItem.Click;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoST.dbgCodigosDblClick(
  Sender: TObject);
  Var
    intIndice: Integer;
begin
  inherited;
  If qryTbRcST.IsEmpty Then
    Exit;

  intIndice := cmbEstado.Items.IndexOf(qryTbRcST.FieldByName('REC_ESTADO').AsString);

  cmbEstado.ItemIndex := intIndice;
  edtCodigo.Text := qryTbRcST.FieldByName('REC_CODIGO').AsString;
  edtDiaVen.Text := qryTbRcST.FieldByName('REC_DIAVEN').AsString;

  qryTbRcST.Edit;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoST.btnCancelaItemClick(
  Sender: TObject);
begin
  inherited;
  If qryTbRcST.State In [dsInsert, dsEdit] Then
  Begin
    qryTbRcST.Cancel;
  End;

  cmbEstado.ItemIndex := 0;
  edtCodigo.Clear;
  edtDiaVen.Clear;

end;

procedure TfrmConfiguracoesCodigosRecolhimentoST.dbgCodigosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    dbgCodigosDblClick(Sender);
  End
  Else If Key = VK_DELETE Then
  Begin
    If fMensagem('ATENÇÃO!', 'Confirma exclusão do registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      qryTbRcST.Delete;
    End;
  End;
end;

end.
