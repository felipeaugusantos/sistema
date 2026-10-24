unit untParametrosEmpresa;

interface

Uses
  Classes, SysUtils, Controls, DB,  Forms,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes, cxProgressBar;

Const
  INT_AUTONOMA = 1;
  INT_SATELITE = 2;
  INT_HUB      = 3;
  INT_NAO_GERAR= 4;

  ArrTipoEmpresa : Array[1..4] Of String = ('Autônoma', 'Satélite', 'HUB', 'Não gerar pedidos');

Type
  TParametrosEmpresa = Class(TZClient)
    Private
      FCodIte: String;
      FBlnConfirmaRep: Boolean;

      Function fSQLEmpresas(blnVazio: Boolean = False): String;

      Procedure pBeforePost(dataSet: TDataSet);

      Function fDescricaoToPontoPedido(strDescricao: String): String;
      Function fDescricaoToDiasAbastecimento(strDescricao: String): String;
      Function fDescricaoToGiro(strDescricao: String): String;

      Function fSQLColunasCopia: String;

      Procedure pCriaColunasCopia;
      Function  fCopiaParEmpAux(pgbProgresso: TcxProgressBar): Boolean;
    function fReplicarParametrosMesmoFornecedorProgress(cxProgress: TcxProgressbar): Boolean;


    Public

      cdsColunasCopia: TZClient;
      blnReplicarMesmoFornecedor: Boolean;

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;
      Function fDescricaoToTipoParametro(strDescricao: String): Integer;
      procedure pSetCodIte(ACodIte: String);
      Function fValidaDados: Boolean;
      Function fCarregaDados: Boolean;
      Function fSalvaDados: Boolean;
      function fSalvaDadosCadProdutos(strCodIte: String; blnUtilizaPorProduto: Boolean; blnReplicando: Boolean = False): Boolean;
      procedure RemoveTodosQuandoPorItem;

      Class Function fSQLTipoEmpresa: String;

      Procedure pColunasCopiaMarcaTodas(blnMarcar: Boolean);

      Procedure pMarcaTodasEmpresas(blnMarcar: Boolean);

      Procedure pMarcaDesmarca;

      Function fCopiaValores: Boolean;
      procedure pCopiaParEmp;

      procedure pConfirmaReplicacaoMesmoFornecedor;
      Procedure pReplicaMesmoFornecedor;

  End;

implementation

uses
  untGravando, untMultiConfirmacao;

constructor TParametrosEmpresa.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLEmpresas);

  cdsColunasCopia := TZClient.Create(Self, fSQLColunasCopia);

  pCriaColunasCopia;
End;

Destructor TParametrosEmpresa.Destroy;
Begin
  Inherited;

End;

Function TParametrosEmpresa.fSQLColunasCopia: String;
  Var
    srtSQL: String;
Begin
  srtSQL := '';

  srtSQL := srtSQL + ' SELECT ';
  srtSQL := srtSQL + '   CAST("" AS CHAR(100)) AS NOMGRU, ';
  srtSQL := srtSQL + '   CAST("" AS CHAR(060)) AS NOMCOL, ';
  srtSQL := srtSQL + '   CAST("" AS CHAR(060)) AS NOMCAM, ';
  srtSQL := srtSQL + '   "N"                   AS COPIAR  ';

  Result := srtSQL;
End;

Procedure TParametrosEmpresa.pCriaColunasCopia;

  Procedure pAdicionaColuna(strNomGru, strNomCol, strNomCam: String);
  Begin
    cdsColunasCopia.Append;
    cdsColunasCopia.FieldByName('NOMGRU').AsString := strNomGru;
    cdsColunasCopia.FieldByName('NOMCOL').AsString := strNomCol;
    cdsColunasCopia.FieldByName('NOMCAM').AsString := strNomCam;
    cdsColunasCopia.FieldByName('COPIAR').AsString := 'N';
    cdsColunasCopia.Post;
  End;

