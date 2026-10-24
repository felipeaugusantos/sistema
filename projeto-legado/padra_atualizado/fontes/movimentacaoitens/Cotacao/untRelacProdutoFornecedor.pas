unit untRelacProdutoFornecedor;

Interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants, untConsultas, cxProgressBar,
  untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untFuncoesConsulta,
  UniDataSetProvider, untGravando;

Type
  TTipoLayout = (layProduto, layFornecedor);

  TRelacProdutoFornecedor = Class(TZClient)
  Private

    FCodFor,
    FNomFor: String;

    frmGravando: TfrmGravando;

    FTipLay: TTipoLayout;

    Function fSQLCadIte: String;

    Function fSQLDados: String;

    Function fSQLSelect(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray; strDesIte, strRefere: String): String;

    Procedure pIncluiItem(strCodIte, strCodFor, strNomFor, strCodMar, strRefere, strSigUni, strDesIte, strDesMar: String);

    Function fTransferePrg(cxProgresso: TcxProgressBar): Boolean;

    Function fCarregaDadosPrg(cxProgresso: TcxProgressBar): Boolean;

    Function fSalvaDadosPrg(cxProgresso: TcxProgressBar): Boolean;

    Function fCarregaItem(strCodIte: String): Boolean;

    Function fSQLFiltrosSelecao(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray; strDesIte, strRefere: String): String;

    Function fSelecionaItensPrg(cxProgresso: TcxProgressBar): Boolean;

  Public

    cdsSelecao: TZClient;

    qryCadIte: TUniQuery;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor Destroy; override;

    Function fSalvaDados: Boolean;

    Function fCarregaDados(tlyTipLay: TTipoLayout; strCodigo: String; strMarca: String = ''): Boolean;

    Procedure pIncluiDado(strCodIte, strCodFor, strCodMar: String);

    Procedure pExcluiDado;

    Procedure pExcluiSelecao;

    Function fSelecionaItens(arrMarca, arrUnidade, arrFornecedor,
                             arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray;
                             strDesIte, strRefere: String): Boolean;

    Function fTransfere(strCodFor, strNomFor: String): Boolean;

  End;

implementation

constructor TRelacProdutoFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Text := fSQLCadIte;

  cdsSelecao := TZClient.Create(Self);
End;

Destructor TRelacProdutoFornecedor.Destroy;
Begin
  Inherited;

End;

