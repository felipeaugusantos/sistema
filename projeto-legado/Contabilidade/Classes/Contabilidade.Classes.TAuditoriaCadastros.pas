unit Contabilidade.Classes.TAuditoriaCadastros;

{-------------------------------------------------------------------------------
  Dispatcher para abertura dos cadastros de origem referenciados nos lançamentos
  contábeis (CON_TPORIC/CON_CDORIC e CON_TPORID/CON_CDORID).

  Uso típico (a partir de um duplo clique na grid de LANCON):

    // ao clicar na coluna de crédito
    TAuditoriaCadastros.AbrirDoDataset(cdsLancon, tolCredito);

    // ou setando os parâmetros manualmente
    TAuditoriaCadastros.AbrirPorOrigem('CF', '000123', 'F');

  Códigos de CON_TPORIC/CON_TPORID suportados nesta rotina:
    'CF' -> Cliente ou Fornecedor (usa CON_TIP_FC = 'C'/'F')
    'PT' -> Portador   (frmCadPortadores)
    'BN' -> Bandeira   (frmCadBandeiras)
    'PC' -> Plano de Contas / Centro de Custo (frmCadCentroCusto)

  Códigos ainda não suportados por esta auditoria (avisa e sai):
    'PR' (Parcon), 'AB' (Abreviação Produto), 'CN' (Configuração)
-------------------------------------------------------------------------------}

interface

uses
  System.SysUtils, Data.DB;

type
  TTipoOrigemLancon = (tolCredito, tolDebito, tolParcon);

  TAuditoriaCadastros = class
  private
    class procedure pAbrirCliente(const ACodigo: String); static;
    class procedure pAbrirFornecedor(const ACodigo: String); static;
    class procedure pAbrirPortador(const ACodigo: String); static;
    class procedure pAbrirBandeira(const ACodigo: String); static;
    class procedure pAbrirPlanoContas(const ACodigo: String); static;
    class procedure pAbrirParametroContabil(const ASeqPar: String); static;
    class function  fPermissaoOk(const ANomeForm: String): Boolean; static;
  public
    /// Abre o cadastro correspondente ao tipo de origem informado.
    /// @param ATipoOrigem   Valor de CON_TPORIC ou CON_TPORID ('PR','CF','PT','BN','PC','AB','CN')
    /// @param ACodigo       Valor de CON_CDORIC ou CON_CDORID
    /// @param ATipoCliFor   Valor de CON_TIP_FC ('C' = Cliente / 'F' = Fornecedor).
    ///                      Só é usado quando ATipoOrigem = 'CF'.
    class procedure pAbrirPorOrigem(const ATipoOrigem, ACodigo,
      ATipoCliFor: String); static;

    /// Versão que lê os campos direto do dataset da grid de LANCON.
    /// AOrigem escolhe se pega Crédito (CON_TPORIC/CON_CDORIC) ou Débito (CON_TPORID/CON_CDORID).
    class procedure pAbrirDoDataset(ADataset: TDataSet;
      AOrigem: TTipoOrigemLancon); static;
  end;

implementation

uses
  Vcl.Forms,
  untCadClientes,
  untCadFornecedores,
  untCadPortadores,
  untCadBandeiras,
  untCadCentroCusto,
  Contabilidade.View.ParametrosContabilizacao,
  untFuncoesSimples,
  Contabilidade.Consultas,
  Contabilidade.Funcoes;

{ TAuditoriaCadastros }

class function TAuditoriaCadastros.fPermissaoOk(const ANomeForm: String): Boolean;
begin
  Result := fVerificaAcessoSistema(ANomeForm);
  If Not Result Then
    pMensagemOk('Usuário sem permissão para o cadastro "' + ANomeForm + '".');
end;

class procedure TAuditoriaCadastros.pAbrirCliente(const ACodigo: String);
var
  LfrmCadClientes: TfrmCadClientes;
begin
  If Not fPermissaoOk('frmCadClientes') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmCadClientes, LfrmCadClientes);
  Try
    Try
      LfrmCadClientes.strCodClienteIniciarCadastro := ACodigo;
      LfrmCadClientes.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirCliente]');
    End;
  Finally
    pFreeAndNil(LfrmCadClientes);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirFornecedor(const ACodigo: String);
