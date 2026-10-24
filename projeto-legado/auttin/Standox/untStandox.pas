unit untStandox;

interface

uses SysUtils, Classes, Uni, Forms, DBClient, Variants, DB,
  Math, DateUtils, StrUtils, untTintadeMaquina, XMLDoc, XMLIntf, DBGridCitel, DBGrids, Controls,
  UniClientDataSet;


Type
  TStandoxAutomotiva = class(TTintadeMaquina)
  private

  public
    function fGravaNovasFormulas(): Boolean;
    function fGravarNovasFormulas: Boolean; override;
  End;

  function fGerarBases: Boolean;
  function fGerarBasesEuropa: Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodPro: String);
  function fRetProCodSeq: Integer;
  function fGetMd5MySQl(strTexto: String): String;
  function fRetCampoBas(strCampo: String; intPos: Integer; strLinha: String): Variant;
  function fRetEmbalagem(strEmbalagem: String): Double;

  // Brasil
  function fStandoxGeraArquivo(blnGerBas: Boolean): Boolean;
  procedure pGerarStandoxTipoUm(qryCadDox: TUniQuery; stlFormulas: TStringList; Var intTipoUm: Integer);
  procedure pGerarStandoxTipoDois(qryCadDox: TUniQuery; stlFormulas: TStringList; intTipoUm: Integer);
  procedure pAdicionaDiluentes;

  // Europa
  function fStandoxGerarAquivoEuropa(blnGerBas : Boolean) : Boolean;

  procedure pGerarStandoxTipoUmEuropa(qryCadDox: TUniQuery; stlFormulas: TStringList; Var intTipoUm: Integer);
  procedure pGerarStandoxTipoDoisEuropa(qryCadDox: TUniQuery; stlFormulas: TStringList; intTipoUm: Integer);

  var
  arrCodDil: Array[0..4] Of String[10]  = ('MSB 10-20',
                                           'MSB 15-25',
                                           'MSB 25-35',
                                           'STBLCOATA',
                                           'STBLADJSL');

  arrCodigo: Array[0..4] Of String[12] = ('T44192002/10',
                                          'T24892002/10',
                                          'T82602002/10',
                                          'T00292000/1S',
                                          'T03012000/1S');

  arrDescri: Array[0..4] Of String[50] = ('Standox Thinner MSB 10-20',
                                          'Standox Thinner MSB 15-25',
                                          'Standox Thinner MSB 25-35',
                                          'STANDOBLUE BASECOAT VISCOSITY ADJUSTER',
                                          'STANDOBLUE VISCOSITY ADJUSTER SLOW');

  arrPesEsp: Array[0..4] Of Double = (0.88,
                                      0.85,
                                      0.87,
                                      1.01,
                                      1.01);

  cdsMD5: TUniClientDataSet;

implementation

uses untFuncoes, untFuncTinta,
  untModuloTinta, untFuncoesSimples;

function fStandoxGeraArquivo(blnGerBas: Boolean): Boolean;
  Var
    strPatDox: String;

    qryCadDox: TUniQuery;
    stlFormulas: TStringList;
    intTipoUm: Integer;
    strLin: String;
    txtArq: TextFile;
