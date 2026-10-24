unit untAdvanceIndustrialDinamica;

interface

uses untTintadeMaquina, Uni, Classes, SysUtils, untIConfTinta;

Type
  TAdvanceIndustrialDinamica = class(TTintadeMaquina)
  private
    FstrPat: String;
    conf: IConfTinta;
    function fFormataFloat(strValor: String): Double;
    function fAjustaFloat(fltValor: Double): Double;
    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadAdv: Boolean;
    procedure SetstrPat(const Value: String);
    function fGetPesoEspecificoBase(strCodBas: String): Double;
    function fGetPesoEspecificoCol(strCodCol: String): Double;
  public
    function fGravarNovasFormulas: Boolean; override;
    class function fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
    class function fDeletaNovaFormula(strCodNfm: String): Boolean;

    procedure pProcessaArquivos;
    property strPat: String read FstrPat write SetstrPat;
    constructor Create(AOwner: TComponent); override;
  End;

implementation

uses untFuncTinta, untFuncoesSimples, StrUtils, untFuncoes, DB;

{ TAdvanceImobiliariaDinamica }

constructor TAdvanceIndustrialDinamica.Create(AOwner: TComponent);
begin
  inherited;
  conf      := fGetConfTinta('ADV');
  NomeTinta := 'Advance';
  FstrPat   := conf.fGet('PATADV'); //fArqIniTinta(0, 'ADVANCE', 'PATADV', '');

end;

function TAdvanceIndustrialDinamica.fFormataFloat(
  strValor: String): Double;
begin
  Result := fStrToFloat(Trim(AnsiReplaceStr(strValor, '.', ',')));
end;

function TAdvanceIndustrialDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen : TUniQuery;
begin

  Result := True;
  qryGen := fCriarQuery('SELECT * FROM ADV_CADNFM');
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
end;

procedure TAdvanceIndustrialDinamica.pProcessaArquivos;
begin
  fProcessaCadCol;
  fProcessaCadBas;
  fProcessaCadAdv;
end;

function TAdvanceIndustrialDinamica.fProcessaCadAdv: Boolean;
var
  arqGen: TextFile;
  strNomArq: String;
  qryGen: TUniQuery;
  strLinha: String;

  intLinhas: Integer;
  intLinha: Integer;
  intCont: Integer;
  intUnid: Integer;
  blnUtf8: Boolean;
const
  arrUnidades: Array [1..3] of String = ('QT', 'GL', 'LA');
  arrMedida: Array [1..3] Of Double = (0.9, 3.6, 18);
