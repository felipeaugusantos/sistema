unit untAlteraFornecedorEntrada;

interface

Uses
  Classes, UniClientDataSet, Windows, Uni, untZClient;

Type

  TAlteraFornecedorEntrada = Class(TZClient)
  Private
     FItens: TStringList;
     FCodFor: String;
     FConfirma: Boolean;

     Function fSQLItens: String;

  Public

    constructor Create(Owner: TComponent; strCodFor: String); Reintroduce;

    Destructor Destroy; Override;

    Procedure pMostraItens;

    Procedure pMarcaTodos(blnMarcar: Boolean);

    Function fComfirmaAlteracao: Boolean;
    Function fItemSelecionado(strCodIte: String): Boolean;

    Procedure pAtualizaItens;

  End;

implementation

Uses
  SysUtils, DB, Forms, untFuncoesSimples, untEntAteraFornecProduto;

constructor TAlteraFornecedorEntrada.Create(Owner: TComponent; strCodFor: String);
Begin
  Inherited Create(Owner, '');

  FCodFor       := strCodFor;
  FItens        := TStringList.Create;
  FItens.Sorted := True;
  FConfirma     := False;
End;

Destructor TAlteraFornecedorEntrada.Destroy;
Begin
  FreeAndNil(FItens);

  inherited;
End;

Function TAlteraFornecedorEntrada.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   "S"        AS SELECI,  ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE,  ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE,  ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI,  ';
  strSQL := strSQL + '   ITE_CODFOR AS CODFOR,  ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR,  ';
  strSQL := strSQL + '   ITE_DTAULT AS DTAULT,  ';
  strSQL := strSQL + '   ITE_PREULT AS PREULT,  ';
  strSQL := strSQL + '   ITE_IMPULT AS IMPULT   ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE C ';

  strSQL := strSQL + ' INNER JOIN TMP_ENTMER ON ENT_CODITE = C.ITE_CODITE ';

  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        I.ITE_CODEMP = :CODEMP ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI= ITE_CODUNI ';

  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   C.ITE_CODFOR <> :CODFOR ';

  Result := strSQL;
End;

Procedure TAlteraFornecedorEntrada.pMostraItens;
  Var
    frmEntAteraFornecProduto: TfrmEntAteraFornecProduto;
Begin
  With qryQuery Do
  Begin
    SQL.Text := fSQLItens;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODFOR').AsString := FCodFor;
  End;

  If fAbreClient(True, 'TAlteraFornecedorEntrada.pMostraItens') And (Not IsEmpty) Then
  Begin
    pCriarFormularios(TfrmEntAteraFornecProduto, frmEntAteraFornecProduto);
    frmEntAteraFornecProduto.cxgItensView.DataController.DataSource := Self.dtsSource;
    frmEntAteraFornecProduto.objAltFor := Self;
    frmEntAteraFornecProduto.ShowModal;

    FConfirma := frmEntAteraFornecProduto.blnConfirma;

    pFreeAndNil(frmEntAteraFornecProduto);
  End;
End;

Procedure TAlteraFornecedorEntrada.pMarcaTodos(blnMarcar: Boolean);
Begin
  DisableControls;
  First;
  While Not Eof Do
  Begin
    Edit;
    FieldByName('SELECI').AsString := IIF(blnMarcar, 'S', 'N');
    Post;
    Next;
  End;

  First;
  EnableControls;
End;

Procedure TAlteraFornecedorEntrada.pAtualizaItens;
  Var
    qryUpDate: TUniQuery;
Begin
  If Not FConfirma Then
    Exit;

  qryUpDate := fCriaQuery(Self);

  With qryUpDate, SQL Do
  Begin
    Add('UPDATE CADITE SET ITE_CODFOR = :CODFOR');
    Add('WHERE');
    Add('  ITE_CODITE IN (' +  FItens.CommaText + ')');

    ParamByName('CODFOR').AsString := FCodFor;

    ExecSQL;
  End;

  FreeAndNil(qryUpDate);
End;

Function TAlteraFornecedorEntrada.fComfirmaAlteracao: Boolean;
Begin
  Try
    Result := False;

    FItens.Clear;

    DisableControls;
    Filter := 'SELECI = ' + QuotedStr('S');
    Filtered := True;
    First;
    While Not Eof Do
    Begin
      FItens.Add(QuotedStr(FieldByName('CODITE').AsString));
      Next;
    End;

    If FItens.Count = 0 Then
    Begin
      pMensagemOk('Selecione os itens para atualização!');
    End

    Else If Not fPergunta('Confirma a alteração dos itens selecionados?') Then
    Begin
    End

    Else Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAlteraFornecedorEntrada.fComfirmaAlteracao]');
    End;
  End;

  Filtered := False;
  First;
  EnableControls;
End;


Function TAlteraFornecedorEntrada.fItemSelecionado(strCodIte: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FConfirma And FItens.Find(QuotedStr(strCodIte), intIndex);
End;

end.
