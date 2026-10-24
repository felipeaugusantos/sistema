unit untTelAcompEntregaEmail;

interface

Uses
  Uni,
  Controls, SysUtils, frxClass,
  DB, Windows, Forms,
  UniClientDataSet,
  System.Classes,
  untFatGeraPdfEmail;

procedure pEnviaEmail(strNumPed,
                      strEspPed,
                      strEmpPed,
                      strNumFat,
                      strEspFat,
                      strEmpFat,
                      strCliFat: String;
                      Handle: THandle);

implementation

uses untFuncoesSimples, untPesqAux, untDigEmail, untReimpressao,
  untTypesSistema, untTEnvioEmail;

function fGeraEmail(strNumPed,
                    strEspPed,
                    strEmpPed,
                    strNumFat,
                    strEspFat,
                    strEmpFat,
                    strCliFat: String;
                    Var strArqPdf: String;
                    blnVisualizar: Boolean = True): Boolean;
  Var
    reiReimpressao: TReimpressao;
    objPdfEma     : TPdfEma;
begin

  Result := False;

  Try
    strArqPdf := '';

    reiReimpressao := TReimpressao.Create(strNumFat,
                                          strEspFat,
                                          0,
                                          0,
                                          strCliFat,
                                          strEmpFat,
                                          '',
                                          True,
                                          'C',
                                          True,
                                          False,
                                          False,
                                          '',
                                          '',
                                          True,
                                          0,
                                          False,
                                          'V',
                                          True);

    objPdfEma := TPdfEma.Create(Nil);

    If Not reiReimpressao.objDocumentos.cdsDocumentos.IsEmpty Then
    Begin
      objPdfEma.setEdtFst(opcEmail);
      objPdfEma.setNumDoc(strNumFat);
      objPdfEma.setEspDoc(strEspFat);
      objPdfEma.setCodEmp(strEmpFat);
      objPdfEma.setVisual(blnVisualizar);
      objPdfEma.setPasPdf('Docs_Env_TeleAtendimento');

      objPdfEma.setReimpr(reiReimpressao);
      Result := objPdfEma.fReimprimeDocumento;

      If (Result) Then
        strArqPdf := reiReimpressao.strArqPDF;
    End;

  Finally
    FreeAndNil(reiReimpressao);
    FreeAndNil(objPdfEma);
  End;
end;

procedure pEnviaEmail(strNumPed,
                      strEspPed,
                      strEmpPed,
                      strNumFat,
                      strEspFat,
                      strEmpFat,
                      strCliFat: String;
                      Handle: THandle);
  Var
    qryGenCli : TUniQuery;
    strDestinatario     : String;
    strEmailDestinatario: String;
    blnConfirma : Boolean;
    strArqPdf   : String;
    strAssunto  : String;
    strTexto    : String;
    arrArquivos, arrDestinatarios : TStringArray;
begin

  If fEmptyStr(strNumPed) Then
    Exit;

  If fEmptyStr(strNumFat) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse pedido ainda não foi faturado!', ['&Ok']);
    Exit;
  End;

  Try

    Try
      pCriarFormularios(TfrmDigEmail, frmDigEmail);

      qryGenCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE');
      pPesquisaCadCli(qryGenCli, qryGenCli, strCliFat);
      frmDigEmail.edtEmail.Text   := qryGenCli.FieldByName('CLI_EMAIL_').AsString;
      frmDigEmail.edtContato.Text := qryGenCli.FieldByName('CLI_CONTAT').AsString;
      blnConfirma := (frmDigEmail.ShowModal = mrOk);
      FreeAndNil(qryGenCli);

      If (blnConfirma) Then
      Begin
        strDestinatario      := frmDigEmail.edtContato.Text;
        strEmailDestinatario := frmDigEmail.edtEmail.Text;
      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmTelAcompEntrega.btnEnviaEmailClick]');
      End;
    End;

    pFreeAndNil(frmDigEmail);

    If (Not blnConfirma) Then
    Begin
      Exit;
    End;

    If (Not fGeraEmail(strNumPed,
                       strEspPed,
                       strEmpPed,
                       strNumFat,
                       strEspFat,
                       strEmpFat,
                       strCliFat,
                       strArqPdf,
                       False)) Then
      Exit;

    {************************************************}
    {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
    {*********************************************LU*}
    If (Not fEmptyStr(strArqPdf)) And (FileExists(strArqPdf)) Then
    Begin
      strAssunto := fRetNomeEmpresa + ' - Documento: ' + strNumFat + '-' + strEspFat;
      strTexto := 'Segue documento em anexo.';

      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

      pCriarArrayAnexosEDestinatarios(strArqPdf, strEmailDestinatario, arrDestinatarios, arrArquivos);

      TEnvioEmail.EnviarEmail(Application.GetParentComponent(), strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);

      SetForegroundWindow(Handle);
    End
    Else
      fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[EnviaEmail]');
    End;
  End;
end;

end.
