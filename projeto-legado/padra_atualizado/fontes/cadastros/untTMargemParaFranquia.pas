unit untTMargemParaFranquia;

interface

uses Data.DB, System.Classes, System.SysUtils, untFuncoesSimples, untZClient, UniClientDataSet, Uni, untParCalculaPrecoCusto;

  Type
    TFieldsMargem = Record
      FPreCom,
      FDesF01,
      FDesF02,
      FDesF03,
      FDesF04,
      FDesF05,
      FDesF06,
      FFreEnt,
      FAcrFin,
      FValFre,
      FOutVal,
      FDesOpe,
      FComis1,
      FComis2,
      FComis3,
      FComis4,
      FComis5,
      FComis6,
      FComis7: Double;
      strMarMkp: String;
      FBlnPredol: Boolean;
    End;

    TMargemParaFranquia = class
    private
      cdsDados: TZClient;
      qryComand: TUniQuery;
      FFieldsMargem: TFieldsMargem;
      FcpcParams: TParCalculaPrecoCusto;

      procedure pCalculaAjustaPrecosDeVenda(blnRecalculaCusto: Boolean);
      procedure pCalculaCusto;
      procedure pCalculaPrecoDeVenda(intTabPre: integer);
      procedure pCalculaMargemBruta(intTabPre: integer);
      function  fRetComissao(intTabPre: integer): Double;
    private
      procedure OnBeforPost(DataSet: TDataSet);
      procedure pMontaSQl(ACodIte: String);
    public
      dtsDados: TDataSource;
      blnEditou: Boolean;
      indexFocused: integer;
      constructor Create(strCodIte: string);
      destructor Destroy; override;
      procedure pCarregaMargemParaFranquia(strCodite, strDesite: String; cpcParams: TParCalculaPrecoCusto; AFieldsMargem: TFieldsMargem);
      procedure pPersisteDados;
      procedure pHerancaItem(strCodIte: String; strCodIteHerdado: string);
  End;



implementation

uses untMargemParaFranquia;

{ TMargemParaFranquia }

procedure TMargemParaFranquia.pMontaSQl(ACodIte: String);
Begin
  cdsDados.qryQuery.SQL.Add('SELECT F.*,');
  cdsDados.qryQuery.SQL.Add('       CONCAT("Empresa:", EMP_CODEMP, "-", EMP_NOMEMP, "-", CID_ESTADO, "-", CID_NOMCID) EMPRESA,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_PRECOM,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF01,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF02,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF03,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF04,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF05,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_OUTVAL,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESF06,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_FREENT,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_ACRFIN,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_DESOPE,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_VALFRE,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB1,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB2,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB3,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB4,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB5,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB6,');
  cdsDados.qryQuery.SQL.Add('       G.ITE_COMTB7');
  cdsDados.qryQuery.SQL.Add('  FROM ITERFI F');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN CADEMP ON EMP_CODEMP = ITE_CODEMP');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = F.ITE_CODITE');
  cdsDados.qryQuery.SQL.Add('                   AND G.ITE_CODEMP = F.ITE_CODEMP');
  cdsDados.qryQuery.SQL.Add(' WHERE G.ITE_CODITE = "'+ACodIte+'"');
End;

constructor TMargemParaFranquia.Create(strCodIte: string);
begin
  dtsDados := TDataSource.Create(nil);
  cdsDados := TZClient.Create(nil);
  pMontaSQl(strCodIte);
  cdsDados.fAbreClient(False, '[TMargemParaFranquia.Create]');
  dtsDados.DataSet := cdsDados;
  blnEditou := False;
end;

destructor TMargemParaFranquia.Destroy;
begin
  FreeAndNil(dtsDados);
  inherited;
end;

