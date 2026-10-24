unit untValidaEntRetDocumentoF11;

interface

uses
  Generics.Collections,
  SysUtils,
  untFuncoesSimples,
  Data.DB,
  MemDS,
  DBAccess,
  Uni,
  UniClientDataSet;

type
  TEntRecTypes = (erRetira, erEntregaFutura, erEntregaImediata);

type
  TEntRecItem = Record
    ertTipo: TEntRecTypes;
    blnMesmaLoja: Boolean;
    blnGeraPedido: Boolean;
    blnLocRetCaixa: Boolean;
    blnLocRetBalcao: Boolean;
  end;

type
  TValidaEntRecDocF11 = Class(TList<TEntRecItem>)
    private
      var
        FblnNPDF11: Boolean;
        FblnNPLF11: Boolean;
        FblnNPRF11: Boolean;
        FblnNOTDES: Boolean;
        FstrCodEmp: String;

      procedure pCarregaItens(strNumDoc, strEspDoc, strCodEmp: String);
      procedure pCarregaItensCheckout(cdsItensCheckout: TUniClientDataSet);

      procedure pAddItem(strEmpIte: String;
                         strEntRet: String;
                         strEntFut: String;
                         strLocRet: String;
                         strCodIte: String);

      function fValidaVaiGerarSomentePedidos():Boolean;
    public
      class function fVaiGerarSomentePedidosF11(strNumDoc: String;
                                                strEspDoc: String;
                                                strCodEmp: String;
                                                blnVendaOrigOutraLoja: Boolean;
                                                cdsItensCheckout: TUniClientDataSet = nil):Boolean; static;
  end;


implementation

{ TValidaEntRecDocF11 }

class function TValidaEntRecDocF11.fVaiGerarSomentePedidosF11(strNumDoc: String;
                                                              strEspDoc: String;
                                                              strCodEmp: String;
                                                              blnVendaOrigOutraLoja: Boolean;
                                                              cdsItensCheckout: TUniClientDataSet = nil):Boolean;
Var
  lstEntRec: TValidaEntRecDocF11;

begin
  lstEntRec := TValidaEntRecDocF11.Create();

  lstEntRec.FstrCodEmp := IIF(blnVendaOrigOutraLoja, VS_strCodEmp, strCodEmp);

  lstEntRec.FblnNPDF11 := fCfgSis('NPDF11', VarBoolean);
  lstEntRec.FblnNPLF11 := fCfgSis('NPLF11', VarBoolean);
  lstEntRec.FblnNPRF11 := fCfgSis('NPRF11', VarBoolean);
  lstEntRec.FblnNOTDES := fCfgSis('NOTDES', VarBoolean, strCodEmp);

  Try
    lstEntRec.pCarregaItens(strNumDoc, strEspDoc, strCodEmp);
    lstEntRec.pCarregaItensCheckout(cdsItensCheckout);

    Result := lstEntRec.fValidaVaiGerarSomentePedidos();
  Finally
    FreeAndNil(lstEntRec);
  End;
end;

function TValidaEntRecDocF11.fValidaVaiGerarSomentePedidos: Boolean;
Var
  intIndex: Integer;
begin
  Result := False;

  If (Self.Count = 0) Then
    Exit;

  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    If (Not Self[intIndex].blnGeraPedido) Then
      Exit;
  End;

  Result := True;
end;

procedure TValidaEntRecDocF11.pAddItem(strEmpIte, strEntRet, strEntFut, strLocRet, strCodIte: String);
var
  objItem: TEntRecItem;
  blnNovoPedidoEntregaMesmaLoja,
  blnNovoPedidoRetiraMesmaLoja,
  blnNovoPedidoRetiraOutraLoja: Boolean;

