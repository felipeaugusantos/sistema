unit untAnnettaNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs,
  ADODB, DB, ComObj, Math;

Type
  TCadBase = Record
    strCodigo: String;
    strDescri: String;
End;

Type
  TAnnettaDinamica = class(TTintadeMaquina)
  private
    strPathTD3: String;
    strPathTD4: String;
    strPathMain: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadAnn: Boolean;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadEmb: Boolean;

    function fStrToFloatAnnetta(strValorUnico: String): Double;    

  public
    function fProcessarArquivos(intOpcao: Integer): Boolean;
    function fGravarNovasFormulas: Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  End;

  procedure pDeletaNovaFormula(strCodigo: String);
  function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
  function fRetProximoCodSeq: Integer;
  function fRetCodEmbalagem(strCodEmbOrigem: String; strUniDes: String): String;

implementation

uses untFuncoesSimples, SysUtils,  StrUtils, untFuncTinta,
    untModuloTinta;



{ TAnnettaDinamica }

constructor TAnnettaDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPathTD3  := fGetConfTinta('ANN').fGet('TXTTD3');
  strPathTD4  := fGetConfTinta('ANN').fGet('TXTTD4');
  strPathMain := fGetConfTinta('ANN').fGet('TXTMAI');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM ANN_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM ANN_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM ANN_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM ANN_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TAnnettaDinamica.Destroy;
begin
  qryCadBas.Free;
  qryCadEmb.Free;
  qryCadCol.Free;
  qryCadUni.Free;
  inherited;
end;

