unit untRelFrx;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDMPExport, frxExportPDF,
  Graphics,
  frxDBSet, Variants, Uni, DB, untFuncEditorRel, untFuncoesImagem, untTypesSistema;

type
  TdtmRelFrx = class(TDataModule)
    frxReportJ: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxReportM: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    function frxReportJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function fRetornaLeftImagem(strOrientacao: String; intQtdColunas: Integer): Double;
    function fRetornaWidthImagem(strOrientacao: String; intQtdColunas: Integer): Double;
    function fBuscaLocFisica(strNomeTmp, strValorSeqDet, strCampoRetorno: String): String;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    intTolerancia: Integer;
    fltPerJur,
    fltPerMul: Double;

    function fCampoNulo(strNomCam: String; intPosicao: Integer): Boolean;
    function fCampoVazio(strNomCam: String; intPosicao: Integer): Boolean;
    function fCalculaJurosCadCtrRel(dtaDtaVen, dtaDtaRec: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double;
    function fVerificaFileExists(strFilePath: String): Boolean;

  public
    { Public declarations }
    arrConsulta: TArrDataSet;

    objGeraFr3: Pointer;

    Class function fRetornaFontName(strValor: String): String;
    Class function fRetornaFontColor(strValor: String; strTag: String = 'Font.Color'): TColor;
    Class function fRetornaFontStyles(strValor: String): String;
    Class function fRetornaBrushColor(strValor: String): TColor;

  end;

var
  dtmRelFrx: TdtmRelFrx;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses
  StrUtils,
  untFuncoesSimples,
  untGeraFR3,
  untFuncTinta;

procedure TdtmRelFrx.DataModuleCreate(Sender: TObject);
begin
  intTolerancia := fCfgSis('TOLATR', varInteger);
  fltPerJur     := fCfgSis('JURATR', varDouble);
  fltPerMul     := fCfgSis('MULATR', varDouble);

  SetLength(arrConsulta, 0);

  objGeraFr3 := Nil;
end;

function TdtmRelFrx.frxReportJUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin

  If SameText(MethodName, 'fFormataFoneRel') Then
    Result := TGeraFR3.fFormataFoneRel(Params[0])

  Else If SameText(MethodName, 'fFormataCpfCgcRel') Then
    Result :=  TGeraFR3(objGeraFr3).fFormataCpfCgcRel(Params[0])

  Else If SameText(MethodName, 'fFormataContabilRel') Then
    Result :=  TGeraFR3(objGeraFr3).fFormataContabilRel(Params[0], Params[1], Params[2])

  Else If SameText(MethodName, 'fFiltraDadosChild') Then
    Result :=  TGeraFR3(objGeraFr3).fFiltraDadosChild(Params[0], Params[1], Params[2], Params[3], Params[4])

  Else If SameText(MethodName, 'fFiltraDadosFr3Child') Then
    Result :=  TGeraFR3(objGeraFr3).fFiltraDadosFr3Child(Params[0], Params[1], Params[2])

  Else If SameText(MethodName, 'fRetQtdRegFr3Child') Then
    Result :=  TGeraFR3(objGeraFr3).fRetQtdRegFr3Child(Params[0])

  Else If SameText(MethodName, 'fCampoNulo') Then
    Result := fCampoNulo(Params[0], Params[1])

  Else If SameText(MethodName, 'fCampoVazio') Then
    Result := fCampoVazio(Params[0], Params[1])

  Else If SameText(MethodName, ArrDesDefFuncao[funCalculaJurosCadCtr]) Then
    Result := fCalculaJurosCadCtrRel(Params[0], Params[1], Params[2], fltPerJur, fltPerMul, intTolerancia)

  Else If SameText(MethodName, ArrDesDefFuncao[funDescricaoLinhaWandaPro]) Then
    Result := fDescriLinhaWandaPro(Params[0])

  Else If SameText(MethodName, ArrDesDefFuncao[funNomeTinta]) Then
    Result := fRetornaNomeTinta(Params[0])

  Else If SameText(MethodName, 'fAdicionaPaginaQuebra') Then
    Result := TGeraFR3(objGeraFr3).fAdicionaPaginaQuebra(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5], Params[6])

  Else If SameText(MethodName, 'fRetornaFontName') Then
    Result := fRetornaFontName(Params[0])

  Else If SameText(MethodName, 'fRetornaFontColor') Then
    Result := fRetornaFontColor(Params[0])

  Else If SameText(MethodName, 'fRetornaBrushColor') Then
    Result := fRetornaBrushColor(Params[0])

  Else If SameText(MethodName, 'fRetornaFontStyles') Then
    Result := fRetornaFontStyles(Params[0])

  Else If SameText(MethodName, 'fVerificaFileExists') Then
    Result := fVerificaFileExists(Params[0])

  Else If SameText(MethodName, 'fRetLocFisica') Then
    Result := fRetLocFisica(Params[0])

  Else If SameText(MethodName, 'fAbreComposicao') Then
    Result := TGeraFR3(objGeraFr3).fFiltraDadosFr3Child(Params[0], Params[1], Params[2])

  Else If SameText(MethodName, 'fBuscaLocFisica') Then
    Result := fBuscaLocFisica(Params[0], Params[1], Params[2])

  Else If SameText(MethodName, 'fCfgSis') Then
    Result := fCfgSis(Params[0])

  Else If SameText(MethodName, 'pCarregaImagemProduto') Then
  Begin
    if not (fCarregaImagemProduto(Params[0], TfrxPictureView(frxReportJ.FindObject(Params[1])), Params[2]) = riOk) then
      TfrxPictureView(frxReportJ.FindObject(Params[1])).Picture := nil;
  End

  Else If SameText(MethodName, 'pCarregaImagemProdutoRed') Then
  Begin
    if not (fCarregaImagemProdutoRed(Params[0], TfrxPictureView(frxReportJ.FindObject(Params[1])), Params[2]) = riOk) then
      TfrxPictureView(frxReportJ.FindObject(Params[1])).Picture := nil;
  End

  Else If SameText(MethodName, 'fRetornaLeftImagem') Then
    Result := fRetornaLeftImagem(Params[0], Params[1])

  Else If SameText(MethodName, 'fRetornaWidthImagem') Then
    Result := fRetornaWidthImagem(Params[0], Params[1]);

