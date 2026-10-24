unit untSolicitacaoColorantesTE;

interface

Uses
  Classes, UniClientDataSet, DB, Uni, SysUtils, Forms, Windows, Controls, System.Generics.Collections;

Type
  TSolicitacaoColorantesTE = Class(TObject)
  private
    cdsUsado: TUniClientDataSet;
    Procedure pCriaItens;
    procedure pProcessarQuantidadeEmbalagem;
    procedure pDefinirEmpresasAnalitico;
    procedure pRetornaSaldos(strCodIte: String; var fltCnv_ML, fltSaldoLoja,
      fltSaldoOutras: Double);
    Procedure pCriaUsado;
    Function fJaUtilizado(strCodIte, strCodEmp: String): Double;
  public
    cdsItens: TUniClientDataSet;
    cdsAnalitico: TUniClientDataSet;

    stlLojas: TStringList;

    blnExibeMensagemTransferenciaEstoque: Boolean;
    
    constructor Create; Reintroduce;
    destructor Destroy; Override;

    function fIncluiItem(strCodIte, strDescri: String;
      fltQtdFormula, fltQtdAcumulada: Double; intAutIncTin: Integer): Boolean;

    function fInformaLojas: Boolean;

    { para gravar no campo empsol da tinta }
    function fGetEmpresaTE(intIncTin: Integer): String;
    function fGetQtdSolicitadaTe(intIncTin: Integer):Double;

    function fRetSqlEstoque(ACodigoItens: String): String;

    function fGerarSolicitaoTransferenciasColorantes(strNumDoc, strEspDoc,
      strEmpDoc: String): Boolean;
  End;

implementation

Uses
  UntFuncoesSimples, untSolicitacaoColorantesLojas, Variants,
  untPreparaGeracaoTE;

Procedure TSolicitacaoColorantesTE.pCriaItens;
Begin
  cdsItens := TUniClientDataSet.Create(nil);

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 70;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CNV_ML';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALLOC';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALOUT';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'INCTIN';
    DataType := ftInteger;
  End;

  cdsItens.CreateDataSet;
  cdsItens.Open;

  cdsAnalitico := TUniClientDataSet.Create(nil);
  cdsAnalitico.Data := cdsItens.Data;
End;

procedure TSolicitacaoColorantesTE.pCriaUsado;
begin
  cdsUsado := TUniClientDataSet.Create(Application);

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
  End;

  cdsUsado.CreateDataSet;
  cdsUsado.Open;
end;

procedure TSolicitacaoColorantesTE.pDefinirEmpresasAnalitico;
begin
  cdsAnalitico.First;
  While Not cdsAnalitico.Eof Do
  Begin
    If cdsItens.Locate('CODITE', cdsAnalitico.FieldByName('CODITE')
      .AsString, []) Then
    Begin
      cdsAnalitico.Edit;
      cdsAnalitico.FieldByName('CODEMP').AsString :=
        cdsItens.FieldByName('CODEMP').AsString;
      cdsAnalitico.Post;
    End;
    cdsAnalitico.Next;
  End;
end;

procedure TSolicitacaoColorantesTE.pProcessarQuantidadeEmbalagem;
var
  strCodigo: String;
  fltSalLoj: Double;
  dicSaldos: TDictionary<String,Double>;
begin
  dicSaldos := TDictionary<String,Double>.Create;
  try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      strCodigo := cdsItens.FieldByName('CODITE').AsString;

      fltSalLoj := cdsItens.FieldByName('SALLOC').AsFloat -
        fJaUtilizado(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp);

      dicSaldos.AddOrSetValue(strCodigo, fltSalLoj);
      cdsItens.Next;
    End;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      strCodigo := cdsItens.FieldByName('CODITE').AsString;
      dicSaldos.TryGetValue(strCodigo, fltSalLoj);

      cdsItens.Edit;
      { Ex: preciso de 950 ml de um colorante porem a embalagem do mesmo tem 300 ml cada,
        teriamos 950 / 300 = 3.1666666, arredondando para cima teria que solicitar
        4 embalagens para atender os 950 ml. }
      cdsItens.FieldByName('QTDITE').AsFloat := cdsItens.FieldByName('QTDITE')
        .AsFloat / cdsItens.FieldByName('CNV_ML').AsFloat;

      If Frac(cdsItens.FieldByName('QTDITE').AsFloat) <> 0.0 Then
        cdsItens.FieldByName('QTDITE').AsFloat :=
          Int(cdsItens.FieldByName('QTDITE').AsFloat) + 1;

      If fltSalLoj > 0 Then
      Begin
        If fltSalLoj >= cdsItens.FieldByName('QTDITE').AsFloat Then
        Begin
          fltSalLoj := fltSalLoj - cdsItens.FieldByName('QTDITE').AsFloat;
          cdsItens.FieldByName('QTDITE').AsFloat := 0;
        End
        Else
        Begin
          cdsItens.FieldByName('QTDITE').AsFloat :=
            cdsItens.FieldByName('QTDITE').AsFloat - fltSalLoj;
          fltSalLoj := 0;
        End;
        dicSaldos.AddOrSetValue(strCodigo, fltSalLoj);
      End;

      cdsItens.Post;
      cdsItens.Next;
    End;
  finally
    dicSaldos.Free;
    cdsItens.First;
  end;
