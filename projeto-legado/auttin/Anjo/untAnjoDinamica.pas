unit untAnjoDinamica;

interface

uses untTintadeMaquina, Classes, Uni, SysUtils, StrUtils, Variants, Forms, ExtCtrls, DBFUniProvider ;

Type
  TColAnj = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type
  TAnjoDinamica = class(TTintadeMaquina)

    private
      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;
      tblCnts    : TUniQuery;

      strPatDbf : String;
      strPatDbf2 : String;
      strPatDbfOriginal : String;

      qryANJ_CADBAS : TUniQuery;
      qryANJ_CADCOL : TUniQuery;
      qryANJ_CADEMB : TUniQuery;
      qryANJ_CADNFM : TUniQuery;
      qryANJ_CADANJ : TUniQuery;

      intAutAnj     : Integer;

      DFUniProvider : TDBFUniProvider;

      DataDBFPro : TUniConnection;
      DataDBFSub : TUniConnection;
      DataDBFFrm : TUniConnection;
      DataDBFMas : TUniConnection;

    protected
      procedure pCarregarProducts;
      procedure pCarregarSubprods(strPatPro: String);
      procedure pCarregarFrm(strPatPro: String; strPatSub: String);
      procedure pCarregarMask(strPatSub: String);
      procedure pCarregarBases;
      function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
      procedure pGravaCadCol(arrColAnj : Array of TColAnj);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadAnj(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColAnj: Array of TColAnj; strDesTin: String): Boolean;
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
      function fGravarNovasFormulas: Boolean; override;
      Constructor Create(AOwner: TComponent); override;
      Constructor CreateNfm(blnValidarDir : Boolean = true );

      Procedure pValidarDiretorio(blnValPath : Boolean = true);

      Destructor Destroy; Reintroduce;
  End;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadAnjNfm(CodPro : String);


implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta, untModulo;


{ TAnjoDinamica }