begin

  Try
    strNomArq := FstrPat + '\formulas.txt';
    intLinhas := fContaLihas(strNomArq);
    blnUtf8 := conf.fGetBoolean('UTF8');
    AssignFile(arqGen, strNomArq);
    Reset(arqGen);

    qryGen := fCriaQuery();

    qryGen.SQL.Text := 'TRUNCATE TABLE ADV_CADADV';
    qryGen.ExecSQL;
    qryGen.SQL.Clear;

    fGravaAutoIncrem('ADV_CADADV', 1);

    qryGen.SQL.Add(' INSERT DELAYED INTO ADV_CADADV ');
    qryGen.SQL.Add('             (AUTOINCREM, ');
    qryGen.SQL.Add('              ADV_CARTA_, ');
    qryGen.SQL.Add('              ADV_PRODUT, ');
    qryGen.SQL.Add('              ADV_FORMUL, ');
    qryGen.SQL.Add('              ADV_BASE01, ');
    qryGen.SQL.Add('              ADV_BASE02, ');
    qryGen.SQL.Add('              ADV_BASE03, ');
    qryGen.SQL.Add('              ADV_QTDB01, ');
    qryGen.SQL.Add('              ADV_QTDB02, ');
    qryGen.SQL.Add('              ADV_QTDB03, ');
    qryGen.SQL.Add('              ADV_MD5KEY, ');

    For intCont := 1 To 12 Do
    Begin
      qryGen.SQL.Add('              ADV_CODC' + fStrZero(intCont, 2) + ', ');
      qryGen.SQL.Add('              ADV_QTDC' + fStrZero(intCont, 2) + ', ');
    End;

    qryGen.SQL.Add('              ADV_UNIDAD) ');
    qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryGen.SQL.Add('         :CARTA_, ');
    qryGen.SQL.Add('         :PRODUT, ');
    qryGen.SQL.Add('         :FORMUL, ');
    qryGen.SQL.Add('         :BASE01, ');
    qryGen.SQL.Add('         :BASE02, ');
    qryGen.SQL.Add('         :BASE03, ');
    qryGen.SQL.Add('         :QTDB01, ');
    qryGen.SQL.Add('         :QTDB02, ');
    qryGen.SQL.Add('         :QTDB03, ');
    qryGen.SQL.Add('         :MD5KEY, ');

    For intCont := 1 To 12 Do
    Begin
      qryGen.SQL.Add('         :CODC' + fStrZero(intCont, 2) + ', ');
      qryGen.SQL.Add('         :QTDC' + fStrZero(intCont, 2) + ', ');
    End;

    qryGen.SQL.Add('         :UNIDAD); ');

    pRegistraAcao('Cadastrando formulas...');
    intLinha := 1;

    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen, strLinha);
      if blnUtf8 then strLinha := Utf8ToAnsi(AnsiString(strLinha));

      for intUnid := 1 to 3 do
      begin
        Try
          qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADV_CADADV', VS_strCodEmp);
          qryGen.ParamByName('FORMUL').AsString := Trim(Copy(strLinha, 1, 50));
          qryGen.ParamByName('CARTA_').AsString := Trim(Copy(strLinha, 51, 50));
          qryGen.ParamByName('PRODUT').AsString := Trim(Copy(strLinha, 101, 50));

          qryGen.ParamByName('BASE01').AsString := Trim(Copy(strLinha, 511, 10));


          {*******************************************}
          {* NÃO TEM SECATIVO                        *}
          {****************************************PH*}
          If LeftStr(Trim(Copy(strLinha, 541, 10)), 4) = '8116' Then
            qryGen.ParamByName('BASE02').AsString := ''
          Else
            qryGen.ParamByName('BASE02').AsString := Trim(Copy(strLinha, 541, 10));

          If LeftStr(Trim(Copy(strLinha, 571, 10)), 4) = '8116' Then
            qryGen.ParamByName('BASE03').AsString := ''
          Else
            qryGen.ParamByName('BASE03').AsString := Trim(Copy(strLinha, 571, 10));

          {*******************************************}
          {* CONVERTER EM 900ML                      *}
          {****************************************PH*}
          qryGen.ParamByName('QTDB01').AsFloat := fAjustaFloat(fFormataFloat(Copy(strLinha, 521, 20)) * arrMedida[intUnid] / fGetPesoEspecificoBase(qryGen.ParamByName('BASE01').AsString));

          If fEmptyStr(qryGen.ParamByName('BASE02').AsString) Then
            qryGen.ParamByName('QTDB02').AsFloat := 0
          Else
            qryGen.ParamByName('QTDB02').AsFloat := fAjustaFloat(fFormataFloat(Copy(strLinha, 551, 20)) * arrMedida[intUnid] / fGetPesoEspecificoBase(qryGen.ParamByName('BASE02').AsString));

          If fEmptyStr(qryGen.ParamByName('BASE03').AsString) Then
            qryGen.ParamByName('QTDB03').AsFloat := 0
          Else
            qryGen.ParamByName('QTDB03').AsFloat := fAjustaFloat(fFormataFloat(Copy(strLinha, 581, 20)) * arrMedida[intUnid] / fGetPesoEspecificoBase(qryGen.ParamByName('BASE03').AsString));

          For intCont := 1 To 12 Do
          Begin
            qryGen.ParamByName('CODC' + fStrZero(intCont, 2)).AsString := Trim(Copy(strLinha, 151 + (30 * (intCont - 1)), 10));

            If fEmptyStr(qryGen.ParamByName('CODC' + fStrZero(intCont, 2)).AsString) Then
              qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat := 0
            Else
              qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
                fAjustaFloat(fFormataFloat(Copy(strLinha, 161 + (30 * (intCont - 1)), 20)) * arrMedida[intUnid] /
                  fGetPesoEspecificoCol(qryGen.ParamByName('CODC' + fStrZero(intCont, 2)).AsString));
          End;

          qryGen.ParamByName('UNIDAD').AsString := arrUnidades[intUnid];
          qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('CARTA_').AsString +
                                                  qryGen.ParamByName('PRODUT').AsString +
                                                  qryGen.ParamByName('FORMUL').AsString +
                                                  qryGen.ParamByName('UNIDAD').AsString);
          qryGen.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then
              pRegistraAcao(Format('A Fórmula [%s - %s - %s] já está cadastrada. [%s]',
                [qryGen.ParamByName('FORMUL').AsString,
                qryGen.ParamByName('CARTA_').AsString,
                qryGen.ParamByName('PRODUT').AsString,
                E.Message]))
            Else
              pRegistraAcao(Format('Não foi possível cadastrar a formula, [%s][%d][%s - %s]',
                [strNomArq, intLinha, E.ClassName, E.Message]));
          End;

          on E: Exception do
          begin
            pRegistraAcao(Format('Não foi possível cadastrar a formula, [%s][%d][%s - %s]',
              [strNomArq, intLinha, E.ClassName, E.Message]));
          end;  
        End;
      end;

      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
    End;

    pRegistraAcao('Cadastro de formulas realizado com sucesso!');
    CloseFile(arqGen);
    Result := True;
  Except

    On E: EInOutError Do
    Begin
      E.Message := 'Não foi possível acessar o arquivo ' + strNomArq;
      Raise;
    End;

    On E: Exception Do
    Begin
      E.Message := Format(E.Message, [E.ClassName]);
      Raise;
    End;
  End;
