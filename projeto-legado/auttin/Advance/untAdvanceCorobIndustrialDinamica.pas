unit untAdvanceCorobIndustrialDinamica;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, untIConfTinta,
     DBFUniProvider, ComObj;

Type
  TColAdv = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type
  TAdvanceCorobIndustrial = class
    private
      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;
      tblCnts    : TUniQuery;

      strPatDbf : String;

      qryADV_CADBAS : TUniQuery;
      qryADV_CADCOL : TUniQuery;
      qryADV_CADEMB : TUniQuery;
      qryADV_CADNFM : TUniQuery;
      qryADV_CADADV : TUniQuery;

      intAutAdv     : Integer;
      conf: IConfTinta;

      DataDBFPro : TUniConnection;
      DataDBFSub : TUniConnection;

      DataDBFMas : TUniConnection;

      ExcelFrm   : Variant;

      intMaxLinhaFrm   : Integer;
      intLinhaAtualFrm : Integer;

    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColAdv : Array of TColAdv);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadAdv(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColAdv: Array of TColAdv; strDesTin: String): Boolean;
      procedure pGravaNovasFormulas;
      procedure pAtualizaTabelas;
      function fRetProxCodSeq: Integer;
      function fVerificaCadEmb: Boolean;
      procedure pImportarCadEmb;
      function fDiretorioValido: Boolean;
      function fVerificaCadBas: Boolean;
      function fVerificaCadCol: Boolean;
      procedure pApagandoTemporarias;
      procedure pPreencheTemporariaFRM;
      function fMaxLinha(Excel: Variant): Integer;

    public
      function fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
      Constructor Create;
      Destructor Destroy; Reintroduce;

  End;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadAdvNfm(CodPro : String);

implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta, untModulo;


{ TAdvanceCorobIndustrial }

