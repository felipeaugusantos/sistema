unit ImportacaoDados.Controller.CadLocEqu;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  cadastro.Model.EquipamentoLocacao, cadastro.Model.AcessorioLocacao, Uni;

Type

 TValidacaoCadEquLocacao = class;
 TValidacaoEquAceLocacao = class;

 TCadEquLocacaoController = Class
 private
   FEquipLocacao: TEquipamentoLocacaoPrincipal;
   FValidacao: TValidacaoCadEquLocacao;
 public
   constructor Create;
   destructor Destroy;override;

   procedure pCarregarCadastro(const strCodEqu: String);

   property EquipamentoLocacao: TEquipamentoLocacaoPrincipal read FEquipLocacao write FEquipLocacao;
   property Validacao: TValidacaoCadEquLocacao read FValidacao write FValidacao;
 End;

 TValidacaoCadEquLocacao = class
 private
    FEquipLocacao: TEquipamentoLocacaoPrincipal;
    FMensagemRetorno: String;
    FBlnExecutar: Boolean;

    function fCodIteExiste(Const aConteudo: String): Boolean;
  public
    constructor Create(aEquipamento: TEquipamentoLocacaoPrincipal);
    destructor Destroy; override;

    function fValidarCodIte: Boolean;
    function fValidarRegrasDeNegocioContrato: Boolean;
    function fValidarValorLocacao: Boolean;
    function fExecutar(Const aExibirMensagem: Boolean = False): Boolean;

    property EquipamentoLocacao: TEquipamentoLocacaoPrincipal read FEquipLocacao write FEquipLocacao;
    property MensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;
  end;

 TEquAceLocacaoController = Class
 private
   FEquAceLocacao: TEquipamentoLocacaoAcessorio;
   FValidacao: TValidacaoEquAceLocacao;
 public
   constructor Create;
   destructor Destroy;override;

   procedure pCarregarCadastro(const strCodEqu, strCodAce: String);

   property AcessorioLocacao: TEquipamentoLocacaoAcessorio read FEquAceLocacao write FEquAceLocacao;
   property Validacao: TValidacaoEquAceLocacao read FValidacao write FValidacao;
 End;

 TValidacaoEquAceLocacao = class
 private
    FEquAceLocacao: TEquipamentoLocacaoAcessorio;
    FMensagemRetorno: String;
    FBlnExecutar: Boolean;

    function fCodIteExiste(Const aConteudo: String): Boolean;
  public
    constructor Create(aEquipamento: TEquipamentoLocacaoAcessorio);
    destructor Destroy; override;

    function fValidarCodIte: Boolean;
    function fValidarRegrasDeNegocioContrato: Boolean;
    function fExecutar(Const aExibirMensagem: Boolean = False): Boolean;

    property AcessorioLocacao: TEquipamentoLocacaoAcessorio read FEquAceLocacao write FEquAceLocacao;
    property MensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;
  end;

 Const
    cstValidacaoCodigoInexistente   = 'Código informado não está cadastrado na base de dados.';
    cstValidacaoRegistroDuplicadoDB = 'Código do Equipamento já está cadastrado no banco de dados. Deixe em branco para gerar uma nova numeração.';
    cstValidacaoRegistroDuplicadoArq= 'Código do Equipamento está duplicado no arquivo de importação.';
    cstValidacaoValorLocacaoZerado  = 'Não foi informado valor para locação (Por hora, diária ou mensal). Se nenhum valor for informado será necessário realizar o ajuste manual.';

implementation

uses
  untFuncoesSimples, untCadCid, untFuncoesGenerica, StrUtils;

{ TValidacaoCadEquLocacao }

constructor TValidacaoCadEquLocacao.Create(aEquipamento: TEquipamentoLocacaoPrincipal);
begin
  FEquipLocacao := aEquipamento;
  FBlnExecutar := True;

  inherited Create;
end;

destructor TValidacaoCadEquLocacao.Destroy;
begin
  inherited;
end;

