unit untWanda;

interface

uses  StrUtils, Classes, Uni, SysUtils, Variants, DB, Forms;

type
  TResBas = Record
   strCodBas: String;
   fltPesBas: Double;
   fltPes1kg: Double;
   fltVol1kg: Double;
   fltVolInd: Double;
   fltPesVol: Double;
   fltValBas: Double;
   fltPesUni: Double;
   fltPreGra: Double;
   fltEmbAla: Double;
  End;

Type TArrayResBas = Array Of TResBas;

  function fPosicionaBaseTmp(Var qryCadBas: TUniQuery; strLinha, strCodBas: String): Boolean;
  function fPosicionaBase(qryCadBas: TUniQuery; strLinha, strCodBas: String): Boolean;
  function fPosicionaEmbalagemTmp(qryEmbala: TUniQuery; strLinha, strCodUni: String): Boolean;
  function fCalculaCustoBase(Var arrResBas: TArrayResBas): Double;
  function fRetDescLinha(strCodigo: String): String;

  procedure pCarregaArquivosTxt;
  function fWandaGeraArquivo(blnAlteraBases: Boolean): Boolean;

implementation

uses  untFuncoes, untModuloTinta, untFuncoesSimples;

function fPosicionaBaseTmp(Var qryCadBas: TUniQuery; strLinha, strCodBas: String): Boolean;
begin

  qryCadBas.Close;
  qryCadBas.ParamByName('LINHA').AsString := strLinha;
  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.Open;

  Result := (Not qryCadBas.IsEmpty);

end;

procedure pCarregaArquivosTxt;
  Var
    strSQL: String;
    strPatWan: String;

    stlArqTxt: TStringList;

    intContador: Integer;
