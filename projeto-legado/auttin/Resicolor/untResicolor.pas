unit untResicolor;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, ComObj;

Type
  TColRsi = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type
  TResicolor = class
    private
      DataProducts: TUniConnection;
      DataSubprods: TUniConnection;
      DataFrm     : TUniConnection;
      DataMask    : TUniConnection;
      DataBases   : TUniConnection;
      DataCnts    : TUniConnection;
      DataRuler   : TUniConnection;

      ExcelFrm         : Variant;

      intMaxLinhaFrm   : Integer;
      intLinhaAtualFrm : Integer;

      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;
      tblCnts    : TUniQuery;
      tblRuler   : TUniQuery;

      strPatDbf : String;

      qryRSI_CADBAS : TUniQuery;
      qryRSI_CADCOL : TUniQuery;
      qryRSI_CADEMB : TUniQuery;
      qryRSI_CADNFM : TUniQuery;
      qryRSI_CADRSI : TUniQuery;

      intAutRsi     : Integer;

    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      procedure pCarregarRuler(strPatSub: String);
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColRsi : Array of TColRsi);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadRsi(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColRsi: Array of TColRsi; strDesTin: String): Boolean;
      procedure pGravaNovasFormulas;
      function fRetProxCodSeq: Integer;
      function fVerificaCadEmb: Boolean;
      procedure pImportarCadEmb;
      function fDiretorioValido: Boolean;
      function fVerificaCadBas: Boolean;
      function fVerificaCadCol: Boolean;

      function fRetUnidade(fltQuant : Double): String;

      function fMaxLinha(Excel: Variant): Integer;
      procedure pApagandoTemporarias;
      procedure pPreencheTemporariaFRM;

    public
      function fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
      Constructor Create;
      Destructor Destroy; Reintroduce;

  End;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadRsiNfm(CodPro : String);

implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta,untIConfTinta, untModulo;


{ TResicolor }

function TResicolor.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryRSI_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryRSI_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TResicolor.pGravaCadCol(arrColRsi: array of TColRsi);
  Var
    intCont : Integer;
    function fRetornaDescColorante(strColId: String): String;
    begin
      Result := '';
      strColId := fstrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);

      If tblCnts.Locate('ID', strColId, []) Then
        Result := tblCnts.FieldByname('DESCR').AsString;
    end;