end;

function TdtmRelFrx.fRetornaLeftImagem(strOrientacao: String; intQtdColunas: Integer): Double;
var
  fltValor: Double;
begin
  fltValor := 0;
  if strOrientacao = 'P' then
  begin
    case intQtdColunas of
      1: fltValor := 345.99234628;
      2: fltValor := 120.94495756;
      3: fltValor := 42.07088628;
      4: fltValor := 17.39370628;
      5: fltValor := 9.83464628;
    end;
  end
  else
  begin
    case intQtdColunas of
      1: fltValor := 191.81114628;
      2: fltValor := 25.51182628;
      3: fltValor := 14.17323628;
      4: fltValor := 6.61417628;
      5: fltValor := 6.61417628;
    end;
  end;
  Result := fltValor;
end;

function TdtmRelFrx.fRetornaWidthImagem(strOrientacao: String; intQtdColunas: Integer): Double;
var
  fltValor: Double;
begin
  fltValor := 0;
  if strOrientacao = 'P' then
  begin
    case intQtdColunas of
      1: fltValor := 391.18135744;
      2: fltValor := 285.35451744;
      3: fltValor := 277.79545744;
      4: fltValor := 236.22062744;
      5: fltValor := 198.42532744;
    end;
  end
  else
  begin
    case intQtdColunas of
      1: fltValor := 372.28370744;
      2: fltValor := 326.92934744;
      3: fltValor := 224.88203744;
      4: fltValor := 175.74814744;
      5: fltValor := 137.95284744;
    end;
  end;
  Result := fltValor;
end;

