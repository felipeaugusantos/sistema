unit untAutocolorDinamica;

interface
{$M+}

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, untModulo,
  untIConfTinta;

Type
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;

  TAutoColorDinamica = class
  private
    tblIdioma : TUniQuery;
    tblForm2k : TUniQuery;
    tblTin2k  : TUniQuery;
    tblManf2k : TUniQuery;

    qryCadBas : TUniQuery;
    qryCadAut : TUniQuery;
    qryCadMon : TUniQuery;
    qryCadSis : TUniQuery;
    cdsCadBas : TUniClientDataSet;

    strPat    : String;
    strForm2k : String;
    intOpcao  : Integer;
    blnMontad : Boolean;
    blnSisLin : Boolean;

    FRegistraAcao     : TEventoStrAcao;
    FRegistraProgresso : TEventoProgresso;
    conf: IConfTinta;

    function fProcessaBases: Boolean;
    function fProcessarTintas: Boolean;
    function fProcessaMontadoras: Boolean;
    function fCadBasVazio: Boolean;
    function fBasesConfiguradas: Integer;
    procedure pCriaCadBasMen;
    function fCarregaCadBas: Integer;
    function fProcessaDilCat: Integer;
  protected

  public
    function fProcessarArquivos: Boolean;
    function fGravaCadNfms: Boolean;
    constructor Create(intOpcao: Integer; blnMontad: Boolean; blnSisLin: Boolean);
    constructor CreateNovasFormulas();
    destructor Destroy; override;
  published
    property  RegistraAcao  : TEventoStrAcao  Read  FRegistraAcao Write FRegistraAcao;
    property  RegistraProgresso : TEventoProgresso  Read  FRegistraProgresso  Write FRegistraProgresso;
  end;

  function fGravaCadNfm(qryCadNfm : TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodigo: String);

  function fRetProxcodSeq: Integer;

implementation

uses untFuncoesSimples, Dialogs,
     untFuncTinta,StrUtils, Math, untTintadeMaquina;

{ TAutoColorDinamica }