end;

function TAdvanceIndustrialDinamica.fProcessaCadBas: Boolean;
var
  arqGen: TextFile;
  strNomArq: String;
  qryGen: TUniQuery;
  strLinha: String;

  intLinhas: Integer;
  intLinha: Integer;
  intCont: Integer;
  blnUtf8: Boolean;
const
  arrUnidades: Array [1..3] of String = ('QT', 'GL', 'LA');
begin
  Try
    strNomArq := FstrPat + '\resinas.txt';
    intLinhas := fContaLihas(strNomArq);
    blnUtf8 := conf.fGetBoolean('UTF8');
    AssignFile(arqGen, strNomArq);
    Reset(arqGen);

    qryGen := fCriaQuery();

    qryGen.SQL.Add(' INSERT INTO ADV_CADBAS ');
    qryGen.SQL.Add('             (AUTOINCREM, ');
    qryGen.SQL.Add('              BAS_CODITE, ');
    qryGen.SQL.Add('              BAS_CODBAS, ');
    qryGen.SQL.Add('              BAS_DESCRI, ');
    qryGen.SQL.Add('              BAS_UNIDAD, ');
    qryGen.SQL.Add('              BAS_PESESP, ');
    qryGen.SQL.Add('              BAS_GRUPO_, ');
    qryGen.SQL.Add('              BAS_PRECUS, ');
    qryGen.SQL.Add('              BAS_MARGEM, ');
    qryGen.SQL.Add('              BAS_PREVEN) ');
    qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryGen.SQL.Add('         :CODITE, ');
    qryGen.SQL.Add('         :CODBAS, ');
    qryGen.SQL.Add('         :DESCRI, ');
    qryGen.SQL.Add('         :UNIDAD, ');
    qryGen.SQL.Add('         :PESESP, ');
    qryGen.SQL.Add('         :GRUPO, ');
    qryGen.SQL.Add('         :PRECUS, ');
    qryGen.SQL.Add('         :MARGEM, ');
    qryGen.SQL.Add('         :PREVEN); ');

    pRegistraAcao('Cadastrando bases...');
    intLinha := 1;
    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen, strLinha);
      if blnUtf8 then strLinha := Utf8ToAnsi(AnsiString(strLinha));

      for intCont := 1 to 3 do
      begin
        qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADV_CADBAS', VS_strCodEmp);
        qryGen.ParamByName('CODBAS').AsString := Trim(Copy(strLinha, 1, 16));
        qryGen.ParamByName('DESCRI').AsString := Trim(Copy(strLinha, 17, 50));
        qryGen.ParamByName('UNIDAD').AsString := arrUnidades[intCont];
        qryGen.ParamByName('PESESP').AsFloat := fFormataFloat(Copy(strLinha, 67, 20));
        qryGen.ParamByName('GRUPO').AsString := Trim(Copy(strLinha, 268, 50));

        Try
          qryGen.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then
              pRegistraAcao(Format('A base [%s - %s - %s] já está cadastrada. [%s]',
                [qryGen.ParamByName('CODBAS').AsString,
                qryGen.ParamByName('DESCRI').AsString,
                qryGen.ParamByName('UNIDAD').AsString,
                E.Message]) )
            Else
              pRegistraAcao(Format('Não foi possível cadastrar a base, [%s][%d][%s - %s]',
                [strNomArq, intLinha, E.ClassName, E.Message]));
          End;

          on E: Exception do
          begin
            pRegistraAcao(Format('Não foi possível cadastrar a base, [%s][%d][%s - %s]',
              [strNomArq, intLinha, E.ClassName, E.Message]));
          end;  
        End;
      end;

      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
    End;

    pRegistraAcao('Cadastro de bases realizado com sucesso!');
    CloseFile(arqGen);
    Result := True;
  Except

    On E: EInOutError Do
    Begin
      E.Message := 'Não foi possível acessar o arquivo ' + strNomArq;
      Raise;
    End;

    On E: Exception Do
    Begin
      E.Message := Format(E.Message, [E.ClassName]);
      Raise;
    End;
  End;
