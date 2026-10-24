unit untCoralImobiliariaNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs;

Type
  TRegistroCoralImobiliaria = Record
    RecordId: Array [1..9] Of Char;
    ColorId: Array [1..30] Of Char;
    Notation: Array [1..50] Of Char;
    Base: Array [1..10] Of Char;
    Can: Array [1..10] Of Char;
    Product: Array [1..50] Of Char;
    Tinter: Array [1..5] Of Array [1..9] Of Char;
    shot: Array [1..5] Of Array [1..12] Of Char;
    SourceFile: Array [1..20] Of Char;
    Palette: Array [1..150] Of Char;
    FinalVolume: Array [1..12] Of Char;
    Price: Array [1..12] Of Char;
    GenerDate: Array [1..10] Of Char;
    Cost: Array [1..12] Of Char;
    G: Char;
    ColorName: Array [1..50] Of Char;
  End;

  PRegistroCoralImobiliaria = ^TRegistroCoralImobiliaria;

  TCoralImobiliariaDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;
    function fContaLinhas(strNomArq: String): Integer;

    function fProcessarCadCor(strNomArq: String): Boolean;
    function fProcessarCadColEmb(strNomArq: String): Boolean;
    function fProcessarCadBas(strNomArq: String): Boolean;

    procedure pProcessarCadBas(registroCoral: TRegistroCoralImobiliaria);
    procedure pProcessarCadCol(registroCoral: TRegistroCoralImobiliaria);
    procedure pProcessarCadEmb(registroCoral: TRegistroCoralImobiliaria);

    function fGetRegistro(strLinha: String): TRegistroCoralImobiliaria;
    function fGetUnidade(strEmbala: String): String;
    function fGetSigUni(strEmbala: String): String;

    function fGetString(Chars: String): String;

    function fEmbalagensConfiguradas: Boolean;    
  public
    function fProcessarArquivos(intOpcao: Integer): Boolean;
    function fGravarNovasFormulas: Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  End;



implementation

uses untFuncoesSimples, SysUtils,  StrUtils, untFuncTinta, Data.DB;



{ TCoralImobiliariaDinamica }

constructor TCoralImobiliariaDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('CIM').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM CORIMO_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM CORIMO_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM CORIMO_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM CORIMO_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TCoralImobiliariaDinamica.Destroy;
begin
  qryCadBas.Free;
  qryCadEmb.Free;
  qryCadCol.Free;
  qryCadUni.Free;
  inherited;
end;

function TCoralImobiliariaDinamica.fContaLinhas(
  strNomArq: String): Integer;
  Var
    arquivo: TextFile;
begin
  Result := 0;
  AssignFile(arquivo, strNomArq);
  Reset(arquivo);

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo);
    Result := Result + 1;
  End;

  CloseFile(arquivo);
end;

function TCoralImobiliariaDinamica.fGetRegistro(
  strLinha: String): TRegistroCoralImobiliaria;
begin
  Result := PRegistroCoralImobiliaria(strLinha)^;
end;

function TCoralImobiliariaDinamica.fGetSigUni(strEmbala: String): String;
begin
  Result := '';
  If qryCadUni.Locate('EMB_CODEMB', strEmbala, []) Then
  Begin
    Result := qryCadUni.FieldByName('UNI_SIGUNI').AsString;
  End;
end;

function TCoralImobiliariaDinamica.fGetString(Chars: String): String;
begin
  Result := Trim(Chars);
end;

function TCoralImobiliariaDinamica.fGetUnidade(strEmbala: String): String;
begin
  Result := '';
  If qryCadEmb.Locate('EMB_CODEMB', strEmbala, []) Then
  Begin
    Result := qryCadEmb.FieldByName('EMB_UNIDAD').AsString;
  End;
end;

function TCoralImobiliariaDinamica.fGravarNovasFormulas: Boolean;
begin
  Result := True;
end;

function TCoralImobiliariaDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
  Var
    stlArquivos: TStringList;
    arquivos:  TSearchRec;
    intCont: Integer;