constructor TAutoColorDinamica.Create(intOpcao: Integer; blnMontad: Boolean; blnSisLin: Boolean);
begin
  conf := fGetConfTinta('AUT');
  strPat    := conf.fGet('PATAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'PATAUT', '');
  If fEmptyStr(strPat) Then
  Begin
    fMensagem('ATENÇÃO', 'O path para os arquivos não está configurado!', ['OK']);
    Exit;
  End;

  Self.intOpcao := intOpcao;
  Self.blnMontad := blnMontad;
  Self.blnSisLin := blnSisLin;

  tblIdioma := fCriaQuery(nil, frmModulo.DataDBF);
  tblForm2k := fCriaQuery(nil, frmModulo.DataDBF);
  tblTin2k  := fCriaQuery(nil, frmModulo.DataDBF);
  tblManf2k := fCriaQuery(nil, frmModulo.DataDBF);

  qryCadBas := fCriaQuery(nil);
  qryCadAut := fCriaQuery(nil);
  qryCadMon := fCriaQuery(nil);
  qryCadSis := fCriaQuery(nil);
  cdsCadBas := TUniClientDataSet.Create(nil);

  tblForm2k.SQL.Clear;
  tblForm2k.SQL.Add('SELECT DISTINCT');
  tblForm2k.SQL.Add('	COLCOD, COLDES, ICIREF, MAKDES, VARIAN, STAYEA, ENDYEA, MIXSCH, LINCOD, FINCOD,');
  tblForm2k.SQL.Add('	TINCOD1, QUANTI1, TINCOD2, QUANTI2, TINCOD3, QUANTI3, TINCOD4, QUANTI4, TINCOD5, QUANTI5,');
  tblForm2k.SQL.Add('	TINCOD6, QUANTI6, TINCOD7, QUANTI7, TINCOD8, QUANTI8, TINCOD9, QUANTI9, TINCOD10, QUANTI10');
  tblForm2k.SQL.Add('FROM ');
  tblForm2k.SQL.Add('"' + strPat + '\form2k.dbf"');

  strForm2k := strPat + '\form2k.dbf';

  tblIdioma.SQL.Add('SELECT * FROM ' + strPat + '\idioma.dbf');
  tblTin2k.SQL.Add('SELECT * FROM ' + strPat + '\tint2k.dbf');
  tblManf2k.SQL.Add('SELECT * FROM ' + strPat + '\manf2k.dbf');

  pCriaCadBasMen;
end;

destructor TAutoColorDinamica.Destroy;
begin
  If Assigned(tblIdioma) Then FreeAndNil(tblIdioma);
  If Assigned(tblForm2k) Then FreeAndNil(tblForm2k);
  If Assigned(tblTin2k) Then FreeAndNil(tblTin2k);
  If Assigned(qryCadBas) Then FreeAndNil(qryCadBas);
  If Assigned(qryCadAut) Then FreeAndNil(qryCadAut);
  If Assigned(tblManf2k) Then FreeAndNil(tblManf2k);
  If Assigned(cdsCadBas) Then FreeAndNil(cdsCadBas);
  If Assigned(qryCadMon) Then FreeAndNil(qryCadMon);
  If Assigned(qryCadSis) Then FreeAndNil(qryCadSis);
end;

function TAutoColorDinamica.fBasesConfiguradas: Integer;
begin
  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT COUNT(BAS_CODITE) AS QTD FROM AUT_CADBAS';
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('QTD').AsInteger;
end;

function TAutoColorDinamica.fCadBasVazio: Boolean;
begin
  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS;';
  qryCadBas.Open;

  Result := qryCadBas.IsEmpty;
end;

function TAutoColorDinamica.fCarregaCadBas: Integer;
  Var
    intCont : Integer;
begin
  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS;';
  qryCadBas.Open;
  qryCadBas.First;

  cdsCadBas.Close;
  cdsCadBas.Open;

  While Not qryCadBas.Eof Do
  Begin
    cdsCadBas.Insert;

    For intCont := 0 To qryCadBas.Fields.Count - 1 Do
      cdsCadBas.Fields.Fields[intCont].Value := qryCadBas.Fields.Fields[intCont].Value;

    cdsCadBas.Post;
    qryCadBas.Next;
  End;



  Result := cdsCadBas.RecordCount;
end;

function TAutoColorDinamica.fProcessaBases: Boolean;
  Var
    intCont : Integer;
begin
  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de bases...');

  Application.ProcessMessages;

  tblIdioma.Close;
  tblIdioma.Open;
  tblTin2k.Close;
  tblTin2k.Open;

  tblTin2k.FieldDefs.Add('Descricao', ftString, 50, False);
  tblTin2k.Close;

  For intCont := 0 To tblTin2k.FieldDefs.Count - 1 Do
  Begin
    tblTin2k.FieldDefs[intCont].CreateField(tblTin2k);
  End;

  tblTin2k.FieldByName('Descricao').FieldKind  := fkLookup;
  tblTin2k.FieldByName('Descricao').FieldName  := 'Descricao';
  tblTin2k.FieldByName('Descricao').KeyFields  := 'TINCOD';
  tblTin2k.FieldByName('Descricao').LookupDataSet  := tblIdioma;
  tblTin2k.FieldByName('Descricao').LookupKeyFields  := 'CHAVE';
  tblTin2k.FieldByName('Descricao').LookupResultField  := 'PO';
  tblTin2k.FieldByName('Descricao').Lookup := True;

  tblTin2k.Open;

  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS ';
  qryCadBas.Open;

  tblTin2k.First;

  While Not tblTin2k.Eof Do
   Begin
    If qryCadBas.Locate('BAS_CODBAS;BAS_MIXSCH',
                        VarArrayOf([tblTin2k.FieldByName('TINCOD').AsString,
                        tblTin2k.FieldByName('MIXSCH').AsString]), []) Then
    Begin
      qryCadBas.Edit;
      qryCadBas.FieldByName('BAS_PESPEC').AsFloat := tblTin2k.FieldByName('SPEGRA').AsFloat;
      qryCadBas.Post;
    End
    Else
    Begin
      qryCadBas.Insert;
      qryCadBas.FieldByName('BAS_CODBAS').AsString := tblTin2k.FieldByName('TINCOD').AsString;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('BAS_DESBAS').AsString := tblTin2k.FieldByName('Descricao').AsString;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADBAS', VS_strCodEmp);
      qryCadBas.FieldByName('BAS_PESPEC').AsFloat := tblTin2k.FieldByName('SPEGRA').AsFloat;
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat := tblTin2k.FieldByName('NETCON').AsFloat * 1000;
      qryCadBas.FieldByName('BAS_MIXSCH').AsString := tblTin2k.FieldByName('MIXSCH').AsString;
      qryCadBas.Post;
    End;

    tblTin2k.Next;

    If Assigned(FRegistraProgresso) Then
      FRegistraProgresso(1, tblTin2k.RecNo, tblTin2k.RecordCount);

    Application.ProcessMessages;
   End;

  tblTin2k.Close;
  tblTin2k.Fields.Clear;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Cadastro de bases concluído com sucesso!');

  Application.ProcessMessages;
  Result := True;
end;

function TAutoColorDinamica.fProcessaDilCat: Integer;
  Var
    qryCadDil : TUniQuery;
    qryCadCat : TUniQuery;
    qryTmp    : TUniQuery;

    txtDil    : TextFile;
    txtCat    : TextFile;
    txtTmp    : TextFile;
    strLinha  : String;
begin
  qryCadDil := fCriaQuery(nil);
  qryCadCat := fCriaQuery(nil);

  qryCadDil.SQL.Text := 'TRUNCATE TABLE AUT_CADDIL';
  qryCadDil.ExecSQL;

  qryCadDil.SQL.Text := 'SELECT * FROM AUT_CADDIL';
  qryCadDil.Open;

  qryCadCat.SQL.Text := 'TRUNCATE TABLE AUT_CADCAT';
  qryCadCat.ExecSQL;

  qryCadCat.SQL.Text := 'SELECT * FROM AUT_CADCAT';
  qryCadCat.Open;

  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS';
  qryCadBas.Open;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de arquivo de catalisadores...');

  Application.ProcessMessages;

  AssignFile(txtCat, strPat + '\CATALISE.CFG');
  Reset(txtCat);

  While Not Eof(txtCat) Do
  Begin
    Readln(txtCat, strLinha);
    If (LeftStr(Trim(strLinha), 2) <> '//') And Not (fEmptyStr(strLinha)) Then
    Begin
      qryCadCat.Insert;
      qryCadCat.FieldByName('CAT_CODSIS').AsString := Copy(strLinha, 1, Pos(char(19), strLinha) - 1);
                                                      strLinha := Copy(strLinha, Pos(char(19), strLinha) + 1, Length(strLinha));
      qryCadCat.FieldByName('CAT_CODCAT').AsString := Copy(strLinha, 1, Pos(char(127), strLinha) - 1);
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadCat.FieldByName('CAT_PORMAX').AsFloat := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, Pos(char(127), strLinha) - 1),'.', ','));
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadCat.FieldByName('CAT_PORMIN').AsFloat := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, Pos(char(127), strLinha) - 1),'.', ','));
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadCat.FieldByName('CAT_DESCRI').AsString := Copy(strLinha, 1, Pos(char(127), strLinha) - 1);
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadCat.FieldByName('CAT_PESPEC').AsString := AnsiReplaceStr(Copy(strLinha, 1, Pos(char(159), strLinha) - 1), '.', ',');

      If qryCadBas.Locate('BAS_CODBAS', qryCadCat.FieldByName('CAT_CODCAT').AsString, []) Then
      Begin
        qryCadBas.Edit;
        qryCadBas.FieldByName('BAS_PESPEC').AsFloat := qryCadCat.FieldByName('CAT_PESPEC').AsFloat;
        qryCadBas.Post
      End
      Else
      Begin

        qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryCadCat.FieldByName('CAT_CODCAT').AsString;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('BAS_DESBAS').AsString := qryCadCat.FieldByName('CAT_DESCRI').AsString;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADBAS', VS_strCodEmp);
        qryCadBas.FieldByName('BAS_PESPEC').AsFloat := qryCadCat.FieldByName('CAT_PESPEC').AsFloat;
        qryCadBas.FieldByName('BAS_MIXSCH').AsString := qryCadCat.FieldByName('CAT_CODSIS').AsString;
        qryCadBas.Post;