procedure TMargemParaFranquia.pCalculaCusto;
var blnEmpresaLogada: Boolean;
begin
  blnEmpresaLogada := cdsDados.FieldByName('ITE_CODEMP').ASString = VS_StrCodemp;
  FcpcParams.curPreCom := IIf(blnEmpresaLogada, FFieldsMargem.FPrecom, cdsDados.FieldByName('ITE_PRECOM').AsFloat);
  FcpcParams.curDesF01 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF01, cdsDados.FieldByName('ITE_DESF01').AsFloat);
  FcpcParams.curDesF02 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF02, cdsDados.FieldByName('ITE_DESF02').AsFloat);
  FcpcParams.curDesF03 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF03, cdsDados.FieldByName('ITE_DESF03').AsFloat);
  FcpcParams.curDesF04 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF04, cdsDados.FieldByName('ITE_DESF04').AsFloat);
  FcpcParams.curDesF05 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF05, cdsDados.FieldByName('ITE_DESF05').AsFloat);
  FcpcParams.curDesF06 := IIf(blnEmpresaLogada, FFieldsMargem.FDesF06, cdsDados.FieldByName('ITE_DESF06').AsFloat);
  FcpcParams.curICMSEnt:= cdsDados.FieldByName('ITE_ICMENT').AsFloat;
  FcpcParams.curIPIEnt := cdsDados.FieldByName('ITE_IPIENT').AsFloat;
  FcpcParams.curFrete  := IIf(blnEmpresaLogada, FFieldsMargem.FFreEnt, cdsDados.FieldByName('ITE_FREENT').AsFloat);
  FcpcParams.curAcrFin := IIf(blnEmpresaLogada, FFieldsMargem.FAcrFin, cdsDados.FieldByName('ITE_ACRFIN').AsFloat);
  FcpcParams.curSubsti := cdsDados.FieldByName('ITE_SUBSTI').AsFloat;
  FcpcParams.curValFre := IIf(blnEmpresaLogada, FFieldsMargem.FValFre, cdsDados.FieldByName('ITE_VALFRE').AsFloat);
  FcpcParams.curDesAdb := cdsDados.FieldByName('ITE_DESADB').AsFloat;
  FcpcParams.curSubFed := cdsDados.FieldByName('ITE_SUBFED').AsFloat;
  FcpcParams.curTCIFCu := 0;
  FcpcParams.curTSCust := 0;
  FcpcParams.curDePiCo := 0;
  FcpcParams.curDeICMS := 0;
  FcpcParams.curFatReg := 0;
  cdsDados.FieldByName('ITE_PRECUS').AsFloat := FcpcParams.fCalculaPrecoCusto(FFieldsMargem.FBlnPredol);
  cdsDados.FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(cdsDados.FieldByName('ITE_PRECUS').AsFloat,
                                                                  cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                                                  cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                                                  IIf(blnEmpresaLogada, FFieldsMargem.FDesOpe, cdsDados.FieldByName('ITE_DESOPE').AsFloat),
                                                                  IIf(blnEmpresaLogada, FFieldsMargem.FOutVal, cdsDados.FieldByName('ITE_OUTVAL').AsFloat));
End;

procedure TMargemParaFranquia.pCalculaPrecoDeVenda(intTabPre: integer);
Begin
  cdsDados.FieldByName('ITE_PREVE' + intTabPre.ToString).AsFloat := fCalculaPrecoVenda(1,
                                                                                       cdsDados.FieldByName('ITE_PRECUS').AsFloat +  FFieldsMargem.FOutVal,
                                                                                       0,
                                                                                       cdsDados.FieldByName('ITE_MARBR' + intTabPre.ToString).AsFloat,
                                                                                       cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                                                                       cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                                                                       FFieldsMargem.FDesOpe,
                                                                                       fRetComissao(intTabPre));

End;

procedure TMargemParaFranquia.pCalculaMargemBruta(intTabPre: integer);
Begin
  cdsDados.FieldByName('ITE_MARBR' + intTabPre.ToString).AsFloat := fCalculaPrecoVenda(2,
                                                                                       cdsDados.FieldByName('ITE_PRECUS').AsFloat +  FFieldsMargem.FOutVal,
                                                                                       cdsDados.FieldByName('ITE_PREVE' + intTabPre.ToString).AsFloat,
                                                                                       cdsDados.FieldByName('ITE_MARBR' + intTabPre.ToString).AsFloat,
                                                                                       cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                                                                       cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                                                                       FFieldsMargem.FDesOpe,
                                                                                       fRetComissao(intTabPre));

End;

function TMargemParaFranquia.fRetComissao(intTabPre: integer): Double;
begin
  Result := 0;
  case intTabPre of
   1: Result := FFieldsMargem.FComis1;
   2: Result := FFieldsMargem.FComis2;
   3: Result := FFieldsMargem.FComis3;
   4: Result := FFieldsMargem.FComis4;
   5: Result := FFieldsMargem.FComis5;
   6: Result := FFieldsMargem.FComis6;
   7: Result := FFieldsMargem.FComis7;
  End;
End;

procedure TMargemParaFranquia.OnBeforPost(DataSet: TDataSet);
begin
  If indexFocused > 0 Then
    If indexFocused > 10 Then
      pCalculaMargemBruta(indexFocused - 10)
    else
      pCalculaPrecoDeVenda(indexFocused);
end;

procedure TMargemParaFranquia.pCalculaAjustaPrecosDeVenda(blnRecalculaCusto: Boolean);
var i: integer;
begin
  cdsDados.First;
  while not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    If blnRecalculaCusto Then
      pCalculaCusto;
    For i := 1 To 7 do
      pCalculaPrecoDeVenda(i);
    cdsDados.Post;
    cdsDados.Next;
  End;
end;

procedure TMargemParaFranquia.pCarregaMargemParaFranquia(strCodite, strDesite: String; cpcParams: TParCalculaPrecoCusto; AFieldsMargem: TFieldsMargem);
  var
    frmMargemParaFranquia: TfrmMargemParaFranquia;
    cdsBkp: TUniClientDataSet;