end;

Constructor TSolicitacaoColorantesTE.Create;
Begin
  blnExibeMensagemTransferenciaEstoque := False;

  stlLojas := TStringList.Create;
  stlLojas.Sorted := True;
  stlLojas.Duplicates := dupIgnore;

  pCriaItens;
  pCriaUsado;
End;

Destructor TSolicitacaoColorantesTE.Destroy;
Begin
  cdsItens.EmptyDataSet;
  cdsItens.Close;
  FreeAndNil(cdsItens);

  stlLojas.Clear;

  FreeAndNil(stlLojas);

  cdsUsado.EmptyDataSet;
  cdsUsado.Close;
  FreeAndNil(cdsUsado);

  cdsAnalitico.EmptyDataSet;
  cdsAnalitico.Close;
  FreeAndNil(cdsAnalitico);

  inherited;
End;

function TSolicitacaoColorantesTE.fGerarSolicitaoTransferenciasColorantes
  (strNumDoc, strEspDoc, strEmpDoc: String): Boolean;
Var
  strSeqPTe: String;
begin
  Result := True;
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If (cdsItens.FieldByName('CODEMP').AsString <> '') And
      (cdsItens.FieldByName('CODEMP').AsString <> VS_strCodEmp) Then
    Begin
      Result := TPreparaGeracaoTE.fGravarPreparaGeracaoTE_MultiLoja(strNumDoc,
        strEspDoc, strEmpDoc, cdsItens.FieldByName('CODITE').AsString,
        cdsItens.FieldByName('CODEMP').AsString, VS_strCodEmp, '',
        cdsItens.FieldByName('QTDITE').AsFloat, strSeqPTe);
    End;
    If Not Result Then
      Break;
    cdsItens.Next;
  End;
end;

function TSolicitacaoColorantesTE.fGetEmpresaTE(intIncTin: Integer): String;
var
  intIndice: Integer;
begin
  Result := '';
  With cdsItens Do
  Begin

    If Locate('INCTIN', IntToStr(intIncTin) , []) Then
    Begin
      Result := FieldByName('CODEMP').AsString;

      If (Not stlLojas.Find(Result, intIndice)) Then
        If (Not fEmptyStr(Result)) Then
        stlLojas.Add(Result);
    End;

  End;

end;


function TSolicitacaoColorantesTE.fGetQtdSolicitadaTe(
  intIncTin: Integer): Double;
begin
  Result := 0;

  if cdsItens.Locate('INCTIN', intIncTin, []) then
  begin
    Result := cdsItens.FieldByName('QTDITE').AsFloat
  end;
end;

Function TSolicitacaoColorantesTE.fIncluiItem(strCodIte, strDescri: String;
  fltQtdFormula, fltQtdAcumulada: Double; intAutIncTin: Integer): Boolean;
Var
  fltCnv_ML, fltSaldoLoja, fltSaldoOutras: Double;

  procedure pAdicionarItem(DataSet: TDataSet; fltQtdIte: Double);
  begin
    DataSet.Append;
    DataSet.FieldByName('CODITE').AsString := strCodIte;
    DataSet.FieldByName('DESCRI').AsString := strDescri;
    DataSet.FieldByName('QTDITE').AsFloat := fltQtdIte;
    DataSet.FieldByName('CNV_ML').AsFloat := fltCnv_ML;
    DataSet.FieldByName('SALLOC').AsFloat := fltSaldoLoja;
    DataSet.FieldByName('SALOUT').AsFloat := fltSaldoOutras;
    DataSet.FieldByName('INCTIN').AsInteger := intAutIncTin;
    DataSet.Post;
  end;

Begin
  Result := True;

  pRetornaSaldos(strCodIte, fltCnv_ML, fltSaldoLoja, fltSaldoOutras);

  pAdicionarItem(cdsItens, fltQtdFormula);

  pAdicionarItem(cdsAnalitico, fltQtdFormula);

End;

Function TSolicitacaoColorantesTE.fInformaLojas: Boolean;
Var
  frmPedeLojas: TfrmSolicitacaoColorantesLojas;