//        fMensagem('', Format('Não foi possivel localizar a base %s', [qryCadCat.FieldByName('CAT_CODCAT').AsString]), ['OK']);
//        Result := 0;
//        qryCadCat.Cancel;
//        CloseFile(txtCat);
//        Exit;
      End;
//      Else
//      Begin
//        fMensagem('', Format('Não foi possivel localizar a base %s', [qryCadCat.FieldByName('CAT_CODCAT').AsString]), ['OK']);
//        Result := 0;
//        qryCadCat.Cancel;
//        CloseFile(txtCat);
//        Exit;
//      End;

      qryCadCat.FieldByName('CAT_CODEMP').AsString := VS_strCodEmp;
      qryCadCat.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADCAT', VS_strCodEmp);
      qryCadCat.Post;
    end;
  End;

  CloseFile(txtCat);

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Arquivo de catalisadores processado com sucesso!');

  Application.ProcessMessages;

  AssignFile(txtDil, strPat + '\DILUICAO.CFG');
  Reset(txtDil);

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de arquivo de diluição...');

  Application.ProcessMessages;

  While Not Eof(txtDil) Do
  Begin
    Readln(txtDil, strLinha);
    If (LeftStr(Trim(strLinha), 2) <> '//') And Not (fEmptyStr(strLinha)) Then
    Begin
      qryCadDil.Insert;
      qryCadDil.FieldByName('DIL_CODSIS').AsString := Copy(strLinha, 1, Pos(char(19), strLinha) - 1);
      strLinha := Copy(strLinha, Pos(char(19), strLinha) + 1, Length(strLinha));
      qryCadDil.FieldByName('DIL_CODDIL').AsString := Copy(strLinha, 1, Pos(char(127), strLinha) - 1);
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadDil.FieldByName('DIL_PORMIN').AsFloat := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, Pos(char(127), strLinha) - 1),'.', ','));
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadDil.FieldByName('DIL_PORMAX').AsFloat := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 1, Pos(char(127), strLinha) - 1),'.', ','));
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadDil.FieldByName('DIL_DESCRI').AsString := Copy(strLinha, 1, Pos(char(127), strLinha) - 1);
      strLinha := Copy(strLinha, Pos(char(127), strLinha) + 1, Length(strLinha));
      qryCadDil.FieldByName('DIL_PESPEC').AsString := AnsiReplaceStr(Copy(strLinha, 1, Pos(char(159), strLinha) - 1), '.', ',');

      If qryCadBas.Locate('BAS_CODBAS', qryCadDil.FieldByName('DIL_CODDIL').AsString, []) Then
      Begin
        qryCadBas.Edit;
        qryCadBas.FieldByName('BAS_PESPEC').AsFloat := qryCadDil.FieldByName('DIL_PESPEC').AsFloat;
        qryCadBas.Post
      End
      Else
      Begin

        qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryCadDil.FieldByName('DIL_CODDIL').AsString;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('BAS_DESBAS').AsString := qryCadDil.FieldByName('DIL_DESCRI').AsString;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADBAS', VS_strCodEmp);
        qryCadBas.FieldByName('BAS_PESPEC').AsFloat := qryCadDil.FieldByName('DIL_PESPEC').AsFloat;
        qryCadBas.FieldByName('BAS_MIXSCH').AsString := qryCadDil.FieldByName('DIL_CODSIS').AsString;
        qryCadBas.Post;