end;

function TAdvanceIndustrialDinamica.fProcessaCadCol: Boolean;
var
  arqGen: TextFile;
  strNomArq: String;
  qryGen: TUniQuery;
  strLinha: String;

  intLinhas: Integer;
  intLinha: Integer;
  blnUtf8: Boolean;
begin
  Try
    strNomArq := FstrPat + '\corantes.txt';
    intLinhas := fContaLihas(strNomArq);
    AssignFile(arqGen, strNomArq);
    Reset(arqGen);
    blnUtf8 := conf.fGetBoolean('UTF8');

    qryGen := fCriaQuery();

    qryGen.SQL.Add(' INSERT INTO ADV_CADCOL ');
    qryGen.SQL.Add('             (AUTOINCREM, ');
    qryGen.SQL.Add('              COL_CODCOL, ');
    qryGen.SQL.Add('              COL_DESCRI, ');
    qryGen.SQL.Add('              COL_PESESP, ');
    qryGen.SQL.Add('              COL_PRECUS, ');
    qryGen.SQL.Add('              COL_MARGEM, ');
    qryGen.SQL.Add('              COL_PREVEN, ');
    qryGen.SQL.Add('              COL_EMBALA, ');
    qryGen.SQL.Add('              COL_CODITE) ');
    qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryGen.SQL.Add('         :CODCOL, ');
    qryGen.SQL.Add('         :DESCRI, ');
    qryGen.SQL.Add('         :PESESP, ');
    qryGen.SQL.Add('         :PRECUS, ');
    qryGen.SQL.Add('         :MARGEM, ');
    qryGen.SQL.Add('         :PREVEN, ');
    qryGen.SQL.Add('         :EMBALA, ');
    qryGen.SQL.Add('         :CODITE); ');

    pRegistraAcao('Cadastrando colorantes...');
    intLinha := 1;
    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen, strLinha);
      if blnUtf8 then strLinha := Utf8ToAnsi(AnsiString(strLinha));
      
      qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADV_CADCOL', VS_strCodEmp);
      qryGen.ParamByName('CODCOL').AsString := Trim(Copy(strLinha, 1, 10));
      qryGen.ParamByName('DESCRI').AsString := Trim(Copy(strLinha, 11, 50));
      qryGen.ParamByName('PESESP').AsFloat := fFormataFloat(Copy(strLinha, 61, 20));
      qryGen.ParamByName('EMBALA').AsFloat := 3600;

      Try
        qryGen.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then
            pRegistraAcao(Format('O Colorante [%s - %s] já está cadastrado. [%s]',
              [qryGen.ParamByName('CODCOL').AsString,
               qryGen.ParamByName('DESCRI').AsString,
               E.Message]))
          Else
            pRegistraAcao(Format('Não foi possível cadastrar o colorante, [%s][%d][%s - %s]',
              [strNomArq, intLinha, E.ClassName, E.Message]));
        End;

        on E: Exception do
        begin
          pRegistraAcao(Format('Não foi possível cadastrar o colorante, [%s][%d][%s - %s]',
              [strNomArq, intLinha, E.ClassName, E.Message]));
        end;  
      End;

      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
    End;

    pRegistraAcao('Cadastro de colorantes realizado com sucesso!');
    CloseFile(arqGen);
    Result := True;
  Except

    On E: EInOutError Do
    Begin
      E.Message := 'Não foi possível acessar o arquivo ' + strNomArq;
      Raise;
    End;

    On E: Exception Do
    Begin
      E.Message := Format(E.Message, [E.ClassName]);
      Raise;
    End;
  End;
