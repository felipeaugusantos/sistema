unit untAnjoSinteticaDinamica;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, untTintadeMaquina;

Type
  TColAja = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type
  TAnjoSinteticaDinamica = class
    private
      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;
      tblCnts    : TUniQuery;

      strPatDbf : String;
      strPatDbfOriginal : String;

      qryAJA_CADBAS : TUniQuery;
      qryAJA_CADCOL : TUniQuery;
      qryAJA_CADEMB : TUniQuery;
      qryAJA_CADNFM : TUniQuery;
      qryAJA_CADAJA : TUniQuery;

      intAutAja     : Integer;

    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColAja : Array of TColAja);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadAja(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColAja: Array of TColAja; strDesTin: String): Boolean;
      procedure pGravaNovasFormulas;
      procedure pAtualizaTabelas;
      function fRetProxCodSeq: Integer;
      function fVerificaCadEmb: Boolean;
      procedure pImportarCadEmb;
      function fDiretorioValido: Boolean;
      function fVerificaCadBas: Boolean;
      function fVerificaCadCol: Boolean;
      function fVerificaCadBasConfig: Boolean;
      function fExisteEmbalagem(strIDEmb: String; fltQTDEmb: Double): Boolean;


    public
      function fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
      Constructor Create;
      Destructor Destroy; Reintroduce;

  End;


  TAnjoSinteticaDinamicaNfm = class(TTintadeMaquina)
  public
    function fGravarNovasFormulas(): Boolean; override;
  end;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadAjaNfm(CodPro : String);


implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta, untModulo;


{ TAnjoSinteticaDinamica }

