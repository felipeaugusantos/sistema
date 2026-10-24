unit untMazaAutomotiva;

interface

uses untTintadeMaquina, ADODB, Uni,  Classes,
     untIConfTinta;

Type
  TMazaAutomotiva = class(TTintadeMaquina)
  private
    FPath: String;
    conf: IConfTinta;
    function fProcessarCadBas: Boolean;
    function fProcessarCadMza: Boolean;
    function fProcessarCadMon: Boolean;
    function fProcessarCadLin: Boolean;    
    procedure SetstrPath(const Value: String);
    function fPathValido(strArquivo: String): Boolean;
    function fRetornaQuantidadeRegTxt(strPosicao: String): Integer;
    function fRetornaPosIniFinBase(strLinha: String;intPosForm: Integer): String;
    function fRetornaPosIniFinQtdBase(strLinha: String;intPosForm: Integer): Double;
    function fFormataStringFloat(strValor: String; intDecimal: Integer): Double;
  public
    constructor Create(AOwner: TComponent); override;

    function fProcessarArquivos: Boolean;

    function fGravarNovasFormulas: Boolean; override;
    property strPath: String read FPath write SetstrPath;
    class function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
    class procedure pDeletaNovaFormulaDinamica(strCodigo: String);

  End;

implementation

uses untFuncoesSimples, DB, untFuncTinta, SysUtils, Variants, StrUtils, Math;



{ TMazaAutomotiva }

constructor TMazaAutomotiva.Create(AOwner: TComponent);
begin
  inherited;
  NomeTinta := 'Maza Automotiva';
  conf      := fGetConfTinta('MZA');
  strPath   := conf.fGet('MZAPAT');
end;

function TMazaAutomotiva.fFormataStringFloat(strValor: String;
  intDecimal: Integer): Double;
var
  strString: String;
begin
  strString := Copy(strValor,1,Length(strValor) - intDecimal) + ',' + Copy(strValor,Length(strValor) - intDecimal + 1,intDecimal);

  Result := fStrToFloat(strString);
end;