begin
  Try
    stlArquivos := TStringList.Create;

    If (FindFirst(strPath + '\*.txt', faAnyFile, arquivos) = 0) Then
    Begin
      Repeat
        stlArquivos.Add(strPath  + '\' + arquivos.Name);
      Until (FindNext(arquivos) <> 0);

    End;
    FindClose(arquivos);

    If stlArquivos.Count > 0 Then
    Begin
      Result := True;
      For intCont := 0 To stlArquivos.Count - 1 Do
      Begin
        Case intOpcao Of
          0: Result := Result And fProcessarCadColEmb(stlArquivos.Strings[intCont]);
          1: Result := Result And fProcessarCadBas(stlArquivos.Strings[intCont]);
          2: Result := Result And fProcessarCadCor(stlArquivos.Strings[intCont]);
        End;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum arquivo da Coral. Verifique as configurações.', ['&Ok']);
      Result := False;
    End;

    FreeAndNil(stlArquivos);
  Except
    On E: Exception Do
    Begin
      If Assigned(stlArquivos) Then FreeAndNil(stlArquivos);
      Result := False;
      pMensagensErro(E.Message, 'TCoralImobiliariaDinamica.fProcessarArquivos');
    End;

  End;

end;


function TCoralImobiliariaDinamica.fProcessarCadBas(
  strNomArq: String): Boolean;
  Var
    arqCoral: TextFile;
    strLinha: String;
    intLinhas: Integer;
    intLinha: Integer;
    registroCoral: TRegistroCoralImobiliaria;
begin
  try
    If Not fEmbalagensConfiguradas Then
    Begin
      fMensagem('ATENÇÃO!', 'As embalagens não estão configuradas corretamente.Favor configurar!', ['&Ok']);    
      Result := False;
      Exit;
    End;
      
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(arqCoral, strNomArq);
    Reset(arqCoral);

    intLinha := 1;
    pRegistraAcao(Format('Cadastrando Bases [%s]...', [strNomArq]));
    While Not Eof(arqCoral) Do
    Begin
      Readln(arqCoral, strLinha);
      registroCoral := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

      If Trim(registroCoral.RecordId) = 'RecordId' Then
        Continue;

      pProcessarCadBas(registroCoral);
      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
    End;
    pRegistraAcao(Format('Cadastro de Bases [%s] realizado com sucesso!', [strNomArq]));
  except
    On E: Exception Do
    Begin
      CloseFile(arqCoral);
      Raise;
    End;
  end;

  CloseFile(arqCoral);
  Result := True;
end;

function TCoralImobiliariaDinamica.fProcessarCadColEmb(
  strNomArq: String): Boolean;
  Var
    arqCoral: TextFile;
    strLinha: String;
    intLinhas: Integer;
    intLinha: Integer;
    registroCoral: TRegistroCoralImobiliaria;
begin
  try
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(arqCoral, strNomArq);
    Reset(arqCoral);

    intLinha := 1;
    pRegistraAcao(Format('Cadastrando Colorantes e Embalagens [%s]...', [strNomArq]));
    While Not Eof(arqCoral) Do
    Begin
      Readln(arqCoral, strLinha);
      registroCoral := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

      If Trim(registroCoral.RecordId) = 'RecordId' Then
        Continue;

      pProcessarCadCol(registroCoral);
      pProcessarCadEmb(registroCoral);
      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
    End;
    pRegistraAcao(Format('Cadastro de Colorantes e Embalagens [%s] realizado com sucesso!', [strNomArq]));
  except
    On E: Exception Do
    Begin
      CloseFile(arqCoral);
      Raise;
    End;
  end;

  CloseFile(arqCoral);
  Result := True;
end;

function TCoralImobiliariaDinamica.fProcessarCadCor(
  strNomArq: String): Boolean;
  Var
    arqCoral: TextFile;
    strLinha: String;
    intLinhas: Integer;
    registroCoral: TRegistroCoralImobiliaria;
    qryGen: TUniQuery;
    intLinha: Integer;
    intForm: Integer;
    intAuto: Integer;
  Const
    intQtdForms: Integer = 5;

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(COR_CODSEQ), 0) + 1 AS MAXIMO FROM CORIMO_CADCOR';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;
  
