unit untConfirmaXMLGravacao;

interface

uses
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  , untRegistrarTarefa, XMLDoc, XMLIntf;

type
  TConfirmaXMLGravacao = class
  private
    Const
      LIMIT_EXECUTION : Integer = 20;
      INTERVAL_DAYS : Integer = 15;
  private
    Type
      TItem = record
        Codigo : String;
        Descricao : String;
        Quantidade : Double;
        Processado : Boolean;
      End;
      TItens = Array Of TItem;
  private
    FConnection: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa : TRegistrarTarefa;
    procedure MarcaComoErro(const ASeqFis: String; const AMessage: String);
    function ValidarItens(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATip_FC : String; const AItens : TItens; var AMessage : String) : Boolean;
    function FindNodeString(const ANode : IXMLNode; const ANodeName : String) : String;
    function FindNodeDouble(const ANode : IXMLNode; const ANodeName : String) : Double;
    function CarregarXML(const AXML : AnsiString) : TItens;
    function CarregarItens(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATip_FC : String) : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    function GetSQLItens(const ATabela, ATip_FC: String): String;
    function ItemExiste(const ACodigoItem, ADescricaoItem : String; AQuantidadeItem : Double; const AItens : TItens) : Boolean;
    procedure MarcaComoSucesso(const ASeqFis: String);
    procedure pProcessarRegistrosOndeExisteXMLNFE;
    procedure pProcessarRegistrosOndeNaoExisteXMLNFE;
    procedure UpdateRecord(const ASeqFis: String; const AStatus, AMessage: String);
    procedure UpdateKeys(const AKeys: String; const ANewStatus, AStatusBefore, AMessage: String);
  public
    procedure Executar;
    constructor Create(const ATarefa: TRegistrarTarefa);
  End;

implementation

{ TConfirmaXMLGravacao }

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Forms,
{$ENDIF}
  SysUtils, Variants, DB, StrUtils;

function TConfirmaXMLGravacao.ValidarItens(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATip_FC : String; const AItens : TItens; var AMessage : String) : Boolean;
  Var
    LItens : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LCount : Integer;
begin
  LItens := fCriaQuery(nil, FConnection);
  Try
    LItens := CarregarItens(ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATip_FC);
    If (LItens.RecordCount <> Length(AItens)) Then
    Begin
      Result := False;
      AMessage := 'Quantidade de itens no xml: ' + IntToStr(Length(AItens)) + ', quantidade de itens em tabela: ' + IntToStr(LItens.RecordCount);
      Exit;
    End;
    LItens.First;
    While Not LItens.Eof Do
    Begin
      If Not ItemExiste(LItens.FieldByName('DET_CODITE').AsString,
                        LItens.FieldByName('DET_DESCRI').AsString,
                        LItens.FieldByName('DET_QTDITE').AsFloat,
                        AItens) Then
      Begin
        Result := False;
        AMessage := 'Produto não existe no XML:' + sLineBreak +
                    'Código: ' + LItens.FieldByName('DET_CODITE').AsString + sLineBreak +
                    'Descrição: ' + LItens.FieldByName('DET_DESCRI').AsString + sLineBreak +
                    'Quantidade: ' + FloatToStrF(LItens.FieldByName('DET_QTDITE').AsFloat, ffFixed, 12, 4);
        Exit;
      End;
      LItens.Next;
    End;
    AMessage := '';
    For LCount := 0 To Length(AItens)-1 Do
    Begin
      If AItens[LCount].Processado Then
        Continue;
      AMessage := AMessage + 'Produto não existe na tabela:' + sLineBreak +
                             'Código: ' + AItens[LCount].Codigo + sLineBreak +
                             'Descrição: ' + AItens[LCount].Descricao + sLineBreak +
                             'Quantidade: ' + FloatToStrF(AItens[LCount].Quantidade, ffFixed, 12, 4) + sLineBreak;
    End;
    Result := fEmptyStr(AMessage);
  Finally
    FreeAndNil(LItens);
  End;
end;