function TValidacaoCadEquLocacao.fCodIteExiste(const aConteudo: String): Boolean;
begin
  Result := Not fEmptyStr( fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [aConteudo], False) );
end;

function TValidacaoCadEquLocacao.fExecutar(
  const aExibirMensagem: Boolean): Boolean;
begin
  Result := True;
  Try
    fValidarCodIte;
  Except
    Result := False;
  End;
end;

function TValidacaoCadEquLocacao.fValidarCodIte: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FEquipLocacao.CodigoItem) Then
    Exit;

  Result := fCodIteExiste(FEquipLocacao.CodigoItem);

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodigoInexistente
  Else
    Result := fValidarRegrasDeNegocioContrato;

end;

function TValidacaoCadEquLocacao.fValidarRegrasDeNegocioContrato: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  Result := FEquipLocacao.fValidaItemLocacao(FEquipLocacao.CodigoItem);

  If Not(Result) Then
    FMensagemRetorno := FEquipLocacao.Mensagem;

end;

function TValidacaoCadEquLocacao.fValidarValorLocacao: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  Result := (FEquipLocacao.ValorLocacao > 0) Or
            (FEquipLocacao.ValorLocacaoDiaria > 0) Or
            (FEquipLocacao.ValorLocacaoMensal > 0);

  If Not(Result) Then
    FMensagemRetorno := cstValidacaoValorLocacaoZerado;
end;

{ TCadEquLocacaoController }

constructor TCadEquLocacaoController.Create;
begin
  FEquipLocacao := TEquipamentoLocacaoPrincipal.Create;
  FValidacao := TValidacaoCadEquLocacao.Create(Nil);
  FValidacao.EquipamentoLocacao := FEquipLocacao;
end;

destructor TCadEquLocacaoController.Destroy;
begin
  inherited;

end;

procedure TCadEquLocacaoController.pCarregarCadastro(const strCodEqu: String);
Begin
  FEquipLocacao.pCarregaEquipamento('', strCodEqu);
End;

{ TEquAceLocacaoController }

constructor TEquAceLocacaoController.Create;
begin
  FEquAceLocacao := TEquipamentoLocacaoAcessorio.Create;
  FValidacao := TValidacaoEquAceLocacao.Create(Nil);
  FValidacao.AcessorioLocacao := FEquAceLocacao;
end;

destructor TEquAceLocacaoController.Destroy;
begin

  inherited;
end;

procedure TEquAceLocacaoController.pCarregarCadastro(const strCodEqu, strCodAce: String);
begin
  FEquAceLocacao.pCarregaEquipamento('', strCodAce);
end;

{ TValidacaoEquAceLocacao }

constructor TValidacaoEquAceLocacao.Create(
  aEquipamento: TEquipamentoLocacaoAcessorio);
begin
  FEquAceLocacao := aEquipamento;
  FBlnExecutar := True;

  inherited Create;
end;

destructor TValidacaoEquAceLocacao.Destroy;
begin

  inherited;
end;

function TValidacaoEquAceLocacao.fCodIteExiste(
  const aConteudo: String): Boolean;
begin
  Result := Not fEmptyStr( fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [aConteudo], False) );
end;

function TValidacaoEquAceLocacao.fExecutar(
  const aExibirMensagem: Boolean): Boolean;
begin
  Result := True;
  Try
    fValidarCodIte;
  Except
    Result := False;
  End;
end;

function TValidacaoEquAceLocacao.fValidarCodIte: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FEquAceLocacao.CodigoItem) Then
    Exit;

  Result := fCodIteExiste(FEquAceLocacao.CodigoItem);

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodigoInexistente
  Else
    Result := Self.fValidarRegrasDeNegocioContrato;
end;

function TValidacaoEquAceLocacao.fValidarRegrasDeNegocioContrato: Boolean;
begin
   Result := True;

  If Not FBlnExecutar Then
    Exit;

  Result := FEquAceLocacao.fValidaItemLocacao(FEquAceLocacao.CodigoItem);

  If Not(Result) Then
    FMensagemRetorno := FEquAceLocacao.Mensagem;
end;

end.