var
  LfrmCadFornecedores: TfrmCadFornecedores;
begin
  If Not fPermissaoOk('frmCadFornecedores') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmCadFornecedores, LfrmCadFornecedores);
  Try
    Try
      LfrmCadFornecedores.strCodFornecedorIniciarCadastro   := ACodigo;
      // Injeção das dependências contábeis (idêntica ao padrão de untEntDadosCaixa2)
      LfrmCadFornecedores.fMskCon                           := fMskCon;
      LfrmCadFornecedores.fSemMascaraPlaNco                 := fSemMascaraPlaNco;
      LfrmCadFornecedores.fPesqPlanoContabil                := fPesqPlanoContabil;
      LfrmCadFornecedores.pPlanoDeContasPorEmpresa          := pPlanoDeContasPorEmpresa;
      LfrmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      LfrmCadFornecedores.pGravarPlanoContasAutomatico      := pGravarPlanoContasAutomatico;
      LfrmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa
                                                           := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      LfrmCadFornecedores.fCriaEstruturaCdsNCO              := fCriaEstruturaCdsNCO;
      LfrmCadFornecedores.pCarregaPlanoDeContasPorEmpresa   := pCarregaPlanoDeContasPorEmpresa;
      LfrmCadFornecedores.pSalvaPlanoDeContasPorEmpresa     := pSalvaPlanoDeContasPorEmpresa;
      LfrmCadFornecedores.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirFornecedor]');
    End;
  Finally
    LfrmCadFornecedores.fMskCon                         := Nil;
    LfrmCadFornecedores.fSemMascaraPlaNco               := Nil;
    LfrmCadFornecedores.fPesqPlanoContabil              := Nil;
    LfrmCadFornecedores.fCriaEstruturaCdsNCO            := Nil;
    LfrmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil;
    LfrmCadFornecedores.pSalvaPlanoDeContasPorEmpresa   := Nil;
    pFreeAndNil(LfrmCadFornecedores);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirPortador(const ACodigo: String);
var
  LfrmCadPortadores: TfrmCadPortadores;
begin
  If Not fPermissaoOk('frmCadPortadores') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmCadPortadores, LfrmCadPortadores);
  Try
    Try
      LfrmCadPortadores.strCodPorIniciarCadastro := ACodigo;
      LfrmCadPortadores.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirPortador]');
    End;
  Finally
    pFreeAndNil(LfrmCadPortadores);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirBandeira(const ACodigo: String);
var
  LfrmCadBandeiras: TfrmCadBandeiras;
begin
  If Not fPermissaoOk('frmCadBandeiras') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmCadBandeiras, LfrmCadBandeiras);
  Try
    Try
      LfrmCadBandeiras.strCodBanIniciarCadastro := ACodigo;
      LfrmCadBandeiras.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirBandeira]');
    End;
  Finally
    pFreeAndNil(LfrmCadBandeiras);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirParametroContabil(
  const ASeqPar: String);
var
  LfrmParCon: TfrmParametrosContabilizacao;
begin
  If Not fPermissaoOk('frmParametrosContabilizacao') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmParametrosContabilizacao, LfrmParCon);
  Try
    Try
      LfrmParCon.strSeqParIniciarCadastro := ASeqPar;
      LfrmParCon.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirParametroContabil]');
    End;
  Finally
    pFreeAndNil(LfrmParCon);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirPlanoContas(const ACodigo: String);
var
  LfrmCadCentroCusto: TfrmCadCentroCusto;
begin
  If Not fPermissaoOk('frmCadCentroCusto') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;

  pCriarFormularios(TfrmCadCentroCusto, LfrmCadCentroCusto);
  Try
    Try
      LfrmCadCentroCusto.strCodCta := ACodigo;
      LfrmCadCentroCusto.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TAuditoriaCadastros.AbrirPlanoContas]');
    End;
  Finally
    pFreeAndNil(LfrmCadCentroCusto);
  End;