function TConfirmaXMLGravacao.CarregarItens(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATip_FC : String): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := fCriaQuery(nil, FConnection);
  Result.SQL.Clear;
  Result.SQL.Add(GetSQLItens('MOVDET', ATip_FC));
  Result.SQL.Add('UNION ALL');
  Result.SQL.Add(GetSQLItens('NOTDET', ATip_FC));
  Result.ParamByName('NUMDOC').AsString := ANumDoc;
  Result.ParamByName('ESPDOC').AsString := AEspDoc;
  Result.ParamByName('CODEMP').AsString := ACodEmp;
  Result.ParamByName('FORCLI').AsString := AForCli;
  Result.ParamByName('SERIE_').AsString := ASerie;
  Result.ParamByName('TIP_FC').AsString := ATip_FC;
  Result.Open;
  If (Result.IsEmpty) Then
  Begin
    Result.SQL.Clear;
    Result.SQL.Add(GetSQLItens('DEL_MOVDET', ATip_FC));
    Result.SQL.Add('UNION ALL');
    Result.SQL.Add(GetSQLItens('DEL_NOTDET', ATip_FC));
    Result.ParamByName('NUMDOC').AsString := ANumDoc;
    Result.ParamByName('ESPDOC').AsString := AEspDoc;
    Result.ParamByName('CODEMP').AsString := ACodEmp;
    Result.ParamByName('FORCLI').AsString := AForCli;
    Result.ParamByName('SERIE_').AsString := ASerie;
    Result.ParamByName('TIP_FC').AsString := ATip_FC;
    Result.Open;
  End;
end;

function TConfirmaXMLGravacao.CarregarXML(const AXML: AnsiString) : TItens;
  Var
    LXMLDocument : TXMLDocument;
    LItem : TItem;
    LNodeDet : IXMLNode;
    LNodeInfNFe : IXMLNode;
    LNodeNFe : IXMLNode;
    LNodeProd : IXMLNode;
    LNodeNfeProc : IXMLNode;
begin
  LXMLDocument := TXMLDocument.Create(Application);
  Try
    LXMLDocument.LoadFromXML(AXML);
    LXMLDocument.Active := True;
    LNodeNfeProc := LXMLDocument.Node.ChildNodes.FindNode('nfeProc');
    If Assigned(LNodeNfeProc) Then
      LNodeNFe := LNodeNfeProc.ChildNodes.FindNode('NFe')
    Else
      LNodeNFe := LXMLDocument.Node.ChildNodes.FindNode('NFe');
    LNodeInfNFe := LNodeNFe.ChildNodes.FindNode('infNFe');
    LNodeDet := LNodeInfNFe.ChildNodes.FindNode('det');
    SetLength(Result, 0);
    While (Assigned(LNodeDet)) And (LNodeDet.GetNodeName = 'det') Do
    Begin
      LNodeProd := LNodeDet.ChildNodes.FindNode('prod');
      If (Not Assigned(LNodeProd)) Then
        Continue;
      FillChar(LItem, SizeOf(LItem), #0);
      LItem.Codigo := FindNodeString(LNodeProd, 'cProd');
      LItem.Descricao := FindNodeString(LNodeProd, 'xProd');
      LItem.Quantidade := FindNodeDouble(LNodeProd, 'qCom');
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := LItem;
      LNodeDet := LNodeDet.NextSibling;
    End;
  Finally
    FreeAndNil(LXMLDocument);
  End;
end;

constructor TConfirmaXMLGravacao.Create(const ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  FConnection := frmModulo.Database;
end;

procedure TConfirmaXMLGravacao.Executar;
begin
  If (Not fTabelaExiste('XMLCNF', FConnection)) Then
    Exit;

  FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' - XMLCNF com XMLNFE');
  pProcessarRegistrosOndeExisteXMLNFE;

  FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' - XMLCNF sem XMLNFE');
  pProcessarRegistrosOndeNaoExisteXMLNFE;
end;

procedure TConfirmaXMLGravacao.pProcessarRegistrosOndeExisteXMLNFE;
  Var
    LPendentes : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LXML : AnsiString;
    LItens : TItens;
    LMessage : String;