Function TRelacProdutoFornecedor.fSQLCadIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '   MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI ';
  strSQL := strSQL + ' FROM CADITE ';
  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TRelacProdutoFornecedor.fSQLSelect(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray; strDesIte, strRefere: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '   MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI  ';

  strSQL := strSQL + ' FROM CADITE   ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  strSQL := strSQL + ' WHERE TRUE ';

  strSQL := strSQL + fSQLFiltrosSelecao(arrMarca, arrUnidade, arrFornecedor,
              arrGrupoProduto, arrGrupoCompra, arrLinGru, strDesIte, strRefere);

  Result := strSQL;
End;

Function TRelacProdutoFornecedor.fSQLFiltrosSelecao(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray; strDesIte, strRefere: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + fSQLIn(arrMarca,        'ITE_CODMAR');
  strSQL := strSQL + fSQLIn(arrUnidade,      'ITE_CODUNI');
  strSQL := strSQL + fSQLIn(arrFornecedor,   'ITE_CODFOR');
  strSQL := strSQL + fSQLIn(arrGrupoProduto, 'ITE_PRDGRU');
  strSQL := strSQL + fSQLIn(arrGrupoCompra,  'ITE_GRUCMP');

  strSQL := strSQL + fSQLParam(strDesite, 'ITE_DESITE', True);
  strSQL := strSQL + fSQLParam(strRefere, 'ITE_REFERE', True);

  strSQL := strSQL + fStrLocateLinGru(arrLinGru, 'ITE_CODGRU');

  Result := strSQL;
End;

Function TRelacProdutoFornecedor.fSelecionaItens(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru: TConsultasArray; strDesIte, strRefere: String): Boolean;
Begin
  If fEmptyStr(fSQLFiltrosSelecao(arrMarca, arrUnidade, arrFornecedor,
           arrGrupoProduto, arrGrupoCompra, arrLinGru, strDesIte, strRefere)) Then
  Begin
    Result := False;
    pMensagemOk('Informe pelo menos um filtro para a seleção de produtos');
    Exit;
  End;

  cdsSelecao.qryQuery.SQL.Text := fSQLSelect(arrMarca, arrUnidade, arrFornecedor,
              arrGrupoProduto, arrGrupoCompra, arrLinGru, strDesIte, strRefere);

  Result := TfrmGravando.fExecuta(fSelecionaItensPrg, frmGravando);
End;

Function TRelacProdutoFornecedor.fSelecionaItensPrg(cxProgresso: TcxProgressBar): Boolean;
Begin
  frmGravando.lblGravando.Caption := 'Selecionando produtos, aguarde...';

  Result := cdsSelecao.fAbreClient(True, 'TRelacProdutoFornecedor.fSelecionaItens');
End;

Function TRelacProdutoFornecedor.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   R.*,     ';

  strSQL := strSQL + '   (SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = REL_CODFOR) AS NOMFOR, ';
  strSQL := strSQL + '   (SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = REL_CODITE) AS DESITE, ';
  strSQL := strSQL + '   (SELECT ITE_REFERE FROM CADITE WHERE ITE_CODITE = REL_CODITE) AS REFERE, ';
  strSQL := strSQL + '   (SELECT MAR_DESMAR FROM CADITE INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR WHERE ITE_CODITE = REL_CODITE) AS DESMAR, ';
  strSQL := strSQL + '   (SELECT UNI_SIGUNI FROM CADITE INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI WHERE ITE_CODITE = REL_CODITE) AS SIGUNI  ';

  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   REPRFO R ';

  strSQL := strSQL + ' WHERE      ';

  If FTipLay = layProduto Then
  Begin
    strSQL := strSQL + ' REL_CODITE = :CODIGO ';
    strSQL := strSQL + ' AND REL_CODMAR = (SELECT ITE_CODMAR FROM CADITE WHERE ITE_CODITE = :CODIGO) ';
  End
  Else
  Begin
    strSQL := strSQL + ' REL_CODFOR = :CODIGO ';
    strSQL := strSQL + ' AND REL_CODMAR = :MARCA ';
  End;

  Result := strSQL;
End;

Function TRelacProdutoFornecedor.fCarregaDados(tlyTipLay: TTipoLayout; strCodigo: String; strMarca: String = ''): Boolean;
Begin
  FTipLay := tlyTipLay;

  qryQuery.SQL.Text := fSQLDados;

  qryQuery.ParamByName('CODIGO').AsString := strCodigo;

  If (Not fEmptyStr(strMarca)) Then
    qryQuery.ParamByName('MARCA').AsSTring  := strMarca;

  If fEmptyStr(strCodigo) Then
    Result := fAbreClient(True, 'TRelacProdutoFornecedor.fCarregaDadosPrg')
  Else
    Result := TfrmGravando.fExecuta(fCarregaDadosPrg, frmGravando);

  IndexFieldNames := 'REL_CODITE;REL_CODFOR;REL_CODMAR';

  If FTipLay = layProduto Then
    fCarregaItem(strCodigo);
End;

Function TRelacProdutoFornecedor.fCarregaDadosPrg(cxProgresso: TcxProgressBar): Boolean;
Begin
  frmGravando.lblGravando.Caption := 'Carregando itens, aguarde...';
  Application.ProcessMessages;

  Result := fAbreClient(True, 'TRelacProdutoFornecedor.fCarregaDadosPrg');
End;

Function TRelacProdutoFornecedor.fSalvaDados: Boolean;
Begin
  Result := False;

  If Active Then
    Result := TfrmGravando.fExecuta(fSalvaDadosPrg, frmGravando);
End;

Function TRelacProdutoFornecedor.fSalvaDadosPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    strAutInc: String;
Begin
  Try
    DisableControls;

    frmGravando.lblGravando.Caption := 'Salvando dados, aguarde...';
    Application.ProcessMessages;

    Filter   := 'AUTOINCREM = ' + QuotedStr('');
    Filtered := True;

    cxProgresso.Properties.Max := RecordCount;

    strAutInc := fRetAutoIncrem('REPRFO', VS_strCodEmp, RecordCount);

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('AUTOINCREM').AsString := strAutInc;
      Post;

      strAutInc := fNextAutoIncrem(strAutInc);

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Filtered := False;

    Result := fSalva;

  Finally
    Filtered := False;
    EnableControls;
  End;
End;

Procedure TRelacProdutoFornecedor.pIncluiItem(strCodIte, strCodFor, strNomFor, strCodMar,
  strRefere, strSigUni, strDesIte, strDesMar: String);
Begin
  Append;
  FieldByName('AUTOINCREM').AsString := '';
  FieldByName('REL_CODITE').AsString := strCodIte;
  FieldByName('REL_CODFOR').AsString := strCodFor;
  FieldByName('REL_CODMAR').AsString := strCodMar;
  FieldByName('NOMFOR').AsString     := strNomFor;
  FieldByName('REFERE').AsString     := strRefere;
  FieldByName('SIGUNI').AsString     := strSigUni;
  FieldByName('DESITE').AsString     := strDesIte;
  FieldByName('DESMAR').AsString     := strDesMar;
  Post;
End;

Procedure TRelacProdutoFornecedor.pIncluiDado(strCodIte, strCodFor, strCodMar: String);
Begin
  If fEmptyStr(strCodIte) Then
    Exit;

  If fEmptyStr(strCodFor) Then
    Exit;

  If fEmptyStr(strCodMar) Then
    Exit;

  If Not FindKey([strCodIte, strCodFor, strCodMar]) Then
  Begin

    If (Not qryCadIte.IsEmpty) Or
       (qryCadIte.ParamByName('CODITE').AsString <> strCodIte) Then
      fCarregaItem(strCodIte);

    pIncluiItem(strCodIte, strCodFor, fRetNomFornecedor(strCodFor), strCodMar,
      qryCadIte.FieldByName('REFERE').AsString,
      qryCadIte.FieldByName('SIGUNI').AsString,
      qryCadIte.FieldByName('DESITE').AsString,
      qryCadIte.FieldByName('DESMAR').AsString);

  End;
End;

Function TRelacProdutoFornecedor.fCarregaItem(strCodIte: String): Boolean;
Begin
  qryCadIte.Close;
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;


  Result := Not qryCadIte.IsEmpty;
End;

Procedure TRelacProdutoFornecedor.pExcluiDado;
Begin
  If IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do produto ' + FieldByName('REL_CODITE').AsString + '-' +
         FieldByName('DESITE').AsString + ' e fornecedor ' + FieldByName('REL_CODFOR').AsString + '-' +
         FieldByName('NOMFOR').AsString + '?') Then
    Delete;
End;

Procedure TRelacProdutoFornecedor.pExcluiSelecao;
Begin
  If cdsSelecao.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do produto ' + cdsSelecao.FieldByName('CODITE').AsString + '-' +
         cdsSelecao.FieldByName('DESITE').AsString + '?') Then
    cdsSelecao.Delete;