begin

  intTipoUm := 0;

  If blnGerBas Then
  Begin
    Result := fGerarBases;

    If fGetConfTinta('DOX').fGet('DOXARQ') = '1' Then
      Result := fGerarBasesEuropa;

    Exit;
  End;

  strPatDox :=  fGetConfTinta('DOX').fGet('PATDOX');
  If (Not FileExists(strPatDox + '\Brazil.txt')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDox + '\Brazil.txt não existe!', ['&Ok']);
    Exit;
  End;

  Result := True;

  cdsMd5 := TUniClientDataSet.Create(Nil);
  With cdsMd5.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MD5KEY';
    DataType := ftString;
    Size     := 32;
  End;
  cdsMd5.CreateDataSet;

  pZapTable('DOX_CADDOX');

  Try
    stlFormulas := TStringList.Create;
    AssignFile(txtArq, strPatDox + '\Brazil.txt');
    Reset(txtArq);
    while not Eof (txtArq) do
    begin
      ReadLn (txtArq, strLin);
      stlFormulas.Add(strLin);
    end;
    CloseFile (txtArq);

    qryCadDox := fCriaQuery(Nil);
    qryCadDox.Close;
    qryCadDox.SQL.Clear;
    qryCadDox.SQL.Add('INSERT INTO DOX_CADDOX ( ');
    qryCadDox.SQL.Add('DOX_CODSEQ, ');
    qryCadDox.SQL.Add('DOX_MONTAD, ');
    qryCadDox.SQL.Add('DOX_CODDOX, ');
    qryCadDox.SQL.Add('DOX_DESCRI, ');
    qryCadDox.SQL.Add('DOX_VERSAO, ');
    qryCadDox.SQL.Add('DOX_ANOINI, ');
    qryCadDox.SQL.Add('DOX_ANOFIN, ');
    qryCadDox.SQL.Add('DOX_PAINEL, ');
    qryCadDox.SQL.Add('DOX_CATEGO, ');
    qryCadDox.SQL.Add('DOX_PAIS__, ');
    qryCadDox.SQL.Add('DOX_VARIAN, ');
    qryCadDox.SQL.Add('DOX_QUALID, ');
    qryCadDox.SQL.Add('DOX_INFCOR, ');
    qryCadDox.SQL.Add('DOX_MD5KEY, ');
    qryCadDox.SQL.Add('DOX_CODEMP, ');
    qryCadDox.SQL.Add('AUTOINCREM, ');
    qryCadDox.SQL.Add('DOX_BASE01, ');
    qryCadDox.SQL.Add('DOX_QTDC01, ');
    qryCadDox.SQL.Add('DOX_BASE02, ');
    qryCadDox.SQL.Add('DOX_QTDC02, ');
    qryCadDox.SQL.Add('DOX_BASE03, ');
    qryCadDox.SQL.Add('DOX_QTDC03, ');
    qryCadDox.SQL.Add('DOX_BASE04, ');
    qryCadDox.SQL.Add('DOX_QTDC04, ');
    qryCadDox.SQL.Add('DOX_BASE05, ');
    qryCadDox.SQL.Add('DOX_QTDC05, ');
    qryCadDox.SQL.Add('DOX_BASE06, ');
    qryCadDox.SQL.Add('DOX_QTDC06, ');
    qryCadDox.SQL.Add('DOX_BASE07, ');
    qryCadDox.SQL.Add('DOX_QTDC07, ');
    qryCadDox.SQL.Add('DOX_BASE08, ');
    qryCadDox.SQL.Add('DOX_QTDC08, ');
    qryCadDox.SQL.Add('DOX_BASE09, ');
    qryCadDox.SQL.Add('DOX_QTDC09, ');
    qryCadDox.SQL.Add('DOX_BASE10, ');
    qryCadDox.SQL.Add('DOX_QTDC10, ');
    qryCadDox.SQL.Add('DOX_BASE11, ');
    qryCadDox.SQL.Add('DOX_QTDC11, ');
    qryCadDox.SQL.Add('DOX_BASE12, ');
    qryCadDox.SQL.Add('DOX_QTDC12, ');
    qryCadDox.SQL.Add('DOX_BASE13, ');
    qryCadDox.SQL.Add('DOX_QTDC13, ');
    qryCadDox.SQL.Add('DOX_BASE14, ');
    qryCadDox.SQL.Add('DOX_QTDC14, ');
    qryCadDox.SQL.Add('DOX_BASE15, ');
    qryCadDox.SQL.Add('DOX_QTDC15, ');
    qryCadDox.SQL.Add('DOX_BASE16, ');
    qryCadDox.SQL.Add('DOX_QTDC16, ');
    qryCadDox.SQL.Add('DOX_BASE17, ');
    qryCadDox.SQL.Add('DOX_QTDC17, ');
    qryCadDox.SQL.Add('DOX_BASE18, ');
    qryCadDox.SQL.Add('DOX_QTDC18, ');
    qryCadDox.SQL.Add('DOX_BASE19, ');
    qryCadDox.SQL.Add('DOX_QTDC19, ');
    qryCadDox.SQL.Add('DOX_BASE20, ');
    qryCadDox.SQL.Add('DOX_QTDC20) ');
    qryCadDox.SQL.Add(' VALUES ( ');
    qryCadDox.SQL.Add(':DOX_CODSEQ, ');
    qryCadDox.SQL.Add(':DOX_MONTAD, ');
    qryCadDox.SQL.Add(':DOX_CODDOX, ');
    qryCadDox.SQL.Add(':DOX_DESCRI, ');
    qryCadDox.SQL.Add(':DOX_VERSAO, ');
    qryCadDox.SQL.Add(':DOX_ANOINI, ');
    qryCadDox.SQL.Add(':DOX_ANOFIN, ');
    qryCadDox.SQL.Add(':DOX_PAINEL, ');
    qryCadDox.SQL.Add(':DOX_CATEGO, ');
    qryCadDox.SQL.Add(':DOX_PAIS__, ');
    qryCadDox.SQL.Add(':DOX_VARIAN, ');
    qryCadDox.SQL.Add(':DOX_QUALID, ');
    qryCadDox.SQL.Add(':DOX_INFCOR, ');
    qryCadDox.SQL.Add(':DOX_MD5KEY, ');
    qryCadDox.SQL.Add(':DOX_CODEMP, ');
    qryCadDox.SQL.Add(':AUTOINCREM, ');
    qryCadDox.SQL.Add(':DOX_BASE01, ');
    qryCadDox.SQL.Add(':DOX_QTDC01, ');
    qryCadDox.SQL.Add(':DOX_BASE02, ');
    qryCadDox.SQL.Add(':DOX_QTDC02, ');
    qryCadDox.SQL.Add(':DOX_BASE03, ');
    qryCadDox.SQL.Add(':DOX_QTDC03, ');
    qryCadDox.SQL.Add(':DOX_BASE04, ');
    qryCadDox.SQL.Add(':DOX_QTDC04, ');
    qryCadDox.SQL.Add(':DOX_BASE05, ');
    qryCadDox.SQL.Add(':DOX_QTDC05, ');
    qryCadDox.SQL.Add(':DOX_BASE06, ');
    qryCadDox.SQL.Add(':DOX_QTDC06, ');
    qryCadDox.SQL.Add(':DOX_BASE07, ');
    qryCadDox.SQL.Add(':DOX_QTDC07, ');
    qryCadDox.SQL.Add(':DOX_BASE08, ');
    qryCadDox.SQL.Add(':DOX_QTDC08, ');
    qryCadDox.SQL.Add(':DOX_BASE09, ');
    qryCadDox.SQL.Add(':DOX_QTDC09, ');
    qryCadDox.SQL.Add(':DOX_BASE10, ');
    qryCadDox.SQL.Add(':DOX_QTDC10, ');
    qryCadDox.SQL.Add(':DOX_BASE11, ');
    qryCadDox.SQL.Add(':DOX_QTDC11, ');
    qryCadDox.SQL.Add(':DOX_BASE12, ');
    qryCadDox.SQL.Add(':DOX_QTDC12, ');
    qryCadDox.SQL.Add(':DOX_BASE13, ');
    qryCadDox.SQL.Add(':DOX_QTDC13, ');
    qryCadDox.SQL.Add(':DOX_BASE14, ');
    qryCadDox.SQL.Add(':DOX_QTDC14, ');
    qryCadDox.SQL.Add(':DOX_BASE15, ');
    qryCadDox.SQL.Add(':DOX_QTDC15, ');
    qryCadDox.SQL.Add(':DOX_BASE16, ');
    qryCadDox.SQL.Add(':DOX_QTDC16, ');
    qryCadDox.SQL.Add(':DOX_BASE17, ');
    qryCadDox.SQL.Add(':DOX_QTDC17, ');
    qryCadDox.SQL.Add(':DOX_BASE18, ');
    qryCadDox.SQL.Add(':DOX_QTDC18, ');
    qryCadDox.SQL.Add(':DOX_BASE19, ');
    qryCadDox.SQL.Add(':DOX_QTDC19, ');
    qryCadDox.SQL.Add(':DOX_BASE20, ');
    qryCadDox.SQL.Add(':DOX_QTDC20) ');

    pGerarStandoxTipoUm(qryCadDox, stlFormulas, intTipoUm);
    pGerarStandoxTipoDois(qryCadDox, stlFormulas, intTipoUm);

    qryCadDox.Close;

  Finally
    FreeAndNil(stlFormulas);
    FreeAndNil(qryCadDox);
    FreeAndNil(cdsMD5);

    If fGetConfTinta('DOX').fGet('DOXARQ') = '1' Then
     fStandoxGerarAquivoEuropa(blnGerBas);
  End;
end;

function fGerarBasesEuropa: Boolean;
Var
  qryAux     : TUniQuery;
  qryCadBas  : TUniQuery;

  strPatDox  : String;
  strLinha   : String;
  strLin     : String;

  strCodBas  : String;

  intCont    : Integer;
  intLinha   : Integer;
  intSEQ     : Integer;
  stlFormulas: TStringList;
  txtArq     : TextFile;