begin
  pCriarFormularios(TfrmMargemParaFranquia, frmMargemParaFranquia);
  cdsBkp := TUniClientDataSet.Create(nil);
  Try
    cdsBkp.Data := cdsDados.Data;
    frmMargemParaFranquia.cxvDados.DataController.DataSource := dtsDados;
    frmMargemParaFranquia.lblSelecionado.Caption := strCodIte + ' - ' + strDesIte;
    frmMargemParaFranquia.MargemParaFranquia := Self;
    FFieldsMargem := AFieldsMargem;
    frmMargemParaFranquia.strMarMkp := FFieldsMargem.strMarMkp;
    FcpcParams := cpcParams;

    pCalculaAjustaPrecosDeVenda(True);

    cdsDados.BeforePost := OnBeforPost;
    frmMargemParaFranquia.ShowModal;
    If Not frmMargemParaFranquia.blnConfirma Then
      cdsDados.Data := cdsBkp.Data
    Else
      blnEditou := True;
  Finally
    freeAndNil(cdsBkp);
    pFreeAndNil(frmMargemParaFranquia);
  End;
end;

procedure TMargemParaFranquia.pPersisteDados;
begin
  If blnEditou Then
  Begin
    qryComand := fCriaQuery;
    Try
      qryComand.SQL.Add('UPDATE ITERFI ');
      qryComand.SQL.Add('   SET ITE_MARBR1 = :MARBR1,');
      qryComand.SQL.Add('       ITE_MARBR2 = :MARBR2,');
      qryComand.SQL.Add('       ITE_MARBR3 = :MARBR3,');
      qryComand.SQL.Add('       ITE_MARBR4 = :MARBR4,');
      qryComand.SQL.Add('       ITE_MARBR5 = :MARBR5,');
      qryComand.SQL.Add('       ITE_MARBR6 = :MARBR6,');
      qryComand.SQL.Add('       ITE_MARBR7 = :MARBR7,');
      qryComand.SQL.Add('       ITE_PRECUS = :PRECUS,');
      qryComand.SQL.Add('       ITE_CUSREA = :CUSREA,');
      qryComand.SQL.Add('       ITE_ULTALT = :ULTALT,');
      qryComand.SQL.Add('       ITE_OPEALT = :OPEALT ');
      qryComand.SQL.Add(' WHERE AUTOINCREM = :AUTINC');

      cdsDados.First;
      while not cdsDados.EoF Do
      Begin
        qryComand.ParamByName('MARBR1').AsFloat := cdsDados.FieldByName('ITE_MARBR1').AsFloat;
        qryComand.ParamByName('MARBR2').AsFloat := cdsDados.FieldByName('ITE_MARBR2').AsFloat;
        qryComand.ParamByName('MARBR3').AsFloat := cdsDados.FieldByName('ITE_MARBR3').AsFloat;
        qryComand.ParamByName('MARBR4').AsFloat := cdsDados.FieldByName('ITE_MARBR4').AsFloat;
        qryComand.ParamByName('MARBR5').AsFloat := cdsDados.FieldByName('ITE_MARBR5').AsFloat;
        qryComand.ParamByName('MARBR6').AsFloat := cdsDados.FieldByName('ITE_MARBR6').AsFloat;
        qryComand.ParamByName('MARBR7').AsFloat := cdsDados.FieldByName('ITE_MARBR7').AsFloat;
        qryComand.ParamByName('PRECUS').AsFloat := cdsDados.FieldByName('ITE_PRECUS').AsFloat;
        qryComand.ParamByName('CUSREA').AsFloat := cdsDados.FieldByName('ITE_CUSREA').AsFloat;
        qryComand.ParamByName('ULTALT').AsDateTime := fNow;
        qryComand.ParamByName('OPEALT').AsString   := strLoginUsuarioLogado;
        qryComand.ParamByName('AUTINC').AsString   := cdsDados.FieldByName('AUTOINCREM').AsString;
        qryComand.ExecSQL;
        cdsDados.Next;
      End;
    Finally
      FreeAndNil(qryComand);
    End;
  End;
end;


procedure TMargemParaFranquia.pHerancaItem(strCodIte: String; strCodIteHerdado: string);
var
  qryHeranca,
  qryIncluir: TUniQuery;
  intIndex : Integer;
Begin

  Try
    qryIncluir := fCriaQuery;
    qryIncluir.SQL.Text := ' SELECT * FROM ITERFI WHERE FALSE ';
    qryIncluir.Open;

    qryHeranca := fCriaQuery;
    qryHeranca.SQL.Text := ' SELECT * FROM ITERFI WHERE ITE_CODITE = :CODITE ';
    qryHeranca.ParamByName('CODITE').AsString := strCodIteHerdado;
    qryHeranca.Open;

    While Not qryHeranca.Eof Do
    Begin
      qryIncluir.Append;
      For intIndex := 0 To qryHeranca.Fields.Count -1 Do
      Begin
        qryIncluir.Fields[intIndex].Value := qryHeranca.FieldByName(qryIncluir.Fields[intIndex].FieldName).Value;
      End;
      qryIncluir.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITERFI', qryHeranca.FieldByName('ITE_CODEMP').AsString);
      qryIncluir.FieldByName('ITE_CODITE').AsString := strCodIte;
      qryIncluir.Post;

      qryHeranca.Next;
    End;
  Finally
    FreeAndNil(qryHeranca);
    FreeAndNil(qryIncluir);
  End;

End;

end.
