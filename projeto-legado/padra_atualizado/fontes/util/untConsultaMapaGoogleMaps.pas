unit untConsultaMapaGoogleMaps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untConsultaEndereco,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw, EditFocus, Vcl.Mask,
  MaskEditFocus, Navegador.Classes.TNavegador, Navegador.View.Help;

type
  TfrmConsultaMapaGoogleMaps = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    edtEndereco: TEditFocus;
    edtCidade: TEditFocus;
    edtEstado: TEditFocus;
    btnUtilizarEndereco: TBitBtnLocked;
    edtBairro: TEditFocus;
    lblEndereco: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblCep: TLabel;
    mskCep: TMaskEditFocus;
    pnlFundo: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnUtilizarEnderecoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }

    objConsulta: TConsultaEndereco;
    frmHelpNavegador: TfrmNavegadorViewHelp;
    objNavegador: TNavegador;
    procedure pCriaHelpNavegador;
    procedure pConsultaEndereco;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strEndere,
    strEndNum,
    strBairro,
    strNomCid,
    strEstado,
    strCodCid: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadCidades, untCadCid;

procedure TfrmConsultaMapaGoogleMaps.btnConfirmaClick(Sender: TObject);
begin
  if not fValidaCampos(edtCidade) then
    Exit;

  if not fValidaCampos(edtEstado) then
    Exit;

  if not fValidaCampos(mskCep) then
    Exit;

  ModalResult := mrOK;
end;

procedure TfrmConsultaMapaGoogleMaps.btnUtilizarEnderecoClick(Sender: TObject);
var
  EnderecoSelecionado: TEnderecoSelecionado;
begin
  inherited;
  EnderecoSelecionado := ObjConsulta.fGetEnderecoSelecionado;
  if Assigned(EnderecoSelecionado) then
  begin
    edtEndereco.Text := EnderecoSelecionado.Rua;
    edtBairro.Text := EnderecoSelecionado.Bairro;
    edtCidade.Text := EnderecoSelecionado.Cidade;
    edtEstado.Text := EnderecoSelecionado.Estado;
    mskCep.Text := fTiraCaracEspeciais(EnderecoSelecionado.Cep);
  end;
end;

procedure TfrmConsultaMapaGoogleMaps.FormActivate(Sender: TObject);
begin
  inherited;
  pConsultaEndereco;
end;

procedure TfrmConsultaMapaGoogleMaps.pCriaHelpNavegador;
begin
  pCriarFormularios(TfrmNavegadorViewHelp, frmHelpNavegador);
  frmHelpNavegador.Align := alClient;
  frmHelpNavegador.Dock(pnlFundo, pnlFundo.BoundsRect);
  frmHelpNavegador.Show;
end;

procedure TfrmConsultaMapaGoogleMaps.pConsultaEndereco;
begin
  If (Not objConsulta.fRetUrlConsultaEnderecoGoogleMaps(strEndere, strEndNum, strBairro, strNomCid, strEstado)) Then
  Begin
    fMensagem('ATENÇÃO!', ObjConsulta.MensagemRetorno, ['&Ok']);
    Exit;
  End;

  If (Not objNavegador.NavegadorAtivo) Then
  Begin
    pCriaHelpNavegador;
    Exit;
  End
  Else
    objNavegador.Navigate(objConsulta.UrlConsulta);
end;

procedure TfrmConsultaMapaGoogleMaps.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objConsulta);
  FreeAndNil(objNavegador);
  inherited;
end;

procedure TfrmConsultaMapaGoogleMaps.FormShow(Sender: TObject);
begin
  inherited;
  objConsulta := TConsultaEndereco.Create(Self);
  objNavegador := TNavegador.New;
  objNavegador.setParent(pnlFundo);
end;

function TfrmConsultaMapaGoogleMaps.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strEndere,
  strBairro,
  strNomCid,
  strEstado,
  LCodigoCorreio: String;
begin
    Result := True;
  try
    if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
    begin
      If (Sender = edtCidade) Then
      Begin
        If fEmptyStr(edtCidade.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Preencha o campo Cidade!', ['&Ok']);
        End;
      End

      Else If (Sender = edtEstado) Then
      Begin
        If fEmptyStr(edtEstado.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Preencha o campo Estado!', ['&Ok']);
        End;
      End

      Else If (Sender = mskCep) then
      begin
        strCodCid := EmptyStr;

        If fEmptyStr(mskCep.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Preencha o campo Cep!', ['&Ok']);
        End

        Else If fCfgSis('USACEP', varBoolean) Then
        Begin
          If (fCadCepDadosCep(mskCep.Text,
                              strCodCid,
                              strEndere,
                              strBairro,
                              strNomCid,
                              strEstado,
                              LCodigoCorreio,
                              '',
                              '',
                              False)) Then
          Begin
            If (fEmptyStr(strCodCid)) Then
            Begin
              Result := False;

              fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                    'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);

              pCriarForm(TfrmCadCidades);
            End;
          End;

        End;

        If (Result) Then
        Begin
          strCodCid := IIF(fEmptyStr(strCodCid), fCodCidPorCEP(mskCep.Text, edtEstado.Text), strCodCid);
          If fRemoveAcento(Trim(edtCidade.Text)) <> fRemoveAcento(fRetNomCidade(strCodCid)) Then
          Begin
            Result := False;

            pMensagemOk('A cidade informada('+edtCidade.Text+') não é a mesma encontrada no '+
                        'cadastro de cidades('+fRetNomCidade(strCodCid)+').'+#13#10+
                        'Por favor, faça a correção antes de continuar com a alteração do endereço de entrega!');
          End;
        End;

      end;

    end;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message,'[TfrmCadClientes.fValidaCampos]');
      Result := False;
    end;
  end;

  if (not Result) then
    pSetFocus(Sender);
end;

end.

