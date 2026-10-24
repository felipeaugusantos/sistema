unit untTBaixaReceberEmail;

interface
Uses System.Classes, Data.DB, UniCLientDataset, untTypesSistema, System.SysUtils,
     cxProgressBar, untConstantes;

Type
  TBaixaReceberEmail = class
  private
    FDadosEmail: TDadosDisparaEmail;

    FStatusGrupo: TStatusDisparaEmail;

    function RetornaArrayDeDuplicatas(ADataset: TDataset): TArrDupTabelaEmail;

    class function ValidaEmailsValidosDoCliente(EmailCliente: String): Boolean;
  public
    constructor Create(ADadosEmail: TDadosDisparaEmail;
                       ADataset: TDataset;
                       AStatusGrupo: TStatusDisparaEmail); overload;

    class function DeveEnviarEmail(ASiglaGrupo: String;
                                   AStatusGrupo: TStatusDisparaEmail;
                                   AEmailCliente: String): Boolean;

    class function DeveEnviarSMS(ASiglaGrupo: String;
                                 AStatusGrupo: TStatusDisparaEmail;
                                 ACelularCliente: String): Boolean;

    class function DeveEnviarWhatsapp(ASiglaGrupo: String;
                                      AStatusGrupo: TStatusDisparaEmail;
                                      ACelularCliente: String): Boolean;

    class function PossuiAlgumModeloAEnviarPix(AEnviarEmail,
                                               AEnviarSMS,
                                               AEnviarWhatsapp: Boolean): Boolean;

    function EnviarEmailBaixaReceberPix(pgbProgresso: TcxProgressBar): Boolean;

    function EnviarSMSBaixaReceberPix(pgbProgresso: TcxProgressBar): Boolean;

    function EnviarWhatsappBaixaReceberPix(pgbProgresso: TcxProgressBar): Boolean;
  end;

implementation
Uses untDisparaEmailAut, untDisparaSmsAut, untFuncoesSimples, untFuncoes;
{ TBaixaReceberEmail }

constructor TBaixaReceberEmail.Create(ADadosEmail: TDadosDisparaEmail;
                                      ADataset: TDataset;
                                      AStatusGrupo: TStatusDisparaEmail);
begin
  FDadosEmail := ADadosEmail;
  FDadosEmail.arrDupTabela := RetornaArrayDeDuplicatas(ADataset);

  FStatusGrupo := AStatusGrupo;
end;

