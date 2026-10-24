unit untSherwinWhilliamsImobiliaria;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, untModulo,
  untTintadeMaquina;

Type
  TColShe = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type

  TSherwinWhilliamsNfm = class(TTintadeMaquina)
  public
    constructor Create(AOwner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;

  TSherwinWhilliams = class
    private
      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;

      strPatDbf : String;

      qrySHE_CADBAS : TUniQuery;
      qrySHE_CADCOL : TUniQuery;
      qrySHE_CADEMB : TUniQuery;
      qrySHE_CADNFM : TUniQuery;
      qrySHE_CADSHE : TUniQuery;

      intAutShe     : Integer;

    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColShe : Array of TColShe);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadShe(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColShe: Array of TColShe; strDesTin: String): Boolean;
      procedure pGravaNovasFormulas;
      procedure pAtualizaTabelas;
      function fVerificaCadEmb: Boolean;
      procedure pImportarCadEmb;
      function fDiretorioValido: Boolean;
      function fVerificaCadBas: Boolean;
      function fVerificaCadCol: Boolean;
      function fVerificaCadBasConfig: Boolean;
      function fRetBasesMask: String;

    public
      function fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
      Constructor Create;
      Destructor Destroy; Reintroduce;

  End;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadSheNfm(CodPro : String);

implementation

uses untFuncoes, untFuncoesSimples, DB,  untFuncTinta;


{ TSherwinWhilliams }

function TSherwinWhilliams.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qrySHE_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qrySHE_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TSherwinWhilliams.pGravaCadCol(arrColShe: array of TColShe);
  Var
    intCont : Integer;
begin
  For intCont := Low(arrColShe) To High(arrColShe) Do
  Begin
    If Not qrySHE_CADCOL.Locate('COL_CODCOL', arrColShe[intCont].strCodCol, []) and
       Not fEmptyStr(arrColShe[intCont].strCodCol) Then
    Begin
      If fEmptyStr(arrColShe[intCont].strCodCol) Then
        Break;

      qrySHE_CADCOL.Insert;
      qrySHE_CADCOL.FieldByName('COL_CODCOL').AsString := arrColShe[intCont].strCodCol;
      qrySHE_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qrySHE_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADCOL', VS_strCodEmp);
      qrySHE_CADCOL.Post;
    End
  End;
end;

procedure TSherwinWhilliams.pCarregarBases;
begin
  tblBases.Close;
  tblBases.SQL.Add('SELECT * FROM ' + strPatDbf + 'bases.dbf');
  tblBases.Open;
  tblBases.First;
end;

procedure TSherwinWhilliams.pCarregarFrm(strPatPro: String; strPatSub: String);
begin
  tblFrm.Close;

  If FileExists(strPatSub + 'frm.dbf') Then
    tblFrm.SQL.Add('SELECT * FROM ' + strPatSub + 'frm.dbf')
  Else If FileExists(strPatPro + 'frm.dbf') Then
    tblFrm.SQL.Add('SELECT * FROM ' + strPatPro + 'frm.dbf')
  Else
    tblFrm.SQL.Add('SELECT * FROM ' + strPatDbf + 'frm.dbf');

  tblFrm.Open;
  tblFrm.First;
end;