Begin
  cdsColunasCopia.fLeDados('TParametrosEmpresa.pCriaColunasCopia');
  cdsColunasCopia.EmptyDataSet;

  pAdicionaColuna('Dados Gerais', 'Tipo de Empresa e Empresa HUB', 'DESTIP' {PAR_TIPEMP});
//  pAdicionaColuna('Dados Gerais', 'Empresa HUB',       'PAR_EMPHUB');
  pAdicionaColuna('Dados Gerais', 'Dia Est. Mínimo',   'PAR_DIAMIN');
  pAdicionaColuna('Dados Gerais', 'Fator Est. Máximo', 'PAR_FATMAX');
  pAdicionaColuna('Dados Gerais', 'PD Comp. Garant. Influencia Compra', 'PAR_SUGGAR');

  pAdicionaColuna('Dias para Abastecimento Máximo', 'Utilizar', 'DESABA' {'PAR_DIAGER'});
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Geral',    'PAR_DIAMAG');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível A',  'PAR_DIAMAA');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível B',  'PAR_DIAMAB');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível C',  'PAR_DIAMAC');

  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível X',  'PAR_DIAMNX');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível Y',  'PAR_DIAMNY');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível Z',  'PAR_DIAMNZ');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível AX', 'PAR_DIAMAX');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível AY', 'PAR_DIAMAY');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível AZ', 'PAR_DIAMAZ');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível BX', 'PAR_DIAMBX');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível BY', 'PAR_DIAMBY');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível BZ', 'PAR_DIAMBZ');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível CX', 'PAR_DIAMCX');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível CY', 'PAR_DIAMCY');
  pAdicionaColuna('Dias para Abastecimento Máximo', 'Nível CZ', 'PAR_DIAMCZ');

  pAdicionaColuna('Ponto de Pedido', 'Utilizar',          'DESPON' {'PAR_PONPED'});
  pAdicionaColuna('Dias para Ponto de Pedido', 'Geral',   'PAR_PONGER');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível A', 'PAR_PONNIA');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível B', 'PAR_PONNIB');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível C', 'PAR_PONNIC');

  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível X',  'PAR_PONNIX');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível Y',  'PAR_PONNIY');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível Z',  'PAR_PONNIZ');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível AX', 'PAR_PONNAX');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível AY', 'PAR_PONNAY');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível AZ', 'PAR_PONNAZ');

  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível BX', 'PAR_PONNBX');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível BY', 'PAR_PONNBY');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível BZ', 'PAR_PONNBZ');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível CX', 'PAR_PONNCX');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível CY', 'PAR_PONNCY');
  pAdicionaColuna('Dias para Ponto de Pedido', 'Nível CZ', 'PAR_PONNCZ');

  pAdicionaColuna('Giro de Venda', 'Utilizar',      'DESGIR' {'PAR_USAMES'});
  pAdicionaColuna('Giro de Venda', 'Meses',         'PAR_MESGIR');
  pAdicionaColuna('Giro de Venda', 'Dias Corridos', 'PAR_DIAGIR');
  pAdicionaColuna('Giro de Venda', 'Desprezar maior e menor valores', 'PAR_DESMAI');
End;

Procedure TParametrosEmpresa.pColunasCopiaMarcaTodas(blnMarcar: Boolean);
Begin
  cdsColunasCopia.DisableControls;
  Try
    cdsColunasCopia.First;

    While Not cdsColunasCopia.Eof Do
    Begin
      cdsColunasCopia.Edit;
      cdsColunasCopia.FieldByName('COPIAR').AsString := IIF(blnMarcar, 'S', 'N');
      cdsColunasCopia.Post;

      cdsColunasCopia.Next;
    End;

  Finally
    cdsColunasCopia.EnableControls;
  End;

End;

procedure TParametrosEmpresa.pCopiaParEmp;
  Var
    frmGravando: TfrmGravando;
Begin
  Self.DisableControls;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Copiando parametros da empresa.';
    frmGravando.fExecutarAcao := fCopiaParEmpAux;
    frmGravando.ShowModal;
    //Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
    Self.EnableControls;
  End;
end;

