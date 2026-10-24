unit ImportacaoDados.Controller.Prospecto;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  ImportacaoDados.Model.CadastroProspecto, Uni;

Type

 TValidacaoProspecto = class;

 TProspectoController = Class
 private
   FProspecto: IProspecto;
   FValidacao: TValidacaoProspecto;
 public
   constructor Create;
   destructor Destroy;override;

   procedure pExecutarVinculoCadCli(const strCodCli: String);
   procedure pCarregarProspecto(const strCodPro: String);
   procedure pAtualizarCategoriaCrm(const strCrmCatAtu: String);
   procedure pAtualizarStatusProspecto(const strTipStat: String);

   property Prospecto: IProspecto read FProspecto write FProspecto;
   property Validacao: TValidacaoProspecto read FValidacao write FValidacao;
 End;

 TValidacaoProspecto = class
 private
    FProspecto: IProspecto;
    FMensagemValidacaoCep: String;
    FAtualizarEndereco: Boolean;
    FCepAnt: String;
    FMensagemRetorno: String;
    FBlnExecutar: Boolean;

    procedure pSetarEndereco(const strCodCid, strEndere, strBairro, strNomCid, strEstado, strCorreio: String);
    function fAtualizarInformacoesCep(Const aExibirMensagem: Boolean): Boolean;
    function fProcessarMensagemCep(Const blnExibirMensagem: Boolean; aMensagem: String; blnConfirma: Boolean = False): Integer;
  public
    constructor Create(aProspecto: IProspecto);
    destructor Destroy; override;

    function fValidarCPFCNPJ: Boolean;
    function fValidarCidade: Boolean;
    function fValidarCep(Const aExibirMensagem: Boolean = False; aImportandoProspecto: Boolean = False): Boolean;
    function fValidarAtividade: Boolean;
    function fValidarVendedor: Boolean;
    function fValidarRedeLojas: Boolean;
    function fValidarCrmFre: Boolean;
    function fValidarCrmCat: Boolean;
    function fValidarCrmPor: Boolean;
    function fValidarCrmFai: Boolean;
    function fValidarInscricaoEstadual: Boolean;
    function fValidarDataNasc: Boolean;
    function fValidarCrmFor: Boolean;
    function fValidarClienteCadastrado: Boolean;
    function fValidarEndereco: Boolean;
    function fValidarTelefone: Boolean;
    function fValidarEmail01: Boolean;
    function fValidarEmailNfe: Boolean;
    function fValidarClienteVinculado: Boolean;
    function fValidarCodRep: Boolean;
    function fValidarCodReg: Boolean;

    function fRetornaCodigoCidade(Const aConteudo: String): String;
    function fRetornaCodigoAtividade(Const aConteudo: String): String;
    function fRetornaCodigoVendedor(Const aConteudo: String): String;
    function fRetornaCodigoRedeLoja(Const aConteudo: String): String;
    function fRetornaCodigoCrmFre(Const aConteudo: String): String;
    function fRetornaCodigoCrmCat(Const aConteudo: String): String;
    function fRetornaCodigoCrmPor(Const aConteudo: String): String;
    function fRetornaCodigoCrmFai(Const aConteudo: String): String;
    function fRetornaCodigoCrmFor(Const aConteudo: String): String;
    function fRetornaCodigoRepresentante(Const aConteudo: String): String;
    function fRetornaCodigoRegiao(Const aConteudo: String): String;

    function Executar(Const aExibirMensagem: Boolean = False): Boolean;
    function fVerificaPodeVincularCliente(Const aExibirMensagem: Boolean = False): Boolean;

    property AtualizarEndereco: Boolean read FAtualizarEndereco write FAtualizarEndereco;
    property MensagemValidacaoCep: String read FMensagemValidacaoCep write FMensagemValidacaoCep;
    property Prospecto: IProspecto read FProspecto write FProspecto;
    property MensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;
  end;

  Const

  cstValidacaoCPFCCGInvalido = 'CPF/CNPJ Inválido.';
  cstValidacaoRegistroDuplicadoArquivo = 'CPF/CNPJ duplicado no arquivo de importação.';
  cstValidacaoRegistroDuplicadoDB = 'Pospecto com CPF/CNPJ informado já consta na base de dados.';
  cstValidacaoRegistroClienteCadastrado = 'Cliente com CPF/CNPJ informado já consta na base de dados.';
  cstValidacaoCodigoInexistente = 'Código informado não está cadastrado na base de dados.';
  cstValidacaoCampoInexistente = 'Campo informado não está cadastrado na base de dados.';
  cstValidacaoEmail = 'Endereço de e-mail inválido.';
  cstValidacaoStatus = 'Situação inválida. Informe "I" para prospecto inativo ou "A" para prospecto ativo.';
  cstValidacaoTamanho = 'Texto excede o tamanho permitido para o campo.';
  cstValidacaoInscricaoEstadual = 'Incrição Estadual Inválida.';
  cstValidacaoDataNasc = 'Data de nascimento inválida. Utilize o formato dd/mm/yyyy.';
  cstValidacaoCep = 'Cep inválido.';
  cstValidacaoTelefone = 'Número de telefone inválido.';
  cstValidacaoCodVen = 'Esse vendedor não está cadastrado!';
  cstValidacaoCodVenNaoInf = 'O código do vendedor deve ser preenchido!';
  cstValidacaoCodCid =  'Essa cidade não está cadastrada!';
  cstValidacaoCodCidNaoInf = 'O Código da Cidade deve ser preenchido!';
  cstValidacaoCpfCNPJNaoInf = 'O CNPJ / CPF deve ser preenchido!';
  cstValidacaoDigitosCep = 'O Cep deve conter 8 digitos.';
  cstValidacaoCodAtiNaoInf = 'O código da atividade deve ser preenchido!';
  cstValidacaoCodAti = 'Essa atividade não está cadastrada!';
  cstValidacaoCodRed = 'O Código da Rede de Lojas digitado não existe!';
  cstValidacaoCrmFre = 'O Código de Frenquência digitado não existe!';
  cstValidacaoCrmPor = 'O Código de Porte digitado não existe!';
  cstValidacaoCrmFor = 'O Código do Fornecedor Atual digitado não existe!';
  cstValidacaoCrmFai = 'O Código da Faixa de Faturamento Estimado digitado não existe!';
  cstValidacaoCrmCat = 'O Código da Categoria digitado não existe!';
  cstValidacaoEndere = 'O endereço precisa ser preenchido.';
  cstValidacaoNumEnd = 'O número do endereço precisa ser preenchido.';
  cstValidacaoFone01 = 'O número do telefone precisa ser preenchido.';
  cstValidacaoEmail1 = 'O endereço de e-mail precisa ser preenchido.';
  cstValidacaoEnail3 = 'O endereço de e-mail nfe precisa ser preenchido.';
  cstValidacaoCepNaoInf = 'O cep precisa ser preenchido.';
  cstValidacaoCliVin = 'O registro atual já esta ativo no cadastro de clientes!';
  cstValidacaoCodRep = 'O Código de Representante digitado não existe!';
  cstValidacaoCodReg = 'O Código de Região digitado não existe!';