End;

Function TRelacProdutoFornecedor.fTransfere(strCodFor, strNomFor: String): Boolean;
Begin
  If cdsSelecao.IsEmpty Then
  Begin
    Result := False;
    Exit;
  End;

  FCodFor := strCodFor;
  FNomFor := strNomFor;

  Result := TfrmGravando.fExecuta(fTransferePrg, frmGravando);
End;

Function TRelacProdutoFornecedor.fTransferePrg(cxProgresso: TcxProgressBar): Boolean;
Begin
  frmGravando.lblGravando.Caption := 'Transferindo itens, aguarde...';
  Application.ProcessMessages;
  cxProgresso.Properties.Max := cdsSelecao.RecordCount;

  cdsSelecao.First;

  While Not cdsSelecao.Eof Do
  Begin

    If Not FindKey([cdsSelecao.FieldByName('CODITE').AsString,
                    FCodFor,
                    cdsSelecao.FieldByName('CODMAR').AsString]) Then
      pIncluiItem(cdsSelecao.FieldByName('CODITE').AsString,
                  FCodFor, FNomFor,
                  cdsSelecao.FieldByName('CODMAR').AsString,
                  cdsSelecao.FieldByName('REFERE').AsString,
                  cdsSelecao.FieldByName('SIGUNI').AsString,
                  cdsSelecao.FieldByName('DESITE').AsString,
                  cdsSelecao.FieldByName('DESMAR').AsString);

    cdsSelecao.Next;

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;

  cdsSelecao.Close;
End;

end.
