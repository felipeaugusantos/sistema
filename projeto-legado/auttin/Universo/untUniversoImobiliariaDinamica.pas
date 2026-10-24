unit untUniversoImobiliariaDinamica;

interface

uses untTintadeMaquina, Uni, Classes, SysUtils,
  ADODB, untIConfTinta, ComObj, System.StrUtils;

Type
  TUniversoImobiliariaDinamica = class(TTintadeMaquina)
  private
    FstrPath: string;
    conf: IConfTinta;

    procedure SetstrPath(const Value: string);
  protected
    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadUni: Boolean;
  public
    constructor Create(AOwner: TComponent); override;

    Function fRetQuantidadeRegSheet(oleSheet: OleVariant): Integer;
    class function fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
    class procedure pDeletarNovaFormula(strcodigo: String);
    function fOncasParaMl(Oncas: String): Double;
    function fGravarNovasFormulas: Boolean; override;
    function fProcessaArquivos: Boolean;
    function fRetAutoIncremGeracao(Var intAutInc: Integer; strTabela,strCodEmp: String): String;
    procedure pAtualizaAutoIncremGeracao(intAutInc: Integer; strTabela: String);
    property strPath: string read FstrPath write SetstrPath;
  end;

Const
  Arr_Produtos: Array [0 .. 5] of String = ('Esmalte Premium',
    'Premium Acetinado', 'Premium Fosco', 'Premium Semibrilho',
    'Standard Fosco', 'Standard Semibrilho');

implementation

uses untFuncoesSimples, Variants, untFuncoes, DB, untFuncTinta;

{ TUniversoImobiliariaDinamica }

constructor TUniversoImobiliariaDinamica.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  conf := fGetConfTinta('UNI');

  NomeTinta := 'Universo';
  FstrPath := conf.fGet('PATUNI');
end;

procedure TUniversoImobiliariaDinamica.pAtualizaAutoIncremGeracao(intAutInc: Integer; strTabela: String);
  Var
    qryGen: TUniQuery;
begin
  If intAutInc > 0 Then
  Begin

    intAutInc := intAutInc + 1;

    Try

      qryGen := fCriaQuery();
      qryGen.SQL.Text := ' UPDATE PROINC ' +
                         '    SET PRO_AUTINC = :AUTINC ' +
                         '  WHERE PRO_NOMARQ = :NOMARQ ';

      qryGen.ParamByName('AUTINC').AsInteger := intAutInc;
      qryGen.ParamByName('NOMARQ').AsString  := strTabela;
      qryGen.ExecSQL;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;


function TUniversoImobiliariaDinamica.fRetAutoIncremGeracao(Var intAutInc: Integer; strTabela,strCodEmp: String): String;
  Var
    qryGen: TUniQuery;
begin
  If intAutInc = 0 Then
  Begin

    Try

      qryGen := fCriaQuery();
      qryGen.SQL.Text := ' SELECT SQL_NO_CACHE    ' +
                         '   PRO_AUTINC AS AUTINC ' +
                         ' FROM                   ' +
                         '   PROINC               ' +
                         ' WHERE                  ' +
                         '   PRO_NOMARQ = :NOMARQ ';

      qryGen.ParamByName('NOMARQ').AsString := strTabela;
      qryGen.Open;

      intAutInc := qryGen.FieldByName('AUTINC').AsInteger;

    Finally
      FreeAndNil(qryGen);
    End;

  End
  Else
    intAutInc := intAutInc + 1;

  Result := strCodEmp + fStrZero(IntToStr(intAutInc) + strCodEmp, 17);
end;


function TUniversoImobiliariaDinamica.fRetQuantidadeRegSheet(oleSheet: OleVariant): Integer;
var
  blnFimPlan: Boolean;
begin
  Result := 1;
  blnFimPlan := False;

  While not blnFimPlan Do
  Begin
    Inc(Result);
    If oleSheet.Cells[Result, 1].Text = '' Then
    Begin
      blnFimPlan := True;
      Dec(Result);
    End;
  End;
end;