function TParametrosEmpresa.fCopiaParEmpAux(pgbProgresso: TcxProgressBar): Boolean;
var qryConsulta: TUniQuery;
    i: integer;
    strCodite: String;
begin
  Result := True;
  qryConsulta := fCriaQuery;
  Try
    strCodite := FCodIte;
    FCodIte := '';
    qryConsulta.SQL.Add(fSQLEmpresas);
    FCodIte := strCodite;
    qryConsulta.Open;
    pgbProgresso.Properties.Max := qryConsulta.RecordCount -1 ;

    while not qryConsulta.EoF Do
    Begin
      Self.Insert;
      For i:=0 To qryConsulta.Fields.Count -1 do
      Begin
        If qryConsulta.Fields[i].FieldName <> 'AUTOINCREM' Then
          Self.FieldByName(qryConsulta.Fields[i].FieldName).Value := qryConsulta.Fields[i].Value;
      End;
      Self.FieldByName('PAR_CODITE').Value :=  strCodite;
      Self.Post;
      qryConsulta.Next;
      pgbProgresso.Position := qryConsulta.RecNo;
      Application.ProcessMessages;
    End;

    Self.First;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

Function TParametrosEmpresa.fCopiaValores: Boolean;
  Var
    cdsRegistro: TZClient;
    intContador: Integer;
    strNomCam: String;
    intRecNo: Integer;
Begin
  Result := False;

  intRecNo := Self.RecNo;

  cdsColunasCopia.DisableControls;

  Try

    If Not cdsColunasCopia.Locate('COPIAR', 'S', []) Then
    Begin
      pMensagemOk('Marque as colunas que deseja copiar!');
      Exit;
    End;

    If fPergunta('Confima a cópia dos valores selecionados?') Then
    Begin
      Self.DisableControls;

      // COPIA O REGISTRO CORRENTE
      cdsRegistro := TZClient.Create(Self, fSQLEmpresas(True));
      cdsRegistro.fLeDados('TParametrosEmpresa.fCopiaValores');
      cdsRegistro.Insert;
      for intContador := 0 To cdsRegistro.Fields.Count - 1 do
        cdsRegistro.Fields[intContador].Value := Self.Fields[intContador].Value;
      cdsRegistro.Post;

      Filter   := 'MARDES = ' + QuotedStr('S') + ' AND PAR_CODEMP <> ' + QuotedStr(cdsRegistro.FieldByName('PAR_CODEMP').AsString);
      Filtered := True;

      If IsEmpty Then
      Begin
        pMensagemOk('Nenhuma empresa destino foi selecionada!');
        Exit;
      End;

      First;
      While Not Eof Do
      Begin

        Edit;

        for intContador := 0 To cdsRegistro.Fields.Count - 1 do
        Begin
          If SameText(Self.Fields[intContador].FieldName, 'PAR_EMPHUB') Then
            strNomCam := 'DESTIP'
          Else
            strNomCam := Self.Fields[intContador].FieldName;


          If cdsColunasCopia.Locate('NOMCAM', strNomCam, []) And
             SameText(cdsColunasCopia.FieldByName('COPIAR').AsString, 'S') Then
          Begin

            // A EMPRESA NÃO PODE SER HUB DELA MESMA
            If (Pos(Self.Fields[intContador].FieldName, 'PAR_EMPHUB-DESTIP') > 0) And
               SameText(Self.FieldByName('PAR_CODEMP').AsString, cdsRegistro.FieldByName('PAR_EMPHUB').AsString) Then
            Begin

            End Else
            Begin
              Self.Fields[intContador].Value := cdsRegistro.Fields[intContador].Value;
            End;

          End;

        End;

        Post;

        Next;
      End;

      Result := True;

      Filtered := False;

      pMarcaTodasEmpresas(False);

      Self.Locate('PAR_CODEMP', cdsRegistro.FieldByName('PAR_CODEMP').AsString, []);
    End;

  Finally
    Filtered := False;

    Self.RecNo := intRecNo;

    cdsColunasCopia.EnableControls;
    Self.EnableControls
  End;

