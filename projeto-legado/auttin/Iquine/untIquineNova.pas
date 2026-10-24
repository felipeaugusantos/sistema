unit untIquineNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs,
  ADODB,  DB;

Type
  TIquineDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadIqu: Boolean;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadEmb: Boolean;

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

uses untFuncoesSimples, SysUtils, StrUtils, untFuncTinta,
  untModuloTinta;



{ TIquineDinamica }

constructor TIquineDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('IQU').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM IQU_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM IQU_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM IQU_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM IQU_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TIquineDinamica.Destroy;
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
    intUnid: Integer;
    blnGerUnids: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.8, 3.2, 16);
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM IQU_CADIQU WHERE IQU_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO IQU_CADIQU ');
  qryGen.SQL.Add('             (IQU_CODSEQ, ');
  qryGen.SQL.Add('              IQU_CODEMP, ');
  qryGen.SQL.Add('              IQU_DESCRI, ');
  qryGen.SQL.Add('              IQU_CODIGO, ');
  qryGen.SQL.Add('              IQU_UNIDAD, ');
  qryGen.SQL.Add('              IQU_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              IQU_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              IQU_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              IQU_CODEMB, ');
  qryGen.SQL.Add('              IQU_CODUNI, ');
  qryGen.SQL.Add('              IQU_MD5KEY, ');
  qryGen.SQL.Add('              IQU_DTACAD, ');
  qryGen.SQL.Add('              IQU_PRODUT) ');
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
  qryGen.SQL.Add('         :MD5KEY, ');
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :PRODUT); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnid := 1 To 3 Do
  Begin
    qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);

    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('IQU_CADIQU', VS_strCodEmp);

    If blnGerUnids Then
    Begin
      qryGen.ParamByName('CODEMB').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('CODEMB').AsString :=
        fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
    End;

    qryGen.ParamByName('CODUNI').AsString := qryGen.ParamByName('UNIDAD').AsString;

    For intCont := 1 To 10 Do
    Begin
      qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      If intUnid = 1 Then
        qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat
      Else
        qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrFator[intUnid];
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString );

    qryGen.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;
    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function TIquineDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadIqu: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.8, 3.2, 16);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM IQU_CADIQU WHERE IQU_CODIGO IN (SELECT NFM_CODIGO FROM IQU_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM IQU_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN IQU_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_PRODUT ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadIqu := fCriaQuery(Self);
  qryCadIqu.SQL.Text := 'SELECT * FROM IQU_CADIQU WHERE FALSE';
  qryCadIqu.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('IQU_CADIQU', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadIqu.Insert;

      qryCadIqu.FieldByName('IQU_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadIqu.FieldByName('IQU_CODEMP').AsString := VS_strCodEmp;
      qryCadIqu.FieldByName('IQU_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadIqu.FieldByName('IQU_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadIqu.FieldByName('IQU_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadIqu.FieldByName('IQU_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadIqu.FieldByName('IQU_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        If intUnid = 1 Then
          qryCadIqu.FieldByName('IQU_QTDC' + fStrZero(intCont, 2)).AsFloat :=
            qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat
        Else
          qryCadIqu.FieldByName('IQU_QTDC' + fStrZero(intCont, 2)).AsFloat :=
            qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IIF(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadIqu.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('IQU_CADIQU', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadIqu.FieldByName('IQU_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadIqu.FieldByName('IQU_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadIqu.FieldByName('IQU_CODUNI').AsString := qryCadIqu.FieldByName('IQU_UNIDAD').AsString;
      qryCadIqu.FieldByName('IQU_MD5KEY').AsString := GetMD5(qryCadIqu.FieldByName('IQU_DESCRI').AsString +
                                                        qryCadIqu.FieldByName('IQU_CODIGO').AsString +
                                                        qryCadIqu.FieldByName('IQU_UNIDAD').AsString +
                                                        qryCadIqu.FieldByName('IQU_CODBAS').AsString +
                                                        qryCadIqu.FieldByName('IQU_CODEMB').AsString +
                                                        qryCadIqu.FieldByName('IQU_CODUNI').AsString );

      qryCadIqu.FieldByName('IQU_PRODUT').AsString := qryGen.FieldByName('NFM_DESPRO').AsString;

      qryCadIqu.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TIquineDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadIqu;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TIquineDinamica.fProcessarArquivos');
    End;
  end;
end;

function TIquineDinamica.fProcessarCadBas: Boolean;
  Var
    qryAdoCadBas: TADOQuery;
    qryCadbas: TUniQuery;
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
begin
  Try
    qryAdoCadBas := TADOQuery.Create(Nil);

    qryAdoCadBas.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadBas.SQL.Add(' SELECT ');
    qryAdoCadBas.SQL.Add('    TBLBASE.COD_BASE,  ');
    qryAdoCadBas.SQL.Add('    TBLBASE.NOME_BASE, ');
    qryAdoCadBas.SQL.Add('    TBLPRODUTO.NOME_PRODUTO ');
    qryAdoCadBas.SQL.Add('  FROM TBLRELPRODUTOBASE,          ');
    qryAdoCadBas.SQL.Add('       TBLPRODUTO,                 ');
    qryAdoCadBas.SQL.Add('       TBLBASE                     ');
    qryAdoCadBas.SQL.Add(' WHERE TBLRELPRODUTOBASE.COD_PRODUTO = TBLPRODUTO.COD_PRODUTO ');
    qryAdoCadBas.SQL.Add('   AND TBLRELPRODUTOBASE.COD_BASE    = TBLBASE.COD_BASE ');

    qryAdoCadBas.SQL.Add(' ORDER BY TBLRELPRODUTOBASE.COD_PRODUTO ');
    qryAdoCadBas.Open;

    qryCadbas := fCriaQuery();
    qryCadbas.SQL.Add(' INSERT INTO IQU_CADBAS ');
    qryCadbas.SQL.Add('             (AUTOINCREM, ');
    qryCadbas.SQL.Add('              BAS_BASE__, ');
    qryCadbas.SQL.Add('              BAS_DESCRI, ');
    qryCadbas.SQL.Add('              BAS_UNIDAD, ');
    qryCadbas.SQL.Add('              BAS_CODEMP, ');
    qryCadbas.SQL.Add('              BAS_PRECUS, ');
    qryCadbas.SQL.Add('              BAS_PREVEN, ');
    qryCadbas.SQL.Add('              BAS_MARGEM, ');
    qryCadbas.SQL.Add('              BAS_PRODUT) ');
    qryCadbas.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadbas.SQL.Add('         :BAS_BASE__, ');
    qryCadbas.SQL.Add('         :BAS_DESCRI, ');
    qryCadbas.SQL.Add('         :BAS_UNIDAD, ');
    qryCadbas.SQL.Add('         :BAS_CODEMP, ');
    qryCadbas.SQL.Add('         :BAS_PRECUS, ');
    qryCadbas.SQL.Add('         :BAS_PREVEN, ');
    qryCadbas.SQL.Add('         :BAS_MARGEM, ');
    qryCadbas.SQL.Add('         :BAS_PRODUT); ');

    pRegistraAcao('Processando cadastro de bases...');
    While Not qryAdoCadBas.Eof Do
    Begin
      for intUnid := 1 to 3 do
      begin
        qryCadbas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('IQU_CADBAS', VS_strCodEmp);
        qryCadbas.ParamByName('BAS_BASE__').AsString := qryAdoCadBas.FieldByName('COD_BASE').AsString;
        qryCadbas.ParamByName('BAS_DESCRI').AsString := qryAdoCadBas.FieldByName('NOME_BASE').AsString;
        qryCadbas.ParamByName('BAS_UNIDAD').AsString := arrUnid[intUnid];
        qryCadbas.ParamByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadbas.ParamByName('BAS_PRECUS').AsFloat  := 0.00;
        qryCadbas.ParamByName('BAS_PREVEN').AsFloat  := 0.00;
        qryCadbas.ParamByName('BAS_MARGEM').AsFloat  := 0.00;
        qryCadbas.ParamByName('BAS_PRODUT').AsString := qryAdoCadBas.FieldByName('NOME_PRODUTO').AsString;

        Try
          qryCadbas.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Base %s já está cadastrada',
              [qryAdoCadBas.FieldByName('COD_BASE').AsString]))
            Else
              Raise;
          End;
        End;
      End;
      qryAdoCadBas.Next;
      pRegistraProgresso(0, qryAdoCadBas.RecNo, qryAdoCadBas.RecordCount);
    end;
    pRegistraAcao('Cadastro de bases processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TIquineNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TIquineDinamica.fProcessarCadCol: Boolean;
  Var
    qryAdoCadCol: TADOQuery;
    qryCadCol: TUniQuery;
begin
  Try
    qryAdoCadCol := TADOQuery.Create(Nil);

    qryAdoCadCol.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadCol.SQL.Add(' SELECT ');
    qryAdoCadCol.SQL.Add('   SNOME_CORANTE ');
    qryAdoCadCol.SQL.Add(' FROM TBLCORANTE ');
    qryAdoCadCol.SQL.Add(' ORDER BY SNOME_CORANTE ');
    qryAdoCadCol.Open;

    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Add(' INSERT INTO IQU_CADCOL ');
    qryCadCol.SQL.Add('             (AUTOINCREM, ');
    qryCadCol.SQL.Add('              COL_CODCOL, ');
    qryCadCol.SQL.Add('              COL_EMBALA, ');
    qryCadCol.SQL.Add('              COL_CODEMP) ');
    qryCadCol.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadCol.SQL.Add('         :COL_CODCOL, ');
    qryCadCol.SQL.Add('         :COL_EMBALA, ');
    qryCadCol.SQL.Add('         :COL_CODEMP);');

    pRegistraAcao('Processando cadastro de colorantes...');
    While Not qryAdoCadCol.Eof Do
    Begin
      qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('IQU_CADCOL', VS_strCodEmp);
      qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCadCol.FieldByName('SNOME_CORANTE').AsString;
      qryCadCol.ParamByName('COL_EMBALA').AsFloat  := 800;
      qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;

      Try
        qryCadCol.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Colorante %s já está cadastrado.',
            [qryAdoCadCol.FieldByName('SNOME_CORANTE').AsString]))
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
      pMensagensErro(E.Message, '[TIquineNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TIquineDinamica.fProcessarCadEmb: Boolean;
  Var
    qryAdoCadEmb: TADOQuery;
    qryCadEmb: TUniQuery;
begin
  Try
    qryAdoCadEmb := TADOQuery.Create(Nil);

    qryAdoCadEmb.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadEmb.SQL.Add(' SELECT ');
    qryAdoCadEmb.SQL.Add('   COD_EMBALAGEM, ');
    qryAdoCadEmb.SQL.Add('   NOME_EMBALAGEM, ');
    qryAdoCadEmb.SQL.Add('   TAMANHO_EMBALAGEM ');
    qryAdoCadEmb.SQL.Add(' FROM TBLEMBALAGEM ');
    qryAdoCadEmb.SQL.Add(' ORDER BY COD_EMBALAGEM ');
    qryAdoCadEmb.Open;

    qryCadEmb := fCriaQuery();
    qryCadEmb.SQL.Add(' INSERT INTO IQU_CADEMB ');
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
    While Not qryAdoCadEmb.Eof Do
    Begin
      qryCadEmb.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('IQU_CADEMB', VS_strCodEmp);
      qryCadEmb.ParamByName('EMB_CODEMB').AsString := qryAdoCadEmb.FieldByName('COD_EMBALAGEM').AsString;
      qryCadEmb.ParamByName('EMB_CODEMP').AsString := VS_strCodEmp;
      qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := qryAdoCadEmb.FieldByName('TAMANHO_EMBALAGEM').AsFloat;
      If UpperCase(qryAdoCadEmb.FieldByName('NOME_EMBALAGEM').AsString) = 'QUARTO' Then
        qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'LT'
      Else If UpperCase(qryAdoCadEmb.FieldByName('NOME_EMBALAGEM').AsString) = 'GALAO' Then
        qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'GL'
      Else
        qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'LA';

      Try
        qryCadEmb.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Embalagem %s já está cadastrada.',
            [qryAdoCadEmb.FieldByName('COD_EMBALAGEM').AsString]))
          Else
            Raise;
        End;
      End;

      qryAdoCadEmb.Next;
      pRegistraProgresso(0, qryAdoCadEmb.RecNo, qryAdoCadEmb.RecordCount);
    End;
    pRegistraAcao('Cadastro de embalagens processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TIquineNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TIquineDinamica.fProcessarCadIqu: Boolean;
  Var
    qryAdoCadIqu: TADOQuery;
    qryCadIqu: TUniQuery;
    intForm: Integer;
    intCodForm,
    intCodSeq,
    intUnid: Integer;
    bkmPosicao: TBookMark;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Integer = (1, 4, 20);

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(IQU_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM IQU_CADIQU;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM IQU_CADIQU';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadIqu.Params.Count - 1 Do
    Begin
      qryCadIqu.Params.Items[i].Value := Null;
    End;
  End;
begin
  Try
    pDeletaRegistros;

    bkmPosicao := nil;
    
    qryAdoCadIqu := TADOQuery.Create(Nil);

    qryAdoCadIqu.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadIqu.SQL.Add(' SELECT ');
    qryAdoCadIqu.SQL.Add('   TBLRELFORMULACORANTE.COD_FORMULA, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA.COD_BASE, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA.NOME_COR, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA.COD_COLECAO, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA.COD_COR, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA.COR_FORMULA, ');
    qryAdoCadIqu.SQL.Add('   TBLCORANTE.SNOME_CORANTE, ');
    qryAdoCadIqu.SQL.Add('   TBLRELFORMULACORANTE.QTD_CORANTE, ');
    qryAdoCadIqu.SQL.Add('   TBLPRODUTO.NOME_PRODUTO  ');
    qryAdoCadIqu.SQL.Add(' FROM TBLRELFORMULACORANTE, ');
    qryAdoCadIqu.SQL.Add('   TBLFORMULA, ');
    qryAdoCadIqu.SQL.Add('   TBLCORANTE, ');
    qryAdoCadIqu.SQL.Add('   TBLPRODUTO  ');
    qryAdoCadIqu.SQL.Add(' WHERE TBLRELFORMULACORANTE.COD_FORMULA = TBLFORMULA.COD_FORMULA ');
    qryAdoCadIqu.SQL.Add(' AND TBLCORANTE.COD_CORANTE = TBLRELFORMULACORANTE.COD_CORANTE ');
    qryAdoCadIqu.SQL.Add(' AND TBLPRODUTO.COD_PRODUTO = TBLFORMULA.COD_PRODUTO ');
    qryAdoCadIqu.SQL.Add(' ORDER BY TBLRELFORMULACORANTE.COD_FORMULA ');
    qryAdoCadIqu.Open;

    qryCadIqu := fCriaQuery();
    qryCadIqu.SQL.Add(' INSERT INTO IQU_CADIQU ');
    qryCadIqu.SQL.Add('             (IQU_CODSEQ, ');
    qryCadIqu.SQL.Add('              IQU_CODEMP, ');
    qryCadIqu.SQL.Add('              IQU_DESCRI, ');
    qryCadIqu.SQL.Add('              IQU_CODIGO, ');
    qryCadIqu.SQL.Add('              IQU_UNIDAD, ');
    qryCadIqu.SQL.Add('              IQU_CODBAS, ');
    qryCadIqu.SQL.Add('              IQU_CODEMB, ');
    qryCadIqu.SQL.Add('              IQU_CODUNI, ');
    qryCadIqu.SQL.Add('              IQU_CODCOL, ');
    qryCadIqu.SQL.Add('              IQU_CODCOR, ');
    qryCadIqu.SQL.Add('              IQU_CORFOR, ');
    qryCadIqu.SQL.Add('              IQU_MD5KEY, ');
    qryCadIqu.SQL.Add('              IQU_PRODUT, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadIqu.SQL.Add('            IQU_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadIqu.SQL.Add('            IQU_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadIqu.SQL.Add('              AUTOINCREM) ');
    qryCadIqu.SQL.Add(' VALUES (:IQU_CODSEQ, ');
    qryCadIqu.SQL.Add('         :IQU_CODEMP, ');
    qryCadIqu.SQL.Add('         :IQU_DESCRI, ');
    qryCadIqu.SQL.Add('         :IQU_CODIGO, ');
    qryCadIqu.SQL.Add('         :IQU_UNIDAD, ');
    qryCadIqu.SQL.Add('         :IQU_CODBAS, ');
    qryCadIqu.SQL.Add('         :IQU_CODEMB, ');
    qryCadIqu.SQL.Add('         :IQU_CODUNI, ');
    qryCadIqu.SQL.Add('         :IQU_CODCOL, ');
    qryCadIqu.SQL.Add('         :IQU_CODCOR, ');
    qryCadIqu.SQL.Add('         :IQU_CORFOR, ');
    qryCadIqu.SQL.Add('         :IQU_MD5KEY, ');
    qryCadIqu.SQL.Add('         :IQU_PRODUT, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadIqu.SQL.Add('       :IQU_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadIqu.SQL.Add('       :IQU_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadIqu.SQL.Add('         :AUTOINCREM); ');

    pRegistraAcao('Processando cadastro de Fórmulas...');

    intCodSeq := 0;
    While Not qryAdoCadIqu.Eof Do
    Begin
      bkmPosicao := qryAdoCadIqu.GetBookmark;

      for intUnid := 1 to 3 Do
      Begin
        Limpar;

        Inc(intCodSeq);
        intCodForm := qryAdoCadIqu.FieldByName('COD_FORMULA').AsInteger;

        qryCadIqu.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('IQU_CADIQU', VS_strCodEmp);
        qryCadIqu.ParamByName('IQU_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
        qryCadIqu.ParamByName('IQU_CODEMP').AsString  := VS_strCodEmp;
        qryCadIqu.ParamByName('IQU_DESCRI').AsString  := AnsiUpperCase(qryAdoCadIqu.FieldByName('NOME_COR').AsString);
        qryCadIqu.ParamByName('IQU_CODIGO').AsString  := qryAdoCadIqu.FieldByName('COD_FORMULA').AsString;
        qryCadIqu.ParamByName('IQU_UNIDAD').AsString  := arrUnid[intUnid];
        qryCadIqu.ParamByName('IQU_CODUNI').AsString  := arrUnid[intUnid];
        qryCadIqu.ParamByName('IQU_CODBAS').AsString  := qryAdoCadIqu.FieldByName('COD_BASE').AsString;
        qryCadIqu.ParamByName('IQU_CODEMB').AsString  := fRetCodEmbalagem('1',arrUnid[intUnid]);
        qryCadIqu.ParamByName('IQU_CODCOL').AsInteger := qryAdoCadIqu.FieldByName('COD_COLECAO').AsInteger;
        qryCadIqu.ParamByName('IQU_CODCOR').AsString  := qryAdoCadIqu.FieldByName('COD_COR').AsString;
        qryCadIqu.ParamByName('IQU_CORFOR').AsString  := qryAdoCadIqu.FieldByName('COR_FORMULA').AsString;
        qryCadIqu.ParamByName('IQU_PRODUT').AsString  := qryAdoCadIqu.FieldByName('NOME_PRODUTO').AsString;
        qryCadIqu.ParamByName('IQU_MD5KEY').AsString  := GetMD5(qryCadIqu.ParamByName('IQU_DESCRI').AsString +
                                                           qryCadIqu.ParamByName('IQU_CODIGO').AsString +
                                                           qryCadIqu.ParamByName('IQU_UNIDAD').AsString +
                                                           qryCadIqu.ParamByName('IQU_CODBAS').AsString +
                                                           qryCadIqu.ParamByName('IQU_CODEMB').AsString +
                                                           qryCadIqu.ParamByName('IQU_CODUNI').AsString +
                                                           IntToStr(qryCadIqu.ParamByName('IQU_CODCOL').AsInteger)+
                                                           qryCadIqu.ParamByName('IQU_CODCOR').AsString+
                                                           qryCadIqu.ParamByName('IQU_CORFOR').AsString);

        intForm := 1;

        While (intCodForm = qryAdoCadIqu.FieldByName('COD_FORMULA').AsInteger)
          And (Not qryAdoCadIqu.Eof) Do
        Begin
          qryCadIqu.ParamByName('IQU_FORM' + fStrZero(intForm, 2)).AsString := qryAdoCadIqu.FieldByName('SNOME_CORANTE').AsString;

          If intUnid = 1 Then
            qryCadIqu.ParamByName('IQU_QTDC' + fStrZero(intForm, 2)).AsFloat := strToFloatDef(AnsiReplaceStr(qryAdoCadIqu.FieldByName('QTD_CORANTE').AsString,'.',','),0)
          else
            qryCadIqu.ParamByName('IQU_QTDC' + fStrZero(intForm, 2)).AsFloat := (strToFloatDef(AnsiReplaceStr(qryAdoCadIqu.FieldByName('QTD_CORANTE').AsString,'.',','),0)) * arrFator[intUnid];

          qryAdoCadIqu.Next;
          intForm := intForm + 1;
          pRegistraProgresso(0, qryAdoCadIqu.RecNo, qryAdoCadIqu.RecordCount);
        End;

        Try
          qryCadIqu.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Fórmula %s já está cadastrada.',
              [qryAdoCadIqu.FieldByName('COD_FORMULA').AsString]))
            Else
              Raise;
          End;
        End;

        If intUnid <> 3 Then
          qryAdoCadIqu.GotoBookmark(bkmPosicao);
      End;
      pRegistraProgresso(0, qryAdoCadIqu.RecNo, qryAdoCadIqu.RecordCount);
    End;

    pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

    qryAdoCadIqu.FreeBookmark(bkmPosicao);
    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TIquineNova.fProcessarCadIqu]');
      Result := False;
    End;
  End;
end;

function fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM IQU_CADEMB WHERE EMB_QTDEMB IN (0.8, 3.2, 16)';
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

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(IQU_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM IQU_CADIQU;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM IQU_CADIQU WHERE IQU_CODIGO = :CODIGO ';

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