class function TUniversoImobiliariaDinamica.fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
Var
  qryGen: TUniQuery;
  intCont: Integer;
  intUnid: Integer;
Const
  arrUnidad: Array [1 .. 4] Of String = ('TT', 'QT', 'GL', 'LA');
  arrMedida: Array [1 .. 4] Of Double = (0.25, 1, 4, 20);

  procedure Limpar;
  Var
    i: Integer;
  Begin
    For i := 1 To 10 Do
    Begin
      qryGen.ParamByName('CODC' + fStrZero(i, 2)).Value := Null;
      qryGen.ParamByName('QTDC' + fStrZero(i, 2)).Value := Null;
    End;
  End;

begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE '+
                     '  FROM UNI_CADUNI '+
                     ' WHERE UNI_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
  qryGen.SQL.Clear;

  qryGen.SQL.Add(' INSERT INTO UNI_CADUNI ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              UNI_GRUPO_, ');
  qryGen.SQL.Add('              UNI_PRODUT, ');
  qryGen.SQL.Add('              UNI_CODTIN, ');
  qryGen.SQL.Add('              UNI_DESCOR, ');
  qryGen.SQL.Add('              UNI_CODBAS, ');
  qryGen.SQL.Add('              UNI_CODUNI, ');
  qryGen.SQL.Add('              UNI_DTACAD, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              UNI_CODC' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              UNI_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('          UNI_CODNFM) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :GRUPO_, ');
  qryGen.SQL.Add('         :PRODUT, ');
  qryGen.SQL.Add('         :CODTIN, ');
  qryGen.SQL.Add('         :DESCOR, ');
  qryGen.SQL.Add('         :CODBAS, ');
  qryGen.SQL.Add('         :CODUNI, ');
  qryGen.SQL.Add('         :DTACAD, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('       :CODC' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('       :QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('         :CODNFM); ');

  qryGen.ParamByName('GRUPO_').AsString := qryCadNfm.FieldbyName('NFM_GRUPO_').AsString;
  qryGen.ParamByName('PRODUT').AsString := qryCadNfm.FieldbyName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODTIN').AsString := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;
  qryGen.ParamByName('DESCOR').AsString := qryCadNfm.FieldbyName('NFM_DESCOR').AsString;
  qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldbyName('NFM_CODBAS').AsString;
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;
  qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldbyName('NFM_DTACAD').AsDateTime;

  Limpar;

  For intUnid := 1 To 4 Do
  Begin
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('UNI_CADUNI',VS_strCodEmp);
    qryGen.ParamByName('CODUNI').AsString     := arrUnidad[intUnid];

    For intCont := 1 To 10 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldbyName('NFM_CODC' + fStrZero(intCont, 2)).AsString) Then
        Break;

      qryGen.ParamByName('CODC' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldbyName('NFM_CODC' + fStrZero(intCont, 2)).AsString;
      qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldbyName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrMedida[intUnid];
    End;

    qryGen.ExecSQL;
  End;

  Result := True;

end;

function TUniversoImobiliariaDinamica.fGravarNovasFormulas: Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT * FROM UNI_CADNFM');
  qryGen.Open;

  pRegistraAcao('Cadastrando Novas Fórmulas');
  While Not qryGen.Eof Do
  Begin
    fGravarNovaFormula(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;

  pRegistraAcao('Cadastro de Novas Fórmulas Realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TUniversoImobiliariaDinamica.fProcessaArquivos: Boolean;
begin

  If fEmptyStr(FstrPath) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := fProcessaCadCol;

  If Result Then
   Result := fProcessaCadBas;

  If Result Then
    Result := fProcessaCadUni;


end;


Function  TUniversoImobiliariaDinamica.fProcessaCadBas: Boolean;
Var
  qryCadBas     : TUniQuery;

  olePlanilha   : OleVariant;
  oleSheet      : OleVariant;

  intMaxLines   : Integer;
  intProgresso  : Integer;
  intSheet      : Integer;

  intRow        : Integer;
  intQtdFolhas  : Integer;
  intUni        : Integer;
Const
  arrUnidad: Array [0 .. 3] of String = ('TT', 'QT', 'GL', 'LA');
begin
  Result := False;

  Try

    Try

      If Not FileExists(FstrPath) Then
      Begin
        pRegistraAcao('O Arquivo não foi encontrado!');
        Exit;
      End;

      olePlanilha         := CreateOleObject('Excel.Application');
      olePlanilha.Visible := False;

      olePlanilha.WorkBooks.Open(FstrPath);

      pRegistraAcao('Abrindo cadastro de bases!');

      intQtdFolhas := olePlanilha.WorkSheets.Count;

      qryCadBas := fCriaQuery();
      qryCadBas.SQL.Text := 'SELECT * '+
                            '  FROM UNI_CADBAS ';
      qryCadBas.Open;


      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := olePlanilha.WorkSheets[intSheet];

        pRegistraAcao('Processando o arquivo ' + String(oleSheet.Name));

        intMaxLines := fRetQuantidadeRegSheet(oleSheet);

        intProgresso := 0;

        For intRow := 3 To intMaxLines Do
        Begin
          For intUni := 0 To 3 Do
          Begin

            If Not qryCadBas.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD',
              VarArrayOf([Trim(UpperCase(oleSheet.Range['B' + IntToStr(intRow)].Text)), UpperCase(oleSheet.Name), arrUnidad[intUni]]), []) Then
            Begin
              Try
                qryCadBas.Insert;
                qryCadBas.FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem('UNI_CADBAS', VS_strCodEmp);
                qryCadBas.FieldbyName('BAS_CODBAS').AsString := Trim(UpperCase(oleSheet.Range['B' + IntToStr(intRow)].Text));
                qryCadBas.FieldbyName('BAS_PRODUT').AsString := UpperCase(oleSheet.Name);
                qryCadBas.FieldbyName('BAS_UNIDAD').AsString := arrUnidad[intUni];
                qryCadBas.Post;
              Except
                on E: Exception do
                  pRegistraAcao('Erro ao gerar o cadastro de bases.' + #13 + E.message);
              End;

            End;

          End;

          Inc(intProgresso);
          pRegistraProgresso(0, intProgresso, intMaxLines);

        End;

      End;

      pRegistraProgresso(0, 0 , 0);
      pRegistraAcao('Cadastro de bases gerado com sucesso!');
      Result := True;
    Except
      on E: Exception do
      begin
        pRegistraAcao('Ocorreu erro ao gerar o cadastro de bases.' + #13 + E.message);
      end;
    End;

  Finally
    olePlanilha.Quit;

    if Assigned(qryCadBas) Then FreeAndNil(qryCadBas);
  End;

end;

function TUniversoImobiliariaDinamica.fProcessaCadCol: Boolean;
Var
  qryCadCol    : TUniQuery;

  intMaxLines  : Integer;
  intProgresso : Integer;

  olePlanilha  : OleVariant;
  oleSheet     : OleVariant;

  intSheet     : Integer;
  intRow       : Integer;
  intQtdFolhas : Integer;
  intCol       : Integer;

  stlColorantes: TStringList;

  strCodCol : String;
begin
  Result := false;

  Try

    Try

      If Not FileExists(FstrPath) Then
      Begin
        pRegistraAcao('O Arquivo não foi encontrado!');
        Exit;
      End;

      olePlanilha := CreateOleObject('Excel.Application');
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(FstrPath);

      pRegistraAcao('Abrindo cadastro de colorantes!');

      qryCadCol          := fCriaQuery();
      qryCadCol.SQL.Text := 'SELECT * '+
                            '  FROM UNI_CADCOL '+
                            ' WHERE FALSE;';
      qryCadCol.Open;

      intQtdFolhas := olePlanilha.WorkSheets.Count;

      // Posicoes no arquivo
      stlColorantes := TStringList.Create;
      stlColorantes.CommaText := 'C,F,I,L,O';

      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := olePlanilha.WorkSheets[intSheet];

        pRegistraAcao('Processando o arquivo ' + String(oleSheet.Name));

        intMaxLines := fRetQuantidadeRegSheet(oleSheet);

        intProgresso := 0;

        For intRow := 3 To intMaxLines Do
        Begin

          For intCol := 0 To stlColorantes.Count - 1 Do
          Begin

            strCodCol := oleSheet.Range[stlColorantes[intCol] + IntToStr(intRow)].Text;

            If Not ((qryCadCol.Locate('COL_CODCOL', strCodCol , [])) Or (fEmptyStr(strCodCol))) Then
            Begin
              Try
                qryCadCol.Insert;
                qryCadCol.FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem('UNI_CADCOL', VS_strCodEmp);
                qryCadCol.FieldbyName('COL_CODCOL').AsString := oleSheet.Range[stlColorantes[intCol] + IntToStr(intRow)].Text;
                qryCadCol.FieldbyName('COL_DESCRI').AsString := oleSheet.Range[stlColorantes[intCol] + IntToStr(intRow)].Text;
                qryCadCol.Post;
              Except
                on E: Exception do
                  pRegistraAcao('Erro ao gerar o cadastro de colorantes.' + #13 + E.message);
              End;

            End;

          End;

          Inc(intProgresso);
          pRegistraProgresso(0, intProgresso, intMaxLines);

        End;

      End;

      pRegistraProgresso(0, 0 , 0);
      pRegistraAcao('Cadastro de colorantes gerado com sucesso!');

      Result := True;
    Except
      on E: Exception do
      begin
        pRegistraAcao('Ocorreu erro ao gerar o cadastro de colorantes.' + #13 + E.message);
      end;
    End;

  Finally
    olePlanilha.Quit;

    If Assigned(qryCadCol) Then FreeAndNil(qryCadCol);
    If Assigned(stlColorantes) Then FreeAndNil(stlColorantes);
  End;

end;

function TUniversoImobiliariaDinamica.fProcessaCadUni: Boolean;
var
  stlColorantes : TStringList;
  stlParteInt   : TStringList;
  stlPartFrac   : TStringList;
  qryCadCor     : TUniQuery;

  olePlanilha   : OleVariant;
  oleSheet      : OleVariant;

  intSheet      : Integer;
  intRow        : Integer;
  intQtdFolhas  : Integer;

  intCol        : Integer;
  intUnidade    : Integer;

  intMaxLines   : Integer;
  intProgresso  : Integer;
  intAutoincrem : Integer;

Const
  arrUnidad: Array [1 .. 4] of String = ('TT', 'QT', 'GL', 'LA');
  arrMedid:  Array [1 .. 4] of Double = (0.0625, 0.25, 1, 5);

begin
  Result := false;

  pZapTable('UNI_CADUNI');

  Try

    Try

      If Not FileExists(FstrPath) Then
      Begin
        pRegistraAcao('O Arquivo não foi encontrado!');
        Exit;
      End;

      olePlanilha := CreateOleObject('Excel.Application');
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(FstrPath);

      pRegistraAcao('Abrindo cadastro de cores!');

      qryCadCor := fCriaQuery();
      qryCadCor.SQL.Text := 'SELECT * '+
                            '  FROM UNI_CADUNI '+
                            ' WHERE FALSE;';
      qryCadCor.Open;

      intQtdFolhas := olePlanilha.WorkSheets.Count;

      stlColorantes := TStringList.Create;
      stlColorantes.CommaText := 'C,F,I,L,O';

      stlParteInt := TStringList.Create;
      stlParteInt.CommaText := 'D,G,J,M,P';

      stlPartFrac := TStringList.Create;
      stlPartFrac.CommaText := 'E,H,K,N,Q';

      intAutoIncrem := 0;

      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := olePlanilha.WorkSheets[intSheet];

        pRegistraAcao('Processando o arquivo ' + String(oleSheet.Name));

        intMaxLines := fRetQuantidadeRegSheet(oleSheet);

        intProgresso := 0;

        For intRow := 3 To intMaxLines Do
        Begin

          For intUnidade := 1 To 4 Do
          Begin

            Try
              qryCadCor.Insert;

              qryCadCor.FieldbyName('AUTOINCREM').AsString := fRetAutoIncremGeracao(intAutoIncrem, 'UNI_CADUNI', VS_strCodEmp );
              qryCadCor.FieldbyName('UNI_CODTIN').AsString := UpperCase(oleSheet.Range['A' + IntToStr(intRow)].Text);
              qryCadCor.FieldbyName('UNI_DESCOR').AsString := UpperCase(oleSheet.Range['A' + IntToStr(intRow)].Text);
              qryCadCor.FieldbyName('UNI_PRODUT').AsString := UpperCase(String(oleSheet.Name));
              qryCadCor.FieldbyName('UNI_CODBAS').AsString := UpperCase(oleSheet.Range['B' + IntToStr(intRow)].Text);
              qryCadCor.FieldbyName('UNI_GRUPO_').AsString := 'UNICOLORS';
              qryCadCor.FieldbyName('UNI_CODUNI').AsString := arrUnidad[intUnidade];


              For intCol := 0 To stlColorantes.Count - 1 Do
              Begin
                qryCadCor.FieldbyName('UNI_CODC' + fStrZero(intCol + 1, 2)).AsString := oleSheet.Range[stlColorantes[intCol] + IntToStr(intRow)].Text;
                qryCadCor.FieldbyName('UNI_QTDC' + fStrZero(intCol + 1, 2)).AsFloat  :=
                  fOncasParaMl(oleSheet.Range[stlParteInt[intCol] + IntToStr(intRow)].Text + 'Y' + oleSheet.Range[stlPartFrac[intCol] + IntToStr(intRow)].Text ) * arrMedid[intUnidade];
              End;

              qryCadCor.Post;
            Except
              on E: Exception do
                pRegistraAcao('Erro ao gerar o cadastro de cores.' + #13 + E.message);
            End;

          End;

          Inc(intProgresso);
          pRegistraProgresso(0, intProgresso, intMaxLines);

        End;

      End;

      pAtualizaAutoIncremGeracao(intAutoIncrem, 'UNI_CADUNI');

      pRegistraProgresso(0, 0 , 0);
      pRegistraAcao('Cadastro de cores gerado com sucesso!');

    Except
      on E: Exception do
      begin
        pRegistraAcao('Ocorreu erro ao gerar o cadastro de cores.' + #13 + E.message);
      end;
    End;

  Finally
    olePlanilha.Quit;

    If Assigned(qryCadCor)     Then FreeAndNil(qryCadCor);
    If Assigned(stlColorantes) Then FreeAndNil(stlColorantes);
    If Assigned(stlParteInt)   Then FreeAndNil(stlParteInt);
    If Assigned(stlPartFrac)   Then FreeAndNil(stlPartFrac);
  End;

end;

class procedure TUniversoImobiliariaDinamica.pDeletarNovaFormula(strcodigo: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Text := 'DELETE '+
                       '  FROM UNI_CADUNI '  +
                       ' WHERE UNI_CODNFM = :CODNFM';
    qryGen.ParamByName('CODNFM').AsString := strcodigo;
    qryGen.ExecSQL;

  Finally
    If Assigned(qryGen) Then FreeAndNil(qryGen);
  End;
end;

function TUniversoImobiliariaDinamica.fOncasParaMl(Oncas: String): Double;
Var
  strInteira  : String;
  strFracao   : String;
  strOncas    : String;
begin
  strOncas   := AnsiReplaceStr(Oncas,'.',',');
  strInteira := Copy(strOncas, 0, Pos('Y', strOncas) - 1);

  strFracao  := Copy(strOncas, Pos('Y', strOncas) + 1, Length(strOncas));
  Result     := fStrToFloat(FormatFloat('0.000000', fStrToFloat(strInteira) * 29.5735295625 + fStrToFloat(strFracao)  * 0.61611520));
end;


procedure TUniversoImobiliariaDinamica.SetstrPath(const Value: string);
begin
  FstrPath := Value;
end;

end.
