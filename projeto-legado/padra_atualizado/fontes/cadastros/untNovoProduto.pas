unit untNovoProduto;

interface

uses
  SysUtils, Classes, DB,   Uni, StrUtils, Variants, UniClientDataSet, Forms;

Type
  TNovProd = class(TComponent)
  private
    class var FItensJaExibidosBanner: TStringList;
  Private
    FExistePathImagem : Boolean;
    cdsBanner: TUniClientDataSet;
    function fGetSQLBanner(strTabPre: String): String;
    procedure pCriaClientBanner;
    procedure pSetarCampoImagemCarregandoDoStream(const strCodIte: String; fldFieldImagem: TField);
    function fBannerNaoListado(const strBanner: String; arrBanner: TArray<String>): Boolean;
    procedure pLimparItensJaExibidosBanner(const intQtdBanner: Integer; arrBanner: TArray<String>);
  Public
    function  getCdsBanner: TUniClientDataSet;
    procedure pCarregaProdutosParaBanner(const strTabPre: String);

    Constructor Create(Owner: TComponent); override;
    Destructor  Destroy; override;
  End;

implementation

uses untfuncoesSimples, untCadPro, untFuncoesImagem;

function TNovProd.fGetSQLBanner(strTabPre: String): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  I.AUTOINCREM AS AUTINC, ';
  Result := Result + '  I.ITE_CODITE AS CODITE, ';
  Result := Result + '  I.ITE_DESITE AS DESITE, ';
  Result := Result + '  ('+ fGetSQLITE_PREVE('T', strTabPre) +') AS PREVEN, ';
  Result := Result + '  I.ITE_REFERE AS REFERE ';
  Result := Result + 'FROM ';
  Result := Result + '  CADITE I ';
  Result := Result + '  INNER JOIN ITEGER T ON I.ITE_CODITE = T.ITE_CODITE ';
  Result := Result + '                     AND T.ITE_CODEMP = :CODEMP ';
  Result := Result + 'WHERE ';

  If (fCfgSis('DUCNPB', VarInteger) >= 0 ) OR (fCfgSis('QDCNPB', VarInteger) >= 0 ) Then
  Begin
    If fCfgSis('ECENPB', varString) = 'EMPRESA LOGADA' Then
    Begin
      If (fCfgSis('DUCNPB', VarInteger) >= 0 ) Then
      Begin
       Result := Result + '  DATEDIFF(CURDATE(), T.ITE_DTAULT) <= ' + IntToStr(fCfgSis('DUCNPB', VarInteger));
       If (fCfgSis('QDCNPB', VarInteger) >= 0 ) Then
         Result := Result +'  OR DATEDIFF(CURDATE(), I.ITE_DTACAD) <= ' + IntToStr(fCfgSis('QDCNPB', VarInteger));
      End
      Else
        Result := Result + '  DATEDIFF(CURDATE(), I.ITE_DTACAD) <= ' + IntToStr(fCfgSis('QDCNPB', VarInteger));
    End
    Else
    Begin
      Result := Result + '  I.ITE_CODITE IN (SELECT DISTINCT ';
      Result := Result + '                     I.ITE_CODITE AS CODITE ';
      Result := Result + '                   FROM ';
      Result := Result + '                     ITEGER T ';
      Result := Result + '                     INNER JOIN CADITE I ON I.ITE_CODITE = T.ITE_CODITE ';
      Result := Result + '                   WHERE ';
      If (fCfgSis('DUCNPB', VarInteger) >= 0 ) Then
      Begin
        Result := Result + '                     DATEDIFF(CURDATE(), T.ITE_DTAULT) <= ' + IntToStr(fCfgSis('DUCNPB', VarInteger));
        If (fCfgSis('QDCNPB', VarInteger) >= 0 ) Then
          Result := Result + '                   OR DATEDIFF(CURDATE(), I.ITE_DTACAD) <= ' + IntToStr(fCfgSis('QDCNPB', VarInteger)) + ')';
      End
      Else
        Result := Result + '                     DATEDIFF(CURDATE(), I.ITE_DTACAD) <= ' + IntToStr(fCfgSis('QDCNPB', VarInteger)) + ')';
    End;
  End
  Else
    Result := Result + 'FALSE';

  Result := Result + ' ORDER BY ';
  Result := Result + '  I.ITE_DESITE ';
End;

function TNovProd.getCdsBanner: TUniClientDataSet;
begin
  Result := cdsBanner;
end;

procedure TNovProd.pSetarCampoImagemCarregandoDoStream(const strCodIte: String; fldFieldImagem: TField);
  Var
    objOutputStream : TBytesStream;
begin
  If (Not FExistePathImagem) Then
    Exit;

  objOutputStream := TBytesStream.Create;
  Try
    If fCarregaImagemPrincipalProdutoDB(strCodIte, objOutputStream, False) Then
      TBlobField(fldFieldImagem).LoadFromStream(objOutputStream);
  Finally
    If Assigned(objOutputStream) Then objOutputStream.Free;
  End;
