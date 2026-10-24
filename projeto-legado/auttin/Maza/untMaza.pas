unit untMaza;

interface

uses Classes, DB, UniClientDataSet, Variants, ADODB, Uni, untTintadeMaquina;


Type
  TMaza = class(TTintadeMaquina)
  private
    strPath: String;
    procedure pProcessarCadBas;
    procedure pProcessarCadCol;
    procedure pProcessarCadMaz;

    function fGetNomesTabelas(): TStringList;
    function fGetConnectionString(strNomArq: String): String;
    function fGetNomeProduto(strNomeTabela: String): String;
  public
    constructor Create(AOwner: TComponent); override;
    procedure pProcessarArquivos(intOpcao: Integer);
    function fGravarNovasFormulas: Boolean; override;
    class function fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
    class procedure pDeletarNovaFormula(strCodigo: String);
  End;

implementation

uses untFuncoesSimples, SysUtils,
     untIConfTinta, untFuncTinta ,StrUtils, untConstantes, untFuncoes;

{ TMaza }

constructor TMaza.Create(AOwner: TComponent);
var
  conf: IConfTinta;
begin
  inherited Create(AOwner);
  conf      := fGetConfTinta('MAZ');
  NomeTinta := 'Maza';
  strPath   := conf.fGet('PATMAZ'); //fArqIniTinta(0, 'MAZA', 'PATMAZ', '');
end;

function TMaza.fGetConnectionString(strNomArq: String): String;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strNomArq +
    ';Persist Security Info=True;Extended Properties="Excel 8.0;HDR=No;IMEX=1"';
end;

function TMaza.fGetNomeProduto(strNomeTabela: String): String;
begin
  Result := AnsiReplaceStr(AnsiReplaceStr(strNomeTabela, '#', '.'), '$', '');
end;

function TMaza.fGetNomesTabelas: TStringList;
  Var
    conAdo: TADOConnection;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
  conAdo := TADOConnection.Create(Self);
  conAdo.LoginPrompt := False;
  conAdo.ConnectionString := fGetConnectionString(strPath);
  conAdo.GetTableNames(Result);
  conAdo.Close;

  FreeAndNil(conAdo);
  Result.Text := AnsiReplaceStr(Result.Text, '_', '');
end;