function TdtmRelFrx.fBuscaLocFisica(strNomeTmp: String; strValorSeqDet: String; strCampoRetorno: String): String;
Var
   qryConsulta : TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery();
    With qryConsulta, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT DISTINCT LOT_LOCFIS                                   ');
      Add('FROM ORDDET                                                  ');
      Add('INNER JOIN ORDCOM   ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM ');
      Add('INNER JOIN ORDGER O on O.AUTOINCREM =  ORDDET.ORD_SEQGER     ');
      Add('INNER JOIN EXTGOR E ON E.FGO_ORDIND = O.AUTOINCREM           ');
      Add('INNER JOIN FATGOR G ON G.AUTOINCREM = E.FGO_SEQFGO           ');
      Add('INNER JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM           ');
      Add('                   AND FDO_CODITE = ODC_CODITE               ');
      Add('INNER JOIN CADLOT L ON L.LOT_CODITE = FDO_CODITE             ');
      Add('                   AND L.LOT_CODEMP = FDO_CODEMP             ');
      Add('                   AND L.LOT_NUMLOT = FDO_NUMLOT             ');
      Add('WHERE ODC_SEQDET = :SEQDET                                   ');
      Add('  AND ODC_CODITE = :CODITE                                   ');

      ParamByName('SEQDET').AsString := strValorSeqDet;
      ParamByName('CODITE').AsString := TGeraFR3(objGeraFr3).fRetornaValorTemporariaFr3(strNomeTmp, strCampoRetorno);
      Open;

      Result := FieldByName('LOT_LOCFIS').AsString;
    end;


  Finally
    FreeAndNil(qryConsulta);
  End;
end;

Class Function TdtmRelFrx.fRetornaFontStyles(strValor: String): String;
  Var
    intPosTag,
    intPosFim: Integer;
Begin
  Result := '';

  intPosTag := Pos('Font.Style', strValor);

  If intPosTag > 0 Then
  Begin
    intPosTag := Pos('=', strValor, intPosTag);

    If intPosTag > 0 Then
    Begin
      intPosTag := Succ(intPosTag);

      intPosFim := Pos(';', strValor, intPosTag);

      If intPosFim = 0 Then
        intPosFim := Length(strValor)
      Else
        intPosFim :=  Pred(intPosFim);

      Result := Trim(Copy(strValor, intPosTag, intPosFim - intPosTag + 1));
    End;

  End;

End;

Class function TdtmRelFrx.fRetornaFontName(strValor: String): String;
  Var
    intPosTag,
    intPosFim: Integer;
Begin
  Result := '';

  intPosTag := Pos('Font.Name', strValor);

  If intPosTag > 0 Then
  Begin
    intPosTag := Pos('=', strValor, intPosTag);

    If intPosTag > 0 Then
    Begin
      intPosTag := Succ(intPosTag);

      intPosFim := Pos(';', strValor, intPosTag);

      If intPosFim = 0 Then
        intPosFim := Length(strValor)
      Else
        intPosFim :=  Pred(intPosFim);

      Result := Trim(Copy(strValor, intPosTag, intPosFim - intPosTag + 1));
    End;

  End;

End;

Class function TdtmRelFrx.fRetornaFontColor(strValor: String; strTag: String = 'Font.Color'): TColor;
  Var
    intPosTag,
    intPosFim: Integer;
    strCor: String;