implementation

uses
  untFuncoesSimples, untCadCid, untFuncoesGenerica, StrUtils;

{ TValidacaoProspecto }

constructor TValidacaoProspecto.Create(aProspecto: IProspecto);
begin
  FProspecto := aProspecto;
  FBlnExecutar := True;

  inherited Create;
end;

destructor TValidacaoProspecto.Destroy;
begin
  inherited;
end;

function TValidacaoProspecto.fValidarCidade: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If Not fEmptyStr(FProspecto.NomCid) Then
   If fEmptyStr(FProspecto.CodCid) Then
    FProspecto.CodCid := fRetornaCodigoCidade(FProspecto.NomCid);

  If fEmptyStr(FProspecto.CodCid) Then
  Begin
    FMensagemRetorno := cstValidacaoCodCidNaoInf;
    Result := False;
    Exit;
  End;

  Result := Not fEmptyStr( fCampoTabela('CID_CODCID', 'CADCID', ['CID_CODCID'], [FProspecto.CodCid], False) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodCid
  Else
  Begin
    FProspecto.NomCid := fRetNomCidade(FProspecto.CodCid);
    FProspecto.Estado := fRetNomCidade(FProspecto.CodCid, 1);
  End;
end;

function TValidacaoProspecto.fValidarClienteCadastrado: Boolean;
var
  strCodCliC: String;
begin
  Result := False;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CPFCGC) Then
  Begin
    FMensagemRetorno := cstValidacaoCpfCNPJNaoInf;
    Exit;
  End;

  strCodCliC := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [FProspecto.CPFCGC] );
  If (Not fEmptyStr(strCodCliC)) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoRegistroClienteCadastrado;
  End
  Else
    Result := True;