function TAdvanceCorobIndustrial.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryADV_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryADV_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TAdvanceCorobIndustrial.pGravaCadCol(arrColAdv: array of TColAdv);
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
  For intCont := Low(arrColAdv) To High(arrColAdv) Do
  Begin
    qryADV_CADCOL.First;
    If Not qryADV_CADCOL.Locate('COL_CODCOL', arrColAdv[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColAdv[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColAdv[intCont].strCodCol) Then
          Break;

        qryADV_CADCOL.Insert;
        qryADV_CADCOL.FieldByName('COL_CODCOL').AsString := arrColAdv[intCont].strCodCol;
        qryADV_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryADV_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADVCOR_CADCOL', VS_strCodEmp);
        qryADV_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAdv[intCont].strCodCol);
        qryADV_CADCOL.Post;
      End;
    End
    Else If fEmptyStr(qryADV_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryADV_CADCOL.Edit;
      qryADV_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAdv[intCont].strCodCol);
      qryADV_CADCOL.Post;
    End;
  End;
end;

procedure TAdvanceCorobIndustrial.pCarregarBases;
begin
  tblBases.Close;
//  tblBases.SQL.Add('SELECT * FROM ' + strPatDbf + '\bases.dbf');
  tblBases.SQL.Clear;
  tblBases.SQL.Add('SELECT * FROM \bases.dbf');
  tblBases.Open;
  tblBases.First;

  tblCnts.Close;
//  tblCnts.SQL.Add('SELECT * FROM ' + strPatDbf + '\cnts.dbf');
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('SELECT * FROM \cnts.dbf');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAdvanceCorobIndustrial.pCarregarFrm(strPatPro: String; strPatSub: String);
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

    tblFrm.Close;
    tblFrm.SQL.Clear;
    tblFrm.SQL.Add('SELECT * FROM TMP_GERFRM');
    tblFrm.Open;
  Finally
    ExcelFrm.WorkBooks.Close;
  End;
end;

procedure TAdvanceCorobIndustrial.pCarregarMask(strPatSub: String);
begin
  DataDBFMas.Connected := False;

  DataDBFMas.Database := strPatSub;

  If Assigned(tblMask) Then
    FreeAndNil(tblMask);

  tblMask := fCriaQuery(nil, DataDBFMas);

  If (Not DataDBFMas.Connected) Then
    DataDBFMas.Connected := True;

  tblMask.Close;
//  tblMask.SQL.Add('SELECT * FROM ' + strPatSub + '\mask.dbf');
  tblMask.SQL.Clear;
  tblMask.SQL.Add('SELECT * FROM \mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TAdvanceCorobIndustrial.pCarregarProducts;
begin
  DataDBFPro.Connected := False;

  DataDBFPro.Database := strPatDbf;

  If (Not DataDBFPro.Connected) Then
    DataDBFPro.Connected := True;

  tblProducts.Close;
//  tblProducts.SQL.Add('SELECT * FROM ' + strPatDbf + '\products.dbf');
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('SELECT * FROM \products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAdvanceCorobIndustrial.pCarregarSubprods(strPatPro: String);
begin
  DataDBFSub.Connected := False;

  DataDBFSub.Database := strPatPro;

  If Assigned(tblSubprods) Then
    FreeAndNil(tblSubprods);

  tblSubprods := fCriaQuery(nil, DataDBFSub);

  If (Not DataDBFSub.Connected) Then
    DataDBFSub.Connected := True;

  tblSubprods.Close;
//  tblSubprods.SQL.Add('SELECT * FROM ' + strPatPro + 'subprods.dbf');
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('SELECT * FROM \SUBPRODS.DBF');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TAdvanceCorobIndustrial.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColAdv   : Array Of TColAdv;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
begin
  Result := False;
  If Not fDiretorioValido Then
  Begin
    fMensagem('', 'O path configurado não é válido', ['&OK']);
    Exit;
  End;

  pCarregarProducts;
  pCarregarBases;
  pAtualizaTabelas;
  intCodSeq := 1;
  If Not blnBasCol Then
    pZapTable('ADVCOR_CADADV');

  If Not fVerificaCadEmb Then
  Begin
    If qryADV_CADEMB.IsEmpty Then
    Begin
      If fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
        pImportarCadEmb;
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
    strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString; //+ '\';
    strProKey := fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);
    pCarregarSubprods(strPatPro);

    For intSubProds := 1 To tblSubprods.RecordCount Do
    Begin
      strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString; // + '\';
      strSubKey := fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
      pCarregarFrm(strPatPro, strPatSub);
      pCarregarMask(strPatSub);

      For intFrm := 1 To tblFrm.RecordCount Do
      Begin
        strBaseSe := fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);
        strEmbCom := fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

        If fEmptyStr(tblFrm.FieldbyName('BASE_ID').AsString) Then
        Begin
          tblFrm.Next;
          Continue;
        End;

        qryADV_CADEMB.First;
        For intMask := 1 To qryADV_CADEMB.RecordCount Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColAdv, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColAdv, Length(arrColAdv) + 1);
            intPos := Pos(',', strFormula);
            arrColAdv[Length(arrColAdv) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);
            If intPos <= 0 Then
              intPos := Length(strFormula)+1;
            arrColAdv[Length(arrColAdv) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColAdv, 20);
          strQtdEmb := fStrZero(Trim(qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

          If (qryADV_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
          Begin
            tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
            qryADV_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            If blnBasCol Then
            Begin
              strDesTin := AnsiUpperCase(
                         Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                         FormatFloat('0.00', qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

              pGravaCadCol(arrColAdv);
              
              If blnGerBase Then
                pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
            End
            Else
            Begin
              strDesTin := AnsiUpperCase(
                            tblFrm.FieldByName('KEY1').AsString + ' ' +
                            Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                            tblFrm.FieldByName('KEY2').AsString
                            );
              For intColora := Low(arrColAdv) To High(arrColAdv) Do
              Begin
                If fEmptyStr(arrColAdv[intColora].strCodCol) Then
                  Break;

                arrColAdv[intColora].fltQtdCol := fCalQtdEmb(arrColAdv[intColora].fltQtdCol, strEmbCom, strQtdEmb);
              End;

              If fGravaCadAdv(intCodSeq, strBaseSe, strProKey, strSubKey, arrColAdv, strDesTin) Then
                Inc(intCodSeq);
            End;
          End;
          qryADV_CADEMB.Next;
        End;
        tblFrm.Next;
        If Saida <> nil Then
          Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                            tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                            tblFrm.RecNo, tblFrm.RecordCount, qryADV_CADEMB.RecNo, qryADV_CADEMB.RecordCount]);
        Application.ProcessMessages;
      End;
      tblSubprods.Next;
    End;
    tblProducts.Next;
  End;
  fGravaAutoIncrem('ADVCOR_CADADV', intAutAdv);
  If Not blnBasCol Then
    pGravaNovasFormulas;

  Result := True;
end;

function TAdvanceCorobIndustrial.fGravaCadAdv(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColAdv: Array of TColAdv; strDesTin: String): Boolean;
var
  intCont : Integer;
  strMd5: string;
begin
  Result := False;
  If qryADV_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryADV_CADADV.FieldByName('ADV_DESCRI').AsString <> strDesTin) or
       (qryADV_CADADV.FieldByName('ADV_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryADV_CADADV.FieldByName('ADV_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString <> qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryADV_CADADV.IsEmpty Then
    Begin
      qryADV_CADADV.Insert;
      qryADV_CADADV.FieldByName('ADV_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryADV_CADADV.FieldByName('ADV_DESCRI').AsString := strDesTin;
      qryADV_CADADV.FieldByName('ADV_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryADV_CADADV.FieldByName('ADV_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString := qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryADV_CADADV.FieldByName('ADV_CODEMP').AsString := VS_strCodEmp;
      qryADV_CADADV.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutAdv, VS_strCodEmp);
      Inc(intAutAdv);
      qryADV_CADADV.FieldByName('ADV_BASE__').AsString := qryADV_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryADV_CADADV.FieldByName('ADV_PROKEY').AsString := qryADV_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryADV_CADADV.FieldByName('ADV_SUBKEY').AsString := qryADV_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      strMd5 := qryADV_CADADV.FieldByName('ADV_DESCRI').AsString +
        qryADV_CADADV.FieldByName('ADV_CODIGO').AsString +
        qryADV_CADADV.FieldByName('ADV_CODIG2').AsString +
        qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString;


      For intCont := Low(arrColAdv) To High(arrColAdv) Do
      Begin
        If fEmptyStr(arrColAdv[intCont].strCodCol) Then
          Break;

        qryADV_CADADV.FieldByName('ADV_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColAdv[intCont].strCodCol;

        if conf.fGetInteger('QTDORI') = 1 then
        begin
          if qryADV_CADCOL.Locate('COL_CODCOL', VarArrayOf([arrColAdv[intCont].strCodCol]), []) then
            arrColAdv[intCont].fltQtdCol := arrColAdv[intCont].fltQtdCol / qryADV_CADCOL.FieldByName('COL_PESESP').AsFloat;
        end;

        qryADV_CADADV.FieldByName('ADV_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColAdv[intCont].fltQtdCol;

        strMd5 := strMd5 + qryADV_CADADV.FieldByName('ADV_FORM' + fStrZero(intCont + 1, 2)).AsString;
        strMd5 := strMd5 + StringReplace(Format('%.4f', [qryADV_CADADV.FieldByName('ADV_QTDB' + fStrZero(intCont + 1, 2)).AsFloat]), ',', '.', [rfReplaceAll]);
      End;

      qryADV_CADADV.FieldByName('ADV_MD5KEY').AsString := GetMD5(strMd5);
      qryADV_CADADV.Post;
      Result := True;
    End;
end;

function TAdvanceCorobIndustrial.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

procedure TAdvanceCorobIndustrial.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryADV_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryADV_CADBAS.Insert;
    qryADV_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryADV_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryADV_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryADV_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryADV_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryADV_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryADV_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADVCOR_CADBAS', VS_strCodEmp);
    qryADV_CADBAS.Post;
  End;
end;

procedure TAdvanceCorobIndustrial.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;
  For intCont1 := 1 To qryADV_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryADV_CADNFM);
    qryADV_CADNFM.Next;
  End;
end;

procedure TAdvanceCorobIndustrial.pApagandoTemporarias;
begin
  fDropTable('TMP_GERFRM');
end;

procedure TAdvanceCorobIndustrial.pAtualizaTabelas;
begin
  qryADV_CADBAS.Close;
  qryADV_CADCOL.Close;
  qryADV_CADEMB.Close;
  qryADV_CADNFM.Close;
  qryADV_CADADV.Close;

  qryADV_CADBAS.Open;
  qryADV_CADCOL.Open;
  qryADV_CADEMB.Open;
  qryADV_CADNFM.Open;
  qryADV_CADADV.Open;
end;

function TAdvanceCorobIndustrial.fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT ADV_CODSEQ FROM ADVCOR_CADADV ORDER BY ADV_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ADV_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

constructor TAdvanceCorobIndustrial.Create;
begin
  intAutAdv := 1;

  strPatDbf := fGetConfTinta('ADV').fGet('PATADV'); //fArqIniTinta(0, 'ADVANCE', 'PATADV', '');

  If Not DirectoryExists(strPatDbf) Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  qryADV_CADBAS :=  fCriaQuery;
  qryADV_CADCOL :=  fCriaQuery;
  qryADV_CADEMB :=  fCriaQuery;
  qryADV_CADNFM :=  fCriaQuery;
  qryADV_CADADV :=  fCriaQuery;

  qryADV_CADBAS.SQL.Text := 'SELECT * FROM ADVCOR_CADBAS';
  qryADV_CADCOL.SQL.Text := 'SELECT * FROM ADVCOR_CADCOL';
  qryADV_CADEMB.SQL.Text := 'SELECT * FROM ADVCOR_CADEMB';
  qryADV_CADNFM.SQL.Text := 'SELECT * FROM ADVCOR_CADNFM';
  qryADV_CADADV.SQL.Text := 'SELECT * FROM ADVCOR_CADADV';

  qryADV_CADBAS.Open;
  qryADV_CADCOL.Open;
  qryADV_CADEMB.Open;
  qryADV_CADNFM.Open;
  qryADV_CADADV.Open;

  DataDBFPro := TUniConnection.Create(Nil);
  DataDBFPro.ProviderName := 'DBF';
  DataDBFPro.LoginPrompt  := False;

  DataDBFSub := TUniConnection.Create(Nil);
  DataDBFSub.ProviderName := 'DBF';
  DataDBFSub.LoginPrompt  := False;

  DataDBFMas := TUniConnection.Create(Nil);
  DataDBFMas.ProviderName := 'DBF';
  DataDBFMas.LoginPrompt  := False;

  frmModulo.DataDBF.Database := strPatDbf;

  If Not frmModulo.DataDBF.Connected Then
    frmModulo.DataDBF.Connected := True;

  tblProducts := fCriaQuery(nil, frmModulo.DataDBF);
//  tblSubprods := fCriaQuery(nil, frmModulo.DataDBF);
//  tblFrm      := fCriaQuery(nil, frmModulo.DataDBF);
//  tblMask     := fCriaQuery(nil, frmModulo.DataDBF);
  tblBases    := fCriaQuery(nil, frmModulo.DataDBF);
  tblCnts     := fCriaQuery(nil, frmModulo.DataDBF);

  conf := fGetConfTinta('ADV');
end;

destructor TAdvanceCorobIndustrial.Destroy;
begin
  FreeAndNil(qryADV_CADBAS);
  FreeAndNil(qryADV_CADCOL);
  FreeAndNil(qryADV_CADEMB);
  FreeAndNil(qryADV_CADNFM);
  FreeAndNil(qryADV_CADADV);
  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);

  If Assigned(DataDBFPro) Then FreeAndNil(DataDBFPro);
  If Assigned(DataDBFSub) Then FreeAndNil(DataDBFSub);
  If Assigned(DataDBFMas) Then FreeAndNil(DataDBFMas);

  pApagandoTemporarias;

  inherited Destroy;
end;

function TAdvanceCorobIndustrial.fVerificaCadEmb: Boolean;
  Var
    tblCans : TUniQuery;
    intCont : Integer;
    intErros :  Integer;
begin
  intErros := 0;
  tblCans := fCriaQuery(nil, frmModulo.DataDBF);
  tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
  tblCans.Open;
  tblCans.First;
  If Not qryADV_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0) And
         (Not fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryADV_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
  //        Result := False;
          Inc(intErros);
          Break;
        End
        Else If fEmptyStr(qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
        Begin
  //        Result := False;
          Inc(intErros);
          Break;
        End;
      End;

      tblCans.Next;
    End;
  End
  Else
    Inc(intErros);
    
  Result := intErros = 0;
  tblCans.Close;
  FreeAndNil(tblCans);
end;

procedure TAdvanceCorobIndustrial.pImportarCadEmb;
  Var
    tblCans : TUniQuery;
    intCont : Integer;
begin
  pAtualizaTabelas;
  tblCans := fCriaQuery(nil, frmModulo.DataDBF);
  tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
  tblCans.Open;
  tblCans.First;
  For intCont := 1 To tblCans.RecordCount Do
  Begin
    qryADV_CADEMB.Insert;
    qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
    qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat := tblCans.FieldByName('NOM_Q').AsFloat;
    qryADV_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
    qryADV_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADVCOR_CADEMB', VS_strCodEmp);
    qryADV_CADEMB.Post;
    tblCans.Next;
  End;
  tblCans.Close;
  FreeAndNil(tblCans);
end;

procedure TAdvanceCorobIndustrial.pPreencheTemporariaFRM;
var
  qryFrm: TUniQuery;
  intTemp: Integer;
begin
  qryFrm := fCriaQuery;

  fDropTable('TMP_GERFRM');

  qryFrm.SQL.Text := ' CREATE TABLE TMP_GERFRM     ' +
                     ' (                           ' +
                     '    BASE_ID CHAR(02),        ' +
                     '    CAN_ID  CHAR(02),        ' +
                     '    FORMULA VARCHAR(100),    ' +
                     '    KEY1    VARCHAR(100),    ' +
                     '    KEY2    VARCHAR(100),    ' +
                     '    COMMENT VARCHAR(255)     ' +
                     '  );                         ';
  qryFrm.ExecSQL;

  qryFrm.SQL.Text := ' INSERT INTO TMP_GERFRM      ' +
                     ' (                           ' +
                     '    BASE_ID ,                ' +
                     '    CAN_ID  ,                ' +
                     '    FORMULA ,                ' +
                     '    KEY1    ,                ' +
                     '    KEY2    ,                ' +
                     '    COMMENT                  ' +
                     '  )                          ' +
                     '  VALUES                     ' +
                     ' (                           ' +
                     '    :BASE_ID ,               ' +
                     '    :CAN_ID  ,               ' +
                     '    :FORMULA ,               ' +
                     '    :KEY1    ,               ' +
                     '    :KEY2    ,               ' +
                     '    :COMMENT                 ' +
                     '  );                         ';

  For intTemp := 1 To intMaxLinhaFrm Do
  Begin
    //Limpa os parametros
    qryFrm.ParamByName('BASE_ID').Value := Null;
    qryFrm.ParamByName('CAN_ID').Value  := Null;
    qryFrm.ParamByName('FORMULA').Value := Null;
    qryFrm.ParamByName('KEY1').Value    := Null;
    qryFrm.ParamByName('KEY2').Value    := Null;
    qryFrm.ParamByName('COMMENT').Value := Null;


    qryFrm.ParamByName('BASE_ID').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,8].Text;
    qryFrm.ParamByName('CAN_ID').AsString  := ExcelFrm.Cells.Item[intLinhaAtualFrm,9].Text;
    qryFrm.ParamByName('FORMULA').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,11].Text;
    qryFrm.ParamByName('KEY1').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,3].Text;
    qryFrm.ParamByName('KEY2').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,4].Text;
    qryFrm.ParamByName('COMMENT').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,27].Text;
    qryFrm.ExecSql;

    intLinhaAtualFrm := intLinhaAtualFrm + 1;
  End;
end;

function TAdvanceCorobIndustrial.fDiretorioValido: Boolean;
begin
  Result := True;
  If Not FileExists(strPatDbf + '\PRODUCTS.DBF') Then
    Result := False;
end;

function TAdvanceCorobIndustrial.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryADV_CADBAS.IsEmpty);
end;