Begin
  Result := -1;

  intPosTag := Pos(strTag, strValor);

  If intPosTag > 0 Then
  Begin
    intPosTag := Pos('=', strValor, intPosTag);

    If intPosTag > 0 Then
    Begin
      intPosTag := Succ(intPosTag);

      intPosFim := Pos(';', strValor, intPosTag);

      If intPosFim = 0 Then
        intPosFim := Length(strValor)
      Else
        intPosFim :=  Pred(intPosFim);

      strCor := Trim(Copy(strValor, intPosTag, intPosFim - intPosTag + 1));

      If SameText(strCor, 'clBlack') Then
        Result := clBlack

      Else If SameText(strCor, 'clMaroon') Then
        Result := clMaroon

      Else If SameText(strCor, 'clGreen') Then
        Result := clGreen

      Else If SameText(strCor, 'clOlive') Then
        Result := clOlive

      Else If SameText(strCor, 'clNavy') Then
        Result := clNavy

      Else If SameText(strCor, 'clPurple') Then
        Result := clPurple

      Else If SameText(strCor, 'clTeal') Then
        Result := clTeal

      Else If SameText(strCor, 'clGray') Then
        Result := clGray

      Else If SameText(strCor, 'clSilver') Then
        Result := clSilver

      Else If SameText(strCor, 'clRed') Then
        Result := clRed

      Else If SameText(strCor, 'clLime') Then
        Result := clLime

      Else If SameText(strCor, 'clYellow') Then
        Result := clYellow

      Else If SameText(strCor, 'clBlue') Then
        Result := clBlue

      Else If SameText(strCor, 'clFuchsia') Then
        Result := clFuchsia

      Else If SameText(strCor, 'clAqua') Then
        Result := clAqua

      Else If SameText(strCor, 'clLtGray') Then
        Result := clLtGray

      Else If SameText(strCor, 'clDkGray') Then
        Result := clDkGray

      Else If SameText(strCor, 'clWhite') Then
        Result := clWhite

      Else If SameText(strCor, 'clMoneyGreen') Then
        Result := clMoneyGreen

      Else If SameText(strCor, 'clSkyBlue') Then
        Result := clSkyBlue

      Else If SameText(strCor, 'clCream') Then
        Result := clCream

      Else If SameText(strCor, 'clMedGray') Then
        Result := clMedGray

      Else If SameText(strCor, 'clNone') Then
        Result := clNone

      Else If SameText(strCor, 'clDefault') Then
        Result := clDefault

      Else If AnsiStartsStr('$', strCor) Then
        Result := StrToIntDef(strCor, clBlack);
    End;

  End;

End;

Class function TdtmRelFrx.fRetornaBrushColor(strValor: String): TColor;
Begin
  Result := fRetornaFontColor(strValor, 'Brush.Color');
End;

function TdtmRelFrx.fCalculaJurosCadCtrRel(dtaDtaVen, dtaDtaRec: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double;
Begin
  If dtaDtaRec <> 0 Then
    Result := fltValDup
  Else
    Result := fltValDup + fCalculaJurosCadCtr(dtaDtaVen, fltValDup, fltPerJur, fltPerMul, intTolerancia);
end;

function TdtmRelFrx.fCampoNulo(strNomCam: String; intPosicao: Integer): Boolean;
  Var
    intContador: Integer;
Begin
  Result := false;

  If intPosicao <= High(arrConsulta) Then
  Begin

    If Assigned(arrConsulta[intPosicao]) And (arrConsulta[intPosicao].FindField(strNomCam) <> Nil) Then
      Result := arrConsulta[intPosicao].FieldByName(strNomCam).IsNull;


  End Else
  Begin

    For intContador := Low(arrConsulta) To High(arrConsulta) Do
    If Assigned(arrConsulta[intContador]) And (arrConsulta[intContador].FindField(strNomCam) <> Nil) Then
    Begin
      Result := arrConsulta[intContador].FieldByName(strNomCam).IsNull;
      Exit;
    End;

  End;

End;

function TdtmRelFrx.fCampoVazio(strNomCam: String; intPosicao: Integer): Boolean;
  Var
    intContador: Integer;
Begin
  Result := false;

  If intPosicao <= High(arrConsulta) Then
  Begin

    If Assigned(arrConsulta[intPosicao]) And (arrConsulta[intPosicao].FindField(strNomCam) <> Nil) Then
      Result := fEmptyStr(arrConsulta[intPosicao].FieldByName(strNomCam).AsString);


  End Else
  Begin

    For intContador := Low(arrConsulta) To High(arrConsulta) Do
    If Assigned(arrConsulta[intContador]) And (arrConsulta[intContador].FindField(strNomCam) <> Nil) Then
    Begin
      Result := fEmptyStr(arrConsulta[intContador].FieldByName(strNomCam).AsString);
      Exit;
    End;

  End;

End;

Function TdtmRelFrx.fVerificaFileExists(strFilePath: String): Boolean;
Begin
  Result := False;

  Try
    If FileExists(strFilePath) Then
      Result := True;

  Except
    Result := False;
  End;

End;

end.
