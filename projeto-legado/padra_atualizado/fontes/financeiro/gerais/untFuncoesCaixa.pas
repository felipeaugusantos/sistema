unit untFuncoesCaixa;

interface

uses
  untRcxResumoCaixa,
  untFuncoesSimples,
  untTypesSistema,
  untLiberacao,
  System.SysUtils;

type
  TFuncoesCaixa = class
  private

  public
    class function fChamaTelaCaixa(strCodOpeCx: String; strCodCli: String): Boolean;
  End;

implementation

{ TFuncoesCaixa }

class function TFuncoesCaixa.fChamaTelaCaixa(strCodOpeCx: String; strCodCli: String): Boolean;
  Var
    dtaIniTmp,
    dtaFinTmp: TDate;
    crTela: TChamaRotina;
    frmRcxCaixa: TfrmRcxResumoCaixa;
    objLiberacao : TLiberacao;
begin
  Result := False;

  {*********************************************************************************}
  {* REQ.: 118299 DEVERIA TER SIDO FEITO ASSIM E NÃO O CONDICIONAL                 *}
  {* If StatusNegociacao = snRealizandoAdiantamento Then EM untFormaPagtoNegociada *}
  {* QUE REMOVI NESTE REQUISITO                                                    *}
  {******************************************************************REQ.:285165*VA*}
  If Not fVerificaAcessoSistema('DIRRCXREC', strCodOpeCx) Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Recebimentos (Consolidação de títulos em aberto antes da Utilização de Créditos)');

      objLiberacao.strDirAce := 'DIRRCXREC';
      objLiberacao.strSenLib := fCfgSis('RCXREC');
      objLiberacao.strMsgSen := 'Recebimentos';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strCodOpeCx;
      objLiberacao.strCodDig := strCodOpeCx;

      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
        Exit;
      End;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;

  pCriarFormularios(TfrmRcxResumoCaixa, frmRcxCaixa);
  Try
    Try
      If Not frmRcxCaixa.blnFecharForm Then
      Begin
        frmRcxCaixa.edtCodOpe.Text := strCodOpeCx;
        frmRcxCaixa.edtNomOpe.Text := fRetNomVendRep(strCodOpeCx);
        frmRcxCaixa.edtCodCli.Text := strCodCli;
        frmRcxCaixa.blnF11         := True;
        frmRcxCaixa.ShowModal;

        Result := Not fExisteCredComProfissionalDevMerc(strCodCli, dtaIniTmp, dtaFinTmp, crTela);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmPrincipal.mnuFatResumoCaixaClick]');
    End;
  Finally
    pFreeAndNil(frmRcxCaixa);
  End;
end;

end.
