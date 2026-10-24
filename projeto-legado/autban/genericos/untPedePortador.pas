unit untPedePortador;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, Buttons, {Qt}  ExtCtrls, Uni,
  BitBtnLockedIncrem;

type
  TfrmPedePortador = class(TForm)
    Label1: TLabel;
    edtPortador: TEditFocus;
    pnlBotoes: TPanel;
    edtDesPortador: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPortadorExit(Sender: TObject);
    procedure edtPortadorKeyPress(Sender: TObject; var Key: Char);

    function fVerificaPortador: Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    qryCadPor   : TUniQuery;
    function CarregaPortador: Boolean;
    { Private declarations }
  public
    blnConfirma: Boolean;
    strCodPor  : String;
    blnVerificPortador : Boolean;
    { Public declarations }
  end;

var
  frmPedePortador: TfrmPedePortador;

implementation

uses  untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmPedePortador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
    VK_Escape: btnCancelar.Click;
  End;
end;

procedure TfrmPedePortador.FormShow(Sender: TObject);
begin
  pSetFocus(edtPortador);
end;

procedure TfrmPedePortador.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaPortador Then
  Begin
    blnConfirma := True;
    strCodPor   := edtPortador.Text;
    Close;
  End;
end;

procedure TfrmPedePortador.btnCancelarClick(Sender: TObject);
begin
  blnConfirma := False;
  Close;
end;

procedure TfrmPedePortador.edtPortadorExit(Sender: TObject);
begin
  If Not fEmptyStr(edtPortador.Text) Then
    edtDesPortador.Text := fRetNomPortador(fStrZero(edtPortador.Text,5))
  Else
    edtDesPortador.Text := '';
end;

procedure TfrmPedePortador.edtPortadorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin

    If fPesqPortador(conSimples,
                 Self,
                 edtPortador,
                 TEditFocus(edtDesPortador),
                 nil,
                 Key,
                 arrSel,
                 True,
                 'Consulta de Portadores',
                 '',
                 False,
                 False,
                 '',
                 False,
                 blnVerificPortador) then
    Begin
      Self.SelectNext((Sender As TWinControl), True, True);
    End;

  End;
end;

function TfrmPedePortador.fVerificaPortador: Boolean;
Begin
  Result := True;

  If fEmptyStr(edtPortador.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Portador, deve ser preenchido!', ['&O k']);
    Result := False;
  End;
  If (Result And blnVerificPortador) Then
  Begin
     If Not CarregaPortador Then
        Result := False;
  End;


  If (Result) And (Not fEmptyStr(edtPortador.Text)) Then
  Begin
    edtPortador.Text :=  fPadL( edtPortador.Text ,5,'0');
    edtPortadorExit(edtPortador);
    If fEmptyStr(edtDesPortador.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&O k']);
      Result := False;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(edtPortador.Text)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
  End;

  If Not Result Then
    pSetFocus(edtPortador);
End;

procedure TfrmPedePortador.FormCreate(Sender: TObject);
begin
    qryCadPor := fCriaQuery(Self); 
end;

function TfrmPedePortador.CarregaPortador: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  edtDesPortador.Text := 'TODOS';

  If fEmptyStr(edtPortador.Text) Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT POR_CODPOR, POR_NOMPOR, POR_PERAUT FROM CADPOR ' +
                          'WHERE POR_CODPOR="' + edtPortador.Text + '"';
    LConsulta.Open;

    edtDesPortador.Text := LConsulta.FieldByName('POR_NOMPOR').AsString;

    If Not LConsulta.FieldByName('POR_NOMPOR').AsString.IsEmpty Then
    Begin
      If LConsulta.FieldByName('POR_PERAUT').AsString = 'N' Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Esse portador não pode ser selecionado na geração de duplicatas no Autban!', ['&Ok']);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.

