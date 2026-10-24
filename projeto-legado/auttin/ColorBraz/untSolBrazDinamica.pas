Unit untSolBrazDinamica;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, ADODB, untIConfTinta;

Type
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;

  TSolBrazDinamica = class(TComponent)
  private
    qryAdoCadSol : TADOQuery;
    qryAdoCadBas : TADOQuery;
    qryAdoCadCol : TADOQuery;

    qryCadBas : TUniQuery;
    qryCadCol : TUniQuery;
    qryCadSol : TUniQuery;


    conConex  : TADOConnection;

    strPat: String;
    intOpcao: Integer;

    FRegistraAcao     : TEventoStrAcao;
    FRegistraProgresso : TEventoProgresso;

    blnParar: Boolean;
    conf: IConfTinta;

    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadSol: Boolean;

    function fVerificaCadBasVazia: Boolean;
    function fVerificaCadBasConfigurada: Boolean;
    function fVerificaCadColVazio: Boolean;
    function fVerificaCadColConfigurado: Boolean;



    function fVerificaCadCol(strCodCol: String): Boolean;


    function fCarregaUnidade(strUnidade: String): String;

  protected
    //
  public
    function fGravaCadNfm: Boolean;
    procedure pCancelar;
    function fProcessaArquivos: Boolean;
    constructor Create(AOWner: TComponent; intOpcao: Integer); reintroduce;
    constructor CreateNfm(AOwner: TComponent);
    destructor Destroy; override;
  published
    property  RegistraAcao  : TEventoStrAcao  Read  FRegistraAcao Write FRegistraAcao;
    property  RegistraProgresso : TEventoProgresso  Read  FRegistraProgresso  Write FRegistraProgresso;
  end;

  function fGravaNFM(qryCadNfm: TUniQuery): Boolean;
  function fProxCodSeq: Integer;

implementation

uses untFuncoesSimples, untFuncTinta, StrUtils, Contnrs, untFuncoes;

{ TSolBrazDinamica }

constructor TSolBrazDinamica.Create(AOWner: TComponent; intOpcao: Integer);
  Var
    intCont: Integer;
    strSQL : String;
begin
  conf     := fGetConfTinta('COL');
  blnParar := False;
//Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=D:\solbraz\xMfrsbook.mdb;Persist Security Info=True
  strPat := conf.fGet('SOLPAT'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLPAT', '');

  conConex := TADOConnection.Create(Self);
  conConex.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPat +
    ';Persist Security Info=True';
  conConex.LoginPrompt := False;
  conConex.Open;

  qryAdoCadSol := TADOQuery.Create(Self);
  qryAdoCadSol.Connection := conConex;

  qryAdoCadBas := TADOQuery.Create(Self);
  qryAdoCadBas.Connection := conConex;

  qryAdoCadCol := TADOQuery.Create(Self);
  qryAdoCadCol.Connection := conConex;

  qryAdoCadSol := TADOQuery.Create(Self);
  qryAdoCadSol.Connection := conConex;

  qryAdoCadSol.SQL.Text := ' SELECT DISTINCT * FROM [CATALOGO COLORBRAZ] UNION SELECT DISTINCT * FROM COLORBRAZ ';

  qryAdoCadBas.SQL.Text := ' SELECT DISTINCT KEYFIELD1, DISPLAYFIELD4, AVAILABLESIZES FROM [CATALOGO COLORBRAZ] ' +
                           ' UNION SELECT DISTINCT KEYFIELD1, DISPLAYFIELD4, AVAILABLESIZES FROM COLORBRAZ ';

  qryAdoCadCol.SQL.Clear;
  strSQL := '';

  For intCont := 1 To 5 Do
  Begin
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' LEFT(INGREDIENT' + IntToStr(intCont) + ', 3) AS INGREDIENT ';
    strSQL := strSQL + ' FROM COLORBRAZ ';
    strSQL := strSQL + ' UNION ';
  End;

  strSQL := Trim(strSQL) + ' ' + Trim(AnsiReplaceStr(strSQL, 'COLORBRAZ', '[CATALOGO COLORBRAZ]'));
  strSQL := Copy(strSQL, 1, Length(strSQL) - Length('UNION'));
  qryAdoCadCol.SQL.Text := Trim(strSQL);

  qryCadSol := fCriaQuery(Self);
  qryCadSol.SQL.Text := 'SELECT * FROM SOL_CADSOL';

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Text := 'SELECT * FROM SOL_CADBAS';

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Text := 'SELECT * FROM SOL_CADCOL';

  qryCadSol := fCriaQuery(Self);
  qryCadSol.SQL.Text := 'SELECT * FROM SOL_CADSOL';

  Self.intOpcao := intOpcao;

end;

destructor TSolBrazDinamica.Destroy;
begin
  FreeAndNil(qryAdoCadSol);
  FreeAndNil(qryAdoCadBas);
  FreeAndNil(qryAdoCadCol);
  FreeAndNil(qryCadSol);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);
  FreeAndNil(conConex);