End;

Procedure TParametrosEmpresa.pMarcaDesmarca;
Begin
  Self.Edit;
  Self.FieldByName('MARDES').AsString := IIF(Self.FieldByName('MARDES').AsString = 'N', 'S', 'N');
  Self.Post;
End;

Procedure TParametrosEmpresa.pMarcaTodasEmpresas(blnMarcar: Boolean);
  Var
    intRecNo: Integer;
Begin
  intRecNo := Self.RecNo;

  Self.DisableControls;
  Try
    Self.First;

    While Not Self.Eof Do
    Begin
      Self.Edit;
      Self.FieldByName('MARDES').AsString := IIF(blnMarcar, 'S', 'N');
      Self.Post;

      Self.Next;
    End;

  Finally
    Self.RecNo := intRecNo;

    Self.EnableControls;
  End;
End;

procedure TParametrosEmpresa.pSetCodIte(ACodIte: String);
begin
  FCodIte := ACodIte;

  Self.qryQuery.SQL.Text := fSQLEmpresas;

end;

procedure TParametrosEmpresa.RemoveTodosQuandoPorItem;
begin
  Self.First;
  while not Self.Eof Do
    Self.Delete;
end;

Function TParametrosEmpresa.fDescricaoToTipoParametro(strDescricao: String): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;

  for intContador := Low(ArrTipoEmpresa) to High(ArrTipoEmpresa) do
  If SameText(ArrTipoEmpresa[intContador], strDescricao) Then
  Begin
    Result := intContador;
    Break;
  End;
End;

Function TParametrosEmpresa.fDescricaoToPontoPedido(strDescricao: String): String;
Begin
  If SameText(strDescricao, 'Não utiliza') Then
    Result := 'N'
  Else If SameText(strDescricao, 'Geral') Then
    Result := 'G'
  Else If SameText(strDescricao, 'ABC') Then
    Result := 'A'
  Else If SameText(strDescricao, 'XYZ') Then
    Result := 'C'
  Else If SameText(strDescricao, 'ABC+XYZ') Then
    Result := 'AC'
  Else Result := '';
End;

Function TParametrosEmpresa.fDescricaoToDiasAbastecimento(strDescricao: String): String;
Begin
  If SameText(strDescricao, 'Geral') Then
    Result := 'G'

  Else If SameText(strDescricao, 'ABC') Then
    Result := 'A'

  Else If SameText(strDescricao, 'XYZ') Then
    Result := 'C'
  Else If SameText(strDescricao, 'ABC+XYZ') Then
    Result := 'AC'
  Else Result := '';
End;

Function TParametrosEmpresa.fDescricaoToGiro(strDescricao: String): String;
Begin
  If SameText(strDescricao, 'Meses') Then
    Result := 'S'

  Else If SameText(strDescricao, 'Dias') Then
    Result := 'N'

  Else Result := '';
End;

