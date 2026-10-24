unit untWegDinamica;

interface

uses Classes, Uni, SysUtils, StrUtils, Variants,  Forms, ExtCtrls, untTintadeMaquina;

Type
  TColWeg = Record
    strCodCol: String;
    fltQtdCol: Double;
  End;

Type

  TWegNfm = class(TTintadeMaquina)
  public
    constructor Create(AOwner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;


  TWegDinamica = class
    private
      tblProducts: TUniQuery;
      tblSubprods: TUniQuery;
      tblFrm     : TUniQuery;
      tblMask    : TUniQuery;
      tblBases   : TUniQuery;
      tblCnts    : TUniQuery;

      strPatDbf : String;
      strPatDbfOriginal : String;

      qryWEG_CADBAS : TUniQuery;
      qryWEG_CADCOL : TUniQuery;
      qryWEG_CADEMB : TUniQuery;
      qryWEG_CADNFM : TUniQuery;
      qryWEG_CADWEG : TUniQuery;

      intAutWeg     : Integer;

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
      procedure pGravaCadCol(arrColWeg : Array of TColWeg);
      procedure pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String; strDesTin: String);
      function fGravaCadWeg(intCodSeq: Integer; strBasSe: String; strProKey: String; strSubKey: String; arrColWeg: Array of TColWeg; strDesTin: String): Boolean;
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
      function fRetUnidade(fltQtdEmb : Double) : String;


    public
      function fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
      Constructor Create;
      Destructor Destroy; Reintroduce;

  End;

  function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  function fRetProxCodSeq: Integer;
  procedure pRemoveCadWegNfm(CodPro : String);


implementation

uses untFuncoes, untFuncoesSimples, DB, untFuncTinta, untModulo;


{ TWegDinamica }

function TWegDinamica.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
  Var
    fltEmbAtu : Double;
    fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryWEG_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryWEG_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

procedure TWegDinamica.pGravaCadCol(arrColWeg: array of TColWeg);
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
  For intCont := Low(arrColWeg) To High(arrColWeg) Do
  Begin
    qryWEG_CADCOL.First;
    If Not qryWEG_CADCOL.Locate('COL_CODCOL', arrColWeg[intCont].strCodCol, []) Then
    Begin
      If Not fEmptyStr(arrColWeg[intCont].strCodCol) Then
      Begin
        If fEmptyStr(arrColWeg[intCont].strCodCol) Then
          Break;

        qryWEG_CADCOL.Insert;
        qryWEG_CADCOL.FieldByName('COL_CODCOL').AsString := arrColWeg[intCont].strCodCol;
        qryWEG_CADCOL.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryWEG_CADCOL.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WEG_CADCOL', VS_strCodEmp);
        qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColWeg[intCont].strCodCol);
        qryWEG_CADCOL.FieldByName('COL_EMBALA').AsFloat  := 3600;
        qryWEG_CADCOL.Post;
      End;
    End
    Else If fEmptyStr(qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryWEG_CADCOL.Edit;
      qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColWeg[intCont].strCodCol);
      qryWEG_CADCOL.Post;
    End;
  End;
end;

procedure TWegDinamica.pCarregarBases;
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

procedure TWegDinamica.pCarregarFrm(strPatPro: String; strPatSub: String);
begin
  DataDBFFrm.Connected := False;

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

