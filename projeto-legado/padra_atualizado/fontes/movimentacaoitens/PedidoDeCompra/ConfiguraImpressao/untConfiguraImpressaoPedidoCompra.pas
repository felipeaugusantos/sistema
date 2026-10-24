unit untConfiguraImpressaoPedidoCompra;

interface

Uses
  Classes,
  strUtils,
  untZClient,
  CxProgressBar;

Type
  TConfiguraImpressaoPedidoCompra = Class(TZClient)
  Private

    FAtivos: Boolean;

    Function fSQLOpcoes: String;

  Public
    blnImpressaoRel: Boolean;
    intIndice: Integer;

    constructor Create(Owner: TComponent; blnAtivos: Boolean = False); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaOpcoes: Boolean;

    Function fCarregaOpcoesImpressao(intPosInicioTxts: Integer; stlOpcoes: TStringList): Boolean;

    Function fImprimeRelatorio(strEspDoc,
                               strCodEmp,
                               strNumPed: String;
                               bImprimirRelatorioDireto: Boolean = False;
                               bExibirMensagemDeArquivoGerado: Boolean = True;
                               fecharJanelaDeDadosAoImprimir: Boolean = False;
                               HandleSelPedidoCompra: THandle =0): Boolean;

    Function fValidaDestino(strCodRel: String): Boolean;

  End;

implementation

Uses
  SysUtils,
  untGravando,
  untFuncoesSimples,
  untFuncoesRel;

constructor TConfiguraImpressaoPedidoCompra.Create(Owner: TComponent; blnAtivos: Boolean = False);
Begin
  Inherited Create(Owner, '');

  FAtivos :=  blnAtivos;
End;

Destructor TConfiguraImpressaoPedidoCompra.Destroy;
Begin

  Inherited;
End;

Function TConfiguraImpressaoPedidoCompra.fSQLOpcoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   C.*,          ';
  strSQL := strSQL + '   CAST(NULL AS UNSIGNED) AS INDICE  ';
  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   CADRPC C      ';
  strSQL := strSQL + ' WHERE           ';
  strSQL := strSQL + '   RPC_CODEMP =  ' + QuotedStr(VS_strCodEmp);

  If FAtivos Then
    strSQL := strSQL + ' AND RPC_HABILI =  "S" ';

  Result := strSQL;
End;

Function TConfiguraImpressaoPedidoCompra.fCarregaOpcoes: Boolean;
Begin
  qryQuery.SQL.Text := fSQLOpcoes;
  Result := fLeDados('TConfiguraImpressaoPedidoCompra.fCarregaOpcoes');
End;

Function TConfiguraImpressaoPedidoCompra.fCarregaOpcoesImpressao(intPosInicioTxts: Integer; stlOpcoes: TStringList): Boolean;
Begin
  Try
    Result := fCarregaOpcoes;

    If Result Then
    Begin

      Self.First;
      While Not Self.Eof Do
      Begin
        stlOpcoes.Add(Self.FieldByName('RPC_DESCRI').AsString);
        Self.Next;
      End;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('INDICE').AsInteger := stlOpcoes.IndexOf(Self.FieldByName('RPC_DESCRI').AsString) + intPosInicioTxts;
        Self.Post;

        Self.Next;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TConfiguraImpressaoPedidoCompra.fCarregaOpcoesImpressao');
    End;
  End;
End;

Function TConfiguraImpressaoPedidoCompra.fImprimeRelatorio(strEspDoc,
                                                           strCodEmp,
                                                           strNumPed: String;
                                                           bImprimirRelatorioDireto: Boolean = False;
                                                           bExibirMensagemDeArquivoGerado: Boolean = True;
                                                           fecharJanelaDeDadosAoImprimir: Boolean = False;
                                                           HandleSelPedidoCompra: THandle =0): Boolean;
Var
  strEmpDes, strEmpTab: String;
  strCodFor, strPatFor: String;
  lstPatFor: TStringList;
  arrParam,
  arrValor: Array of string;