procedure TSherwinWhilliams.pCarregarMask(strPatSub: String);
begin
  tblMask.Close;
  tblMask.SQL.Add('SELECT * FROM ' + strPatSub + 'mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TSherwinWhilliams.pCarregarProducts;
begin
  tblProducts.Close;
  tblProducts.SQL.Add('SELECT * FROM ' + strPatDbf + 'products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TSherwinWhilliams.pCarregarSubprods(strPatPro: String);
begin
  tblSubprods.Close;
  tblSubprods.SQL.Add('SELECT * FROM ' + strPatPro + 'subprods.dbf');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TSherwinWhilliams.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColShe   : Array Of TColShe;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
    strTYPE     : String;
begin
  Result := False;

  strTYPE := '';

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
    pZapTable('SHE_CADSHE');

  If Not fVerificaCadEmb Then
  Begin
    If qrySHE_CADEMB.IsEmpty Then
    Begin
      If fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
        pImportarCadEmb;
    End
    Else
      fMensagem('', 'O Cadastro de Embalagem está inconsistente!', ['&OK']);

    Exit;
  End;

  If (Not blnBasCol) and  (Not fVerificaCadBas) Then
  Begin
    fMensagem('', 'O cadastro de bases está inconsistente!', ['&OK']);

    Exit;
  End;

  If (Not blnBasCol) and (Not fVerificaCadCol) Then
  Begin
    fMensagem('', 'O cadastro de colorantes está vazio!', ['&OK']);
    Exit;
  End;

  For intProducts := 1 To tblProducts.RecordCount Do
  Begin
    strPatPro := strPatDbf + tblProducts.FieldByName('PATH').AsString + '\';
    strProKey := fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);
    pCarregarSubprods(strPatPro);

    For intSubProds := 1 To tblSubprods.RecordCount Do
    Begin
      strPatSub := strPatPro + tblSubprods.FieldByName('PATH').AsString + '\';
      strSubKey := fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
      pCarregarFrm(strPatPro, strPatSub);
      pCarregarMask(strPatSub);

      For intFrm := 1 To tblFrm.RecordCount Do
      Begin
        strBaseSe := fStrZero(Trim(tblFrm.FieldbyName('BASE_ID').AsString), 2);
        strEmbCom := fStrZero(Trim(tblFrm.FieldByName('CAN_ID').AsString), 2);

        strTYPE := fRetBasesMask;

        tblMask.First;

        For intMask := 1 To tblMask.RecordCount Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColShe, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColShe, Length(arrColShe) + 1);
            intPos := Pos(',', strFormula);
            arrColShe[Length(arrColShe) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);
            If intPos <= 0 Then
              intPos := Length(strFormula)+1;
            arrColShe[Length(arrColShe) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

            {*******************************************}
            {* FORMULA GEL TEM QUE MULTIPLICAR POR 0.2 *}
            {****************************************PH*}
            If (tblProducts.FieldByName('PATH').AsString = 'PROD0005')
              And (tblSubprods.FieldByName('PATH').AsString = 'SUBP0001') Then
            Begin
              arrColShe[Length(arrColShe) - 1].fltQtdCol := arrColShe[Length(arrColShe) - 1].fltQtdCol * 0.2;
            End;

            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColShe, 20);
          strQtdEmb := fStrZero(Trim(tblMask.FieldByName('PNT_ID').AsString), 2);

          If (tblMask.FieldByName('TYPE').AsString = 'CA') Then
          Begin
            tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
            qrySHE_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            If blnBasCol Then
            Begin
              strDesTin := AnsiUpperCase(
                         Trim(tblProducts.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                         FormatFloat('0.00', qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');
              pGravaCadCol(arrColShe);
              If blnGerBase Then
                pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
            End
            Else
            Begin
              If (Pos(Trim(tblFrm.FieldbyName('BASE_ID').AsString), strTYPE) > 0) Then
              Begin
                strDesTin := AnsiUpperCase(
                              tblFrm.FieldByName('KEY1').AsString + ' ' +
                              Trim(tblProducts.FieldByName('DESCR').AsString) + ' ' +
                              Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                              tblFrm.FieldByName('KEY2').AsString
                              );
                For intColora := Low(arrColShe) To High(arrColShe) Do
                Begin
                  If fEmptyStr(arrColShe[intColora].strCodCol) Then
                    Break;

                  arrColShe[intColora].fltQtdCol := fCalQtdEmb(arrColShe[intColora].fltQtdCol, strEmbCom, strQtdEmb);
                End;

                If fGravaCadShe(intCodSeq, strBaseSe, strProKey, strSubKey, arrColShe, strDesTin) Then
                  Inc(intCodSeq);
              End;
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
  fGravaAutoIncrem('SHE_CADSHE', intAutShe);
  
  If Not blnBasCol Then
    pGravaNovasFormulas;
  Result := True;
end;

function TSherwinWhilliams.fRetBasesMask: String;
begin
  Result := '';

  tblMask.First;
  while not tblMask.Eof do
  Begin
    If (tblMask.FieldByName('TYPE').AsString = 'BA') Then
      If Pos(Trim(tblMask.FieldByName('PNT_ID').AsString), Result) <= 0 Then
        Result := Result + Trim(tblMask.FieldByName('PNT_ID').AsString) + '_';

    tblMask.Next;
  End;
end;

function TSherwinWhilliams.fGravaCadShe(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColShe: Array of TColShe; strDesTin: String): Boolean;
  Var
    intCont : Integer;
begin
  Result := False;
  If qrySHE_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) and
                Not fEmptyStr(qrySHE_CADBAS.FieldByName('BAS_CODITE').AsString) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qrySHE_CADSHE.FieldByName('SHE_DESCRI').AsString <> strDesTin) or
       (qrySHE_CADSHE.FieldByName('SHE_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qrySHE_CADSHE.FieldByName('SHE_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qrySHE_CADSHE.FieldByName('SHE_UNIDAD').AsString <> qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qrySHE_CADSHE.IsEmpty Then
    Begin
      qrySHE_CADSHE.Insert;
      qrySHE_CADSHE.FieldByName('SHE_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qrySHE_CADSHE.FieldByName('SHE_DESCRI').AsString := strDesTin;
      qrySHE_CADSHE.FieldByName('SHE_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qrySHE_CADSHE.FieldByName('SHE_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qrySHE_CADSHE.FieldByName('SHE_UNIDAD').AsString := qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qrySHE_CADSHE.FieldByName('SHE_CODEMP').AsString := VS_strCodEmp;
      qrySHE_CADSHE.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutShe, VS_strCodEmp);
      Inc(intAutShe);
      qrySHE_CADSHE.FieldByName('SHE_BASE__').AsString := qrySHE_CADBAS.FieldByName('BAS_BASE__').AsString;
      qrySHE_CADSHE.FieldByName('SHE_PROKEY').AsString := qrySHE_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qrySHE_CADSHE.FieldByName('SHE_SUBKEY').AsString := qrySHE_CADBAS.FieldByName('BAS_SUBKEY').AsString;
      qrySHE_CADSHE.FieldByName('SHE_COMMEN').AsString := AnsiUpperCase(tblFrm.FieldByName('COMMENT').AsString);

      For intCont := Low(arrColShe) To High(arrColShe) Do
      Begin
        If fEmptyStr(arrColShe[intCont].strCodCol) Then
          Break;

        qrySHE_CADSHE.FieldByName('SHE_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColShe[intCont].strCodCol;
        qrySHE_CADSHE.FieldByName('SHE_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColShe[intCont].fltQtdCol;
      End;
      qrySHE_CADSHE.Post;
      Result := True;
    End;
end;

procedure TSherwinWhilliams.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qrySHE_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qrySHE_CADBAS.Insert;
    qrySHE_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qrySHE_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qrySHE_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qrySHE_CADBAS.FieldByName('BAS_UNIDAD').AsString := qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qrySHE_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qrySHE_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qrySHE_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADBAS', VS_strCodEmp);
    qrySHE_CADBAS.Post;
  End;
end;

procedure TSherwinWhilliams.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;

  For intCont1 := 1 To qrySHE_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qrySHE_CADNFM);
    qrySHE_CADNFM.Next;
  End;

end;

procedure TSherwinWhilliams.pAtualizaTabelas;
begin
  qrySHE_CADBAS.Close;
  qrySHE_CADCOL.Close;
  qrySHE_CADEMB.Close;
  qrySHE_CADNFM.Close;
  qrySHE_CADSHE.Close;

  qrySHE_CADBAS.Open;
  qrySHE_CADCOL.Open;
  qrySHE_CADEMB.Open;
  qrySHE_CADNFM.Open;
  qrySHE_CADSHE.Open;
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT SHE_CODSEQ FROM SHE_CADSHE ORDER BY SHE_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('SHE_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

constructor TSherwinWhilliams.Create;
begin
  intAutShe := 1;

  strPatDbf     :=  fGetConfTinta('SHE').fGet('TXTSHE');

  If Not DirectoryExists(strPatDbf) Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  qrySHE_CADBAS :=  fCriaQuery;
  qrySHE_CADCOL :=  fCriaQuery;
  qrySHE_CADEMB :=  fCriaQuery;
  qrySHE_CADNFM :=  fCriaQuery;
  qrySHE_CADSHE :=  fCriaQuery;

  qrySHE_CADBAS.SQL.Text := 'SELECT * FROM SHE_CADBAS';
  qrySHE_CADCOL.SQL.Text := 'SELECT * FROM SHE_CADCOL';
  qrySHE_CADEMB.SQL.Text := 'SELECT * FROM SHE_CADEMB';
  qrySHE_CADNFM.SQL.Text := 'SELECT * FROM SHE_CADNFM';
  qrySHE_CADSHE.SQL.Text := 'SELECT * FROM SHE_CADSHE';

  qrySHE_CADBAS.Open;
  qrySHE_CADCOL.Open;
  qrySHE_CADEMB.Open;
  qrySHE_CADNFM.Open;
  qrySHE_CADSHE.Open;


  tblProducts :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblSubprods :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblFrm      :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblMask     :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblBases    :=  fCriaQuery(nil, frmModulo.DataDBF);
end;

destructor TSherwinWhilliams.Destroy;
begin
  FreeAndNil(qrySHE_CADBAS);
  FreeAndNil(qrySHE_CADCOL);
  FreeAndNil(qrySHE_CADEMB);
  FreeAndNil(qrySHE_CADNFM);
  FreeAndNil(qrySHE_CADSHE);
  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  inherited Destroy;
end;

function TSherwinWhilliams.fVerificaCadEmb: Boolean;
  Var
    tblCans : TUniTable;
    intCont : Integer;
    intErros: Integer;
begin
  intErros := 0;
  tblCans := TUniTable.Create(nil);
  tblCans.TableName := strPatDbf + 'CANS.DBF';
  tblCans.Open;
  tblCans.First;
  If Not qrySHE_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If Not qrySHE_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
      Begin
//        Result := False;
        Inc(intErros);
        Break;
      End
      Else If fEmptyStr(qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
      Begin
//        Result := False;
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
  FreeAndNil(tblCans);
end;

procedure TSherwinWhilliams.pImportarCadEmb;
  Var
    tblCans : TUniTable;
    intCont : Integer;
begin
  pAtualizaTabelas;
  tblCans := TUniTable.Create(nil);
  tblCans.TableName := strPatDbf + 'CANS.DBF';
  tblCans.Open;
  tblCans.First;
  For intCont := 1 To tblCans.RecordCount Do
  Begin
    qrySHE_CADEMB.Insert;
    qrySHE_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
    qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat := tblCans.FieldByName('NOM_Q').AsFloat;
    qrySHE_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
    qrySHE_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADEMB', VS_strCodEmp);
    qrySHE_CADEMB.Post;
    tblCans.Next;
  End;
  tblCans.Close;
  FreeAndNil(tblCans);
end;

function TSherwinWhilliams.fDiretorioValido: Boolean;
begin
  Result := True;
  If Not FileExists(strPatDbf + 'PRODUCTS.DBF') Then
    Result := False;
end;

function TSherwinWhilliams.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qrySHE_CADBAS.IsEmpty) and (fVerificaCadBasConfig);
end;

function TSherwinWhilliams.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qrySHE_CADCOL.IsEmpty;
end;

function TSherwinWhilliams.fVerificaCadBasConfig: Boolean;
  Var
    qryGen  : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM SHE_CADBAS WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  Var
    intCont1  : Integer;
    intCont2  : Integer;
    qryCadBas : TUniQuery;
    qryCadShe : TUniQuery;

begin
  qryCadShe := fCriaQuery;
  qryCadShe.SQL.Text := 'SELECT * FROM SHE_CADSHE';
  qryCadShe.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM SHE_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';
  qryCadBas.ParamByName('BASE').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadSheNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadShe.Insert;
    qryCadShe.FieldByName('SHE_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadShe.FieldByName('SHE_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadShe.FieldByName('SHE_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadShe.FieldByName('SHE_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
    qryCadShe.FieldByName('SHE_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadShe.FieldByName('SHE_CODEMP').AsString := VS_strCodEmp;
    qryCadShe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADSHE',VS_strCodEmp);
    qryCadShe.FieldByName('SHE_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadShe.FieldByName('SHE_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryCadShe.FieldByName('SHE_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
    qryCadShe.FieldByName('SHE_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;
    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadShe.FieldByName('SHE_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadShe.FieldByName('SHE_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString)
    End;
    qryCadShe.Post;
    qryCadBas.Next;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadShe);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  SHE_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadSheNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE FROM SHE_CADSHE WHERE  SHE_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;


{ TSherwinWhilliamsNfm }

constructor TSherwinWhilliamsNfm.Create(AOwner: TComponent);
begin
  NomeTinta := 'Sherwin Williams';
  inherited;
end;

function TSherwinWhilliamsNfm.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadShe: TUniQuery;
    qryCadBas: TUniQuery;
    intProSeq: Integer;
    intCont: Integer;
begin
  {**************************************************}
  {* REMOVENDO NOVAS FORMULAS DO CADASTRO DE TINTAS *}
  {***********************************************PH*}
  pRegistraAcao('Removendo novas formulas do cadastro de tintas...');
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM SHE_CADSHE WHERE SHE_CODIGO IN (SELECT NFM_CODPRO FROM SHE_CADNFM);';
  qryGen.ExecSQL;
  pRegistraAcao('Novas formulas removidas com sucesso!');

  {*******************************************}
  {* CADASTRO DE NOVAS FORMULAS              *}
  {****************************************PH*}
  qryGen.SQL.Text := 'SELECT * FROM SHE_CADNFM;';
  qryGen.Open;

  {*******************************************}
  {* CADASTRO DE TINTAS                      *}
  {****************************************PH*}
  qryCadShe := fCriaQuery(Self);
  qryCadShe.SQL.Text := 'SELECT * FROM SHE_CADSHE WHERE FALSE';
  qryCadShe.Open;

  qryCadBas := fCriaQuery(Self);

  intProSeq := fRetProxCodSeq;

  TTintadeMaquina.fAjustaInicialAutoIncremento('SHE_CADSHE', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin

    qryCadBas.Close;
    qryCadBas.SQL.Text := 'SELECT * FROM SHE_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';
    qryCadBas.ParamByName('BASE').AsString := qryGen.FieldByName('NFM_BASE__').AsString;
    qryCadBas.ParamByName('PROKEY').AsString := qryGen.FieldByName('NFM_PROKEY').AsString;
    qryCadBas.ParamByName('SUBKEY').AsString := qryGen.FieldByName('NFM_SUBKEY').AsString;
    qryCadBas.Open;
    qryCadBas.First;


    While Not qryCadBas.Eof Do
    Begin
      qryCadShe.Insert;
      qryCadShe.FieldByName('SHE_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString + ' ' + qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadShe.FieldByName('SHE_CODIGO').AsString := qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadShe.FieldByName('SHE_CODIG2').AsString := qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadShe.FieldByName('SHE_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
      qryCadShe.FieldByName('SHE_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
      qryCadShe.FieldByName('SHE_CODEMP').AsString := VS_strCodEmp;
      qryCadShe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SHE_CADSHE',VS_strCodEmp);
      qryCadShe.FieldByName('SHE_CODSEQ').AsString := fStrZero(intProSeq, 6);
      qryCadShe.FieldByName('SHE_BASE__').AsString := qryGen.FieldByName('NFM_BASE__').AsString;
      qryCadShe.FieldByName('SHE_PROKEY').AsString := qryGen.FieldByName('NFM_PROKEY').AsString;
      qryCadShe.FieldByName('SHE_SUBKEY').AsString := qryGen.FieldByName('NFM_SUBKEY').AsString;

      For intCont := 1 To 10 Do
      Begin
        If fEmptyStr(qryGen.FieldByName('NFM_COL0' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadShe.FieldByName('SHE_FORM' + fStrZero(intCont, 2)).AsString := qryGen.FieldByName('NFM_COL0' + fStrZero(intCont, 2)).AsString;
        qryCadShe.FieldByName('SHE_QTDB' + fStrZero(intCont, 2)).AsFloat :=
                                    fConverteQtdEmb(qryGen.FieldByName('NFM_QTD0' + fStrZero(intCont, 2)).AsFloat,
                                    qryGen.FieldByName('NFM_UNIDAD').AsString,
                                    qryCadBas.FieldByName('BAS_UNIDAD').AsString)
      End;
      qryCadShe.Post;
      qryCadBas.Next;
      intProSeq := intProSeq + 1;
    End;

    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadBas);
  Result := True;
end;

end.