procedure TWegDinamica.pCarregarMask(strPatSub: String);
begin
  DataDBFMas.Connected := False;

  DataDBFMas.Database := strPatSub;

  If (Not DataDBFMas.Connected) Then
    DataDBFMas.Connected := True;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('SELECT * FROM \mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TWegDinamica.pCarregarProducts;
begin
  DataDBFPro.Connected := False;

  DataDBFPro.Database := strPatDbf;

  If (Not DataDBFPro.Connected) Then
    DataDBFPro.Connected := True;

  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('SELECT * FROM \products.dbf');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TWegDinamica.pCarregarSubprods(strPatPro: String);
begin
  DataDBFSub.Connected := False;

  DataDBFSub.Database := strPatPro;

  If (Not DataDBFSub.Connected) Then
    DataDBFSub.Connected := True;

  tblSubprods.Close;
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('SELECT * FROM \subprods.dbf');
  tblSubprods.Open;
  tblSubprods.First;
end;

function TWegDinamica.fProcessarArquivos(blnGerBase: Boolean; blnBasCol: Boolean; var Saida: TPanel): Boolean;
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

    arrColWeg   : Array Of TColWeg;
    strQtdEmb   : String;
    strDesTin   : String;
    intColora   : Integer;
    intCodSeq   : Integer;
    intPatWeg  : Integer;
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
    pZapTable('WEG_CADWEG');

  If Not fVerificaCadEmb Then
  Begin
    If qryWEG_CADEMB.IsEmpty Then
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
    strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString; // + '\';
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

        qryWEG_CADEMB.First;
        For intMask := 1 To qryWEG_CADEMB.RecordCount Do
        Begin
          strFormula := tblFrm.FieldByName('FORMULA').AsString;
          SetLength(arrColWeg, 0);

          While (Not fEmptyStr(strFormula)) Do
          Begin
            SetLength(arrColWeg, Length(arrColWeg) + 1);
            intPos := Pos(',', strFormula);
            arrColWeg[Length(arrColWeg) - 1].strCodCol := fStrZero(Copy(strFormula, 1, intPos - 1), 2);
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
            intPos := Pos(',', strFormula);
            If intPos <= 0 Then
              intPos := Length(strFormula)+1;
            arrColWeg[Length(arrColWeg) - 1].fltQtdCol := fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));
            strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
          End;

          SetLength(arrColWeg, 20);
          strQtdEmb := fStrZero(Trim(qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString), 2);

          If (qryWEG_CADEMB.FieldByName('EMB_USAEMB').AsString = 'S') Then
          Begin
            tblBases.Locate('ID', tblFrm.FieldByName('BASE_ID').AsString, []);
            qryWEG_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);

            If blnBasCol Then
            Begin
              strDesTin := AnsiUpperCase(
                         //Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                         Trim(tblBases.FieldByName('DESCR').AsString) + ' ' +
                         FormatFloat('0.00', qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L');

              pGravaCadCol(arrColWeg);

              If blnGerBase Then
                pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin);
            End
            Else
            Begin
              strDesTin := AnsiUpperCase(
                            tblFrm.FieldByName('KEY1').AsString + ' ' +
                            //Trim(tblSubprods.FieldByName('DESCR').AsString) + ' ' +
                            tblFrm.FieldByName('KEY2').AsString + ' ' +
                            tblFrm.FieldByName('KEY3').AsString
                            );
              For intColora := Low(arrColWeg) To High(arrColWeg) Do
              Begin
                If fEmptyStr(arrColWeg[intColora].strCodCol) Then
                  Break;

                arrColWeg[intColora].fltQtdCol := fCalQtdEmb(arrColWeg[intColora].fltQtdCol, strEmbCom, strQtdEmb);
              End;

              If fGravaCadWeg(intCodSeq, strBaseSe, strProKey, strSubKey, arrColWeg, strDesTin) Then
                Inc(intCodSeq);
            End;
          End;
          qryWEG_CADEMB.Next;
        End;
        tblFrm.Next;
        If Saida <> nil Then
          Saida.Caption := Format('Processando Arquivos %d/%d %d/%d %d/%d %d/%d', [tblProducts.RecNo,
                            tblProducts.RecordCount, tblSubprods.RecNo , tblSubprods.RecordCount,
                            tblFrm.RecNo, tblFrm.RecordCount, qryWEG_CADEMB.RecNo, qryWEG_CADEMB.RecordCount]);
        Application.ProcessMessages;
      End;
      tblSubprods.Next;
    End;
    tblProducts.Next;
  End;

  fGravaAutoIncrem('WEG_CADWEG', intAutWeg);
  If Not blnBasCol Then
    pGravaNovasFormulas;

  Result := True;
end;

function TWegDinamica.fGravaCadWeg(intCodSeq: Integer; strBasSe: String; strProKey: String;
  strSubKey: String; arrColWeg: Array of TColWeg; strDesTin: String): Boolean;
  Var
    intCont : Integer;
begin
  Result := False;
  If qryWEG_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                VarArrayOf([strBasSe, strProKey, strSubKey, qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
    {*************************************************************************}
    {* VERIFICA SE NAO É IGUAL AO ULTIMO GRAVADO PARA NAO GRAVAR DUCPLICADOS *}
    {**********************************************************************PH*}
    If (qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString <> strDesTin) or
       (qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString <> qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryWEG_CADWEG.IsEmpty Then
    Begin
      qryWEG_CADWEG.Insert;
      qryWEG_CADWEG.FieldByName('WEG_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString := strDesTin;
      qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryWEG_CADWEG.FieldByName('WEG_NOMCOR').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY3').AsString);
      qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString := qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryWEG_CADWEG.FieldByName('WEG_CODEMP').AsString := VS_strCodEmp;
      qryWEG_CADWEG.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutWeg, VS_strCodEmp);
      Inc(intAutWeg);
      qryWEG_CADWEG.FieldByName('WEG_BASE__').AsString := qryWEG_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryWEG_CADWEG.FieldByName('WEG_PROKEY').AsString := qryWEG_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryWEG_CADWEG.FieldByName('WEG_SUBKEY').AsString := qryWEG_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      For intCont := Low(arrColWeg) To High(arrColWeg) Do
      Begin
        If fEmptyStr(arrColWeg[intCont].strCodCol) Then
          Break;

        qryWEG_CADWEG.FieldByName('WEG_FORM' + fStrZero(intCont + 1, 2)).AsString := arrColWeg[intCont].strCodCol;
        qryWEG_CADWEG.FieldByName('WEG_QTDB' + fStrZero(intCont + 1, 2)).AsFloat := arrColWeg[intCont].fltQtdCol;
      End;
      qryWEG_CADWEG.Post;
      Result := True;
    End;
end;

procedure TWegDinamica.pGravaCadBas(strBasSe: String; strProKey: String; strSubKey: String;
  strDesTin: String);
begin
  If Not qryWEG_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
     VarArrayOf([strBasSe, strProKey, strSubKey, qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryWEG_CADBAS.Insert;
    qryWEG_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryWEG_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryWEG_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryWEG_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryWEG_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryWEG_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryWEG_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WEG_CADBAS', VS_strCodEmp);
    qryWEG_CADBAS.Post;
  End;
end;

procedure TWegDinamica.pGravaNovasFormulas;
  Var
    intCont1  : Integer;
begin
  pAtualizaTabelas;
  For intCont1 := 1 To qryWEG_CADNFM.RecordCount Do
  Begin
    fGravaNovaFormula(qryWEG_CADNFM);
    qryWEG_CADNFM.Next;
  End;
end;

procedure TWegDinamica.pAtualizaTabelas;
begin
  qryWEG_CADBAS.Close;
  qryWEG_CADCOL.Close;
  qryWEG_CADEMB.Close;
  qryWEG_CADNFM.Close;
  qryWEG_CADWEG.Close;

  qryWEG_CADBAS.Open;
  qryWEG_CADCOL.Open;
  qryWEG_CADEMB.Open;
  qryWEG_CADNFM.Open;
  qryWEG_CADWEG.Open;
end;

function TWegDinamica.fExisteEmbalagem(strIDEmb: String; fltQTDEmb: Double): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Nil);
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT EMB_CODEMB FROM WEG_CADEMB WHERE EMB_CODEMB = :CODEMB');
    qryConsulta.SQL.Add(' AND EMB_QTDEMB = :QTDEMB');
    qryConsulta.Params.ParamByName('CODEMB').AsString := fStrZero(Trim(strIDEmb),2);
    qryConsulta.Params.ParamByName('QTDEMB').AsFloat  := fltQTDEmb;
    qryConsulta.Open;
    Result := qryConsulta.RecordCount > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TWegDinamica.fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT WEG_CODSEQ FROM WEG_CADWEG ORDER BY WEG_CODSEQ DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('WEG_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
end;

function TWegDinamica.fRetUnidade(fltQtdEmb: Double): String;
begin
  Result := 'LT';

  If fltQtdEmb = 3600 Then
    Result := 'GL'
  else
  If fltQtdEmb = 20000 Then
    Result := 'LA';
end;

constructor TWegDinamica.Create;
begin
  intAutWeg := 1;

  strPatDbf  := fGetConfTinta('WEG').fGet('PATWEG'); //WEG1
  strPatDbfOriginal := strPatDbf;

  If (Not DirectoryExists(strPatDbf)) Then
  Begin
    fMensagem('', 'O path configurado não existe!', ['&Sim']);
    Exit;
  End;

  qryWEG_CADBAS :=  fCriaQuery;
  qryWEG_CADCOL :=  fCriaQuery;
  qryWEG_CADEMB :=  fCriaQuery;
  qryWEG_CADNFM :=  fCriaQuery;
  qryWEG_CADWEG :=  fCriaQuery;

  qryWEG_CADBAS.SQL.Text := 'SELECT * FROM WEG_CADBAS';
  qryWEG_CADCOL.SQL.Text := 'SELECT * FROM WEG_CADCOL';
  qryWEG_CADEMB.SQL.Text := 'SELECT * FROM WEG_CADEMB';
  qryWEG_CADNFM.SQL.Text := 'SELECT * FROM WEG_CADNFM';
  qryWEG_CADWEG.SQL.Text := 'SELECT * FROM WEG_CADWEG';

  qryWEG_CADBAS.Open;
  qryWEG_CADCOL.Open;
  qryWEG_CADEMB.Open;
  qryWEG_CADNFM.Open;
  qryWEG_CADWEG.Open;

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

destructor TWegDinamica.Destroy;
begin
  FreeAndNil(qryWEG_CADBAS);
  FreeAndNil(qryWEG_CADCOL);
  FreeAndNil(qryWEG_CADEMB);
  FreeAndNil(qryWEG_CADNFM);
  FreeAndNil(qryWEG_CADWEG);
  FreeAndNil(tblProducts);
  FreeAndNil(tblSubprods);
  FreeAndNil(tblFrm);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);

  If Assigned(DataDBFPro) Then FreeAndNil(DataDBFPro);
  If Assigned(DataDBFSub) Then FreeAndNil(DataDBFSub);
  If Assigned(DataDBFFrm) Then FreeAndNil(DataDBFFrm);
  If Assigned(DataDBFMas) Then FreeAndNil(DataDBFMas);

  inherited Destroy;
end;

function TWegDinamica.fVerificaCadEmb: Boolean;
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
  If Not qryWEG_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0) And
         (Not fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryWEG_CADEMB.Locate('EMB_CODEMB', fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
  //        Result := False;
          Inc(intErros);
          Break;
        End
        Else If fEmptyStr(qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
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

procedure TWegDinamica.pImportarCadEmb;
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
    If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
    Begin
      qryWEG_CADEMB.Insert;
      qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString := fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
      qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
      qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
      qryWEG_CADEMB.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
      qryWEG_CADEMB.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WEG_CADEMB', VS_strCodEmp);
      qryWEG_CADEMB.Post;
    End;
    tblCans.Next;
  End;
  tblCans.Close;
  FreeAndNil(tblCans);
end;

function TWegDinamica.fDiretorioValido: Boolean;
begin
  Result := True;
  If (Not FileExists(strPatDbf + '\PRODUCTS.DBF')) Then
    Result := False;
end;

function TWegDinamica.fVerificaCadBas: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryWEG_CADBAS.IsEmpty) and (fVerificaCadBasConfig);
end;

function TWegDinamica.fVerificaCadCol: Boolean;
begin
  pAtualizaTabelas;
  Result := Not qryWEG_CADCOL.IsEmpty;
end;

function TWegDinamica.fVerificaCadBasConfig: Boolean;
  Var
    qryGen  : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM WEG_CADBAS WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;


function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  Var
    intCont1  : Integer;
    intCont2  : Integer;
    qryCadBas : TUniQuery;
    qryCadWeg : TUniQuery;

begin
  qryCadWeg := fCriaQuery;
  qryCadWeg.SQL.Text := 'SELECT * FROM WEG_CADWEG LIMIT 0';
  qryCadWeg.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * '+
                        '  FROM WEG_CADBAS '+
                        ' WHERE BAS_BASE__ = :BASE '+
                        '   AND BAS_PROKEY = :PROKEY '+
                        '   AND BAS_SUBKEY = :SUBKEY';

  qryCadBas.ParamByName('BASE').AsString   := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryCadBas.ParamByName('PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryCadBas.ParamByName('SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;

  qryCadBas.Open;

  pRemoveCadWegNfm(qryNfm.FieldByName('NFM_CODPRO').AsString);

  For intCont1 := 1 To qryCadBas.RecordCount Do
  Begin
    qryCadWeg.Insert;
    qryCadWeg.FieldByName('WEG_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadWeg.FieldByName('WEG_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadWeg.FieldByName('WEG_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadWeg.FieldByName('WEG_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
    qryCadWeg.FieldByName('WEG_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;

    qryCadWeg.FieldByName('WEG_NOMCOR').AsString := qryNfm.FieldByName('NFM_NOMCOR').AsString;

    qryCadWeg.FieldByName('WEG_CODEMP').AsString := VS_strCodEmp;
    qryCadWeg.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WEG_CADWEG',VS_strCodEmp);
    qryCadWeg.FieldByName('WEG_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryCadWeg.FieldByName('WEG_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryCadWeg.FieldByName('WEG_PROKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
    qryCadWeg.FieldByName('WEG_SUBKEY').AsString := qryNfm.FieldByName('NFM_SUBKEY').AsString;
    qryCadWeg.FieldByName('WEG_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intCont2 := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString) Then
        Break;

      qryCadWeg.FieldByName('WEG_FORM' + fStrZero(intCont2, 2)).AsString := qryNfm.FieldByName('NFM_COL0' + fStrZero(intCont2, 2)).AsString;
      qryCadWeg.FieldByName('WEG_QTDB' + fStrZero(intCont2, 2)).AsFloat :=
                                  fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + fStrZero(intCont2, 2)).AsFloat,
                                  qryNfm.FieldByName('NFM_UNIDAD').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString)
    End;

    qryCadWeg.Post;
    qryCadBas.Next;

  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadWeg);
  Result := True;
end;

function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: TUniQuery;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM  WEG_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;

  FreeAndNil(qryGen);
end;

procedure pRemoveCadWegNfm(CodPro : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text :=  'DELETE '+
                      '  FROM WEG_CADWEG '+
                      ' WHERE WEG_CODIGO = :CODPRO ';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

function fRetProxCodSeq: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT WEG_CODSEQ '+
                     '  FROM WEG_CADWEG '+
                     ' ORDER BY WEG_CODSEQ '+
                     '  DESC LIMIT 1;';
  qryGen.Open;
  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('WEG_CODSEQ').AsInteger + 1;
  FreeAndNil(qryGen);
End;

constructor TWegNfm.Create(AOwner: TComponent);
begin
  NomeTinta := 'Weg';
  inherited;
end;

function TWegNfm.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadWeg: TUniQuery;
    qryCadBas: TUniQuery;
    intProSeq: Integer;
    intCont: Integer;
begin
  {**************************************************}
  {* REMOVENDO NOVAS FORMULAS DO CADASTRO DE TINTAS *}
  {***********************************************PH*}
  pRegistraAcao('Removendo novas formulas do cadastro de tintas...');

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE '+
                     '  FROM WEG_CADWEG '+
                     ' WHERE WEG_CODIGO IN (SELECT NFM_CODPRO FROM WEG_CADNFM);';
  qryGen.ExecSQL;
  pRegistraAcao('Novas formulas removidas com sucesso!');

  {*******************************************}
  {* CADASTRO DE NOVAS FORMULAS              *}
  {****************************************PH*}
  qryGen.SQL.Text := 'SELECT * FROM WEG_CADNFM;';
  qryGen.Open;

  {*******************************************}
  {* CADASTRO DE TINTAS                      *}
  {****************************************PH*}
  qryCadWeg := fCriaQuery(Self);
  qryCadWeg.SQL.Text := 'SELECT * FROM WEG_CADWEG WHERE FALSE';
  qryCadWeg.Open;

  qryCadBas := fCriaQuery(Self);

  intProSeq := fRetProxCodSeq;

  TTintadeMaquina.fAjustaInicialAutoIncremento('WEG_CADWEG', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin

    qryCadBas.Close;
    qryCadBas.SQL.Text := 'SELECT * '+
                          '  FROM WEG_CADBAS '+
                          ' WHERE BAS_BASE__ = :BASE '+
                          '   AND BAS_PROKEY = :PROKEY '+
                          '   AND BAS_SUBKEY = :SUBKEY';

    qryCadBas.ParamByName('BASE').AsString   := qryGen.FieldByName('NFM_BASE__').AsString;
    qryCadBas.ParamByName('PROKEY').AsString := qryGen.FieldByName('NFM_PROKEY').AsString;
    qryCadBas.ParamByName('SUBKEY').AsString := qryGen.FieldByName('NFM_SUBKEY').AsString;
    qryCadBas.Open;
    qryCadBas.First;


    While Not qryCadBas.Eof Do
    Begin
      qryCadWeg.Insert;
      qryCadWeg.FieldByName('WEG_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString + ' ' + qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadWeg.FieldByName('WEG_CODIGO').AsString := qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadWeg.FieldByName('WEG_CODIG2').AsString := qryGen.FieldByName('NFM_CODPRO').AsString;
      qryCadWeg.FieldByName('WEG_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
      qryCadWeg.FieldByName('WEG_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
      qryCadWeg.FieldByName('WEG_CODEMP').AsString := VS_strCodEmp;
      qryCadWeg.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WEG_CADWEG',VS_strCodEmp);
      qryCadWeg.FieldByName('WEG_CODSEQ').AsString := fStrZero(intProSeq, 6);
      qryCadWeg.FieldByName('WEG_BASE__').AsString := qryGen.FieldByName('NFM_BASE__').AsString;
      qryCadWeg.FieldByName('WEG_PROKEY').AsString := qryGen.FieldByName('NFM_PROKEY').AsString;
      qryCadWeg.FieldByName('WEG_SUBKEY').AsString := qryGen.FieldByName('NFM_SUBKEY').AsString;
      qryCadWeg.FieldByName('WEG_NOMCOR').AsString := qryGen.FieldByName('NFM_NOMCOR').AsString;

      For intCont := 1 To 10 Do
      Begin
        If fEmptyStr(qryGen.FieldByName('NFM_COL0' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadWeg.FieldByName('WEG_FORM' + fStrZero(intCont, 2)).AsString := qryGen.FieldByName('NFM_COL0' + fStrZero(intCont, 2)).AsString;
        qryCadWeg.FieldByName('WEG_QTDB' + fStrZero(intCont, 2)).AsFloat :=
                                    fConverteQtdEmb(qryGen.FieldByName('NFM_QTD0' + fStrZero(intCont, 2)).AsFloat,
                                    qryGen.FieldByName('NFM_UNIDAD').AsString,
                                    qryCadBas.FieldByName('BAS_UNIDAD').AsString)
      End;
      qryCadWeg.Post;
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