//        fMensagem('', Format('Não foi possivel localizar a base %s', [qryCadDil.FieldByName('DIL_CODDIL').AsString]), ['OK']);
//        Result := 0;
//        qryCadDil.Cancel;
//        CloseFile(txtDil);
//        Exit;
      End;
//      Else
//      Begin
//        fMensagem('', Format('Não foi possivel localizar a base %s', [qryCadDil.FieldByName('DIL_CODDIL').AsString]), ['OK']);
//        Result := 0;
//        qryCadDil.Cancel;
//        CloseFile(txtDil);
//        Exit;
//      End;

      qryCadDil.FieldByName('DIL_CODEMP').AsString := VS_strCodEmp;
      qryCadDil.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADDIL', VS_strCodEmp);
      qryCadDil.Post;
    End;
  End;

  CloseFile(txtDil);

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Arquivo de diluição processado com sucesso!');

  Application.ProcessMessages;

  Result := qryCadDil.RecordCount + qryCadCat.RecordCount;

  qryTmp := fCriaQuery(nil);
  qryTmp.SQL.Text := 'UPDATE AUT_CADDIL SET DIL_CATALI = "S" WHERE DIL_CODSIS = :CODSIS AND DIL_CODDIL = :CODDIL;';

  qryCadDil.Close;
  qryCadDil.SQL.Text := 'SELECT DISTINCT AUT_CODMAT FROM AUT_CADSIS';
  qryCadDil.Open;
  qryCadDil.First;

  While Not qryCadDil.Eof Do
  Begin
    If FileExists(strPat + '\' + qryCadDil.FieldByName('AUT_CODMAT').AsString + '.CFG') Then
    Begin
      AssignFile(txtTmp, strPat + '\' + qryCadDil.FieldByName('AUT_CODMAT').AsString + '.CFG');
      Reset(txtTmp);
      Readln(txtTmp, strLinha);
      strLinha := Copy(strLinha, Pos(Char(19), strLinha) + 1, Length(strLinha));
      strLinha := Copy(strLinha, 0, Pos(Char(127), strLinha) - 1);

      qryTmp.Close;
      qryTmp.ParamByName('CODDIL').AsString := strLinha;
      qryTmp.ParamByName('CODSIS').AsString := qryCadDil.FieldByName('AUT_CODMAT').AsString;
      qryTmp.ExecSQL;
    End;

    qryCadDil.Next;
  End;

  FreeAndNil(qryTmp);
  FreeAndNil(qryCadCat);
  FreeAndNil(qryCadDil);
end;

function TAutoColorDinamica.fProcessaMontadoras: Boolean;
begin
  tblManf2k.Close;
  tblManf2k.Open;

  qryCadMon.Close;
  qryCadMon.SQL.Text := 'SELECT * FROM AUT_CADMON';
  qryCadMon.Open;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de montadoras...');

  Application.ProcessMessages;

  While Not tblManf2k.Eof Do
  Begin
    If Not qryCadMon.Locate('AUT_CODMON', tblManf2k.FieldByName('MAKCOD').AsString, []) Then
    Begin
      qryCadMon.Insert;
      qryCadMon.FieldByName('AUT_CODMON').AsString := tblManf2k.FieldByName('MAKCOD').AsString;
      qryCadMon.FieldByName('AUT_DESCRI').AsString := tblManf2k.FieldByName('MAKDES').AsString;
      qryCadMon.FieldByName('AUT_LINHAS').AsString := tblManf2k.FieldByName('MIXSCH').AsString;
      qryCadMon.FieldByName('AUT_CODEMP').AsString := VS_strCodEmp;
      qryCadMon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADMON', VS_strCodEmp);
      qryCadMon.Post;
    End;
    tblManf2k.Next;

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, tblManf2k.RecNo, tblManf2k.RecordCount);
      Application.ProcessMessages;
    End;
  End;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Cadastro de montadoras processado com sucesso!');

  Application.ProcessMessages;

  Result := True;
end;

function TAutoColorDinamica.fProcessarArquivos: Boolean;
begin

  If intOpcao = 1 Then
  Begin
    If Not FileExists(strPat + '\idioma.dbf') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', Format('O arquivo %s não existe!', [strPat + '\idioma.dbf']), ['OK']);
      Exit;
    End;

    If Not FileExists(strPat + '\tin2k.dbf') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', Format('O arquivo %s não existe!', [strPat + '\tin2k.dbf']), ['OK']);
      Exit;
    End;

    If Not fProcessaBases Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Não foi possivel realizar o cadastro de bases!', ['OK']);
      Exit;
    End;

    If blnMontad and (Not FileExists(strPat + '\manf2k.dbf')) Then
    Begin
      Result := (fMensagem('', Format('O arquivo %s não existe, deseja continuar mesmo assim?', [strPat + '\manf2k.dbf']), ['Sim', 'Não']) = 2);
      If Result Then
        Exit
      Else
        blnMontad := False;
    End;

    If blnMontad And (Not fProcessaMontadoras) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Não foi possivel realizar o cadastro de Montadora!', ['OK']);
      Exit;
    End;
  End
  Else If intOpcao = 2 Then
  Begin
    If Not FileExists(strForm2k) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', Format('O arquivo %s não existe!', [strForm2k]), ['OK']);
      Exit;
    End;

    If Not fProcessarTintas Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Não foi possivel realizar o cadastro das tintas!', ['OK']);
      Exit;
    End;

  End
  Else If intOpcao = 3 Then
  Begin
    If fProcessaDilCat <= 0 Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Não foi possivel realizar o cadastro dos diluentes e catalisadores', ['&Ok']);
      Exit;
    End;
  End;
  Result := True;
end;

function TAutoColorDinamica.fProcessarTintas: Boolean;
  Var
    intCont : Integer;
    intForm : Integer;
    strCamp : String;
    blnCondicao : Boolean;

    lstBasNCad  : TStringList;
    fltTotalML: Double;
begin
  blnCondicao := False;

  If fCadBasVazio Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'O cadastro de bases está vazio!', ['OK']);
    Exit;
  End;

  If (fBasesConfiguradas = 0) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'O cadastro de bases não está configurado!', ['OK']);
    Exit;
  End;

  If fCarregaCadBas = 0 Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Não foi possivel carregar o cadastro de bases!', ['OK']);
    Exit;
  End;

  qryCadAut.Close;
  qryCadAut.SQL.Text := 'TRUNCATE TABLE AUT_CADAUT;';
  qryCadAut.ExecSQL;

  qryCadAut.SQL.Text := 'SELECT * FROM AUT_CADAUT WHERE FALSE;';
  qryCadAut.Open;

  if blnSisLin then
  begin
    qryCadSis.Close;
    qryCadSis.SQL.Text := 'SELECT * FROM AUT_CADSIS;';
    qryCadSis.Open;
  end;

  Try
    tblForm2k.Close;
    tblForm2k.Open;
  Except
    fMensagem('ATENÇÃO', 'Não foi possivel abrir o arquivo Form2k!', ['OK']);
    Result := False;
    Exit;
  End;

  tblForm2k.First;

  Try
    tblTin2k.Close;
    tblTin2k.Open;
  Except
    fMensagem('ATENÇÃO', 'Não foi possivel abrir o arquivo Tint2k!', ['OK']);
    Result := False;
    Exit;
  End;

  lstBasNCad := TStringList.Create;
  lstBasNCad.Clear;
  lstBasNCad.Duplicates := dupIgnore;
  lstBasNCad.Sorted := True;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de tintas...');

  Application.ProcessMessages;

  For intCont := 1 To tblForm2k.RecordCount Do
  Begin
    qryCadAut.Insert;
    fltTotalML := 0;

    For intForm := 1 To 10 Do
    Begin
      strCamp := 'TINCOD' + IntToStr(intForm);
      If fEmptyStr(tblForm2k.FieldByName(strCamp).AsString) Then
        Break;

      Try
        If tblTin2k.Locate('TINCOD', tblForm2k.FieldByName('TINCOD' + IntToStr(intForm)).AsString, []) Then
        Begin
          If (tblTin2k.FieldByName('SPEGRA').IsNull) Or (tblTin2k.FieldByName('SPEGRA').AsFloat = 0) Then
            fltTotalML := fltTotalML + (tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat / 1)
          Else
            fltTotalML := fltTotalML + (tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat / tblTin2k.FieldByName('SPEGRA').AsFloat);
        End
        Else
          fltTotalML := fltTotalML + tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat;
      Except
        fMensagem('ERRO', 'ERRO', ['OK']);
        Result := False;
        Exit;
      End;


    End;

    For intForm := 1 To 10 Do
    Begin
      strCamp := 'TINCOD' + IntToStr(intForm);
      If fEmptyStr(tblForm2k.FieldByName(strCamp).AsString) Then
        Break;

      blnCondicao := cdsCadBas.Locate('BAS_CODBAS', tblForm2k.FieldByName(strCamp).AsString, [])
                      And Not cdsCadBas.FieldByName('BAS_CODITE').IsNull;

      If Not blnCondicao Then
      Begin
        qryCadAut.Cancel;
        lstBasNCad.Add(Format('A Base %s não está configurada!' ,[tblForm2k.FieldByName(strCamp).AsString]));
        Break;
      End;

      qryCadAut.FieldByName('AUT_CODB' + fStrZero(intForm, 2)).AsString := tblForm2k.FieldByName('TINCOD' + IntToStr(intForm)).AsString;
