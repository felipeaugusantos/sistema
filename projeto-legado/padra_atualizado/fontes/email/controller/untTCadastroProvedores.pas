unit untTCadastroProvedores;

interface

uses System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
     Data.DB, System.Generics.Defaults, untFuncoesSimples, Uni, UniClientDataset;

Type
  TOperacao = (opInserir, opAtualizar, opExcluir);
  TCampoValidacao = (cvNone, cvNome, cvSmtp, cvPortaSmtp, cvImap, cvPortaImap, cvLimite, cvLimPHr);

Type
  TCadastroProvedores = class(TComponent)
  Private

    FObjCadPrv  : TUniQuery;
    FCampoValidacao: TCampoValidacao;
    dtsCadPrv   : TDataSource;

    function  fValidarExclusao(intCodPrv: Integer): Boolean;
    function  fValidarCampos(ACadPrv: TUniQuery; AOperacao: TOperacao): Boolean;
  Public
    Constructor Create(AOwner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    function fGravar(ACadPrv: TUniQuery; operacao: TOperacao): Boolean;
    function fListarTodosProvedores: TDataSource;
    function fCriaObjetoCadPrv(strNomPrv, strUrlSmtp, strUrlImap: String;
      intPortaSmtp, intPortaImap, intLimiteArq, intLimitePorHora: Integer; blnSSLEnt, blnSSLSai: Boolean; strGravaPastaEnviados: String): TUniQuery;
    function fPEsquisaCadPrvByCod(intCodPrv: Integer): TUniQuery;

    class function RetornaProvedorPorID(ACodigoProvedor: Integer): TUniClientDataset;

    property objCadPrv: TUniQuery read FObjCadPrv write FObjCadPrv;
    property campoValidacao: TCampoValidacao read FCampoValidacao write FCampoValidacao;
  end;

implementation

{ TCadastroProvedores }

constructor TCadastroProvedores.Create(AOwner: TComponent);
begin
  inherited Create(Owner);

  FObjCadPrv   := fCriaQuery(Self);
  FCampoValidacao := cvNone;
  dtsCadPrv    := TDataSource.Create(Owner);

  dtsCadPrv.DataSet := FObjCadPrv;
end;

destructor TCadastroProvedores.Destroy;
begin
  FObjCadPrv.Free;
  dtsCadPrv.Free;
  inherited;
end;

function TCadastroProvedores.fValidarExclusao(intCodPrv: Integer): Boolean;
  var
    LCadOpe: TUniQuery;
begin
  try
    LCadOpe := fCriaQuery(Nil);
    LCadOpe.Close;
    LCadOpe.SQL.Clear;
    LCadOpe.SQL.Text := 'SELECT * FROM CADOPE WHERE OPE_CODPRV = :CODPRV';
    LCadOpe.ParamByName('CODPRV').AsInteger := intCodPrv;
    LCadOpe.Open;
    Result := LCadOpe.IsEmpty;

    if (not Result) then
      fMensagem('Alerta', 'Provedor possui vínculo com Operadores, portanto, não pode ser excluído!', ['&Ok'])
  finally
    FreeAndNil(LCadOpe);
  end;
end;

class function TCadastroProvedores.RetornaProvedorPorID(
  ACodigoProvedor: Integer): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM CADPRV ' +
                          'WHERE PRV_CODPRV=:CODPRV ';

    LConsulta.ParamByName('CODPRV').AsInteger := ACodigoProvedor;
    LConsulta.Open;

    Result := fCriaClientDatset(LConsulta);
    Result.Open;

    Result.First;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TCadastroProvedores.fValidarCampos(ACadPrv: TUniQuery; AOperacao: TOperacao): Boolean;
begin
  Result := False;
  FCampoValidacao := cvNone;

  if (fEmptyStr(ACadPrv.FieldByName('PRV_NOMPRV').AsString)) then
  begin
    fMensagem('Alerta', 'O campo Nome deve ser informado!', ['&Ok']);
    FCampoValidacao := cvNome;
  end
  else if (fEmptyStr(ACadPrv.FieldByName('PRV_URSMTP').AsString)) then
  begin
    fMensagem('Alerta', 'O campo SMTP deve ser informado!', ['&Ok']);
    FCampoValidacao := cvSmtp;
  end
  else if (ACadPrv.FieldByName('PRV_PORPRV').AsInteger <= 0) then
  begin
    fMensagem('Alerta', 'O campo Porta deve ser maior que 0 (zero)!', ['&Ok']);
    FCampoValidacao := cvPortaSmtp;
  end
  else if (ACadPrv.FieldByName('PRV_LIMARQ').AsInteger <= 0) then
  begin
    fMensagem('Alerta', 'O campo Limite Anexos (MB) deve ser maior que 0 (zero)!', ['&Ok']);
    FCampoValidacao := cvLimite;
  end
  else if (ACadPrv.FieldByName('PRV_LIMPHR').AsInteger < 0) then
  begin
    fMensagem('Alerta', 'O campo Limite de Emails por hora não pode ser menor que zero!', ['&Ok']);
    FCampoValidacao := cvLimPHr;
  end
  else if (not fEmptyStr(ACadPrv.FieldByName('PRV_URIMAP').AsString) and (ACadPrv.FieldByName('PRV_PTIMAP').AsInteger = 0)) then
  begin
    fMensagem('Alerta', 'O campo Porta IMAP deve ser maior que 0 (zero)!', ['&Ok']);
    FCampoValidacao := cvPortaImap;
  end
  else if (fEmptyStr(ACadPrv.FieldByName('PRV_URIMAP').AsString)) and (ACadPrv.FieldByName('PRV_PTIMAP').AsInteger > 0) then
  begin
    fMensagem('Alerta', 'O campo IMAP deve ser informado!', ['&Ok']);
    FCampoValidacao := cvImap;
  end
  Else If (MatchStr(ACadPrv.FieldByName('PRV_URSMTP').AsString, ['smtp.office365.com', 'smtp-mail.outlook.com']) And
          (Not ACadPrv.FieldByName('PRV_USAOA2').AsString.Equals('S')) And
          (AOperacao = opAtualizar)) Then
  Begin
    Result := fMensagem('ATENÇÃO', 'O servidor de e-mail que está sendo gravado é do Outlook/Office 365.' + #13 +
                                   'Após as mudanças realizadas pela Microsoft, é necessário realizar a configuração ' +
                                   'das chaves OAuth2 para o funcionamento do e-mail.' + #13 +
                                   'Deseja salvar o provedor selecionado sem as configurações OAuth2?', ['&Sim', '&Não']) = 1;

    If Not Result Then
      FCampoValidacao := cvSmtp;
  End
  else
    Result := True;
end;

function TCadastroProvedores.fCriaObjetoCadPrv(strNomPrv, strUrlSmtp, strUrlImap: String;
  intPortaSmtp, intPortaImap, intLimiteArq, intLimitePorHora: Integer; blnSSLEnt, blnSSLSai: Boolean; strGravaPastaEnviados: String): TUniQuery;
begin
  Result :=  fCriarQuery('SELECT * FROM CADPRV WHERE FALSE', Self);

  If (Not Result.Active) Then
    fAbrirTabela(Result);


  Result.Insert;
  Result.FieldByName('PRV_NOMPRV').AsString  := strNomPrv;
  Result.FieldByName('PRV_URSMTP').AsString  := strUrlSmtp;
  Result.FieldByName('PRV_PORPRV').AsInteger := intPortaSmtp;
  Result.FieldByName('PRV_URIMAP').AsString  := strUrlImap;
  Result.FieldByName('PRV_PTIMAP').AsInteger := intPortaImap;
  Result.FieldByName('PRV_LIMARQ').AsInteger := intLimiteArq;
  Result.FieldByName('PRV_LIMPHR').AsInteger := intLimitePorHora;

  If (blnSSLEnt) Then
    Result.FieldByName('PRV_SSLENT').AsString := 'S'
  Else
    Result.FieldByName('PRV_SSLENT').AsString := 'N';

  If (blnSSLSai) Then
    Result.FieldByName('PRV_SSLSAI').AsString := 'S'
  Else
    Result.FieldByName('PRV_SSLSAI').AsString := 'N';

  If (IfEmptyStr(strGravaPastaEnviados, 'S') = 'S') Then
    Result.FieldByName('PRV_GRVENV').AsString := 'S'
  Else
    Result.FieldByName('PRV_GRVENV').AsString := 'N';

end;

function TCadastroProvedores.fGravar(ACadPrv: TUniQuery; operacao: TOperacao): Boolean;
begin
  Result := True;

  If Operacao In [opInserir, opAtualizar] Then
  Begin
    If ((ACadPrv.FieldByName('PRV_GRVENV').AsString = 'Sim') And
        Not fEmptyStr(ACadPrv.FieldByName('PRV_URIMAP').AsString)) Then
    Begin
      If fMensagem('ATENÇÃO', 'Para gravar emails na pasta de itens enviados, é necessário configurar ' +
                              'o servidor IMAP do provedor. Se não configurar, a gravação não funcionará.' + #13 +
                              'Deseja continuar mesmo assim?', ['&Sim', '&Não'], 2) = 2 Then
        Exit(False);
    End;
  End;

  case (operacao) of
    opInserir   : begin
                    if (fValidarCampos(ACadPrv, operacao)) and (fMensagem('ATENÇÃO!', 'Confirma inclusão do Provedor ' +
                      ACadPrv.FieldByName('PRV_NOMPRV').AsString + '?', ['&Sim','&Não'], 2) = 1) Then
                    begin
                      ACadPrv.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADPRV', VS_strCodEmp);
                      ACadPrv.FieldByName('PRV_CODPRV').AsInteger := StrToInt(fAtualizaProCod('CADPRV', ''));
                      ACadPrv.Post;
                    end
                    else
                      Result := False;
                  end;
    opExcluir   : begin
                    if (fValidarExclusao(ACadPrv.FieldByName('PRV_CODPRV').AsInteger)) and (fMensagem('ATENÇÃO!', 'Deseja realmente excluir o Provedor ' +
                      ACadPrv.FieldByName('PRV_NOMPRV').AsString + '?', ['&Sim','&Não'], 2) = 1) Then
                    Begin
                     If (Not ACadPrv.Active) Then
                       fAbrirTabela(ACadPrv);

                      ACadPrv.Delete;
                    End
                    else
                      Result := False;
                  end;
    opAtualizar : begin
                    if (fValidarCampos(ACadPrv, operacao)) and (fMensagem('ATENÇÃO!', 'Confirma alteração dos dados do Provedor ' +
                        ACadPrv.FieldByName('PRV_NOMPRV').AsString + '?', ['&Sim','&Não'], 2) = 1) Then
                      ACadPrv.Post
                    else
                      Result := False;
                  end;
  end;
end;

function TCadastroProvedores.fListarTodosProvedores: TDataSource;
begin
  FObjCadPrv.Close;
  FObjCadPrv.SQL.Clear;
  FObjCadPrv.SQL.Text := 'SELECT * FROM CADPRV ORDER BY PRV_NOMPRV, PRV_CODPRV';
  FObjCadPrv.Open;

  dtsCadPrv.DataSet := FObjCadPrv;
  Result:= dtsCadPrv;
end;

function TCadastroProvedores.fPEsquisaCadPrvByCod(intCodPrv: Integer): TUniQuery;
begin
  Result := fCriaQuery(Self);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Text := 'SELECT * FROM CADPRV WHERE PRV_CODPRV = :CODPRV';
  Result.ParamByName('CODPRV').AsInteger := intCodPrv;
  Result.Open;
end;

end.