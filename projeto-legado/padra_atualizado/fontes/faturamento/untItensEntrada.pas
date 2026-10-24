unit untItensEntrada;

interface

Uses
  Windows,
  Forms,
  SysUtils,
  Controls,
  Uni,
  ComCtrls,
  Data.DB,
  untTypesSistema;

Type
  TItensEntrada = Class(TObject)
  Private

    Function fCarregaItensFatVenda(qryItens: TUniQuery;
      prbProgresso: TProgressBar; fIncluiItem: TfIncluiItem; blnPreNot: Boolean;
      strCliFil: String = ''; blnOutraSaidas: Boolean = false;
      strTabPre: String = ''; blnConEqu: Boolean = false;
      blnEmpresaParaFaturamentoUsaWMS: Boolean = false; strCodEmp: String = '';
      blnUtilizarQtde1: Boolean = False): Boolean;

    function fGetSQLItensRemessa(strCodEmp: String): String;
    function fCarregarItemRemessa(qryItens: TUniQuery; strAutincIteRemessa, strCodEmp: String): Boolean;
    function fCarregarTodosItensRemessa(qryItens: TUniQuery; strAutincRemessa, strCodEmp: String): Boolean;

    function RetornarPrecoItensVenda(qryItens: TUniQuery;
      blnOutraSaidas: Boolean; strCliFil: String; blnPreNot: Boolean;
      strTabPre: String; blnConEqu: Boolean = false): Double;
    function RetornarPrecoOpcoesOutrasSaidas(const OutrasSaidas,
      AConsertoDeEquipamentos: Boolean): Boolean;

    function fRetornaNumLot(qryItens: TUniQuery; blnEmpresaParaFaturamentoUsaWMS: Boolean; strCodEmp: String;
      blnConEqu: Boolean = False): String;

  Public
    blnPrecoFaturamento: Boolean;

    Function fCarregaItensNotaEntrada(prbProgresso: TProgressBar;
      fIncluiItem: TfIncluiItem; strCliFil: String = '';
      blnOutraSaidas: Boolean = false; strTabPre: String = '';
      blnConEqu: Boolean = false;
      blnEmpresaParaFaturamentoUsaWMS: Boolean = false; strCodEmp: String = '';
      blnDocumentoFornecedor: Boolean = False): Boolean;
    function fCarregaItensNotaEntradaRemessa(prbProgresso: TProgressBar; fIncluiItem: TfIncluiItem; strAutincIteRemessa,
      strCodEmp: String; blnConEqu: Boolean = False; blnUtilizarQtde1: Boolean = False; strAutincGerRemessa: String = ''): Boolean;
    Function fCarregaItensOrdemServico(prbProgresso: TProgressBar;
      fIncluiItem: TfIncluiItem; strAutIncOsSel, strCodEmp: String): Boolean;
  End;

implementation

Uses
  untFatItensNotaEntrada, untFuncoesSimples, untConstantes, untCadLote;

Function TItensEntrada.fCarregaItensNotaEntrada(prbProgresso: TProgressBar;
  fIncluiItem: TfIncluiItem; strCliFil: String = '';
  blnOutraSaidas: Boolean = false; strTabPre: String = '';
  blnConEqu: Boolean = false;
  blnEmpresaParaFaturamentoUsaWMS: Boolean = false; strCodEmp: String = '';
  blnDocumentoFornecedor: Boolean = False): Boolean;
Begin
  pCriarFormularios(TfrmFatItensNotaEntrada, frmFatItensNotaEntrada);
  Try
    frmFatItensNotaEntrada.blnOutrasSaidas := blnOutraSaidas;
    frmFatItensNotaEntrada.blnConEqu := blnConEqu;
    frmFatItensNotaEntrada.blnDocumentoFornecedor := blnDocumentoFornecedor;
    With frmFatItensNotaEntrada Do
      Result := (ShowModal = mrOk) And
        fCarregaItensFatVenda(
          qryItens,
          prbProgresso,
          fIncluiItem,
          rdgUtiPre.ItemIndex = 0,
          strCliFil,
          blnOutraSaidas,
          strTabPre,
          blnConEqu,
          blnEmpresaParaFaturamentoUsaWMS,
          strCodEmp);

    blnPrecoFaturamento := frmFatItensNotaEntrada.rdgUtiPre.ItemIndex = 2;
  Finally
    FreeAndNil(frmFatItensNotaEntrada);
  End;