end;



function TSolBrazDinamica.fCarregaUnidade(strUnidade: String): String;
begin
  If (strUnidade = 'Galão') Then
  Begin
    Result := conf.fGet('SOLGAL'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLGAL', '');
  End
  Else If (strUnidade = 'Lata') Then
  Begin
    Result := conf.fGet('SOLLAT'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLLAT', '');
  End
  Else If (strUnidade = 'Quarto') Then
  Begin
    Result := conf.fGet('SOLQUA'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLQUA', '');
  End;
end;

function TSolBrazDinamica.fGravaCadNfm: Boolean;
  Var
    qryCadNfm: TUniQuery;
    intCont: Integer;
    blnCadCol: Boolean;
begin
  blnCadCol := False;
    
  qryCadNfm := fCriaQuery(Self);
  qryCadNfm.Close;
  qryCadNfm.SQL.Text := 'DELETE FROM SOL_CADSOL WHERE SOL_CODNFM IN (SELECT NFM_CODNFM FROM SOL_CADNFM)';
  qryCadNfm.ExecSQL;

  qryCadNfm.SQL.Text := 'SELECT * FROM SOL_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Processando cadastro de novas formulas...');

  While Not qryCadNfm.Eof Do
  Begin
    qryCadSol.Insert;
    qryCadSol.FieldByName('SOL_CODSEQ').AsString := fStrZero(fProxCodSeq, 6);
    qryCadSol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SOL_CADSOL', VS_strCodEmp);
    qryCadSol.FieldByName('SOL_CODEMP').AsString := VS_strCodEmp;
    qryCadSol.FieldByName('SOL_UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;
    qryCadSol.FieldByName('SOL_MARCA_').AsString := qryCadNfm.FieldByName('NFM_MARCA_').AsString;
    qryCadSol.FieldByName('SOL_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryCadSol.FieldByName('SOL_DESBAS').AsString := qryCadNfm.FieldByName('NFM_DESBAS').AsString;
    qryCadSol.FieldByName('SOL_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;

    For intCont := 1 To 6 Do
    Begin
      If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString)) Then
        Break;

      blnCadCol := fVerificaCadCol(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString);

      If Not (blnCadCol) Then
        Break;

      qryCadSol.FieldByName('SOL_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryCadSol.FieldByName('SOL_QTDB' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsString;
    End;

    If Not (blnCadCol) Then
    Begin
      If (Assigned(FRegistraProgresso)) Then
        FRegistraProgresso(1, qryCadNfm.RecNo, qryCadNfm.RecordCount);

      qryCadNfm.Next;
      Continue;
    End;

    qryCadSol.FieldByName('SOL_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCadSol.Post;

    If (Assigned(FRegistraProgresso)) Then
      FRegistraProgresso(1, qryCadNfm.RecNo, qryCadNfm.RecordCount);

    qryCadNfm.Next;
  End;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Cadastro de novas formulas processado com sucesso!');

  FreeAndNil(qryCadSol);
  Result := True;
end;

function TSolBrazDinamica.fProcessaArquivos: Boolean;
begin
  case intOpcao of
    1:
      Begin
        If Not (fProcessaCadBas) Then
        Begin
          Result := False;
          Exit;
        End;
        If Not (fProcessaCadCol) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
    2:
      Begin
        If Not (fProcessaCadSol) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
  end;

  Result := True;
end;

function TSolBrazDinamica.fProcessaCadBas: Boolean;
  Var
    strUnidades: String;
    strUniAtual: String;
begin


  qryAdoCadBas.Close;
  qryAdoCadBas.Open;
  qryCadBas.Close;
  qryCadBas.Open;

  qryAdoCadBas.First;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Processando cadastro de bases...');

  Application.ProcessMessages;

  While Not qryAdoCadBas.Eof Do
  Begin

    {**************************************************************}
    {* GERAR SOMENTE AS BASES NAS UNIDADES DISPONIVEIS NO ARQUIVO *}
    {***********************************************************PH*}

    strUnidades := qryAdoCadBas.FieldByName('AVAILABLESIZES').AsString + ';';

    While Not fEmptyStr(strUnidades) Do
    Begin

      If (Copy(strUnidades, 1, Pos(';', strUnidades) - 1) = 'Galão') Then
      Begin
        strUniAtual := conf.fGet('SOLGAL'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLGAL', '');
      End
      Else If (Copy(strUnidades, 1, Pos(';', strUnidades) - 1) = 'Lata') Then
      Begin
        strUniAtual := conf.fGet('SOLLAT'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLLAT', '');
      End
      Else If (Copy(strUnidades, 1, Pos(';', strUnidades) - 1) = 'Quarto') Then
      Begin
        strUniAtual := conf.fGet('SOLQUA'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLQUA', '');
      End;

      If (Not qryCadBas.Locate('BAS_CODBAS;BAS_DESCRI;BAS_CODUNI',
        VarArrayOf([qryAdoCadBas.FieldByName('DISPLAYFIELD4').AsString,
          qryAdoCadBas.FieldByName('KEYFIELD1').AsString, strUniAtual]), [])) Then
      Begin
        qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryAdoCadBas.FieldByName('DISPLAYFIELD4').AsString;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := qryAdoCadBas.FieldByName('KEYFIELD1').AsString;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SOL_CADBAS', VS_strCodEmp);
        qryCadBas.FieldByName('BAS_CODUNI').AsString := strUniAtual;
        qryCadBas.Post;
      End;

      strUnidades := Copy(strUnidades, Pos(';', strUnidades) + 1, Length(strUnidades));
    End;

    qryAdoCadBas.Next;

    If (Assigned(FRegistraProgresso)) Then
      FRegistraProgresso(1, qryAdoCadBas.RecNo, qryAdoCadBas.RecordCount);

    Application.ProcessMessages;
  End;



  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Cadastro de bases processado com sucesso!');

  Application.ProcessMessages;

  Result := True;
end;

function TSolBrazDinamica.fProcessaCadCol: Boolean;
begin
  qryAdoCadCol.Close;
  qryAdoCadCol.Open;
  qryCadCol.Close;
  qryCadCol.Open;

  qryAdoCadCol.First;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Processando cadastro de colorantes...');

  Application.ProcessMessages;

  While Not qryAdoCadCol.Eof Do
  Begin
    If (Not qryCadCol.Locate('COL_CODCOL', qryAdoCadCol.FieldByName('INGREDIENT').AsString, [])
      And Not (fEmptyStr(qryAdoCadCol.FieldByName('INGREDIENT').AsString))) Then
    Begin
      qryCadCol.Insert;
      qryCadCol.FieldByName('COL_CODCOL').AsString := qryAdoCadCol.FieldbyName('INGREDIENT').AsString;
      qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SOL_CADCOL', VS_strCodEmp);
      qryCadCol.Post;
    End;
    qryAdoCadCol.Next;

    If (Assigned(FRegistraProgresso)) Then
      FRegistraProgresso(1, qryAdoCadCol.RecNo, qryAdoCadCol.RecordCount);

    Application.ProcessMessages;
  End;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Cadastro de colorantes processado com sucesso!');

  Application.ProcessMessages;

  Result := True;
end;

function TSolBrazDinamica.fProcessaCadSol: Boolean;
  Var
    qryGen: TUniQuery;

    fltFatorOri: Double;
    fltFatorDes: Double;

    strUnidades : String;
    strUniAtual : String;

    intCont: Integer;
    intCodSeq: Integer;

    blnColorante: Boolean;

begin

  blnColorante := False;
  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Removendo todas as tintas...');

  qryGen := fCriaQuery(Self);
  qryGen.Close;
  qryGen.SQL.Text := 'TRUNCATE TABLE SOL_CADSOL';
  qryGen.ExecSQL;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Tintas removidas com sucesso!');

  If Not (fVerificaCadBasVazia) Then
  Begin
    fMensagem('', 'O cadastro de bases está vazio!', ['OK']);
    Result := False;
    FreeAndNil(qryGen);
    Exit;
  End;

  If Not (fVerificaCadBasConfigurada) Then
  Begin
    fMensagem('', 'O cadastro de base não está configurado!', ['OK']);
    Result := False;
    FreeAndNil(qryGen);
    Exit;
  End;

  If Not (fVerificaCadColVazio) Then
  Begin
    fMensagem('', 'O Cadastro de colorantes estã vazio!', ['OK']);
    Result := False;
    FreeAndNil(qryGen);
    Exit;
  End;

  If Not (fVerificaCadColConfigurado) Then
  Begin
    fMensagem('', 'Os colorantes não estão configurados', ['OK']);
    Result := False;
    FreeAndNil(qryGen);
    Exit;
  End;

  qryAdoCadSol.Close;
  qryAdoCadSol.Open;
  qryCadSol.Close;
  qryCadSol.Open;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM CADUNI WHERE UNI_CODUNI = :CODUNI';

  qryCadBas.Close;
  qryCadBas.Open;

  qryCadCol.Close;
  qryCadCol.Open;

  qryAdoCadSol.First;

  intCodSeq := 1;

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Processando cadastro de tintas...');

  qryCadBas.Close;
  qryCadBas.Open;
  qryCadCol.Close;
  qryCadCol.Open;

  While Not qryAdoCadSol.Eof Do
  Begin

    strUnidades := qryAdoCadSol.FieldByName('AVAILABLESIZES').AsString + ';';

    While Not fEmptyStr(strUnidades) Do
    Begin


      strUniAtual := Copy(strUnidades, 1, Pos(';', strUnidades) - 1);

      If Not (qryCadBas.Locate('BAS_CODBAS;BAS_DESCRI;BAS_CODUNI', VarArrayOf([
          qryAdoCadSol.FieldByName('DISPLAYFIELD4').AsString,
          qryAdoCadSol.FieldByName('DISPLAYFIELD2').AsString,
          fCarregaUnidade(strUniAtual)]), [])) Then
      Begin
        If (Assigned(FRegistraProgresso)) Then
          FRegistraProgresso(1, qryAdoCadSol.RecNo, qryAdoCadSol.RecordCount);

        qryAdoCadSol.Next;
        Application.ProcessMessages;
        strUnidades := Copy(strUnidades, Pos(';', strUnidades) + 1, Length(strUnidades));
        Continue;
      End;


      If (fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString)) Then
      Begin
        If (Assigned(FRegistraProgresso)) Then
          FRegistraProgresso(1, qryAdoCadSol.RecNo, qryAdoCadSol.RecordCount);

        qryAdoCadSol.Next;
        Application.ProcessMessages;
        strUnidades := Copy(strUnidades, Pos(';', strUnidades) + 1, Length(strUnidades));
        Continue;
      End;



      qryGen.Close;

      qryCadSol.Insert;
      qryCadSol.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intCodSeq, VS_strCodEmp);
      qryCadSol.FieldByName('SOL_CODSEQ').AsString := fStrZero(intCodSeq, 6);
      qryCadSol.FieldByName('SOL_CODEMP').AsString := VS_strCodEmp;

      qryGen.ParamByName('CODUNI').AsString := fCarregaUnidade(qryAdoCadSol.FieldByName('FORMULASIZE').AsString);
      qryGen.Open;
      fltFatorOri := qryGen.FieldByName('UNI_PESLIT').AsFloat;

      qryGen.Close;
      qryGen.ParamByName('CODUNI').AsString := fCarregaUnidade(Copy(strUnidades, 1, Pos(';', strUnidades) - 1));
      qryGen.Open;

      qryCadSol.FieldByName('SOL_UNIDAD').AsString := qryGen.ParamByName('CODUNI').AsString;

      fltFatorDes := qryGen.FieldByName('UNI_PESLIT').AsFloat;

      qryCadSol.FieldByName('SOL_MARCA_').AsString := qryAdoCadSol.FieldByName('DISPLAYFIELD1').AsString;
      qryCadSol.FieldByName('SOL_CODBAS').AsString := qryAdoCadSol.FieldByName('DISPLAYFIELD4').AsString;
      qryCadSol.FieldByName('SOL_DESBAS').AsString := qryAdoCadSol.FieldByName('DISPLAYFIELD2').AsString;
      qryCadSol.FieldByName('SOL_CODCOR').AsString := qryAdoCadSol.FieldByName('DISPLAYFIELD3').AsString;


      For intCont := 1 To 6 Do
      Begin

        If (fEmptyStr(qryAdoCadSol.FieldByName('INGREDIENT' + IntToStr(intCont)).AsString)) Then
          Break;

        blnColorante := fVerificaCadCol(LeftStr(qryAdoCadSol.FieldByName('INGREDIENT' + IntToStr(intCont)).AsString, 3));

        If Not (blnColorante) Then
        Begin
          qryCadSol.Cancel;
          Break;
        End;

        qryCadSol.FieldByName('SOL_FORM' + fStrZero(intCont, 2)).AsString :=
                LeftStr(qryAdoCadSol.FieldByName('INGREDIENT' + IntToStr(intCont)).AsString, 3);

        qryCadSol.FieldByName('SOL_QTDB' + fStrZero(intCont, 2)).AsFloat :=

        fStrToFloat(Copy(qryAdoCadSol.FieldByName('INGREDIENT' + IntToStr(intCont)).AsString, 5,
        Length(qryAdoCadSol.FieldByName('INGREDIENT' + IntToStr(intCont)).AsString))) * fltFatorDes / fltFatorOri;

      End;

      If Not (blnColorante) Then
      Begin
        qryCadSol.Cancel;
        Break;
      End;

      qryCadSol.Post;
      Inc(intCodSeq);

      strUnidades := Copy(strUnidades, Pos(';', strUnidades) + 1, Length(strUnidades));
      If (Assigned(FRegistraProgresso)) Then
        FRegistraProgresso(1, qryAdoCadSol.RecNo, qryAdoCadSol.RecordCount);
      Application.ProcessMessages;

    End;

    qryAdoCadSol.Next;
    If (blnParar) Then
    Begin
      Result := False;
      Exit;
    End;

  End;

  fGravaAutoIncrem('SOL_CADSOL', intCodSeq);

  If (Assigned(FRegistraAcao)) Then
    FRegistraAcao('Cadastro de tintas processado com sucesso!');

  FreeAndNil(qryGen);


  If Not (fGravaCadNfm) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;
end;

function TSolBrazDinamica.fVerificaCadBasConfigurada: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(BAS_CODITE) AS CONT FROM SOL_CADBAS';
  qryGen.Open;

  If (qryGen.FieldByName('CONT').AsInteger = 0) Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT COUNT(BAS_CODUNI) AS CONT FROM SOL_CADBAS';
  qryGen.Open;

  If (qryGen.FieldByName('CONT').AsInteger = 0) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;

end;

function TSolBrazDinamica.fVerificaCadBasVazia: Boolean;
begin
  qryCadBas.Close;
  qryCadBas.Open;
  Result := Not qryCadBas.IsEmpty;
end;

function TSolBrazDinamica.fVerificaCadColConfigurado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(COL_CODITE) AS CONT FROM SOL_CADCOL';
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;
end;

function TSolBrazDinamica.fVerificaCadCol(strCodCol: String): Boolean;
begin
  Result := qryCadCol.Locate('COL_CODCOL', strCodCol, []);
  If (Result) Then
  Begin
    Result := Not qryCadCol.FieldByName('COL_CODITE').IsNull;
  End;
end;

function TSolBrazDinamica.fVerificaCadColVazio: Boolean;
begin
  qryCadCol.Close;
  qryCadCol.Open;
  Result := Not qryCadCol.IsEmpty
end;

function fGravaNFM(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadSol: TUniQuery;
    intCont: Integer;
begin
  qryCadSol := fCriaQuery(nil);
  qryCadSol.SQL.Text := 'DELETE FROM SOL_CADSOL WHERE SOL_CODNFM = :COD';
  qryCadSol.ParamByName('COD').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadSol.ExecSQL;

  qryCadSol.SQL.Text := 'SELECT * FROM SOL_CADSOL';
  qryCadsol.Open;

  qryCadSol.Insert;
  qryCadSol.FieldByName('SOL_CODSEQ').AsString := fStrZero(fProxCodSeq, 6);
  qryCadSol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SOL_CADSOL', VS_strCodEmp);
  qryCadSol.FieldByName('SOL_CODEMP').AsString := VS_strCodEmp;
  qryCadSol.FieldByName('SOL_UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;
  qryCadSol.FieldByName('SOL_MARCA_').AsString := qryCadNfm.FieldByName('NFM_MARCA_').AsString;
  qryCadSol.FieldByName('SOL_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
  qryCadSol.FieldByName('SOL_DESBAS').AsString := qryCadNfm.FieldByName('NFM_DESBAS').AsString;
  qryCadSol.FieldByName('SOL_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;

  For intCont := 1 To 6 Do
  Begin
    If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString)) Then
      Break;

    qryCadSol.FieldByName('SOL_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
    qryCadSol.FieldByName('SOL_QTDB' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsString;
  End;

  qryCadSol.FieldByName('SOL_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadSol.Post;

  FreeAndNil(qryCadSol);

  Result := True;
end;

function fProxCodSeq: Integer;
  Var
    qryCadGen: TUniQuery;
begin
  qryCadGen := fCriaQuery(nil);
  qryCadGen.SQL.Text := 'SELECT MAX(SOL_CODSEQ) AS "PROX" FROM SOL_CADSOL';
  qryCadGen.Open;
  If (qryCadGen.FieldByName('PROX').IsNull) Then
    Result := 1
  Else
    Result := qryCadGen.FieldByName('PROX').AsInteger + 1;
  FreeAndNil(qryCadGen);
end;

procedure TSolBrazDinamica.pCancelar;
begin
  blnParar := True;
end;

constructor TSolBrazDinamica.CreateNfm(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.