class function TMazaAutomotiva.fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  Var
    qryMza: TUniQuery;
    intCont: Integer;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'DELETE FROM MZA_CADMZA WHERE MZA_CODNFM = :CODNFM';
    qryMza.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryMza.ExecSQL;

    qryMza.SQL.Clear;
    qryMza.SQL.Add(' INSERT INTO MZA_CADMZA ');
    qryMza.SQL.Add('             (AUTOINCREM, ');
    qryMza.SQL.Add('              MZA_CODEMP, ');
    qryMza.SQL.Add('              MZA_CODIGO, ');
    qryMza.SQL.Add('              MZA_VARIAC, ');
    qryMza.SQL.Add('              MZA_DESCRI, ');
    qryMza.SQL.Add('              MZA_OBSERV, ');
    qryMza.SQL.Add('              MZA_ANOCOR, ');
    qryMza.SQL.Add('              MZA_PESCOR, ');
    qryMza.SQL.Add('              MZA_PESFOR, ');
    qryMza.SQL.Add('              MZA_DTAFOR, ');
    qryMza.SQL.Add('              MZA_LINHA_, ');
    qryMza.SQL.Add('              MZA_CODMON, ');
    qryMza.SQL.Add('              MZA_CODNFM, ');

    For intCont := 1 To 15 Do
    Begin
      qryMza.SQL.Add('              MZA_FORM' + fStrZero(intCont, 2) + ', ');
      qryMza.SQL.Add('              MZA_QTDC' + fStrZero(intCont, 2) + ', ');
    End;

    qryMza.SQL.Add('              MZA_UNIVER, ');
    qryMza.SQL.Add('              MZA_ACRMOB) ');
    qryMza.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryMza.SQL.Add('         :MZA_CODEMP, ');
    qryMza.SQL.Add('         :MZA_CODIGO, ');
    qryMza.SQL.Add('         :MZA_VARIAC, ');
    qryMza.SQL.Add('         :MZA_DESCRI, ');
    qryMza.SQL.Add('         :MZA_OBSERV, ');
    qryMza.SQL.Add('         :MZA_ANOCOR, ');
    qryMza.SQL.Add('         :MZA_PESCOR, ');
    qryMza.SQL.Add('         :MZA_PESFOR, ');
    qryMza.SQL.Add('         :MZA_DTAFOR, ');
    qryMza.SQL.Add('         :MZA_LINHA_, ');
    qryMza.SQL.Add('         :MZA_CODMON, ');
    qryMza.SQL.Add('         :MZA_CODNFM, ');

    For intCont := 1 To 15 Do
    Begin
      qryMza.SQL.Add('         :MZA_FORM' + fStrZero(intCont, 2) + ', ');
      qryMza.SQL.Add('         :MZA_QTDC' + fStrZero(intCont, 2) + ', ');
    End;

    qryMza.SQL.Add('         :MZA_UNIVER, ');
    qryMza.SQL.Add('         :MZA_ACRMOB);');

    qryMza.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MZA_CADMZA', VS_strCodEmp);
    qryMza.ParamByName('MZA_CODEMP').AsString := VS_strCodEmp;
    qryMza.ParamByName('MZA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryMza.ParamByName('MZA_VARIAC').AsString := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
    qryMza.ParamByName('MZA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryMza.ParamByName('MZA_OBSERV').AsString := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
    qryMza.ParamByName('MZA_PESCOR').AsFloat  := qryCadNfm.FieldByName('NFM_PESCOR').AsFloat;
    qryMza.ParamByName('MZA_PESFOR').AsFloat  := qryCadNfm.FieldByName('NFM_PESFOR').AsFloat;
    qryMza.ParamByName('MZA_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
    qryMza.ParamByName('MZA_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
    qryMza.ParamByName('MZA_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;

    For intCont := 1 To 15 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
        Break;

      qryMza.ParamByName('MZA_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryMza.ParamByName('MZA_QTDC' + fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat;
    End;

    qryMza.ParamByName('MZA_UNIVER').AsString := qryCadNfm.FieldByName('NFM_UNIVER').AsString;
    qryMza.ParamByName('MZA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

    qryMza.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(qryMza);
  End;
end;

class procedure TMazaAutomotiva.pDeletaNovaFormulaDinamica(strCodigo: String);
Var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery;

    qryDel.SQL.Clear;
    qryDel.Close;
    qryDel.SQL.Text := 'DELETE FROM MZA_CADMZA '+
                       ' WHERE MZA_CODIGO = :CODIGO ';

    qryDel.ParamByName('CODIGO').AsString := strCodigo;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;

end;

function TMazaAutomotiva.fGravarNovasFormulas: Boolean;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT * FROM MZA_CADNFM';
    qryMza.Open;

    pRegistraAcao('Processando cadastro de novas fórmulas...');
    While Not qryMza.Eof Do
    Begin
      fGravaNovaFormula(qryMza);

      pRegistraProgresso(0, qryMza.RecNo, qryMza.RecordCount);
      qryMza.Next;
    End;

    pRegistraAcao('Cadastro de novas fórmulas processado com sucesso!');
    Result := True;
  Finally
    FreeAndNil(qryMza);
  End;
end;

function TMazaAutomotiva.fPathValido(strArquivo: String): Boolean;
begin
  Result := True;
  If (Not FileExists(FPath)) Then
  Begin
    fMensagem('Informação', 'Não foi possivel encontrar o arquivo MazaMix.Txt no ' +
                  'diretorio ' + FPath, ['&Ok']);
    Result := False;
  End;
end;

function TMazaAutomotiva.fProcessarArquivos: Boolean;
begin
  Result := True;
  
  if Not fPathValido(FPath) then
    Result := False;

  if Result Then
    Result := fProcessarCadBas
            And fProcessarCadMon
            And fProcessarCadLin
            And fProcessarCadMza;
end;

function TMazaAutomotiva.fProcessarCadBas: Boolean;
  Var
    qryCadbas: TUniQuery;
    intContador: Integer;
    intQtdReg: Integer;
    arqBasTxt: TextFile;
    strLinha : String;
begin
  intContador := 0;
  strLinha    := '';
  Result := False;
  Try
    Try
      //Selecionar as bases do arquivo texto
      qryCadbas := fCriaQuery();
      qryCadbas.Close;
      qryCadbas.SQL.Clear;
      qryCadbas.SQL.Add(' INSERT INTO MZA_CADBAS    ');
      qryCadbas.SQL.Add('             (AUTOINCREM,  ');
      qryCadbas.SQL.Add('              BAS_CODBAS,  ');
      qryCadbas.SQL.Add('              BAS_DESCRI,  ');
      qryCadbas.SQL.Add('              BAS_EFEITO,  ');
      qryCadbas.SQL.Add('              BAS_LINHA_,  ');
      qryCadbas.SQL.Add('              BAS_EMBALA,  ');
      qryCadbas.SQL.Add('              BAS_PESESP) ');
      qryCadbas.SQL.Add(' VALUES (:AUTOINCREM,  ');
      qryCadbas.SQL.Add('         :BAS_CODBAS,  ');
      qryCadbas.SQL.Add('         :BAS_DESCRI,  ');
      qryCadbas.SQL.Add('         :BAS_EFEITO,  ');
      qryCadbas.SQL.Add('         :BAS_LINHA_,  ');
      qryCadbas.SQL.Add('         :BAS_EMBALA,  ');
      qryCadbas.SQL.Add('         :BAS_PESESP); ');

      //procura arquivo de bases
      AssignFile(arqBasTxt, FPath);
      Reset(arqBasTxt);

      intQtdReg := fRetornaQuantidadeRegTxt('30');   // 30 - arquivo de bases

      pRegistraAcao('Processando cadastro de bases...');
      While Not Eof(arqBasTxt) Do
      Begin

        Readln(arqBasTxt, strLinha);

        If LeftStr(strLinha,2) = '30' Then // 30 - arquivo de bases
        Begin

          intContador := intContador + 1;

          qryCadbas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MZA_CADBAS', VS_strCodEmp);
          qryCadbas.ParamByName('BAS_CODBAS').AsString := Copy(strLinha,3,7); //codigo da base
          qryCadbas.ParamByName('BAS_DESCRI').AsString := Copy(strLinha,14,50); //descricao da base
          qryCadbas.ParamByName('BAS_EFEITO').AsString := Copy(strLinha,64,50); //efeito
          qryCadbas.ParamByName('BAS_LINHA_').AsString := Copy(strLinha,114,3); //linha
          qryCadbas.ParamByName('BAS_EMBALA').AsFloat  := fStrToFloat(Copy(strLinha,125,5)); //embalagem
          qryCadbas.ParamByName('BAS_PESESP').AsFloat  := fFormataStringFloat(Copy(strLinha,117,8),4); //peso especifico

          Try
            qryCadbas.ExecSQL;
          Except
            On E: EUniError Do
            Begin
              If E.ErrorCode = 1062 Then //DUPLICADO
                pRegistraAcao(Format('Base %s já está cadastrada', [
                  Copy(strLinha,3,9)]))
              Else
                Raise;
            End;
          End;

          pRegistraProgresso(0, intContador, intQtdReg);
        End;
      End;
      pRegistraAcao('Cadastro de bases processado com sucesso!');

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TMazaAutomotiva.fProcessarCadBas]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCadBas);
    CloseFile(arqBasTxt);
  End;
end;

function TMazaAutomotiva.fProcessarCadLin: Boolean;
  Var
    qryCadLin: TUniQuery;
    intQtdReg,
    intContador: Integer;
    arqLinTxt: TextFile;
    strLinha : String;
begin

  Result := False;
  intContador := 0;
  strLinha := '';
  
  Try
    Try

      qryCadLin := fCriaQuery();
      qryCadLin.Close;
      qryCadLin.SQL.Clear;
      qryCadLin.SQL.Add(' INSERT INTO MZA_CADLIN    ');
      qryCadLin.SQL.Add('             (AUTOINCREM,  ');
      qryCadLin.SQL.Add('              LIN_CODIGO,  ');
      qryCadLin.SQL.Add('              LIN_DESCRI,  ');
      qryCadLin.SQL.Add('              LIN_VOLUME)  ');
      qryCadLin.SQL.Add(' VALUES (:AUTOINCREM,  ');
      qryCadLin.SQL.Add('         :LIN_CODIGO,  ');
      qryCadLin.SQL.Add('         :LIN_DESCRI,  ');
      qryCadLin.SQL.Add('         :LIN_VOLUME); ');

      //procura arquivo de Linhas de produtos
      AssignFile(arqLinTxt, FPath);
      Reset(arqLinTxt);

      intQtdReg := fRetornaQuantidadeRegTxt('20');   // 20 - arquivo de Linhas de produtos

      pRegistraAcao('Processando cadastro de Linhas ...');

      While Not Eof(arqLinTxt) Do
      Begin

        Readln(arqLinTxt, strLinha);

        If LeftStr(strLinha,2) = '20' Then // 20 - arquivo de Linhas
        Begin

          intContador := intContador + 1;

          qryCadLin.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MZA_CADLIN', VS_strCodEmp);
          qryCadLin.ParamByName('LIN_CODIGO').AsString := Copy(strLinha,3,3);  //codigo da linha
          qryCadLin.ParamByName('LIN_DESCRI').AsString := Copy(strLinha,6,30); //nome da linha
          qryCadLin.ParamByName('LIN_VOLUME').AsFloat  := fStrToFloat(Copy(strLinha,36,6)); //volume da linha

          Try
            qryCadLin.ExecSQL;
          Except
            On E: EUniError Do
            Begin
              If E.ErrorCode = 1062 Then //DUPLICADO
                pRegistraAcao(Format('A Linha %s - %s já está cadastrada!', [
                  Copy(strLinha,3,5),
                  Copy(strLinha,6,45)]))
              Else
                Raise;
            End;
          End;

          pRegistraProgresso(0, intContador, intQtdReg);
        End;
      End;
      pRegistraAcao('Cadastro de Linhas processado com sucesso!');
      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TMazaAutomotiva.fProcessarCadLin]');
        Result := False
      End;
    End;
  Finally
    FreeAndNil(qryCadLin);
    CloseFile(arqLinTxt);
  End;
end;

function TMazaAutomotiva.fProcessarCadMza: Boolean;
  Var
    qryCadMza: TUniQuery;
    intForm: Integer;

    intQtdReg,
    intContador: Integer;

    arqMzaTxt: TextFile;
    strLinha : String;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadMza.Params.Count - 1 Do
    Begin
      qryCadMza.Params.Items[i].Value := Null;
    End;
  End;
begin
  strLinha := '';
  intContador := 0;

  Try
    Try
      qryCadMza := fCriaQuery();
      qryCadMza.Close;
      qryCadMza.SQL.Clear;
      qryCadMza.SQL.Text := 'TRUNCATE TABLE MZA_CADMZA;';
      qryCadMza.ExecSQL;

      qryCadMza.SQL.Clear;
      qryCadMza.SQL.Add(' INSERT INTO MZA_CADMZA ');
      qryCadMza.SQL.Add('             (AUTOINCREM, ');
      qryCadMza.SQL.Add('              MZA_CODEMP, ');
      qryCadMza.SQL.Add('              MZA_CODIGO, ');
      qryCadMza.SQL.Add('              MZA_VARIAC, ');
      qryCadMza.SQL.Add('              MZA_DESCRI, ');
      qryCadMza.SQL.Add('              MZA_OBSERV, ');
      qryCadMza.SQL.Add('              MZA_ANOCOR, ');
      qryCadMza.SQL.Add('              MZA_PESCOR, ');
      qryCadMza.SQL.Add('              MZA_PESFOR, ');
      qryCadMza.SQL.Add('              MZA_DTAFOR, ');
      qryCadMza.SQL.Add('              MZA_LINHA_, ');
      qryCadMza.SQL.Add('              MZA_CODMON, ');
      qryCadMza.SQL.Add('              MZA_CODNFM, ');

      For intForm := 1 To 15 Do
      Begin
        qryCadMza.SQL.Add('              MZA_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadMza.SQL.Add('              MZA_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadMza.SQL.Add('              MZA_UNIVER) ');
      qryCadMza.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadMza.SQL.Add('         :MZA_CODEMP, ');
      qryCadMza.SQL.Add('         :MZA_CODIGO, ');
      qryCadMza.SQL.Add('         :MZA_VARIAC, ');
      qryCadMza.SQL.Add('         :MZA_DESCRI, ');
      qryCadMza.SQL.Add('         :MZA_OBSERV, ');
      qryCadMza.SQL.Add('         :MZA_ANOCOR, ');
      qryCadMza.SQL.Add('         :MZA_PESCOR, ');
      qryCadMza.SQL.Add('         :MZA_PESFOR, ');
      qryCadMza.SQL.Add('         :MZA_DTAFOR, ');
      qryCadMza.SQL.Add('         :MZA_LINHA_, ');
      qryCadMza.SQL.Add('         :MZA_CODMON, ');
      qryCadMza.SQL.Add('         :MZA_CODNFM, ');

      For intForm := 1 To 15 Do
      Begin
        qryCadMza.SQL.Add('         :MZA_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadMza.SQL.Add('         :MZA_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadMza.SQL.Add('         :MZA_UNIVER); ');

      //procura arquivo de Linhas de produtos
      AssignFile(arqMzaTxt, FPath);
      Reset(arqMzaTxt);

      intQtdReg := fRetornaQuantidadeRegTxt('60');   // 60 - arquivo de formulas

      pRegistraAcao('Processando cadastro de cores...');

      While Not Eof(arqMzaTxt) Do
      Begin

        Readln(arqMzaTxt, strLinha);

        If LeftStr(strLinha,2) = '60' Then // 60 - arquivo de formulas
        Begin

          intContador := intContador + 1;

          Limpar;

          qryCadMza.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MZA_CADMZA', VS_strCodEmp);
          qryCadMza.ParamByName('MZA_CODEMP').AsString := VS_strCodEmp;
          qryCadMza.ParamByName('MZA_CODIGO').AsString := Copy(strLinha,3,8);   //codigo da linha
          qryCadMza.ParamByName('MZA_VARIAC').AsString := Copy(strLinha,11,4);  //codigo da variacao
          qryCadMza.ParamByName('MZA_DESCRI').AsString := Copy(strLinha,15,45);  //nome da cor
          qryCadMza.ParamByName('MZA_OBSERV').AsString := Copy(strLinha,60,34);  //observacao
          qryCadMza.ParamByName('MZA_ANOCOR').AsString := Copy(strLinha,94,4);  //ano da cor
          qryCadMza.ParamByName('MZA_PESCOR').AsFloat  := fFormataStringFloat(Copy(strLinha,98,10),6);  //Peso da cor
          qryCadMza.ParamByName('MZA_PESFOR').AsFloat  := fFormataStringFloat(Copy(strLinha,108,10),6);  //Peso da formulacao
          qryCadMza.ParamByName('MZA_DTAFOR').AsString := Copy(strLinha,118,8);  //Data da formulacao
          qryCadMza.ParamByName('MZA_LINHA_').AsString := Copy(strLinha,126,3);  //codigo da linha
          qryCadMza.ParamByName('MZA_CODMON').AsString := Copy(strLinha,129,3);  //codigo da montadora
          qryCadMza.ParamByName('MZA_CODNFM').AsString := '';  //codigo das novas formulas

          For intForm := 1 To 15 Do
          Begin
            qryCadMza.ParamByName('MZA_FORM' + fStrZero(intForm, 2)).AsString := fRetornaPosIniFinBase(strLinha,intForm);
            qryCadMza.ParamByName('MZA_QTDC' + fStrZero(intForm, 2)).AsFloat  := fFormataStringFloat(FloatToStr(fRetornaPosIniFinQtdBase(strLinha,intForm)),4);
          End;

          qryCadMza.ParamByName('MZA_UNIVER').AsString := Copy(strLinha,132,12);  //codigo universal da cor

          qryCadMza.ExecSQL;

          pRegistraProgresso(0, intContador, intQtdReg);
        End;
      End;

      pRegistraAcao('Cadastro de cores processado com sucesso!');
      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TMazaAutomotiva.fProcessarCadMza]');
        Result := False
      End;
    End;
  Finally
    FreeAndNil(qryCadMza);
    CloseFile(arqMzaTxt);
  End;
end;

function TMazaAutomotiva.fRetornaPosIniFinBase(strLinha: String;
  intPosForm: Integer): String;
const
  ArrPosIni:Array[0..14] of Integer=(144,159,174,189,204,219,234,249,264,279,294,309,324,339,354);
  ArrPosFin:Array[0..14] of Integer=(7,7,7,7,7,7,7,7,7,7,7,7,7,7,7);
begin
  Result := Copy(strLinha,ArrPosIni[intPosForm - 1], ArrPosFin[intPosForm - 1]);
end;

function TMazaAutomotiva.fRetornaPosIniFinQtdBase(strLinha: String;
  intPosForm: Integer): Double;
const
  ArrPosIni:Array[0..14] of Integer=(151,166,181,196,211,226,241,256,271,286,301,316,331,346,361);
  ArrPosFin:Array[0..14] of Integer=(8,8,8,8,8,8,8,8,8,8,8,8,8,8,8);
begin
  Result := fStrToFloat(FormatFloat('###,#0.0000',fStrToFloat(Copy(strLinha,ArrPosIni[intPosForm - 1], ArrPosFin[intPosForm - 1]))));
end;

function TMazaAutomotiva.fRetornaQuantidadeRegTxt(strPosicao: String): Integer;
var
  arqTxt: TextFile;
  strLinha: String;
  intContador: Integer;
begin
  Result      := 0;
  intContador := 0;
  strLinha    := '';
  Try
    AssignFile(arqTxt, FPath);
    Reset(arqTxt);

    While not Eof(arqTxt) Do
    Begin
      Readln(arqTxt, strLinha);
      If LeftStr(strLinha,2) = strPosicao Then
      Begin
        intContador := intContador + 1;
        Result := intContador;
      End
      Else
      Begin
        If intContador > 0 Then
          Break;
      End;
    End;

  Finally
    CloseFile(arqTxt);
  End;
end;

function TMazaAutomotiva.fProcessarCadMon: Boolean;
  Var
    qryCadMon: TUniQuery;
    intQtdReg,
    intContador: Integer;
    arqMonTxt: TextFile;
    strLinha : String;
begin

  Result := False;
  strLinha := '';
  intContador := 0;

  Try
    Try
      qryCadMon := fCriaQuery();
      qryCadMon.Close;
      qryCadMon.SQL.Clear;
      qryCadMon.SQL.Add(' INSERT INTO MZA_CADMON ');
      qryCadMon.SQL.Add('             (AUTOINCREM, ');
      qryCadMon.SQL.Add('              MON_CODMON, ');
      qryCadMon.SQL.Add('              MON_DESCRI) ');
      qryCadMon.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadMon.SQL.Add('         :MON_CODMON, ');
      qryCadMon.SQL.Add('         :MON_DESCRI); ');

      //procura arquivo de montadoras
      AssignFile(arqMonTxt, FPath);
      Reset(arqMonTxt);

      intQtdReg := fRetornaQuantidadeRegTxt('10');   // 10 - arquivo de montadoras

      pRegistraAcao('Processando cadastro de montadoras ...');

      While Not Eof(arqMonTxt) Do
      Begin

        Readln(arqMonTxt, strLinha);

        If LeftStr(strLinha,2) = '10' Then // 10 - arquivo de Montadoras
        Begin

          intContador := intContador + 1;

          qryCadMon.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MZA_CADMON', VS_strCodEmp);
          qryCadMon.ParamByName('MON_CODMON').AsString := Copy(strLinha,3,3);  //codigo da montadora
          qryCadMon.ParamByName('MON_DESCRI').AsString := Copy(strLinha,6,40); //nome da montadora

          Try
            qryCadMon.ExecSQL;
          Except
            On E: EUniError Do
            Begin
              If E.ErrorCode = 1062 Then //DUPLICADO
                pRegistraAcao(Format('A Montadora %s - %s já está cadastrada!', [
                  Copy(strLinha,3,5),
                  Copy(strLinha,6,45)]))
              Else
                Raise;
            End;
          End;

          pRegistraProgresso(0, intContador, intQtdReg);
        End;
      End;
      pRegistraAcao('Cadastro de montadoras processado com sucesso!');
      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TMazaAutomotiva.fProcessarCadMon]');
        Result := False
      End;
    End;
  Finally
    FreeAndNil(qryCadMon);
    CloseFile(arqMonTxt);
  End;
end;

procedure TMazaAutomotiva.SetstrPath(const Value: String);
begin
  FPath := Value;
end;

end.