End;

function TItensEntrada.fCarregaItensNotaEntradaRemessa(prbProgresso: TProgressBar; fIncluiItem: TfIncluiItem;
  strAutincIteRemessa, strCodEmp: String; blnConEqu: Boolean = False; blnUtilizarQtde1: Boolean = False; strAutincGerRemessa: String = ''): Boolean;
Var
  qryItens: TUniQuery;
begin
  Try
    qryItens := fCriaQuery(Nil);

    if (not fEmptyStr(strAutincGerRemessa)) then
      Result := fCarregarTodosItensRemessa(qryItens, strAutincGerRemessa, strCodEmp)
    else
      Result := fCarregarItemRemessa(qryItens, strAutincIteRemessa, strCodEmp);

    Result := Result and fCarregaItensFatVenda(qryItens, prbProgresso, fIncluiItem, True, '',
                                 False, '', blnConEqu, False, '', blnUtilizarQtde1);
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TItensEntrada.fCarregaItensOrdemServico(prbProgresso: TProgressBar;
  fIncluiItem: TfIncluiItem; strAutIncOsSel, strCodEmp: String): Boolean;
Var
  qryItens: TUniQuery;
begin
  Try
    qryItens := fCriaQuery(Nil);

    Result := (fCarregarItemRemessa(qryItens, strAutIncOsSel, strCodEmp)) And
      (fCarregaItensFatVenda(qryItens, prbProgresso, fIncluiItem, True));
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TItensEntrada.fCarregarItemRemessa(qryItens: TUniQuery; strAutincIteRemessa, strCodEmp: String): Boolean;
begin
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(fGetSQLItensRemessa(strCodEmp));
  qryItens.SQL.Add('WHERE D.AUTOINCREM IN ( ' + QuotedStr(strAutincIteRemessa) + ' )');
  qryItens.Open;

  Result := not qryItens.IsEmpty;
End;


function TItensEntrada.fCarregarTodosItensRemessa(qryItens: TUniQuery; strAutincRemessa, strCodEmp: String): Boolean;
begin
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(fGetSQLItensRemessa(strCodEmp));
  qryItens.SQL.Add('WHERE D.DET_SEQGER = ' + QuotedStr(strAutincRemessa));
  qryItens.Open;

  Result := (not qryItens.IsEmpty);
end;

function TItensEntrada.fGetSQLItensRemessa(strCodEmp: String): String;
var
  strTePrev,
  strPreIte: String;
begin
  strTePrev := fGetTEPREV(VS_strCodEmp, fRetornaClienteFilial(strCodEmp));

  if SameText(strTePrev, 'IMP') then
    strPreIte := 'ITE_IMPULT'
  else
    strPreIte := 'ITE_PRE' + strTePrev;

  Result := '';
  Result := Result + ' SELECT D.*, ' + strPreIte + ' AS PRECO_TE, T.DET_NCMITE ';
  Result := Result + ' FROM MOVDET D ';
  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
end;

function TItensEntrada.RetornarPrecoOpcoesOutrasSaidas(
Const OutrasSaidas : Boolean; Const AConsertoDeEquipamentos : Boolean)  : Boolean;
begin
  Result := false;

  if Not OutrasSaidas Then
    Exit;

  If AConsertoDeEquipamentos Then
    Exit;

  Result := true;
end;


function TItensEntrada.fRetornaNumLot(qryItens: TUniQuery; blnEmpresaParaFaturamentoUsaWMS: Boolean; strCodEmp: String;
  blnConEqu: Boolean = False): String;
