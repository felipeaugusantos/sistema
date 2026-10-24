unit untInfCodOpeLcCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Data.DB, MemDS,
  DBAccess, Uni;

type
  TfrmInfCodOpeLcCaixa = class(TfrmPai)
    edtLogin: TEditFocus;
    edtNomOpe: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    btnGravar: TBitBtnLocked;
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function OperadorInativo(AOperador: String): Boolean;
    function OperadorSemPermissaoDeReceberTransferencia(AOperador: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    strCodOpe  : String;
  end;

var
  frmInfCodOpeLcCaixa: TfrmInfCodOpeLcCaixa;

implementation

uses untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmInfCodOpeLcCaixa.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    strCodOpe := edtLogin.Text;
    Close;
  End
  Else
    strCodOpe := EmptyStr;

end;

procedure TfrmInfCodOpeLcCaixa.edtLoginKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtLogin, edtNomOpe, nil, Key, arrOperador, True, True, False,
                   False, False, False, False, False, False, True) Then
  Begin
    fValidaCampos(edtLogin,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmInfCodOpeLcCaixa.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtLogin);
  strCodOpe   := '';

end;

function TfrmInfCodOpeLcCaixa.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtLogin) Then
    Begin

      If Not fEmptyStr(edtLogin.Text) Then
      Begin

        edtNomOpe.Text := fRetNomeOperador(edtLogin.Text);

        If fEmptyStr(edtNomOpe.Text) Then
        Begin
          Result := False;
          fMensagem('','Operador não encontrado.', ['&Ok']);
        End;

        if OperadorInativo(edtLogin.Text) then
        begin
          Result := False;
          fMensagem('ATENÇÃO', 'Não é permitido gerar transferência de valores para operadores inativos.', ['&OK']);
        end;

        if OperadorSemPermissaoDeReceberTransferencia(edtLogin.Text) then
        begin
          Result := False;
          fMensagem('ATENÇÃO', 'Operador sem permissão de receber transferência de valores.', ['&OK']);
        end;
      End
      Else
      Begin
        fMensagem('', 'O código do operador deve ser informado!', ['&Ok']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmInfCodOpeLcCaixa.OperadorInativo(AOperador: String): Boolean;
var
  qryOperador: TUniQuery;
begin
  qryOperador := fCriaQuery(nil);

  qryOperador.Close;
  qryOperador.SQL.Clear;
  qryOperador.SQL.Add('SELECT COUNT(*) AS QTD ');
  qryOperador.SQL.Add('FROM CADOPE ');
  qryOperador.SQL.Add('WHERE OPE_CODOPE = :OPERADOR AND ');
  qryOperador.SQL.Add('      OPE_STATUS = "I" ');
  qryOperador.ParamByName('OPERADOR').AsString := AOperador;
  qryOperador.Open;

  Result := qryOperador.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryOperador);
end;

function TfrmInfCodOpeLcCaixa.OperadorSemPermissaoDeReceberTransferencia(AOperador: String): Boolean;
var
  qryOperador: TUniQuery;
begin
  qryOperador := fCriaQuery(nil);

  qryOperador.Close;
  qryOperador.SQL.Clear;
  qryOperador.SQL.Add('SELECT COUNT(*) AS QTD ');
  qryOperador.SQL.Add('FROM CADOPE ');
  qryOperador.SQL.Add('WHERE OPE_CODOPE = :OPERADOR AND ');
  qryOperador.SQL.Add('      OPE_PERTRF = "N" ');
  qryOperador.ParamByName('OPERADOR').AsString := AOperador;
  qryOperador.Open;

  Result := qryOperador.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryOperador);
end;

end.
