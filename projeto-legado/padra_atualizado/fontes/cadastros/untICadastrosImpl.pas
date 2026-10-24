unit untICadastrosImpl;

interface

Uses untICadastros, Dialogs;

Type
  TCadastros = class(TInterfacedObject, ICadastros)
  Public
    procedure pChamaCadastroFornecedor;
    procedure pChamaCadastroCliente;
    procedure pChamaCadastroProspecto;
  End;

implementation

{ TCadastros }

uses untFuncoesSimples, untCadFornecedores, untCadClientes, untCadProspectos,
     Contabilidade.Funcoes, Contabilidade.Consultas, untCadTransportadoras;

procedure TCadastros.pChamaCadastroCliente;
  Var
    frm : TfrmCadClientes;
begin
  frm := Nil;
  If fVerificaAcessoSistema('frmCadClientes') Then
    pCriarForm(TfrmCadClientes, frm);
end;

procedure TCadastros.pChamaCadastroFornecedor;
begin
  If fVerificaAcessoSistema('frmCadFornecedores') Then
  Begin
    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
    try
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
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pFreeAndNil(frmCadFornecedores);
    end;
  End;
end;

procedure TCadastros.pChamaCadastroProspecto;
  Var
    frm : TfrmCadProspectos;
begin
  frm := Nil;
  If fVerificaAcessoSistema('frmCadProspectos') Then
    pCriarForm(TfrmCadProspectos, frm);
end;

end.