end;

function TValidacaoProspecto.fValidarClienteVinculado: Boolean;
var
  strCodCli: String;
begin
  strCodCli := fCampoTabela('PRO_CODCLI', 'PROSPE', ['PRO_CODPRO'], [FProspecto.CodPro] );
  Result := fEmptyStr(strCodCli);
  If Not(Result) Then
    FMensagemRetorno := cstValidacaoCliVin;
end;

function TValidacaoProspecto.fValidarCodReg: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CodReg) Then
    If Not fEmptyStr(FProspecto.DesReg) Then
      FProspecto.CodReg := fRetornaCodigoRegiao(FProspecto.DesReg);

  If fEmptyStr(FProspecto.CodReg) Then
    Exit;

  Result := Not fEmptyStr( fRetNomRegiao(FProspecto.CodReg) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodReg
  Else
   FProspecto.DesReg := fRetNomRegiao(FProspecto.CodReg)
end;

function TValidacaoProspecto.fValidarCodRep: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CodRep) Then
    If Not fEmptyStr(FProspecto.NomRep) Then
      FProspecto.CodRep := fRetornaCodigoRepresentante(FProspecto.NomRep);

  If fEmptyStr(FProspecto.CodRep) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_CODOPE'], [FProspecto.CodRep], False) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodRep
  Else
   FProspecto.NomRep := fRetNomVendRep(FProspecto.CodRep)
end;


function TValidacaoProspecto.Executar(Const aExibirMensagem: Boolean = False): Boolean;
begin
  Result := True;
  Try
    fValidarCPFCNPJ;
    fValidarCidade;
    fValidarCep(aExibirMensagem);
    fValidarAtividade;
    fValidarVendedor;
    fValidarRedeLojas;
    fValidarCrmFre;
    fValidarCrmCat;
    fValidarCrmPor;
    fValidarCrmFai;
    fValidarInscricaoEstadual;
    fValidarDataNasc;
    fValidarCrmFor;
    fValidarCodRep;
    fValidarCodReg;
  Except
    Result := False;
  End;
end;

function TValidacaoProspecto.fVerificaPodeVincularCliente(
  const aExibirMensagem: Boolean): Boolean;
begin
  Try
    FBlnExecutar := FBlnExecutar And fValidarClienteVinculado;
    FBlnExecutar := FBlnExecutar And fValidarCPFCNPJ;
    FBlnExecutar := FBlnExecutar And fValidarCidade;
    FBlnExecutar := FBlnExecutar And fValidarCep(False);
    FBlnExecutar := FBlnExecutar And fValidarEndereco;

    FBlnExecutar := FBlnExecutar And fValidarAtividade;
    FBlnExecutar := FBlnExecutar And fValidarVendedor;
    FBlnExecutar := FBlnExecutar And fValidarTelefone;
    FBlnExecutar := FBlnExecutar And fValidarEmail01;
    FBlnExecutar := FBlnExecutar And fValidarEmailNfe;
    FBlnExecutar := FBlnExecutar And fValidarCodRep;

    Result := FBlnExecutar;
    If (Not Result) and aExibirMensagem Then
    Begin
      fMensagem('ATENÇÃO!', FMensagemRetorno, ['&Ok']);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      FMensagemRetorno := E.Message;
    End;
  End;
end;

function TValidacaoProspecto.fValidarCPFCNPJ: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CPFCGC) Then
  Begin
    FMensagemRetorno := cstValidacaoCpfCNPJNaoInf;
    Result := False;
    Exit;
  End;

  Result := (fValidaCPF(FProspecto.CPFCGC)  or  fTestaCgc(FProspecto.CPFCGC));

  If Length( FProspecto.CPFCGC ) > 11 Then
    FProspecto.TipPro := '1'
  Else
    FProspecto.TipPro := '2';

  If Not Result Then
    FMensagemRetorno := cstValidacaoCPFCCGInvalido;
end;

function TValidacaoProspecto.fProcessarMensagemCep(Const blnExibirMensagem: Boolean; aMensagem: String; blnConfirma: Boolean = False): Integer;
Begin
  Result := 1;
  FMensagemValidacaoCep := aMensagem;
  If blnExibirMensagem Then
  Begin
    If blnConfirma Then
      Result := fMensagem('ATENÇÃO!', aMensagem,  ['&Sim', '&Não'])
    Else
      Result := fMensagem('ATENÇÃO!', aMensagem, ['&Ok']);
  End;

  FMensagemRetorno := FMensagemValidacaoCep;