function TBaixaReceberEmail.EnviarEmailBaixaReceberPix(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LEmailAutomatico: TEmaAut;
begin
  Result := True;

  pgbProgresso.Visible := False;

  LEmailAutomatico := TEmaAut.Create(Nil);

  Try
    LEmailAutomatico.FOpcDoc := 'PX';
    LEmailAutomatico.FStatus := FStatusGrupo;

    While Pos(';;', FDadosEmail.strEmaCob) > 0 Do
      FDadosEmail.strEmaCob := FDadosEmail.strEmaCob.Replace(';;', ';');

    LEmailAutomatico.FEmaCli := FDadosEmail.strEmaCob;
    LEmailAutomatico.FNomCli := fRetNomCliente(FDadosEmail.strCodCli);
    LEmailAutomatico.FCodCli := FDadosEmail.strCodCli;
    LEmailAutomatico.FPriCli := fRetPrimeiraPalavra(LEmailAutomatico.FNomCli);
    LEmailAutomatico.FCidCli := fRetNomCidade(fRetCodCidByCliente(FDadosEmail.strCodCli));
    LEmailAutomatico.FCodOpe := strLoginUsuarioLogado;
    LEmailAutomatico.FArrDup := FDadosEmail.arrDupTabela;

    LEmailAutomatico.QrCodePix := 'Pagamento por Pix:<br>' +
                                  '<p><img src="' + RetornaLinkImagemPixCitel(FDadosEmail.QRCodePix) + '" /></p>' +
                                  '<p>Valor: R$ ' + FDadosEmail.strValDup + '</p>';
    If Not FDadosEmail.LinkCitelPix.IsEmpty Then
      LEmailAutomatico.QrCodePix := LEmailAutomatico.QrCodePix + '<p>Link para Pix Copia e Cola: <a href="' + FDadosEmail.LinkCitelPix + '">' + FDadosEmail.LinkCitelPix + '</a></p>';

    LEmailAutomatico.QrCodePix := LEmailAutomatico.QrCodePix + '<p>Para pagamento através do código (Pix Copia e Cola):<br>' +
                                                               '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((FDadosEmail.QRCodePix.Length + 3) / 3).ToString + '">' + FDadosEmail.QRCodePix + '</textarea></p>';

    If LEmailAutomatico.fTemEmailAtivo Then
      Result := LEmailAutomatico.fEnviaEmailAutomatico;

    If Not Result Then
      Raise ExceptionAutcom.Create('Não foi possível enviar o e-mail do Pix ao cliente');
  Finally
    FreeAndNil(LEmailAutomatico);
  End;
end;

function TBaixaReceberEmail.EnviarSMSBaixaReceberPix(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    LSmsAutomatico: TSmsAut;

    LTexto: String;
begin
  Result := True;

  LTexto := 'SMS';

  pgbProgresso.Visible := False;

  LSmsAutomatico := TSmsAut.Create(Nil);

  Try
    LSmsAutomatico.FOpcDoc := 'PX';
    LSmsAutomatico.FStatus := FStatusGrupo;

    LSmsAutomatico.FTo := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [FDadosEmail.strCodCli]);
    LSmsAutomatico.FNomCli := fRetNomCliente(FDadosEmail.strCodCli);
    LSmsAutomatico.FPriCli := fRetPrimeiraPalavra(LSmsAutomatico.FNomCli);
    LSmsAutomatico.FCidCli := fRetNomCidade(fRetCodCidByCliente(FDadosEmail.strCodCli));
    LSmsAutomatico.FEmaCob := fCampoTabela('IFNULL(CLI_EMCOB1, "")', 'CADCLI', ['CLI_CODCLI'], [FDadosEmail.strCodCli]);

    LSmsAutomatico.QrCodePix := 'Pagamento por Pix: ' + FDadosEmail.LinkCitelPix + '   - Valor: R$ ' + FDadosEmail.strValDup;
    If FDadosEmail.LinkCitelPix.IsEmpty Then
      LSmsAutomatico.QrCodePix := 'Pagamento por Pix: ' + FDadosEmail.QRCodePix + '   - Valor: R$ ' + FDadosEmail.strValDup;


    If LSmsAutomatico.fTemModeloAtivo Then
      Result := LSmsAutomatico.fEnviaSmsAutomatico;

    If Not Result Then
      Raise ExceptionAutcom.Create('Não foi possível enviar o ' + LTexto + ' do Pix ao cliente');
  Finally
    FreeAndNil(LSmsAutomatico);
  End;
end;

function TBaixaReceberEmail.EnviarWhatsappBaixaReceberPix(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    LWhatsappAutomatico: TSmsAut;

    LTexto: String;
begin
  Result := True;

  LTexto := 'WhatsApp';

  pgbProgresso.Visible := False;

  LWhatsappAutomatico := TSmsAut.Create(Nil);

  Try
    LWhatsappAutomatico.FOpcDoc := 'PX';
    LWhatsappAutomatico.FStatus := FStatusGrupo;

    LWhatsappAutomatico.FTo := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [FDadosEmail.strCodCli]);
    LWhatsappAutomatico.FNomCli := fRetNomCliente(FDadosEmail.strCodCli);
    LWhatsappAutomatico.FPriCli := fRetPrimeiraPalavra(LWhatsappAutomatico.FNomCli);
    LWhatsappAutomatico.FCidCli := fRetNomCidade(fRetCodCidByCliente(FDadosEmail.strCodCli));
    LWhatsappAutomatico.FEmaCob := fCampoTabela('IFNULL(CLI_EMCOB1, "")', 'CADCLI', ['CLI_CODCLI'], [FDadosEmail.strCodCli]);

    LWhatsappAutomatico.QrCodePix := FDadosEmail.LinkCitelPix;
    If FDadosEmail.LinkCitelPix.IsEmpty Then
      LWhatsappAutomatico.QrCodePix := FDadosEmail.QRCodePix;

    LWhatsappAutomatico.blnWhatsApp := True;
    If LWhatsappAutomatico.fTemModeloAtivo Then
    Begin
      If Not fRetFilaEContatoEnvio(LWhatsappAutomatico.FAutIncCtt,
                                   LWhatsappAutomatico.FTo,
                                   LWhatsappAutomatico.FIDFila,
                                   LWhatsappAutomatico.FCodCli,
                                   LWhatsappAutomatico.FNomCli,
                                   LWhatsappAutomatico.FCodigo,
                                   LWhatsappAutomatico.FCodGru,
                                   False) then
        Exit;

      Result := LWhatsappAutomatico.fEnviaSmsAutomatico;
    End;

    If Not Result Then
      Raise ExceptionAutcom.Create('Não foi possível enviar o ' + LTexto + ' do Pix ao cliente');
  Finally
    FreeAndNil(LWhatsappAutomatico);
  End;
end;

class function TBaixaReceberEmail.PossuiAlgumModeloAEnviarPix(AEnviarEmail,
  AEnviarSMS, AEnviarWhatsapp: Boolean): Boolean;
begin
  Result := AEnviarEmail;

  If Not Result Then
    Result := AEnviarSMS;

  If Not Result Then
    Result := AEnviarWhatsapp;
end;

class function TBaixaReceberEmail.DeveEnviarEmail(ASiglaGrupo: String;
  AStatusGrupo: TStatusDisparaEmail; AEmailCliente: String): Boolean;
  Var
    LEmailAutomatico: TEmaAut;
begin
  Try
    While Pos(';;', AEmailCliente) > 0 Do
      AEmailCliente := AEmailCliente.Replace(';;', ';');

    LEmailAutomatico := TEmaAut.Create(Nil);
    LEmailAutomatico.FOpcDoc := ASiglaGrupo;
    LEmailAutomatico.FStatus := AStatusGrupo;

    Result := LEmailAutomatico.fTemEmailAtivo;

    If Result Then
      Result := ValidaEmailsValidosDoCliente(AEmailCliente);
  Finally
    FreeAndNil(LEmailAutomatico);
  End;
end;

class function TBaixaReceberEmail.DeveEnviarSMS(ASiglaGrupo: String;
  AStatusGrupo: TStatusDisparaEmail; ACelularCliente: String): Boolean;
  Var
    LSmsAutomatico: TSmsAut;
begin
  Try
    LSmsAutomatico := TSmsAut.Create(Nil);
    LSmsAutomatico.FOpcDoc := ASiglaGrupo;
    LSmsAutomatico.FStatus := AStatusGrupo;

    Result := LSmsAutomatico.fTemModeloAtivo;

    If Result Then
      Result := Not ACelularCliente.IsEmpty;
  Finally
    FreeAndNil(LSmsAutomatico);
  End;
end;

class function TBaixaReceberEmail.DeveEnviarWhatsapp(ASiglaGrupo: String;
  AStatusGrupo: TStatusDisparaEmail; ACelularCliente: String): Boolean;
  Var
    LWppAutomatico: TSmsAut;
begin
  Try
    LWppAutomatico := TSmsAut.Create(Nil);
    LWppAutomatico.FOpcDoc := ASiglaGrupo;
    LWppAutomatico.FStatus := AStatusGrupo;

    LWppAutomatico.blnWhatsApp := True;
    Result := LWppAutomatico.fTemModeloAtivo;

    If Result Then
      Result := Not ACelularCliente.IsEmpty;
  Finally
    FreeAndNil(LWppAutomatico);
  End;
end;

function TBaixaReceberEmail.RetornaArrayDeDuplicatas(ADataset: TDataset): TArrDupTabelaEmail;
  Var
    LDuplicata: TDupTabelaEmail;
begin
  SetLength(Result, 0);

  If ADataset.IsEmpty Then
    Exit;

  ADataset.First;
  While Not ADataset.Eof Do
  Begin
    SetLength(Result, Length(Result) + 1);

    LDuplicata.strNumDoc := ADataset.FieldByName('NRODUP').AsString;
    LDuplicata.strParcel := ADataset.FieldByName('PARDUP').AsString;
    LDuplicata.strEspdoc := ADataset.FieldByName('CTR_ESPDOC').AsString;
    LDuplicata.strCodEmp := ADataset.FieldByName('CTR_CODEMP').AsString;
    LDuplicata.strCodCli := ADataset.FieldByName('CTR_CODCLI').AsString;
    LDuplicata.dtaDtaCad := ADataset.FieldByName('CTR_DTACAD').AsDateTime;
    LDuplicata.dtaDtaVen := ADataset.FieldByName('CTR_DTAVEN').AsDateTime;
    LDuplicata.fltVlrDup := ADataset.FieldByName('CTR_VALDUP').AsFloat;
    LDuplicata.ValorCorrigido := ADataset.FieldByName('CTR_VALCAL').AsFloat;
    LDuplicata.ValorRecebido := ADataset.FieldByName('CTR_VALREC').AsFloat;

    Result[Length(Result) - 1] := LDuplicata;

    ADataset.Next;
  End;
end;

class function TBaixaReceberEmail.ValidaEmailsValidosDoCliente(
  EmailCliente: String): Boolean;
  Var
    LListaEmails: TStringList;

    LEmail: String;
begin
  Result := False;

  Try
    LListaEmails := TStringList.Create;
    LListaEmails.Delimiter := ';';
    LListaEmails.StrictDelimiter := True;
    LListaEmails.DelimitedText := EmailCliente;

    For LEmail In LListaEmails Do
    Begin
      If fEnderecoEmailValido(LEmail) Then
        Result := True;
    End;
  Finally
    FreeAndNil(LListaEmails);
  End;
end;

end.