//      qryCadAut.FieldByName('AUT_QTDC' + fStrZero(intForm, 2)).AsFloat := tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat * 0.9;


      Try
        If tblTin2k.Locate('TINCOD', tblForm2k.FieldByName('TINCOD' + IntToStr(intForm)).AsString, []) Then
        Begin

          qryCadAut.FieldByName('AUT_QTDC' + fStrZero(intForm, 2)).AsFloat :=
            900 * tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat / fltTotalML;
            
        End
        Else
          fltTotalML := fltTotalML + tblForm2k.FieldByName('QUANTI' + IntToStr(intForm)).AsFloat;
      Except
        Break;
      End;

    End;

    If Not blnCondicao Then
    Begin
      tblForm2k.Next;
      If (intCont mod 200) = 0 Then
      Try
        If Assigned(FRegistraProgresso) Then
        Begin
          FRegistraProgresso(1, intCont, tblForm2k.RecordCount);
          Application.ProcessMessages;
        End;
      Except
        fMensagem('ERRO', 'ERRO', ['OK']);
        Result := False;
        Exit;
      End;
      Continue;
    End;

    qryCadAut.FieldByName('AUT_CODIGO').AsString := tblForm2k.FieldByName('COLCOD').AsString;
    qryCadAut.FieldByName('AUT_DESCRI').AsString := tblForm2k.FieldByName('COLDES').AsString;
    qryCadAut.FieldByName('AUT_REFERE').AsString := tblForm2k.FieldByName('ICIREF').AsString;
    qryCadAut.FieldByName('AUT_MONTAD').AsString := tblForm2k.FieldByName('MAKDES').AsString;
    qryCadAut.FieldByName('AUT_VARIAN').AsString := tblForm2k.FieldByName('VARIAN').AsString;
    qryCadAut.FieldByName('AUT_ANOINI').AsString := tblForm2k.FieldByName('STAYEA').AsString;
    qryCadAut.FieldByName('AUT_ANOFIN').AsString := tblForm2k.FieldByName('ENDYEA').AsString;
    qryCadAut.FieldByName('AUT_CODSEQ').AsString := fStrZero(intCont, 6);
    qryCadAut.FieldByName('AUT_CODEMP').AsString := VS_strCodEmp;
    qryCadAut.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intCont, VS_strCodEmp);
    qryCadAut.FieldByName('AUT_MIXSCH').AsString := tblForm2k.FieldByName('MIXSCH').AsString;
    qryCadAut.FieldByName('AUT_LINHA_').AsString := tblForm2k.FieldByName('LINCOD').AsString + ' ' + tblForm2k.FieldByName('FINCOD').AsString;

    If blnSisLin And (Not qryCadSis.Locate('AUT_CODSIS;AUT_CODMAT;AUT_TIPO__',
                                            VarArrayOf([tblForm2k.FieldByName('MIXSCH').AsString,
                                                        tblForm2k.FieldByName('LINCOD').AsString,
                                                        tblForm2k.FieldByName('FINCOD').AsString]), [])) Then
    Begin
      qryCadSis.Insert;
      qryCadSis.FieldByName('AUT_CODSIS').AsString := tblForm2k.FieldByName('MIXSCH').AsString;
      qryCadSis.FieldByName('AUT_CODMAT').AsString := tblForm2k.FieldByName('LINCOD').AsString;
      qryCadSis.FieldByName('AUT_TIPO__').AsString := tblForm2k.FieldByName('FINCOD').AsString;
      qryCadSis.FieldByName('AUT_CODEMP').AsString := VS_strCodEmp;
      qryCadSis.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUT_CADSIS', VS_strCodEmp);
      qryCadSis.Post;
    End;

    qryCadAut.Post;
    tblForm2k.Next;

    If (intCont mod 200) = 0 Then
      If Assigned(FRegistraProgresso) Then
      Begin
        FRegistraProgresso(1, intCont, tblForm2k.RecordCount);
        Application.ProcessMessages;
      End;

  End;

  If Assigned(FRegistraAcao) Then
  Begin
    For intCont := 0 To lstBasNCad.Count -1 Do
    Begin
      FRegistraAcao(lstBasNCad.Strings[intCont]);
    End;
  End;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Cadastro de tintas processado com sucesso!');

  Application.ProcessMessages;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Processando cadastro de formulas personalisadas...');

  Application.ProcessMessages;

  fGravaCadNfms;

  If Assigned(FRegistraAcao) Then
    FRegistraAcao(DateTimeToStr(fNow()) + ' - Cadastro de formulas personalisadas processado com sucesso!');

  Application.ProcessMessages;

  Application.ProcessMessages;
  Result := True;