function TAnjoSinteticaDinamica.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryAJA_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryAJA_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TAnjoSinteticaDinamica.pGravaCadCol(arrColAja: array of TColAja);
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
  For intCont := Low(arrColAja) To High(arrColAja) Do
  Begin
    qryAJA_CADCOL.First;
    If Not qryAJA_CADCOL.Locate('COL_CODCOL', arrColAja[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColAja[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColAja[intCont].strCodCol) Then
          Break;

        qryAJA_CADCOL.Insert;
        qryAJA_CADCOL.FieldByName('COL_CODCOL').AsString := arrColAja[intCont].strCodCol;
        qryAJA_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryAJA_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJA_CADCOL', VS_strCodEmp);
        qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAja[intCont].strCodCol);
        qryAJA_CADCOL.Post;
      End;
    End
    Else If fEmptyStr(qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryAJA_CADCOL.Edit;
      qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAja[intCont].strCodCol);
      qryAJA_CADCOL.Post;
    End;
  End;
end;

procedure TAnjoSinteticaDinamica.pCarregarBases;
begin
  tblBases.Close;
  tblBases.SQL.Add('SELECT * FROM ' + strPatDbf + '\bases.dbf');
  tblBases.Open;
  tblBases.First;

  tblCnts.Close;
  tblCnts.SQL.Add('SELECT * FROM ' + strPatDbf + '\cnts.dbf');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAnjoSinteticaDinamica.pCarregarFrm(strPatPro: String; strPatSub: String);
begin
  tblFrm.Close;

  If FileExists(strPatSub + '\frm.dbf') Then
    tblFrm.SQL.Add('SELECT * FROM ' + strPatSub + '\frm.dbf')
  Else If FileExists(strPatPro + '\frm.dbf') Then
    tblFrm.SQL.Add('SELECT * FROM ' + strPatPro + '\frm.dbf')
  Else
    tblFrm.SQL.Add('SELECT * FROM ' + strPatDbf + '\frm.dbf');

  tblFrm.Open;
  tblFrm.First;
end;

procedure TAnjoSinteticaDinamica.pCarregarMask(strPatSub: String);
begin
  tblMask.Close;
  tblMask.SQL.Add('SELECT * FROM ' + strPatSub + '\mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TAnjoSinteticaDinamica.pCarregarProducts;
begin
  tblProducts.Close;
  tblProducts.SQL.Add('SELECT * FROM ' + strPatDbf + '\products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAnjoSinteticaDinamica.pCarregarSubprods(strPatPro: String);
begin
  tblSubprods.Close;
  tblSubprods.SQL.Add('SELECT * FROM ' + strPatPro + 'subprods.dbf');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TAnjoSinteticaDinamica.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColAja   : Array Of TColAja;
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
    pZapTable('AJA_CADAJA');

  If Not fVerificaCadEmb Then
  Begin
    If qryAJA_CADEMB.IsEmpty Then
    Begin
      If fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
        pImportarCadEmb;
    End
    Else
    Begin
      fMensagem('', 'O Cadastro de Embalagem está inconsistente!', ['&OK']);
      Exit;
    End;
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
    strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString + '\';
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

        qryAJA_CADEMB.First;
        For intMask := 1 To qryAJA_CADEMB.RecordCount Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColAja, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColAja, Length(arrColAja) + 1);
            intPos := Pos(',', strFormula);
            arrColAja[Length(arrColAja) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);
            If intPos <= 0 Then
              intPos := Length(strFormula)+1;
            arrColAja[Length(arrColAja) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColAja, 20);
          strQtdEmb := fStrZero(Trim(qryAJA_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

          If (qryAJA_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
          Begin
            tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
            qryAJA_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            If blnBasCol Then
            Begin
              strDesTin := AnsiUpperCase(
                         Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                         FormatFloat('0.00', qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

              pGravaCadCol(arrColAja);

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
              For intColora := Low(arrColAja) To High(arrColAja) Do
              Begin
                If fEmptyStr(arrColAja[intColora].strCodCol) Then
                  Break;

                arrColAja[intColora].fltQtdCol := fCalQtdEmb(arrColAja[intColora].fltQtdCol, strEmbCom, strQtdEmb);
              End;

              If fGravaCadAja(intCodSeq, strBaseSe, strProKey, strSubKey, arrColAja, strDesTin) Then
                Inc(intCodSeq);
            End;
          End;
          qryAJA_CADEMB.Next;
        End;
        tblFrm.Next;
        If Saida <> nil Then
          Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                            tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                            tblFrm.RecNo, tblFrm.RecordCount, qryAJA_CADEMB.RecNo, qryAJA_CADEMB.RecordCount]);
        Application.ProcessMessages;
      End;
      tblSubprods.Next;
    End;
    tblProducts.Next;
  End;
{    fGravaAutoIncrem('AJA_CADAJA', intAutAja);
  If Not blnBasCol Then
    pGravaNovasFormulas;}

  Result := True;
end;

function TAnjoSinteticaDinamica.fGravaCadAja(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColAja: Array of TColAja; strDesTin: String): Boolean;
var
  intCont : Integer;
  strMd5Key: string;
begin
  Result := False;
  If qryAJA_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) and
                Not fEmptyStr(qryAJA_CADBAS.FieldByName('BAS_CODITE').AsString) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString <> strDesTin) or
       (qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString <> qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryAJA_CADAJA.IsEmpty Then
    Begin
      qryAJA_CADAJA.Insert;
      qryAJA_CADAJA.FieldByName('AJA_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString := strDesTin;
      qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString := qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryAJA_CADAJA.FieldByName('AJA_CODEMP').AsString := VS_strCodEmp;
      qryAJA_CADAJA.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutAja, VS_strCodEmp);
      Inc(intAutAja);
      qryAJA_CADAJA.FieldByName('AJA_BASE__').AsString := qryAJA_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryAJA_CADAJA.FieldByName('AJA_PROKEY').AsString := qryAJA_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryAJA_CADAJA.FieldByName('AJA_SUBKEY').AsString := qryAJA_CADBAS.FieldByName('BAS_SUBKEY').AsString;
      
      strMd5Key := qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString +
        qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString +
        qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString +
        qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString +
        qryAJA_CADAJA.FieldByName('AJA_PROKEY').AsString +
        qryAJA_CADAJA.FieldByName('AJA_SUBKEY').AsString +
        qryAJA_CADAJA.FieldByName('AJA_BASE__').AsString; 

      For intCont := Low(arrColAja) To High(arrColAja) Do
      Begin
        strMd5Key := strMd5Key + arrColAja[intCont].strCodCol +
          StringReplace(FormatFloat('0.0000', arrColAja[intCont].fltQtdCol), ',', '.', []);

        If fEmptyStr(arrColAja[intCont].strCodCol) Then
          Continue;

        qryAJA_CADAJA.FieldByName('AJA_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColAja[intCont].strCodCol;
        qryAJA_CADAJA.FieldByName('AJA_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColAja[intCont].fltQtdCol;
      End;

      qryAJA_CADAJA.FieldByName('AJA_MD5KEY').AsString := GetMD5(strMd5Key);

      qryAJA_CADAJA.Post;
      Result := True;
    End;
end;

procedure TAnjoSinteticaDinamica.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryAJA_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryAJA_CADBAS.Insert;
    qryAJA_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryAJA_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryAJA_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryAJA_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryAJA_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryAJA_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryAJA_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJA_CADBAS', VS_strCodEmp);
    qryAJA_CADBAS.Post;
  End;
end;

procedure TAnjoSinteticaDinamica.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;
  For intCont1 := 1 To qryAJA_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryAJA_CADNFM);
    qryAJA_CADNFM.Next;
  End;
end;

procedure TAnjoSinteticaDinamica.pAtualizaTabelas;
begin
  qryAJA_CADBAS.Close;
  qryAJA_CADCOL.Close;
  qryAJA_CADEMB.Close;
  qryAJA_CADNFM.Close;
  qryAJA_CADAJA.Close;

  qryAJA_CADBAS.Open;
  qryAJA_CADCOL.Open;
  qryAJA_CADEMB.Open;
  qryAJA_CADNFM.Open;
  qryAJA_CADAJA.Open;
end;

function TAnjoSinteticaDinamica.fExisteEmbalagem(strIDEmb: String; fltQTDEmb: Double): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Nil);
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT EMB_CODEMB FROM AJA_CADEMB WHERE EMB_CODEMB = :CODEMB');
    qryConsulta.SQL.Add(' AND EMB_QTDEMB = :QTDEMB');
    qryConsulta.Params.ParamByName('CODEMB').AsString := fStrZero(Trim(strIDEmb),2);
    qryConsulta.Params.ParamByName('QTDEMB').AsFloat  := fltQTDEmb;
    qryConsulta.Open;
    Result := qryConsulta.RecordCount > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TAnjoSinteticaDinamica.fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT AJA_CODSEQ FROM AJA_CADAJA ORDER BY AJA_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('AJA_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

constructor TAnjoSinteticaDinamica.Create;
begin
  intAutAja := 1;

  strPatDbf  := fGetConfTinta('AJA').fGet('PATAJA'); //ANJOSINTETICA1
  strPatDbfOriginal := strPatDbf;

  If Not DirectoryExists(strPatDbf)  Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  qryAJA_CADBAS :=  fCriaQuery;
  qryAJA_CADCOL :=  fCriaQuery;
  qryAJA_CADEMB :=  fCriaQuery;
  qryAJA_CADNFM :=  fCriaQuery;
  qryAJA_CADAJA :=  fCriaQuery;

  qryAJA_CADBAS.SQL.Text := 'SELECT * FROM AJA_CADBAS';
  qryAJA_CADCOL.SQL.Text := 'SELECT * FROM AJA_CADCOL';
  qryAJA_CADEMB.SQL.Text := 'SELECT * FROM AJA_CADEMB';
  qryAJA_CADNFM.SQL.Text := 'SELECT * FROM AJA_CADNFM';
  qryAJA_CADAJA.SQL.Text := 'SELECT * FROM AJA_CADAJA';

  qryAJA_CADBAS.Open;
  qryAJA_CADCOL.Open;
  qryAJA_CADEMB.Open;
  qryAJA_CADNFM.Open;
  qryAJA_CADAJA.Open;


  tblProducts :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblSubprods :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblFrm      :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblMask     :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblBases    :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblCnts     :=  fCriaQuery(nil, frmModulo.DataDBF);
end;

destructor TAnjoSinteticaDinamica.Destroy;
begin
  FreeAndNil(qryAJA_CADBAS);
  FreeAndNil(qryAJA_CADCOL);
  FreeAndNil(qryAJA_CADEMB);
  FreeAndNil(qryAJA_CADNFM);
  FreeAndNil(qryAJA_CADAJA);
  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);
  inherited Destroy;
end;

function TAnjoSinteticaDinamica.fVerificaCadEmb: Boolean;
  Var
    tblCans : TUniQuery;
    intCont : Integer;
    intErros :  Integer;
begin
  intErros := 0;
  tblCans := fCriaQuery(nil, frmModulo.DataDBF);
  tblCans.SQL.Add('SELECT * FROM ' + strPatDbf + '\CANS.DBF');
  tblCans.Open;
  tblCans.First;
  If Not qryAJA_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0) And
         (Not fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryAJA_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
  //        Result := False;
          Inc(intErros);
          Break;
        End
        Else If fEmptyStr(qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
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

procedure TAnjoSinteticaDinamica.pImportarCadEmb;
  Var
    tblCans : TUniQuery;
    intCont : Integer;
begin
  pAtualizaTabelas;
  tblCans := fCriaQuery(nil, frmModulo.DataDBF);
  tblCans.SQL.Add('SELECT * FROM ' + strPatDbf + '\CANS.DBF');
  tblCans.Open;
  tblCans.First;
  For intCont := 1 To tblCans.RecordCount Do
  Begin
    If Not fEmptyStr(tblCans.FieldByName('NOM_Q').AsString) Then
    Begin
      If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
      Begin
        qryAJA_CADEMB.Insert;
        qryAJA_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
        qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
        qryAJA_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
        qryAJA_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJA_CADEMB', VS_strCodEmp);
        If tblCans.FieldByName('NOM_Q').AsFloat = 900 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LT'
        Else If tblCans.FieldByName('NOM_Q').AsFloat = 3600 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'GL'
        Else
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LA';
        qryAJA_CADEMB.Post;
      End;
    End;
    tblCans.Next;
  End;
  tblCans.Close;
  FreeAndNil(tblCans);
end;

function TAnjoSinteticaDinamica.fDiretorioValido: Boolean;
begin
  Result := True;
  If Not FileExists(strPatDbf + '\PRODUCTS.DBF') Then
    Result := False;
end;

function TAnjoSinteticaDinamica.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryAJA_CADBAS.IsEmpty) and (fVerificaCadBasConfig);
end;

function TAnjoSinteticaDinamica.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qryAJA_CADCOL.IsEmpty;
end;

function TAnjoSinteticaDinamica.fVerificaCadBasConfig: Boolean;
  Var
    qryGen  : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM AJA_CADBAS WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;


function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
var
  intCont1  : Integer;
  intCont2  : Integer;
  qryCadBas : TUniQuery;
  qryCadAja : TUniQuery;
  strMd5Key: string;
begin
  qryCadAja := fCriaQuery;
  qryCadAja.SQL.Text := 'SELECT * FROM AJA_CADAJA LIMIT 0';
  qryCadAja.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM AJA_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';
  qryCadBas.ParamByName('BASE').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadAjaNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadAja.Insert;
    qryCadAja.FieldByName('AJA_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAja.FieldByName('AJA_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAja.FieldByName('AJA_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAja.FieldByName('AJA_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
    qryCadAja.FieldByName('AJA_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadAja.FieldByName('AJA_CODEMP').AsString := VS_strCodEmp;
    qryCadAja.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJA_CADAJA',VS_strCodEmp);
    qryCadAja.FieldByName('AJA_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadAja.FieldByName('AJA_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryCadAja.FieldByName('AJA_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
    qryCadAja.FieldByName('AJA_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;
    qryCadAja.FieldByName('AJA_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    strMd5Key := qryCadAja.FieldByName('AJA_DESCRI').AsString +
        qryCadAja.FieldByName('AJA_CODIGO').AsString +
        qryCadAja.FieldByName('AJA_CODIG2').AsString +
        qryCadAja.FieldByName('AJA_UNIDAD').AsString +
        qryCadAja.FieldByName('AJA_PROKEY').AsString +
        qryCadAja.FieldByName('AJA_SUBKEY').AsString +
        qryCadAja.FieldByName('AJA_BASE__').AsString;

    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadAja.FieldByName('AJA_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadAja.FieldByName('AJA_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString);

      strMd5Key := strMd5Key + qryCadAja.FieldByName('AJA_FORM' + fStrZero(intCont2 + 1, 2)).AsString +
          StringReplace(FormatFloat('0.0000', qryCadAja.FieldByName('AJA_QTDB' + fStrZero(intCont2 + 1, 2)).AsFloat), ',', '.', []);
    End;

    qryCadAja.FieldByName('AJA_MD5KEY').AsString := GetMD5(strMd5Key);
    qryCadAja.Post;
    qryCadBas.Next;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadAja);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  AJA_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadAjaNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE FROM AJA_CADAJA WHERE  AJA_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT AJA_CODSEQ FROM AJA_CADAJA ORDER BY AJA_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('AJA_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
End;

{ TAnjoSinteticaDinamicaNfm }

function TAnjoSinteticaDinamicaNfm.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM AJA_CADAJA WHERE AJA_CODIGO IN (SELECT NFM_CODPRO FROM AJA_CADNFM);';
  qryGen.ExecSQL;

  {*******************************************}
  {* SELECIONA TODAS AS NOVAS FORMULAS       *}
  {****************************************PH*}
  qryGen.SQL.Text := 'SELECT * FROM AJA_CADNFM;';
  qryGen.Open;

  qryGen.First;

  pRegistraAcao('Cadastrando novas fórmulas');

  {**************************************************************************************}
  {* PERCORRE TODAS AS NOVAS FORMULAS CADASTRANDO EM VARIAS UNIDADES DEPENDENDO DA BASE *}
  {***********************************************************************************PH*}
  While Not qryGen.Eof Do
  Begin
    fGravaNovaFormula(qryGen);

    qryGen.Next;
    pRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);    
  End;

  pRegistraAcao('Novas fórmulas cadastradas com sucesso!');

  Result := True;
end;

end.

