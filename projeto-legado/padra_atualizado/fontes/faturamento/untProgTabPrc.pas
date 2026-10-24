unit untProgTabPrc;

interface
{$M+}

uses Classes, UniClientDataSet, Uni, Forms, untTypesSistema, untLiberacao;

  Type  
    TLibProgTabPrc = Class(TObject)
      private
        FCodCli: String;
        FCodVen: String;
        FTabPre: String;
        FItens : TUniClientDataSet;
        FLisTbl: TStringList;
        objLiberacao : TLiberacao;
      protected

        function fExibirItens(strTabela: String): Boolean;
        function fLiberacao  (strTabela: String): Boolean;

      public

        Constructor Create(strCodCli, strCodVen: String; oleDados: OleVariant);
        Destructor Destroy; override;

        function fLiberarProgredirTabelaPreco: Boolean;

      published

    End;

implementation

uses untFuncoesSimples, SysUtils, DB,
     untFuncFat,untFatLibProgredirTabPreco, untFuncoes;

Constructor TLibProgTabPrc.Create(strCodCli, strCodVen: String; oleDados: OleVariant);
begin
  inherited Create;

  objLiberacao := TLiberacao.Create;
  FItens  := TUniClientDataSet.Create(Nil);
  FItens.Data := oleDados;

  FLisTbl := TStringList.Create;
  FLisTbl.Sorted := True;
  FLisTbl.Duplicates := dupIgnore;

  FCodCli := strCodCli;
  FCodVen := strCodVen;
  FTabPre := fCampoTabela('CLI_TABPRE','CADCLI',['CLI_CODCLI'],[FCodCli], False);

  If fEmptyStr(FTabPre) And fCfgSis('HIETAB', VarBoolean) Then
    FTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [FCodVen], False);

  If fEmptyStr(FTabPre) Then FTabPre := '1';

  With FItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      If (fCfgSis('ALITPR', varBoolean)) And (FieldByName('ITE_PROMOC').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      If FieldByName('ITE_TABPRE').AsInteger > StrToInt(FTabPre) Then
        FLisTbl.Add(FieldByName('ITE_TABPRE').AsString);
      Next;
    End;
    First;
  End;

  TFloatField(FItens.FieldByName('ITE_QTDITE')).DisplayFormat := '##,#0.00';
  TFloatField(FItens.FieldByName('ITE_UNITAR')).DisplayFormat := '##,#0.00';
  TFloatField(FItens.FieldByName('ITE_TOTITE')).DisplayFormat := '##,#0.00';

end;

Destructor TLibProgTabPrc.Destroy;
begin
  FreeAndNil(FItens);
  FreeAndNil(FLisTbl);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited Destroy;
end;

function TLibProgTabPrc.fLiberarProgredirTabelaPreco: Boolean;
  Var
    intCont: Integer;
begin

  If FLisTbl.Count > 0 Then
  Begin
    Result := True;

    For intCont := 0 To FLisTbl.Count -1 Do
    Begin

      With FItens Do
      Begin
        Filter   := 'ITE_TABPRE = ' + QuotedStr(FLisTbl[intCont]);
        Filtered := True;
        First;

        If Not (fExibirItens(FLisTbl[intCont]) And fLiberacao(FLisTbl[intCont])) Then
        Begin
          Result := False;
          Break;
        End;

        Application.ProcessMessages;

      End;

    End;

  End
  Else
    Result := True;

end;

function TLibProgTabPrc.fExibirItens(strTabela: String): Boolean;
begin

  Try
    pCriarFormularios(TfrmFatLibProgredirTabPreco, frmFatLibProgredirTabPreco);

    With frmFatLibProgredirTabPreco Do
    Begin
      Caption := Caption + ' ' + strTabela;
      dtsItens.DataSet := FItens;
      ShowModal;
      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLibProgTabPrc.fExibirItens]');
    End;
  End;

  pFreeAndNil(frmFatLibProgredirTabPreco);

end;

function TLibProgTabPrc.fLiberacao(strTabela: String): Boolean;
begin

  Result := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Senha para progredir da tabela de preço ' +
                                      FTabPre + ' para ' + strTabela + ' ' +
                                      'quando configurado para somente regredir!');

  objLiberacao.strDirAce := 'PRGTP' + strTabela;
  objLiberacao.strMsgSen := 'Senha para progredir da tabela de preço ' +
                             FTabPre + ' para ' + strTabela + ' ' +
                            'quando configurado para somente regredir!';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := FCodCli + '-' + fRetNomCliente(FCodCli);
  objLiberacao.strCpfCnpj := fRetCgcCpf(FCodCli);
  objLiberacao.blnUsarSenhaFixa := False;

  If (Not objLiberacao.fLibera) Then
  Begin
    fMensagem('','Senha inválida!',['&OK']);
    Result := False;
  End

end;

end.
