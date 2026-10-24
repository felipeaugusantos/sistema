unit untConfiguracoesCodigosRecolhimentoDifal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Uni, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, BitBtnLockedIncrem, EditFocus, ComboBoxFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.Mask, MaskEditFocus;

type
  TfrmConfiguracoesCodigosRecolhimentoDifal = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmbEstado: TComboBoxFocus;
    edtCodigo: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dbgCodigos: TDBGridCitel;
    dtsTbRcST: TDataSource;
    Label212: TLabel;
    edtDiaVen: TMaskEditFocus;
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgCodigosDblClick(Sender: TObject);
    procedure dbgCodigosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaItemClick(Sender: TObject);
  private
    { Private declarations }
    qryRecDifal: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesCodigosRecolhimentoDifal: TfrmConfiguracoesCodigosRecolhimentoDifal;

implementation

uses untFuncoes, untConstantes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfiguracoesCodigosRecolhimentoDifal.btnAdicionarClick(Sender: TObject);
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

  If qryRecDifal.State <> dsEdit Then
  Begin
    If qryRecDifal.Locate('CRD_ESTADO', cmbEstado.Text, []) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este Estado já está cadastrado.', ['&Ok']);
      Exit;
    End;

    qryRecDifal.Append;
  End;

  qryRecDifal.FieldByName('CRD_CODEMP').AsString := VS_strCodEmp;
  qryRecDifal.FieldByName('CRD_ESTADO').AsString := cmbEstado.Text;
  qryRecDifal.FieldByName('CRD_CODIGO').AsString := edtCodigo.Text;
  If Not fEmptyStr(Trim(edtDiaVen.Text)) Then
    qryRecDifal.FieldByName('CRD_DIAVEN').AsInteger := StrToInt(Trim(edtDiaVen.Text))
  Else
    qryRecDifal.FieldByName('CRD_DIAVEN').Clear;

  fStartTransaction;
  Try
    qryRecDifal.Post;
    fCommit;
  finally
    fRollBack;
  end;

  btnCancelaItem.Click;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoDifal.btnCancelaItemClick(
  Sender: TObject);
begin
  inherited;
  If qryRecDifal.State In [dsInsert, dsEdit] Then
  Begin
    qryRecDifal.Cancel;
  End;

  cmbEstado.ItemIndex := 0;
  edtCodigo.Clear;
  edtDiaVen.Clear;

end;

procedure TfrmConfiguracoesCodigosRecolhimentoDifal.dbgCodigosDblClick(Sender: TObject);
  Var
    intIndice: Integer;
begin
  inherited;
  If qryRecDifal.IsEmpty Then
    Exit;

  intIndice := cmbEstado.Items.IndexOf(qryRecDifal.FieldByName('CRD_ESTADO').AsString);

  cmbEstado.ItemIndex := intIndice;
  edtCodigo.Text := qryRecDifal.FieldByName('CRD_CODIGO').AsString;
  edtDiaVen.Text := qryRecDifal.FieldByName('CRD_DIAVEN').AsString;

  qryRecDifal.Edit;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoDifal.dbgCodigosKeyDown(
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
      qryRecDifal.Delete;
    End;
  End;
end;

procedure TfrmConfiguracoesCodigosRecolhimentoDifal.FormCreate(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  qryRecDifal := fCriaQuery;

  qryRecDifal.SQL.Clear;
  qryRecDifal.SQL.Add('SELECT * FROM CRDFAL WHERE CRD_CODEMP = :CODEMP');
  qryRecDifal.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryRecDifal.Open;

  dtsTbRcST.DataSet := qryRecDifal;

  cmbEstado.Items.Add('');
  For intContador := Low(ESTADOS) To High(ESTADOS) Do
  Begin
    cmbEstado.Items.Add(String(AnsiString(ESTADOS[intContador])));
  End;
end;

end.