class function TMaza.fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    intForm: Integer;
    intUnids: Integer;
  Const
    arrUnidades: Array[1..3] Of String = ('QT', 'GL', 'LA');
    arrQuantidades: Array[1..3] Of Double = (1.0, 4.0, 20);
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE FROM MAZ_CADMAZ WHERE MAZ_CODNFM = :CODNFM;';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldbyName('NFM_COLNUM').AsString;
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO MAZ_CADMAZ ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              MAZ_COLNUM, ');
  qryGen.SQL.Add('              MAZ_COLNAM, ');
  qryGen.SQL.Add('              MAZ_CODBAS, ');
  qryGen.SQL.Add('              MAZ_PRODUT, ');
  qryGen.SQL.Add('              MAZ_CODUNI, ');

  For intForm := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              MAZ_CODC' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('              MAZ_QTDC' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('              MAZ_CODNFM) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :MAZ_COLNUM, ');
  qryGen.SQL.Add('         :MAZ_COLNAM, ');
  qryGen.SQL.Add('         :MAZ_CODBAS, ');
  qryGen.SQL.Add('         :MAZ_PRODUT, ');
  qryGen.SQL.Add('         :MAZ_CODUNI, ');

  For intForm := 1 To 10 Do
  Begin
    qryGen.SQL.Add('         :MAZ_CODC' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('         :MAZ_QTDC' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('         :MAZ_CODNFM); ');

  fAjustaInicialAutoIncremento('MAZ_CADMAZ', VS_strCodEmp);

  qryGen.ParamByName('MAZ_COLNUM').AsString := AnsiUpperCase(qryCadNfm.FieldbyName('NFM_COLNUM').AsString);
  qryGen.ParamByName('MAZ_COLNAM').AsString := AnsiUpperCase(qryCadNfm.FieldbyName('NFM_COLNAM').AsString);
  qryGen.ParamByName('MAZ_CODBAS').AsString := AnsiUpperCase(qryCadNfm.FieldbyName('NFM_CODBAS').AsString);
  qryGen.ParamByName('MAZ_PRODUT').AsString := AnsiUpperCase(qryCadNfm.FieldbyName('NFM_PRODUT').AsString);
  qryGen.ParamByName('MAZ_CODNFM').AsString := AnsiUpperCase(qryCadNfm.FieldbyName('NFM_COLNUM').AsString);

  For intUnids := 1 To 3 Do
  Begin
    For intForm := 1 To 10 Do
    Begin
      qryGen.ParamByName('MAZ_CODC' + fStrZero(intForm, 2)).AsString :=
        AnsiUpperCase(qryCadNfm.FieldbyName('NFM_CODC' + fStrZero(intForm, 2)).AsString);

      qryGen.ParamByName('MAZ_QTDC' + fStrZero(intForm, 2)).AsFloat :=
        qryCadNfm.FieldbyName('NFM_QTDC' + fStrZero(intForm, 2)).AsFloat * arrQuantidades[intUnids];
    End;

    qryGen.ParamByName('MAZ_CODUNI').AsString := arrUnidades[intUnids];
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MAZ_CADMAZ', VS_strCodEmp);
    qryGen.ExecSQL;
  End;

  qryGen.Free;
  Result := True;
end;

function TMaza.fGravarNovasFormulas: Boolean;
  Var
    qryCadNfm: TUniQuery;
begin
  Result := True;
  qryCadNfm := fCriaQuery();
  qryCadNfm.SQL.Text := 'SELECT * FROM MAZ_CADNFM';
  qryCadNfm.Open;

  RegistraAcao('Cadastrando Novas Fórmulas...');

  While Not qryCadNfm.Eof Do
  Begin
    TMaza.fGravarNovaFormula(qryCadNfm);
    pRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
    qryCadNfm.Next;
  End;

  pRegistraAcao('Cadastro de Novas Fórmulas realizado com sucesso!');
  qryCadNfm.Free;
end;

class procedure TMaza.pDeletarNovaFormula(strCodigo: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE FROM MAZ_CADMAZ WHERE MAZ_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodigo;
  qryGen.ExecSQL;
  qryGen.Free;
end;

procedure TMaza.pProcessarArquivos(intOpcao: Integer);
begin
  If Not FileExists(strPath) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPath]), ['OK']);
    Exit;
  End;

  Case intOpcao Of
    0: pProcessarCadCol;
    1: pProcessarCadBas;
    2: pProcessarCadMaz;
  End;
  
end;

procedure TMaza.pProcessarCadBas;
  Var
    qryCadBas: TADOQuery;
    stlTabelas: TStringList;
    intCont: Integer;
    qryGen: TUniQuery;
  Const
    arrUnidade: Array[1..3] Of String = ('QT', 'GL', 'LA');
begin
  qryCadBas := TADOQuery.Create(Self);
  qryCadBas.ConnectionString := fGetConnectionString(strPath);
  stlTabelas := fGetNomesTabelas();

  For intCont := 0 To stlTabelas.Count - 1 Do
  Begin
    qryCadBas.SQL.Add(' UNION ');
    qryCadBas.SQL.Add(Format(' SELECT DISTINCT %s AS PRODUTO, F3 AS BASE ', [fGetNomeProduto(stlTabelas.Strings[intCont])]));
    qryCadBas.SQL.Add(Format(' FROM [%s] ', [stlTabelas.Strings[intCont]]));
    qryCadBas.SQL.Add(' WHERE F3 <> "BASE" ');
  End;

  qryCadBas.SQL.Delete(0);
  qryCadBas.Open;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add(' INSERT INTO MAZ_CADBAS ');
  qryGen.SQL.Add('             (BAS_CODBAS, ');
  qryGen.SQL.Add('              BAS_PRODUT, ');
  qryGen.SQL.Add('              BAS_CODUNI, ');
  qryGen.SQL.Add('              AUTOINCREM) ');
  qryGen.SQL.Add(' VALUES (:BAS_CODBAS, ');
  qryGen.SQL.Add('         :BAS_PRODUT, ');
  qryGen.SQL.Add('         :BAS_CODUNI, ');
  qryGen.SQL.Add('         :AUTOINCREM); ');

  fAjustaInicialAutoIncremento('MAZ_CADBAS', VS_strCodEmp);
  pRegistraAcao('Processando cadastro de bases...');
  While Not qryCadBas.Eof Do
  Begin

    qryGen.ParamByName('BAS_CODBAS').AsString := AnsiUpperCase(qryCadBas.FieldByName('BASE').AsString);
    qryGen.ParamByName('BAS_PRODUT').AsString := AnsiUpperCase(qryCadBas.FieldByName('PRODUTO').AsString);

    For intCont := 1 To 3 Do
    Begin
      qryGen.ParamByName('BAS_CODUNI').AsString := arrUnidade[intCont];
      qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MAZ_CADBAS', VS_strCodEmp);

      Try
        qryGen.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT Then
          Begin
            qryCadBas.Free;
            stlTabelas.Free;
            qryGen.Free;
            Raise;
          End;
        End;
      End;
    End;

    pRegistraProgresso(0, qryCadBas.RecNo, qryCadBas.RecordCount);
    qryCadBas.Next;
  End;
  pRegistraAcao('Cadastro de bases processado com sucesso!');

  qryCadBas.Free;
  stlTabelas.Free;
  qryGen.Free;
