unit untLukscolorImobiliaria;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, untModulo, ComObj ;

Type
  TColLkd = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type
  TLukscolor = class
    private
      DataProducts    : TUniConnection;
      DataSubProducts : TUniConnection;
      DataFrm         : TUniConnection;
      DataMask        : TUniConnection;
      DataBase        : TUniConnection;

      ExcelFrm         : Variant;

      intMaxLinhaFrm   : Integer;
      intLinhaAtualFrm : Integer;

      tblProducts : TUniQuery;
      tblSubprods : TUniQuery;
      tblFrm      : TUniQuery;
      tblMask     : TUniQuery;
      tblBases    : TUniQuery;
      tblCnts     : TUniQuery;

      strPatDbf   : String;

      qryLKD_CADBAS : TUniQuery;
      qryLKD_CADCOL : TUniQuery;
      qryLKD_CADEMB : TUniQuery;
      qryLKD_CADNFM : TUniQuery;
      qryLKD_CADLKD : TUniQuery;

      intAutLkd     : Integer;
    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColLkd : Array of TColLkd);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadLkd(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColLkd: Array of TColLkd; strDesTin: String): Boolean;
      procedure pGravaNovasFormulas;
      procedure pAtualizaTabelas;
      function fRetProxCodSeq: Integer;
      function fVerificaCadEmb: Boolean;
      procedure pImportarCadEmb;
      function fDiretorioValido: Boolean;
      function fVerificaCadBas: Boolean;
      function fVerificaCadCol: Boolean;
      function fVerificaCadBasConfig: Boolean;
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
  procedure pRemoveCadLkdNfm(CodPro : String);

implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta;


{ TLukscolor }

function TLukscolor.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryLKD_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TLukscolor.pGravaCadCol(arrColLkd: array of TColLkd);
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
  For intCont := Low(arrColLkd) To High(arrColLkd) Do
  Begin
    qryLKD_CADCOL.First;
    If Not qryLKD_CADCOL.Locate('COL_CODCOL', arrColLkd[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColLkd[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColLkd[intCont].strCodCol) Then
          Break;

        qryLKD_CADCOL.Insert;
        qryLKD_CADCOL.FieldByName('COL_CODCOL').AsString := arrColLkd[intCont].strCodCol;
        qryLKD_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryLKD_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADCOL', VS_strCodEmp);
        qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColLkd[intCont].strCodCol);
        qryLKD_CADCOL.Post;
      End;
    End
    Else If fEmptyStr(qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryLKD_CADCOL.Edit;
      qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColLkd[intCont].strCodCol);
      qryLKD_CADCOL.Post;
    End;
  End;
end;

procedure TLukscolor.pCarregarBases;
begin

  DataBase:= TUniConnection.Create(Nil);
  DataBase.ProviderName := 'DBF';
  DataBase.LoginPrompt  := False;

  DataBase.Database     := strPatDbf;

  If (Not DataBase.Connected) Then
    DataBase.Connected := True;

  tblBases := TUniQuery.Create(Nil);
  tblBases.Connection := DataBase;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('SELECT * FROM \BASES.DBF');
  tblBases.Open;
  tblBases.First;


  tblCnts := TUniQuery.Create(Nil);
  tblCnts.Connection := DataBase;

  tblCnts.Close;
  tblCnts.SQL.Add('SELECT * FROM \CNTS.DBF');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TLukscolor.pCarregarFrm(strPatPro: String; strPatSub: String);
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

procedure TLukscolor.pCarregarMask(strPatSub: String);
begin
  DataMask:= TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt  := False;

  DataMask.Database     := strPatSub;

  If (Not DataMask.Connected) Then
    DataMask.Connected := True;

  tblMask := TUniQuery.Create(Nil);
  tblMask.Connection := DataMask;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('SELECT * FROM \MASK.DBF');
  tblMask.Open;
  tblMask.First;
end;

procedure TLukscolor.pCarregarProducts;
begin
  DataProducts := TUniConnection.Create(Nil);
  DataProducts.ProviderName := 'DBF';
  DataProducts.LoginPrompt  := False;

  DataProducts.Database     := strPatDbf;

  If (Not DataProducts.Connected) Then
    DataProducts.Connected := True;

  tblProducts := TUniQuery.Create(Nil);
  tblProducts.Connection := DataProducts;

  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('SELECT * FROM \PRODUCTS.DBF');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TLukscolor.pCarregarSubprods(strPatPro: String);
begin
  DataSubProducts := TUniConnection.Create(Nil);
  DataSubProducts.ProviderName:= 'DBF';
  DataSubProducts.LoginPrompt := False;
  DataSubProducts.Database    := strPatPro;

  If (Not DataSubProducts.Connected) Then
    DataSubProducts.Connected := True;

  tblSubprods := TUniQuery.Create(Nil);
  tblSubprods.Connection := DataSubProducts;

  tblSubprods.Close;
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('SELECT * FROM \SUBPRODS.DBF');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TLukscolor.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColLkd   : Array Of TColLkd;
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
    pZapTable('LKD_CADLKD');

  If Not fVerificaCadEmb Then
  Begin
    If qryLKD_CADEMB.IsEmpty Then
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

  tblProducts.First;

  // For intProducts := 1 To tblProducts.RecordCount Do

  While Not tblProducts.Eof Do
  Begin
    strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString;
    strProKey := fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);

    pCarregarSubprods(strPatPro);

    For intSubProds := 1 To tblSubprods.RecordCount Do
    Begin
      strPatSub := strPatPro +'\'+ tblSubprods.FieldByName('PATH').AsString;
      strSubKey := fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);

      pCarregarFrm(strPatPro, strPatSub);
      pCarregarMask(strPatSub);