begin
  try
    intLinhas := fContaLinhas(strNomArq);

    AssignFile(arqCoral, strNomArq);
    Reset(arqCoral);

    qryGen := fCriaQuery(Self);

    If Not blnTruncou Then
    Begin
      qryGen.SQL.Text := 'TRUNCATE TABLE CORIMO_CADCOR';
      qryGen.ExecSQL;
      blnTruncou := True;
    End;

    qryGen.SQL.Clear;
    qryGen.SQL.Add(' INSERT INTO CORIMO_CADCOR ');
    qryGen.SQL.Add('             (COR_CODSEQ, ');
    qryGen.SQL.Add('              COR_CODEMP, ');
    qryGen.SQL.Add('              COR_DESCRI, ');
    qryGen.SQL.Add('              COR_CODIGO, ');
    qryGen.SQL.Add('              COR_UNIDAD, ');
    qryGen.SQL.Add('              COR_COLID1, ');
    qryGen.SQL.Add('              COR_COLID2, ');
    qryGen.SQL.Add('              COR_DESPRO, ');
    qryGen.SQL.Add('              COR_CODBAS, ');

    For intForm := 1 To intQtdForms Do
    Begin
      qryGen.SQL.Add('              COR_FORM' + fStrZero(intForm, 2) + ', ');
      qryGen.SQL.Add('              COR_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryGen.SQL.Add('              AUTOINCREM, ');
    qryGen.SQL.Add('              COR_CODEMB, ');
    qryGen.SQL.Add('              COR_CODUNI, ');
    qryGen.SQL.Add('              COR_MD5KEY, ');    
    qryGen.SQL.Add('              COR_UNIVER) ');
    qryGen.SQL.Add(' VALUES (:COR_CODSEQ, ');
    qryGen.SQL.Add('         :COR_CODEMP, ');
    qryGen.SQL.Add('         :COR_DESCRI, ');
    qryGen.SQL.Add('         :COR_CODIGO, ');
    qryGen.SQL.Add('         :COR_UNIDAD, ');
    qryGen.SQL.Add('         :COR_COLID1, ');
    qryGen.SQL.Add('         :COR_COLID2, ');
    qryGen.SQL.Add('         :COR_DESPRO, ');
    qryGen.SQL.Add('         :COR_CODBAS, ');

    For intForm := 1 To intQtdForms Do
    Begin
      qryGen.SQL.Add('         :COR_FORM' + fStrZero(intForm, 2) + ', ');
      qryGen.SQL.Add('         :COR_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryGen.SQL.Add('         :AUTOINCREM, ');
    qryGen.SQL.Add('         :COR_CODEMB, ');
    qryGen.SQL.Add('         :COR_CODUNI, ');
    qryGen.SQL.Add('         :COR_MD5KEY, ');
    qryGen.SQL.Add('         :COR_UNIVER); ');

    intAuto := fAjustaInicialAutoIncremento('CORIMO_CADCOR', VS_strCodEmp);

    intLinha := 1;

    pRegistraAcao(Format('Processando Cadastro de Formulas [%s]...', [strNomArq]));
    While Not Eof(arqCoral) Do
    Begin
      Readln(arqCoral, strLinha);
      registroCoral := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

      If Trim(registroCoral.RecordId) = 'RecordId' Then
        Continue;

      qryGen.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intAuto, VS_strCodEmp);
//      qryGen.ParamByName('COR_CODSEQ').AsString := fStrZero(fGetString(registroCoral.RecordId), 6);
      qryGen.ParamByName('COR_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryGen.ParamByName('COR_CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('COR_DESCRI').AsString := Trim(fGetString(registroCoral.Notation) + ' ' + fGetString(registroCoral.Product) + ' ' + fGetString(registroCoral.Base));
      qryGen.ParamByName('COR_CODIGO').AsString := fGetString(registroCoral.ColorId);
      qryGen.ParamByName('COR_COLID1').AsString := fGetString(registroCoral.ColorId);
      qryGen.ParamByName('COR_COLID2').AsString := fGetString(registroCoral.ColorName);
      qryGen.ParamByName('COR_DESPRO').AsString := fGetString(registroCoral.Product);
      qryGen.ParamByName('COR_CODBAS').AsString := fGetString(registroCoral.Base);

      For intForm := 1 To intQtdForms Do
      Begin
        qryGen.ParamByName('COR_FORM' + fStrZero(intForm, 2)).AsString := fGetString(registroCoral.Tinter[intForm]);
        qryGen.ParamByName('COR_QTDC' + fStrZero(intForm, 2)).AsFloat := fStrToFloat(fGetString(registroCoral.shot[intForm]));
      End;

      qryGen.ParamByName('COR_CODEMB').AsString := fGetString(registroCoral.Can);
      qryGen.ParamByName('COR_UNIDAD').AsString := fGetSigUni(fGetString(registroCoral.Can));
      qryGen.ParamByName('COR_CODUNI').AsString := fGetUnidade(fGetString(registroCoral.Can));
      qryGen.ParamByName('COR_UNIVER').AsString := fGetString(registroCoral.Notation);
      qryGen.ParamByName('COR_MD5KEY').AsString := GetMD5(qryGen.ParamByName('COR_DESCRI').AsString +
                                                    qryGen.ParamByName('COR_CODIGO').AsString +
                                                    qryGen.ParamByName('COR_UNIDAD').AsString +
                                                    qryGen.ParamByName('COR_COLID1').AsString +
                                                    qryGen.ParamByName('COR_COLID2').AsString +
                                                    qryGen.ParamByName('COR_DESPRO').AsString +
                                                    qryGen.ParamByName('COR_CODBAS').AsString +
                                                    qryGen.ParamByName('COR_CODEMB').AsString +
                                                    qryGen.ParamByName('COR_CODUNI').AsString +
                                                    qryGen.ParamByName('COR_UNIVER').AsString);      

      qryGen.ExecSQL;
      pRegistraProgresso(0, intLinha, intLinhas);
      intLinha := intLinha + 1;
      intAuto := intAuto + 1;
    End;
    pRegistraAcao(Format('Cadastro de Formulas Processado com Sucesso! [%s]', [strNomArq]));
  except
    On E: Exception Do
    Begin
      CloseFile(arqCoral);
      Raise;
    End;
  end;

  Result := True;
  CloseFile(arqCoral);
  qryGen.Free;
end;

procedure TCoralImobiliariaDinamica.pProcessarCadBas(
  registroCoral: TRegistroCoralImobiliaria);
begin
  If Not qryCadBas.Locate('BAS_BASE__;BAS_DESCRI;BAS_UNIDAD',
    VarArrayOf([fGetString(registroCoral.Base), fGetString(registroCoral.Product), fGetUnidade(fGetString(registroCoral.Can))]),
    []) Then
  Begin
    qryCadBas.Insert;
    qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADBAS', VS_strCodEmp);
    qryCadBas.FieldByName('BAS_BASE__').AsString := fGetString(registroCoral.Base);
    qryCadBas.FieldByName('BAS_DESCRI').AsString := fGetString(registroCoral.Product);
    qryCadBas.FieldByName('BAS_UNIDAD').AsString := fGetUnidade(fGetString(registroCoral.Can));
    qryCadBas.Post;
  End;
end;

procedure TCoralImobiliariaDinamica.pProcessarCadCol(
  registroCoral: TRegistroCoralImobiliaria);
  Var
    intCont: Integer;
begin
  For intCont := 1 To 5 Do
  Begin
    If (Not fEmptyStr(fGetString(registroCoral.Tinter[intCont])))
      And (Not qryCadCol.Locate('COL_CODCOL', fGetString(registroCoral.Tinter[intCont]), [])) Then
    Begin
      qryCadCol.Insert;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCOL', VS_strCodEmp);
      qryCadCol.FieldByName('COL_CODCOL').AsString := fGetString(registroCoral.Tinter[intCont]);
      qryCadCol.Post;
    End;
  End;
end;

procedure TCoralImobiliariaDinamica.pProcessarCadEmb(
  registroCoral: TRegistroCoralImobiliaria);
begin
  If Not qryCadEmb.Locate('EMB_CODEMB', fGetString(registroCoral.Can), []) Then
  Begin
    qryCadEmb.Insert;
    qryCadEmb.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADEMB', VS_strCodEmp);
    qryCadEmb.FieldByName('EMB_CODEMB').AsString := fGetString(registroCoral.Can);
    qryCadEmb.Post;
  End;
end;

function TCoralImobiliariaDinamica.fEmbalagensConfiguradas: Boolean;
var
  qryConEmb: TUniQuery;
begin
  Try
    Try
      qryConEmb := fCriaQuery(Self);
      With qryConEmb Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT EMB_UNIDAD    ');
        SQL.Add('   FROM CORIMO_CADEMB ');
        SQL.Add('  WHERE TRUE          ');
        Open;

        First;
        While Not Eof Do
        Begin
          If FieldByName('EMB_UNIDAD').AsString = '' Then
          Begin
            Result := False;
            Exit;
          End;
          qryConEmb.Next;
        End;

        Result := Not IsEmpty;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', 'Nao foi possível consultar as embalagens.', ['&Ok']);
        Result := False;
      end;
    End;
  Finally
    FreeAndNil(qryConEmb);
  End;
end;

end.
