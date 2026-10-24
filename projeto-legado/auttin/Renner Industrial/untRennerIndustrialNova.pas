unit untRennerIndustrialNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants, untPaiGeraArq, Dialogs,
  ADODB, DB, ComObj, Math ;

Type
  TRennerIndustrialDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadRen: Boolean;
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

implementation

uses untFuncoesSimples, SysUtils, untFuncoes, StrUtils, untFuncTinta,
  untModuloTinta;



{ TRennerIndustrialDinamica }

constructor TRennerIndustrialDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('REN').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM REN_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM REN_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM REN_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM REN_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TRennerIndustrialDinamica.Destroy;
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
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM REN_CADREN WHERE REN_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO REN_CADREN ');
  qryGen.SQL.Add('             (REN_CODSEQ, ');
  qryGen.SQL.Add('              REN_CODEMP, ');
  qryGen.SQL.Add('              REN_DESCRI, ');
  qryGen.SQL.Add('              REN_CODIGO, ');
  qryGen.SQL.Add('              REN_UNIDAD, ');
  qryGen.SQL.Add('              REN_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              REN_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              REN_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              REN_CODEMB, ');
  qryGen.SQL.Add('              REN_CODUNI, ');
  qryGen.SQL.Add('              REN_ATIVAD, ');
  qryGen.SQL.Add('              REN_DTACAD, ');
  qryGen.SQL.Add('              REN_MD5KEY) ');
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
  qryGen.SQL.Add('         :ATIVAD, ');
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :MD5KEY); ');

  qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  qryGen.ParamByName('UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;
  qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REN_CADREN', VS_strCodEmp);
  qryGen.ParamByName('CODEMB').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;
  qryGen.ParamByName('CODUNI').AsString := qryGen.ParamByName('UNIDAD').AsString;
  qryGen.ParamByName('ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
  qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

  For intCont := 1 To 10 Do
  Begin
    qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
    qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=  qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat;
  End;

  qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                            qryGen.ParamByName('CODIGO').AsString +
                                            qryGen.ParamByName('UNIDAD').AsString +
                                            qryGen.ParamByName('CODBAS').AsString +
                                            qryGen.ParamByName('CODEMB').AsString +
                                            qryGen.ParamByName('CODUNI').AsString );
  qryGen.ExecSQL;
  Result := True;
end;

function TRennerIndustrialDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadRen: TUniQuery;
    intCont: Integer;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM REN_CADREN WHERE REN_CODIGO IN (SELECT NFM_CODIGO FROM REN_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM REN_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN REN_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadRen := fCriaQuery(Self);
  qryCadRen.SQL.Text := 'SELECT * FROM REN_CADREN WHERE FALSE';
  qryCadRen.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('REN_CADREN', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas fórmulas...');
  While Not qryGen.Eof Do
  Begin
    qryCadRen.Insert;

    qryCadRen.FieldByName('REN_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryCadRen.FieldByName('REN_CODEMP').AsString := VS_strCodEmp;
    qryCadRen.FieldByName('REN_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
    qryCadRen.FieldByName('REN_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
    qryCadRen.FieldByName('REN_UNIDAD').AsString := qryGen.FieldByName('NFM_UNIDAD').AsString;
    qryCadRen.FieldByName('REN_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;

    For intCont := 1 To 10 Do
    Begin

      If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
        Break;

      qryCadRen.FieldByName('REN_FORM' + fStrZero(intCont, 2)).AsString :=
        qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

      qryCadRen.FieldByName('REN_QTDC' + fStrZero(intCont, 2)).AsFloat :=
        qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat;
    End;

    qryCadRen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REN_CADREN', VS_strCodEmp);
    qryCadRen.FieldByName('REN_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
    qryCadRen.FieldByName('REN_CODUNI').AsString := qryCadRen.FieldByName('REN_UNIDAD').AsString;
    qryCadRen.FieldByName('REN_MD5KEY').AsString := GetMD5(qryCadRen.FieldByName('REN_DESCRI').AsString +
                                                      qryCadRen.FieldByName('REN_CODIGO').AsString +
                                                      qryCadRen.FieldByName('REN_UNIDAD').AsString +
                                                      qryCadRen.FieldByName('REN_CODBAS').AsString +
                                                      qryCadRen.FieldByName('REN_CODEMB').AsString +
                                                      qryCadRen.FieldByName('REN_CODUNI').AsString );

    qryCadRen.Post;

    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas fórmulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TRennerIndustrialDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadRen;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TRennerIndustrialDinamica.fProcessarArquivos');
    End;
  end;
end;

function TRennerIndustrialDinamica.fProcessarCadBas: Boolean;
  Var
    qryAdoCadBas: TADOQuery;
    qryCadbas: TUniQuery;
  Const
    strUnid = 'GL';
begin
  Try
    qryAdoCadBas := TADOQuery.Create(Nil);

    qryAdoCadBas.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadBas.SQL.Add(' SELECT                    ');
    qryAdoCadBas.SQL.Add('   *                       ');
    qryAdoCadBas.SQL.Add(' FROM Bases                ');
    qryAdoCadBas.SQL.Add(' ORDER BY 1                ');
    qryAdoCadBas.Open;

    qryCadbas := fCriaQuery();
    qryCadbas.SQL.Add(' INSERT INTO REN_CADBAS   ');
    qryCadbas.SQL.Add('             (AUTOINCREM, ');
    qryCadbas.SQL.Add('              BAS_BASE__, ');
    qryCadbas.SQL.Add('              BAS_DESCRI, ');
    qryCadbas.SQL.Add('              BAS_UNIDAD, ');
    qryCadbas.SQL.Add('              BAS_CODEMP, ');
    qryCadbas.SQL.Add('              BAS_COMPOB, ');
    qryCadbas.SQL.Add('              BAS_PRECUS, ');
    qryCadbas.SQL.Add('              BAS_PREVEN, ');
    qryCadbas.SQL.Add('              BAS_MARGEM) ');
    qryCadbas.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadbas.SQL.Add('         :BAS_BASE__, ');
    qryCadbas.SQL.Add('         :BAS_DESCRI, ');
    qryCadbas.SQL.Add('         :BAS_UNIDAD, ');
    qryCadbas.SQL.Add('         :BAS_CODEMP, ');
    qryCadbas.SQL.Add('         :BAS_COMPOB, ');
    qryCadbas.SQL.Add('         :BAS_PRECUS, ');
    qryCadbas.SQL.Add('         :BAS_PREVEN, ');
    qryCadbas.SQL.Add('         :BAS_MARGEM); ');

    pRegistraAcao('Processando cadastro de bases...');
    While Not qryAdoCadBas.Eof Do
    Begin
      qryCadbas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REN_CADBAS', VS_strCodEmp);
      qryCadbas.ParamByName('BAS_BASE__').AsString := qryAdoCadBas.FieldByName('Código da Base').AsString;
      qryCadbas.ParamByName('BAS_DESCRI').AsString := AnsiUpperCase(qryAdoCadBas.FieldByName('Descrição').AsString);
      qryCadbas.ParamByName('BAS_COMPOB').AsString := qryAdoCadBas.FieldByName('Componente B').AsString;
      qryCadbas.ParamByName('BAS_UNIDAD').AsString := strUnid;
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
            [qryAdoCadBas.FieldByName('Código da Base').AsString]))
          Else
            Raise;
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
      pMensagensErro(E.Message, '[TRennerIndustrialNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TRennerIndustrialDinamica.fProcessarCadCol: Boolean;
  Var
    qryAdoCadCol: TADOQuery;
    qryCadCol: TUniQuery ;
begin
  Try
    qryAdoCadCol := TADOQuery.Create(Nil);

    qryAdoCadCol.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
      ';Persist Security Info=True';

    qryAdoCadCol.SQL.Add(' SELECT          ');
    qryAdoCadCol.SQL.Add('   * ');
    qryAdoCadCol.SQL.Add(' FROM Pigmentos   ');
    qryAdoCadCol.SQL.Add(' ORDER BY 1 ');
    qryAdoCadCol.Open;

    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Add(' INSERT INTO REN_CADCOL   ');
    qryCadCol.SQL.Add('             (AUTOINCREM, ');
    qryCadCol.SQL.Add('              COL_CODCOL, ');
    qryCadCol.SQL.Add('              COL_DESCRI, ');
    qryCadCol.SQL.Add('              COL_CODEMP, ');
    qryCadCol.SQL.Add('              COL_EMBALA) ');
    qryCadCol.SQL.Add(' VALUES (:AUTOINCREM,     ');
    qryCadCol.SQL.Add('         :COL_CODCOL,     ');
    qryCadCol.SQL.Add('         :COL_DESCRI,     ');
    qryCadCol.SQL.Add('         :COL_CODEMP,     ');
    qryCadCol.SQL.Add('         :COL_EMBALA);    ');

    pRegistraAcao('Processando cadastro de colorantes...');
    While Not qryAdoCadCol.Eof Do
    Begin
      qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REN_CADCOL', VS_strCodEmp);
      qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCadCol.FieldByName('Código do Pigmento').AsString;
      qryCadCol.ParamByName('COL_DESCRI').AsString := qryAdoCadCol.FieldByName('Descrição').AsString;
      qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.ParamByName('COL_EMBALA').AsFloat  := 1000;

      Try
        qryCadCol.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Colorante %s já está cadastrado.',
            [qryAdoCadCol.FieldByName('Código do Pigmento').AsString]))
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
      pMensagensErro(E.Message, '[TRennerIndustrialNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TRennerIndustrialDinamica.fProcessarCadEmb: Boolean;
  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM REN_CADEMB';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  Var
    qryCadEmb: TUniQuery;
  Const
    strUnid = 'GL';
    fltQtde = 3600;
begin
  Try
    pDeletaRegistros;

    qryCadEmb := fCriaQuery();
    qryCadEmb.SQL.Add(' INSERT INTO REN_CADEMB ');
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

    qryCadEmb.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REN_CADEMB', VS_strCodEmp);
    qryCadEmb.ParamByName('EMB_CODEMB').AsString := '1';
    qryCadEmb.ParamByName('EMB_CODEMP').AsString := VS_strCodEmp;
    qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := fltQtde;
    qryCadEmb.ParamByName('EMB_UNIDAD').AsString := strUnid;

    qryCadEmb.ExecSQL;
    pRegistraProgresso(1, 1, 1);

    pRegistraAcao('Cadastro de embalagens processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRennerIndustrialNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TRennerIndustrialDinamica.fProcessarCadRen: Boolean;
  Var
    qryAdoCadRen: TADOQuery;
    qryCadRen: TUniQuery;
    intForm: Integer;
    intCodSeq: Integer;
    strCor,
    strBase: String;
  Const
    strUnid = 'GL';

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(REN_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REN_CADREN;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM REN_CADREN';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadRen.Params.Count - 1 Do
    Begin
      qryCadRen.Params.Items[i].Value := Null;
    End;
  End;
begin
  Try
    pDeletaRegistros;

    qryAdoCadRen := TADOQuery.Create(Nil);
    qryAdoCadRen.ConnectionString := 'Driver={Microsoft Access Driver (*.mdb)}; Dbq=' + strPath + '; Uid=Admin; Pwd=;';

    qryAdoCadRen.SQL.Add(' SELECT                              ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Código da Cor",         ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Código da Base",        ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Código do Pigmento",    ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_1",            ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_2",            ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_3",            ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_4",            ');
    qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_5",            ');
    qryAdoCadRen.SQL.Add('   Tintas."Código do Identificador", ');
    qryAdoCadRen.SQL.Add('   Cores."Descrição"                 ');
    qryAdoCadRen.SQL.Add(' FROM Fórmulas,                      ');
    qryAdoCadRen.SQL.Add('   Tintas,                           ');
    qryAdoCadRen.SQL.Add('   Cores                             ');
    qryAdoCadRen.SQL.Add(' WHERE Fórmulas."Código da Cor" = Tintas."Código da Cor"  ');
    qryAdoCadRen.SQL.Add(' AND Fórmulas."Código da Base" = Tintas."Código da Base"  ');
    qryAdoCadRen.SQL.Add(' AND Fórmulas."Código da Cor" = Cores."Código da Cor"     ');
    qryAdoCadRen.SQL.Add(' ORDER BY Fórmulas."Código da Cor", Fórmulas."Código da Base", Fórmulas."Código do Pigmento"');
    qryAdoCadRen.Open;

    qryCadRen := fCriaQuery();
    qryCadRen.SQL.Add(' INSERT INTO REN_CADREN ');
    qryCadRen.SQL.Add('             (REN_CODSEQ, ');
    qryCadRen.SQL.Add('              REN_CODEMP, ');
    qryCadRen.SQL.Add('              REN_DESCRI, ');
    qryCadRen.SQL.Add('              REN_CODIGO, ');
    qryCadRen.SQL.Add('              REN_UNIDAD, ');
    qryCadRen.SQL.Add('              REN_CODBAS, ');
    qryCadRen.SQL.Add('              REN_CODEMB, ');
    qryCadRen.SQL.Add('              REN_CODUNI, ');
    qryCadRen.SQL.Add('              REN_MD5KEY, ');
    qryCadRen.SQL.Add('              REN_IDENTI, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadRen.SQL.Add('            REN_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadRen.SQL.Add('            REN_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadRen.SQL.Add('              AUTOINCREM) ');
    qryCadRen.SQL.Add(' VALUES (:REN_CODSEQ, ');
    qryCadRen.SQL.Add('         :REN_CODEMP, ');
    qryCadRen.SQL.Add('         :REN_DESCRI, ');
    qryCadRen.SQL.Add('         :REN_CODIGO, ');
    qryCadRen.SQL.Add('         :REN_UNIDAD, ');
    qryCadRen.SQL.Add('         :REN_CODBAS, ');
    qryCadRen.SQL.Add('         :REN_CODEMB, ');
    qryCadRen.SQL.Add('         :REN_CODUNI, ');
    qryCadRen.SQL.Add('         :REN_MD5KEY, ');
    qryCadRen.SQL.Add('         :REN_IDENTI, ');

    For intForm := 1 To 10 Do
    Begin
      qryCadRen.SQL.Add('       :REN_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadRen.SQL.Add('       :REN_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadRen.SQL.Add('         :AUTOINCREM); ');

    pRegistraAcao('Processando cadastro de Fórmulas...');

    intCodSeq := 0;
    While (Not qryAdoCadRen.Eof) Do
    Begin
      Limpar;
      Inc(intCodSeq);

      strCor  := qryAdoCadRen.FieldByName('Código da Cor').AsString;
      strBase := qryAdoCadRen.FieldByName('Código da Base').AsString;

      qryCadRen.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('REN_CADREN', VS_strCodEmp);
      qryCadRen.ParamByName('REN_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
      qryCadRen.ParamByName('REN_CODEMP').AsString  := VS_strCodEmp;
      qryCadRen.ParamByName('REN_DESCRI').AsString  := AnsiUpperCase(qryAdoCadRen.FieldByName('Descrição').AsString);
      qryCadRen.ParamByName('REN_CODIGO').AsString  := qryAdoCadRen.FieldByName('Código da Cor').AsString;
      qryCadRen.ParamByName('REN_UNIDAD').AsString  := strUnid;
      qryCadRen.ParamByName('REN_CODUNI').AsString  := strUnid;
      qryCadRen.ParamByName('REN_CODBAS').AsString  := qryAdoCadRen.FieldByName('Código da Base').AsString;
      qryCadRen.ParamByName('REN_CODEMB').AsString  := '1';
      qryCadRen.ParamByName('REN_IDENTI').AsString  := qryAdoCadRen.FieldByName('Código do Identificador').AsString;
      qryCadRen.ParamByName('REN_MD5KEY').AsString  := GetMD5(qryCadRen.ParamByName('REN_DESCRI').AsString +
                                                         qryCadRen.ParamByName('REN_CODIGO').AsString +
                                                         qryCadRen.ParamByName('REN_UNIDAD').AsString +
                                                         qryCadRen.ParamByName('REN_CODBAS').AsString +
                                                         qryCadRen.ParamByName('REN_CODEMB').AsString +
                                                         qryCadRen.ParamByName('REN_CODUNI').AsString);

      intForm := 1;

      While ((strCor = qryAdoCadRen.FieldByName('Código da Cor').AsString) And
             (strBase = qryAdoCadRen.FieldByName('Código da Base').AsString)) And
            (Not qryAdoCadRen.Eof) Do
      Begin
        qryCadRen.ParamByName('REN_FORM' + fStrZero(intForm, 2)).AsString := qryAdoCadRen.FieldByName('Código do Pigmento').AsString;
        qryCadRen.ParamByName('REN_QTDC' + fStrZero(intForm, 2)).AsFloat :=
          (qryAdoCadRen.FieldByName('Quant 01_1').AsFloat +
          ((qryAdoCadRen.FieldByName('Quant 01_2').AsFloat +
           (qryAdoCadRen.FieldByName('Quant 01_3').AsFloat * 0.5) +
           (qryAdoCadRen.FieldByName('Quant 01_4').AsFloat * 0.25) +
           (qryAdoCadRen.FieldByName('Quant 01_5').AsFloat * 0.125)) / 48)) * 29.57353;

        qryAdoCadRen.Next;
        intForm := intForm + 1;
        pRegistraProgresso(0, qryAdoCadRen.RecNo, qryAdoCadRen.RecordCount);
      End;

      Try
        qryCadRen.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Fórmula %s já está cadastrada.',
            [qryAdoCadRen.FieldByName('Código da Cor').AsString]))
          Else
            Raise;
        End;
      End;

      //qryAdoCadRen.GotoBookmark(bkmPosicao);
      pRegistraProgresso(0, qryAdoCadRen.RecNo, qryAdoCadRen.RecordCount);
    End;

    pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRennerIndustrialNova.fProcessarCadRen]');
      Result := False;
    End;
  End;
end;

function fRetProximoCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
   qryGen := fCriaQuery(nil);

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(REN_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REN_CADREN;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM REN_CADREN WHERE REN_CODIGO = :CODIGO ';

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