end;

procedure TMaza.pProcessarCadCol;
  Var
    qryCadCol: TADOQuery;
    stlTabelas: TStringList;
    intCont: Integer;
    qryGen: TUniQuery;
    intCol: Integer;
  Const
    Tabs: Array [1..4] of String = ('F4', 'F6', 'F8', 'F10');
    Cols: Array [1..4] of String = ('COL1', 'COL2', 'COL3', 'COL4');
begin
  qryCadCol := TADOQuery.Create(Self);
  qryCadCol.ConnectionString := fGetConnectionString(strPath);
  stlTabelas := fGetNomesTabelas();

  For intCont := 0 To stlTabelas.Count - 1 Do
  Begin
    For intCol := 1 To 4 Do
    Begin
      qryCadCol.SQL.Add(' UNION ');
      qryCadCol.SQL.Add(Format(' SELECT DISTINCT %s AS COL', [Tabs[intCol]]));
      qryCadCol.SQL.Add(Format(' FROM [%s] ', [stlTabelas.Strings[intCont]]));
      qryCadCol.SQL.Add(Format(' WHERE %s <> "%s" ', [Tabs[intCol], Cols[intCol]]));
    End;
  End;

  qryCadCol.SQL.Delete(0);
  qryCadCol.Open;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add(' INSERT INTO MAZ_CADCOL ');
  qryGen.SQL.Add('             (COL_CODCOL, ');
  qryGen.SQL.Add('              AUTOINCREM) ');
  qryGen.SQL.Add(' VALUES (:COL_CODCOL, ');
  qryGen.SQL.Add('         :AUTOINCREM) ');

  fAjustaInicialAutoIncremento('MAZ_CADCOL', VS_strCodEmp);
  pRegistraAcao('Processando cadastro de colorantes...');
  While Not qryCadCol.Eof Do
  Begin

    qryGen.ParamByName('COL_CODCOL').AsString := AnsiUpperCase(qryCadCol.FieldByName('COL').AsString);
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MAZ_CADCOL', VS_strCodEmp);

      Try
        qryGen.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT Then
          Begin
            qryCadCol.Free;
            stlTabelas.Free;
            qryGen.Free;
            Raise;
          End;
        End;
      End;
      
    qryCadCol.Next;
    pRegistraProgresso(0, qryCadCol.RecNo, qryCadCol.RecordCount);
  End;
  pRegistraAcao('Cadastro de bases processado com sucesso!');

  qryCadCol.Free;
  stlTabelas.Free;
  qryGen.Free;
end;

procedure TMaza.pProcessarCadMaz;
  Var
    qryCadGen: TADOQuery;
    stlTabelas: TStringList;
    intCont: Integer;
    qryGen: TUniQuery;
    intForms: Integer;
    intAuto: Integer;
  Const
    arrUnidade: Array[1..3] Of String = ('QT', 'GL', 'LA');
    arrQtds: Array[1..3] Of Double = (0.25, 1.0, 5.0);
    arrForms: Array[1..4] Of String = ('F4', 'F6', 'F8', 'F10');
    arrCQtds: Array[1..4] Of String = ('F5', 'F7', 'F9', 'F11');
