unit untPafExportacaoMovEcf;

interface

uses Windows, Classes, ComCtrls, Forms, Uni;

Type
  TInicarExportacaoEvent = procedure(Sender: TObject; strRegistro: String;
    intTotalRegistros: Integer) of object;

  TFinalizarExportacaoEvent = procedure(Sender: TObject; strRegistro: String) of object;

  TExportacaoLinhaEvent = procedure(Sender: TObject; strRegistro: String;
    intRegAtual: Integer) of object;

Type
  TExportaMovEcf = class(TObject)
    private
      FAntesIniciarRegistro: TInicarExportacaoEvent;
      FLinhaProcessada: TExportacaoLinhaEvent;
      FAntesFinalizarRegistro: TFinalizarExportacaoEvent;

      FArquivos: TStringList;
      FNumSer: String;
      FDtaIni: TDateTime;
      FDtaFin: TDateTime;
      FDtaArq: TDateTime;
      FNumeroDeSerieCompleto: String;

      procedure pExportaMovEcfR01;
      procedure pExportaMovEcfR02_R03;
      procedure pExportaMovEcfR04_R05;
      procedure pExportaMovEcfR06;
      procedure pExportaMovEcfR07;

      procedure pAssinarArquivos;

      procedure pSetaParametros(qryAux: TUniQuery; strCampoData: String);
      function fGetArquivo(strNumSer: String): TStringList;
      function fRetornaCodNacionalECF: String;
      function fRetornaVersaoER: String;
      function fRetornaVersaoPrograma: String;

    public
      strCodNac: String;

      property AntesIniciarRegistro: TInicarExportacaoEvent Read FAntesIniciarRegistro Write FAntesIniciarRegistro;
      property LinhaProcessada: TExportacaoLinhaEvent Read FLinhaProcessada Write FLinhaProcessada;
      property AntesFinalizarRegistro: TFinalizarExportacaoEvent Read FAntesFinalizarRegistro Write FAntesFinalizarRegistro;

      constructor Create(strNumSer: String; dtaDtaIni, dtaDtaFin, dtaDtaArq: TDateTime);
      procedure pExportar;
  End;

implementation

uses untFuncoes, SysUtils, untFiscal, StrUtils, untFuncoesSimples;

{ TExportaMovEcf }

constructor TExportaMovEcf.Create(strNumSer: String; dtaDtaIni, dtaDtaFin, dtaDtaArq: TDateTime);
begin
  inherited Create;
  FNumeroDeSerieCompleto := strNumSer;
  FNumSer   := strNumSer;
  FDtaIni   := dtaDtaIni;
  FDtaFin   := dtaDtaFin;
  FDtaArq   := dtaDtaArq;
  FArquivos := TStringList.Create;
end;

function TExportaMovEcf.fGetArquivo(strNumSer: String): TStringList;
  Var
    intIndice: Integer;
begin
  intIndice := FArquivos.IndexOf(strNumSer);
  If intIndice >= 0 Then
    Result := TStringList(FArquivos.Objects[intIndice])
  Else
  Begin
    Result := TStringList.Create;
    FArquivos.AddObject(strNumSer, Result);
  End;
end;

procedure TExportaMovEcf.pAssinarArquivos;
  Var
    intContador: Integer;
    strNomArq: String;
    stlArqAtu: TStringList;
    strNumSer: String;
begin
  AntesIniciarRegistro(Self, 'ASSINATURA', FArquivos.Count);

  For intContador := 0 To FArquivos.Count-1 Do
  Begin

    stlArqAtu := TStringList(FArquivos.Objects[intContador]);

    If Not fEmptyStr(Self.FNumSer) Then
      strNumSer := RightStr(FNumSer, 14)
    Else
    Begin
      strNumSer := Trim(Copy(stlArqAtu[0], 4, 20));
      FNumeroDeSerieCompleto := strNumSer;
      strNumSer := RightStr(strNumSer, 14);
    End;

    strNomArq := 'PAF\' + fRetornaCodNacionalECF +
                 strNumSer +
                 FormatDateTime('ddmmyyyy', FDtaArq) + '.txt';

    If Not DirectoryExists(ExtractFilePath(strNomArq)) Then
      CreateDir(ExtractFilePath(strNomArq));

    stlArqAtu.SaveToFile(strNomArq);

    pAssinarDigitalmente(AnsiString(strNomArq));

    LinhaProcessada(Self, 'ASSINATURA', intContador+1);
  End;

  AntesFinalizarRegistro(Self, 'ASSINATURA');
