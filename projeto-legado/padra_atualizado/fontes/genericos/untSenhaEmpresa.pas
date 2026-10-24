unit untSenhaEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni, BitBtnLockedIncrem, untTypesSistema,  frxClass, System.StrUtils,
  frxExportCSVTestabilidade, Data.DB;

type
  TfrmSenhaEmpresa = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtSenha: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadEmp: TUniQuery;
    procedure pCarregaEmpresa;
    function fSelecionarEmpresa: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untModulo;

{$R *.dfm}

procedure TfrmSenhaEmpresa.edtCodEmpKeyPress(Sender: TObject;var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If (fEntraCons(Key)) Then
  Begin
    edtCodEmp.Text := fSelecionarEmpresa;
    pCarregaEmpresa;
  End;

end;

function TfrmSenhaEmpresa.fSelecionarEmpresa: String;
  Var
    qryGen     : TUniQuery;
    arrOpcoes  : Array Of String;
Begin
  Result := '';
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP ORDER BY EMP_CODEMP');
    Open;

    If Not IsEmpty Then
    Begin
      SetLength(arrOpcoes, RecordCount);

      First;
      While Not Eof Do
      Begin
        arrOpcoes[Pred(recNo)] := FieldByName('EMP_CODEMP').AsString + ' - ' +
                                  FieldByName('EMP_NOMEMP').AsString;
        Next;
      End;

      Result := LeftStr(arrOpcoes[Pred(fGetMenu('Selecione a Empresa', arrOpcoes, 1, False, True))],3);
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;



function TfrmSenhaEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtSenha) Then
  Begin
    If fEmptyStr(edtSenha.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaEmpresa;
      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

procedure TfrmSenhaEmpresa.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmSenhaEmpresa.pCarregaEmpresa;
begin

  qryCadEmp.Close;
  qryCadEmp.ParamByName('CODEMP').AsString := edtCodEMp.Text;
  qryCadEmp.OPen;
  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;

end;

procedure TfrmSenhaEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.SQL.Add('SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');
end;

procedure TfrmSenhaEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenha);
end;

end.