//      For intFrm := 1 To tblFrm.RecordCount Do
      tblFrm.First;

      While Not tblFrm.Eof Do
      Begin
        If fEmptyStr(tblFrm.FieldbyName('BASE_ID').AsString) Then
        Begin
          tblFrm.Next;
          Continue;
        End;

        strBaseSe := fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);
        strEmbCom := fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

        tblMask.First;

        // For intMask := 1 To tblMask.RecordCount Do

        While Not tblMask.Eof Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColLkd, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColLkd, Length(arrColLkd) + 1);
            intPos := Pos(',', strFormula);
            arrColLkd[Length(arrColLkd) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);
            If intPos <= 0 Then
              intPos := Length(strFormula)+1;
            arrColLkd[Length(arrColLkd) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColLkd, 20);
          strQtdEmb := fStrZero(Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

          If (tblMask.FieldByName('TYPE').AsString = 'CA') Then
          Begin

            tblBases.Close;
            tblBases.SQl.Text := 'SELECT * FROM \BASES.DBF WHERE TRIM(ID) = :ID';
            tblBases.ParamByName('ID').AsString  := Trim(tblFrm.FieldByName('BASE_ID').AsString);
            tblBases.Open;

            qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            If blnBasCol Then
            Begin
              strDesTin := AnsiUpperCase(
                         Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                         FormatFloat('0.00', qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');
                            pGravaCadCol(arrColLkd);
              If (blnGerBase) Then
                pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
            End
            Else
            Begin
              strDesTin := AnsiUpperCase(
                            tblFrm.FieldByName('KEY1').AsString + ' ' +
                            Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                            tblFrm.FieldByName('KEY2').AsString
                            );
              For intColora := Low(arrColLkd) To High(arrColLkd) Do
              Begin
                If fEmptyStr(arrColLkd[intColora].strCodCol) Then
                  Break;

                arrColLkd[intColora].fltQtdCol := fCalQtdEmb(arrColLkd[intColora].fltQtdCol, strEmbCom, strQtdEmb);
              End;

              If fGravaCadLkd(intCodSeq, strBaseSe, strProKey, strSubKey, arrColLkd, strDesTin) Then
                Inc(intCodSeq);
            End;
          End;
          tblMask.Next;
        End;
        tblFrm.Next;
        If Saida <> nil Then
          Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                            tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                            tblFrm.RecNo, tblFrm.RecordCount, tblMask.RecNo, tblMask.RecordCount]);
        Application.ProcessMessages;
      End;
      tblSubprods.Next;
    End;
    tblProducts.Next;
  End;

  fGravaAutoIncrem('LKD_CADLKD', intAutLkd);

  If Not blnBasCol Then
    pGravaNovasFormulas;

  Result := True;
end;

function TLukscolor.fGravaCadLkd(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColLkd: Array of TColLkd; strDesTin: String): Boolean;
  Var
    intCont : Integer;
begin
  Result := False;
  If qryLKD_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) and
                Not fEmptyStr(qryLKD_CADBAS.FieldByName('BAS_CODITE').AsString) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString <> strDesTin) or
       (qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString <> qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryLKD_CADLKD.IsEmpty Then
    Begin
      qryLKD_CADLKD.Insert;
      qryLKD_CADLKD.FieldByName('LKD_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString := strDesTin;
      qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString := qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryLKD_CADLKD.FieldByName('LKD_CODEMP').AsString := VS_strCodEmp;
      qryLKD_CADLKD.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutLkd, VS_strCodEmp);
      Inc(intAutLkd);
      qryLKD_CADLKD.FieldByName('LKD_BASE__').AsString := qryLKD_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryLKD_CADLKD.FieldByName('LKD_PROKEY').AsString := qryLKD_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryLKD_CADLKD.FieldByName('LKD_SUBKEY').AsString := qryLKD_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      For intCont := Low(arrColLkd) To High(arrColLkd) Do
      Begin
        If fEmptyStr(arrColLkd[intCont].strCodCol) Then
          Break;

        qryLKD_CADLKD.FieldByName('LKD_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColLkd[intCont].strCodCol;
        qryLKD_CADLKD.FieldByName('LKD_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColLkd[intCont].fltQtdCol;
      End;
      qryLKD_CADLKD.Post;
      Result := True;
    End;
end;

function TLukscolor.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

procedure TLukscolor.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryLKD_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryLKD_CADBAS.Insert;
    qryLKD_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryLKD_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryLKD_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryLKD_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryLKD_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryLKD_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryLKD_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADBAS', VS_strCodEmp);
    qryLKD_CADBAS.Post;
  End;
end;

procedure TLukscolor.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;
  For intCont1 := 1 To qryLKD_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryLKD_CADNFM);
    qryLKD_CADNFM.Next;
  End;
end;

procedure TLukscolor.pApagandoTemporarias;
begin
  fDropTable('TMP_GERFRM');
  fDropTable('TMP_MD5KEY');
end;

procedure TLukscolor.pAtualizaTabelas;
begin
  qryLKD_CADBAS.Close;
  qryLKD_CADCOL.Close;
  qryLKD_CADEMB.Close;
  qryLKD_CADNFM.Close;
  qryLKD_CADLKD.Close;

  qryLKD_CADBAS.Open;
  qryLKD_CADCOL.Open;
  qryLKD_CADEMB.Open;
  qryLKD_CADNFM.Open;
  qryLKD_CADLKD.Open;
end;

function TLukscolor.fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT LKD_CODSEQ FROM LKD_CADLKD ORDER BY LKD_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('LKD_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

constructor TLukscolor.Create;
begin
  intAutLkd := 1;

  strPatDbf     :=  fGetConfTinta('LKS').fGet('PATLKS');

  If Not DirectoryExists(strPatDbf) Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  qryLKD_CADBAS :=  fCriaQuery;
  qryLKD_CADCOL :=  fCriaQuery;
  qryLKD_CADEMB :=  fCriaQuery;
  qryLKD_CADNFM :=  fCriaQuery;
  qryLKD_CADLKD :=  fCriaQuery;

  qryLKD_CADBAS.SQL.Text := 'SELECT * FROM LKD_CADBAS';
  qryLKD_CADCOL.SQL.Text := 'SELECT * FROM LKD_CADCOL';
  qryLKD_CADEMB.SQL.Text := 'SELECT * FROM LKD_CADEMB';
  qryLKD_CADNFM.SQL.Text := 'SELECT * FROM LKD_CADNFM';
  qryLKD_CADLKD.SQL.Text := 'SELECT * FROM LKD_CADLKD';

  qryLKD_CADBAS.Open;
  qryLKD_CADCOL.Open;
  qryLKD_CADEMB.Open;
  qryLKD_CADNFM.Open;
  qryLKD_CADLKD.Open;
end;

destructor TLukscolor.Destroy;
begin
  // Destruir as querys
  If Assigned(qryLKD_CADBAS) Then pFreeAndNil(qryLKD_CADBAS);
  If Assigned(qryLKD_CADCOL) Then pFreeAndNil(qryLKD_CADCOL);
  If Assigned(qryLKD_CADEMB) Then pFreeAndNil(qryLKD_CADEMB);
  If Assigned(qryLKD_CADNFM) Then pFreeAndNil(qryLKD_CADNFM);
  If Assigned(qryLKD_CADLKD) Then pFreeAndNil(qryLKD_CADLKD);

  // Destruir as Tables
  If Assigned(tblProducts)   Then pFreeAndNil(tblProducts);
  If Assigned(tblSubprods)   Then pFreeAndNil(tblSubprods);
  If Assigned(tblFrm)        Then pFreeAndNil(tblFrm);
  If Assigned(tblMask)       Then pFreeAndNil(tblMask);
  If Assigned(tblBases)      Then pFreeAndNil(tblBases);
  If Assigned(tblCnts)       Then pFreeAndNil(tblCnts);

  // Destruir os Connections
  If Assigned(DataProducts)    Then pFreeAndNil(DataProducts);
  If Assigned(DataSubProducts) Then pFreeAndNil(DataSubProducts);
  If Assigned(DataFrm)         Then pFreeAndNil(DataFrm);
  If Assigned(DataMask)        Then pFreeAndNil(DataMask);
  If Assigned(DataBase)        Then pFreeAndNil(DataBase);

  pApagandoTemporarias;

  inherited Destroy;
end;

function TLukscolor.fVerificaCadEmb: Boolean;
  Var
    tblCans  : TUniQuery;
    DataCans : TUniConnection;

    intCont : Integer;
    intErros :  Integer;
begin
  intErros := 0;

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

  If Not qryLKD_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If Not qryLKD_CADEMB.Locate('EMB_CODEMB',fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
      Begin
        Inc(intErros);
        Break;
      End
      Else
      If fEmptyStr(qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
      Begin
        Inc(intErros);
        Break;
      End;
      tblCans.Next;
    End;
  End
  Else
    Inc(intErros);

  Result := intErros = 0;
  tblCans.Close;

  if Assigned(tblCans)  Then  pFreeAndNil(tblCans);
  if Assigned(DataCans) Then pFreeAndNil(DataCans);
end;

procedure TLukscolor.pImportarCadEmb;
  Var
    tblCans  : TUniQuery;
    DataCans : TUniConnection;
    intCont  : Integer;
begin
  pAtualizaTabelas;

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
    qryLKD_CADEMB.Insert;
    qryLKD_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
    qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
    qryLKD_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
    qryLKD_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADEMB', VS_strCodEmp);
    qryLKD_CADEMB.Post;
    tblCans.Next;
  End;
  tblCans.Close;

  if Assigned(tblCans) Then pFreeAndNil(tblCans);
  if Assigned(DataCans)Then pFreeAndNil(DataCans);
end;

procedure TLukscolor.pPreencheTemporariaFRM;
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

function TLukscolor.fDiretorioValido: Boolean;
begin
  Result := FileExists(strPatDbf + '\PRODUCTS.DBF');
end;

function TLukscolor.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryLKD_CADBAS.IsEmpty) and (fVerificaCadBasConfig);
end;

function TLukscolor.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qryLKD_CADCOL.IsEmpty;
end;

function TLukscolor.fVerificaCadBasConfig: Boolean;
  Var
    qryGen  : TUniQuery;
begin

  qryGen := fCriaQuery;

  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT '+
                     '  FROM LKD_CADBAS '+
                     ' WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;

  FreeAndNil(qryGen);
end;


function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  Var
    intCont1  : Integer;
    intCont2  : Integer;
    qryCadBas : TUniQuery;
    qryCadLkd : TUniQuery;

begin
  qryCadLkd          := fCriaQuery;
  qryCadLkd.SQL.Text := 'SELECT * FROM LKD_CADLKD';
  qryCadLkd.Open;

  qryCadBas          := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * '+
                        '  FROM LKD_CADBAS '+
                        ' WHERE BAS_BASE__ = :BASE '+
                        '   AND BAS_PROKEY = :PROKEY ';

  qryCadBas.ParamByName('BASE').AsString   := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.Open;

  pRemoveCadLkdNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadLkd.Insert;
    qryCadLkd.FieldByName('LKD_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
//    qryCadLkd.FieldByName('LKD_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadLkd.FieldByName('LKD_CODEMP').AsString := VS_strCodEmp;
    qryCadLkd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LKD_CADLKD',VS_strCodEmp);
    qryCadLkd.FieldByName('LKD_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadLkd.FieldByName('LKD_BASE__').AsString := qryCadBas.FieldByName('BAS_BASE__').AsString;
    qryCadLkd.FieldByName('LKD_PROKEY').AsString := qryCadBas.FieldByName('BAS_PROKEY').AsString;
    qryCadLkd.FieldByName('LKD_SUBKEY').AsString := qryCadBas.FieldByName('BAS_SUBKEY').AsString;
    qryCadLkd.FieldByName('LKD_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadLkd.FieldByName('LKD_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadLkd.FieldByName('LKD_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString)
    End;
    qryCadLkd.Post;
    qryCadBas.Next;
  End;

  pFreeAndNil(qryCadBas);
  pFreeAndNil(qryCadLkd);

  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  LKD_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadLkdNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin

  qryGen          := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE '+
                      '  FROM LKD_CADLKD '+
                      ' WHERE  LKD_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;

  qryGen.ExecSQL;

  FreeAndNil(qryGen);
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT LKD_CODSEQ '+
                     '  FROM LKD_CADLKD '+
                     ' ORDER BY LKD_CODSEQ '+
                     '  DESC LIMIT 1;';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('LKD_CODSEQ').AsInteger + 1;

  pFreeAndNil(qryGen);
End;

end.