end;

function TExportaMovEcf.fRetornaVersaoER: String;
begin
  If AnsiEndsText('2012', fNumeroLaudo) Then
    Result := '0109'
  Else
    Result := '0113';
end;

function TExportaMovEcf.fRetornaVersaoPrograma: String;
begin
  If AnsiEndsText('2012', fNumeroLaudo) Then
    Result := '27.16.470'
  Else
    Result := '27.379.48a';
end;

procedure TExportaMovEcf.pExportaMovEcfR01;
  Var
    strLinha: String;
    qryR01: TUniQuery;
begin
  qryR01 := fCriaQuery;

  qryR01.SQL.Add('SELECT ');
  qryR01.SQL.Add('  * ');
  qryR01.SQL.Add('FROM ');
  qryR01.SQL.Add('  PAFR01 ');
  qryR01.SQL.Add('WHERE TRUE ');

  pSetaParametros(qryR01, 'PAF_DTAEMI');

  qryR01.Open;

  FAntesIniciarRegistro(Self, 'R01', qryR01.RecordCount);

  While (Not qryR01.Eof) Do
  Begin
    strLinha := 'R01'                                                                   + // 03 - 001 a 003
                fPadR(qryR01.FieldByName('PAF_NUMSER').AsString, 20, ' ')               + // 20 - 004 a 023
                ' '                                                                     + // 01 - 024 a 024
                fPadR(qryR01.FieldByName('PAF_TIPECF').AsString, 07, ' ')               + // 07 - 025 a 031
                fPadR(qryR01.FieldByName('PAF_MARECF').AsString, 20, ' ')               + // 20 - 032 a 051
                fPadR(qryR01.FieldByName('PAF_MODECF').AsString, 20, ' ')               + // 20 - 052 a 071
                fPadR(qryR01.FieldByName('PAF_VER_SB').AsString, 10, ' ')               + // 10 - 072 a 081
                FormatDateTime('yyyymmdd', qryR01.FieldByName('PAF_DTA_SB').AsDateTime) + // 08 - 082 a 089
                FormatDateTime('hhnnss', qryR01.FieldByName('PAF_HOR_SB').AsDateTime)   + // 06 - 090 a 095
                fPadL(qryR01.FieldByName('PAF_NUMCAI').AsString, 03, '0')               + // 03 - 096 a 098
                fPadL(fCadEmp('C_G_C_'), 14, '0')                                       + // 14 - 099 a 112
                fPadR(fTiraCaracEspeciais(fCadEmp('I_E_S_'), True, True, True, True, True, True), 14, '0') + // 14 - 113 a 126
                '51212892000125'                                                        + // 14 - 127 a 140
                fPadR('582660690118', 14, ' ')                                          + // 14 - 141 a 154
                fPadR('072059301', 14, ' ')                                             + // 14 - 155 a 168
                fPadR(qryR01.FieldByName('PAF_RAZSOC').AsString, 40, ' ')               + // 40 - 169 a 208
                fPadR('AutCom', 40, ' ')                                                + // 40 - 209 a 248
                fPadR(fRetornaVersaoPrograma, 10, ' ')                                  + // 10 - 249 a 258
                fRetMD5Laudo                                                            + // 32 - 259 a 290
                FormatDateTime('yyyymmdd', FDtaIni)                                     + // 08 - 291 a 298
                FormatDateTime('yyyymmdd', FDtaFin)                                     + // 08 - 299 a 306
                fRetornaVersaoER;                                                         // 04 - 307 a 310

    FLinhaProcessada(Self, 'R01', 1);

    fGetArquivo(qryR01.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

    qryR01.Next;
  End;

  FAntesFinalizarRegistro(Self, 'R01');
end;

procedure TExportaMovEcf.pExportaMovEcfR02_R03;
  Var
    strLinha: String;
    qryR02: TUniQuery;
    qryR03: TUniQuery;
    stlCRZ: TStringList;
begin

  stlCRZ := TStringList.Create;

  {*****************************************}
  {* GERA REGISTRO R02                     *}
  {**************************************MV*}
  qryR02 := fCriaQuery;
  qryR02.SQL.Add('SELECT ');
  qryR02.SQL.Add('  * ');
  qryR02.SQL.Add('FROM ');
  qryR02.SQL.Add('  PAFR02 ');
  qryR02.SQL.Add('WHERE TRUE ');

  pSetaParametros(qryR02, 'PAF_DTAEMI');

  qryR02.Open;

  FAntesIniciarRegistro(Self, 'R02', qryR02.RecordCount);

  While (Not qryR02.Eof) Do
  Begin

    strLinha := 'R02'                                                                         + // 03 - 001 a 003
                fPadR(qryR02.FieldByName('PAF_NUMSER').AsString, 20, ' ')                     + // 20 - 004 a 023
                ' '                                                                           + // 01 - 024 a 024
                fPadR(qryR02.FieldByName('PAF_MODECF').AsString, 20, ' ')                     + // 20 - 025 a 044
                fPadL(qryR02.FieldByName('PAF_NUMUSU').AsString, 02, '0')                     + // 02 - 045 a 046
                fPadL(qryR02.FieldByName('PAF_NUMCRZ').AsString, 06, '0')                     + // 06 - 047 a 052
                fPadL(qryR02.FieldByName('PAF_NUMCOO').AsString, 06, '0')                     + // 06 - 053 a 058
                fPadL(qryR02.FieldByName('PAF_NUMCRO').AsString, 06, '0')                     + // 06 - 059 a 064
                FormatDateTime('yyyymmdd', qryR02.FieldByName('PAF_DTAMOV').AsDateTime)       + // 08 - 065 a 072
                FormatDateTime('yyyymmdd', qryR02.FieldByName('PAF_DTAEMI').AsDateTime)       + // 08 - 073 a 080
                FormatDateTime('hhnnss', qryR02.FieldByName('PAF_HOREMI').AsDateTime)         + // 06 - 081 a 086
                fPadL(fValNumForm(qryR02.FieldByName('PAF_VENBRU').AsFloat, 14 , 2), 14, '0') + // 14 - 087 a 100
                fPadL(qryR02.FieldByName('PAF_INCISS').AsString, 01, ' ');                      // 01 - 101 a 101

    fGetArquivo(qryR02.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

    stlCRZ.Add(qryR02.FieldByName('PAF_NUMCRZ').AsString);

    FLinhaProcessada(Self, 'R02', qryR02.RecNo);

    qryR02.Next;
  End;

  FreeAndNil(qryR02);

  FAntesFinalizarRegistro(Self, 'R02');

  If (stlCRZ.Count > 0) Then
  Begin

    {*****************************************}
    {* GERA REGISTRO R03                     *}
    {**************************************MV*}
    qryR03 := fCriaQuery;
    qryR03.SQL.Add('SELECT ');
    qryR03.SQL.Add('  * ');
    qryR03.SQL.Add('FROM ');
    qryR03.SQL.Add('  PAFR03 ');
    qryR03.SQL.Add('WHERE TRUE ');

    pSetaParametros(qryR03, 'PAF_DTAMOV');

    qryR03.Open;

    FAntesIniciarRegistro(Self, 'R03', qryR03.RecordCount);

    While (Not qryR03.Eof) Do
    Begin
      strLinha := 'R03'                                                                         + // 03 - 01 a 03
                  fPadR(qryR03.FieldByName('PAF_NUMSER').AsString, 20, ' ')                     + // 20 - 004 a 023
                  ' '                                                                           + // 01 - 024 a 024
                  fPadR(qryR03.FieldByName('PAF_MODECF').AsString, 20, ' ')                     + // 20 - 025 a 044
                  fPadL(qryR03.FieldByName('PAF_NUMUSU').AsString, 02, '0')                     + // 02 - 045 a 046
                  fPadL(qryR03.FieldByName('PAF_NUMCRZ').AsString, 06, '0')                     + // 06 - 047 a 052
                  fPadR(qryR03.FieldByName('PAF_TOTPAR').AsString, 07, ' ')                     + // 07 - 053 a 059
                  fPadL(fValNumForm(qryR03.FieldByName('PAF_VALACU').AsFloat, 12, 2), 13, '0');   // 13 - 060 a 072

      fGetArquivo(qryR03.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

      FLinhaProcessada(Self, 'R03', qryR03.RecNo);

      qryR03.Next;
      Application.ProcessMessages;
    End;

    FreeAndNil(qryR03);

    FAntesFinalizarRegistro(Self, 'R03');

  End
  Else
    FAntesFinalizarRegistro(Self, 'R03');
end;

procedure TExportaMovEcf.pExportaMovEcfR04_R05;
  Var
    qryR04: TUniQuery;
    qryR05: TUniQuery;
    stlCCF: TStringList;
    strLinha: String;
    intDecQtd: Integer;
    intDecUni: Integer;
begin
  stlCCF := TStringList.Create;

  qryR04 := fCriaQuery;
  qryR04.SQL.Add('SELECT ');
  qryR04.SQL.Add('  * ');
  qryR04.SQL.Add('FROM ');
  qryR04.SQL.Add('  PAFR04 ');
  qryR04.SQL.Add('WHERE TRUE ');

  pSetaParametros(qryR04, 'PAF_DTAINI');

  qryR04.Open;

  FAntesIniciarRegistro(Self, 'R04', qryR04.RecordCount);

  While (Not qryR04.Eof) Do
  Begin

    strLinha := 'R04'                                                                        + // 03 - 001 a 003
                fPadR(qryR04.FieldByName('PAF_NUMSER').AsString, 20, ' ')                    + // 20 - 004 a 023
                ' '                                                                          + // 01 - 024 a 024
                fPadR(qryR04.FieldByName('PAF_MODECF').AsString, 20, ' ')                    + // 20 - 025 a 044
                fPadL(qryR04.FieldByName('PAF_NUMUSU').AsString, 02, '0')                    + // 02 - 045 a 046
                fPadL(qryR04.FieldByName('PAF_NUMCCF').AsString, 06, '0')                    + // 06 - 047 a 052
                fPadL(qryR04.FieldByName('PAF_NUMCOO').AsString, 06, '0')                    + // 06 - 053 a 058
                FormatDateTime('yyyymmdd', qryR04.FieldByName('PAF_DTAINI').AsDateTime)      + // 08 - 059 a 066
                fPadL(fValNumForm(qryR04.FieldByName('PAF_SUBTOT').AsFloat, 14, 2), 14, '0') + // 14 - 067 a 080
                fPadL(fValNumForm(qryR04.FieldByName('PAF_DESSUB').AsFloat, 13, 2), 13, '0') + // 13 - 081 a 093
                fPadR(qryR04.FieldByName('PAF_TIPDES').AsString, 01, ' ')                    + // 01 - 094 a 094
                fPadL(fValNumForm(qryR04.FieldByName('PAF_ACRSUB').AsFloat, 13, 2), 13, '0') + // 13 - 095 a 107
                fPadR(qryR04.FieldByName('PAF_TIPACR').AsString, 01, ' ')                    + // 01 - 108 a 108
                fPadL(fValNumForm(qryR04.FieldByName('PAF_TOTLIQ').AsFloat, 14, 2), 14, '0') + // 14 - 109 a 122
                fPadR(qryR04.FieldByName('PAF_CANCEL').AsString, 01, ' ')                    + // 01 - 123 a 123
                fPadL(fValNumForm(qryR04.FieldByName('PAF_CANACR').AsFloat, 13, 2), 13, '0') + // 13 - 124 a 136
                fPadR(qryR04.FieldByName('PAF_ORDAPL').AsString, 01, ' ')                    + // 01 - 137 a 137
                fPadR(qryR04.FieldByName('PAF_NOMCLI').AsString, 40, ' ')                    + // 40 - 138 a 177
                fPadR(qryR04.FieldByName('PAF_NUMCPF').AsString, 14, ' ');                     // 14 - 178 a 191

    stlCCF.Add(qryR04.FieldByName('PAF_NUMCCF').AsString);
    fGetArquivo(qryR04.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

    FLinhaProcessada(Self, 'R04', qryR04.RecNo);

    qryR04.Next;
  End;

  FreeAndNil(qryR04);

  FAntesFinalizarRegistro(Self, 'R04');

  If (stlCCF.Count > 0) Then
  Begin
    qryR05 := fCriaQuery;
    qryR05.SQL.Add('SELECT ');
    qryR05.SQL.Add('  * ');
    qryR05.SQL.Add('FROM ');
    qryR05.SQL.Add('  PAFR05 ');
    qryR05.SQL.Add('WHERE TRUE ');

    pSetaParametros(qryR05, 'PAF_DTAEMI');

    qryR05.Open;

    FAntesIniciarRegistro(Self, 'R05', qryR05.RecordCount);

    While (Not qryR05.Eof) Do
    Begin

      intDecQtd := qryR05.FieldByName('PAF_DECQTD').AsInteger;
      intDecUni := qryR05.FieldByName('PAF_DECUNI').AsInteger;

      strLinha := 'R05'                                                                                 + // 003 - 001 a 003
                  fPadR(qryR05.FieldByName('PAF_NUMSER').AsString, 020, ' ')                            + // 020 - 004 a 023
                  ' '                                                                                   + // 001 - 024 a 024
                  fPadR(qryR05.FieldByName('PAF_MODECF').AsString, 020, ' ')                            + // 020 - 025 a 044
                  fPadL(qryR05.FieldByName('PAF_NUMUSU').AsString, 002, '0')                            + // 002 - 045 a 046
                  fPadL(qryR05.FieldByName('PAF_NUMCOO').AsString, 006, '0')                            + // 006 - 047 a 052
                  fPadL(qryR05.FieldByName('PAF_NUMCCF').AsString, 006, '0')                            + // 006 - 053 a 058
                  fPadL(qryR05.FieldByName('PAF_NUMITE').AsString, 003, '0')                            + // 003 - 059 a 061
                  fPadL(qryR05.FieldByName('PAF_CODITE').AsString, 014, '0')                            + // 014 - 062 a 075
                  fPadR(qryR05.FieldByName('PAF_DESITE').AsString, 100, ' ')                            + // 100 - 076 a 175
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_QTDITE').AsFloat, 07, intDecQtd), 007, '0') + // 007 - 176 a 182
                  fPadR(qryR05.FieldByName('PAF_UNIDAD').AsString, 003, ' ')                            + // 003 - 183 a 185
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_UNITAR').AsFloat, 08, intDecUni), 008, '0') + // 008 - 186 a 193
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_DESCON').AsFloat, 08, 02), 008, '0')        + // 008 - 194 a 201
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_ACRESC').AsFloat, 08, 02), 008, '0')        + // 008 - 202 a 209
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_TOTLIQ').AsFloat, 14, 02), 014, '0')        + // 014 - 210 a 223
                  fPadR(qryR05.FieldByName('PAF_TOTALI').AsString, 007, ' ')                            + // 007 - 224 a 230
                  fPadR(qryR05.FieldByName('PAF_CANCEL').AsString, 001, ' ')                            + // 001 - 231 a 231
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_QTDCAN').AsFloat, 07, intDecQtd), 007, '0') + // 007 - 232 a 238
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_VALCAN').AsFloat, 13, 02), 013, '0')        + // 013 - 239 a 251
                  fPadL(fValNumForm(qryR05.FieldByName('PAF_CANACR').AsFloat, 13, 02), 013, '0')        + // 013 - 252 a 264
                  fPadR(qryR05.FieldByName('PAF_INDA_T').AsString, 001, ' ')                            + // 001 - 265 a 265
                  fPadR(qryR05.FieldByName('PAF_I_PP_T').AsString, 001, ' ')                            + // 001 - 266 a 266
                  fPadL(IntToStr(intDecQtd), 001, '0')                                                  + // 001 - 267 a 267
                  fPadL(IntToStr(intDecUni), 001, '0');                                                   // 001 - 268 a 268

      fGetArquivo(qryR05.FieldByName('PAF_NUMSER').AsString).Add(strLinha);
      FLinhaProcessada(Self, 'R05', qryR05.RecNo);
      qryR05.Next;
    End;

    FAntesFinalizarRegistro(Self, 'R05');

    FreeAndNil(qryR05);
  End
  Else
    FAntesFinalizarRegistro(Self, 'R05');

end;

procedure TExportaMovEcf.pExportaMovEcfR06;
  Var
    qryR06: TUniQuery;
    strLinha: String;
begin

  qryR06 := fCriaQuery;
  qryR06.SQL.Add('SELECT ');
  qryR06.SQL.Add('  * ');
  qryR06.SQL.Add('FROM ');
  qryR06.SQL.Add('  PAFR06 ');
  qryR06.SQL.Add('WHERE TRUE ');

  pSetaParametros(qryR06, 'PAF_DTAEMI');

  qryR06.Open;

  FAntesIniciarRegistro(Self, 'R06', qryR06.RecordCount);

  While (Not qryR06.Eof) Do
  Begin

    strLinha := 'R06'                                                                   + // 003 - 001 a 003
                fPadR(qryR06.FieldByName('PAF_NUMSER').AsString, 020, ' ')              + // 020 - 004 a 023
                ' '                                                                     + // 001 - 024 a 024
                fPadR(qryR06.FieldByName('PAF_MODECF').AsString, 020, ' ')              + // 020 - 025 a 044
                fPadL(qryR06.FieldByName('PAF_NUMUSU').AsString, 002, '0')              + // 002 - 045 a 046
                fPadL(qryR06.FieldByName('PAF_NUMCOO').AsString, 006, '0')              + // 006 - 047 a 052
                fPadL(qryR06.FieldByName('PAF_NUMGNF').AsString, 006, '0')              + // 006 - 053 a 058
                fPadL(qryR06.FieldByName('PAF_NUMGRG').AsString, 006, '0')              + // 006 - 059 a 064
                fPadL(qryR06.FieldByName('PAF_NUMCDC').AsString, 004, '0')              + // 004 - 065 a 068
                fPadR(qryR06.FieldByName('PAF_DENOMI').AsString, 002, ' ')              + // 002 - 069 a 070
                FormatDateTime('yyyymmdd', qryR06.FieldByName('PAF_DTAEMI').AsDateTime) + // 008 - 071 a 078
                FormatDateTime('hhnnss', qryR06.FieldByName('PAF_HOREMI').AsDateTime);    // 006 - 079 a 084

    fGetArquivo(qryR06.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

    FLinhaProcessada(Self, 'R06', qryR06.RecNo);

    qryR06.Next;
  End;

  FAntesFinalizarRegistro(Self, 'R06');

  FreeAndNil(qryR06);

end;

procedure TExportaMovEcf.pExportaMovEcfR07;
  Var
    qryR07: TUniQuery;
    strLinha: String;
begin
  qryR07 := fCriaQuery;
  qryR07.SQL.Add('SELECT ');
  qryR07.SQL.Add('  * ');
  qryR07.SQL.Add('FROM ');
  qryR07.SQL.Add('  PAFR07 ');
  qryR07.SQL.Add('WHERE TRUE ');

  pSetaParametros(qryR07, 'PAF_DTAEMI');

  qryR07.Open;

  FAntesIniciarRegistro(Self, 'R07', qryR07.RecordCount);

  While (Not qryR07.Eof) Do
  Begin

    strLinha := 'R07'                                                                           + // 003 - 001 a 003
                fPadR(qryR07.FieldByName('PAF_NUMSER').AsString, 020, ' ')                      + // 020 - 004 a 023
                ' '                                                                             + // 001 - 024 a 024
                fPadR(qryR07.FieldByName('PAF_MODECF').AsString, 020, ' ')                      + // 020 - 025 a 044
                fPadL(qryR07.FieldByName('PAF_NUMUSU').AsString, 002, '0')                      + // 002 - 045 a 046
                fPadL(qryR07.FieldByName('PAF_NUMCOO').AsString, 006, '0')                      + // 006 - 047 a 052
                fPadL(qryR07.FieldByName('PAF_NUMCCF').AsString, 006, '0')                      + // 006 - 053 a 058
                fPadL(qryR07.FieldByName('PAF_NUMGNF').AsString, 006, '0')                      + // 006 - 059 a 064
                fPadR(qryR07.FieldByName('PAF_MEIPAG').AsString, 015, ' ')                      + // 015 - 065 a 079
                fPadL(fValNumForm(qryR07.FieldByName('PAF_VALPAG').AsFloat, 13, 02), 013, '0')  + // 013 - 080 a 092
                fPadR(qryR07.FieldByName('PAF_ESTORN').AsString, 001, ' ')                      + // 001 - 093 a 093
                fPadL(fValNumForm(qryR07.FieldByName('PAF_VALEST').AsFloat, 13, 02), 013, '0');   // 013 - 094 a 106

    fGetArquivo(qryR07.FieldByName('PAF_NUMSER').AsString).Add(strLinha);

    FLinhaProcessada(Self, 'R07', qryR07.RecNo);

    qryR07.Next;
  End;

  FAntesFinalizarRegistro(Self, 'R07');

  FreeAndNil(qryR07);

end;

procedure TExportaMovEcf.pExportar;
begin
  pExportaMovEcfR01;
  pExportaMovEcfR02_R03;
  pExportaMovEcfR04_R05;
  pExportaMovEcfR06;
  pExportaMovEcfR07;

  pAssinarArquivos;
end;

procedure TExportaMovEcf.pSetaParametros(qryAux: TUniQuery; strCampoData: String);
begin
  If Not fEmptyStr(FNumSer) Then
    qryAux.SQL.Add('  AND PAF_NUMSER = :NUMSER ');

  If (FDtaIni > 0) Then
    qryAux.SQL.Add(' AND ' + strCampoData + ' BETWEEN :DTAINI AND :DTAFIN ');

  If Not fEmptyStr(FNumSer) Then
    qryAux.ParamByName('NUMSER').AsString := FNumSer;

  If (FDtaIni > 0) Then
  Begin
    qryAux.ParamByName('DTAINI').AsDateTime := FDtaIni;
    qryAux.ParamByName('DTAFIN').AsDateTime := FDtaFin;
  End;
end;

function TExportaMovEcf.fRetornaCodNacionalECF: String;
  Var
    strCodNacCadEcf : String;
begin
  strCodNacCadEcf := fCampoTabela('ECF_CODNAC', 'CADECF', ['ECF_NUMSER'], [FNumeroDeSerieCompleto]);

  Result := '';
  If Not fEmptyStr(strCodNac) Then
    Result := strCodNac
  Else If (Not fEmptyStr(strCodNacCadEcf)) Then
    Result := strCodNacCadEcf
  Else If (Pos('BEMATECH', VS_objFiscal.strModEcf) > 0) Then
    Result := '032101'
  Else If (Pos('SWEDA', VS_objFiscal.strModEcf) > 0) Then
    Result := '382002';
end;

end.