begin
  objItem.ertTipo       := erRetira;
  objItem.blnMesmaLoja  := (strEmpIte = FstrCodEmp);
  objItem.blnLocRetCaixa := (strLocRet = 'C');
  objItem.blnLocRetBalcao := ((strLocRet = 'B') Or (strLocRet = 'B2'));

  blnNovoPedidoEntregaMesmaLoja := FblnNPDF11;
  blnNovoPedidoRetiraMesmaLoja  := FblnNPLF11;
  blnNovoPedidoRetiraOutraLoja  := FblnNPRF11;

  If (fEhItemServico(strCodIte)) Then
  Begin
    blnNovoPedidoEntregaMesmaLoja := False;
    blnNovoPedidoRetiraMesmaLoja  := False;
  End;

  If (strEntRet = 'R') Then
  Begin
    objItem.ertTipo := erRetira;
  End
  Else If (strEntRet = 'E') Then
  Begin
    If (strEntFut = 'S') Then
      objItem.ertTipo := erEntregaFutura
    Else
      objItem.ertTipo := erEntregaImediata;
  End;

  Case objItem.ertTipo Of
    erRetira:
    Begin
      If objItem.blnMesmaLoja Then
      Begin
        If objItem.blnLocRetCaixa Then
          objItem.blnGeraPedido := False
        Else If objItem.blnLocRetBalcao Then
          objItem.blnGeraPedido := blnNovoPedidoRetiraMesmaLoja And (Not FblnNOTDES)
        Else
          objItem.blnGeraPedido := blnNovoPedidoRetiraMesmaLoja;
      End
      Else
        objItem.blnGeraPedido := blnNovoPedidoRetiraOutraLoja;
    End;
    erEntregaFutura:
    Begin
      objItem.blnGeraPedido := False;
    End;
    erEntregaImediata:
    Begin
      objItem.blnGeraPedido := blnNovoPedidoEntregaMesmaLoja;
    End;
  End;

  Self.Add(objItem);
end;

procedure TValidaEntRecDocF11.pCarregaItens(strNumDoc, strEspDoc, strCodEmp: String);
Var
  qryEntRet: TUniQuery;
begin
  qryEntRet := fCriaQuery();

  Try
    qryEntRet.SQL.Add('  SELECT                                ');
    qryEntRet.SQL.Add('    FD.FDO_CODITE,                      ');
    qryEntRet.SQL.Add('    FD.FDO_EMPITE,                      ');
    qryEntRet.SQL.Add('    ED.FDO_ENTRET,                      ');
    qryEntRet.SQL.Add('    FD.FDO_ENTFUT,                      ');
    qryEntRet.SQL.Add('    ED.FDO_LOCRET                       ');
    qryEntRet.SQL.Add('  FROM                                  ');
    qryEntRet.SQL.Add('    FATDOR FD                           ');
    qryEntRet.SQL.Add('    INNER JOIN EXTDOR ED                ');
    qryEntRet.SQL.Add('      ON FD.AUTOINCREM = ED.FDO_SEQFDO  ');
    qryEntRet.SQL.Add('  WHERE FD.FDO_NUMDOC = :NUMDOC         ');
    qryEntRet.SQL.Add('    AND FD.FDO_ESPDOC = :ESPDOC         ');
    qryEntRet.SQL.Add('    AND FD.FDO_CODEMP = :CODEMP         ');

    qryEntRet.ParamByName('NUMDOC').AsString := strNumDoc;
    qryEntRet.ParamByName('ESPDOC').AsString := strEspDoc;
    qryEntRet.ParamByName('CODEMP').AsString := strCodEmp;

    qryEntRet.Open;

    qryEntRet.First;
    While Not qryEntRet.Eof Do
    Begin
      pAddItem(qryEntRet.FieldByName('FDO_EMPITE').AsString,
               qryEntRet.FieldByName('FDO_ENTRET').AsString,
               qryEntRet.FieldByName('FDO_ENTFUT').AsString,
               qryEntRet.FieldByName('FDO_LOCRET').AsString,
               qryEntRet.FieldByName('FDO_CODITE').AsString);

      qryEntRet.Next;
    End;
  Finally
    FreeAndNil(qryEntRet);
  End;
end;


procedure TValidaEntRecDocF11.pCarregaItensCheckout(cdsItensCheckout: TUniClientDataSet);
var
  cdsClone: TUniClientDataSet;
begin
  If Assigned(cdsItensCheckout) And (cdsItensCheckout.Active) Then
  Begin
    cdsClone := TUniClientDataSet.Create(nil);

    Try
      pCloneDataSet(cdsClone, cdsItensCheckout);

      cdsClone.Filter := 'ITE_CHKOUT <> ' + QuotedStr('');
      cdsClone.Filtered := True;

      cdsClone.First;
      While (Not cdsClone.Eof) Do
      Begin
        pAddItem(VS_strCodEmp,
                 cdsClone.FieldByName('ITE_ENTRET').AsString,
                 'N',
                 cdsClone.FieldByName('ITE_LOCRET').AsString,
                 cdsClone.FieldByName('ITE_CODITE').AsString);
        cdsClone.Next;
      End;

    Finally
      FreeAndNil(cdsClone);
    End;
  End;
end;

end.