begin
  For intCont := Low(arrColRsi) To High(arrColRsi) Do
  Begin
    qryRSI_CADCOL.First;

    If Not qryRSI_CADCOL.Locate('COL_CODCOL', arrColRsi[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColRsi[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColRsi[intCont].strCodCol) Then
          Break;

        qryRSI_CADCOL.Insert;
        qryRSI_CADCOL.FieldByName('COL_CODCOL').AsString := arrColRsi[intCont].strCodCol;
        qryRSI_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryRSI_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RSI_CADCOL', VS_strCodEmp);
        qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColRsi[intCont].strCodCol);
        qryRSI_CADCOL.Post;

      End;
    End
    Else If fEmptyStr(qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryRSI_CADCOL.Edit;
      qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColRsi[intCont].strCodCol);
      qryRSI_CADCOL.Post;
    End;
  End;
end;

procedure TResicolor.pCarregarBases;
begin
  DataBases.Database     := strPatDbf;

  If (Not DataBases.Connected) Then
    DataBases.Connected := True;

  tblBases := TUniQuery.Create(Nil);

  tblBases.Connection := DataBases;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('SELECT * FROM \BASES.DBF');
  tblBases.Open;
  tblBases.First;


  tblCnts := TUniQuery.Create(Nil);

  tblCnts.Connection := DataBases;

  tblCnts.Close;
  tblCnts.SQL.Add('SELECT * FROM \CNTS.DBF');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TResicolor.pCarregarFrm(strPatPro: String; strPatSub: String);
Var
  strPath : String;
begin
  pApagandoTemporarias;

  If FileExists(strPatSub + '\FRM.DBF') Then
    strPath := strPatSub
  Else
  If FileExists(strPatPro + '\FRM.DBF') Then
    strPath := strPatPro
  Else
    strPath := strPatDbf;

  Try
    ExcelFrm := CreateOleObject('Excel.Application');
    ExcelFrm.Visible := False;
    ExcelFrm.WorkBooks.Add(strPath + '\FRM.DBF');

    intMaxLinhaFrm   := fMaxLinha(ExcelFrm);
    intLinhaAtualFrm := 2;

    pPreencheTemporariaFRM;

    tblFrm := fCriaQuery;

    tblFrm.SQL.Clear;
    tblFrm.Close;
    tblFrm.SQL.Add('SELECT * FROM TMP_GERFRM');
    tblFrm.Open;

  Finally
    ExcelFrm.WorkBooks.Close;
  End;

end;

procedure TResicolor.pCarregarMask(strPatSub: String);
begin
  DataMask.Database     := strPatSub;

  If (Not DataMask.Connected) Then
    DataMask.Connected := True;

  tblMask:= TUniQuery.Create(Nil);
  tblMask.Connection := DataMask;


  tblMask.Close;
  tblMask.SQL.Add('SELECT * FROM \mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TResicolor.pCarregarProducts;
begin
  DataProducts.Database     := strPatDbf;

  If (Not DataProducts.Connected) Then
    DataProducts.Connected := True;

  tblProducts:= TUniQuery.Create(Nil);

  tblProducts.Connection := DataProducts;

  tblProducts.Close;
  tblProducts.SQL.Add('SELECT * FROM \products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TResicolor.pCarregarRuler(strPatSub: String);
begin
  DataRuler.Database     := strPatSub;

  If (Not DataRuler.Connected) Then
    DataRuler.Connected := True;

  tblRuler := TUniQuery.Create(Nil);

  tblRuler.Connection := DataRuler;

  tblRuler.Close;
  tblRuler.SQL.Add('SELECT * FROM \ruler.dbf');
  tblRuler.Open;
  tblRuler.First;
end;

procedure TResicolor.pCarregarSubprods(strPatPro: String);
begin


  DataSubprods.Database     := strPatPro;

  If (Not DataSubprods.Connected) Then
    DataSubprods.Connected := True;

  tblSubprods:= TUniQuery.Create(Nil);

  tblSubprods.Connection := DataSubprods;

  tblSubprods.Close;
  tblSubprods.SQL.Add('SELECT * FROM \subprods.dbf');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TResicolor.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
  Var
    intProducts : Integer;
    intSubProds : Integer;
    intFrm      : Integer;
    intMask     : Integer;
    intPos      : Integer;

    strProKey   : String;
    strPatPro   : String;
    strPatSub   : String;
    strSubKey   : String;
    strBaseSe   : String;
    strEmbCom   : String;
    strFormula  : String;

    arrColRsi   : Array Of TColRsi;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
    intQtdRegFrm: Integer;
    strSQLBase  : String;
  Const
    MAX_QTD_REG_FRM = 1200;
begin
  Result := False;
  If Not fDiretorioValido Then
  Begin
    fMensagem('', 'O path configurado não é válido', ['&OK']);
    Exit;
  End;

  pCarregarProducts;
  pCarregarBases;
  intCodSeq := 1;

  strSQLBase := tblBases.SQL.Text;

  If Not blnBasCol Then
    pZapTable('RSI_CADRSI');

  If Not fVerificaCadEmb Then
  Begin
    If qryRSI_CADEMB.IsEmpty Then
    Begin
      If fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
      begin
        Try
          pImportarCadEmb;
          Result := true;
        except
          Result := false;
        End
      End
    End
    Else
      fMensagem('', 'O Cadastro de Embalagem está inconsistente!', ['&OK']);

    Exit;
  End;

  If (Not blnBasCol) and (Not fVerificaCadBas) Then
  Begin
    fMensagem('', 'O cadastro de bases está vazio!', ['&OK']);
    Exit;
  End;

  If (Not blnBasCol) and (Not fVerificaCadCol) Then
  Begin
    fMensagem('', 'O cadastro de colorantes está vazio!', ['&OK']);
    Exit;
  End;


  For intProducts := 1 To tblProducts.RecordCount Do
  Begin
    strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString;
    strProKey := fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

    pCarregarSubprods(strPatPro);

    For intSubProds := 1 To tblSubprods.RecordCount Do
    Begin
      strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
      strSubKey := fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);

      pCarregarFrm(strPatPro, strPatSub);

      pCarregarMask(strPatSub);

      pCarregarRuler(strPatSub);

      If (tblFrm.RecordCount < MAX_QTD_REG_FRM) Or (Not blnBasCol) Then
        intQtdRegFrm := tblFrm.RecordCount
      Else
        intQtdRegFrm := MAX_QTD_REG_FRM;

      For intFrm := 1 To intQtdRegFrm Do
      Begin
        strBaseSe := fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);

        If strBaseSe = '00' Then
          Continue;

        strEmbCom := fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

        tblRuler.Locate('ID', tblFrm.FieldbyName('BASE_ID').AsString,[]);

        qryRSI_CADEMB.First;

        For intMask := 1 To qryRSI_CADEMB.RecordCount Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColRsi, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColRsi, Length(arrColRsi) + 1);
            intPos := Pos(',', strFormula);

            arrColRsi[Length(arrColRsi) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);

            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);

            If intPos <= 0 Then
              intPos := Length(strFormula)+1;

            arrColRsi[Length(arrColRsi) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ',')) * 0.616125
                                                          * fStrToFloat(AnsiReplaceStr(Trim(tblRuler.FieldByName('RULE').AsString),'.',','));

            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColRsi, 20);
          strQtdEmb := fStrZero(Trim(qryRSI_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

          If (qryRSI_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
          Begin

            tblBases.SQL.Clear;
            tblBases.Close;
            tblBases.SQL.Text := strSQLBase + ' WHERE TRIM(ID) LIKE ''%'+tblFrm.FieldByName('BASE_ID').AsString+'%'''+
                                              '   AND TRIM(PROD_KEY) = :PROD_KEY '+
                                              '   AND TRIM(SUBP_KEY) = :SUBP_KEY ';
            tblBases.ParamByName('PROD_KEY').AsString := Trim(tblProducts.FieldByName('ID').AsString);
            tblBases.ParamByName('SUBP_KEY').AsString := Trim(tblSubprods.FieldByName('ID').AsString);
            tblBases.Open;

            If Not tblBases.IsEmpty Then
            begin
              qryRSI_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);


              If blnBasCol Then
              Begin
                strDesTin := AnsiUpperCase(
                           Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                           Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                           FormatFloat('0.00', qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                pGravaCadCol(arrColRsi);


                If blnGerBase Then
                  pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
              End
              Else
              Begin
                strDesTin := AnsiUpperCase(
                              tblFrm.FieldByName('KEY1').AsString + ' ' +
                              Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                              tblFrm.FieldByName('KEY3').AsString
                              );
                For intColora := Low(arrColRsi) To High(arrColRsi) Do
                Begin
                  If fEmptyStr(arrColRsi[intColora].strCodCol) Then
                    Break;

                  arrColRsi[intColora].fltQtdCol := fCalQtdEmb(arrColRsi[intColora].fltQtdCol, strEmbCom, strQtdEmb);
                End;

                If fGravaCadRsi(intCodSeq, strBaseSe, strProKey, strSubKey, arrColRsi, strDesTin) Then
                  Inc(intCodSeq);
              End;

            End;

          End;
          qryRSI_CADEMB.Next;
        End;
        tblFrm.Next;

        If Saida <> nil Then
          Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                            tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                            tblFrm.RecNo, tblFrm.RecordCount, qryRSI_CADEMB.RecNo, qryRSI_CADEMB.RecordCount]);

        Application.ProcessMessages;

      End;
      tblSubprods.Next;
    End;
    tblProducts.Next;
  End;
  fGravaAutoIncrem('RSI_CADRSI', intAutRsi);
  If Not blnBasCol Then
    pGravaNovasFormulas;

  Result := True;
end;

function TResicolor.fGravaCadRsi(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColRsi: Array of TColRsi; strDesTin: String): Boolean;
  Var
    intCont : Integer;
begin
  Result := False;

  If qryRSI_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    If (qryRSI_CADRSI.FieldByName('RSI_DESCRI').AsString <> strDesTin) or
       (qryRSI_CADRSI.FieldByName('RSI_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryRSI_CADRSI.FieldByName('RSI_CODIG2').AsString <> tblFrm.FieldByName('KEY3').AsString) or
       (qryRSI_CADRSI.FieldByName('RSI_UNIDAD').AsString <> qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryRSI_CADRSI.IsEmpty Then
    Begin
      qryRSI_CADRSI.Insert;
      qryRSI_CADRSI.FieldByName('RSI_CODSEQ').AsString := fStrZero(intCodSeq, 15);
      qryRSI_CADRSI.FieldByName('RSI_DESCRI').AsString := strDesTin;
      qryRSI_CADRSI.FieldByName('RSI_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryRSI_CADRSI.FieldByName('RSI_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY3').AsString);
      qryRSI_CADRSI.FieldByName('RSI_UNIDAD').AsString := qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryRSI_CADRSI.FieldByName('RSI_CODEMP').AsString := VS_strCodEmp;
      qryRSI_CADRSI.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutRsi, VS_strCodEmp);
      Inc(intAutRsi);
      qryRSI_CADRSI.FieldByName('RSI_BASE__').AsString := qryRSI_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryRSI_CADRSI.FieldByName('RSI_PROKEY').AsString := qryRSI_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryRSI_CADRSI.FieldByName('RSI_SUBKEY').AsString := qryRSI_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      For intCont := Low(arrColRsi) To High(arrColRsi) Do
      Begin
        If fEmptyStr(arrColRsi[intCont].strCodCol) Then
          Break;

        qryRSI_CADRSI.FieldByName('RSI_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColRsi[intCont].strCodCol;
        qryRSI_CADRSI.FieldByName('RSI_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColRsi[intCont].fltQtdCol;
      End;
      qryRSI_CADRSI.Post;
      Result := True;
    End;

  End;
end;

function TResicolor.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

procedure TResicolor.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryRSI_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryRSI_CADBAS.Insert;
    qryRSI_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryRSI_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryRSI_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryRSI_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryRSI_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryRSI_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryRSI_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RSI_CADBAS', VS_strCodEmp);
    qryRSI_CADBAS.Post;
  End;
end;

procedure TResicolor.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  For intCont1 := 1 To qryRSI_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryRSI_CADNFM);
    qryRSI_CADNFM.Next;
  End;
end;

procedure TResicolor.pApagandoTemporarias;
begin
  fDropTable('TMP_GERFRM');
end;


function TResicolor.fRetProxCodSeq: Integer;
Var
  qryGen : TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.SQL.Text := 'SELECT RSI_CODSEQ '+
                       '  FROM RSI_CADRSI '+
                       ' ORDER BY RSI_CODSEQ DESC '+
                       ' LIMIT 1;';
    qryGen.Open;
    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('RSI_CODSEQ').AsInteger + 1;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TResicolor.fRetUnidade(fltQuant: Double): String;
begin
  Result := 'LT';

  If (fltQuant < 3000) Then
    Result := 'LT'
  Else
  If (fltQuant  >= 3000) And (fltQuant <= 3800) then
    Result := 'GL'
  Else
    Result := 'LA';
end;

constructor TResicolor.Create;
  Var
    conf: IConfTinta;
begin
  intAutRsi := 1;

  conf      := fGetConfTinta('RSI');
  strPatDbf := conf.fGet('PATRSI');

  If Not DirectoryExists(strPatDbf) Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  DataSubprods:= TUniConnection.Create(Nil);
  DataSubprods.ProviderName := 'DBF';
  DataSubprods.LoginPrompt  := False;

  DataProducts := TUniConnection.Create(Nil);
  DataProducts.ProviderName := 'DBF';
  DataProducts.LoginPrompt  := False;

  DataMask := TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt  := False;

  DataBases:= TUniConnection.Create(Nil);
  DataBases.ProviderName := 'DBF';
  DataBases.LoginPrompt  := False;

  DataRuler:= TUniConnection.Create(Nil);
  DataRuler.ProviderName := 'DBF';
  DataRuler.LoginPrompt  := False;

  qryRSI_CADBAS :=  fCriaQuery;
  qryRSI_CADCOL :=  fCriaQuery;
  qryRSI_CADEMB :=  fCriaQuery;
  qryRSI_CADNFM :=  fCriaQuery;
  qryRSI_CADRSI :=  fCriaQuery;

  qryRSI_CADBAS.SQL.Text := 'SELECT * FROM RSI_CADBAS';
  qryRSI_CADCOL.SQL.Text := 'SELECT * FROM RSI_CADCOL';
  qryRSI_CADEMB.SQL.Text := 'SELECT * FROM RSI_CADEMB';
  qryRSI_CADNFM.SQL.Text := 'SELECT * FROM RSI_CADNFM';
  qryRSI_CADRSI.SQL.Text := 'SELECT * FROM RSI_CADRSI';

  qryRSI_CADBAS.Open;
  qryRSI_CADCOL.Open;
  qryRSI_CADEMB.Open;
  qryRSI_CADNFM.Open;
  qryRSI_CADRSI.Open;
end;

destructor TResicolor.Destroy;
begin
  FreeAndNil(qryRSI_CADBAS);
  FreeAndNil(qryRSI_CADCOL);
  FreeAndNil(qryRSI_CADEMB);
  FreeAndNil(qryRSI_CADNFM);
  FreeAndNil(qryRSI_CADRSI);

  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);
  FreeAndNil(tblRuler);

  If Assigned(DataProducts) Then pFreeAndNil(DataProducts);
  If Assigned(DataSubprods) Then pFreeAndNil(DataSubprods);
  If Assigned(DataFrm)      Then pFreeAndNil(DataFrm);
  If Assigned(DataMask)     Then pFreeAndNil(DataMask);
  If Assigned(DataBases)    Then pFreeAndNil(DataBases);
  If Assigned(DataCnts)     Then FreeAndNil(tblCnts);
  If Assigned(DataRuler)    Then FreeAndNil(tblRuler);

  inherited Destroy;
end;

function TResicolor.fVerificaCadEmb: Boolean;
  Var
    conDataCans : TUniConnection;
    QryCans     : TUniQuery;
    intCont     :  Integer;
    intErros    : Integer;
begin
  Try
    intErros := 0;

    conDataCans:= TUniConnection.Create(Nil);

    conDataCans.ProviderName := 'DBF';
    conDataCans.LoginPrompt  := False;

    conDataCans.Database     := strPatDbf;

    If (Not conDataCans.Connected) Then
      conDataCans.Connected := True;

    QryCans := TUniQuery.Create(Nil);

    QryCans.Connection := conDataCans;

    QryCans.Close;
    QryCans.SQL.Clear;
    QryCans.SQL.Add('SELECT * FROM \CANS.DBF');
    QryCans.Open;
    QryCans.First;

    If Not qryRSI_CADEMB.IsEmpty Then
    Begin
      For intCont := 1 To QryCans.RecordCount Do
      Begin
        If (QryCans.FieldByName('NOM_Q').AsFloat > 0) And (Not fEmptyStr(QryCans.FieldByName('NOM_Q').AsString)) Then
        Begin

          If Not qryRSI_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(QryCans.FieldByName('ID').AsString), 2), []) Then
          Begin
            Inc(intErros);
            Break;
          End
          Else
          If fEmptyStr(qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
          Begin
            Inc(intErros);
            Break;
          End;
        End;

        QryCans.Next;
      End;
    End
    Else
      Inc(intErros);

    Result := intErros = 0;
    QryCans.Close;

  Finally
    If Assigned(QryCans) Then  FreeAndNil(QryCans);
    If Assigned(conDataCans)Then  FreeAndNil(conDataCans);
  End;
end;

procedure TResicolor.pImportarCadEmb;
  Var
    tblCans  : TUniQuery;
    DataCans : TUniConnection;
    intCont  : Integer;
begin
  Try

    DataCans := TUniConnection.Create(Nil);

    DataCans.ProviderName := 'DBF';
    DataCans.LoginPrompt  := False;

    DataCans.Database     := strPatDbf;

    If (Not DataCans.Connected) Then
      DataCans.Connected := True;

    tblCans := TUniQuery.Create(Nil);

    tblCans.Connection := DataCans;

    tblCans.Close;
    tblCans.SQL.Clear;
    tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
    tblCans.Open;
    tblCans.First;

    For intCont := 1 To tblCans.RecordCount Do
    Begin
      qryRSI_CADEMB.Insert;
      qryRSI_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
      qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
      qryRSI_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
      qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
      qryRSI_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RSI_CADEMB', VS_strCodEmp);
      qryRSI_CADEMB.Post;
      tblCans.Next;
    End;

    tblCans.Close;

  Finally
    if Assigned(tblCans) Then pFreeAndNil(tblCans);
    if Assigned(DataCans)Then pFreeAndNil(DataCans);
  End;

end;

procedure TResicolor.pPreencheTemporariaFRM;
var
  qryTbl : TUniQuery;
  qryFrm : TUniQuery;
  intTemp: Integer;
begin
  Try
    fDropTable('TMP_GERFRM');

    qryTbl := fCriaQuery;

    qryTbl.SQL.Text := ' CREATE TABLE TMP_GERFRM     ' +
                       ' (                           ' +
                       '    BASE_ID CHAR(02),        ' +
                       '    CAN_ID  CHAR(02),        ' +
                       '    FORMULA VARCHAR(100),    ' +
                       '    KEY1    VARCHAR(100),    ' +
                       '    KEY2    VARCHAR(100),    ' +
                       '    KEY3    VARCHAR(100),    ' +
                       '    COMMENT VARCHAR(255)     ' +
                       '  );                         ';
    qryTbl.ExecSQL;

    qryFrm := fCriaQuery;

    qryFrm.SQL.Text := ' SELECT * FROM TMP_GERFRM WHERE FALSE  ';
    qryFrm.Open;

    For intTemp := 1 To intMaxLinhaFrm Do
    Begin
      qryFrm.Insert;
      qryFrm.FieldByName('BASE_ID').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,8].Text;
      qryFrm.FieldByName('CAN_ID').AsString  := ExcelFrm.Cells.Item[intLinhaAtualFrm,9].Text;
      qryFrm.FieldByName('FORMULA').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,11].Text;
      qryFrm.FieldByName('KEY1').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,3].Text;
      qryFrm.FieldByName('KEY2').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,4].Text;
      qryFrm.FieldByName('KEY3').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,5].Text;
      qryFrm.FieldByName('COMMENT').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,27].Text;
      qryFrm.Post;

      intLinhaAtualFrm := intLinhaAtualFrm + 1;
    End;
  Finally
    If Assigned(qryTbl) Then FreeAndNil(qryTbl);
    If Assigned(qryFrm) Then FreeAndNil(qryFrm);
  End;

