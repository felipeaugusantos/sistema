unit untCadMovBancarioPortador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, untTypesSistema;

type
  TfrmCadMovBancarioPortador = class(TfrmPai)
    pnlFundo: TPanel;
    lblPortadorAtualDesc: TLabel;
    lblPortadorAtual: TLabel;
    lblNovoPortadorDesc: TLabel;
    edtCodigoPortador: TEditFocus;
    edtNomePortador: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoPortadorKeyPress(Sender: TObject; var Key: Char);
  private
    FPortadorAtual,
    FNovoPortador,
    FCodigoEmpresa: String;

    FPortadorSelecionado: TUniQuery;

    procedure CarregarPortador;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    property PortadorAtual: String read FPortadorAtual write FPortadorAtual;
    property NovoPortador: String read FNovoPortador;

    property CodigoEmpresa: String read FCodigoEmpresa write FCodigoEmpresa;
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples, untPesqAux, untConsultas;
{$R *.dfm}

procedure TfrmCadMovBancarioPortador.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  inherited;

  FNovoPortador := edtCodigoPortador.Text;
end;

procedure TfrmCadMovBancarioPortador.btnSairClick(Sender: TObject);
begin
  inherited;
  FNovoPortador := EmptyStr;
end;

procedure TfrmCadMovBancarioPortador.CarregarPortador;
begin
  pPesquisaCadPor(Nil, FPortadorSelecionado, edtCodigoPortador.Text);

  edtNomePortador.Clear;
  If Not FPortadorSelecionado.IsEmpty Then
    edtNomePortador.Text := FPortadorSelecionado.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmCadMovBancarioPortador.edtCodigoPortadorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LListaPortadores: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodigoPortador,
                     TEditFocus(edtNomePortador),
                     nil,
                     Key,
                     LListaPortadores,
                     True,
                     'Consulta de Portadores') then
      Self.SelectNext((Sender As TWinControl), True, True);
  End;
end;

procedure TfrmCadMovBancarioPortador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FPortadorSelecionado);
end;

procedure TfrmCadMovBancarioPortador.FormCreate(Sender: TObject);
begin
  inherited;
  FPortadorAtual := EmptyStr;
  FNovoPortador := EmptyStr;
  FCodigoEmpresa := VS_strCodEmp;

  FPortadorSelecionado := fCriarQuery('SELECT * FROM CADPOR WHERE POR_CODPOR=:CODPOR');
end;

procedure TfrmCadMovBancarioPortador.FormShow(Sender: TObject);
begin
  inherited;
  lblPortadorAtual.Caption := 'Nenhum';
  If Not FPortadorAtual.IsEmpty Then
    lblPortadorAtual.Caption := Concat(FPortadorAtual, '-',
                                       fRetNomPortador(FPortadorAtual));

  pSetFocus(edtCodigoPortador);
end;

function TfrmCadMovBancarioPortador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoPortador) Then
    Begin
      If fEmptyStr(edtCodigoPortador.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        CarregarPortador;
        If FPortadorSelecionado.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        Else If FPortadorAtual = edtCodigoPortador.Text then
        Begin
          fMensagem('ATENÇÃO!', 'O portador selecionado não pode ser igual ao portador atual!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(FPortadorSelecionado.FieldByName('POR_CODPOR').AsString, FCodigoEmpresa) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If (FPortadorSelecionado.FieldByName('POR_MOVBAN').AsString = 'N') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar Movimento Bancário!',['&O K']);
          Result := False;
        End

        Else If FPortadorSelecionado.FieldByName('POR_CODPOR').AsString = fCfgSis('PORRES') Then
        Begin
          fMensagem('ATENÇÃO', 'Este portador é o portador do resumo de caixa. Somente poderá ser utilizado na área ' +
                               'de contra-partida para transferência de valores para o caixa!', ['&O K']);
          Result := False;
        End

        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(FPortadorSelecionado.FieldByName('POR_CODPOR').AsString, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;

    If Not Result Then
      pSetFocus(Sender);
  End;
end;

end.