begin
  LPendentes := fCriaQuery(nil, FConnection);
  Try
    LPendentes.Close;
    LPendentes.SQL.Clear;
    LPendentes.SQL.Add(' SELECT XMLCNF.AUTOINCREM, XMLNFE.NFE_ARQXML, ');
    LPendentes.SQL.Add('        CNF_NUMDOC, CNF_ESPDOC, CNF_CODEMP, CNF_FORCLI, ');
    LPendentes.SQL.Add('        CNF_TIP_FC, CNF_SERIE_, XMLCNF.CNF_SEQFIS ');
    LPendentes.SQL.Add('   FROM XMLCNF ');
    LPendentes.SQL.Add('   INNER JOIN CADFIS ON XMLCNF.CNF_SEQFIS = CADFIS.AUTOINCREM ');
    LPendentes.SQL.Add('   INNER JOIN XMLNFE ON XMLNFE.NFE_ACESSO = CADFIS.FIS_ACESSO ');
    LPendentes.SQL.Add('  WHERE XMLCNF.CNF_CODEMP = :CODEMP ');
    LPendentes.SQL.Add('    AND XMLCNF.CNF_STATUS = "GE" ');
    LPendentes.SQL.Add('  ORDER BY XMLCNF.CNF_DTAEMI DESC ');
    LPendentes.SQL.Add('  LIMIT ' + IntToStr(LIMIT_EXECUTION) );
    LPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LPendentes.Open;
    LPendentes.First;

    While Not LPendentes.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
        Break;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(LPendentes.FieldByName('CNF_NUMDOC').AsString, '-',
                                                                     LPendentes.FieldByName('CNF_ESPDOC').AsString, '-',
                                                                     LPendentes.FieldByName('CNF_CODEMP').AsString));

      If (LPendentes.FieldByName('NFE_ARQXML').IsNull) Then
      Begin
        MarcaComoErro(LPendentes.FieldByName('CNF_SEQFIS').AsString, 'Sem XML');
        LPendentes.Next;
        Continue;
      End;

      LXML := AnsiString(LPendentes.FieldByName('NFE_ARQXML').AsString);

      If (Length(Trim(String(LXML))) <= 3) Then
      Begin
        MarcaComoErro(LPendentes.FieldByName('CNF_SEQFIS').AsString, 'Sem XML');
        LPendentes.Next;
        Continue;
      End;

      Try
        LItens := CarregarXML(LXML);
      Except
        On E: Exception Do
        Begin
          MarcaComoErro(LPendentes.FieldByName('CNF_SEQFIS').AsString, 'Falha na carga do XML: ' + E.Message);
          LPendentes.Next;
          Continue;
        End;
      End;

      LMessage := '';

      If (Not ValidarItens(LPendentes.FieldByName('CNF_NUMDOC').AsString,
                           LPendentes.FieldByName('CNF_ESPDOC').AsString,
                           LPendentes.FieldByName('CNF_CODEMP').AsString,
                           LPendentes.FieldByName('CNF_FORCLI').AsString,
                           LPendentes.FieldByName('CNF_SERIE_').AsString,
                           LPendentes.FieldByName('CNF_TIP_FC').AsString,
                           LItens,
                           LMessage)) Then
      Begin
        MarcaComoErro(LPendentes.FieldByName('CNF_SEQFIS').AsString, 'Falha na validação dos itens - ' + LMessage);
        LPendentes.Next;
        Continue;
      End;

      MarcaComoSucesso(LPendentes.FieldByName('CNF_SEQFIS').AsString);

      LPendentes.Next;
    End;
  Finally
    FreeAndNil(LPendentes);
  End;
end;

procedure TConfirmaXMLGravacao.pProcessarRegistrosOndeNaoExisteXMLNFE;
  Var
    LPendentes : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LKeys : String;
begin
  LPendentes := fCriaQuery(nil, FConnection);
  Try
    LPendentes.Close;
    LPendentes.SQL.Clear;
    LPendentes.SQL.Add(' SELECT XMLCNF.CNF_SEQFIS ');
    LPendentes.SQL.Add('   FROM XMLCNF ');
    LPendentes.SQL.Add('   INNER JOIN CADFIS ON XMLCNF.CNF_SEQFIS = CADFIS.AUTOINCREM ');
    LPendentes.SQL.Add('    LEFT JOIN XMLNFE ON XMLNFE.NFE_ACESSO = CADFIS.FIS_ACESSO ');
    LPendentes.SQL.Add('  WHERE XMLCNF.CNF_CODEMP = :CODEMP ');
    LPendentes.SQL.Add('    AND XMLCNF.CNF_STATUS = "GE" ');
    LPendentes.SQL.Add('    AND XMLNFE.NFE_ACESSO IS NULL ');
    LPendentes.SQL.Add('    AND CADFIS.FIS_DTAENT <= DATE_SUB(CURRENT_DATE, INTERVAL ' + IntToStr(INTERVAL_DAYS) + ' DAY) ');
    LPendentes.SQL.Add('  LIMIT ' + IntToStr(LIMIT_EXECUTION));
    LPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LPendentes.Open;

    If LPendentes.IsEmpty Then
      Exit;

    LKeys := '';

    LPendentes.First;
    While Not LPendentes.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
        Exit;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' ' + LPendentes.FieldByName('CNF_SEQFIS').AsString);

      If fEmptyStr(LKeys) Then
        LKeys := QuotedStr(LPendentes.FieldByName('CNF_SEQFIS').AsString)
      Else
        LKeys := LKeys + ', ' + QuotedStr(LPendentes.FieldByName('CNF_SEQFIS').AsString);

      LPendentes.Next;
    End;

    UpdateKeys(LKeys, 'ER', 'GE', 'Sem XML');
  Finally
    FreeAndNil(LPendentes);
  End;
end;

function TConfirmaXMLGravacao.FindNodeDouble(const ANode: IXMLNode;
  const ANodeName: String): Double;
  Var
    LXMLNode : IXMLNode;