Begin
  If cdsItens.IsEmpty Then
    Exit(True);

  pProcessarQuantidadeEmbalagem;

  pCriarFormularios(TfrmSolicitacaoColorantesLojas, frmPedeLojas);
  Try
    (cdsItens.FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('SALLOC') As TFloatField).DisplayFormat := '#,##0.000';
    (cdsItens.FieldByName('SALOUT') As TFloatField).DisplayFormat := '#,##0.000';

    frmPedeLojas.objSolColorantesTE := Self;

    frmPedeLojas.dtsItens.DataSet := cdsItens;

    cdsItens.IndexFieldNames := 'CODITE';
    cdsItens.BeforePost := frmPedeLojas.pItensLojaBeforePost;
    cdsItens.AfterInsert := frmPedeLojas.pItensLojaAfterInsert;
    cdsItens.AfterScroll := frmPedeLojas.pItensLojaAfterScroll;
    cdsItens.First;

    while not cdsItens.Eof do
    begin
      if cdsItens.FieldByName('QTDITE').AsFloat <= 0 then
      begin
        cdsItens.Delete;
        cdsItens.Prior;
      end;
      cdsItens.Next;
    end;

     cdsItens.First;

    Result := True;

    if not cdsItens.IsEmpty then
    Begin
      If (Self.blnExibeMensagemTransferenciaEstoque) Then
      Begin          
        fMensagem('','Há produtos que não possuem saldo suficiente para este documento!' + #13#10 +
                     'Será exibida a tela para Transferência de Estoque.', ['&Ok']);

      End;

      Result := frmPedeLojas.ShowModal = mrOk
    End;
    
  Finally
    cdsItens.BeforePost := nil;
    cdsItens.AfterInsert := nil;
    cdsItens.AfterScroll := nil;
    pFreeAndNil(frmPedeLojas);
  End;

  If Result Then
    pDefinirEmpresasAnalitico;
End;



function TSolicitacaoColorantesTE.fJaUtilizado(strCodIte,
  strCodEmp: String): Double;
begin

  If Not cdsUsado.Locate('CODITE;CODEMP;', VarArrayOf([strCodIte, strCodEmp]), []) Then
  Begin
    cdsUsado.Insert;
    cdsUsado.FieldByName('CODEMP').AsString := strCodEmp;
    cdsUsado.FieldByName('CODITE').AsString := strCodIte;
    cdsUsado.FieldByName('QTDITE').AsFloat  := 0;
    cdsUsado.Post;
  End;

  Result := cdsUsado.FieldByName('QTDITE').AsFloat;

end;

procedure TSolicitacaoColorantesTE.pRetornaSaldos(strCodIte: String;
  var fltCnv_ML, fltSaldoLoja, fltSaldoOutras: Double);
Var
  qrySaldo: TUniQuery;
begin
  fltSaldoLoja := 0;
  fltSaldoOutras := 0;
  qrySaldo := fCriaQuery();
  Try
    qrySaldo.SQL.Text := fRetSqlEstoque(strCodIte.QuotedString);
    qrySaldo.Open;
    qrySaldo.First;
    While Not qrySaldo.Eof Do
    Begin
      If qrySaldo.FieldByName('EMP_CODEMP').AsString = VS_strCodEmp Then
        fltSaldoLoja := qrySaldo.FieldByName('ITE_SALDIS').AsFloat
      Else
        fltSaldoOutras := fltSaldoOutras + qrySaldo.FieldByName
          ('ITE_SALDIS').AsFloat;
      qrySaldo.Next;
    End;
    fltCnv_ML := qrySaldo.FieldByName('ITE_CNV_ML').AsFloat;
    If fltCnv_ML = 0 Then
      fltCnv_ML := 1;
  Finally
    qrySaldo.Free();
  End;
end;

function TSolicitacaoColorantesTE.fRetSqlEstoque(ACodigoItens: String): String;
Var
  LSQLSaldos, LSQLDisponivel, LSQLReservado, LSQLEntFutura: String;
begin
  LSQLSaldos := 'G.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('G', True);
  LSQLDisponivel := fSQLSaldoDisponivel('G', True);
  LSQLReservado := '(' + LSQLSaldos + ') - (' + LSQLDisponivel + ')';
  LSQLEntFutura :=
    'IFNULL(ITE_QTEF_P,0) + IFNULL(ITE_QTEF_F,0) + IFNULL(ITE_QTEF_A,0) + IFNULL(ITE_QTPDBF,0)';

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  E.EMP_CODEMP, ';
  Result := Result + '  G.ITE_CODITE, ';
  Result := Result + '  C.ITE_CNV_ML, ';
  Result := Result + '  CONCAT(E.EMP_CODEMP,"-",E.EMP_NOMFAN) AS EMP_NOMEMP, ';
  Result := Result + '  ( ' + LSQLSaldos + ') AS ITE_SALDOS, ';
  Result := Result + '  ( ' + LSQLDisponivel + ') AS ITE_SALDIS, ';
  Result := Result + '  ( ' + LSQLReservado + ') AS ITE_SALRES, ';
  Result := Result + '  ( ' + LSQLEntFutura + ') AS ITE_ENTFUT  ';
  Result := Result + 'FROM ';
  Result := Result + '  ITEGER G ';
  Result := Result + 'INNER JOIN CADITE C ';
  Result := Result + '  ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'INNER JOIN CADEMP E ';
  Result := Result + '  ON E.EMP_CODEMP = G.ITE_CODEMP ';
  Result := Result + 'WHERE G.ITE_CODITE IN (' + ACodigoItens + ')';
  Result := Result + ' AND LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
end;

end.
