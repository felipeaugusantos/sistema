unit untFuncFatTelasHelper;

interface

uses untFuncFat, untTypesSistema;

type
  TFuncFatTelasHelper = class helper for TFatVenda
  public
    procedure pVendasPorCliente(blnVenCli: Boolean; var intConfirmando: Integer;
      strCodCli, strNomCli: String; fIncluirItem: TfIncluiItem = nil);
  End;

implementation

uses untFuncoesSimples, Winapi.Windows, System.SysUtils, untRelFatVendasCliente;

{ TFuncFatTelasHelper }

procedure TFuncFatTelasHelper.pVendasPorCliente(blnVenCli: Boolean; var intConfirmando: Integer; strCodCli, strNomCli: String; fIncluirItem: TfIncluiItem = nil);
var
  frmRel: TfrmRelFatVendasCliente;
Begin
  If Not fVerificaAcessoSistema('VENCLF') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso em Vendas por Clientes!', ['&OK']);
    Exit;
  End;

  If fEmptyStr(strCodCli) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente.', ['&OK']);
    Exit;
  End
  Else If (fEmptyStr(fRetNomCliente(strCodCli))) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente válido!', ['&OK']);
    Exit;
  End;

  If (blnVenCli) Then
  Begin
    If Assigned(fIncluirItem) Or (InterlockedIncrement(intConfirmando) = 0) Then
    Begin
      Try
        Try
          pCriarFormularios(TfrmRelFatVendasCliente,frmRel);
          frmRel.blnFaturamento := True;
          frmRel.blnSenha := False;
          frmRel.blnVeioDoTelemarketing := False;
          frmRel.blnVeioDoTablet := False;
          frmRel.edtCodCliente.Text := strCodCli;
          frmRel.edtDesCliente.Text := strNomCli;
          frmRel.blnSomenteVendas := True;
          frmRel.blnVeioTelaVendas := True;
          frmRel.blnMosCom := True;
          frmRel.blnCliCons := fClienteConsumidor(strNomCli, False, True);
          frmRel.fIncluirItem := fIncluirItem;
          frmRel.blnDireitoTodasEmpresas := fVerificaAcessoSistema('mnuVendaClienteTodasEmpresas');
          frmRel.ShowModal;

          If Not Assigned(fIncluirItem) Then
            InterlockedDecrement(intConfirmando);
        Finally
          pFreeAndNil(frmRel);
        End;
      Except
        On E: Exception Do
        Begin
          If Not Assigned(fIncluirItem) Then
            InterlockedDecrement(intConfirmando);
          pMensagensErro(E.Message, '[pVendasPorCliente]');
        End;
      End;
    End
    Else
      If Not Assigned(fIncluirItem) Then
        InterlockedDecrement(intConfirmando);
  End;
end;

end.


