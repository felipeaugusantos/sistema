{******************************************}
{* FUNÇÕES USADAS PARA EFEITO DO BOTÃO    *}
{* INSERT: EM CADASTROS QUE UTILIZAM CÓ-  *}
{* DIGOS DE OUTRAS TABELAS, É CHAMADA A   *}
{* TELA DE CADASTRO, CASO NÃO SE ENCONTRE *}
{* O REGISTRO DESEJADO                    *}
{***************************************MV*}
unit untFuncIns;

interface

 Uses Windows, Forms, SysUtils, untIFuncIns, Contabilidade.Funcoes, Contabilidade.Consultas;

Type
 {****************************************}
 {* Classe criada para utilizar o Evendo *}
 {* OnChamaCadastro do DBEditFocus       *}
 {************************************GB**}
 TFuncIns = Class
 Public
   Class function fChamaCadReg(Key: Word; strCodReg: String = ''): String;
   Class function fChamaCadTri(Key: Word): String;
   Class function fChamaCadMar(Key: Word): String;
   Class function fChamaCadUni(Key: Word): String;
   Class function fChamaCadGru(Key: Word): String;
   Class function fChamaCadEmp(Key: Word): String;
   Class function fChamaCadCli(Key: Word): String;
   Class function fChamaCadTra(Key: Word; strCodTra: String = ''): String;
   Class function fChamaCadMot(Key: Word; strCodMot: String = ''): String;
   Class function fChamaCadAju(Key: Word; strCodAju: String = ''): String;
   Class function fChamaCadPor(Key: Word): String;
   Class function fChamaTipPrj(Key: Word): String;
   Class function fChamaCadBco(Key: Word): String;
   Class function fChamaCadCta(Key: Word): String;
   Class function fChamaCadRes(Key: Word): String;
   Class function fChamaCadCfo(Key: Word): String;
   Class function fChamaCadCar(Key: Word): String;
   Class function fChamaCadOpe(Key: Word): String;
   Class function fChamaCadEve(Key: Word): String;
   Class function fChamaCadCnd(Key: Word): String;
   Class function fChamaCadFpg(Key: Word): String;
   Class function fChamaCadIte(Key: Word; strCodIte: String = ''): String;
   Class function fChamaCadBan(Key: Word): String;
   Class function fChamaCadAdqCartao(Key: Word): String;
   Class function fChamaCadDep(Key: Word): String;
   Class function fChamaCorVei(Key: Word): String;
   Class function fChamaModVei(Key: Word): String;
   Class function fChamaMarVei(Key: Word): String;
   Class function fChamaTipSer(Key: Word): String;
   Class function fChamaCadRed(Key: Word): String;
   Class function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
   Class function fChamaCadFor(Key: Word; strCodFor: String = ''): String;
   Class function fChamaCadOco(Key: Word): String;
   Class function fChamaCadDiv(Key: Word): String;
   Class function fChamaCadAce(Key: Word): String;
   Class function fChamaCadPag(Key: Word): String;
   Class function fChamaTipCli(Key: Word): String;
   Class function fChamaCadEqu(Key: Word): String;
   Class function fChamaCadDfe(Key: Word): String;
   Class function fChamaCadSubReg(Key: Word): String;
   Class function fChamaCadGrupoPrecos(Key: Word): String;
   Class function fChamaCadGrupoProdutos(Key: Word): String;
   Class function fChamaCadNcm(Key: Word): String;
   Class function fChamaCadAbreviacaoPIS(Key: Word): String;
   Class function fChamaCadAbreviacaoIPI(Key: Word): String;
   Class function fChamaCadAbreviacaoCOFINS(Key: Word): String;
   Class function fChamaCadClassificacaoOnu(Key: Word): String;
   Class function fChamaCadGruCompra(Key: Word): String;
   Class function fChamaCadLocFisAmostraProducao(key: Word): String;
   Class function fChamaCadGruSer(Key: Word): String;
   Class function fChamaCadEmbarcacoes(Key: Word): String;
   Class function fChamaCadLocFisica(Key: Word): String;
   Class function fChamaCadGpc(Key: Word): String;
   Class function fChamaCadFun(Key: Word): String;
   Class function fChamaCadAcessorio(Key: Word): String;
   Class function fChamaCadProspecto(Key: Word): String;
   Class function fChamaCadCNAE(Key: Word): String;
   Class function fChamaCadAbreviacaoFiscal(strCodAbf: String): String;
   Class function fChamaCadLocFisicaConsertoEquip(Key: Word): String;
End;