function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
   Var
    qryGen: TUniQuery;
    intCont: Integer;
    intUnidade: Integer;
    blnGerUnids: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1, 4, 20);

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryGen.Params.Count - 1 Do
    Begin
      qryGen.Params.Items[i].Value := Null;
    End;
  End;
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM ANN_CADANN WHERE ANN_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO ANN_CADANN ');
  qryGen.SQL.Add('             (ANN_CODSEQ, ');
  qryGen.SQL.Add('              ANN_CODEMP, ');
  qryGen.SQL.Add('              ANN_DESCRI, ');
  qryGen.SQL.Add('              ANN_CODIGO, ');
  qryGen.SQL.Add('              ANN_UNIDAD, ');
  qryGen.SQL.Add('              ANN_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              ANN_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              ANN_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              ANN_CODEMB, ');
  qryGen.SQL.Add('              ANN_CODUNI, ');
  qryGen.SQL.Add('              ANN_PRODUT, ');
  qryGen.SQL.Add('              ANN_DTACAD, ');
  qryGen.SQL.Add('              ANN_MD5KEY) ');
  qryGen.SQL.Add(' VALUES (:CODSEQ, ');
  qryGen.SQL.Add('         :CODEMP, ');
  qryGen.SQL.Add('         :DESCRI, ');
  qryGen.SQL.Add('         :CODIGO, ');
  qryGen.SQL.Add('         :UNIDAD, ');
  qryGen.SQL.Add('         :CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('         :FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('         :QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('         :AUTOINCREM, ');
  qryGen.SQL.Add('         :CODEMB, ');
  qryGen.SQL.Add('         :CODUNI, ');
  qryGen.SQL.Add('         :PRODUT, ');
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :MD5KEY); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnidade := 1 To 3 Do
  Begin
    Limpar;

    qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryGen.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnidade]);

    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ANN_CADANN', VS_strCodEmp);

    If blnGerUnids Then
    Begin
      qryGen.ParamByName('CODEMB').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('CODEMB').AsString :=
        fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnidade]);
    End;

    qryGen.ParamByName('CODUNI').AsString := qryGen.ParamByName('UNIDAD').AsString;

    For intCont := 1 To 10 Do
    Begin
      If Not fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
      Begin
        qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
        qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * Iif(blnGerUnids, 1, arrFator[intUnidade]);
      End;
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString +
                                              qryGen.ParamByName('PRODUT').AsString);

    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function TAnnettaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadAnn: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1, 4, 20);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM ANN_CADANN WHERE ANN_CODIGO IN (SELECT NFM_CODIGO FROM ANN_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM ANN_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN ANN_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadAnn := fCriaQuery(Self);
  qryCadAnn.SQL.Text := 'SELECT * FROM ANN_CADANN WHERE FALSE';
  qryCadAnn.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('ANN_CADANN', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadAnn.Insert;

      qryCadAnn.FieldByName('ANN_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadAnn.FieldByName('ANN_CODEMP').AsString := VS_strCodEmp;
      qryCadAnn.FieldByName('ANN_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadAnn.FieldByName('ANN_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadAnn.FieldByName('ANN_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadAnn.FieldByName('ANN_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;
      qryCadAnn.FieldByName('ANN_PRODUT').AsString := qryGen.FieldByName('NFM_DESPRO').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadAnn.FieldByName('ANN_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        qryCadAnn.FieldByName('ANN_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IIF(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadAnn.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANN_CADANN', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadAnn.FieldByName('ANN_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadAnn.FieldByName('ANN_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadAnn.FieldByName('ANN_CODUNI').AsString := qryCadAnn.FieldByName('ANN_UNIDAD').AsString;
      qryCadAnn.FieldByName('ANN_MD5KEY').AsString := GetMD5(qryCadAnn.FieldByName('ANN_DESCRI').AsString +
                                                        qryCadAnn.FieldByName('ANN_CODIGO').AsString +
                                                        qryCadAnn.FieldByName('ANN_UNIDAD').AsString +
                                                        qryCadAnn.FieldByName('ANN_CODBAS').AsString +
                                                        qryCadAnn.FieldByName('ANN_CODEMB').AsString +
                                                        qryCadAnn.FieldByName('ANN_CODUNI').AsString +
                                                        qryCadAnn.FieldByName('ANN_PRODUT').AsString);

      qryCadAnn.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TAnnettaDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadAnn;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TAnnettaDinamica.fProcessarArquivos');
    End;
  end;
end;

function TAnnettaDinamica.fProcessarCadBas: Boolean;
  Var
    olePlanilha, oleSheet: OleVariant;
    intLinha, intUltLinha: Integer;
    blnFimPlan: Boolean;
    qryCadbas: TUniQuery;
    intUnid: Integer;
    intCont: Integer;
    intFolha: Integer;
    intContReg: Integer;
    intTotLin: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');

  function fContaLinhas(intFolha: Integer): Integer;
  Begin
    oleSheet := olePlanilha.WorkSheets[intFolha];

    Result := 2;
    blnFimPlan := False;

    While not blnFimPlan Do
    Begin
      Inc(Result);
      If fEmptyStr(oleSheet.Cells[Result, 1].Text) Then
      Begin
        blnFimPlan := True;
        Dec(Result);
      end;
    end;
  End;
begin
  Try
    For intCont := 1 to 2 Do
    Begin
      Try
        intContReg := 0;
        qryCadBas := fCriaQuery();

        olePlanilha := CreateOleObject('Excel.Application');
        olePlanilha.Visible := False;

        If intCont = 1 Then
        Begin
          olePlanilha.WorkBooks.Open(strPathTD3);
          pRegistraAcao('Processando cadastro de bases - Arquivo TD3...');
        End
        Else
        Begin
          olePlanilha.WorkBooks.Open(strPathTD4);
          pRegistraAcao('Processando cadastro de bases - Arquivo TD4...');
        End;

        {*******************************************}
        {* CONTAR TOTAL DE LINHAS DO ARQUIVO       *}
        {****************************************NC*}
        intTotLin := 0;
        For intFolha := 1 to olePlanilha.WorkSheets.Count do
          intTotLin := intTotLin + fContaLinhas(intFolha) - 1; // -1 da linha do título

        For intFolha := 1 to olePlanilha.WorkSheets.Count do
        Begin
          oleSheet := olePlanilha.WorkSheets[intFolha];

          intUltLinha := fContaLinhas(intFolha);

          qryCadbas.Close;
          qryCadbas.SQL.Clear;
          qryCadbas.SQL.Add(' SELECT * FROM ANN_CADBAS');
          qryCadbas.Open;

          For intLinha := 2 to intUltLinha do
          Begin
            Inc(intContReg);
            If Not qryCadBas.Locate('BAS_BASE__;BAS_DESCRI', VarArrayOf([oleSheet.Cells[intLinha, 3].Text, AnsiUpperCase(oleSheet.Name)]), []) Then
            Begin
              for intUnid := 1 to 3 Do
              Begin
                qryCadbas.Insert;
                qryCadbas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANN_CADBAS', VS_strCodEmp);
                qryCadbas.FieldByName('BAS_BASE__').AsString := oleSheet.Cells[intLinha, 3].Text;
                qryCadbas.FieldByName('BAS_DESCRI').AsString := AnsiUpperCase(oleSheet.Name);
                qryCadbas.FieldByName('BAS_UNIDAD').AsString := arrUnid[intUnid];
                qryCadbas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
                qryCadbas.FieldByName('BAS_PRECUS').AsFloat  := 0.00;
                qryCadbas.FieldByName('BAS_PREVEN').AsFloat  := 0.00;
                qryCadbas.FieldByName('BAS_MARGEM').AsFloat  := 0.00;
                qryCadBas.Post;
              End;
            End;

            pRegistraProgresso(0, intContReg, intTotLin);

          End;
        End;
        pRegistraAcao('Cadastro de bases processado com sucesso!');
        Result := True;
      Finally
        If Assigned(qryCadBas) Then
          FreeAndNil(qryCadBas);

        If Not VarIsEmpty(olePlanilha) Then
        Begin
          olePlanilha.Quit;
          olePlanilha := Unassigned;
          oleSheet := Unassigned;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAnnettaNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TAnnettaDinamica.fProcessarCadCol: Boolean;
  Var
    qryAdoCadCol: TADOQuery;
    qryCadCol: TUniQuery;
begin
  Try
    qryAdoCadCol := TADOQuery.Create(Nil);

    qryAdoCadCol.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPathMain +
      ';Persist Security Info=True';

    qryAdoCadCol.SQL.Add(' SELECT ');
    qryAdoCadCol.SQL.Add('   Code,');
    qryAdoCadCol.SQL.Add('   Description');
    qryAdoCadCol.SQL.Add(' FROM Components ');
    qryAdoCadCol.SQL.Add(' ORDER BY Code ');
    qryAdoCadCol.Open;

    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Add(' INSERT INTO ANN_CADCOL ');
    qryCadCol.SQL.Add('             (AUTOINCREM, ');
    qryCadCol.SQL.Add('              COL_CODCOL, ');
    qryCadCol.SQL.Add('              COL_DESCRI, ');
    qryCadCol.SQL.Add('              COL_CODEMP) ');
    qryCadCol.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadCol.SQL.Add('         :COL_CODCOL, ');
    qryCadCol.SQL.Add('         :COL_DESCRI, ');
    qryCadCol.SQL.Add('         :COL_CODEMP);');

    pRegistraAcao('Processando cadastro de colorantes...');
    While Not qryAdoCadCol.Eof Do
    Begin
      qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ANN_CADCOL', VS_strCodEmp);
      qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCadCol.FieldByName('Code').AsString;
      qryCadCol.ParamByName('COL_DESCRI').AsString := AnsiUpperCase(qryAdoCadCol.FieldByName('Description').AsString);
      qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;

      Try
        qryCadCol.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Colorante %s já está cadastrado.',
            [qryAdoCadCol.FieldByName('Description').AsString]))
          Else
            Raise;
        End;
      End;

      qryAdoCadCol.Next;
      pRegistraProgresso(0, qryAdoCadCol.RecNo, qryAdoCadCol.RecordCount);
    End;
    pRegistraAcao('Cadastro de colorantes processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAnnettaNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TAnnettaDinamica.fProcessarCadEmb: Boolean;
  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM ANN_CADEMB';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  Var
    qryCadEmb: TUniQuery;
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrQtde: Array[1..3] Of Double = (900, 3600, 18000);
begin
  Try
    pDeletaRegistros;

    qryCadEmb := fCriaQuery();
    Try
      qryCadEmb.SQL.Add(' INSERT INTO ANN_CADEMB ');
      qryCadEmb.SQL.Add('             (AUTOINCREM, ');
      qryCadEmb.SQL.Add('              EMB_CODEMB, ');
      qryCadEmb.SQL.Add('              EMB_CODEMP, ');
      qryCadEmb.SQL.Add('              EMB_QTDEMB, ');
      qryCadEmb.SQL.Add('              EMB_UNIDAD) ');
      qryCadEmb.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadEmb.SQL.Add('         :EMB_CODEMB, ');
      qryCadEmb.SQL.Add('         :EMB_CODEMP, ');
      qryCadEmb.SQL.Add('         :EMB_QTDEMB, ');
      qryCadEmb.SQL.Add('         :EMB_UNIDAD); ');

      pRegistraAcao('Processando cadastro de embalagens...');

      For intUnid := 1 to 3 Do
      Begin
        qryCadEmb.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ANN_CADEMB', VS_strCodEmp);
        qryCadEmb.ParamByName('EMB_CODEMB').AsString := IntToStr(intUnid);
        qryCadEmb.ParamByName('EMB_CODEMP').AsString := VS_strCodEmp;
        qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := arrQtde[intUnid];
        qryCadEmb.ParamByName('EMB_UNIDAD').AsString := arrUnid[intUnid];

        qryCadEmb.ExecSQL;
        pRegistraProgresso(1, intUnid, 3);
      End;
    Finally
      FreeAndNil(qryCadEmb);
    End;

    pRegistraAcao('Cadastro de embalagens processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAnnettaNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TAnnettaDinamica.fProcessarCadAnn: Boolean;
  Var
    olePlanilha, oleSheet: OleVariant;
    intLinha, intUltLinha: Integer;
    blnFimPlan: Boolean;
    qryCadAnn: TUniQuery;
    intForm: Integer;
    intCodSeq,
    intUnid,
    intFolha,
    intCont,
    intContReg,
    intTotLin: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.9, 3.6, 18);

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(ANN_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM ANN_CADANN;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM ANN_CADANN';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadAnn.Params.Count - 1 Do
    Begin
      qryCadAnn.Params.Items[i].Value := Null;
    End;
  End;

  function fContaLinhas(intFolha: Integer): Integer;
  Begin
    oleSheet := olePlanilha.WorkSheets[intFolha];

    Result := 2;
    blnFimPlan := False;

    While not blnFimPlan Do
    Begin
      Inc(Result);
      If fEmptyStr(oleSheet.Cells[Result, 1].Text) Then
      Begin
        blnFimPlan := True;
        Dec(Result);
      end;
    end;
  End;
begin
  Try
    Result := False;
    pDeletaRegistros;

    intCodSeq := 0;
    For intCont := 1 to 2 Do
    Begin
      intContReg := 0;

      olePlanilha := CreateOleObject('Excel.Application');
      qryCadAnn := fCriaQuery();

      Try
        olePlanilha.Visible := False;
        If intCont = 1 Then
        Begin
          olePlanilha.WorkBooks.Open(strPathTD3);
          pRegistraAcao('Processando cadastro de Fórmulas - Arquivo TD3...');
        End
        Else
        Begin
          olePlanilha.WorkBooks.Open(strPathTD4);
          pRegistraAcao('Processando cadastro de Fórmulas - Arquivo TD4...');
        End;

        qryCadAnn.SQL.Add(' INSERT INTO ANN_CADANN ');
        qryCadAnn.SQL.Add('             (ANN_CODSEQ, ');
        qryCadAnn.SQL.Add('              ANN_CODEMP, ');
        qryCadAnn.SQL.Add('              ANN_DESCRI, ');
        qryCadAnn.SQL.Add('              ANN_CODIGO, ');
        qryCadAnn.SQL.Add('              ANN_UNIDAD, ');
        qryCadAnn.SQL.Add('              ANN_CODBAS, ');
        qryCadAnn.SQL.Add('              ANN_CODEMB, ');
        qryCadAnn.SQL.Add('              ANN_CODUNI, ');
        qryCadAnn.SQL.Add('              ANN_PRODUT, ');
        qryCadAnn.SQL.Add('              ANN_MD5KEY, ');

        For intForm := 1 To 5 Do
        Begin
          qryCadAnn.SQL.Add('            ANN_FORM' + fStrZero(intForm, 2) + ', ');
          qryCadAnn.SQL.Add('            ANN_QTDC' + fStrZero(intForm, 2) + ', ');
        End;

        qryCadAnn.SQL.Add('              AUTOINCREM) ');
        qryCadAnn.SQL.Add(' VALUES (:ANN_CODSEQ, ');
        qryCadAnn.SQL.Add('         :ANN_CODEMP, ');
        qryCadAnn.SQL.Add('         :ANN_DESCRI, ');
        qryCadAnn.SQL.Add('         :ANN_CODIGO, ');
        qryCadAnn.SQL.Add('         :ANN_UNIDAD, ');
        qryCadAnn.SQL.Add('         :ANN_CODBAS, ');
        qryCadAnn.SQL.Add('         :ANN_CODEMB, ');
        qryCadAnn.SQL.Add('         :ANN_CODUNI, ');
        qryCadAnn.SQL.Add('         :ANN_PRODUT, ');
        qryCadAnn.SQL.Add('         :ANN_MD5KEY, ');

        For intForm := 1 To 5 Do
        Begin
          qryCadAnn.SQL.Add('       :ANN_FORM' + fStrZero(intForm, 2) + ', ');
          qryCadAnn.SQL.Add('       :ANN_QTDC' + fStrZero(intForm, 2) + ', ');
        End;

        qryCadAnn.SQL.Add('         :AUTOINCREM); ');

        {*******************************************}
        {* CONTAR TOTAL DE LINHAS DO ARQUIVO       *}
        {****************************************NC*}
        intTotLin := 0;
        For intFolha := 1 to olePlanilha.WorkSheets.Count do
          intTotLin := intTotLin + fContaLinhas(intFolha) - 1; // -1 da linha do título

        For intFolha := 1 to olePlanilha.WorkSheets.Count do
        Begin
          oleSheet := olePlanilha.WorkSheets[intFolha];

          intUltLinha := fContaLinhas(intFolha);

          For intLinha := 2 to intUltLinha do
          Begin
            for intUnid := 1 to 3 Do
            Begin
              Limpar;

              Inc(intContReg);
              Inc(intCodSeq);
              qryCadAnn.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('ANN_CADANN', VS_strCodEmp);
              qryCadAnn.ParamByName('ANN_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
              qryCadAnn.ParamByName('ANN_CODEMP').AsString  := VS_strCodEmp;
              qryCadAnn.ParamByName('ANN_DESCRI').AsString  := AnsiUpperCase(oleSheet.Cells[intLinha, 2].Text);
              qryCadAnn.ParamByName('ANN_CODIGO').AsString  := oleSheet.Cells[intLinha, 1].Text;
              qryCadAnn.ParamByName('ANN_UNIDAD').AsString  := arrUnid[intUnid];
              qryCadAnn.ParamByName('ANN_CODUNI').AsString  := arrUnid[intUnid];
              qryCadAnn.ParamByName('ANN_CODBAS').AsString  := oleSheet.Cells[intLinha, 3].Text;
              qryCadAnn.ParamByName('ANN_CODEMB').AsString  := fRetCodEmbalagem('2',arrUnid[intUnid]);
              qryCadAnn.ParamByName('ANN_PRODUT').AsString  := AnsiUpperCase(oleSheet.Name);
              qryCadAnn.ParamByName('ANN_MD5KEY').AsString  := GetMD5(qryCadAnn.ParamByName('ANN_DESCRI').AsString +
                                                                 qryCadAnn.ParamByName('ANN_CODIGO').AsString +
                                                                 qryCadAnn.ParamByName('ANN_UNIDAD').AsString +
                                                                 qryCadAnn.ParamByName('ANN_CODBAS').AsString +
                                                                 qryCadAnn.ParamByName('ANN_CODEMB').AsString +
                                                                 qryCadAnn.ParamByName('ANN_CODUNI').AsString +
                                                                 qryCadAnn.ParamByName('ANN_PRODUT').AsString);

              {*******************************************}
              {* NA PLANILHA TEM UMA COLUNA COM INTEIRO  *}
              {* E OUTRA COM A PARTE FRACIONADA DA ONÇA  *}
              {****************************************NC*}
              If Not fEmptyStr(oleSheet.Cells[intLinha, 4].Text) and (oleSheet.Cells[intLinha, 4].Text <> 'S/N') Then
              Begin
                qryCadAnn.ParamByName('ANN_FORM01').AsString := oleSheet.Cells[intLinha, 4].Text;
                qryCadAnn.ParamByName('ANN_QTDC01').AsFloat  := RoundTo(((fStrToFloatAnnetta(oleSheet.Cells[intLinha, 5].Text) * 29.57) +
                  (fStrToFloatAnnetta(oleSheet.Cells[intLinha, 6].Text) * 0.61604)) * arrFator[intUnid] / 3.6, -3);
              End;
              If Not fEmptyStr(oleSheet.Cells[intLinha, 7].Text) and (oleSheet.Cells[intLinha, 7].Text <> 'S/N') Then
              Begin
                qryCadAnn.ParamByName('ANN_FORM02').AsString := oleSheet.Cells[intLinha, 7].Text;
                qryCadAnn.ParamByName('ANN_QTDC02').AsFloat  := RoundTo(((fStrToFloatAnnetta(oleSheet.Cells[intLinha, 8].Text) * 29.57) +
                  (fStrToFloatAnnetta(oleSheet.Cells[intLinha, 9].Text) * 0.61604)) * arrFator[intUnid] / 3.6, -3);
              End;
              If Not fEmptyStr(oleSheet.Cells[intLinha, 10].Text) and (oleSheet.Cells[intLinha, 10].Text <> 'S/N') Then
              Begin
                qryCadAnn.ParamByName('ANN_FORM03').AsString := oleSheet.Cells[intLinha, 10].Text;
                qryCadAnn.ParamByName('ANN_QTDC03').AsFloat  := RoundTo(((fStrToFloatAnnetta(oleSheet.Cells[intLinha, 11].Text) * 29.57) +
                  (fStrToFloatAnnetta(oleSheet.Cells[intLinha, 12].Text) * 0.61604)) * arrFator[intUnid] / 3.6, -3);
              End;
              If Not fEmptyStr(oleSheet.Cells[intLinha, 13].Text) and (oleSheet.Cells[intLinha, 13].Text <> 'S/N') Then
              Begin
                qryCadAnn.ParamByName('ANN_FORM04').AsString := oleSheet.Cells[intLinha, 13].Text;
                qryCadAnn.ParamByName('ANN_QTDC04').AsFloat  := RoundTo(((fStrToFloatAnnetta(oleSheet.Cells[intLinha, 14].Text) * 29.57) +
                  (fStrToFloatAnnetta(oleSheet.Cells[intLinha, 15].Text) * 0.61604)) * arrFator[intUnid] / 3.6, -3);
              End;
              If Not fEmptyStr(oleSheet.Cells[intLinha, 16].Text) and (oleSheet.Cells[intLinha, 16].Text <> 'S/N') Then
              Begin
                qryCadAnn.ParamByName('ANN_FORM05').AsString := oleSheet.Cells[intLinha, 16].Text;
                qryCadAnn.ParamByName('ANN_QTDC05').AsFloat  := RoundTo(((fStrToFloatAnnetta(oleSheet.Cells[intLinha, 17].Text) * 29.57) +
                  (fStrToFloatAnnetta(oleSheet.Cells[intLinha, 18].Text) * 0.61604)) * arrFator[intUnid] / 3.6, -3);
              End;

              pRegistraProgresso(0, intContReg, intTotLin * 3);

              Try
                qryCadAnn.ExecSQL;
              Except
                On E: EUniError Do
                Begin
                  If E.ErrorCode = 1062 Then //DUPLICADO
                    pRegistraAcao(Format('Fórmula %s já está cadastrada.',
                    [oleSheet.Cells[intLinha, 1].Text + ' - ' + oleSheet.Cells[intLinha, 2].Text]))
                  Else
                    Raise;
                End;
              End;
            End;
          End;
        End;

        pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

        Result := True;
      Finally
        If Assigned(qryCadAnn) Then
          FreeAndNil(qryCadAnn);

        If Not VarIsEmpty(olePlanilha) Then
        Begin
          olePlanilha.Quit;
          olePlanilha := Unassigned;
          oleSheet := Unassigned;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAnnettaNova.fProcessarCadAnn]');
      Result := False;
    End;
  End;
end;

function TAnnettaDinamica.fStrToFloatAnnetta(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',','),0);
end;

function fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM ANN_CADEMB WHERE EMB_QTDEMB IN (900, 3600, 18000)';
  qryGen.Open;

  If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
  Begin
    Result := qryGen.FieldByName('EMB_CODEMB').AsString;
  End
  Else
    Result := strCodEmbOrigem;

  FreeAndNil(qryGen);
end;

function fRetProximoCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
   qryGen := fCriaQuery(nil);

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(ANN_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM ANN_CADANN;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ANN_CADANN WHERE ANN_CODIGO = :CODIGO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ExecSQL;
    Close;
  End;
end;

end.