end;

procedure TNovProd.pCarregaProdutosParaBanner(const strTabPre: String);
  Var
    qryBanner: TUniQuery;
    LArrRecNo: TArray<String>;
begin
  qryBanner := fCriaQuery(Nil);
  Try
    If (Not Assigned(cdsBanner)) Then
    Begin
      pCriaClientBanner;
    End
    Else
      cdsBanner.EmptyDataSet;

    qryBanner.Close;
    qryBanner.SQL.Clear;
    qryBanner.SQL.Add(fGetSQLBanner(strTabPre));
    qryBanner.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBanner.Open;

    SetLength(LArrRecNo, 0);
    If qryBanner.RecordCount > fCfgSis('BANQTD', VarInteger) Then
    Begin
      qryBanner.First;
      While Not qryBanner.Eof Do
      Begin
        If FItensJaExibidosBanner.IndexOf(qryBanner.FieldByName('CODITE').AsString) = -1 Then
        Begin
          SetLength(LArrRecNo, Length(LArrRecNo)+1);
          LArrRecNo[Length(LArrRecNo)-1] := qryBanner.RecNo.ToString;
          FItensJaExibidosBanner.Add(qryBanner.FieldByName('CODITE').AsString);
        End;

        If Length(LArrRecNo) >= fCfgSis('BANQTD', VarInteger) Then
          If (qryBanner.RecordCount - qryBanner.RecNo) >= fCfgSis('BANQTD', VarInteger) Then
            Break;

        qryBanner.Next;
      End;
    End;

    pLimparItensJaExibidosBanner(qryBanner.RecordCount, LArrRecNo);

    qryBanner.First;
    While Not qryBanner.Eof Do
    Begin
      If fBannerNaoListado(qryBanner.RecNo.ToString, LArrRecNo) Then
      Begin
        qryBanner.Next;
        Continue;
      End;

      If cdsBanner.RecordCount >= fCfgSis('BANQTD', VarInteger) Then
        Break;

      cdsBanner.Insert;
      cdsBanner.FieldByName('AUTINC').AsString := qryBanner.FieldByName('AUTINC').AsString;
      cdsBanner.FieldByName('CODITE').AsString := qryBanner.FieldByName('CODITE').AsString;
      cdsBanner.FieldByName('DESITE').AsString := qryBanner.FieldByName('DESITE').AsString;
      cdsBanner.FieldByName('PREVEN').AsFloat  := qryBanner.FieldByName('PREVEN').AsFloat;
      cdsBanner.FieldByName('REFERE').AsString := qryBanner.FieldByName('REFERE').AsString;

      pSetarCampoImagemCarregandoDoStream(qryBanner.FieldByName('CODITE').AsString, cdsBanner.FieldByName('IMAGEM'));

      cdsBanner.Post;

      qryBanner.Next;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TNovProd.CarregaProdutosParaBanner]')
  End;

  FreeAndNil(qryBanner);
End;

procedure TNovProd.pCriaClientBanner;
begin
  Try
    cdsBanner := TUniClientDataSet.Create(Nil);
    cdsBanner.AggregatesActive := True;

    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Size := 020; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 100; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'PREVEN'; DataType := ftFloat;               Required := False; End; //(12,02)
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'REFERE'; DataType := ftString; Size := 20;  Required := False; End;

    cdsBanner.CreateDataSet;
    cdsBanner.LogChanges := False;

    TBlobField.Create(cdsBanner.FieldByName('IMAGEM') as TBlobField);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TNovProd.pCriaClientBanner]');
  End;
end;

procedure TNovProd.pLimparItensJaExibidosBanner(const intQtdBanner: Integer; arrBanner: TArray<String>);
begin
  If FItensJaExibidosBanner.Count >= intQtdBanner Then
    FItensJaExibidosBanner.Clear;

  If Length(arrBanner) < fCfgSis('BANQTD', VarInteger) Then
    FItensJaExibidosBanner.Clear;
end;

{ TNovProd }

constructor TNovProd.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FExistePathImagem := (fRetornaPathImagem(False) <> '');
end;

destructor TNovProd.Destroy;
begin
  If (Assigned(cdsBanner)) Then
    FreeAndNil(cdsBanner);

  inherited destroy;
end;

function TNovProd.fBannerNaoListado(const strBanner: String; arrBanner: TArray<String>): Boolean;
begin
  Result := False;

  If (Length(arrBanner) <= 0) Then
    Exit;

  If (MatchStr(strBanner, arrBanner)) Then
    Exit;

  Result := True;
end;

initialization
  TNovProd.FItensJaExibidosBanner := TStringList.Create;

finalization
   FreeAndNil(TNovProd.FItensJaExibidosBanner);

end.