end;


procedure TAutoColorDinamica.pCriaCadBasMen;
  Var
    intCont : Integer;
begin
  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM AUT_CADBAS WHERE FALSE;';
  qryCadBas.Open;

  For intCont := 0 To qryCadBas.FieldDefs.Count - 1 Do
  Begin
    cdsCadBas.FieldDefs.Add(qryCadBas.FieldDefs[intCont].Name, qryCadBas.FieldDefs[intCont].DataType,
                            qryCadBas.FieldDefs[intCont].Size, qryCadBas.FieldDefs[intCont].Required);
  End;

  cdsCadBas.CreateDataSet;
end;

function fGravaCadNfm(qryCadNfm : TUniQuery): Boolean;
  Var
    qryCadAut : TUniQuery;
    intCont : Integer;
begin
  qryCadAut := fCriaQuery(nil);
  qryCadAut.SQL.Text := 'DELETE FROM AUT_CADAUT WHERE AUT_CODNFM = :CODNFM';
  qryCadAut.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadAut.ExecSQL;

  qryCadAut.SQL.Text := 'SELECT * FROM AUT_CADAUT WHERE FALSE';
  qryCadAut.Open;

  qryCadAut.Insert;
  qryCadAut.FieldByName('AUT_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadAut.FieldByName('AUT_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadAut.FieldByName('AUT_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
  qryCadAut.FieldByName('AUT_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
  qryCadAut.FieldByName('AUT_VARIAN').AsString := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
  qryCadAut.FieldByName('AUT_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
  qryCadAut.FieldByName('AUT_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
  qryCadAut.FieldByName('AUT_CODSEQ').AsString := fStrZero(fRetProxcodSeq, 6);
  qryCadAut.FieldByName('AUT_CODEMP').AsString := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
  qryCadAut.FieldByName('AUTOINCREM').AsString := fFormataAutInc(fRetProxcodSeq, VS_strCodEmp);
  qryCadAut.FieldByName('AUT_MIXSCH').AsString := qryCadNfm.FieldByName('NFM_MIXSCH').AsString;

  For intCont := 1 To 10 Do
  Begin
    If fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString) Then
      Break;

    qryCadAut.FieldByName('AUT_CODB' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString;
    qryCadAut.FieldByName('AUT_QTDC' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString;
  End;

  qryCadAut.FieldByName('AUT_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadAut.FieldByName('AUT_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
  qryCadAut.Post;

  FreeAndNil(qryCadAut);
  Result := True;
end;

function fRetProxcodSeq: Integer;
  Var
    qryCadAut : TUniQuery;
begin
  qryCadAut := fCriaQuery(nil);
  qryCadAut.SQL.Text := 'SELECT AUT_CODSEQ FROM AUT_CADAUT ORDER BY AUT_CODSEQ DESC LIMIT 1';
  qryCadAut.Open;
  If qryCadAut.IsEmpty Then
    Result := 1
  Else
    Result := qryCadAut.FieldByName('AUT_CODSEQ').AsInteger + 1;
  FreeAndNil(qryCadAut);
end;

function TAutoColorDinamica.fGravaCadNfms: Boolean;
  Var
    qryCadNfm : TUniQuery;
begin
  qryCadNfm := fCriaQuery(nil);
  qryCadNfm.SQL.Text := 'SELECT * FROM AUT_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  If Assigned(FRegistraAcao) Then FRegistraAcao('Cadastrando novas formulas...');

  TTintadeMaquina.fAjustaInicialAutoIncremento('AUT_CADAUT', VS_strCodEmp);

  While Not qryCadNfm.Eof Do
  Begin
    Result := fGravaCadNfm(qryCadNfm);

    If Not Result Then
      Break;

    qryCadNfm.Next;
    If Assigned(FRegistraProgresso) Then FRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

  End;

  FreeAndNil(qryCadNfm);
  If Assigned(FRegistraAcao) Then FRegistraAcao('Novas formulas cadastradas com sucesso!');

  Result := True;
end;

constructor TAutoColorDinamica.CreateNovasFormulas;
begin
  //
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    qryCadAut : TUniQuery;
begin
  qryCadAut := fCriaQuery(nil);
  qryCadAut.SQL.Text := 'DELETE FROM AUT_CADAUT WHERE AUT_CODNFM = :CODNFM';
  qryCadAut.ParamByName('CODNFM').AsString := strCodigo;
  qryCadAut.ExecSQL;
  FreeAndNil(qryCadAut);
end;

end.
