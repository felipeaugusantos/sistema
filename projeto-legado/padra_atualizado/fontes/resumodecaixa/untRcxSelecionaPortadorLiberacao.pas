unit untRcxSelecionaPortadorLiberacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni;

type
  TfrmRcxSelecionaPortadorLiberacao = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblPortador: TLabel;
    edtCodigoPortador: TEditFocus;
    edtNomePortador: TEditFocus;
    lblDescricao: TLabel;
    lblValor: TLabel;
    lblModalidade: TLabel;
    lblModalidadeDescricao: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodigoPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    FConsultaPortador: TUniQuery;

    FModalidade,
    FEmpresaLancamento: String;

    FValor: Double;
    { Private declarations }
  public
    property Modalidade: String read FModalidade write FModalidade;
    property Valor: Double read FValor write FValor;
    property EmpresaLancamento: String read FEmpresaLancamento write FEmpresaLancamento;

    procedure CarregaPortador;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRcxSelecionaPortadorLiberacao: TfrmRcxSelecionaPortadorLiberacao;

implementation
Uses untTypesSistema, untConsultas, untPesqAux, untFuncoesSimples;
{$R *.dfm}

procedure TfrmRcxSelecionaPortadorLiberacao.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  inherited;
  Self.Close;

  ModalResult := mrOk;
end;

procedure TfrmRcxSelecionaPortadorLiberacao.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmRcxSelecionaPortadorLiberacao.CarregaPortador;
begin
  pPesquisaCadPor(Nil, FConsultaPortador, edtCodigoPortador.Text);
  edtNomePortador.Text := FConsultaPortador.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmRcxSelecionaPortadorLiberacao.edtCodigoPortadorKeyPress(
  Sender: TObject; var Key: Char);
  Var
    LArraySelecao: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
    fPesqPortador(conSimples,
                  Self,
                  edtCodigoPortador,
                  edtNomePortador,
                  FConsultaPortador,
                  Key,
                  LArraySelecao);
end;

procedure TfrmRcxSelecionaPortadorLiberacao.FormCreate(Sender: TObject);
begin
  inherited;
  FConsultaPortador := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE');
end;

procedure TfrmRcxSelecionaPortadorLiberacao.FormShow(Sender: TObject);
begin
  inherited;
  lblModalidadeDescricao.Caption := FModalidade;
  lblValor.Caption := FormatFloat(',0.00', FValor);

  pSetFocus(edtCodigoPortador);
end;

function TfrmRcxSelecionaPortadorLiberacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
   Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodigoPortador) Then
    Begin
      If fEmptyStr(edtCodigoPortador.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        CarregaPortador;
        If FConsultaPortador.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodigoPortador.Text, FEmpresaLancamento) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          if fRetDataPortador(edtCodigoPortador.Text) > VS_Date then
          begin
            fMensagem('Atenção', 'Data de início do portador selecionado é superior a data do documento.' + #13 +
                                 ' Selecione um novo portador.',['&OK']);
            pSetFocus(Sender);
            Result := False;
            Exit;
          end
          Else If FConsultaPortador.FieldByName('POR_CODPOR').AsString = fCfgSis('PORRES') Then
          Begin
            fMensagem('Atenção', 'Esse portador não pode ser selecionado, pois é portador do Resumo de Caixa.',['&OK']);
            pSetFocus(Sender);
            Result := False;
            Exit;
          End;
        End;

      End;
    End;
  End;

  If Not Result Then
  begin
    pSetFocus(Sender);
    if Sender is TEditFocus then
      (Sender as TEditFocus).SelectAll;
  end;
end;

end.
