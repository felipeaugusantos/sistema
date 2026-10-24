unit untRecoaNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs,
  ADODB,  DB, ComObj, Math ;

Type
  TRecoaDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadRec: Boolean;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadEmb: Boolean;

    function fStrToFloatRecoa(strValorUnico: String): Double;

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



{ TRecoaDinamica }

constructor TRecoaDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('REC').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM REC_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM REC_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM REC_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM REC_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TRecoaDinamica.Destroy;
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
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM REC_CADREC WHERE REC_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO REC_CADREC ');
  qryGen.SQL.Add('             (REC_CODSEQ, ');
  qryGen.SQL.Add('              REC_CODEMP, ');
  qryGen.SQL.Add('              REC_DESCRI, ');
  qryGen.SQL.Add('              REC_CODIGO, ');
  qryGen.SQL.Add('              REC_UNIDAD, ');
  qryGen.SQL.Add('              REC_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              REC_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              REC_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              REC_CODEMB, ');
  qryGen.SQL.Add('              REC_CODUNI, ');
  qryGen.SQL.Add('              REC_DTACAD, ');
  qryGen.SQL.Add('              REC_MD5KEY) ');
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
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :MD5KEY); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnidade := 1 To 3 Do
  Begin
    qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnidade]);

    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REC_CADREC', VS_strCodEmp);

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
      qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
        qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * Iif(blnGerUnids, 1, arrFator[intUnidade]);
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString );
    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function TRecoaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadRec: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1, 4, 20);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM REC_CADREC WHERE REC_CODIGO IN (SELECT NFM_CODIGO FROM REC_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM REC_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN REC_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadRec := fCriaQuery(Self);
  qryCadRec.SQL.Text := 'SELECT * FROM REC_CADREC WHERE FALSE';
  qryCadRec.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('REC_CADREC', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadRec.Insert;

      qryCadRec.FieldByName('REC_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadRec.FieldByName('REC_CODEMP').AsString := VS_strCodEmp;
      qryCadRec.FieldByName('REC_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadRec.FieldByName('REC_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadRec.FieldByName('REC_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadRec.FieldByName('REC_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadRec.FieldByName('REC_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        qryCadRec.FieldByName('REC_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IIF(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadRec.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REC_CADREC', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadRec.FieldByName('REC_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadRec.FieldByName('REC_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadRec.FieldByName('REC_CODUNI').AsString := qryCadRec.FieldByName('REC_UNIDAD').AsString;
      qryCadRec.FieldByName('REC_MD5KEY').AsString := GetMD5(qryCadRec.FieldByName('REC_DESCRI').AsString +
                                                        qryCadRec.FieldByName('REC_CODIGO').AsString +
                                                        qryCadRec.FieldByName('REC_UNIDAD').AsString +
                                                        qryCadRec.FieldByName('REC_CODBAS').AsString +
                                                        qryCadRec.FieldByName('REC_CODEMB').AsString +
                                                        qryCadRec.FieldByName('REC_CODUNI').AsString );

      qryCadRec.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TRecoaDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadRec;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TRecoaDinamica.fProcessarArquivos');
    End;
  end;
end;

function TRecoaDinamica.fProcessarCadBas: Boolean;
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

    qryAdoCadBas.SQL.Add(' SELECT            ');
    qryAdoCadBas.SQL.Add('   COD_BASE,       ');
    qryAdoCadBas.SQL.Add('   BASE,           ');
    qryAdoCadBas.SQL.Add('   PRODUTO         ');
    qryAdoCadBas.SQL.Add(' FROM BASES        ');
    qryAdoCadBas.SQL.Add(' ORDER BY COD_BASE ');
    qryAdoCadBas.Open;

    qryCadbas := fCriaQuery();
    qryCadbas.SQL.Add(' INSERT INTO REC_CADBAS   ');
    qryCadbas.SQL.Add('             (AUTOINCREM, ');
    qryCadbas.SQL.Add('              BAS_BASE__, ');
    qryCadbas.SQL.Add('              BAS_DESCRI, ');
    qryCadbas.SQL.Add('              BAS_UNIDAD, ');
    qryCadbas.SQL.Add('              BAS_CODEMP, ');
    qryCadbas.SQL.Add('              BAS_PRODUT, ');
    qryCadbas.SQL.Add('              BAS_PRECUS, ');
    qryCadbas.SQL.Add('              BAS_PREVEN, ');
    qryCadbas.SQL.Add('              BAS_MARGEM) ');
    qryCadbas.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadbas.SQL.Add('         :BAS_BASE__, ');
    qryCadbas.SQL.Add('         :BAS_DESCRI, ');
    qryCadbas.SQL.Add('         :BAS_UNIDAD, ');
    qryCadbas.SQL.Add('         :BAS_CODEMP, ');
    qryCadbas.SQL.Add('         :BAS_PRODUT, ');
    qryCadbas.SQL.Add('         :BAS_PRECUS, ');
    qryCadbas.SQL.Add('         :BAS_PREVEN, ');
    qryCadbas.SQL.Add('         :BAS_MARGEM); ');

    pRegistraAcao('Processando cadastro de bases...');
    While Not qryAdoCadBas.Eof Do
    Begin
      for intUnid := 1 to 3 do
      begin
        //Textura e Graffiato não tem Litro.
        If (Pos(AnsiUpperCase(qryAdoCadBas.FieldByName('PRODUTO').AsString),'TEXTURA_GRAFFIATO') > 0) And (intUnid = 1) Then
          Continue;

        qryCadbas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REC_CADBAS', VS_strCodEmp);
        qryCadbas.ParamByName('BAS_BASE__').AsString := qryAdoCadBas.FieldByName('COD_BASE').AsString;
        qryCadbas.ParamByName('BAS_DESCRI').AsString := AnsiUpperCase(qryAdoCadBas.FieldByName('BASE').AsString);
        qryCadbas.ParamByName('BAS_PRODUT').AsString := qryAdoCadBas.FieldByName('PRODUTO').AsString;
        qryCadbas.ParamByName('BAS_UNIDAD').AsString := arrUnid[intUnid];
        qryCadbas.ParamByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadbas.ParamByName('BAS_PRECUS').AsFloat  := 0.00;
        qryCadbas.ParamByName('BAS_PREVEN').AsFloat  := 0.00;
        qryCadbas.ParamByName('BAS_MARGEM').AsFloat  := 0.00;

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
      pMensagensErro(E.Message, '[TRecoaNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TRecoaDinamica.fProcessarCadCol: Boolean;
  Var
    qryAdoCadCol: TADOQuery;
    qryCadCol: TUniQuery;
begin
  Try
    qryAdoCadCol := TADOQuery.Create(Nil);

    qryAdoCadCol.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadCol.SQL.Add(' SELECT          ');
    qryAdoCadCol.SQL.Add('   NOME          ');
    qryAdoCadCol.SQL.Add(' FROM CORANTES   ');
    qryAdoCadCol.SQL.Add(' ORDER BY NUMERO ');
    qryAdoCadCol.Open;

    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Add(' INSERT INTO REC_CADCOL   ');
    qryCadCol.SQL.Add('             (AUTOINCREM, ');
    qryCadCol.SQL.Add('              COL_CODCOL, ');
    qryCadCol.SQL.Add('              COL_CODEMP) ');
    qryCadCol.SQL.Add(' VALUES (:AUTOINCREM,     ');
    qryCadCol.SQL.Add('         :COL_CODCOL,     ');
    qryCadCol.SQL.Add('         :COL_CODEMP);    ');

    pRegistraAcao('Processando cadastro de colorantes...');
    While Not qryAdoCadCol.Eof Do
    Begin
      qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REC_CADCOL', VS_strCodEmp);
      qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCadCol.FieldByName('NOME').AsString;
      qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;

      Try
        qryCadCol.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Colorante %s já está cadastrado.',
            [qryAdoCadCol.FieldByName('NOME').AsString]))
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
      pMensagensErro(E.Message, '[TRecoaNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TRecoaDinamica.fProcessarCadEmb: Boolean;
  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM REC_CADEMB';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  Var
    qryCadEmb: TUniQuery;
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrQtde: Array[1..3] Of Double = (810, 3240, 16200);
begin
  Try
    pDeletaRegistros;

    qryCadEmb := fCriaQuery();
    qryCadEmb.SQL.Add(' INSERT INTO REC_CADEMB ');
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
      qryCadEmb.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REC_CADEMB', VS_strCodEmp);
      qryCadEmb.ParamByName('EMB_CODEMB').AsString := IntToStr(intUnid);
      qryCadEmb.ParamByName('EMB_CODEMP').AsString := VS_strCodEmp;
      qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := arrQtde[intUnid];
      qryCadEmb.ParamByName('EMB_UNIDAD').AsString := arrUnid[intUnid];

      qryCadEmb.ExecSQL;
      pRegistraProgresso(1, intUnid, 3);
    End;

    pRegistraAcao('Cadastro de embalagens processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRecoaNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TRecoaDinamica.fProcessarCadRec: Boolean;
  Var
    qryAdoCadRec: TADOQuery;
    qryCadRec: TUniQuery;
    intForm: Integer;
    intCodSeq,
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.81, 3.24, 16.2);

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(REC_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REC_CADREC;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM REC_CADREC';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadRec.Params.Count - 1 Do
    Begin
      qryCadRec.Params.Items[i].Value := Null;
    End;
  End;
begin
  Try
    pDeletaRegistros;

    qryAdoCadRec := TADOQuery.Create(Nil);

    qryAdoCadRec.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadRec.SQL.Add(' SELECT             ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F1,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F2,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F4,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F5,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F6,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F7,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F8,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F9,     ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F10,    ');
    qryAdoCadRec.SQL.Add('   FORMULAS.F11,    ');
    qryAdoCadRec.SQL.Add('   BASES.COD_BASE  ');
    qryAdoCadRec.SQL.Add(' FROM FORMULAS,     ');
    qryAdoCadRec.SQL.Add('   BASES            ');
    qryAdoCadRec.SQL.Add(' WHERE FORMULAS.F1 = BASES.PRODUTO ');
    qryAdoCadRec.SQL.Add(' AND FORMULAS.F4 = BASES.BASE ');
    qryAdoCadRec.SQL.Add(' ORDER BY FORMULAS.F2 ');
    qryAdoCadRec.Open;

    qryCadRec := fCriaQuery();
    qryCadRec.SQL.Add(' INSERT INTO REC_CADREC ');
    qryCadRec.SQL.Add('             (REC_CODSEQ, ');
    qryCadRec.SQL.Add('              REC_CODEMP, ');
    qryCadRec.SQL.Add('              REC_DESCRI, ');
    qryCadRec.SQL.Add('              REC_CODIGO, ');
    qryCadRec.SQL.Add('              REC_UNIDAD, ');
    qryCadRec.SQL.Add('              REC_CODBAS, ');
    qryCadRec.SQL.Add('              REC_CODEMB, ');
    qryCadRec.SQL.Add('              REC_CODUNI, ');
    qryCadRec.SQL.Add('              REC_MD5KEY, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadRec.SQL.Add('            REC_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadRec.SQL.Add('            REC_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadRec.SQL.Add('              AUTOINCREM) ');
    qryCadRec.SQL.Add(' VALUES (:REC_CODSEQ, ');
    qryCadRec.SQL.Add('         :REC_CODEMP, ');
    qryCadRec.SQL.Add('         :REC_DESCRI, ');
    qryCadRec.SQL.Add('         :REC_CODIGO, ');
    qryCadRec.SQL.Add('         :REC_UNIDAD, ');
    qryCadRec.SQL.Add('         :REC_CODBAS, ');
    qryCadRec.SQL.Add('         :REC_CODEMB, ');
    qryCadRec.SQL.Add('         :REC_CODUNI, ');
    qryCadRec.SQL.Add('         :REC_MD5KEY, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadRec.SQL.Add('       :REC_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadRec.SQL.Add('       :REC_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadRec.SQL.Add('         :AUTOINCREM); ');

    pRegistraAcao('Processando cadastro de Fórmulas...');

    intCodSeq := 0;
    While Not qryAdoCadRec.Eof Do
    Begin
      for intUnid := 1 to 3 Do
      Begin
        //Textura e Graffiato não tem Litro.
        If (Pos(AnsiUpperCase(qryAdoCadRec.FieldByName('F1').AsString),'TEXTURA_GRAFFIATO') > 0) And (intUnid = 1) Then
          Continue;

        Limpar;

        Inc(intCodSeq);

        qryCadRec.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('REC_CADREC', VS_strCodEmp);
        qryCadRec.ParamByName('REC_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
        qryCadRec.ParamByName('REC_CODEMP').AsString  := VS_strCodEmp;
        qryCadRec.ParamByName('REC_DESCRI').AsString  := AnsiUpperCase(qryAdoCadRec.FieldByName('F1').AsString);
        qryCadRec.ParamByName('REC_CODIGO').AsString  := qryAdoCadRec.FieldByName('F2').AsString;
        qryCadRec.ParamByName('REC_UNIDAD').AsString  := arrUnid[intUnid];
        qryCadRec.ParamByName('REC_CODUNI').AsString  := arrUnid[intUnid];
        qryCadRec.ParamByName('REC_CODBAS').AsString  := qryAdoCadRec.FieldByName('COD_BASE').AsString;
        qryCadRec.ParamByName('REC_CODEMB').AsString  := fRetCodEmbalagem('1',arrUnid[intUnid]);
        qryCadRec.ParamByName('REC_MD5KEY').AsString  := GetMD5(qryCadRec.ParamByName('REC_DESCRI').AsString +
                                                           qryCadRec.ParamByName('REC_CODIGO').AsString +
                                                           qryCadRec.ParamByName('REC_UNIDAD').AsString +
                                                           qryCadRec.ParamByName('REC_CODBAS').AsString +
                                                           qryCadRec.ParamByName('REC_CODEMB').AsString +
                                                           qryCadRec.ParamByName('REC_CODUNI').AsString);

        If Not fEmptyStr(qryAdoCadRec.FieldByName('F5').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM01').AsString := LeftStr(qryAdoCadRec.FieldByName('F5').AsString,2);
          qryCadRec.ParamByName('REC_QTDC01').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F5').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        If Not fEmptyStr(qryAdoCadRec.FieldByName('F6').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM02').AsString := LeftStr(qryAdoCadRec.FieldByName('F6').AsString,2);
          qryCadRec.ParamByName('REC_QTDC02').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F6').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        If Not fEmptyStr(qryAdoCadRec.FieldByName('F7').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM03').AsString := LeftStr(qryAdoCadRec.FieldByName('F7').AsString,2);
          qryCadRec.ParamByName('REC_QTDC03').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F7').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        If Not fEmptyStr(qryAdoCadRec.FieldByName('F8').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM04').AsString := LeftStr(qryAdoCadRec.FieldByName('F8').AsString,2);
          qryCadRec.ParamByName('REC_QTDC04').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F8').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        If Not fEmptyStr(qryAdoCadRec.FieldByName('F9').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM05').AsString := LeftStr(qryAdoCadRec.FieldByName('F9').AsString,2);
          qryCadRec.ParamByName('REC_QTDC05').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F9').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        If Not fEmptyStr(qryAdoCadRec.FieldByName('F10').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM06').AsString := LeftStr(qryAdoCadRec.FieldByName('F10').AsString,2);
          qryCadRec.ParamByName('REC_QTDC06').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F10').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;
        {If Not fEmptyStr(qryAdoCadRec.FieldByName('F11').AsString) Then
        Begin
          qryCadRec.ParamByName('REC_FORM07').AsString := LeftStr(qryAdoCadRec.FieldByName('F11').AsString,2);
          qryCadRec.ParamByName('REC_QTDC07').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCadRec.FieldByName('F11').AsString,4,17)) * 0.616125 * arrFator[intUnid] / 0.81, -4);
        End;}

        Try
          qryCadRec.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Fórmula %s já está cadastrada.',
              [qryAdoCadRec.FieldByName('COD_FORMULA').AsString]))
            Else
              Raise;
          End;
        End;
      End;
      qryAdoCadRec.Next;
      pRegistraProgresso(0, qryAdoCadRec.RecNo, qryAdoCadRec.RecordCount);
    End;

    pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRecoaNova.fProcessarCadIqu]');
      Result := False;
    End;
  End;
end;

function TRecoaDinamica.fStrToFloatRecoa(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',','),0);
end;

function fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM REC_CADEMB WHERE EMB_QTDEMB IN (810, 3240, 16200)';
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

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(REC_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REC_CADREC;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM REC_CADREC WHERE REC_CODIGO = :CODIGO ';

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