End;

procedure TValidacaoProspecto.pSetarEndereco(const strCodCid, strEndere, strBairro,
  strNomCid, strEstado, strCorreio: String);
begin
  If FAtualizarEndereco Then
  Begin
    FProspecto.CodCid := strCodCid;
    FProspecto.NomCid := fRetNomCidade(strCodCid);
    FProspecto.Estado := fRetNomCidade(strCodCid, 1);
    FProspecto.Endere := strEndere;
    FProspecto.Bairro := strBairro;
    FProspecto.CodCorreio := strCorreio;
  End
  Else
  Begin
    If fEmptyStr(FProspecto.CodCid) Then
      FProspecto.CodCid := strCodCid;
    If fEmptyStr(FProspecto.NomCid) Then
      FProspecto.NomCid := fRetNomCidade(strCodCid);
    If fEmptyStr(FProspecto.Estado) Then
      FProspecto.Estado := fRetNomCidade(strCodCid, 1);
    If fEmptyStr(FProspecto.Endere) Then
      FProspecto.Endere := strEndere;
    If fEmptyStr(FProspecto.Bairro) Then
      FProspecto.Bairro := strBairro;
    If fEmptyStr(FProspecto.CodCorreio) Then
      FProspecto.CodCorreio := strCorreio;
  End;

end;

function TValidacaoProspecto.fAtualizarInformacoesCep(Const aExibirMensagem: Boolean): Boolean;
var
  strCodCid,
  strEndere,
  strBairro,
  strNomCid,
  strEstado,
  strCorreio: string;
Begin
  Result := True;

  If (Not fCadCepDadosCep(FProspecto.NumCep, strCodCid, strEndere, strBairro, strNomCid, strEstado, strCorreio, '' ,  '' )) Then
  Begin
    fProcessarMensagemCep(aExibirMensagem,'Cep não encontrado');
    Exit;
  End;

  If (fEmptyStr(strCodCid)) Then
    If fVerificaAcessoSistema('frmCadCidades') Then
    Begin
      Result := False;
      fProcessarMensagemCep(aExibirMensagem, fMensagemTravaAcessoCadCid(strCodCid, strNomCid));
      Exit;
    End;

  If fEmptyStr(strCorreio) Then
  Begin
    If fProcessarMensagemCep(aExibirMensagem,  'O Código Correios da cidade ' + strNomCid + ' está em branco.' + #13#10 +
                                               'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?') = 1 Then
    Begin
      pAtualizaCodigoCorreios(strCodCid, FProspecto.NumCep);
    End;
  End;

  If (strCodCid <> FProspecto.CodCid)  Then
    If (Not fEmptyStr(strCodCid)) Then
    Begin
      Result := False;
      fProcessarMensagemCep(aExibirMensagem, 'O CEP informado não pertence a cidade de ' + fRetNomCidade(FProspecto.CodCid) + '!');
      Exit;
    End;

  FAtualizarEndereco := False;
  If (Result) Then
  Begin
    If (fTiraCaracEspeciais(FProspecto.NumCep) <> fTiraCaracEspeciais(FCepAnt)) And (Not fEmptyStr(FCepAnt)) Then
    Begin
      FAtualizarEndereco := fProcessarMensagemCep(aExibirMensagem, 'O CEP foi alterado, deseja atualizar o endereço?', True) = 1;
    End;
  End;

  pSetarEndereco( strCodCid, strEndere, strBairro, strNomCid, strEstado, strCorreio );
End;