begin

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_EMBALA (DESCRI VARCHAR(100)) ENGINE=MYISAM ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_BASES (DESCRI VARCHAR(100)) ENGINE=MYISAM ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  If (fTabelaExiste('TMP_LAYER')) Then
    fDropTable('TMP_LAYER');

  strSQL := '';
  strSQL := strSQL + 'CREATE TABLE TMP_LAYER ( ';
  strSQL := strSQL + '  LINHA VARCHAR(03), ';
  strSQL := strSQL + '  CODIGO VARCHAR(14), ';
  strSQL := strSQL + '  REFERE VARCHAR(14), ';
  strSQL := strSQL + '  CODBAS VARCHAR(10), ';
  strSQL := strSQL + '  PERCEN NUMERIC(12, 2)) ENGINE=MYISAM ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strPatWan := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'PATWAN', ''), '\', '\\');

  stlArqTxt := TStringList.Create;

  stlArqTxt.LoadFromFile(strPatWan + '\akzembal.txt');

  For intContador := 0 To stlArqTxt.Count -1 Do
  Begin

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO TMP_EMBALA VALUES ("' + stlArqTxt[intContador] + '") ';
    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  End;

  stlArqTxt.Clear;
  stlArqTxt.LoadFromFile(strPatWan + '\akzbases.txt');

  For intContador := 0 To stlArqTxt.Count -1 Do
  Begin

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO TMP_BASES VALUES ("' + stlArqTxt[intContador] + '") ';
    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  End;

  stlArqTxt.Clear;
  stlArqTxt.LoadFromFile(strPatWan + '\akzlayer.txt');

  For intContador := 0 To stlArqTxt.Count -1 Do
  Begin

    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO TMP_LAYER VALUES (' +
                              QuotedStr(LeftStr(stlArqTxt[intContador], 3)) + ', ' +
                              QuotedStr(Copy(stlArqTxt[intContador], 5, 14)) + ', ' +
                              QuotedStr(Copy(stlArqTxt[intContador], 20, 14)) + ', ' +
                              QuotedStr(Copy(stlArqTxt[intContador], 56, 10)) + ', ' +
                              AnsiReplaceStr(Copy(stlArqTxt[intContador], 67, 8), ',', '.') + ') ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  End;

  strSQL := '';
  strSQL := strSQL + '  CREATE INDEX IDX_TMP ON TMP_LAYER(LINHA, CODIGO, REFERE) ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

function fWandaGeraArquivo(blnAlteraBases: Boolean): Boolean;
  Var
    strSQL: String;

    strLinTxt: String;

    strLinha : String;
    strCodigo: String;
    strDesCri: String;
    strRefere: String;
    strMonTad: String;
    strAnoTin: String;
    strCodBas: String;
    fltPesUti: Double;
    fltValUti: Double;
    arrResCon: TArrayResBas;
    arrResDil: TArrayResBas;
    intCodSeq: Integer;
    fltPerCen: Double;
    fltPesBas: Double;
    fltValBas: Double;
    fltPes1kg: Double;
    intRegAtu: Integer;
    strSomLin: String;
    strLinDil: String;
    strBasDil: String;
    fltPreCus: Double;

    strCodUni: String;
    fltEmbala: Double;

    blnIncBas: Boolean;

    stlFormul: TStringList;
    intContador: Integer;

    qryLayer: TUniQuery;
    qryBases: TUniQuery;
    qryEmbala: TUniQuery;

    qryCadBas: TUniQuery;
    qryCadWan: TUniQuery;

    strPatWan: String;
    fltFveWan: Double;
    intTamMat: Integer;

    fltPreCusCon: Double;
    fltPreCusDil: Double;

    intLinha: Integer;

begin

  strPatWan := fArqIniTinta(0, 'WANDA', 'PATWAN', '');
  fltFveWan := fStrToFloat(fArqIniTinta(0, 'WANDA', 'FVEWAN', '0'));

  Result := False;
  If (Not FileExists(strPatWan + '\akzembal.txt')) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo ' + strPatWan + '\akzembal.txt.' + #13#10 +
                  'Verifique!', ['&Ok']);
    Exit;
  End;

  If (Not FileExists(strPatWan + '\akzbases.txt')) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo ' + strPatWan + '\akzbases.txt.' + #13#10 +
                  'Verifique!', ['&Ok']);
    Exit;
  End;

  If (Not FileExists(strPatWan + '\akzlayer.txt')) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo ' + strPatWan + '\akzlayer.txt.' + #13#10 +
                  'Verifique!', ['&Ok']);
    Exit;
  End;

  If (Not FileExists(strPatWan + '\akzformu.txt')) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo ' + strPatWan + '\akzformu.txt.' + #13#10 +
                  'Verifique!', ['&Ok']);
    Exit;
  End;

  pCarregaArquivosTxt;

  strCodBas := '';
  intCodSeq := 1;

  intRegAtu := 0;
  strSomLin := fTransform(fArqIniTinta(0, 'WANDA', 'LINWAN', ''), 3);
  strBasDil := fArqIniTinta(0, 'WANDA', 'BD1WAN', '');
  strLinDil := fArqIniTinta(0, 'WANDA', 'LD1WAN', '');

  stlFormul := TStringList.Create;
  stlFormul.LoadFromFile(strPatWan + '\akzformu.txt');

  qryLayer  := fCriaQuery;
  qryBases  := fCriaQuery;
  qryEmbala := fCriaQuery;

  qryCadBas := fCriaQuery;
  qryCadWan := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_CADBAS.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  WANPRO_CADBAS.BAS_VALBAS AS ITE_PREVEN ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WAN_CADBAS ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = BAS_CODITE  ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  pZapTable('WAN_CADWAN');

  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM WAN_CADWAN');
    Open;
  End;

  {*******************************************}
  {* PREPARA A QUERY DO ARQUIVO LAYER PARA A *}
  {* CONSULTA                                *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_LAYER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LINHA = :LINHA AND ';
  strSQL := strSQL + '  CODIGO = :CODIGO AND ';
  strSQL := strSQL + '  REFERE = :REFERE ';

  With qryLayer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  {*******************************************}
  {* PREPARA A QUERY DO ARQUIVO DE EMBALAGEM *}
  {* PARA A CONSULTA                         *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_EMBALA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LEFT(DESCRI, 3) = :LINHA AND ';
  strSQL := strSQL + '  SUBSTRING(DESCRI, 5, 2) = :UNIDAD ';

  With qryEmbala Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_BASES ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LEFT(DESCRI, 3) = :LINHA AND ';
  strSQL := strSQL + '  SUBSTRING(DESCRI, 5, 10) = :CODBAS ';

  With qryBases Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  intLinha := 0;

  Try

    For intContador := 0 To stlFormul.Count -1 Do
    Begin

      Application.ProcessMessages;
      intLinha  := intContador;
      strLinTxt := stlFormul[intContador];

      strLinha  := LeftStr(strLinTxt, 3);
      strCodigo := Copy(strLinTxt, 05, 14);
      strDescri := Copy(strLinTxt, 35, 30);
      strRefere := Copy(strLinTxt, 20, 14);
      strMontad := Copy(strLinTxt, 66, 15);
      strAnoTin := Copy(strLinTxt, 82, 09);

      If (Not fEmptyStr(strSomLin) And (Pos(strLinha, strSomLin) <= 0)) Then
        Continue;

      SetLength(arrResCon, 0);
      SetLength(arrResDil, 0);

      qryLayer.Close;
      qryLayer.ParamByName('LINHA').AsString  := strLinha;
      qryLayer.ParamByName('CODIGO').AsString := strCodigo;
      qryLayer.ParamByName('REFERE').AsString := strRefere;
      qryLayer.Open;

      SetLength(arrResCon, 0);
      SetLength(arrResDil, 0);

      While (Not qryLayer.Eof) Do
      Begin

        strCodBas := qryLayer.FieldByName('CODBAS').AsString;
        fltPerCen := fStrToFloat(qryLayer.FieldByName('PERCEN').AsString);

        If (Not fPosicionaBaseTmp(qryBases, strLinha, strCodBas)) Then
        Begin
          qryLayer.Next;
          Continue;
        End;

        strCodUni := Copy(qryBases.FieldByName('DESCRI').AsString, 47, 2);

        fltPesBas := fStrToFloat(Copy(qryBases.FieldByName('DESCRI').AsString, 50, 08));

        fltEmbala := 1;
        If (fPosicionaEmbalagemTmp(qryEmbala, strLinha, strCodUni)) Then
        Begin
          fltEmbala := fStrToFloat(Copy(qryEmbala.FieldByName('DESCRI').AsString, 37, 05));
        End;

        {*******************************************}
        {* GERA ARQUIVO DE BASE                    *}
        {****************************************MV*}
        blnIncBas := False;

        If (Not fPosicionaBase(qryCadBas, strLinha, strCodBas)) Then
        Begin

          qryCadBas.Append;
          qryCadBas.FieldByName('BAS_LINHA_').AsString := strLinha;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
          qryCadBas.FieldByName('BAS_DESBAS').AsString := Copy(qryBases.FieldByName('DESCRI').AsString, 16, 30);

          blnIncBas := True;

        End;

        If (blnAlteraBases) Or (blnIncBas) Then
        Begin
          If (qryCadBas.State = dsBrowse) Then
            qryCadBas.Edit;

          qryCadBas.FieldByName('BAS_PESUNI').AsFloat  := fltEmbala;
          qryCadBas.FieldByName('BAS_PESBAS').AsFloat  := fltPesBas;

          If (qryCadBas.State = dsInsert) Then
            qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WAN_CADBAS', VS_strCodEmp);

          qryCadBas.Post;
        end;

        fltPesBas := qryCadBas.FieldByName('BAS_PESBAS').AsFloat;
        fltValBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
        fltEmbala := qryCadBas.FieldByName('BAS_PESUNI').AsFloat;

        {*******************************************}
        {* COMENTÁRIO                              *}
        {****************************************MV*}
        fltPes1Kg := (fltPerCen * 10);

        intTamMat := Length(arrResCon);
        SetLength(arrResCon, intTamMat+1);
        arrResCon[intTamMat].strCodBas := strCodBas;
        arrResCon[intTamMat].fltPesBas := fltPesBas;
        arrResCon[intTamMat].fltPes1kg := fltPes1kg;
        arrResCon[intTamMat].fltVol1kg := fltPes1kg / fltPesBas;
        arrResCon[intTamMat].fltVolInd := 0.0;
        arrResCon[intTamMat].fltPesVol := 0.0;
        arrResCon[intTamMat].fltValBas := fltValBas;
        arrResCon[intTamMat].fltPesUni := 0.0;
        arrResCon[intTamMat].fltPreGra := 0.0;
        arrResCon[intTamMat].fltEmbAla := fltEmbala;

        {*******************************************}
        {* DILUIDO                                 *}
        {****************************************MV*}
        If (Pos(strLinha, strLinDil) > 0) Then
        Begin

          fPosicionaBase(qryCadBas, strLinDil, strBasDil);

          fltPesBas := qryCadBas.FieldByName('BAS_PESBAS').AsFloat;
          fltValBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
          fltEmbala := qryCadBas.FieldByName('BAS_PESUNI').AsFloat;

          fltPerCen := fltPerCen - (fltPerCen * 0.30);
          fltPes1kg := fltPerCen * 10;

          intTamMat := Length(arrResDil);
          SetLength(arrResDil, intTamMat+1);
          arrResDil[intTamMat].strCodBas := strBasDil;
          arrResDil[intTamMat].fltPesBas := fltPesBas;
          arrResDil[intTamMat].fltPes1kg := fltPes1kg;
          arrResDil[intTamMat].fltVol1kg := fltPes1kg / fltPesBas;
          arrResDil[intTamMat].fltVolInd := 0.0;
          arrResDil[intTamMat].fltPesVol := 0.0;
          arrResDil[intTamMat].fltValBas := fltValBas;
          arrResDil[intTamMat].fltPesUni := 0.0;
          arrResDil[intTamMat].fltPreGra := 0.0;
          arrResDil[intTamMat].fltEmbAla := fltEmbala;

        End;


        qryLayer.Next;

      End;

      fltPreCusCon := fCalculaCustoBase(arrResCon);
      fltPreCusDil := fCalculaCustoBase(arrResDil);

      qryCadWan.Append;
      qryCadWan.FieldByName('WAN_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryCadWan.FieldByName('WAN_LINHA_').AsString := strLinha;
      qryCadWan.FieldByName('WAN_NOMLIN').AsString := fRetDescLinha(strLinha);
      qryCadWan.FieldByName('WAN_CODIGO').AsString := strCodigo;
      qryCadWan.FieldByName('WAN_DESCRI').AsString := strDesCri;
      qryCadWan.FieldByName('WAN_REFERE').AsString := strRefere;
      qryCadWan.FieldByName('WAN_MONTAD').AsString := strMonTad;
      qryCadWan.FieldByName('WAN_A_N_O_').AsString := strAnoTin;
      qryCadWan.FieldByName('WAN_CONCUS').AsFloat  := fltPreCusCon;
      qryCadWan.FieldByName('WAN_CONVEN').AsFloat  := fltPreCusCon * fltFveWan;
      qryCadWan.FieldByName('WAN_DILCUS').AsFloat  := fltPreCusDil;
      qryCadWan.FieldByName('WAN_DILVEN').AsFloat  := fltPreCusDil * fltFveWan;
      qryCadWan.FieldByName('WAN_CODEMP').AsString := VS_strCodEmp;
      qryCadWan.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intCodSeq, VS_strCodEmp);
      qryCadWan.Post;

      Inc(intCodSeq);

    End;

  Except

    On E: Exception Do
    Begin
      fMensagem('', 'Erro ao gerar Tinta: ' + #13#10 + IntToStr(intLinha) + ' - ' + strLinTxt, ['&Ok']);
      Result := False;
    End;

  End;

  qryLayer.Close;
  qryBases.Close;
  qryEmbala.Close;

  FreeAndNil(qryLayer);
  FreeAndNil(qryBases);
  FreeAndNil(qryEmbala);

  FreeAndNil(stlFormul);

  fDropTable('TMP_LAYER');
  fDropTable('TMP_BASES');
  fDropTable('TMP_EMBALA');

end;

function fPosicionaBase(qryCadBas: TUniQuery; strLinha, strCodBas: String): Boolean;
begin

  Result := qryCadBas.Locate('BAS_LINHA_;BAS_CODBAS', VarArrayOf([strLinha, strCodBas]), []);

end;

function fPosicionaEmbalagemTmp(qryEmbala: TUniQuery; strLinha, strCodUni: String): Boolean;
begin

  qryEmbala.Close;
  qryEmbala.ParamByName('LINHA').AsString := strLinha;
  qryEmbala.ParamByName('UNIDAD').AsString := strCodUni;
  qryEmbala.Open;

  Result := (Not qryEmbala.IsEmpty);

end;

function fCalculaCustoBase(Var arrResBas: TArrayResBas): Double;
  Var
    intContador: Integer;
    fltVolInd: Double;
    fltPesUni: Double;
    fltPreGra: Double;
    fltTotVol: Double;
begin

  {*******************************************}
  {* CALCULTA TOTAL DO VOLUME                *}
  {****************************************MV*}
  Result := 0.0;
  fltTotVol := 0.0;

  For intContador := 0 To Length(arrResBas) -1 Do
    fltTotVol := fltTotVol + arrResBas[intContador].fltVol1Kg;

  {*******************************************}
  {* CALCULA VALORES DA MATRIZ arrResBas     *}
  {****************************************MV*}
  For intContador := 0 To Length(arrResBas) -1 Do
  Begin
    fltVolInd := (arrResBas[intContador].fltVol1Kg / fltTotVol) * 900;
    fltPesUni := arrResBas[intContador].fltPesBas * (arrResBas[intContador].fltEmbala * 1000);
    fltPreGra := arrResBas[intContador].fltValBas / fltPesUni;

    arrResBas[intContador].fltVolInd := fltVolInd;
    arrResBas[intContador].fltPesVol := fltVolInd * arrResBas[intContador].fltPesBas;
    arrResBas[intContador].fltPesUni := fltPesUni;
    arrResBas[intContador].fltPreGra := fltPreGra;

    Result := Result + arrResBas[intContador].fltPreGra * arrResBas[intContador].fltPesVol;

  End;

  Result := fFormataFloat(Result, 02);

end;

function fRetDescLinha(strCodigo: String): String;
begin
  Case StrToInt(strCodigo) Of
     1 : Result := Uppercase('Autobase Plus 100:50');
     4 : Result := Uppercase('Wandabase HS');
     6 : Result := Uppercase('Wandalac');
     8 : Result := Uppercase('Wanda PU HS');
     9 : Result := Uppercase('Wandacar');
    11 : Result := Uppercase('Single Stage Converter');
    12 : Result := Uppercase('Autobase Plus Baseline 100:80');
    13 : Result := Uppercase('Autocoat BT100');
    14 : Result := Uppercase('Autobase Plus 100:80');
    15 : Result := Uppercase('Autocoat BT110');
    16 : Result := Uppercase('Autocoat BT120');
    17 : Result := Uppercase('Autocoat BT130');
    19 : Result := Uppercase('Autobase Plus Baseline 100:50');
    27 : Result := Uppercase('Autowave MM');
    58 : Result := Uppercase('Wanda PU MS');
    59 : Result := Uppercase('Autocoat BT90');
    72 : Result := Uppercase('Tech Fleet PU');
    74 : Result := Uppercase('Tech Fleet Epoxy');
    75 : Result := Uppercase('Tech Fleet Sintetico');
    76 : Result := Uppercase('Tech Fleet Laca');
  Else
    Result := '';
  End

end;

end.