begin
  qryCadGen := TADOQuery.Create(Self);
  qryCadGen.ConnectionString := fGetConnectionString(strPath);
  stlTabelas := fGetNomesTabelas();

  For intCont := 0 To stlTabelas.Count - 1 Do
  Begin
    qryCadGen.SQL.Add(' UNION ');
    qryCadGen.SQL.Add(Format(' SELECT DISTINCT %s AS PRODUTO, * FROM [%s] WHERE F2 <> "Color Name" ',
                                  [fGetNomeProduto(stlTabelas.Strings[intCont]), stlTabelas.Strings[intCont]]));
  End;

  qryCadGen.SQL.Delete(0);
  qryCadGen.Open;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'TRUNCATE TABLE MAZ_CADMAZ';
  qryGen.ExecSql;

  qryGen.Sql.Clear;
  qryGen.SQL.Add(' INSERT DELAYED INTO MAZ_CADMAZ ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              MAZ_COLNUM, ');
  qryGen.SQL.Add('              MAZ_COLNAM, ');
  qryGen.SQL.Add('              MAZ_CODBAS, ');
  qryGen.SQL.Add('              MAZ_PRODUT, ');
  qryGen.SQL.Add('              MAZ_CODUNI, ');

  For intForms := 1 To 4 Do
  Begin
    qryGen.SQL.Add('              MAZ_CODC' + fStrZero(intForms, 2) + ', ');
    qryGen.SQL.Add('              MAZ_QTDC' + fStrZero(intForms, 2) + ', ');
  End;

  qryGen.SQL.Add('              MAZ_CODNFM) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :MAZ_COLNUM, ');
  qryGen.SQL.Add('         :MAZ_COLNAM, ');
  qryGen.SQL.Add('         :MAZ_CODBAS, ');
  qryGen.SQL.Add('         :MAZ_PRODUT, ');
  qryGen.SQL.Add('         :MAZ_CODUNI, ');

  For intForms := 1 To 4 Do
  Begin
    qryGen.SQL.Add('         :MAZ_CODC' + fStrZero(intForms, 2) + ', ');
    qryGen.SQL.Add('         :MAZ_QTDC' + fStrZero(intForms, 2) + ', ');
  End;

  qryGen.SQL.Add('         :MAZ_CODNFM) ');

  fAjustaInicialAutoIncremento('MAZ_CADMAZ', VS_strCodEmp);
  intAuto := 1;

  pRegistraAcao('Processando cadastro de fórmulas...');
  While Not qryCadGen.Eof Do
  Begin
    qryGen.ParamByName('MAZ_COLNUM').AsString := AnsiUpperCase(qryCadGen.Fields[1].AsString);
    qryGen.ParamByName('MAZ_COLNAM').AsString := AnsiUpperCase(qryCadGen.FieldByName('F2').AsString);
    qryGen.ParamByName('MAZ_CODBAS').AsString := AnsiUpperCase(qryCadGen.FieldByName('F3').AsString);
    qryGen.ParamByName('MAZ_PRODUT').AsString := AnsiUpperCase(qryCadGen.FieldByName('PRODUTO').AsString);

    For intCont := 1 To 3 Do
    Begin
      For intForms := 1 To 4 Do
      Begin
        qryGen.ParamByName('MAZ_QTDC' + fStrZero(intForms, 2) + '').AsFloat :=
          fStrToFloat(qryCadGen.FieldByName(arrCQtds[intForms]).AsString) * arrQtds[intCont] * 7.39;

        If qryGen.ParamByName('MAZ_QTDC' + fStrZero(intForms, 2) + '').AsFloat > 0 Then
          qryGen.ParamByName('MAZ_CODC' + fStrZero(intForms, 2) + '').AsString :=
            AnsiUpperCase(qryCadGen.FieldByName(arrForms[intForms]).AsString)
        Else
          qryGen.ParamByName('MAZ_CODC' + fStrZero(intForms, 2) + '').Value := Null;
      End;

      qryGen.ParamByName('MAZ_CODUNI').AsString := arrUnidade[intCont];
      qryGen.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intAuto, VS_strCodEmp);
      intAuto := intAuto + 1;
      qryGen.ExecSQL;
    End;

    pRegistraProgresso(0, qryCadGen.RecNo, qryCadGen.RecordCount);
    qryCadGen.Next;
  End;
  pRegistraAcao('Cadastro de fórmulas processado com sucesso!');
  fGravaAutoIncrem('MAZ_CADBAS', intAuto);
  
  qryCadGen.Free;
  stlTabelas.Free;
  qryGen.Free;
end;


end.