Procedure TParametrosEmpresa.pBeforePost(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    FieldByName('PAR_TIPEMP').AsInteger := fDescricaoToTipoParametro(FieldByName('DESTIP').AsString);
    FieldByName('PAR_PONPED').AsString  := fDescricaoToPontoPedido(FieldByName('DESPON').AsString);
    FieldByName('PAR_DIAGER').AsString  := fDescricaoToDiasAbastecimento(FieldByName('DESABA').AsString);
    FieldByName('PAR_USAMES').AsString  := fDescricaoToGiro(FieldByName('DESGIR').AsString);

    If FieldByName('PAR_TIPEMP').AsInteger <> INT_SATELITE Then
      FieldByName('PAR_EMPHUB').Clear;

    If SameText(FieldByName('PAR_USAMES').AsString, 'S') And
       (FieldByName('PAR_MESGIR').AsInteger < 6) Then
      FieldByName('PAR_DESMAI').AsString := 'N';

    If SameText(FieldByName('PAR_USAMES').AsString, 'N') And
       (FieldByName('PAR_DIAGIR').AsInteger < 6) Then
      FieldByName('PAR_DESMAI').AsString := 'N';

  End;
End;

Class Function TParametrosEmpresa.fSQLTipoEmpresa: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  CASE PAR_TIPEMP ';
  strSQL := strSQL + '     WHEN 1 THEN "Autônoma" ';
  strSQL := strSQL + '     WHEN 2 THEN "Satélite" ';
  strSQL := strSQL + '     WHEN 3 THEN "HUB" ';
  strSQL := strSQL + '     WHEN 4 THEN "Não gerar pedidos" ';
  strSQL := strSQL + '  END ';

  Result := strSQL;
End;

Function TParametrosEmpresa.fSQLEmpresas(blnVazio: Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  P.*, ';
  strSQL := strSQL + '  (SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = PAR_CODEMP) AS PAR_NOMEMP,  ';

  strSQL := strSQL +   fSQLTipoEmpresa + ' AS DESTIP,';
  strSQL := strSQL +   fSQLTipoEmpresa + ' AS TIPORI,';

  strSQL := strSQL + '  "N" AS MARDES,';

  strSQL := strSQL + '  CASE PAR_PONPED ';
  strSQL := strSQL + '     WHEN "N" THEN "Não utiliza" ';
  strSQL := strSQL + '     WHEN "G" THEN "Geral" ';
  strSQL := strSQL + '     WHEN "A" THEN "ABC" ';
  strSQL := strSQL + '     WHEN "C" THEN "XYZ" ';
  strSQL := strSQL + '     WHEN "AC" THEN "ABC+XYZ" ';
  strSQL := strSQL + '  END AS DESPON, ';

  strSQL := strSQL + '  CASE PAR_DIAGER ';
  strSQL := strSQL + '     WHEN "G" THEN "Geral" ';
  strSQL := strSQL + '     WHEN "A" THEN "ABC" ';
  strSQL := strSQL + '     WHEN "C" THEN "XYZ" ';
  strSQL := strSQL + '     WHEN "AC" THEN "ABC+XYZ" ';
  strSQL := strSQL + '  END AS DESABA, ';

  strSQL := strSQL + '  CASE PAR_USAMES ';
  strSQL := strSQL + '     WHEN "S" THEN "Meses" ';
  strSQL := strSQL + '     WHEN "N" THEN "Dias" ';
  strSQL := strSQL + '  END AS DESGIR ';
  If FCodIte <> '' Then
    strSQL := strSQL + ' FROM ITEPAR P '
  Else
    strSQL := strSQL + ' FROM EMPPAR P ';

  If FCodIte <> '' Then
    strSQL := strSQL + ' WHERE P.PAR_CODITE =  "'+FCodIte+'" ';

  strSQL := strSQL + 'ORDER BY PAR_CODEMP ';

  Result := strSQL;
End;

Function TParametrosEmpresa.fCarregaDados: Boolean;
   Var
     qryEmpresa: TUniQuery;
Begin
  Result := fLeDados('TParametrosEmpresa.fCarregaDados');

  pAlinhaCampoCentro('PAR_CODEMP');
  pAlinhaCampoCentro('PAR_EMPHUB');
  pAlinhaCampoCentro('PAR_MESGIR');
  pAlinhaCampoCentro('DESTIP');
  pAlinhaCampoCentro('DESABA');
  pAlinhaCampoCentro('DESPON');
  pAlinhaCampoCentro('DESGIR');

  If Not Result Then
    Exit;
  If FCodIte = '' Then
  Begin
    qryEmpresa := fCriaQuery;
    Try
      qryEmpresa.SQL.Text := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP ' +
                             'LEFT JOIN EMPPAR ON PAR_CODEMP = EMP_CODEMP ' +
                             'WHERE PAR_CODEMP IS NULL ' +
                             'ORDER BY EMP_CODEMP ';

      qryEmpresa.Open;

      While Not qryEmpresa.Eof Do
      Begin
        Insert;
        FieldByName('PAR_CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
        FieldByName('PAR_NOMEMP').AsString := qryEmpresa.FieldByName('EMP_NOMEMP').AsString;
        FieldByName('PAR_SUGGAR').AsString := 'N';
        FieldByName('PAR_PONPED').AsString := 'N';
        FieldByName('PAR_DIAGER').AsString := 'G';
        FieldByName('PAR_USAMES').AsString := 'S';
        Post;

        qryEmpresa.Next;
      End;
    Finally
      FreeAndNil(qryEmpresa);
    End;
  End;

  BeforePost  := pBeforePost;

End;

Function TParametrosEmpresa.fValidaDados: Boolean;
  Var
    strErros,
    strCodEmp: String;
    stlHubs: TStringList;
Begin
  Result := True;

  stlHubs := TStringList.Create;

  DisableControls;

  Try
    Filter    := 'PAR_TIPEMP = ' + IntToStr(INT_SATELITE) + ' AND PAR_EMPHUB IS NULL ';
    Filtered  := True;

    Result := IsEmpty;

    If Not Result Then
    Begin
      strCodEmp := FieldByName('PAR_CODEMP').AsString;
      strErros := 'Informe a Empresa HUB para todas as Satélites!';
      Exit;
    End;

    Filter    := 'PAR_TIPEMP = ' + IntToStr(INT_HUB);
    Filtered  := True;

    First;
    While Not Eof Do
    Begin
      stlHubs.Add(FieldByName('PAR_CODEMP').AsString);
      Next;
    End;

    Filter := 'PAR_TIPEMP = ' + IntToStr(INT_SATELITE) +
              IIF(stlHubs.Count > 0, ' AND NOT (PAR_EMPHUB IN (' + fCommaText(stlHubs, True) + '))', '');

    Filtered  := True;

    Result := IsEmpty;

    If Not Result Then
    Begin
      strCodEmp := FieldByName('PAR_CODEMP').AsString;
      strErros := 'Informe a Empresa ' + FieldByName('PAR_EMPHUB').AsString + ' não é do tipo HUB!';
      Exit;
    End;

  Finally
    Filtered := False;
    EnableControls;

    If Not Result Then
    Begin
      Locate('PAR_CODEMP', strCodEmp, []);
      pMensagemOk(strErros);
    End;
  End;

  FreeAndNil(stlHubs);
End;

Function TParametrosEmpresa.fSalvaDados: Boolean;
  Var
    strAutInc: String;
Begin
  DisableControls;

  Try
    Filter    := 'AUTOINCREM IS NULL';
    Filtered  := True;
    strAutInc := fRetAutoIncrem('EMPPAR', VS_strCodEmp, RecordCount);
    Filtered  := False;

    First;

    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
      Begin
        FieldByName('AUTOINCREM').AsString := strAutInc;
        strAutInc := fNextAutoIncrem(strAutInc);
      End;

      Post;

      Next;
    End;

  Finally
    Filtered := False;
    EnableControls;
  End;

  Result := fSalva;
End;

function TParametrosEmpresa.fSalvaDadosCadProdutos(strCodIte: String; blnUtilizaPorProduto: Boolean; blnReplicando: Boolean = False): Boolean;
var qryComand: TUniQuery;
    qryItePar: TUniQuery;
    i: integer;
begin
  qryComand := fCriaQuery();
  qryItePar := fCriaQuery();
  Try
    qryComand.sql.add('DELETE FROM ITEPAR WHERE ITEPAR.PAR_CODITE = "'+strCodIte+'"');
    qryComand.ExecSQL;
    qryComand.SQL.Clear;
    If blnUtilizaPorProduto Then
    Begin
      qryItePar.sql.Add('SELECT * FROM ITEPAR WHERE FALSE');
      qryItePar.Open;
      Self.First;
      qryComand.SQL.Add('REPLACE INTO ITEPAR(');
      For i:= 0 To qryItePar.Fields.Count-1 do
       qryComand.SQL.Add(qryItePar.Fields[i].FieldName + IIf(i = qryItePar.Fields.Count -1, ')',','));
      qryComand.SQL.Add('VALUES(');
      For i:= 0 To qryItePar.Fields.Count-1 do
       qryComand.SQL.Add(':' + qryItePar.Fields[i].FieldName + IIf(i = qryItePar.Fields.Count -1, ')',','));

      while not Self.Eof do
      Begin
        For i:= 0 To qryItePar.Fields.Count-1 do
          qryComand.ParamByName(qryItePar.Fields[i].FieldName).Value := Self.FieldByName(qryItePar.Fields[i].FieldName).Value;

        If Self.FieldByName('AUTOINCREM').AsString = '' Then
          qryComand.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEPAR', VS_StrCodEmp);

        qryComand.ParamByName('PAR_CODITE').AsString := strCodIte;
        Self.Next;
        qryComand.ExecSQL;
      End;

      If (Not blnReplicando) And (blnReplicarMesmoFornecedor) And (FBlnConfirmaRep) Then
        pReplicaMesmoFornecedor;
    End;

    Result := True;
  Finally
    FreeAndNil(qryComand);
    FreeAndNil(qryItePar);
  End;
end;

procedure TParametrosEmpresa.pReplicaMesmoFornecedor;
begin
  Try
    Screen.Cursor := crHourGlass;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fReplicarParametrosMesmoFornecedorProgress;
    frmGravando.ShowModal;

  Finally
    FreeAndNil(frmGravando);
    Screen.Cursor := crDefault;
  End;

end;

procedure TParametrosEmpresa.pConfirmaReplicacaoMesmoFornecedor;
var
  strCodFor: String;
  qryItens: TUniQuery;
begin
  Try
    strCodFor := fCampoTabela('ITE_CODFOR', 'CADITE', ['ITE_CODITE'], [FCodIte]);
    qryItens := fCriaQuery;

    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT GROUP_CONCAT(ITE_CODITE, '' - '',ITE_DESITE,''\n'' SEPARATOR '''') AS ITENS FROM CADITE WHERE ITE_CODITE <> ' + QuotedStr(FCodIte) + ' AND ITE_CODFOR = ' + QuotedStr(strCodFor));
    qryItens.Open;

    If qryItens.IsEmpty Then
      Exit;

    FBlnConfirmaRep := TfrmMultiConfirmacao.fMultiConfirmacao('Itens que os parâmetros serão replicados', 'Atenção: Todos os parâmetros também serão atualizados para os itens abaixo ( mesmo fornecedor ).' + #13#10 +  #13#10 +
                                                              'Fornecedor: ' + strCodFor + '-' + fRetNomFornecedor(strCodFor) + #13#10 +  #13#10 + qryItens.FieldByName('ITENS').AsString);
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TParametrosEmpresa.fReplicarParametrosMesmoFornecedorProgress(cxProgress : TcxProgressbar): Boolean;
var
  strCodFor: String;
  qryItens: TUniQuery;
begin
  Result := True;

  If Not FBlnConfirmaRep Then
    Exit;

  strCodFor := fCampoTabela('ITE_CODFOR', 'CADITE', ['ITE_CODITE'], [FCodIte]);
  qryItens := fCriaQuery;

  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ITE_CODITE, ITE_DESITE FROM CADITE WHERE ITE_CODITE <> ' + QuotedStr(FCodIte) + ' AND ITE_CODFOR = ' + QuotedStr(strCodFor));
  qryItens.Open;

  If qryItens.IsEmpty Then
    Exit;

  Try
    Try
      cxProgress.Properties.Max := qryItens.RecordCount;
      qryItens.First;
      While Not qryItens.Eof Do
      Begin
        frmGravando.lblGravando.Caption := 'Replicando parâmetros para o item ' + qryItens.FieldByName('ITE_CODITE').AsString + '-' + qryItens.FieldByName('ITE_DESITE').AsString + '...';
        Application.ProcessMessages;

        fSalvaDadosCadProdutos(qryItens.FieldByName('ITE_CODITE').AsString, True, True);
        qryItens.Next;
        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;

    Except On
      E:Exception Do
      Begin
        pMensagensErro(E.Message, '[pReplicaMesmoFornecedor]');
      End;
    End;
  Finally
    FreeAndNil(qryItens);
  End;

end;


end.