begin
  strPatDox := fGetConfTinta('DOX').fGet('PATDOX');

  If (Not FileExists(strPatDox + '\Standowin_EUR.txt')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDox + '\Standowin_EUR.txt não existe!', ['&Ok']);
    Exit;
  End;

  Try
    stlFormulas := TStringList.Create;
    AssignFile(txtArq, strPatDox + '\Standowin_EUR.txt');
    Reset(txtArq);

    while not Eof (txtArq) do
    begin
      ReadLn (txtArq, strLin);
      stlFormulas.Add(strLin);
    end;

    CloseFile (txtArq);

    intLinha := 0;

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT COUNT(*) CODSEQ'+
                       '  FROM DOX_CADBAS '+
                       ' WHERE BAS_CODEMP = :CODEMP ';
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    intSEQ := qryAux.FieldByName('CODSEQ').AsInteger;


    qryCadBas := fCriaQuery(Nil);
    qryCadBas.Close;
    qryCadBas.SQL.Text := 'SELECT * '+
                          '  FROM DOX_CADBAS '+
                          ' WHERE FALSE; ';
    qryCadBas.Open;

    While (intLinha < stlFormulas.Count) Do
    Begin
      strLinha := stlFormulas[intLinha];

      Inc(intLinha);

      For intCont := 1 to 20 Do
      Begin
        strCodBas := fRetCampoBas('CODBAS', intCont, strLinha);

        if fEmptyStr(strCodBas) Then
          Continue;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Text := 'SELECT * '+
                           '  FROM DOX_CADBAS '+
                           ' WHERE BAS_CODEMP = :CODEMP '+
                           '   AND BAS_CODBAS = :CODBAS ';
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.ParamByName('CODBAS').AsString := strCodBas;

        qryAux.Open;

        If (qryAux.IsEmpty) Then
        Begin
          Inc(intSEQ);
          qryCadBas.Insert;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
          qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryCadBas.FieldByName('BAS_PESESP').AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('PESESP',intCont,strLinha),'.',','));
          qryCadBas.FieldByName('BAS_DESBAS').AsString := UpperCase(fRetCampoBas('DESBAS',intCont,strLinha));
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(fRetCampoBas('EMBALA',intCont,strLinha));
          qryCadBas.FieldByName('BAS_PESGRA').AsString := 'N';
          qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intSEQ, VS_strCodEmp);
          qryCadBas.Post;
        End;

      End;

    End;

    Application.ProcessMessages;

    fGravaAutoIncrem('DOX_CADBAS', intSEQ);

    pAdicionaDiluentes;

    Result := True;
  Finally
    If Assigned(stlFormulas) Then FreeAndNil(stlFormulas);
    If Assigned(qryCadBas)   Then FreeAndNil(qryCadBas);
    If Assigned(qryAux)      Then FreeAndNil(qryAux);
  End;
end;


function fGerarBases: Boolean;
  Var
    strPatDox: String;
    qryCadBas,
    qrySel: TUniQuery;
    strLinha, strLin : String;
    cdsBases: TUniClientDataSet;
    intCont,
    intLinha: Integer;
    stlFormulas: TStringList;
    txtArq: TextFile;
    strCodbas : String;
begin
  strPatDox := fGetConfTinta('DOX').fGet('PATDOX');
  If (Not FileExists(strPatDox + '\Brazil.txt')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDox + '\Brazil.txt não existe!', ['&Ok']);
    Exit;
  End;

  pZapTable('DOX_CADBAS');

  Try
    stlFormulas := TStringList.Create;
    AssignFile(txtArq, strPatDox + '\Brazil.txt');
    Reset(txtArq);
    while not Eof (txtArq) do
    begin
      ReadLn (txtArq, strLin);
      stlFormulas.Add(strLin);
    end;
    CloseFile (txtArq);

    qrySel := fCriarQuery('SELECT * FROM DOX_CADBAS WHERE FALSE',Nil);

    cdsBases := fCriaClientDatset(qrySel, True, Nil);

    qryCadBas := fCriaQuery(Nil);
    qryCadBas.Close;
    qryCadBas.SQL.Clear;
    qryCadBas.SQL.Add('INSERT INTO DOX_CADBAS (');
    qryCadBas.SQL.Add('  BAS_CODBAS, ');
    qryCadBas.SQL.Add('  BAS_CODEMP, ');
    qryCadBas.SQL.Add('  BAS_PESESP, ');
    qryCadBas.SQL.Add('  BAS_DESBAS, ');
    qryCadBas.SQL.Add('  BAS_EMBALA, ');
    qryCadBas.SQL.Add('  BAS_PESGRA, ');
    qryCadBas.SQL.Add('  AUTOINCREM) ');
    qryCadBas.SQL.Add('VALUES ( ');
    qryCadBas.SQL.Add('  :CODBAS, ');
    qryCadBas.SQL.Add('  :CODEMP, ');
    qryCadBas.SQL.Add('  :PESESP, ');
    qryCadBas.SQL.Add('  :DESBAS, ');
    qryCadBas.SQL.Add('  :EMBALA, ');
    qryCadBas.SQL.Add('  :PESGRA, ');
    qryCadBas.SQL.Add('  :AUTINC) ');

    intLinha := 0;
    While (intLinha < stlFormulas.Count) Do
    Begin

      strLinha := stlFormulas[intLinha];

      If ((Trim(fRetCampoBas('PAIS',0,strLinha)) = 'BRAZIL') Or (Trim(fRetCampoBas('PAIS',0,strLinha)) = 'BRASIL')) Then
      Begin
        For intCont := 1 to 20 Do
        Begin
          strCodbas := fRetCampoBas('CODBAS', intCont, strLinha);

          If Not cdsBases.Locate('BAS_CODBAS',strCodbas,[]) Then
          Begin
            If Not fEmptyStr(fRetCampoBas('CODBAS', intCont, strLinha)) Then
            Begin
              cdsBases.Append;
              cdsBases.FieldByName('BAS_CODBAS').AsString := strCodbas;
              cdsBases.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
              cdsBases.FieldByName('BAS_PESESP').AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('PESESP',intCont,strLinha),'.',','));
              cdsBases.FieldByName('BAS_DESBAS').AsString := UpperCase(fRetCampoBas('DESBAS',intCont,strLinha));
              cdsBases.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(fRetCampoBas('EMBALA',intCont,strLinha));
              cdsBases.FieldByName('BAS_PESGRA').AsString := 'N';
              cdsBases.Post;
            End;
          End;
        End;
      End;

      Inc(intLinha);
      Application.ProcessMessages;
    End;

    cdsBases.First;
    While Not cdsBases.Eof Do
    Begin
      qryCadBas.ParamByName('CODBAS').AsString := cdsBases.FieldByName('BAS_CODBAS').AsString;
      qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCadBas.ParamByName('PESESP').AsFloat  := cdsBases.FieldByName('BAS_PESESP').AsFloat;
      qryCadBas.ParamByName('AUTINC').AsString := fFormataAutInc(cdsBases.RecNo, VS_strCodEmp);
      qryCadBas.ParamByName('DESBAS').AsString := UpperCase(cdsBases.FieldByName('BAS_DESBAS').AsString);
      qryCadBas.ParamByName('EMBALA').AsFloat  := cdsBases.FieldByName('BAS_EMBALA').AsFloat;
      qryCadBas.ParamByName('PESGRA').AsString := 'N';
      qryCadBas.ExecSQL;

      cdsBases.Next;
      Application.ProcessMessages;
    End;

    fGravaAutoIncrem('DOX_CADBAS', cdsBases.RecordCount);

    pAdicionaDiluentes;

    Result := True;
  Finally
    FreeAndNil(stlFormulas);
    FreeAndNil(qrySel);
    FreeAndNil(cdsBases);
    FreeAndNil(qryCadBas);
  End;