var
  objCadLot: TCadLot;
begin
  Result := '';

  objCadLot := TCadLot.Create(nil);
  Try

    if blnEmpresaParaFaturamentoUsaWMS then
      Result := 'A DEFINIR'
    Else if fCfgSis('LOTIM2') = 'P' then
    Begin
      If Not objCadLot.fItemSemNenhumLoteEmpresa(qryItens.FieldByName('DET_CODITE').AsString) Then
        Result := objCadLot.fRetArmazemPrincipalVenda(qryItens.FieldByName('DET_CODITE').AsString);
    End
    Else
    Begin
      if objCadLot.fExisteLote(qryItens.FieldByName('DET_CODITE').AsString,
                               strCodEmp,
                               qryItens.FieldByName('DET_NUMLOT').AsString) then
        Result := qryItens.FieldByName('DET_NUMLOT').AsString
      else
        Result := '';

      if ((Result = 'A DEFINIR') and blnConEqu) then
        Result := objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(qryItens.FieldByName('DET_CODITE').AsString);
    End;

  Finally
    FreeAndNil(objCadLot);
  End;
end;

function TItensEntrada.RetornarPrecoItensVenda(qryItens: TUniQuery;
  blnOutraSaidas: Boolean; strCliFil: String; blnPreNot: Boolean;
  strTabPre: String; blnConEqu: Boolean = false): Double;
begin
  Result := qryItens.FieldByName('PRECO_TE').AsFloat;

  if RetornarPrecoOpcoesOutrasSaidas(blnOutraSaidas, blnConEqu)then
  begin
    Result := qryItens.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
    Exit;
  end;

  If blnPreNot Then
  begin
    Result := qryItens.FieldByName('DET_UNITAR').AsFloat;
    Exit;
  end;

  If Not fEmptyStr(strCliFil) Then
  Begin
    Result := fGetValorVendaParaFilial(strCliFil,
      qryItens.FieldByName('DET_CODITE').AsString,
      CST_SUBSTITUICAO.Contains(qryItens.FieldByName('DET_CODFIS').AsString));
  End

end;

Function TItensEntrada.fCarregaItensFatVenda(qryItens: TUniQuery;
  prbProgresso: TProgressBar; fIncluiItem: TfIncluiItem; blnPreNot: Boolean;
  strCliFil: String = ''; blnOutraSaidas: Boolean = false;
  strTabPre: String = ''; blnConEqu: Boolean = false;
  blnEmpresaParaFaturamentoUsaWMS: Boolean = false; strCodEmp: String = '';
  blnUtilizarQtde1: Boolean = False): Boolean;

Var
  fltPreco: Double;
  strNumLot: String;
Begin
  Result := false;

  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  prbProgresso.Visible := True;
  prbProgresso.Position := 0;
  prbProgresso.Max := qryItens.RecordCount;

  qryItens.First;

  While Not qryItens.Eof Do
  Begin
    fltPreco :=
      RetornarPrecoItensVenda(
        qryItens,
        blnOutraSaidas,
        strCliFil,
        blnPreNot,
        strTabPre,
        blnConEqu);

    strNumLot := fRetornaNumLot(qryItens, blnEmpresaParaFaturamentoUsaWMS, strCodEmp, blnConEqu);

    Result := fIncluiItem(
      qryItens.FieldByName('DET_CODITE').AsString,
      strNumLot,
      IIF(blnUtilizarQtde1, 1, qryItens.FieldByName('DET_QTDITE').AsFloat),
      fltPreco,
      '',
      qryItens.FieldByName('DET_DESCRI').AsString,
      qryItens.FieldByName('DET_NCMITE').AsString,
      0,
      '',
      blnPreNot);

    If Not Result Then
      Break;

    qryItens.Next;
    prbProgresso.StepBy(1);
    Application.ProcessMessages;
  End; { While }

  prbProgresso.Visible := False;
End;

end.