end;

procedure TAdvanceIndustrialDinamica.SetstrPat(const Value: String);
begin
  FstrPat := Value;
end;

function TAdvanceIndustrialDinamica.fGetPesoEspecificoBase(
  strCodBas: String): Double;
var
  qryGen : TUniQuery;
begin
  Result := 0;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'SELECT BAS_PESESP FROM ADV_CADBAS WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      if qryGen.IsEmpty then
        raise Exception.CreateFmt('Não foi possível encontrar a base [%s]', [strCodBas]);

      Result := qryGen.FieldByName('BAS_PESESP').AsFloat;

      if Result <= 0 then
        raise Exception.CreateFmt('O peso especifico da base [%s] está incorreto [%f]', [strCodBas, Result]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TAdvanceIndustrialDinamica.fGetPesoEspecificoCol(
  strCodCol: String): Double;
var
  qryGen : TUniQuery;
begin
  Result := 0;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'SELECT COL_PESESP FROM ADV_CADCOL WHERE COL_CODCOL = :CODCOL';
      qryGen.ParamByName('CODCOL').AsString := strCodCol;
      qryGen.Open;

      if qryGen.IsEmpty then
        raise Exception.CreateFmt('Não foi possível encontrar o colorante [%s]', [strCodCol]);

      Result := qryGen.FieldByName('COL_PESESP').AsFloat;
      if Result <= 0 then
        raise Exception.CreateFmt('O peso especifico do colorante [%s] está incorreto [%f]', [strCodCol, Result]);      
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TAdvanceIndustrialDinamica.fAjustaFloat(
  fltValor: Double): Double;
begin
  Result := fStrToFloat(FormatFloat('0.00', fltValor));
end;

class function TAdvanceIndustrialDinamica.fGravarNovaFormula(
  qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    intForm: Integer;

  Const
    arrUnids: array[0..2] of String = ('QT', 'GL', 'LA');
    arrFatores: array[0..2] of Double = (1, 4, 20);
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE FROM ADV_CADADV WHERE ADV_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO ADV_CADADV ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              ADV_CARTA_, ');
  qryGen.SQL.Add('              ADV_PRODUT, ');
  qryGen.SQL.Add('              ADV_FORMUL, ');
  qryGen.SQL.Add('              ADV_BASE01, ');
  qryGen.SQL.Add('              ADV_BASE02, ');
  qryGen.SQL.Add('              ADV_BASE03, ');
  qryGen.SQL.Add('              ADV_QTDB01, ');
  qryGen.SQL.Add('              ADV_QTDB02, ');
  qryGen.SQL.Add('              ADV_QTDB03, ');
  qryGen.SQL.Add('              ADV_UNIDAD, ');
  qryGen.SQL.Add('              ADV_MD5KEY, ');
  qryGen.SQL.Add('              ADV_DTACAD, ');

  For intForm := 1 To 15 Do
  Begin
    qryGen.SQL.Add('              ADV_CODC' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('              ADV_QTDC' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('              ADV_CODNFM) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :CARTA_, ');
  qryGen.SQL.Add('         :PRODUT, ');
  qryGen.SQL.Add('         :FORMUL, ');
  qryGen.SQL.Add('         :BASE01, ');
  qryGen.SQL.Add('         :BASE02, ');
  qryGen.SQL.Add('         :BASE03, ');
  qryGen.SQL.Add('         :QTDB01, ');
  qryGen.SQL.Add('         :QTDB02, ');
  qryGen.SQL.Add('         :QTDB03, ');
  qryGen.SQL.Add('         :UNIDAD, ');
  qryGen.SQL.Add('         :MD5KEY, ');
  qryGen.SQL.Add('         :DTACAD, ');

  For intForm := 1 To 15 Do
  Begin
    qryGen.SQL.Add('         :CODC' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('         :QTDC' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('         :CODNFM); ');


  qryGen.ParamByName('CARTA_').AsString := 'PERSONALIZADA';
  qryGen.ParamByName('PRODUT').AsString := 'PERSONALIZADO';
  qryGen.ParamByName('FORMUL').AsString := qryCadNfm.FieldbyName('NFM_FORMUL').AsString;
  qryGen.ParamByName('BASE01').AsString := qryCadNfm.FieldbyName('NFM_BASE01').AsString;
  qryGen.ParamByName('BASE02').AsString := qryCadNfm.FieldbyName('NFM_BASE02').AsString;
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;

  For intCont := 0 To 2 Do
  Begin
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADV_CADADV', VS_strCodEmp);
    qryGen.ParamByName('UNIDAD').AsString := arrUnids[intCont];

    For intForm := 1 To 15 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldbyName('NFM_CODC' + fStrZero(intForm, 2)).AsString) Then
        Break;

      qryGen.ParamByName('CODC' + fStrZero(intForm, 2)).AsString := qryCadNfm.FieldbyName('NFM_CODC' + fStrZero(intForm, 2)).AsString;
      qryGen.ParamByName('QTDC' + fStrZero(intForm, 2)).AsFloat := arrFatores[intCont] * qryCadNfm.FieldbyName('NFM_QTDC' + fStrZero(intForm, 2)).AsFloat;
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('CARTA_').AsString +
                                              qryGen.ParamByName('PRODUT').AsString +
                                              qryGen.ParamByName('FORMUL').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString);

    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldbyName('NFM_DTACAD').AsDateTime;

    qryGen.ExecSQL;
  End;

  Result := True;
end;

class function TAdvanceIndustrialDinamica.fDeletaNovaFormula(
  strCodNfm: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE FROM ADV_CADADV WHERE ADV_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
  Result := True;
end;

end.