end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadDox: TUniQuery;
    strCodSeq: String;
    strAutInc: String;
    intContador: Integer;
begin

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  Try
    qryCadDox := fCriaQuery;
    qryCadDox.SQL.Add('SELECT * FROM DOX_CADDOX ORDER BY AUTOINCREM DESC LIMIT 1');
    qryCadDox.Open;

    strCodSeq := fStrZero(fRetProCodSeq,6);
    strAutInc := fRetAutoIncrem('DOX_CADDOX', VS_strCodEmp);

    qryCadDox.Append;

    qryCadDox.FieldByName('DOX_CODSEQ').AsString := strCodSeq;
    qryCadDox.FieldByName('DOX_CODDOX').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCadDox.FieldByName('DOX_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCadDox.FieldByName('DOX_VERSAO').AsString := qryCadNfm.FieldByName('NFM_VERSAO').AsString;
    qryCadDox.FieldByName('DOX_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;
    qryCadDox.FieldByName('DOX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryCadDox.FieldByName('DOX_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
    qryCadDox.FieldByName('DOX_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
    qryCadDox.FieldByName('DOX_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
    qryCadDox.FieldByName('DOX_CATEGO').AsString := qryCadNfm.FieldByName('NFM_CATEGO').AsString;
    qryCadDox.FieldByName('DOX_PAIS__').AsString := qryCadNfm.FieldByName('NFM_PAIS__').AsString;
    qryCadDox.FieldByName('DOX_VARIAN').AsString := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
    qryCadDox.FieldByName('DOX_CODEMP').AsString := VS_strCodEmp;
    qryCadDox.FieldByName('AUTOINCREM').AsString := strAutInc;
    qryCadDox.FieldByName('DOX_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
    qryCadDox.FieldByName('DOX_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
    qryCadDox.FieldByName('DOX_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
    intContador := 1;

    While intContador <= 20 Do
    Begin

      If (fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString)) Then
      Begin
        Break;
      End;

      qryCadDox.FieldByName('DOX_BASE' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
      qryCadDox.FieldByName('DOX_QTDC' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat;

      Inc(intContador);

    End;

    qryCadDox.FieldByName('DOX_MD5KEY').AsString := fGetMd5MySql(qryCadDox.FieldByName('DOX_MONTAD').AsString + qryCadDox.FieldByName('DOX_CODDOX').AsString +
                                                                 qryCadDox.FieldByName('DOX_DESCRI').AsString + qryCadDox.FieldByName('DOX_VERSAO').AsString +
                                                                 qryCadDox.FieldByName('DOX_ANOINI').AsString + qryCadDox.FieldByName('DOX_ANOFIN').AsString +
                                                                 qryCadDox.FieldByName('DOX_PAINEL').AsString + qryCadDox.FieldByName('DOX_CATEGO').AsString +
                                                                 qryCadDox.FieldByName('DOX_PAIS__').AsString + qryCadDox.FieldByName('DOX_VARIAN').AsString +
                                                                 qryCadDox.FieldByName('DOX_QUALID').AsString + qryCadDox.FieldByName('DOX_INFCOR').AsString +
                                        qryCadDox.FieldByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC01').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC02').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC03').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC04').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC05').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC06').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC07').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC08').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC09').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC10').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC11').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC12').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC13').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC14').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC15').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC16').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC17').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC18').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC19').AsFloat), ',', '.') +
                                        qryCadDox.FieldByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC20').AsFloat), ',', '.'));  

    qryCadDox.Post;
    qryCadDox.Close;

    Result := True;
  Finally
    FreeAndNil(qryCadDox);
  End;
end;

function fStandoxGerarAquivoEuropa(blnGerBas : Boolean) : Boolean;
  Var
    strPatDox: String;

    qryCadDox: TUniQuery;
    stlFormulas: TStringList;
    intTipoUm: Integer;
    strLin: String;
    txtArq: TextFile;
begin

  intTipoUm := 0;

  If blnGerBas Then
  Begin
    Result := fGerarBasesEuropa;
    Exit;
  End;

  strPatDox :=  fGetConfTinta('DOX').fGet('PATDOX');
  If (Not FileExists(strPatDox + '\Standowin_EUR.txt')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDox + '\Standowin_EUR.txt não existe!', ['&Ok']);
    Exit;
  End;

  Result := True;

  cdsMd5 := TUniClientDataSet.Create(Nil);
  With cdsMd5.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MD5KEY';
    DataType := ftString;
    Size     := 32;
  End;

  cdsMd5.CreateDataSet;

  Try
    stlFormulas := TStringList.Create;
    AssignFile(txtArq, strPatDox + '\Standowin_EUR.txt');
    Reset(txtArq);
    while not Eof (txtArq) do
    begin
      ReadLn (txtArq, strLin);
      stlFormulas.Add(strLin);
    end;
    CloseFile (txtArq);

    qryCadDox := fCriaQuery(Nil);
    qryCadDox.Close;
    qryCadDox.SQL.Clear;
    qryCadDox.SQL.Add('INSERT INTO DOX_CADDOX ( ');
    qryCadDox.SQL.Add('DOX_CODSEQ, ');
    qryCadDox.SQL.Add('DOX_MONTAD, ');
    qryCadDox.SQL.Add('DOX_CODDOX, ');
    qryCadDox.SQL.Add('DOX_DESCRI, ');
    qryCadDox.SQL.Add('DOX_VERSAO, ');
    qryCadDox.SQL.Add('DOX_ANOINI, ');
    qryCadDox.SQL.Add('DOX_ANOFIN, ');
    qryCadDox.SQL.Add('DOX_PAINEL, ');
    qryCadDox.SQL.Add('DOX_CATEGO, ');
    qryCadDox.SQL.Add('DOX_PAIS__, ');
    qryCadDox.SQL.Add('DOX_VARIAN, ');
    qryCadDox.SQL.Add('DOX_QUALID, ');
    qryCadDox.SQL.Add('DOX_INFCOR, ');
    qryCadDox.SQL.Add('DOX_MD5KEY, ');
    qryCadDox.SQL.Add('DOX_CODEMP, ');
    qryCadDox.SQL.Add('AUTOINCREM, ');
    qryCadDox.SQL.Add('DOX_BASE01, ');
    qryCadDox.SQL.Add('DOX_QTDC01, ');
    qryCadDox.SQL.Add('DOX_BASE02, ');
    qryCadDox.SQL.Add('DOX_QTDC02, ');
    qryCadDox.SQL.Add('DOX_BASE03, ');
    qryCadDox.SQL.Add('DOX_QTDC03, ');
    qryCadDox.SQL.Add('DOX_BASE04, ');
    qryCadDox.SQL.Add('DOX_QTDC04, ');
    qryCadDox.SQL.Add('DOX_BASE05, ');
    qryCadDox.SQL.Add('DOX_QTDC05, ');
    qryCadDox.SQL.Add('DOX_BASE06, ');
    qryCadDox.SQL.Add('DOX_QTDC06, ');
    qryCadDox.SQL.Add('DOX_BASE07, ');
    qryCadDox.SQL.Add('DOX_QTDC07, ');
    qryCadDox.SQL.Add('DOX_BASE08, ');
    qryCadDox.SQL.Add('DOX_QTDC08, ');
    qryCadDox.SQL.Add('DOX_BASE09, ');
    qryCadDox.SQL.Add('DOX_QTDC09, ');
    qryCadDox.SQL.Add('DOX_BASE10, ');
    qryCadDox.SQL.Add('DOX_QTDC10, ');
    qryCadDox.SQL.Add('DOX_BASE11, ');
    qryCadDox.SQL.Add('DOX_QTDC11, ');
    qryCadDox.SQL.Add('DOX_BASE12, ');
    qryCadDox.SQL.Add('DOX_QTDC12, ');
    qryCadDox.SQL.Add('DOX_BASE13, ');
    qryCadDox.SQL.Add('DOX_QTDC13, ');
    qryCadDox.SQL.Add('DOX_BASE14, ');
    qryCadDox.SQL.Add('DOX_QTDC14, ');
    qryCadDox.SQL.Add('DOX_BASE15, ');
    qryCadDox.SQL.Add('DOX_QTDC15, ');
    qryCadDox.SQL.Add('DOX_BASE16, ');
    qryCadDox.SQL.Add('DOX_QTDC16, ');
    qryCadDox.SQL.Add('DOX_BASE17, ');
    qryCadDox.SQL.Add('DOX_QTDC17, ');
    qryCadDox.SQL.Add('DOX_BASE18, ');
    qryCadDox.SQL.Add('DOX_QTDC18, ');
    qryCadDox.SQL.Add('DOX_BASE19, ');
    qryCadDox.SQL.Add('DOX_QTDC19, ');
    qryCadDox.SQL.Add('DOX_BASE20, ');
    qryCadDox.SQL.Add('DOX_QTDC20) ');
    qryCadDox.SQL.Add(' VALUES ( ');
    qryCadDox.SQL.Add(':DOX_CODSEQ, ');
    qryCadDox.SQL.Add(':DOX_MONTAD, ');
    qryCadDox.SQL.Add(':DOX_CODDOX, ');
    qryCadDox.SQL.Add(':DOX_DESCRI, ');
    qryCadDox.SQL.Add(':DOX_VERSAO, ');
    qryCadDox.SQL.Add(':DOX_ANOINI, ');
    qryCadDox.SQL.Add(':DOX_ANOFIN, ');
    qryCadDox.SQL.Add(':DOX_PAINEL, ');
    qryCadDox.SQL.Add(':DOX_CATEGO, ');
    qryCadDox.SQL.Add(':DOX_PAIS__, ');
    qryCadDox.SQL.Add(':DOX_VARIAN, ');
    qryCadDox.SQL.Add(':DOX_QUALID, ');
    qryCadDox.SQL.Add(':DOX_INFCOR, ');
    qryCadDox.SQL.Add(':DOX_MD5KEY, ');
    qryCadDox.SQL.Add(':DOX_CODEMP, ');
    qryCadDox.SQL.Add(':AUTOINCREM, ');
    qryCadDox.SQL.Add(':DOX_BASE01, ');
    qryCadDox.SQL.Add(':DOX_QTDC01, ');
    qryCadDox.SQL.Add(':DOX_BASE02, ');
    qryCadDox.SQL.Add(':DOX_QTDC02, ');
    qryCadDox.SQL.Add(':DOX_BASE03, ');
    qryCadDox.SQL.Add(':DOX_QTDC03, ');
    qryCadDox.SQL.Add(':DOX_BASE04, ');
    qryCadDox.SQL.Add(':DOX_QTDC04, ');
    qryCadDox.SQL.Add(':DOX_BASE05, ');
    qryCadDox.SQL.Add(':DOX_QTDC05, ');
    qryCadDox.SQL.Add(':DOX_BASE06, ');
    qryCadDox.SQL.Add(':DOX_QTDC06, ');
    qryCadDox.SQL.Add(':DOX_BASE07, ');
    qryCadDox.SQL.Add(':DOX_QTDC07, ');
    qryCadDox.SQL.Add(':DOX_BASE08, ');
    qryCadDox.SQL.Add(':DOX_QTDC08, ');
    qryCadDox.SQL.Add(':DOX_BASE09, ');
    qryCadDox.SQL.Add(':DOX_QTDC09, ');
    qryCadDox.SQL.Add(':DOX_BASE10, ');
    qryCadDox.SQL.Add(':DOX_QTDC10, ');
    qryCadDox.SQL.Add(':DOX_BASE11, ');
    qryCadDox.SQL.Add(':DOX_QTDC11, ');
    qryCadDox.SQL.Add(':DOX_BASE12, ');
    qryCadDox.SQL.Add(':DOX_QTDC12, ');
    qryCadDox.SQL.Add(':DOX_BASE13, ');
    qryCadDox.SQL.Add(':DOX_QTDC13, ');
    qryCadDox.SQL.Add(':DOX_BASE14, ');
    qryCadDox.SQL.Add(':DOX_QTDC14, ');
    qryCadDox.SQL.Add(':DOX_BASE15, ');
    qryCadDox.SQL.Add(':DOX_QTDC15, ');
    qryCadDox.SQL.Add(':DOX_BASE16, ');
    qryCadDox.SQL.Add(':DOX_QTDC16, ');
    qryCadDox.SQL.Add(':DOX_BASE17, ');
    qryCadDox.SQL.Add(':DOX_QTDC17, ');
    qryCadDox.SQL.Add(':DOX_BASE18, ');
    qryCadDox.SQL.Add(':DOX_QTDC18, ');
    qryCadDox.SQL.Add(':DOX_BASE19, ');
    qryCadDox.SQL.Add(':DOX_QTDC19, ');
    qryCadDox.SQL.Add(':DOX_BASE20, ');
    qryCadDox.SQL.Add(':DOX_QTDC20) ');

    pGerarStandoxTipoUmEuropa(qryCadDox, stlFormulas, intTipoUm);
    pGerarStandoxTipoDoisEuropa(qryCadDox, stlFormulas, intTipoUm);

    qryCadDox.Close;

  Finally
    FreeAndNil(stlFormulas);
    FreeAndNil(qryCadDox);
    FreeAndNil(cdsMD5);
  End;

end;


procedure pGerarStandoxTipoUmEuropa(qryCadDox: TUniQuery; stlFormulas: TStringList; Var intTipoUm: Integer);
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  qryAux: TUniQuery;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;

  IntCodSeq : Integer;
begin
  intLinha := 0;

  Try
    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT MAX(DOX_CODSEQ) CODSEQ '+
                          '  FROM DOX_CADDOX '+
                          ' WHERE DOX_CODEMP = :CODEMP';
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    IntCodSeq :=  qryAux.FieldByName('CODSEQ').AsInteger;

  Finally
    FreeAndNil(qryAux);
  End;


  While (intLinha < stlFormulas.Count) Do
  Begin

    If qryCadDox.IsEmpty Then
    Begin
      strLinha     := stlFormulas[intLinha];
      strMontad    := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
      strCodigo    := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));
      strDescri    := Trim(fRetCampoBas('DESCRI',intLinha,strLinha));
      strVersao    := Trim(fRetCampoBas('VERSAO',intLinha,strLinha));
      strAnoIni    := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));
      strAnoFin    := Trim(fRetCampoBas('ANOFIN',intLinha,strLinha));
      strPainel    := Trim(fRetCampoBas('PAINEL',intLinha,strLinha));
      strCatego    := Trim(fRetCampoBas('CATEGO',intLinha,strLinha));
      strPais      := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
      strVarian    := Trim(fRetCampoBas('VARIAN',intLinha,strLinha));
      strQualidade := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
      strInfCor    := Trim(fRetCampoBas('INFCOR',intLinha,strLinha));

      If (Pos('0',strMontad) <= 0) And (Not fEmptyStr(strMontad)) Then
      Begin
        Inc(IntCodSeq);

        qryCadDox.Close;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := fStrZero(IntCodSeq+1, 6);
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := strQualidade;
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_CODEMP').AsString := VS_strCodEmp;
        qryCadDox.ParamByName('AUTOINCREM').AsString := fFormataAutInc(IntCodSeq+1, VS_strCodEmp);

        For intContador := 0 To 19 Do
        Begin
          qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString := fRetCampoBas('CODBAS',intContador+1,strLinha);
          qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS',intContador+1,strLinha),'.',','));
        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := fGetMd5MySql(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                                     qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                                     qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                                     qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
                                            qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If Not cdsMD5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
        Begin
          qryCadDox.ExecSQL;

          cdsMD5.Append;
          cdsMD5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
          cdsMD5.Post;
        End;
      End;

    End;

    Inc(intLinha);

    Application.ProcessMessages;
  End;

  intTipoUm := intLinha;
End;

procedure pGerarStandoxTipoDoisEuropa(qryCadDox: TUniQuery; stlFormulas: TStringList; intTipoUm: Integer);
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;
  intBase: Integer;
  blnStandBlue: Boolean;
  strBase: String;

  IntCodSeq : Integer;
  qryAux: TUniQuery;
begin
  blnStandBlue := False;
  strBase  := '';
  intLinha := 0;

  Try
    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT MAX(DOX_CODSEQ) CODSEQ '+
                          '  FROM DOX_CADDOX '+
                          ' WHERE DOX_CODEMP = :CODEMP';
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    IntCodSeq :=  qryAux.FieldByName('CODSEQ').AsInteger;

  Finally
    FreeAndNil(qryAux);
  End;


  While (intLinha < stlFormulas.Count) Do
  Begin

    strLinha     := stlFormulas[intLinha];
    strMontad    := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
    strCodigo    := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));
    strDescri    := Trim(fRetCampoBas('DESCRI',intLinha,strLinha));
    strVersao    := Trim(fRetCampoBas('VERSAO',intLinha,strLinha));
    strAnoIni    := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));
    strAnoFin    := Trim(fRetCampoBas('ANOFIN',intLinha,strLinha));
    strPainel    := Trim(fRetCampoBas('PAINEL',intLinha,strLinha));
    strCatego    := Trim(fRetCampoBas('CATEGO',intLinha,strLinha));
    strPais      := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
    strVarian    := Trim(fRetCampoBas('VARIAN',intLinha,strLinha));
    strQualidade := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
    strInfCor    := Trim(fRetCampoBas('INFCOR',intLinha,strLinha));

    If (strQualidade <> 'STANDOBLUE BASECOAT') Then
    Begin
      If (Pos('0',strMontad) <= 0) And (Not fEmptyStr(strMontad)) Then
      Begin
        Inc(IntCodSeq);

        qryCadDox.Close;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := fStrZero(IntCodSeq + 1, 6);
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := 'STANDOBLUE BASECOAT';
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_CODEMP').AsString := VS_strCodEmp;
        qryCadDox.ParamByName('AUTOINCREM').AsString := fFormataAutInc(IntCodSeq + 1, VS_strCodEmp);

        intBase := 0;
        For intContador := 0 To 19 Do
        Begin

          qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString := '';
          qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := 0.0;

          strBase := fRetCampoBas('CODBAS',intContador+1,strLinha);

          If Pos('STBLUE',strBase) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + fStrZero(intBase+1, 2)).AsString := fRetCampoBas('CODBAS',intContador+1,strLinha);
            qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intBase+1, 2)).AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS',intContador+1,strLinha),'.',','));

            Inc(intBase);
            blnStandBlue:= True;
          End;

        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := fGetMd5MySql(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                                     qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                                     qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                                     qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
                                            qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If blnStandBlue Then
        Begin
          If Not cdsMD5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
          Begin
            qryCadDox.ExecSQL;

            cdsMD5.Append;
            cdsMD5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
            cdsMD5.Post;
          End;

          blnStandBlue := False;
        End;
      End;
    End;

    Inc(intLinha);
//    Inc(intTipoUm);

    Application.ProcessMessages;
  End;

End;



procedure pDeletaNovaFormula(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  DOX_CADDOX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DOX_CODNFM = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;
    ExecSQL;
    Close;
  End;
end;

{ TStandoxAutomotiva }

function TStandoxAutomotiva.fGravaNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM DOX_CADNFM ';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    fGeraNovasFormulas(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizadas com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TStandoxAutomotiva.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaNovasFormulas();
end;

function fRetProCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(DOX_CODSEQ),0) + 1 PROX FROM DOX_CADDOX;';
    qryGen.Open;

    Result := qryGen.FieldByName('PROX').AsInteger;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fGetMd5MySQl(strTexto: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Text := 'SELECT UPPER(CAST(MD5("' + strTexto + '") AS CHAR)) SAIDA';
    qryGen.Open;
    Result := qryGen.FieldByName('SAIDA').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetCampoBas(strCampo: String; intPos: Integer; strLinha: String): Variant;
function fPosIniBas: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 449;
      2  : Result := 539;
      3  : Result := 629;
      4  : Result := 719;
      5  : Result := 809;
      6  : Result := 899;
      7  : Result := 989;
      8  : Result := 1079;
      9  : Result := 1169;
      10 : Result := 1259;
      11 : Result := 1349;
      12 : Result := 1439;
      13 : Result := 1529;
      14 : Result := 1619;
      15 : Result := 1709;
      16 : Result := 1799;
      17 : Result := 1889;
      18 : Result := 1979;
      19 : Result := 2069;
      20 : Result := 2159;
    End;
  End;

  function fPosDesIni: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 459;
      2  : Result := 549;
      3  : Result := 639;
      4  : Result := 729;
      5  : Result := 819;
      6  : Result := 909;
      7  : Result := 999;
      8  : Result := 1089;
      9  : Result := 1179;
      10 : Result := 1269;
      11 : Result := 1359;
      12 : Result := 1449;
      13 : Result := 1539;
      14 : Result := 1629;
      15 : Result := 1719;
      16 : Result := 1809;
      17 : Result := 1899;
      18 : Result := 1989;
      19 : Result := 2079;
      20 : Result := 2169;
    End;
  End;

  function fPosLinIni: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 524;
      2  : Result := 614;
      3  : Result := 704;
      4  : Result := 794;
      5  : Result := 884;
      6  : Result := 974;
      7  : Result := 1064;
      8  : Result := 1154;
      9  : Result := 1244;
      10 : Result := 1334;
      11 : Result := 1424;
      12 : Result := 1514;
      13 : Result := 1604;
      14 : Result := 1694;
      15 : Result := 1784;
      16 : Result := 1874;
      17 : Result := 1964;
      18 : Result := 2054;
      19 : Result := 2144;
      20 : Result := 2234;
    End;
  End;

  function fPosPesIni: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 499;
      2  : Result := 589;
      3  : Result := 679;
      4  : Result := 769;
      5  : Result := 859;
      6  : Result := 949;
      7  : Result := 1039;
      8  : Result := 1129;
      9  : Result := 1219;
      10 : Result := 1309;
      11 : Result := 1399;
      12 : Result := 1489;
      13 : Result := 1579;
      14 : Result := 1669;
      15 : Result := 1759;
      16 : Result := 1849;
      17 : Result := 1939;
      18 : Result := 2029;
      19 : Result := 2119;
      20 : Result := 2209;
    End;
  End;

  function fPosTipIni: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 459;
      2  : Result := 549;
      3  : Result := 639;
      4  : Result := 729;
      5  : Result := 819;
      6  : Result := 909;
      7  : Result := 999;
      8  : Result := 1089;
      9  : Result := 1179;
      10 : Result := 1269;
      11 : Result := 1359;
      12 : Result := 1449;
      13 : Result := 1539;
      14 : Result := 1629;
      15 : Result := 1719;
      16 : Result := 1809;
      17 : Result := 1899;
      18 : Result := 1989;
      19 : Result := 2079;
      20 : Result := 2169;
    End;
  End;

  function fPosEmbIni: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 489;
      2  : Result := 579;
      3  : Result := 669;
      4  : Result := 759;
      5  : Result := 849;
      6  : Result := 939;
      7  : Result := 1029;
      8  : Result := 1119;
      9  : Result := 1209;
      10 : Result := 1299;
      11 : Result := 1389;
      12 : Result := 1479;
      13 : Result := 1569;
      14 : Result := 1659;
      15 : Result := 1749;
      16 : Result := 1839;
      17 : Result := 1929;
      18 : Result := 2019;
      19 : Result := 2109;
      20 : Result := 2199;
    End;
  End;

  function fPosQtdBas: Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 479;
      2  : Result := 569;
      3  : Result := 659;
      4  : Result := 749;
      5  : Result := 839;
      6  : Result := 929;
      7  : Result := 1019;
      8  : Result := 1109;
      9  : Result := 1199;
      10 : Result := 1289;
      11 : Result := 1379;
      12 : Result := 1469;
      13 : Result := 1559;
      14 : Result := 1649;
      15 : Result := 1739;
      16 : Result := 1829;
      17 : Result := 1919;
      18 : Result := 2009;
      19 : Result := 2099;
      20 : Result := 2189;
    End;
  End;

begin
  //Informacoes Bases
  If strCampo = 'CODBAS' Then
    Result := Trim(Copy(strLinha,fPosIniBas,10))
  Else If strCampo = 'TIPO__' Then
    Result := Trim(Copy(strLinha,fPosTipIni,15))
  Else If strCampo = 'LINHA_' Then
    Result := Trim(Copy(strLinha,fPosLinIni,15))
  Else If strCampo = 'PESESP' Then
    Result := Trim(Copy(strLinha,fPosPesIni,10))
  Else If strCampo = 'DESBAS' Then
    Result := Trim(Copy(strLinha,fPosDesIni,20))
  Else If strCampo = 'EMBALA' Then
    Result := Trim(Copy(strLinha,fPosEmbIni,10))
  Else If strCampo = 'QTDBAS' Then
    Result := Trim(Copy(strLinha,fPosQtdBas,10))

  //Informacoes Cor
  Else If strCampo = 'MONTAD' Then
    Result := Trim(Copy(strLinha,1,50))
  Else If strCampo = 'CODIGO' Then
    Result := Trim(Copy(strLinha,51,10))
  Else If strCampo = 'DESCRI' Then
    Result := Trim(Copy(strLinha,111,100))
  Else If strCampo = 'VERSAO' Then
    Result := Trim(Copy(strLinha,211,10))
  Else If strCampo = 'ANOINI' Then
    Result := Trim(Copy(strLinha,221,4))
  Else If strCampo = 'ANOFIN' Then
    Result := Trim(Copy(strLinha,225,4))
  Else If strCampo = 'PAINEL' Then
    Result := Trim(Copy(strLinha,229,10))
  Else If strCampo = 'CATEGO' Then
    Result := Trim(Copy(strLinha,259,20))
  Else If strCampo = 'PAIS' Then
    Result := Trim(Copy(strLinha,279,30))
  Else If strCampo = 'VARIAN' Then
    Result := Trim(Copy(strLinha,309,10))
  Else If strCampo = 'QUALID' Then
    Result := Trim(Copy(strLinha,319,100))
  Else If strCampo = 'INFCOR' Then
    Result := Trim(Copy(strLinha,419,30));
end;

function fRetEmbalagem(strEmbalagem: String): Double;
begin
  Result := 0;
  If strEmbalagem = '1 LITRE' Then
    Result := 1000;
end;

procedure pGerarStandoxTipoUm(qryCadDox: TUniQuery; stlFormulas: TStringList; Var intTipoUm: Integer);
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;
begin
  intLinha := 0;
  While (intLinha < stlFormulas.Count) Do
  Begin

    strLinha     := stlFormulas[intLinha];
    strMontad    := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
    strCodigo    := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));
    strDescri    := Trim(fRetCampoBas('DESCRI',intLinha,strLinha));
    strVersao    := Trim(fRetCampoBas('VERSAO',intLinha,strLinha));
    strAnoIni    := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));
    strAnoFin    := Trim(fRetCampoBas('ANOFIN',intLinha,strLinha));
    strPainel    := Trim(fRetCampoBas('PAINEL',intLinha,strLinha));
    strCatego    := Trim(fRetCampoBas('CATEGO',intLinha,strLinha));
    strPais      := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
    strVarian    := Trim(fRetCampoBas('VARIAN',intLinha,strLinha));
    strQualidade := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
    strInfCor    := Trim(fRetCampoBas('INFCOR',intLinha,strLinha));

    If (Pos('0',strMontad) <= 0) And (Not fEmptyStr(strMontad)) And ((strPais = 'BRASIL') Or (strPais = 'BRAZIL')) Then
    Begin
      qryCadDox.Close;
      qryCadDox.ParamByName('DOX_CODSEQ').AsString := fStrZero(intLinha+1, 6);
      qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
      qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
      qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
      qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
      qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
      qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
      qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
      qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
      qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
      qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
      qryCadDox.ParamByName('DOX_QUALID').AsString := strQualidade;
      qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
      qryCadDox.ParamByName('DOX_CODEMP').AsString := VS_strCodEmp;
      qryCadDox.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intLinha+1, VS_strCodEmp);

      For intContador := 0 To 19 Do
      Begin
        qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString := fRetCampoBas('CODBAS',intContador+1,strLinha);
        qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS',intContador+1,strLinha),'.',','));

        If (strQualidade <> 'STANDOBLUE BASECOAT') Then
        Begin
          If Pos('STBLUE',qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString := '';
            qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := 0.0;
          End;
        End;
      End;

      qryCadDox.ParamByName('DOX_MD5KEY').AsString := fGetMd5MySql(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                                   qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                                   qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                                   qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                                   qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                                   qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
                                          qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
                                          qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

      If Not cdsMD5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
      Begin
        qryCadDox.ExecSQL;

        cdsMD5.Append;
        cdsMD5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
        cdsMD5.Post;
      End;
    End;

    Inc(intLinha);

    Application.ProcessMessages;
  End;

  intTipoUm := intLinha;
end;

procedure pGerarStandoxTipoDois(qryCadDox: TUniQuery; stlFormulas: TStringList; intTipoUm: Integer);
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;
  intBase: Integer;
  blnStandBlue: Boolean;
  strBase: String;
begin
  blnStandBlue := False;
  strBase  := '';
  intLinha := 0;
  While (intLinha < stlFormulas.Count) Do
  Begin

    strLinha     := stlFormulas[intLinha];
    strMontad    := Trim(fRetCampoBas('MONTAD',intLinha,strLinha));
    strCodigo    := Trim(fRetCampoBas('CODIGO',intLinha,strLinha));
    strDescri    := Trim(fRetCampoBas('DESCRI',intLinha,strLinha));
    strVersao    := Trim(fRetCampoBas('VERSAO',intLinha,strLinha));
    strAnoIni    := Trim(fRetCampoBas('ANOINI',intLinha,strLinha));
    strAnoFin    := Trim(fRetCampoBas('ANOFIN',intLinha,strLinha));
    strPainel    := Trim(fRetCampoBas('PAINEL',intLinha,strLinha));
    strCatego    := Trim(fRetCampoBas('CATEGO',intLinha,strLinha));
    strPais      := Trim(fRetCampoBas('PAIS',intLinha,strLinha));
    strVarian    := Trim(fRetCampoBas('VARIAN',intLinha,strLinha));
    strQualidade := Trim(fRetCampoBas('QUALID',intLinha,strLinha));
    strInfCor    := Trim(fRetCampoBas('INFCOR',intLinha,strLinha));

    If (strQualidade <> 'STANDOBLUE BASECOAT') Then
    Begin
      If (Pos('0',strMontad) <= 0) And (Not fEmptyStr(strMontad)) And ((strPais = 'BRASIL') Or (strPais = 'BRAZIL')) Then
      Begin
        qryCadDox.Close;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := fStrZero(intTipoUm+1, 6);
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := 'STANDOBLUE BASECOAT';
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_CODEMP').AsString := VS_strCodEmp;
        qryCadDox.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intTipoUm+1, VS_strCodEmp);

        intBase := 0;
        For intContador := 0 To 19 Do
        Begin

          qryCadDox.ParamByName('DOX_BASE' + fStrZero(intContador+1, 2)).AsString := '';
          qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := 0.0;

          strBase := fRetCampoBas('CODBAS',intContador+1,strLinha);

          If Pos('STBLUE',strBase) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + fStrZero(intBase+1, 2)).AsString := fRetCampoBas('CODBAS',intContador+1,strLinha);
            qryCadDox.ParamByName('DOX_QTDC' + fStrZero(intBase+1, 2)).AsFloat  := fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS',intContador+1,strLinha),'.',','));

            Inc(intBase);
            blnStandBlue:= True;
          End;

        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := fGetMd5MySql(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                                     qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                                     qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                                     qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                                     qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
                                            qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
                                            qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If blnStandBlue Then
        Begin
          If Not cdsMD5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
          Begin
            qryCadDox.ExecSQL;

            cdsMD5.Append;
            cdsMD5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
            cdsMD5.Post;
          End;

          blnStandBlue := False;
        End;
      End;
    End;

    Inc(intLinha);
    Inc(intTipoUm);

    Application.ProcessMessages;
  End;

end;

procedure pAdicionaDiluentes;
var
  intContador: Integer;
  qryDil: TUniQuery;
  qryBas: TUniQuery;
begin
  Try
    pZapTable('DOX_CADDIL');

    qryBas := fCriaQuery;

    For intContador := 0 To Length(arrCodDil) - 1 Do
    Begin
      qryBas.Close;
      qryBas.SQL.Clear;
      qryBas.SQL.Add('SELECT * '+
                     '  FROM DOX_CADBAS '+
                     ' WHERE BAS_CODBAS =:CODBAS');
      qryBas.ParamByName('CODBAS').AsString := String(arrCodDil[intContador]);
      qryBas.Open;

      If Not qryBas.IsEmpty Then
        Continue;

      qryBas.Append;
      qryBas.FieldByName('BAS_CODBAS').AsString := String(arrCodDil[intContador]);
      qryBas.FieldByName('BAS_DESBAS').AsString := UpperCase(String(arrDescri[intContador]));
      qryBas.FieldByName('BAS_PESESP').AsFloat  := arrPesEsp[intContador];

      If intContador <= 2 Then
        qryBas.FieldByName('BAS_EMBALA').AsFloat  := 1000
      else
        qryBas.FieldByName('BAS_EMBALA').AsFloat  := 3500;

      qryBas.FieldByName('BAS_PESGRA').AsString := 'N';
      qryBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DOX_CADBAS', VS_strCodEmp);
      qryBas.Post;
    End;

    qryDil := fCriaQuery;
    With qryDil Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM DOX_CADDIL WHERE FALSE');
      Open;

      For intContador := 0 To Length(arrCodDil) - 1 Do
      Begin
        Append;
        FieldByName('DIL_CODDIL').AsString := String(arrCodDil[intContador]);
        FieldByName('DIL_DESCRI').AsString := String(arrDescri[intContador]);
        FieldByName('DIL_PESESP').AsFloat  := arrPesEsp[intContador];
        FieldByName('DIL_CODIGO').AsString := String(arrCodigo[intContador]);
        FieldByName('DIL_CODEMP').AsString := VS_strCodEmp;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DOX_CADDIL', VS_strCodEmp);
        Post;
      End;
    End;

  Finally
    FreeAndNil(qryBas);
    FreeAndNil(qryDil);
  End;
end;

end.

