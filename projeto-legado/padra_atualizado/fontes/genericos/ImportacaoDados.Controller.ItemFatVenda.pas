unit ImportacaoDados.Controller.ItemFatVenda;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, ImportacaoDados.Model.ItemFatVenda;

Type

 TValidacaoItemFatVenda = class;

 TItemFatVendaController = Class
 private
   FItemFatVenda: TItemFatVenda;
   FValidacao: TValidacaoItemFatVenda;
 public
   constructor Create;
   destructor Destroy;override;

   property ItemFatVenda: TItemFatVenda read FItemFatVenda write FItemFatVenda;
   property Validacao: TValidacaoItemFatVenda read FValidacao write FValidacao;
 End;

 TValidacaoItemFatVenda = class
 private
    FItemFatVenda: TItemFatVenda;

  public
    constructor Create(aItemFatVenda: TItemFatVenda);
    destructor Destroy; override;

    function fValidarProduto: Boolean;
    function fValidarUnidade: Boolean;
    function fValidarEmpresa: Boolean;
    function fValidarLoteArm: Boolean;
    function fValidarDataEntrega: Boolean;
    function fValidarTabelaPreco: Boolean;

    function fRetornaCodigoUnidade(Const aConteudo: String): String;
    function fRetornaCodigoLote(Const aConteudo: String): String;
    function Executar(Const aExibirMensagem: Boolean = False): Boolean;

  end;

  Const

  cstValidacaoProduto          = 'Produto informado não está cadastrado na base de dados';
  cstValidacaoVlrUnitZerado    = 'Valor unitário não pode ter valor 0(Zero).';
  cstValidacaoDestino          = 'Destino inválido. Informe "R"  para Retira ou "E" para Entrega.';
  cstValidacaoUnidade          = 'Unidade informada não está cadastrada na base de dados.';
  cstValidacaoEmpresa          = 'Empresa informada não está cadastrada na base de dados.';
  cstValidacaoLote             = 'Lote informado não está cadastrado na base de dados.';
  cstValidacaoArm              = 'Código de Armazenamento informado não está cadastrado na base de dados.';
  cstValidacaoLocalRetira      = 'Local Retira inválido. Informe "C" para Caixa ou "E" para Expedição.';
  cstValidacaoTipoEntrega      = 'Tipo Entrega inválido. Informe "F" para Entrega Futura ou "I" para Entrega Imediata.';
  cstValidacaoMotivo           = 'Motivo inválido. Informe "F" para Falta de Produto, "A" para Aguardando Cliente ou "P" para Previsão de Entrega.';
  cstValidacaoClienteRetira    = 'Cliente Retira inválido. Informe "S" para Sim ou "N" para Não.';
  cstValidacaoDataEntrega      = 'Data de entrega inválida. Utilize o formato dd/mm/yyyy.';
  cstValidacaoTabelaPreco      = 'Tabela de Preço inválida.';
  cstValidacaoPegou            = 'Campo Cliente Pegou inválido. Informe "S" para Sim ou "N" para Não.';
  cstValidacaoBrinde           = 'Campo Brinde inválido. Informe "S" para Sim ou "N" para Não.';
  cstValidacaoNumerico         = 'Campo numérico inválido.';
  cstValidacaoQuantidadeZerada = 'Quantidade não pode ter valor 0(Zero).';
  cstValidacaoMultiploDeVenda  = 'Quantidade não permitida. Múltiplo de Vendas no cadastro de produto: %n.';

implementation

uses
  untFuncoesSimples,  untFuncoesGenerica, StrUtils;

{ TValidacaoItemFatVenda }

constructor TValidacaoItemFatVenda.Create(aItemfatVenda: TItemfatVenda);
begin
  FItemfatVenda := aItemfatVenda;

  inherited Create;
end;

destructor TValidacaoItemFatVenda.Destroy;
begin
  inherited;
end;

function TValidacaoItemFatVenda.fValidarProduto: Boolean;
begin
  Result := True;

  If Not fEmptyStr(FItemfatVenda.CodItem) Then
    Result := Not fEmptyStr( fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [FItemfatVenda.CodItem], False));
end;

function TValidacaoItemFatVenda.fValidarUnidade: Boolean;
begin
  Result := True;

  If Not fEmptyStr(FItemfatVenda.UnidadeItem) Then
    Result := Not fEmptyStr( fCampoTabela('UNI_SIGUNI', 'CADUNI', ['UNI_CODUNI'], [FItemfatVenda.UnidadeItem], False));
end;


function TValidacaoItemFatVenda.fValidarEmpresa: Boolean;
begin
  Result := True;

  If Not fEmptyStr(FItemfatVenda.EmpFat) Then
    Result := Not fEmptyStr( fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CODEMP'], [FItemfatVenda.EmpFat], False));
end;

function TValidacaoItemFatVenda.fValidarLoteArm: Boolean;
begin
  Result := True;

  If Not fEmptyStr(FItemfatVenda.LoteArm) Then
    Result := Not fEmptyStr( fCampoTabela('LOT_NUMLOT', 'CADLOT', ['LOT_NUMLOT'], [FItemfatVenda.LoteArm], False))

end;

function TValidacaoItemFatVenda.Executar(Const aExibirMensagem: Boolean = False): Boolean;
begin
  Result := True;
  Try
    fValidarProduto;
    fValidarUnidade;
    fValidarEmpresa;
    fValidarLoteArm;
    fValidarTabelaPreco;
  Except
    Result := False;
  End;
end;

function TValidacaoItemFatVenda.fRetornaCodigoUnidade(Const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  Result := fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_SIGUNI'], [aConteudo], False);
end;

function TValidacaoItemFatVenda.fRetornaCodigoLote(Const aConteudo: String): String;
begin
  If fEmptyStr(aConteudo) Then
    Exit;

  If (fCfgSis('CTLEST') = 1) Then
    Result := fCampoTabela('LOT_NUMLOT', 'CADLOT', ['LOT_NUMLOT'], [aConteudo], False)
  Else
    Result := fCampoTabela('AMZ_CODAMZ', 'CADAMZ', ['AMZ_CODAMZ'], [aConteudo], False)
end;


function TValidacaoItemFatVenda.fValidarDataEntrega: Boolean;
begin
  Result := True;

  If fEmptyStr(FItemfatVenda.StrDtaEntrega) Then
    Exit;

  Try
    FItemfatVenda.DtaEntrega := StrToDateTime(fRetornaDataTratada(FItemfatVenda.StrDtaEntrega));
    Result := FItemfatVenda.DtaEntrega > 0;
  except
    Result := False;
  End;
end;

function TValidacaoItemFatVenda.fValidarTabelaPreco: Boolean;
begin
  Result := True;

  If Not fEmptyStr(FItemfatVenda.TabPreCad) Then
    Result := (Pos(FItemfatVenda.TabPreCad,'1_2_3_4_5_6_7_') > 0);
end;

{ TItemFatVendaController }

constructor TItemFatVendaController.Create;
begin
  FItemfatVenda := TItemfatVenda.fNew;
  FValidacao := TValidacaoItemFatVenda.Create(FItemfatVenda);
end;

destructor TItemFatVendaController.Destroy;
begin
  inherited;

  If Assigned(FValidacao) Then
    FreeAndNil(FValidacao);

  If Assigned(FItemfatVenda) Then
    FreeAndNil(FItemfatVenda);

end;

end.