function TValidacaoProspecto.fValidarCep(Const aExibirMensagem: Boolean = False; aImportandoProspecto: Boolean = False): Boolean;
begin
  Result := True;

  If aImportandoProspecto Then
    FCepAnt := '';

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CodCid) Then
    If  fEmptyStr(FProspecto.NumCep) Then
      Exit;

  If (FProspecto.Estado = 'EX') Then
    Exit;

  // Não é obrigatório o Cep para cadastro de prospecto
  If (Length(Trim(fTiraCaracEspeciais(FProspecto.NumCep)))<= 0) Then
    Exit;

  If (Length(Trim(fTiraCaracEspeciais(FProspecto.NumCep))) <> 8) Then
  Begin
    Result := False;
    fProcessarMensagemCep(aExibirMensagem, cstValidacaoDigitosCep);
    Exit;
  End;

  If (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Result := fAtualizarInformacoesCep(aExibirMensagem);
  End;

  FCepAnt := FProspecto.NumCep;
end;

function TValidacaoProspecto.fRetornaCodigoCidade(Const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CID_CODCID', 'CADCID', ['CID_NOMCID'], [aConteudo], False);
end;

function TValidacaoProspecto.fValidarAtividade: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CodAti) Then
    If Not fEmptyStr(FProspecto.DesAti) Then
      FProspecto.CodAti := fRetornaCodigoAtividade(FProspecto.DesAti);

  If fEmptyStr(FProspecto.CodAti) Then
  Begin
    FMensagemRetorno := cstValidacaoCodAtiNaoInf;
    Result := False;
    Exit;
  End;

  Result := Not fEmptyStr( fCampoTabela('ATI_CODATI', 'CADATI', ['ATI_CODATI'], [FProspecto.CodAti], False) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodAti
  Else
   FProspecto.DesAti := fRetNomAtividade(FProspecto.CodAti)
end;

function  TValidacaoProspecto.fRetornaCodigoAtividade(Const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('ATI_CODATI', 'CADATI', ['ATI_DESATI'], [aConteudo], False);
end;

function TValidacaoProspecto.fValidarVendedor: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If Not FEmptyStr(FProspecto.NomVen) Then
    If fEmptyStr(FProspecto.CodVen) Then
      FProspecto.CodVen := fRetornaCodigoVendedor(FProspecto.NomVen) ;

  If fEmptyStr(FProspecto.CodVen) Then
  Begin
    FMensagemRetorno := cstValidacaoCodVenNaoInf;
    Result := False;
    Exit;
  End;

  Result := Not fEmptyStr( fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_CODOPE'], [FProspecto.CodVen], False) );
  FProspecto.NomVen := fRetNomVendRep(FProspecto.CodVen);

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodVen;
end;

function TValidacaoProspecto.fRetornaCodigoVendedor(Const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_NOMOPE'], [aConteudo], False);
end;

function TValidacaoProspecto.fRetornaCodigoCrmPor(const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CRP_CODIGO', 'CRMPOR', ['CRP_DESCRI'], [aConteudo]);
end;

function TValidacaoProspecto.fRetornaCodigoRedeLoja(const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('RED_CODRED', 'CADRED', ['RED_DESRED'], [aConteudo], False);
end;

function TValidacaoProspecto.fRetornaCodigoRegiao(
  const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('REG_CODREG', 'CADREG', ['REG_DESREG'], [aConteudo], False);
end;

function TValidacaoProspecto.fRetornaCodigoRepresentante(
  const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_NOMOPE'], [aConteudo], False);
end;

function TValidacaoProspecto.fRetornaCodigoCrmCat(const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CAT_CODIGO', 'CRMCAT', ['CAT_DESCRI'], [aConteudo]);
end;

function TValidacaoProspecto.fRetornaCodigoCrmFai(
  const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CRF_CODIGO', 'CRMFAI', ['CRF_DESCRI'], [aConteudo]);
end;

function TValidacaoProspecto.fRetornaCodigoCrmFor(const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CRF_CODIGO', 'CRMFOR', ['CRF_NOMFOR'], [aConteudo]);
end;

function TValidacaoProspecto.fRetornaCodigoCrmFre(const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('CRF_CODIGO', 'CRMFRE', ['CRF_DESCRI'], [aConteudo]);
end;

function TValidacaoProspecto.fValidarRedeLojas: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If Not fEmptyStr(FProspecto.DesRed) Then
    If fEmptyStr(FProspecto.CodRed) Then
      FProspecto.CodRed := fRetornaCodigoRedeLoja(FProspecto.DesRed);

  If fEmptyStr(FProspecto.CodRed) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('RED_CODRED', 'CADRED', ['RED_CODRED'], [FProspecto.CodRed], False) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCodRed
  Else
    FProspecto.DesRed := fRetNomeRedeLojaSelect(FProspecto.CodRed)
end;

function TValidacaoProspecto.fValidarTelefone: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.Fone01) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoFone01;
    Exit;
  End;

  Result := fValidaTelefone( FProspecto.Fone01 );

  If Not Result Then
    FMensagemRetorno := cstValidacaoTelefone;
end;

function TValidacaoProspecto.fValidarCrmCat: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If Not fEmptyStr(FProspecto.DesCat) Then
    If fEmptyStr(FProspecto.CrmCat) Then
      FProspecto.CrmCat := fRetornaCodigoCrmCat(FProspecto.DesCat);

  If fEmptyStr(FProspecto.CrmCat) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('CAT_CODIGO', 'CRMCAT', ['CAT_CODIGO'], [FProspecto.CrmCat]) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCrmCat
  Else
    FProspecto.DesCat := fRetDesCrmCat(FProspecto.CrmCat);
end;

function TValidacaoProspecto.fValidarCrmFai: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CrmFai) Then
    If Not fEmptyStr(FProspecto.DesFai) Then
      FProspecto.CrmFre := fRetornaCodigoCrmFai(FProspecto.DesFai);

  If fEmptyStr(FProspecto.CrmFai) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('CRF_CODIGO', 'CRMFAI', ['CRF_CODIGO'], [FProspecto.CrmFai]) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCrmFai
  Else
    FProspecto.DesFai := fRetDesCrmFai(FProspecto.CrmFai);
end;

function TValidacaoProspecto.fValidarCrmFre: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CrmFre) Then
    If Not fEmptyStr(FProspecto.DesFre) Then
      FProspecto.CrmFre := fRetornaCodigoCrmFre(FProspecto.DesFre);

  If fEmptyStr(FProspecto.CrmFre) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('CRF_CODIGO', 'CRMFRE', ['CRF_CODIGO'], [FProspecto.CrmFre]) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCrmFre
  Else
    FProspecto.DesFre := fRetDesCrmFre(FProspecto.CrmFre);

end;

function TValidacaoProspecto.fValidarCrmPor: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CrmPor) Then
    If Not fEmptyStr(FProspecto.DesPor) Then
      FProspecto.CrmPor := fRetornaCodigoCrmPor(FProspecto.DesPor);

  If fEmptyStr(FProspecto.CrmPor) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('CRP_CODIGO', 'CRMPOR', ['CRP_CODIGO'], [FProspecto.CrmPor]) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCrmPor
  Else
    FProspecto.DesPor := fRetDesCrmPor(FProspecto.CrmPor);
end;

function TValidacaoProspecto.fValidarCrmFor: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.CrmFor) Then
    If Not fEmptyStr(FProspecto.DesFor) Then
      FProspecto.CrmFor := fRetornaCodigoCrmFor(FProspecto.DesFor);

  If fEmptyStr(FProspecto.CrmFor) Then
    Exit;

  Result := Not fEmptyStr( fCampoTabela('CRF_CODIGO', 'CRMFOR', ['CRF_CODIGO'], [FProspecto.CrmFor]) );

  If Not Result Then
    FMensagemRetorno := cstValidacaoCrmFor
  Else
    FProspecto.DesFor := fRetDesCrmFor(FProspecto.CrmFor);
end;

function TValidacaoProspecto.fValidarDataNasc: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.StrDatNas) Then
    Exit;

  Try
    FProspecto.DatNas := StrToDateTime(FProspecto.StrDatNas);
    Result := FProspecto.DatNas > 0;
    FMensagemRetorno := cstValidacaoDataNasc;
  except
    Result := False;
  End;
end;

function TValidacaoProspecto.fValidarEmail01: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.Email1) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoEmail1;
    Exit;
  End;

  Result := fEmailValido(FProspecto.Email1, False, 'E-Mail', False, False);

  If Not Result Then
  Begin
    FMensagemRetorno := cstValidacaoEmail;
  End;
end;

function TValidacaoProspecto.fValidarEmailNfe: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.Email3) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoEnail3;
    Exit;
  End;

  Result := fEmailValido( FProspecto.Email3, False, 'E-Mail', False, False);

  If Not Result Then
  Begin
    FMensagemRetorno := cstValidacaoEmail;
  End;
end;

function TValidacaoProspecto.fValidarEndereco: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If fEmptyStr(FProspecto.Endere) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoEndere;
  End;

  If fEmptyStr(FProspecto.NumEnd) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoNumEnd;
  End;
end;

function TValidacaoProspecto.fValidarInscricaoEstadual: Boolean;
begin
  Result := True;

  If Not FBlnExecutar Then
    Exit;

  If Not fValidaIES(FProspecto.InsEst, FProspecto.Estado) Then
  Begin
    Result := False;
    FMensagemRetorno := cstValidacaoInscricaoEstadual;
  End
  Else
  Begin
    If FProspecto.Estado = 'RS' Then
    Begin
      FProspecto.InsEst := fRetornaZerosNumIes( FProspecto.InsEst ) + FProspecto.InsEst;
    End;
  End;
end;

{ TProspectoController }

constructor TProspectoController.Create;
begin
  FProspecto := TProspecto.fNew;
  FValidacao := TValidacaoProspecto.Create(Nil);
  FValidacao.Prospecto := FProspecto;
end;

destructor TProspectoController.Destroy;
begin
  inherited;

end;

procedure TProspectoController.pCarregarProspecto(const strCodPro: String);
var
  qrySelect: TUniQuery;
Begin
  qrySelect := fCriaQuery;
  Try
    qrySelect.Close;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add(' SELECT * FROM PROSPE       ');
    qrySelect.SQL.Add(' WHERE PRO_CODPRO = :CODPRO ');
    qrySelect.ParamByName('CODPRO').AsString := strCodPro;
    qrySelect.Open;

    If Not qrySelect.IsEmpty Then
    Begin
      FProspecto.strAutInc(qrySelect.FieldByName('AUTOINCREM').AsString)
                .strCodPro(qrySelect.FieldByName('PRO_CODPRO').AsString)
                .strNomPro(qrySelect.FieldByName('PRO_NOMCLI').AsString)
                .strCPFCGC(qrySelect.FieldByName('PRO_CGCCPF').AsString)
                .strEndere(qrySelect.FieldByName('PRO_ENDERE').AsString)
                .strNumEnd(qrySelect.FieldByName('PRO_ENDNUM').AsString)
                .strCodCid(qrySelect.FieldByName('PRO_CODCID').AsString)
                .strCodVen(qrySelect.FieldByName('PRO_CODVEN').AsString)
                .strCodAti(qrySelect.FieldByName('PRO_CODATI').AsString)
                .strStatus(qrySelect.FieldByName('PRO_STATUS').AsString)
                .strFone01(qrySelect.FieldByName('PRO_FONE01').AsString)
                .strFone02(qrySelect.FieldByName('PRO_FONE01').AsString)
                .strEmail1(qrySelect.FieldByName('PRO_EMAIL_').AsString)
                .strEmail2(qrySelect.FieldByName('PRO_EMAIL2').AsString)
                .strEmail3(qrySelect.FieldByName('PRO_EMAIL3').AsString)
                .strBairro(qrySelect.FieldByName('PRO_BAIRRO').AsString)
                .strNumCep(qrySelect.FieldByName('PRO_C_E_P_').AsString)
                .strContat(qrySelect.FieldByName('PRO_C_E_P_').AsString)
                .strEndCom(qrySelect.FieldByName('PRO_ENDCOM').AsString)
                .strNomFan(qrySelect.FieldByName('PRO_ENDCOM').AsString)
                .strNumFax(qrySelect.FieldByName('PRO_F_A_X_').AsString)
                .strInsEst(qrySelect.FieldByName('PRO_I_E_S_').AsString)
                .StrDtaNas(qrySelect.FieldByName('PRO_NASCIM').AsString)
                .strIdNext(qrySelect.FieldByName('PRO_NEXTEL').AsString)
                .strNum_Rg(qrySelect.FieldByName('PRO_NUMR_G').AsString)
                .strObserv(qrySelect.FieldByName('PRO_OBSERV').AsString)
                .strNRgExp(qrySelect.FieldByName('PRO_RG_EXP').AsString)
                .strCodRed(qrySelect.FieldByName('PRO_CODRED').AsString)
                .strCrmFai(qrySelect.FieldByName('PRO_CRMFAI').AsString)
                .strCrmFre(qrySelect.FieldByName('PRO_CRMFRE').AsString)
                .strCrmPor(qrySelect.FieldByName('PRO_CRMPOR').AsString)
                .strCrmCat(qrySelect.FieldByName('PRO_CRMCAT').AsString)
                .strCaiPos(qrySelect.FieldByName('PRO_CAIPOS').AsString)
                .strCelula(qrySelect.FieldByName('PRO_CELULA').AsString)
                .strHomePg(qrySelect.FieldByName('PRO_HOMEPA').AsString)
                .strStaPro(qrySelect.FieldByName('PRO_STAPRO').AsString)
                .strCodRep(qrySelect.FieldByName('PRO_CODREP').AsString)
                .strCodReg(qrySelect.FieldByName('PRO_CODREG').AsString);
    End;
  Finally
    qrySelect.Close;
    FreeAndNil(qrySelect);
  End;
End;

procedure TProspectoController.pAtualizarCategoriaCrm(const strCrmCatAtu: String);
var
  qryUpdate: TUniQuery;
Begin
  If fEmptyStr(FProspecto.AutInc) Then
    Exit;

  If fEmptyStr(strCrmCatAtu) Then
    Exit;

  qryUpdate := fCriaQuery;
  Try
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(' UPDATE PROSPE ');
    qryUpdate.SQL.Add('   SET PRO_CRMCAT = :CRMCAT ');
    qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');
    qryUpdate.ParamByName('AUTINC').AsString := FProspecto.AutInc;
    qryUpdate.ParamByName('CRMCAT').AsString := strCrmCatAtu;
    qryUpdate.ExecSQL;

    FProspecto.strCrmCat(strCrmCatAtu);
  Finally
    FreeAndNil(qryUpdate);
  End;
End;

procedure TProspectoController.pAtualizarStatusProspecto(const strTipStat: String);
var
  qryUpdate: TUniQuery;
Begin
  If fEmptyStr(FProspecto.AutInc) Then
    Exit;

  If fEmptyStr(strTipStat) Then
    Exit;

  qryUpdate := fCriaQuery;
  Try
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(' UPDATE PROSPE ');
    qryUpdate.SQL.Add('   SET PRO_STAPRO = :CRMSTA ');
    qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');
    qryUpdate.ParamByName('AUTINC').AsString := FProspecto.AutInc;
    qryUpdate.ParamByName('CRMSTA').AsString := strTipStat;
    qryUpdate.ExecSQL;

    FProspecto.strStaPro(strTipStat);
  Finally
    FreeAndNil(qryUpdate);
  End;
End;

procedure TProspectoController.pExecutarVinculoCadCli(const strCodCli: String);
Var
  qryUpdate : TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);

  Try
    fStartTransaction;
    Try
      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE PROSPE SET PRO_CODCLI = :PRO_CODCLI,');
      qryUpdate.SQL.Add('                  PRO_STATUS = :PRO_STATUS');
      qryUpdate.SQL.Add('WHERE PRO_CODPRO = :PRO_CODPRO');
      qryUpdate.ParamByName('PRO_CODCLI').AsString := strCodCli;
      qryUpdate.ParamByName('PRO_CODPRO').AsString := FProspecto.CodPro;
      qryUpdate.ParamByName('PRO_STATUS').AsString := 'I';
      qryUpdate.ExecSQL;

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(' UPDATE MOVOCO SET OCO_CODCLI = :CODCLI, OCO_TIP_FC = "C" ');
      qryUpdate.SQL.Add(' WHERE OCO_CODCLI = :CODPRO AND OCO_TIP_FC = "P"          ');
      qryUpdate.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdate.ParamByName('CODPRO').AsString := FProspecto.CodPro;
      qryUpdate.ExecSQL;

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(' UPDATE FATGOR                                  ');
      qryUpdate.SQL.Add('   INNER JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM ');
      qryUpdate.SQL.Add(' SET FGO_CODCLI = :CODCLI,                      ');
      qryUpdate.SQL.Add('     FGO_PROSPE = NULL                          ');
      qryUpdate.SQL.Add(' WHERE FGO_PROSPE = :CODPRO                     ');
      qryUpdate.SQL.Add('   AND FGO_JAFATU = 0                           ');
      qryUpdate.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdate.ParamByName('CODPRO').AsString := FProspecto.CodPro;
      qryUpdate.ExecSQL;

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(' INSERT INTO CLIFOR (CLF_CODCLI, CLF_CRMFOR)        ');
      qryUpdate.SQL.Add('   SELECT ' + QuotedStr(strCodCli) + ',  PRF_CRMFOR ');
      qryUpdate.SQL.Add('     FROM PROFOR                                    ');
      qryUpdate.SQL.Add('   WHERE  PRF_CODPRO = :CODPRO                      ');
      qryUpdate.ParamByName('CODPRO').AsString := FProspecto.CodPro;
      qryUpdate.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCRM.pVincularProspectoCliente]');
      End;
    End;

  Finally
    FreeAndNil(qryUpdate);
  End;

end;

end.