Type
  TObjFuncIns = class(TInterfacedObject, IFuncIns)
  private
    function fChamaCadReg(Key: Word; strCodReg: String = ''): String;
    function fChamaCadTri(Key: Word): String;
    function fChamaCadMar(Key: Word): String;
    function fChamaCadUni(Key: Word): String;
    function fChamaCadGru(Key: Word): String;
    function fChamaCadEmp(Key: Word): String;
    function fChamaCadCli(Key: Word): String;
    function fChamaCadTra(Key: Word; strCodTra: String = ''): String;
    function fChamaCadMot(Key: Word; strCodMot: String = ''): String;
    function fChamaCadAju(Key: Word; strCodAju: String = ''): String;
    function fChamaCadPor(Key: Word): String;
    function fChamaCadBco(Key: Word): String;
    function fChamaCadCta(Key: Word): String;
    function fChamaCadCfo(Key: Word): String;
    function fChamaCadCar(Key: Word): String;
    function fChamaCadOpe(Key: Word): String;
    function fChamaCadEve(Key: Word): String;
    function fChamaCadCnd(Key: Word): String;
    function fChamaCadFpg(Key: Word): String;
    function fChamaCadIte(Key: Word; strCodIte: String = ''): String;
    function fChamaCadBan(Key: Word): String;
    function fChamaCadDep(Key: Word): String;
    function fChamaCorVei(Key: Word): String;
    function fChamaModVei(Key: Word): String;
    function fChamaMarVei(Key: Word): String;
    function fChamaTipSer(Key: Word): String;
    function fChamaCadRed(Key: Word): String;
    function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
    function fChamaCadFor(Key: Word; strCodFor: String = ''): String;
    function fChamaCadOco(Key: Word): String;
    function fChamaCadDiv(Key: Word): String;
    function fChamaCadAce(Key: Word): String;
    function fChamaCadPag(Key: Word): String;
    function fChamaTipCli(Key: Word): String;
    function fChamaCadEqu(Key: Word): String;
    function fChamaCadDfe(Key: Word): String;
    function fChamaCadSubReg(Key: Word): String;
    function fChamaCadLocFisAmostraProducao(key: Word): String;
    function fChamaCadGruSer(Key: Word): String;
    function fChamaCadEmbarcacoes(Key: Word): String;
    function fChamaCadLocFisica(Key: Word): String;
    function fChamaCadFun(Key: Word): String;
    function fChamaCadAcessorio(Key: Word): String;
    function fChamaCadAbreviacaoFiscal(strCodAbf: String): String;
    function fChamaCadLocFisicaConsertoEquip(Key: Word): String;
End;


  function fChamaCadReg(Key: Word; strCodReg: String = ''): String;
  function fChamaCadTri(Key: Word): String;
  function fChamaCadMar(Key: Word): String;
  function fChamaCadUni(Key: Word): String;
  function fChamaCadGru(Key: Word): String;
  function fChamaCadEmp(Key: Word): String;
  function fChamaCadCli(Key: Word): String;
  function fChamaCadTra(Key: Word; strCodTra: String = ''): String;
  function fChamaCadMot(Key: Word; strCodMot: String = ''): String;
  function fChamaCadAju(Key: Word; strCodAju: String = ''): String;
  function fChamaCadPor(Key: Word): String;
  function fChamaTipPrj(Key: Word): String;
  function fChamaCadBco(Key: Word): String;
  function fChamaCadCta(Key: Word): String;
  function fChamaCadCfo(Key: Word): String;
  function fChamaCadCar(Key: Word): String;
  function fChamaCadOpe(Key: Word): String;
  function fChamaCadEve(Key: Word): String;
  function fChamaCadCnd(Key: Word): String;
  function fChamaCadFpg(Key: Word): String;
  function fChamaCadIte(Key: Word; strCodIte: String = ''): String;
  function fChamaCadBan(Key: Word): String;
  function fChamaCadAdqCartaoFunc(Key: Word): String;
  function fChamaCadDep(Key: Word): String;
  function fChamaCorVei(Key: Word): String;
  function fChamaModVei(Key: Word): String;
  function fChamaMarVei(Key: Word): String;
  function fChamaTipSer(Key: Word): String;
  function fChamaCadRed(Key: Word): String;
  function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
  function fChamaCadFor(Key: Word): String;
  function fChamaCadOco(Key: Word): String;
  function fChamaCadDiv(Key: Word): String;
  function fChamaCadAce(Key: Word): String;
  function fChamaCadPag(Key: Word): String;
  function fChamaTipCli(Key: Word): String;
  function fChamaCadEqu(Key: Word): String;
  function fChamaCadDfe(Key: Word): String;
  function fChamaCadSubReg(Key: Word): String;
  function fChamaCadLocFisAmostraProducao(key: Word): String;
  function fChamaCadGruSer(Key: Word): String;
  function fChamaCadEmbarcacoes(Key: Word): String;
  function fChamaCadLocFisica(Key: Word): String;
  function fChamaCadGpc(Key: Word): String;
  function fChamaCadFun(Key: Word): String;
  function fChamaCadAcessorio(Key: Word): String;
  function fChamaCadProspecto(Key: Word): String;
  function fChamaCadCNAE(Key: Word): String;
  function fChamaCadGrupoPrecos(Key: Word): String;
  function fChamaCadLocFisicaConsertoEquip(Key: Word): String;

implementation