function TAnjoDinamica.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryANJ_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryANJ_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryANJ_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryANJ_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TAnjoDinamica.pGravaCadCol(arrColAnj: array of TColAnj);
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
  For intCont := Low(arrColAnj) To High(arrColAnj) Do
  Begin
    qryANJ_CADCOL.First;
    If Not qryANJ_CADCOL.Locate('COL_CODCOL', arrColAnj[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColAnj[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColAnj[intCont].strCodCol) Then
          Break;

        qryANJ_CADCOL.Insert;
        qryANJ_CADCOL.FieldByName('COL_CODCOL').AsString := arrColAnj[intCont].strCodCol;
        qryANJ_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryANJ_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANJ_CADCOL', VS_strCodEmp);
        qryANJ_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAnj[intCont].strCodCol);
        qryANJ_CADCOL.Post;
      End;
    End
    Else If fEmptyStr(qryANJ_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryANJ_CADCOL.Edit;
      qryANJ_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAnj[intCont].strCodCol);
      qryANJ_CADCOL.Post;
    End;
  End;
end;

procedure TAnjoDinamica.pCarregarBases;
begin
  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('SELECT * FROM \bases.dbf');
  tblBases.Open;
  tblBases.First;

  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('SELECT * FROM \cnts.dbf');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAnjoDinamica.pCarregarFrm(strPatPro: String; strPatSub: String);
begin
  If FileExists(strPatSub + '\frm.dbf') Then
    DataDBFFrm.Database := strPatSub
  Else If FileExists(strPatPro + '\frm.dbf') Then
    DataDBFFrm.Database := strPatPro
  Else
    DataDBFFrm.Database := strPatDbf;

  If (Not DataDBFFrm.Connected) Then
    DataDBFFrm.Connected := True;

  tblFrm.Close;
  tblFrm.SQL.Clear;
  tblFrm.SQL.Add('SELECT * FROM \frm.dbf');
  tblFrm.Open;
  tblFrm.First;
end;

procedure TAnjoDinamica.pCarregarMask(strPatSub: String);
begin
  DataDBFMas.Database := strPatSub;

  If (Not DataDBFMas.Connected) Then
    DataDBFMas.Connected := True;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('SELECT * FROM \mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TAnjoDinamica.pCarregarProducts;
begin
  DataDBFPro.Database := strPatDbf;

  If (Not DataDBFPro.Connected) Then
    DataDBFPro.Connected := True;

  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('SELECT * FROM \products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAnjoDinamica.pCarregarSubprods(strPatPro: String);
begin
  DataDBFSub.Database := strPatPro;

  If (Not DataDBFSub.Connected) Then
    DataDBFSub.Connected := True;

  tblSubprods.Close;
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('SELECT * FROM \subprods.dbf');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TAnjoDinamica.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColAnj   : Array Of TColAnj;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
    intPatAnjo  : Integer;
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
    pZapTable('ANJ_CADANJ');

  For intPatAnjo := 1 to 2 do
  Begin

    If intPatAnjo = 2 Then
    Begin
      if ((strPatDbfOriginal = EmptyStr) Or
          (strPatDbf2 = EmptyStr)) then
        Begin
          Result := True;
          Exit;
        End
      else
        begin
          strPatDbf := strPatDbf2;
          pCarregarProducts;
          pCarregarBases;
          pAtualizaTabelas;
        end;
    End;

    {
    If Not fVerificaCadEmb Then
    Begin
      If qryANJ_CADEMB.IsEmpty Then
      Begin
        If fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
          pImportarCadEmb;
      End
      Else
        fMensagem('', 'O Cadastro de Embalagem está inconsistente!', ['&OK']);

      Exit;
    End;
    }

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

          qryANJ_CADEMB.First;
          For intMask := 1 To qryANJ_CADEMB.RecordCount Do
          Begin
            strFormula := tblFrm.FieldByName('FORMULA').AsString;
            SetLength(arrColAnj, 0);

            While (Not fEmptyStr(strFormula)) Do
            Begin
              SetLength(arrColAnj, Length(arrColAnj) + 1);
              intPos := Pos(',', strFormula);
              arrColAnj[Length(arrColAnj) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
              strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              intPos := Pos(',', strFormula);
              If intPos <= 0 Then
                intPos := Length(strFormula)+1;
              arrColAnj[Length(arrColAnj) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
              strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            End;

            SetLength(arrColAnj, 20);
            strQtdEmb := fStrZero(Trim(qryANJ_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

            If (qryANJ_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
            Begin
              tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
              qryANJ_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

              If blnBasCol Then
              Begin
                strDesTin := AnsiUpperCase(
                           Trim(tblProducts.FieldByName('DESCR').AsString) + ' ' +
                           Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                           Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                           FormatFloat('0.00', qryANJ_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

                pGravaCadCol(arrColAnj);

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
                For intColora := Low(arrColAnj) To High(arrColAnj) Do
                Begin
                  If fEmptyStr(arrColAnj[intColora].strCodCol) Then
                    Break;

                  arrColAnj[intColora].fltQtdCol := fCalQtdEmb(arrColAnj[intColora].fltQtdCol, strEmbCom, strQtdEmb);
                End;

                If fGravaCadAnj(intCodSeq, strBaseSe, strProKey, strSubKey, arrColAnj, strDesTin) Then
                  Inc(intCodSeq);
              End;
            End;
            qryANJ_CADEMB.Next;
          End;
          tblFrm.Next;
          If Saida <> nil Then
            Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                              tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                              tblFrm.RecNo, tblFrm.RecordCount, qryANJ_CADEMB.RecNo, qryANJ_CADEMB.RecordCount]);
          Application.ProcessMessages;
        End;
        tblSubprods.Next;
      End;
      tblProducts.Next;
    End;
{    fGravaAutoIncrem('ANJ_CADANJ', intAutAnj);
    If Not blnBasCol Then
      pGravaNovasFormulas;}
  End;
  fGravaAutoIncrem('ANJ_CADANJ', intAutAnj);
  If Not blnBasCol Then
    pGravaNovasFormulas;
    
  Result := True;
end;

function TAnjoDinamica.fGravaCadAnj(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColAnj: Array of TColAnj; strDesTin: String): Boolean;
var
  intCont : Integer;
  strMd5Key: string;
begin
  Result := False;
  If qryANJ_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) and
                Not fEmptyStr(qryANJ_CADBAS.FieldByName('BAS_CODITE').AsString) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryANJ_CADANJ.FieldByName('ANJ_DESCRI').AsString <> strDesTin) or
       (qryANJ_CADANJ.FieldByName('ANJ_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryANJ_CADANJ.FieldByName('ANJ_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryANJ_CADANJ.FieldByName('ANJ_UNIDAD').AsString <> qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryANJ_CADANJ.IsEmpty Then
    Begin
      qryANJ_CADANJ.Insert;
      qryANJ_CADANJ.FieldByName('ANJ_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryANJ_CADANJ.FieldByName('ANJ_DESCRI').AsString := strDesTin;
      qryANJ_CADANJ.FieldByName('ANJ_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryANJ_CADANJ.FieldByName('ANJ_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryANJ_CADANJ.FieldByName('ANJ_UNIDAD').AsString := qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryANJ_CADANJ.FieldByName('ANJ_CODEMP').AsString := VS_strCodEmp;
      qryANJ_CADANJ.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutAnj, VS_strCodEmp);
      Inc(intAutAnj);
      qryANJ_CADANJ.FieldByName('ANJ_BASE__').AsString := qryANJ_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryANJ_CADANJ.FieldByName('ANJ_PROKEY').AsString := qryANJ_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryANJ_CADANJ.FieldByName('ANJ_SUBKEY').AsString := qryANJ_CADBAS.FieldByName('BAS_SUBKEY').AsString;
      
      strMd5Key := qryANJ_CADANJ.FieldByName('ANJ_DESCRI').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_CODIGO').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_CODIG2').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_UNIDAD').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_PROKEY').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_SUBKEY').AsString +
        qryANJ_CADANJ.FieldByName('ANJ_BASE__').AsString; 

      For intCont := Low(arrColAnj) To High(arrColAnj) Do
      Begin
        strMd5Key := strMd5Key + arrColAnj[intCont].strCodCol +
          StringReplace(FormatFloat('0.0000', arrColAnj[intCont].fltQtdCol), ',', '.', []);

        If fEmptyStr(arrColAnj[intCont].strCodCol) Then
          Continue;

        qryANJ_CADANJ.FieldByName('ANJ_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColAnj[intCont].strCodCol;
        qryANJ_CADANJ.FieldByName('ANJ_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColAnj[intCont].fltQtdCol;
      End;

      qryANJ_CADANJ.FieldByName('ANJ_MD5KEY').AsString := GetMD5(strMd5Key);

      qryANJ_CADANJ.Post;
      Result := True;
    End;
end;

function TAnjoDinamica.fGravarNovasFormulas: Boolean;
Var
  QryNfm : TUniQuery;
begin
  Result := false;

  QryNfm := Nil;

  try
    QryNfm := fCriaQuery;
    QryNfm.SQL.Text := 'SELECT * FROM ANJ_CADNFM;';
    QryNfm.Open;

    QryNfm.First;

    pRegistraAcao('Processando o cadastro de novas fórmulas...');

    While not (QryNfm.Eof) Do
    begin
      pRegistraAcao('Cadastrando a nova fórmula..:' + QryNfm.fieldByName('NFM_CODPRO').AsString );

      Result := fGravaNovaFormula(QryNfm);

      pRegistraProgresso(0, QryNfm.RecNo, QryNfm.RecordCount);

      QryNfm.Next;
    end;

    pRegistraAcao('Cadastro de novas fórmulas realizado com sucesso!');

  finally
    FreeAndNil(QryNfm);
  end;
end;

procedure TAnjoDinamica.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryANJ_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBasSe, strProKey, strSubKey, qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryANJ_CADBAS.Insert;
    qryANJ_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryANJ_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryANJ_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryANJ_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryANJ_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryANJ_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryANJ_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANJ_CADBAS', VS_strCodEmp);
    qryANJ_CADBAS.Post;
  End;
end;

procedure TAnjoDinamica.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;
  For intCont1 := 1 To qryANJ_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryANJ_CADNFM);
    qryANJ_CADNFM.Next;
  End;
end;

procedure TAnjoDinamica.pAtualizaTabelas;
begin
  qryANJ_CADBAS.Close;
  qryANJ_CADCOL.Close;
  qryANJ_CADEMB.Close;
  qryANJ_CADNFM.Close;
  qryANJ_CADANJ.Close;

  qryANJ_CADBAS.Open;
  qryANJ_CADCOL.Open;
  qryANJ_CADEMB.Open;
  qryANJ_CADNFM.Open;
  qryANJ_CADANJ.Open;
end;

function TAnjoDinamica.fExisteEmbalagem(strIDEmb: String; fltQTDEmb: Double): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Nil);
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT EMB_CODEMB FROM ANJ_CADEMB WHERE EMB_CODEMB = :CODEMB');
    qryConsulta.SQL.Add(' AND EMB_QTDEMB = :QTDEMB');
    qryConsulta.Params.ParamByName('CODEMB').AsString := fStrZero(Trim(strIDEmb),2);
    qryConsulta.Params.ParamByName('QTDEMB').AsFloat  := fltQTDEmb;
    qryConsulta.Open;
    Result := qryConsulta.RecordCount > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TAnjoDinamica.fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT ANJ_CODSEQ FROM ANJ_CADANJ ORDER BY ANJ_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ANJ_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

constructor TAnjoDinamica.Create;
begin
  pValidarDiretorio;
end;

constructor TAnjoDinamica.CreateNfm(blnValidarDir: Boolean);
begin
  pValidarDiretorio(blnValidarDir);
end;

destructor TAnjoDinamica.Destroy;
begin
  FreeAndNil(qryANJ_CADBAS);
  FreeAndNil(qryANJ_CADCOL);
  FreeAndNil(qryANJ_CADEMB);
  FreeAndNil(qryANJ_CADNFM);
  FreeAndNil(qryANJ_CADANJ);
  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);

  If Assigned(DFUniProvider) Then FreeAndNil(DFUniProvider);
  If Assigned(DataDBFPro) Then FreeAndNil(DataDBFPro);
  If Assigned(DataDBFSub) Then FreeAndNil(DataDBFSub);
  If Assigned(DataDBFFrm) Then FreeAndNil(DataDBFFrm);
  If Assigned(DataDBFMas) Then FreeAndNil(DataDBFMas);

  inherited Destroy;
end;

function TAnjoDinamica.fVerificaCadEmb: Boolean;
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
  If Not qryANJ_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0) And
         (Not fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryANJ_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
  //        Result := False;
          Inc(intErros);
          Break;
        End
        Else If fEmptyStr(qryANJ_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
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

procedure TAnjoDinamica.pImportarCadEmb;
  Var
    tblCans : TUniQuery;
    intCont : Integer;
    intEmb  : Integer;
begin
  For intEmb := 1 to 2 Do
  Begin
    If intEmb = 2 Then
    Begin
      if ((strPatDbfOriginal = EmptyStr) Or
          (strPatDbf2 = EmptyStr)) then
        Begin
          Exit;
        End
      Else
        strPatDbf := strPatDbf2;
    End;

    pAtualizaTabelas;
    tblCans := fCriaQuery(nil, frmModulo.DataDBF);
    tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
    tblCans.Open;
    tblCans.First;
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
      Begin
        qryANJ_CADEMB.Insert;
        qryANJ_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
        qryANJ_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
        qryANJ_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
        qryANJ_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANJ_CADEMB', VS_strCodEmp);
        qryANJ_CADEMB.Post;
      End;
      tblCans.Next;
    End;
    tblCans.Close;
    FreeAndNil(tblCans);
  End;
end;

procedure TAnjoDinamica.pValidarDiretorio(blnValPath: Boolean);
begin
  intAutAnj := 1;

  strPatDbf  := fGetConfTinta('ANJ').fGet('PATANJ'); //ANJO1
  strPatDbf2 := fGetConfTinta('ANJ').fGet('ANJPAT'); //ANJO2
  strPatDbfOriginal := strPatDbf;

  if (blnValPath) then
  begin
    If ((Not DirectoryExists(strPatDbf)) And (Not DirectoryExists(strPatDbf2))) Then
    Begin
      fMensagem('', 'O path configurado não existe!', ['&Sim']);
      Exit;
    End;
  end;

  If ((Not DirectoryExists(strPatDbf)) And (DirectoryExists(strPatDbf2))) Then
  Begin
    strPatDbfOriginal := EmptyStr;
    strPatDbf         := strPatDbf2;
  End;

  If ((DirectoryExists(strPatDbf)) And (Not DirectoryExists(strPatDbf2))) Then
  Begin
    strPatDbfOriginal := strPatDbf;
    strPatDbf2        := EmptyStr;
  End;

  qryANJ_CADBAS :=  fCriaQuery;
  qryANJ_CADCOL :=  fCriaQuery;
  qryANJ_CADEMB :=  fCriaQuery;
  qryANJ_CADNFM :=  fCriaQuery;
  qryANJ_CADANJ :=  fCriaQuery;

  qryANJ_CADBAS.SQL.Text := 'SELECT * FROM ANJ_CADBAS';
  qryANJ_CADCOL.SQL.Text := 'SELECT * FROM ANJ_CADCOL';
  qryANJ_CADEMB.SQL.Text := 'SELECT * FROM ANJ_CADEMB';
  qryANJ_CADNFM.SQL.Text := 'SELECT * FROM ANJ_CADNFM';
  qryANJ_CADANJ.SQL.Text := 'SELECT * FROM ANJ_CADANJ';

  qryANJ_CADBAS.Open;
  qryANJ_CADCOL.Open;
  qryANJ_CADEMB.Open;
  qryANJ_CADNFM.Open;
  qryANJ_CADANJ.Open;

  DFUniProvider := TDBFUniProvider.Create(Nil);

  DataDBFPro := TUniConnection.Create(Nil);
  DataDBFPro.ProviderName := 'DBF';
  DataDBFPro.LoginPrompt  := False;

  DataDBFSub := TUniConnection.Create(Nil);
  DataDBFSub.ProviderName := 'DBF';
  DataDBFSub.LoginPrompt  := False;

  DataDBFFrm := TUniConnection.Create(Nil);
  DataDBFFrm.ProviderName := 'DBF';
  DataDBFFrm.LoginPrompt  := False;

  DataDBFMas := TUniConnection.Create(Nil);
  DataDBFMas.ProviderName := 'DBF';
  DataDBFMas.LoginPrompt  := False;

  frmModulo.DataDBF.Database := strPatDbf;

  If Not frmModulo.DataDBF.Connected Then
    frmModulo.DataDBF.Connected := True;

  tblProducts :=  fCriaQuery(nil, DataDBFPro);
  tblSubprods :=  fCriaQuery(nil, DataDBFSub);
  tblFrm      :=  fCriaQuery(nil, DataDBFFrm);
  tblMask     :=  fCriaQuery(nil, DataDBFMas);
  tblBases    :=  fCriaQuery(nil, frmModulo.DataDBF);
  tblCnts     :=  fCriaQuery(nil, frmModulo.DataDBF);

end;

function TAnjoDinamica.fDiretorioValido: Boolean;
begin
  Result := True;
  If ((Not FileExists(strPatDbf + '\PRODUCTS.DBF')) And
      (Not FileExists(strPatDbf2 + '\PRODUCTS.DBF'))) Then
    Result := False;
end;

function TAnjoDinamica.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryANJ_CADBAS.IsEmpty) and (fVerificaCadBasConfig);
end;

function TAnjoDinamica.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qryANJ_CADCOL.IsEmpty;
end;

function TAnjoDinamica.fVerificaCadBasConfig: Boolean;
  Var
    qryGen  : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM ANJ_CADBAS WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;


function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
var
  intCont1  : Integer;
  intCont2  : Integer;
  qryCadBas : TUniQuery;
  qryCadAnj : TUniQuery;
  strMd5Key: string;
begin
  qryCadAnj := fCriaQuery;
  qryCadAnj.SQL.Text := 'SELECT * FROM ANJ_CADANJ LIMIT 0';
  qryCadAnj.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * '+
                        '  FROM ANJ_CADBAS '+
                        ' WHERE BAS_BASE__ = :BASE   '+
                        '   AND BAS_PROKEY = :PROKEY '+
                        '   AND BAS_SUBKEY = :SUBKEY ';
  qryCadBas.ParamByName('BASE').AsString   := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadAnjNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadAnj.Insert;
    qryCadAnj.FieldByName('ANJ_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAnj.FieldByName('ANJ_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAnj.FieldByName('ANJ_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadAnj.FieldByName('ANJ_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
    qryCadAnj.FieldByName('ANJ_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadAnj.FieldByName('ANJ_CODEMP').AsString := VS_strCodEmp;
    qryCadAnj.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANJ_CADANJ',VS_strCodEmp);
    qryCadAnj.FieldByName('ANJ_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadAnj.FieldByName('ANJ_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryCadAnj.FieldByName('ANJ_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
    qryCadAnj.FieldByName('ANJ_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

    strMd5Key := qryCadAnj.FieldByName('ANJ_DESCRI').AsString +
        qryCadAnj.FieldByName('ANJ_CODIGO').AsString +
        qryCadAnj.FieldByName('ANJ_CODIG2').AsString +
        qryCadAnj.FieldByName('ANJ_UNIDAD').AsString +
        qryCadAnj.FieldByName('ANJ_PROKEY').AsString +
        qryCadAnj.FieldByName('ANJ_SUBKEY').AsString +
        qryCadAnj.FieldByName('ANJ_BASE__').AsString;

    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadAnj.FieldByName('ANJ_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadAnj.FieldByName('ANJ_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString);

      strMd5Key := strMd5Key + qryCadAnj.FieldByName('ANJ_FORM' + fStrZero(intCont2 + 1, 2)).AsString +
          StringReplace(FormatFloat('0.0000', qryCadAnj.FieldByName('ANJ_QTDB' + fStrZero(intCont2 + 1, 2)).AsFloat), ',', '.', []);
    End;

    qryCadAnj.FieldByName('ANJ_MD5KEY').AsString := GetMD5(strMd5Key);
    qryCadAnj.Post;
    qryCadBas.Next;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadAnj);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  ANJ_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadAnjNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE FROM ANJ_CADANJ WHERE  ANJ_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT ANJ_CODSEQ FROM ANJ_CADANJ ORDER BY ANJ_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ANJ_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
End;

end.