function TAdvanceCorobIndustrial.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qryADV_CADCOL.IsEmpty;
end;

function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
var
  intCont1  : Integer;
  intCont2  : Integer;
  qryCadBas : TUniQuery;
  qryCadAdv : TUniQuery;
  strMd5: string;
begin
  qryCadAdv := fCriaQuery;
  qryCadAdv.SQL.Text := 'SELECT * FROM ADVCOR_CADADV LIMIT 0';
  qryCadAdv.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM ADVCOR_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';
  qryCadBas.ParamByName('BASE').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadAdvNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadAdv.Insert;
    qryCadAdv.FieldByName('ADV_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAdv.FieldByName('ADV_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAdv.FieldByName('ADV_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAdv.FieldByName('ADV_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;

    if not fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString) then
      qryCadAdv.FieldByName('ADV_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString
    else
      qryCadAdv.FieldByName('ADV_CODITE').Value := Null;

    qryCadAdv.FieldByName('ADV_CODEMP').AsString := VS_strCodEmp;
    qryCadAdv.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADVCOR_CADADV',VS_strCodEmp);
    qryCadAdv.FieldByName('ADV_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadAdv.FieldByName('ADV_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryCadAdv.FieldByName('ADV_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
    qryCadAdv.FieldByName('ADV_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;
    qryCadAdv.FieldByName('ADV_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    strMd5 := qryCadAdv.FieldByName('ADV_DESCRI').AsString +
        qryCadAdv.FieldByName('ADV_CODIGO').AsString +
        qryCadAdv.FieldByName('ADV_CODIG2').AsString +
        qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadAdv.FieldByName('ADV_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadAdv.FieldByName('ADV_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString);

      strMd5 := strMd5 + qryCadAdv.FieldByName('ADV_FORM' + fStrZero(intCont2 + 1, 2)).AsString;
      strMd5 := strMd5 + StringReplace(Format('%.4f', [qryCadAdv.FieldByName('ADV_QTDB' + fStrZero(intCont2 + 1, 2)).AsFloat]), ',', '.', [rfReplaceAll]);
    End;

    qryCadAdv.FieldByName('ADV_MD5KEY').AsString := GetMD5(strMd5);
    qryCadAdv.Post;
    qryCadBas.Next;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadAdv);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  ADVCOR_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadAdvNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE FROM ADVCOR_CADADV WHERE  ADV_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT ADV_CODSEQ FROM ADVCOR_CADADV ORDER BY ADV_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ADV_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
End;

end.