Begin
  Result := True;

  Try
    strEmpTab := fCampoTabela('PCG_EMPDES', 'PCMGER', ['PCG_CODEMP','PCG_NUMPED','PCG_ESPDOC'], [strCodEmp, strNumPed, strEspDoc]);
    strEmpDes := IfThen(strEmpTab.IsEmpty,  strCodEmp, strEmpTab);
    strCodFor := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_CODEMP','PCG_NUMPED','PCG_ESPDOC'], [strCodEmp, strNumPed, strEspDoc]);;
    strPatFor := '';
    lstPatFor := TStringList.Create;

    arrParam := ['NUMPED', 'CODEMP', 'ESPDOC', 'EMPDES'];
    arrValor := [strNumPed, strCodEmp, strEspDoc, strEmpDes];

    blnImpressaoRel := Self.Locate('INDICE', intIndice, []);

    If blnImpressaoRel Then
    Begin

      If Not Assigned(fncExecutaRelatorioCodigo) Then
        Exit;

      If (Self.FieldByName('RPC_PATFOR').AsString <> '') and (not fEmptyStr(strCodFor)) Then
      Begin
        Try
          {REQUISITO 363201
           SERÁ VALIDADO SE O RELATORIO POSSUI O VINCULO COM UM PATH DE SAIDA
           SEMPRE CADASTRAR: TABELA;CAMPO_PATH;CODIGO_FORNECEDOR
                         EX: FORNEO;NEO_PATARQ;NEO_CODFOR
           JZ}

          lstPatFor.Text := StringReplace(Self.FieldByName('RPC_PATFOR').AsString, ';', #13#10, [rfReplaceAll]);
          strPatFor := fCampoTabela(lstPatFor[1], lstPatFor[0], [lstPatFor[2]], [strCodFor]);

          arrParam := ['NUMPED', 'CODEMP', 'ESPDOC', 'EMPDES', 'PASTA_REL'];
          arrValor := [strNumPed, strCodEmp, strEspDoc, strEmpDes, strPatFor];
        Except
          On E: Exception Do
          Begin
            strPatFor := '';
          End;
        End;
      End;

      If (strEspDoc = 'OR') and (strEmpTab.IsEmpty)  then
        fncExecutaRelatorioCodigo(Self.FieldByName('RPC_CODREL').AsString,
                                  arrParam,
                                  arrValor,
                                  ['NUMPED', 'CODEMP', 'ESPDOC'],
                                  bImprimirRelatorioDireto,
                                  bExibirMensagemDeArquivoGerado,//  blnExibirMensagem: Boolean = True;
                                  '',
                                  False,
                                  Nil,
                                  fecharJanelaDeDadosAoImprimir,
                                  HandleSelPedidoCompra) //      strDirAce: String = ''
      Else
        fncExecutaRelatorioCodigo(Self.FieldByName('RPC_CODREL').AsString,
                                  arrParam,
                                  arrValor,
                                  ['NUMPED', 'CODEMP', 'ESPDOC', 'EMPDES'],
                                  bImprimirRelatorioDireto,
                                  bExibirMensagemDeArquivoGerado,//  blnExibirMensagem: Boolean = True;
                                  '',
                                  False,
                                  Nil,
                                  fecharJanelaDeDadosAoImprimir,
                                  HandleSelPedidoCompra); //      strDirAce: String = ''

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TConfiguraImpressaoPedidoCompra.fCarregaOpcoesImpressao');
    End;
  End;

  FreeAndNil(lstPatFor);
End;

Function TConfiguraImpressaoPedidoCompra.fValidaDestino(strCodRel: String): Boolean;
  Var
    strDestino: String;
Begin
  strDestino := Trim(fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [strCodRel]));

  Result := SameText('TXT', strDestino) Or SameText('CSV', strDestino);
End;


end.