end;

function TResicolor.fDiretorioValido: Boolean;
begin
  Result := True;
  If Not FileExists(strPatDbf + '\PRODUCTS.DBF') Then
    Result := False;
end;

function TResicolor.fVerificaCadBas: Boolean;
begin
  Result := (Not qryRSI_CADBAS.IsEmpty);
end;

function TResicolor.fVerificaCadCol: Boolean;
begin
  Result := Not qryRSI_CADCOL.IsEmpty;
end;

function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  Var
    intCont1  : Integer;
    intCont2  : Integer;
    qryCadBas : TUniQuery;
    qryCadRsi : TUniQuery;

begin
  qryCadRsi := fCriaQuery;
  qryCadRsi.SQL.Text := 'SELECT * FROM RSI_CADRSI LIMIT 0';
  qryCadRsi.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM RSI_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';
  qryCadBas.ParamByName('BASE').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadRsiNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadRsi.Insert;
    qryCadRsi.FieldByName('RSI_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadRsi.FieldByName('RSI_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadRsi.FieldByName('RSI_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadRsi.FieldByName('RSI_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
      qryCadRsi.FieldByName('RSI_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
      qryCadRsi.FieldByName('RSI_CODEMP').AsString := VS_strCodEmp;
      qryCadRsi.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RSI_CADRSI',VS_strCodEmp);
      qryCadRsi.FieldByName('RSI_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 15);
      qryCadRsi.FieldByName('RSI_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
      qryCadRsi.FieldByName('RSI_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
      qryCadRsi.FieldByName('RSI_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;
    qryCadRsi.FieldByName('RSI_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;
    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadRsi.FieldByName('RSI_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadRsi.FieldByName('RSI_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString)
    End;
    qryCadRsi.Post;
    qryCadBas.Next;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadRsi);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Text := 'SELECT * FROM RSI_CADEMB';
    qryGen.Open;

    qryGen.Locate('EMB_UNIDAD', strUniOri, []);
    fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    qryGen.Locate('EMB_UNIDAD', strUniNov, []);
    fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    Result := fltUniNov * fltQtd / fltUniOri;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pRemoveCadRsiNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Text :=  'DELETE '+
                        '  FROM RSI_CADRSI '+
                        '  WHERE  RSI_CODIGO = :CODPRO ';

    qryGen.ParamByName('CODPRO').AsString := CodPro;

    qryGen.ExecSQL;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Text := 'SELECT RSI_CODSEQ '+
                       '  FROM RSI_CADRSI '+
                       ' ORDER BY RSI_CODSEQ DESC '+
                       ' LIMIT 1;';
    qryGen.Open;
    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('RSI_CODSEQ').AsInteger + 1;
  Finally
    FreeAndNil(qryGen);
  End;

End;

end.