end;

class procedure TAuditoriaCadastros.pAbrirPorOrigem(const ATipoOrigem, ACodigo,
  ATipoCliFor: String);
var
  LTipo   : String;
  LCliFor : String;
begin
  LTipo   := UpperCase(Trim(ATipoOrigem));
  LCliFor := UpperCase(Trim(ATipoCliFor));

  If fEmptyStr(LTipo) Then
  Begin
    pMensagemOk('Tipo de origem não informado.');
    Exit;
  End;

  If fEmptyStr(ACodigo) Then
  Begin
    pMensagemOk('Código de origem não informado.');
    Exit;
  End;

  If LTipo = 'CF' Then
  Begin
    If LCliFor = 'C' Then
      pAbrirCliente(ACodigo)
    Else If LCliFor = 'F' Then
      pAbrirFornecedor(ACodigo)
    Else
      pMensagemOk('Tipo Cliente/Fornecedor (CON_TIP_FC) inválido: "' +
                  ATipoCliFor + '". Esperado "C" ou "F".');
    Exit;
  End;

  If LTipo = 'PT' Then
  Begin
    pAbrirPortador(ACodigo);
    Exit;
  End;
  If LTipo = 'BN' Then
  Begin
    pAbrirBandeira(ACodigo);
    Exit;
  End;
  If LTipo = 'PC' Then
  Begin
    pAbrirPlanoContas(ACodigo);
    Exit;
  End;
  If LTipo = 'PR' Then
  Begin
    pAbrirParametroContabil(ACodigo);
    Exit;
  End;

  // Tipos que ainda não são cobertos pela auditoria contábil.
  If (LTipo = 'AB') Or (LTipo = 'CN') Then
  Begin
    pMensagemOk('A abertura do cadastro de origem "' + LTipo +
                '" ainda não está disponível nesta rotina de auditoria.');
    Exit;
  End;

  pMensagemOk('Tipo de origem desconhecido: "' + ATipoOrigem + '".');
end;

class procedure TAuditoriaCadastros.pAbrirDoDataset(ADataset: TDataSet;
  AOrigem: TTipoOrigemLancon);
var
  LCampoTipo : String;
  LCampoCod  : String;
  LTipo      : String;
  LCod       : String;
  LTipCliFor : String;
begin
  If (ADataset = Nil) Or (Not ADataset.Active) Or (ADataset.IsEmpty) Then
  Begin
    pMensagemOk('Nenhum lançamento selecionado.');
    Exit;
  End;
  LTipo := EmptyStr;
  Case AOrigem Of
    tolCredito:
    Begin
      LCampoTipo := 'CON_TPORIC';
      LCampoCod  := 'CON_CDORIC';
    End;
    tolDebito:
    Begin
      LCampoTipo := 'CON_TPORID';
      LCampoCod  := 'CON_CDORID';
    End;
    tolParcon:
    begin
      LTipo := 'PR';
    end;
  End;

  if fEmptyStr(LTipo) then
    LTipo := ADataset.FieldByName(LCampoTipo).AsString;
  // Para tipo 'PR' (Parcon) usamos CON_SEQPAR do próprio LANCON, não CON_CDORIC/CDORID.
  If UpperCase(Trim(LTipo)) = 'PR' Then
  Begin
    If ADataset.FindField('CON_SEQPAR') = Nil Then
    Begin
      pMensagemOk('Coluna CON_SEQPAR não está disponível no dataset de LANCON.');
      Exit;
    End;
    LCod := ADataset.FieldByName('CON_SEQPAR').AsString;
  End
  Else
    LCod := ADataset.FieldByName(LCampoCod).AsString;

  // CON_TIP_FC pode não estar publicado na grid; obtenha com FindField para não estourar.
  If ADataset.FindField('CON_TIP_FC') <> Nil Then
    LTipCliFor := ADataset.FieldByName('CON_TIP_FC').AsString
  Else
    LTipCliFor := '';

  pAbrirPorOrigem(LTipo, LCod, LTipCliFor);
end;

end.
