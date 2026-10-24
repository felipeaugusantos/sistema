unit untCadPorChqEmi;

interface

uses
  Classes, Controls, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, Menus, AppEvnts, DB, EditFocus, Grids, DBGridCitel, DBGrids, Uni, untPaiSimples,
  BitBtnLockedIncrem;

type
  TfrmCadPorChqEmi = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtDesPor: TEditFocus;
    Label2: TLabel;
    edtDesEmp: TEditFocus;
    Label3: TLabel;
    edtDesBco: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCodPor: TEditFocus;
    pnlConfirma: TPanel;
    edtCodEmp: TEditFocus;
    edtCodBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtNumCCo: TEditFocus;
    edtNumChq: TEditFocus;
    Label7: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodBcoExit(Sender: TObject);
  private
  protected
  public
    strCodPor : String;
  end;


implementation

uses SysUtils, Forms, untPai, untFuncoes, untFuncoesSimples, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadPorChqEmi.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadPorChqEmi.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodBco.Text) Then
  Begin
    fMensagem('', 'O Banco deve ser preenchido.', ['&OK']);
    pSetFocus(edtCodBco);
    Exit;
  End
  Else If fEmptyStr(edtDesBco.Text) Then
  Begin
    fMensagem('', 'O Banco informado é inválido.', ['&OK']);
    pSetFocus(edtCodBco);
    Exit;
  End;

  If fEmptyStr(edtNumAge.Text) Then
  Begin
    fMensagem('', 'O Numero da Agência deve ser preenchida.', ['&OK']);
    pSetFocus(edtNumAge);
    Exit;
  End;

  If fEmptyStr(edtNumCCO.Text) Then
  Begin
    fMensagem('', 'O Numero da Conta Corrente deve ser preenchida.', ['&OK']);
    pSetFocus(edtNumCCO);
    Exit;
  End;

  If fEmptyStr(edtNumChq.Text) Then
  Begin
    fMensagem('', 'O Numero do Cheque deve ser preenchido.', ['&OK']);
    pSetFocus(edtNumChq);
    Exit;
  End;

  If qryTabela.RecordCount = 0 Then
  Begin
    qryTabela.Insert;
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PORCHQ', edtCodEmp.Text);
    qryTabela.FieldByName('CHQ_CODEMP').AsString := edtCodEmp.Text;
    qryTabela.FieldByName('CHQ_CODPOR').AsString := edtCodPor.Text;
  End
  Else
  Begin
    qryTabela.Edit;
  End;

  qryTabela.FieldByName('CHQ_CODBCO').AsString := edtCodBco.Text;
  qryTabela.FieldByName('CHQ_NUMAGE').AsString := edtNumAge.Text;
  qryTabela.FieldByName('CHQ_NUMCCO').AsString := edtNumCCo.Text;
  qryTabela.FieldByName('CHQ_NUMCHQ').AsString := edtNumChq.Text;

  qryTabela.Post;

  Close;
end;

procedure TfrmCadPorChqEmi.edtCodBcoExit(Sender: TObject);
begin
  inherited;
  edtDesBco.Text := fRetNomeBco(edtCodBco.Text);
end;

procedure TfrmCadPorChqEmi.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  If fPesqBanco(Self, edtCodBco, edtDesBco, nil, Key, arrBancos) Then
  Begin
    If fValidaCampos(edtCodBco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPorChqEmi.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtCodPor.Text := strCodPor;
  edtDesPor.Text := fRetNomPortador(strCodPor);

  qryTabela     := fCriaQuery(Self);
  qryTabela.SQL.Add('SELECT * '+
                    '  FROM PORCHQ ' +
                    ' WHERE CHQ_CODPOR = ' + QuotedStr(strCodPor)+
                    '   AND CHQ_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryTabela.Open;

  edtCodBco.Text := qryTabela.FieldByName('CHQ_CODBCO').AsString;
  edtNumAge.Text := qryTabela.FieldByName('CHQ_NUMAGE').AsString;
  edtNumCCo.Text := qryTabela.FieldByName('CHQ_NUMCCO').AsString;
  edtNumChq.Text := qryTabela.FieldByName('CHQ_NUMCHQ').AsString;

  edtDesBco.Text := fRetNomeBco(edtCodBco.Text);

  inherited;
end;

end.