uses untCadSitTributarias, untCadMarcas,untCadUnidades,
     untCadGrupos,untCadEmpresas, untCadClientes, untCadPortadores,untCadTiposProjeto, untCadBancos,
     untCadCentroCusto, untCadClassFiscal, untCadCartoes, untCadTipSer,
     untCadCorVei, untCadMarVei, untFuncoesSimples, untCadModVei, untCadOperadores, untCadEventos,
     untCadCondicoes, untCadFormaPagamento, untFuncIns2, untCadProdutos, untCadRegioes,
     untCadBandeiras, untCadAdquirenteCartao, untCadDepartamentos, untCadRedeLojas, untCadVeiculos,
     untCadFornecedores, untCadOcorrencias, untCadSubRegiao, untCadDiversos,
     untCadCanaldeAcesso, untCadGrupoPrecos, untCadGrupoProdutos, untCadAbreviacaoPIS,
     untCadAbreviacaoIPI, untCadAbreviacaoCOFINS, untCadClassificacaoOnu, untCadNCM,
     untCadGruCompras, untCadTiposCliente, untCadEquipamentos, untCadDefeitos,
     untCadLocFisAmostraProducao, untCadGrupoServicos, untCadCtaResultados,
     untCadEmbarcacoes, untCadLocFisica, untCadTransportadoras, untCadMotoristas, untCadAjudantes,
     untCadGPC, untCadFuncoes, untCadAcessorios, untCadProspectos, untCadCna, untCadAbreviacaoFiscal,
     untCadLocFisicaConsertoEquip;

{*****************************************}
{* CADASTRO DE REGIOES                   *}
{**************************************MV*}
Class function TFuncIns.fChamaCadReg(Key: Word; strCodReg: String = ''): String;
var
  frmCadRegioes: TfrmCadRegioes;
begin
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadRegioes') Then
    Begin
      Try
        pCriarFormularios(TfrmCadRegioes, frmCadRegioes);
        frmCadRegioes.strCodRegiaoIniciarCadastro := strCodReg;
        frmCadRegioes.ShowModal;
        Result := frmCadRegioes.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmCadRegioes);
    End
    Else
      fMensagem('','Sem permissão para Cadastro de Regiões!',['&Ok']);
  End;
end;