begin
  LXMLNode := ANode.ChildNodes.FindNode(ANodeName);
  If (Not Assigned(LXMLNode)) Or (LXMLNode.NodeValue = Null) Then
    Result := 0
  Else
    Result := fStrToFloat(AnsiReplaceStr(LXMLNode.NodeValue, '.', ','));
end;

function TConfirmaXMLGravacao.FindNodeString(const ANode : IXMLNode; const ANodeName : String) : String;
  Var
    LXMLNode : IXMLNode;
begin
  LXMLNode := ANode.ChildNodes.FindNode(ANodeName);
  If (Not Assigned(LXMLNode)) Or (LXMLNode.NodeValue = Null) Then
    Result := ''
  Else
    Result := LXMLNode.NodeValue;
end;

function TConfirmaXMLGravacao.GetSQLItens(const ATabela, ATip_FC: String): String;
begin
  Result := '';
  Result := Result + ' SELECT DET_CODITE, DET_DESCRI, DET_QTDITE ';
  Result := Result + '   FROM ' + ATabela;
  Result := Result + '  WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '    AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '    AND DET_CODEMP = :CODEMP ';
  If (ATip_FC = 'C') Then
    Result := Result + '  AND DET_CODCLI = :FORCLI '
  Else
    Result := Result + '  AND DET_CODFOR = :FORCLI ';
  Result := Result + '    AND DET_SERIE_ = :SERIE_ ';
  Result := Result + '    AND DET_TIP_FC = :TIP_FC ';
end;

function TConfirmaXMLGravacao.ItemExiste(const ACodigoItem,
  ADescricaoItem: String; AQuantidadeItem: Double;
  const AItens: TItens): Boolean;
  Var
    LCount : Integer;
begin
  Result := False;
  For LCount := 0 To Length(AItens)-1 Do
  Begin
    If (AItens[LCount].Processado) Then
      Continue;
    If (AItens[LCount].Codigo = ACodigoItem) And
       (AItens[LCount].Descricao = ADescricaoItem) And
       (AItens[LCount].Quantidade = AQuantidadeItem) Then
    Begin
      AItens[LCount].Processado := True;
      Result := True;
      Exit;
    End;
  End;
end;

procedure TConfirmaXMLGravacao.MarcaComoErro(const ASeqFis: String; const AMessage: String);
begin
  UpdateRecord(ASeqFis, 'ER', AMessage);
end;

procedure TConfirmaXMLGravacao.MarcaComoSucesso(const ASeqFis: String);
begin
  UpdateRecord(ASeqFis, 'OK', '');
end;

procedure TConfirmaXMLGravacao.UpdateRecord(const ASeqFis: String; const AStatus, AMessage: String);
  Var
    LUpdate : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LUpdate := fCriaQuery(nil, FConnection);
  Try
    LUpdate.Close;
    LUpdate.SQL.Clear;
    LUpdate.SQL.Add(' UPDATE XMLCNF ');
    LUpdate.SQL.Add('    SET CNF_STATUS = :STATUS, ');
    LUpdate.SQL.Add('        CNF_OBSERV = :OBSERV ');
    LUpdate.SQL.Add('  WHERE CNF_SEQFIS = :SEQFIS ');
    LUpdate.ParamByName('STATUS').AsString := AStatus;
    LUpdate.ParamByName('SEQFIS').AsString := ASeqFis;
    If fEmptyStr(AMessage) Then
      LUpdate.ParamByName('OBSERV').Value := Null
    Else
      LUpdate.ParamByName('OBSERV').AsString := AMessage;
    LUpdate.ExecSQL;
  Finally
    FreeANdNil(LUpdate);
  End;
end;

procedure TConfirmaXMLGravacao.UpdateKeys(const AKeys: String; const ANewStatus, AStatusBefore, AMessage: String);
  Var
    LUpdate : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fEmptyStr(AKeys) Then
    Exit;
  LUpdate := fCriaQuery(nil, FConnection);
  Try
    LUpdate.Close;
    LUpdate.SQL.Clear;
    LUpdate.SQL.Add(' UPDATE XMLCNF ');
    LUpdate.SQL.Add('    SET CNF_STATUS = :NEWSTS, ');
    LUpdate.SQL.Add('        CNF_OBSERV = :OBSERV ');
    LUpdate.SQL.Add('  WHERE CNF_SEQFIS IN ( ' + AKeys + ')');
    LUpdate.SQL.Add('    AND CNF_STATUS = :STSBEF ');
    LUpdate.ParamByName('NEWSTS').AsString := ANewStatus;
    LUpdate.ParamByName('STSBEF').AsString := AStatusBefore;
    LUpdate.ParamByName('OBSERV').AsString := AMessage;
    LUpdate.ExecSQL;
  Finally
    FreeANdNil(LUpdate);
  End;
end;

end.