class function TFuncIns.fChamaCadRes(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCtaResultados') Then
    Result := fChamaForm(Key, TfrmCadCtaResultados)
  Else
    fMensagem('','Sem permissão para Cadastro de Contas de Resultado!',['&Ok']);
end;

Class function TFuncIns.fChamaCadSubReg(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadSubRegiao') Then
    Result := fChamaForm(Key, TfrmCadSubRegiao)
  Else
    fMensagem('','Sem permissão para Cadastro de Sub-Região!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE SITUAÇÃO TRIBUTARIA       *}
{**************************************MV*}
Class function TFuncIns.fChamaCadTri(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadSitTributarias') Then
    Result := fChamaForm(Key, TfrmCadSitTributarias)
  Else
    fMensagem('','Sem permissão para Cadastro de Situação Tributária!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE MARCAS                    *}
{**************************************MV*}
Class function TFuncIns.fChamaCadMar(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadMarcas') Then
    Result := fChamaForm(Key, TfrmCadMarcas)
  Else
    fMensagem('','Sem permissão para Cadastro de Marcas!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE UNIDADES                  *}
{**************************************MV*}
Class function TFuncIns.fChamaCadUni(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadUnidades') Then
    Result := fChamaForm(Key, TfrmCadUnidades)
  Else
    fMensagem('','Sem permissão para Cadastro de Unidades!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE GRUPOS                    *}
{**************************************MV*}
class function TFuncIns.fChamaCadGpc(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadGPC') Then
    Result := fChamaForm(Key, TfrmCadGPC, frmCadGPC)
  Else
    fMensagem('','Sem permissão para Cadastro de Classificação Global do Produto - GPC!',['&Ok']);
end;

Class function TFuncIns.fChamaCadGru(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadGrupos') Then
    Result := fChamaForm(Key, TfrmCadGrupos)
  Else
    fMensagem('','Sem permissão para Cadastro de Grupos!',['&Ok']);
end;

class function TFuncIns.fChamaCadGruCompra(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadGruCompras') Then
    Result := fChamaForm(Key, TfrmCadGruCompras)
  Else
    fMensagem('','Sem permissão para Cadastro de Grupo de Compras',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE EMPRESA                   *}
{**************************************MV*}
class function TFuncIns.fChamaCadEmbarcacoes(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadEmbarcacoes') Then
    Result := fChamaForm(Key, TfrmCadEmbarcacoes)
  Else
    fMensagem('','Sem permissão para Cadastro de Embarcações!',['&Ok']);
end;

Class function TFuncIns.fChamaCadEmp(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadEmpresas') Then
    Result := fChamaForm(Key, TfrmCadEmpresas)
  Else
    fMensagem('','Sem permissão para Cadastro de Empresas!',['&Ok']);
end;

class function TFuncIns.fChamaCadEqu(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadEquipamentos') Then
    Result := fChamaForm(Key, TfrmCadEquipamentos)
  Else
    fMensagem('','Sem permissão para Cadastro de Equipamentos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CLIENTES                  *}
{**************************************MV*}
Class function TFuncIns.fChamaCadCli(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado) Then
    Result := fChamaForm(Key, TfrmCadClientes, frmCadClientes)
  Else
    fMensagem('','Sem permissão para Cadastro de Clientes!',['&Ok']);
end;

class function TFuncIns.fChamaCadCNAE(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCna') Then
    Result := fChamaForm(Key, TfrmCadCna)
  Else
    fMensagem('','Sem permissão para Cadastro de Classificação Nacional de Atividades Econômicas (CNAE)!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE TRANSPORTADORAS           *}
{**************************************MV*}
Class function TFuncIns.fChamaCadTra(Key: Word; strCodTra: String = ''): String;
var
  frmCadTransportadoras: TfrmCadTransportadoras;
begin
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadTransportadoras') Then
    Begin
      Try
        pCriarFormularios(TfrmCadTransportadoras, frmCadTransportadoras);
        frmCadTransportadoras.strCodTransportadoraIniciarCadastro := strCodTra;
        frmCadTransportadoras.ShowModal;
        Result := frmCadTransportadoras.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmCadTransportadoras);
    End
    Else
      fMensagem('','Sem permissão para acessar o cadastro de transportadoras',['&Ok']);
  End;
end;

{*****************************************}
{* CADASTRO DE MOTORISTAS                *}
{**************************************MV*}
Class function TFuncIns.fChamaCadMot(Key: Word; strCodMot: String = ''): String;
var
  frmCadMotoristas: TfrmCadMotoristas;
begin
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadMotoristas') Then
    Begin
      Try
        pCriarFormularios(TfrmCadMotoristas, frmCadMotoristas);
        frmCadMotoristas.strCodMotoristaIniciarCadastro := strCodMot;
        frmCadMotoristas.ShowModal;
        Result := frmCadMotoristas.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmCadMotoristas);
    End
    Else
      fMensagem('','Sem permissão para acessar o cadastro de motoristas',['&Ok']);
  End;
end;


{*****************************************}
{* CADASTRO DE AJUDANTES                 *}
{**************************************MV*}
Class function TFuncIns.fChamaCadAju(Key: Word; strCodAju: String = ''): String;
var
  frmCadAjudantes: TfrmCadAjudantes;
begin
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadAjudantes') Then
    Begin
      Try
        pCriarFormularios(TfrmCadAjudantes, frmCadAjudantes);
        frmCadAjudantes.strCodAjudanteIniciarCadastro := strCodAju;
        frmCadAjudantes.ShowModal;
        Result := frmCadAjudantes.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmCadAjudantes);
    End
    Else
      fMensagem('','Sem permissão para acessar o cadastro de ajudantes',['&Ok']);
  End;
end;

{*****************************************}
{* CADASTRO DE PORTADORES                *}
{**************************************MV*}
Class function TFuncIns.fChamaCadPor(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadPortadores') Then
    Result := fChamaForm(Key, TfrmCadPortadores)
  Else
    fMensagem('','Sem permissão para Cadastro de Portadores!',['&Ok']);
end;

{*****************************************}
{* CADASTRO PROSPECTO                    *}
{*****************************************}
class function TFuncIns.fChamaCadProspecto(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadProspectos') Then
    Result := fChamaForm(Key, TfrmCadProspectos)
  Else
    fMensagem('','Sem permissão para Cadastro de Prospecto!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE BANCOS                    *}
{**************************************MV*}
Class function TFuncIns.fChamaCadBco(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadBancos') Then
    Result := fChamaForm(Key, TfrmCadBancos)
  Else
    fMensagem('','Sem permissão para Cadastro de Bancos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CENTRO DE CUSTO           *}
{**************************************MV*}
Class function TFuncIns.fChamaCadCta(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCentroCusto') Then
    Result := fChamaForm(Key, TfrmCadCentroCusto)
  Else
    fMensagem('','Sem permissão para Cadastro de Plano de Conta!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CLASSIFICAÇÃO FISCAL      *}
{**************************************MV*}
Class function TFuncIns.fChamaCadCfo(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadClassFiscal') Then
    Result := fChamaForm(Key, TfrmCadClassFiscal)
  Else
    fMensagem('','Sem permissão para Cadastro de Classificação Fiscal!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CARTÕES                   *}
{**************************************MV*}
Class function TFuncIns.fChamaCadCar(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCartoes') Then
    Result := fChamaForm(Key, TfrmCadCartoes)
  Else
    fMensagem('','Sem permissão para Cadastro de Cartões!',['&Ok'])
end;

{*****************************************}
{* CADASTRO DE OPERADORES                *}
{**************************************MV*}
Class function TFuncIns.fChamaCadOpe(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadOperadores') Then
    Result := fChamaForm(Key, TfrmCadOperadores)
  Else
    fMensagem('','Sem permissão para Cadastro de Operadores!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE EVENTOS                   *}
{**************************************LB*}
Class function TFuncIns.fChamaCadEve(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadEventos') Then
    Result := fChamaForm(Key, TfrmCadEventos)
  Else
    fMensagem('','Sem permissão para Cadastro de Centro de Custos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE BANDEIRAS                 *}
{**************************************LA*}
Class function TFuncIns.fChamaCadBan(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadBandeiras') Then
    Result := fChamaForm(Key, TfrmCadBandeiras)
  Else
    fMensagem('','Sem permissão para Cadastro de Bandeiras de Cartão de Crédito!',['&Ok']);
end;

Class function TFuncIns.fChamaCadAdqCartao(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadAdquirenteCartao') Then
    Result := fChamaForm(Key, TfrmCadAdquirenteCartao)
  Else
    fMensagem('','Sem permissão para Cadastro de Adquirentes de Cartão de Crédito!',['&Ok']);
end ;

{*****************************************}
{* CADASTRO DE DEPARTAMENTOS             *}
{**************************************RV*}
Class function TFuncIns.fChamaCadDep(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadDepartamentos') Then
    Result := fChamaForm(Key, TfrmCadDepartamentos)
  Else
    fMensagem('','Sem permissão para Cadastro de Departamentos!',['&Ok']);
end;

class function TFuncIns.fChamaCadDfe(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadDefeitos') Then
    Result := fChamaForm(Key, TfrmCadDefeitos)
  Else
    fMensagem('','Sem permissão para Cadastro de Defeitos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CORES DE VEICULOS         *}
{**************************************RV*}
Class function TFuncIns.fChamaCorVei(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCorVei') Then
    Result := fChamaForm(Key, TfrmCadCorVei)
  Else
    fMensagem('','Sem permissão para Cadastro de Cores de Veículos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE MODELOS DE VEICULOS       *}
{**************************************RV*}
Class function TFuncIns.fChamaModVei(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadModVei') Then
    Result := fChamaForm(Key, TfrmCadModVei)
  Else
    fMensagem('','Sem permissão para Cadastro de Modelos de Veículos!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE MARCAS DE VEICULOS        *}
{**************************************RV*}
Class function TFuncIns.fChamaMarVei(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadMarVei') Then
    Result := fChamaForm(Key, TfrmCadMarVei)
  Else
    fMensagem('','Sem permissão para Cadastro de Marcas de Veículos!',['&Ok']);
end;

Class function TFuncIns.fChamaTipSer(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadTipSer') Then
    Result := fChamaForm(Key, TfrmCadTipSer)
  Else
    fMensagem('','Sem permissão para Cadastro de Tipos de Serviço!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE CONDICOES                 *}
{**************************************MA*}
Class function TFuncIns.fChamaCadCnd(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadCondicoes') Then
    Result := fChamaForm(Key, TfrmCadCondicoes)
  Else
    fMensagem('','Sem permissão para Cadastro de Condições de Pagamento!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE FORMAS DE PAGAMENTO       *}
{**************************************MA*}
Class function TFuncIns.fChamaCadFpg(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadFormaPagamento') Then
    Result := fChamaForm(Key, TfrmCadFormaPagamento)
  Else
    fMensagem('','Sem permissão para Cadastro de Formas de Pagamento!',['&Ok']);
end;

class function TFuncIns.fChamaCadFun(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadFuncoes') Then
    Result := fChamaForm(Key, TfrmCadFuncoes, frmCadFuncoes)
  Else
    fMensagem('','Sem permissão para Cadastro de Funções!',['&Ok']);
end;

{*****************************************}
{* CADASTRO DE PRODUTOS                  *}
{**************************************AF*}
Class function TFuncIns.fChamaCadIte(Key: Word; strCodIte: String = ''): String;
begin
  If fVerificaAcessoSistema('frmCadProdutos') Then
  Begin
    pCriarFormularios(TfrmCadProdutos, frmCadProdutos);
      try
        Try
          {frmCadProdutos.fMskCon := fMskCon;
          frmCadProdutos.fSemMascaraPlaNco := fSemMascaraPlaNco;
          frmCadProdutos.fPesqPlanoContabil := fPesqPlanoContabil;
          frmCadProdutos.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
          frmCadProdutos.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa; }
          If strCodIte <> '' then
            frmCadProdutos.fCarregaProdutoExterno(strCodIte, frmCadProdutos)
          Else
            frmCadProdutos.showModal;

          if frmCadProdutos.strCodIteExterno.isEmpty Then
            Result := strCodIte
          else
            Result := frmCadProdutos.strCodIteExterno;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[fChamaCadIte]');
          End;
        End;
      finally
        pFreeAndNil(frmCadProdutos);
      end;
  End
  Else
  Begin
    fMensagem('','Sem permissão para Cadastro de Produtos!',['&Ok']);
  End;
end;

class function TFuncIns.fChamaCadLocFisica(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadLocFisica') Then
    Result := fChamaForm(Key, TfrmCadLocFisica)
  Else
    fMensagem('','Sem permissão para Cadastro de Localização Física!',['&Ok']);
end;

class function TFuncIns.fChamaCadLocFisicaConsertoEquip(Key: Word): String;
begin
  if fVerificaAcessoSistema('frmCadLocFisicaConsertoEquip') then
    Result := fChamaForm(Key, TfrmCadLocFisicaConsertoEquip)
  else
    fMensagem('', 'Sem permissão para Cadastro de Localização Física - Conserto Equipamen',['&Ok']);
end;

class function TFuncIns.fChamaCadLocFisAmostraProducao(key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadLocFisAmostraProducao') Then
    Result := fChamaForm(Key, TfrmCadLocFisAmostraProducao)
  Else
    fMensagem('','Sem permissão para Cadastro de localização física de amostra de produção!',['&Ok']);
end;

{******************************}
{* CADASTRO DE REDES DE LOJAS *}
{***************************JU*}
Class function TFuncIns.fChamaCadRed(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadRedeLojas') Then
    Result := fChamaForm(Key, TfrmCadRedeLojas)
  Else
    fMensagem('','Sem permissão para Cadastro de Redes de Lojas',['&Ok']);
End;

Class function TFuncIns.fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
  Var
    frmCadVeiculos: TfrmCadVeiculos;
begin
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadVeiculos') Then
    Begin
      Try
        pCriarFormularios(TfrmCadVeiculos, frmCadVeiculos);
        frmCadVeiculos.strPlacaVeiculoIniciarCadastro := strPlaVei;
        frmCadVeiculos.ShowModal;
        Result := frmCadVeiculos.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmCadVeiculos);
    End
    Else
      fMensagem('','Sem permissão para acessar o cadastro de veículos',['&Ok']);
  End;
end;

{**************************}
{* CADASTRO DE FORNECEDOR *}
{***********************MM*}
Class function TFuncIns.fChamaCadFor(Key: Word; strCodFor: String): String;
Begin
  Result := '';
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadFornecedores') Then
    begin

      pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
      try
        Try
          frmCadFornecedores.fMskCon := fMskCon;
          frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
          frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
          frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
          frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
          frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
          frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
          frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
          frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
          frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
          frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
          frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
          If strCodFor <> '' then
            frmCadFornecedores.fCarregaFornecedorExterno(strCodFor, frmCadFornecedores)
          Else
            frmCadFornecedores.showModal;

          if frmCadFornecedores.strCodForExterno = '' Then
            Result := strCodFor
          else
            Result := frmCadFornecedores.strCodForExterno;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[fChamaCadFor]');
          End;
        End;
      finally
        frmCadFornecedores.fMskCon := Nil;
        frmCadFornecedores.fSemMascaraPlaNco := Nil;
        frmCadFornecedores.fPesqPlanoContabil := Nil;
        frmCadFornecedores.pPlanoDeContasPorEmpresa := Nil;
        frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := Nil;
        frmCadFornecedores.pGravarPlanoContasAutomatico := Nil;
        frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := Nil;
        frmCadFornecedores.fCadastroRapidoCliente := Nil;
        frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
        frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
        frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
        frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
        pFreeAndNil(frmCadFornecedores);
      end;
    end
    else
      fMensagem('','Sem permissão para Cadastro de Fornecedores',['&Ok']);
  End;

End;

Class function TFuncIns.fChamaCadDiv(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadDiversos') Then
    Result := fChamaForm(Key, TfrmCadDiversos)
  Else
    fMensagem('','Sem permissão para Cadastro de Diversos',['&Ok']);
End;

Class function TFuncIns.fChamaCadAce(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadCanaldeAcesso') Then
    Result := fChamaForm(Key, TfrmCadCanaldeAcesso)
  Else
    fMensagem('','Sem permissão para Cadastro de Canal de Acesso',['&Ok']);
End;

class function TFuncIns.fChamaCadAcessorio(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadAcessorios') Then
    Result := fChamaForm(Key, TfrmCadAcessorios)
  Else
    fMensagem('','Sem permissão para Cadastro de Acessórios!',['&Ok']);
end;

Class function TFuncIns.fChamaCadPag(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadCondicoes') Then
    Result := fChamaForm(Key, TfrmCadCondicoes)
  Else
    fMensagem('','Sem permissão para Cadastro de Condição de Pagamento',['&Ok']);
End;

Class function TFuncIns.fChamaTipCli(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadTiposCliente') Then
    Result := fChamaForm(Key, TfrmCadTiposCliente)
  Else
    fMensagem('','Sem permissão para Cadastro de Tipos de Cliente',['&Ok']);
End;

class function TFuncIns.fChamaTipPrj(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadTipoProjeto') Then
    Result := fChamaForm(Key, TfrmCadTiposProjeto, frmCadTiposProjeto)
  Else
    fMensagem('','Sem permissão para Cadastro de Tipos de Projeto!',['&Ok']);
end;

{**************************}
{* CADASTRO DE OCORRENCIA *}
{***********************MM*}
Class function TFuncIns.fChamaCadOco(Key: Word): String;
  Var
    frmCadOcorrencias: TfrmCadOcorrencias;
Begin
  If fVerificaAcessoSistema('frmCadOcorrencias') And fIsInsert(Key) Then
  Begin
    Try
      Try
        pCriarFormularios(TfrmCadOcorrencias, frmCadOcorrencias);
        frmCadOcorrencias.ShowModal;
        Result := frmCadOcorrencias.strUltimoCodigo;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    Finally
      pFreeAndNil(frmCadOcorrencias);
    End;
  End
  Else
    fMensagem('','Sem permissão para Cadastro de Ocorrências',['&Ok']);
end;

Class function TFuncIns.fChamaCadGrupoPrecos(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadGrupoPrecos') Then
    Result := fChamaForm(Key, TfrmCadGrupoPrecos)
  Else
    fMensagem('','Sem permissão para Cadastro de Grupo de Preços',['&Ok']);
End;

Class function TFuncIns.fChamaCadGrupoProdutos(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadGrupoProdutos') Then
    Result := fChamaForm(Key, TfrmCadGrupoProdutos)
  Else
    fMensagem('','Sem permissão para Cadastro de Grupo de Produtos',['&Ok']);
End;

Class function TFuncIns.fChamaCadNcm(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadNCM') Then
    Result := fChamaForm(Key, TfrmCadNCM)
  Else
    fMensagem('','Sem permissão para Cadastro de Nomenclatura Comum do Mercosul (NCM)',['&Ok']);
end;

Class function TFuncIns.fChamaCadAbreviacaoPIS(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadAbreviacaoPIS') Then
    Result := fChamaForm(Key, TfrmCadAbreviacaoPIS)
  Else
    fMensagem('','Sem permissão para Cadastro de Abreviação de PIS',['&Ok']);
End;

class function TFuncIns.fChamaCadAbreviacaoFiscal(strCodAbf: String): String;
Var
  frmCadAbreviacaoFiscal: TfrmCadAbreviacaoFiscal;
begin
  If fVerificaAcessoSistema('frmCadAbrevFiscal') Then
  begin
    pCriarFormularios(TfrmCadAbreviacaoFiscal, frmCadAbreviacaoFiscal);
    Try
      frmCadAbreviacaoFiscal.strAbrExterna := strCodAbf;
      frmCadAbreviacaoFiscal.Showmodal;
    Finally
      FreeAndNil(frmCadAbreviacaoFiscal)
    End;
  End
  Else
    fMensagem('','Sem permissão para Cadastro de Fiscal',['&Ok']);

end;

Class function TFuncIns.fChamaCadAbreviacaoIPI(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadAbreviacaoIPI') Then
    Result := fChamaForm(Key, TfrmCadAbreviacaoIPI)
  Else
    fMensagem('','Sem permissão para Cadastro de Abreviação de IPI',['&Ok']);
End;

Class function TFuncIns.fChamaCadAbreviacaoCOFINS(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadAbreviacaoCOFINS') Then
    Result := fChamaForm(Key, TfrmCadAbreviacaoCOFINS)
  Else
    fMensagem('','Sem permissão para Cadastro de Abreviação de IPI',['&Ok']);
End;

Class function TFuncIns.fChamaCadClassificacaoOnu(Key: Word): String;
Begin
  If fVerificaAcessoSistema('frmCadClassificacaoOnu') Then
    Result := fChamaForm(Key, TfrmCadClassificacaoOnu)
  Else
    fMensagem('','Sem permissão para Cadastro da Classificação ONU',['&Ok']);
End;

{*****************************************}
{* CADASTRO DE GRUPO DE SERVIÇOS         *}
{**************************************DF*}
Class function TFuncIns.fChamaCadGruSer(Key: Word): String;
begin
  If fVerificaAcessoSistema('frmCadGrupoServicos') Then
    Result := fChamaForm(Key, TfrmCadGrupoServicos)
  Else
    fMensagem('','Sem permissão para Cadastro de Grupos de Serviços!',['&Ok']);
end;

// Chamadas para Manter a Compatibilidade;

function fChamaCadReg(Key: Word; strCodReg: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadReg(Key, strCodReg);
End;

function fChamaCadTri(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadTri(Key);
End;

function fChamaCadMar(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadMar(Key);
End;

function fChamaCadUni(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadUni(Key);
End;

function fChamaCadGru(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadGru(Key);
End;

function fChamaCadEmp(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEmp(Key);
End;

function fChamaCadCli(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCli(Key);
End;

function fChamaCadTra(Key: Word; strCodTra: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadTra(Key, strCodTra);
End;

function fChamaCadMot(Key: Word; strCodMot: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadMot(Key, strCodMot);
End;

function fChamaCadAju(Key: Word; strCodAju: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadAju(Key, strCodAju);
End;

function fChamaCadPor(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadPor(Key);
End;

function fChamaTipPrj(Key: Word): String;
Begin
  Result := TFuncIns.fChamaTipPrj(Key);
End;

function fChamaCadBco(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadBco(Key);
End;

function fChamaCadCta(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCta(Key);
End;

function fChamaCadCfo(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCfo(Key);
End;

function fChamaCadCar(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCar(Key);
End;

function fChamaCadOpe(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadOpe(Key);
End;

function fChamaCadEve(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEve(Key);
End;

function fChamaCadCnd(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCnd(Key);
End;

function fChamaCadFpg(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadFpg(Key);
End;

function fChamaCadIte(Key: Word; strCodIte: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadIte(Key, strCodIte);
End;

function fChamaCadBan(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadBan(Key);
End;

function fChamaCadAdqCartaoFunc(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadAdqCartao(Key);
end ;

function fChamaCadDep(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDep(Key);
End;

function fChamaCorVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCorVei(Key);
End;

function fChamaModVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaModVei(Key);
End;

function fChamaMarVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaMarVei(Key);
End;

function fChamaTipSer(Key: Word): String;
Begin
  Result := TFuncIns.fChamaTipSer(Key);
End;

function fChamaCadRed(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadRed(Key);
End;

function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadVei(Key, strPlaVei);
End;

function fChamaCadFor(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadFor(Key);
End;

function fChamaCadOco(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadOco(Key);
End;

function fChamaCadDiv(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDiv(Key);
End;

function fChamaCadAce(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadAce(Key);
End;

function fChamaCadPag(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadPag(Key);
End;

function fChamaTipCli(Key: Word): String;
Begin
  Result := TFuncIns.fChamaTipCli(Key);
End;

function fChamaCadEqu(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEqu(Key);
End;

function fChamaCadDfe(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDfe(Key);
End;

function fChamaCadSubReg(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadSubReg(Key);
End;

function fChamaCadLocFisAmostraProducao(key: Word): String;
Begin
  Result := TFuncIns.fChamaCadLocFisAmostraProducao(key);
End;

function fChamaCadGruSer(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadGruSer(Key);
End;

function fChamaCadEmbarcacoes(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEmbarcacoes(Key);
End;

function fChamaCadLocFisica(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadLocFisica(Key);
End;

function fChamaCadFun(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadFun(Key);
end;

function fChamaCadAcessorio(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadAcessorio(Key);
end;

function fChamaCadProspecto(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadProspecto(Key);
End;

function fChamaCadCNAE(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCNAE(Key);
End;

function fChamaCadLocFisicaConsertoEquip(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadLocFisicaConsertoEquip(Key);
end;

{ TObjFuncIns }

function TObjFuncIns.fChamaCadReg(Key: Word; strCodReg: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadReg(Key, strCodReg);
End;

function TObjFuncIns.fChamaCadTra(Key: Word; strCodTra: String = ''): String;
begin
  Result := TFuncIns.fChamaCadTra(Key, strCodTra);
end;

function TObjFuncIns.fChamaCadMot(Key: Word; strCodMot: String = ''): String;
begin
  Result := TFuncIns.fChamaCadMot(Key, strCodMot);
end;

function TObjFuncIns.fChamaCadAcessorio(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadAcessorio(Key);
end;

function TObjFuncIns.fChamaCadAju(Key: Word; strCodAju: String = ''): String;
begin
  Result := TFuncIns.fChamaCadAju(Key, strCodAju);
end;

function TObjFuncIns.fChamaCadTri(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadTri(Key);
End;

function TObjFuncIns.fChamaCadMar(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadMar(Key);
End;

function TObjFuncIns.fChamaCadUni(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadUni(Key);
End;

function TObjFuncIns.fChamaCadGru(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadGru(Key);
End;

function TObjFuncIns.fChamaCadEmp(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEmp(Key);
End;

function TObjFuncIns.fChamaCadCli(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCli(Key);
End;

function TObjFuncIns.fChamaCadPor(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadPor(Key);
End;

function TObjFuncIns.fChamaCadBco(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadBco(Key);
End;

function TObjFuncIns.fChamaCadCta(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCta(Key);
End;

function TObjFuncIns.fChamaCadCfo(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCfo(Key);
End;

function TObjFuncIns.fChamaCadCar(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCar(Key);
End;

function TObjFuncIns.fChamaCadOpe(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadOpe(Key);
End;

function TObjFuncIns.fChamaCadEve(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEve(Key);
End;

function TObjFuncIns.fChamaCadCnd(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadCnd(Key);
End;

function TObjFuncIns.fChamaCadFpg(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadFpg(Key);
End;

function TObjFuncIns.fChamaCadFun(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadFun(Key);
end;

function TObjFuncIns.fChamaCadIte(Key: Word; strCodIte: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadIte(Key, strCodIte);
End;

function TObjFuncIns.fChamaCadBan(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadBan(Key);
End;

function TObjFuncIns.fChamaCadDep(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDep(Key);
End;

function TObjFuncIns.fChamaCorVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCorVei(Key);
End;

function TObjFuncIns.fChamaModVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaModVei(Key);
End;

function TObjFuncIns.fChamaMarVei(Key: Word): String;
Begin
  Result := TFuncIns.fChamaMarVei(Key);
End;

function TObjFuncIns.fChamaTipSer(Key: Word): String;
Begin
  Result := TFuncIns.fChamaTipSer(Key);
End;

function TObjFuncIns.fChamaCadRed(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadRed(Key);
End;

function TObjFuncIns.fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadVei(Key, strPlaVei);
End;

function TObjFuncIns.fChamaCadFor(Key: Word; strCodFor: String = ''): String;
Begin
  Result := TFuncIns.fChamaCadFor(Key, strCodFor);
End;

function TObjFuncIns.fChamaCadOco(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadOco(Key);
End;

function TObjFuncIns.fChamaCadDiv(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDiv(Key);
End;

function TObjFuncIns.fChamaCadAbreviacaoFiscal(strCodAbf: String): String;
begin
  Result := TFuncIns.fChamaCadAbreviacaoFiscal(strCodAbf);
end;

function TObjFuncIns.fChamaCadAce(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadAce(Key);
End;

function TObjFuncIns.fChamaCadPag(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadPag(Key);
End;

function TObjFuncIns.fChamaTipCli(Key: Word): String;
Begin
  Result := TFuncIns.fChamaTipCli(Key);
End;

function TObjFuncIns.fChamaCadEqu(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEqu(Key);
End;

function TObjFuncIns.fChamaCadDfe(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadDfe(Key);
End;

function TObjFuncIns.fChamaCadSubReg(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadSubReg(Key);
End;

function TObjFuncIns.fChamaCadLocFisAmostraProducao(key: Word): String;
Begin
  Result := TFuncIns.fChamaCadLocFisAmostraProducao(key);
End;

function TObjFuncIns.fChamaCadLocFisica(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadLocFisica(Key);
end;

function TObjFuncIns.fChamaCadLocFisicaConsertoEquip(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadLocFisicaConsertoEquip(Key);
end;

function TObjFuncIns.fChamaCadGruSer(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadGruSer(Key);
End;

function TObjFuncIns.fChamaCadEmbarcacoes(Key: Word): String;
Begin
  Result := TFuncIns.fChamaCadEmbarcacoes(Key);
End;

function fChamaCadGpc(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadGpc(Key);
end;

function fChamaCadGrupoPrecos(Key: Word): String;
begin
  Result := TFuncIns.fChamaCadGrupoPrecos(Key);
End;

End.

