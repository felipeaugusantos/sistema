unit TConverte;

interface

uses
  SysUtils, StrUtils, ComCtrls, Forms, Uni, MySQLUniProvider,
  Dialogs, Windows, Classes, AnsiStrings, UniClientDataSet,
  UniDataSetProvider, Variants, cxProgressBar;

type
  TRecursosAdicionais = class
    CadRelArquivo : String;
    CadTemGrupo : String;
    CallFinal : String;
  end;

type
  TarrRecursosAdicionais = Array of TRecursosAdicionais;

  TfGetCodigoRelatorio = Function :String Of Object;
  TfGetAutoIncrem = Function(strNomTab: String) :String Of Object;

Type
  TConvert = class(TComponent)
  private
    // Private declarations

    Function fCarregaDados: Boolean;

    Procedure pAddChilds(strCodRel: String; stlChilds: TStringList);

  public
    strRelArquiv, strCaminhoArquiv, strRelPad, strCodcli : String;

    strCodRelExterno,
    strCodRelPai: String;

    fGetCodigoRelatorio: TfGetCodigoRelatorio;
    fGetAutoIncrem: TfGetAutoIncrem;

    blnRelPadrao: Boolean;

    stlScript,
    stlScriptSubRel: TStringList;
    stlScriptChiRel: TStringList;
    stlScriptHisRel: TStringList;
    stlScriptDirRel: TStringList;
    stlScriptAtaRel: TStringList;
    stlScriptCadDir: TStringList;

    strSeqGer: String;

    intContTem: Integer;
    intContMod: Integer;

    stlLista,
    stlListaValida,
    //stlListaSub: TStringList;
    stlListaCadTem: TStringList;
    stlListaCadMod: TStringList;

    stlListaCadRel,
    stlListaCodRel,
    stlListaCodPai,
    stlListaCodVal: TStringList;

    Database: TUniConnection;

    qryGenCom: TUniQuery;
    qryGen: TUniQuery;
    qryCon: TUniQuery;

    qryGeral:  TUniQuery;
    qryGeralFilha:  TUniQuery;
    qryComple: TUniQuery;
    qryCadDir: TUniQuery;
    qryColuna: TUniQuery;

    cdsCadRel : TUniClientDataSet;
    dspProvid: TUniDataSetProvider;
    qryCadRel: TUniQuery;

    cdsCadTem: TUniClientDataSet;
    dspProTem: TUniDataSetProvider;
    qryCadTem: TUniQuery;

    cdsCadMod: TUniClientDataSet;
    dspProMod: TUniDataSetProvider;
    qryCadMod: TUniQuery;

    cdsCadPai: TUniClientDataSet;
    dspProPai: TUniDataSetProvider;
    qryCadPai: TUniQuery;

    FPath: String;
    FHost: String;
    FBanc: String;
    FUser: String;
    FPass: String;

    FNumPor: Integer;

    strChave,
    strChaveBKP: String;

    relsver72 : TStrings;
    relsver74 : TStrings;
    stlArray : array of string;

    arrTemplateFixo : TarrRecursosAdicionais;

    procedure setBanc(const Value: String);
    procedure setHost(const Value: String);
    procedure setPath(const Value: String);
    procedure setUser(const Value: String);
    procedure setNumPor(const Value: Integer);

    property strPatDbf: String Read FPath Write setPath;
    property strNum_Ip: String Read FHost Write setHost;
    property strNomBan: String Read FBanc Write setBanc;
    property intNumPor: Integer Read FNumPor Write setNumPor;
    property strUsuari: String Read FUser Write setUser;
    property strPassWd: String Read FPass Write FPass;

    //function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;

    Function fRetAutoincrem(Var intContador: Integer): String;
    Function fRetColunasSQL(tabela, codigo: String; autoincrem : Boolean): String;

    Function fRetExisteGatInf(strCodRel: String): Boolean;

    Procedure pInsereCadVal;
    Procedure pInsereCadRel(blnbkp, blnSalvaCADVAL: Boolean);
    Procedure pInsereCadMod;
    Procedure pInsereCadCam;
    Procedure pInsereGruPar;
    Procedure pInsereCadPar(var intContRegDir: Integer; var strChavesCodDir: string);
    Procedure pInsereDirRel(var intContRegDir: Integer; var strChavesCodDir: string);
    Procedure fInsereCadDir(var intContRegDir: Integer; var strChavesCodDir: string; strCodDir: string);
    Procedure pInsereSubRel(blnbkp: Boolean);
    Procedure pInsereChiRel(blnbkp: Boolean);
    Procedure pInsereHisRel;
    Procedure pInsereDireitos;
    Procedure pInsereCadTem;
    Procedure pInsereAtaRel();
    Procedure pInsereCallProcedure();

    Procedure pInsereTabela(strNomTab, strCamSeqGer: String);

    Procedure pCriaCadPai;

    Procedure pRegistraPai(strCodOld, strCodNew: String);

    Function fRetCodPai(strCodOld: String): String;

    Function fGetListaRelatorio(strCodRel: String): String;
    Function fGetCodChilds(strCodRels: String): String;

    Function fGeraScriptCopiaRelatorio(strCodRel: String;
                                       Var strNovRel: String): String;

    Function fCriaQuery: TUniQuery;

    Function fConverte(pgbStatus: TProgressBar; stbLog: TStatusBar; blnLibUtil : Boolean ): Boolean;

    function fUsarSenhaDLL: Boolean;
    Function fAbreConsulta: Boolean;
    Function fAbreTemplate: Boolean;
    Function fAbreModelos: Boolean;
    Function fInLista(strCodRel: String): Boolean;
    Function fInListaCadTem(strCodTem: String): Boolean;
    Function fInListaCadMod(strCodMod: String): Boolean;
    Function fTemCadDir(var strChaves: string): Boolean;

    Function fGeraScript(var strChavesCodDir: string; blnCabecalho, blnTemplates, blnSalvaCADVAL: Boolean; var blnInicioScript: Boolean; strCodRel: string = ''; blnExportacao: Boolean = False): Boolean;
    procedure pAlimentaFimScript(blnTemplates, blnSalvaCADVAL, blnExisteGatInf: Boolean);
    Procedure pGeraCabecalho;
    Procedure pGeraTemplates;
    Procedure pGeraModelos;
    Procedure pGeraUpdateCodPai;
    Procedure pGeraUpdateCodVal;

    Function fGetAutoincremSub(strAutInc: String): String;
    Function fGetCodigoSub(strCodigo: String): String;

    constructor Create(AOwner: TComponent; ADatabase: TUniConnection = Nil); Reintroduce;

    Destructor Destroy; override;

    procedure pAddLista;
    procedure pAddListaTemplate;
    procedure pAddListaModelos;

    procedure pAddMarcaDesmarcaTodosLista(blnMarca: Boolean);
    procedure pAddMarcaDesmarcaTodosListaTemplate(blnMarca: Boolean);
    procedure pAddMarcaDesmarcaTodosListaModelo(blnMarca: Boolean);

    function fCampoExiste(const strTabela, strCampo: String): Boolean;

    Procedure pNutrindoRelatoriosVersoesDif;
    Procedure pTemRelOutraVersao;

    Procedure pProcessaArrayCod;

    Procedure pAdicionaTemplateFixo;

    Function fRetornaSalvaCadVal: Boolean;
  end;

implementation

uses DB;

{ TConvert }

constructor TConvert.Create(AOwner: TComponent; ADatabase: TUniConnection = Nil);
begin

  Try
    strChave    := '';
    strChaveBKP := '';

    fGetCodigoRelatorio := Nil;
    fGetAutoIncrem := Nil;

    strCodRelExterno := '';
    strCodRelPai := '';

    stlLista        := TStringList.Create;
    stlLista.Sorted := True;

    stlListaCadTem        := TStringList.Create;
    stlListaCadTem.Sorted := True;

    stlListaCadMod        := TStringList.Create;
    stlListaCadMod.Sorted := True;

    stlScript       := TStringList.Create;
    stlScriptSubRel := TStringList.Create;
    stlScriptChiRel := TStringList.Create;
    stlScriptHisRel := TStringList.Create;
    stlScriptAtaRel := TStringList.Create;
    stlScriptCadDir := TStringList.Create;
    stlScriptDirRel := TStringList.Create;
    stlListaCodPai := TStringList.Create;
    stlListaCodVal := TStringList.Create;
    stlListaCadRel := TStringList.Create;
    stlListaCodRel := TStringList.Create;

    EnableUniSQL := False;

    If Assigned(ADatabase) Then
    Begin
      Database := ADatabase;
    End Else
    Begin
      Database := TUniConnection.Create(Self);
      Database.ConnectString := 'Provider Name=MySQL;Password=citel13347;Port=3306;Login Prompt=False';
      Database.ProviderName := 'MySQL';
    End;

    qryGen := TUniQuery.Create(Self);
    qryGen.Connection  := Database;

    qryGenCom := TUniQuery.Create(Self);
    qryGenCom.Connection  := Database;

    qryCon := TUniQuery.Create(Self);
    qryCon.Connection  := Database;

    // RELATRIO
    qryCadRel := TUniQuery.Create(Self);
    qryCadRel.Connection  := Database;

    cdsCadRel := TUniClientDataSet.Create(Self);
    dspProvid := TUniDataSetProvider.Create(Self);

    dspProvid.ResolveToDataSet := True;
    dspProvid.DataSet := qryCadRel;
    cdsCadRel.SetProvider(dspProvid);
    //---------------------------------

    // TEMPLATE
    qryCadTem := TUniQuery.Create(Nil);
    qryCadTem.Connection  := Database;

    cdsCadTem := TUniClientDataSet.Create(Nil);
    dspProTem := TUniDataSetProvider.Create(Nil);

    dspProTem.ResolveToDataSet := True;
    dspProTem.DataSet := qryCadTem;
    cdsCadTem.SetProvider(dspProTem);

    //---------------------------------

    // MODELOS

    qryCadMod := TUniQuery.Create(Self);
    qryCadMod.Connection  := Database;

    cdsCadMod := TUniClientDataSet.Create(Self);
    dspProMod := TUniDataSetProvider.Create(Self);

    dspProMod.ResolveToDataSet := True;
    dspProMod.DataSet := qryCadMod;
    cdsCadMod.SetProvider(dspProTem);

    //---------------------------------

    // CADPAI
    qryCadPai := TUniQuery.Create(Self);
    qryCadPai.Connection  := Database;

    cdsCadPai := TUniClientDataSet.Create(Self);
    dspProPai := TUniDataSetProvider.Create(Self);

    dspProPai.ResolveToDataSet := True;
    dspProPai.DataSet := qryCadPai;
    cdsCadPai.SetProvider(dspProPai);
    cdsCadPai.IndexFieldNames := 'CODOLD';
    //---------------------------------


    qryGeral := TUniQuery.Create(Self);
    qryGeral.Connection  := Database;

    qryGeralFilha := TUniQuery.Create(Self);
    qryGeralFilha.Connection  := Database;

    qryComple := TUniQuery.Create(Self);
    qryComple.Connection  := Database;

    qryCadDir := TUniQuery.Create(Self);
    qryCadDir.Connection  := Database;

    qryColuna := TUniQuery.Create(Self);
    qryColuna.Connection  := Database;

    //---------------------------------

    pNutrindoRelatoriosVersoesDif;

    SetLength(arrTemplateFixo, 0);
    SetLength(arrTemplateFixo, Length(arrTemplateFixo) + 1);
    arrTemplateFixo[Length(arrTemplateFixo) - 1] := TRecursosAdicionais.Create;
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadRelArquivo := '14203_14213_GERACAO_SPED_FISCAL.SQL';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadTemGrupo := 'SPED_FISCAL@SPED FISCAL VALIDAÇÃO';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CallFinal := 'CALL pGeraRelmenSped();';

    SetLength(arrTemplateFixo, Length(arrTemplateFixo) + 1);
    arrTemplateFixo[Length(arrTemplateFixo) - 1] := TRecursosAdicionais.Create;
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadRelArquivo :=  '12150_12170_GERACAO_DE_SPED_DE_PIS_COFINS.SQL';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadTemGrupo := 'SPED CONTRIBUIÇÃO VALIDAÇÃO';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CallFinal := '';

    SetLength(arrTemplateFixo, Length(arrTemplateFixo) + 1);
    arrTemplateFixo[Length(arrTemplateFixo) - 1] := TRecursosAdicionais.Create;
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadRelArquivo := '23350_23361_GERACAO_SPED_FISCAL.SQL';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadTemGrupo := 'SPED_FISCAL@SPED FISCAL VALIDAÇÃO';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CallFinal := 'CALL pGeraRelmenSped();';

    SetLength(arrTemplateFixo, Length(arrTemplateFixo) + 1);
    arrTemplateFixo[Length(arrTemplateFixo) - 1] := TRecursosAdicionais.Create;
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadRelArquivo := '15692_15708_ANALISE_DE_RESULTADOS_CONTAS_A_PAGAR_DRE.SQL';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CadTemGrupo := '';
    arrTemplateFixo[Length(arrTemplateFixo) - 1].CallFinal := 'CALL pAtualizaColunasDRE();';

  Except

    On E: Exception Do
      Raise Exception.Create('Erro: ' + E.Message);

  End;

end;

Destructor TConvert.Destroy;
Begin
  FreeAndNil(stlLista);
  FreeAndNil(stlListaCadTem);
  FreeAndNil(stlListaCadMod);

  FreeAndNil(stlScript);
  FreeAndNil(stlScriptSubRel);
  FreeAndNil(stlScriptChiRel);
  FreeAndNil(stlScriptHisRel);
  FreeAndNil(stlScriptAtaRel);
  FreeAndNil(stlScriptCadDir);
  FreeAndNil(stlScriptDirRel);
  FreeAndNil(stlListaCodPai);
  FreeAndNil(stlListaCadRel);
  FreeAndNil(stlListaCodRel);
  FreeAndNil(stlListaCodVal);

  FreeAndNil(relsver72);
  FreeAndNil(relsver74);

  SetLength(arrTemplateFixo, 0);
End;

Procedure TConvert.pCriaCadPai;
Begin
  qryCadPai.SQL.Text := 'SELECT REL_CODREL AS CODOLD, REL_CODREL AS CODNEW FROM CADREL WHERE FALSE';
  cdsCadPai.Open;
End;

Procedure TConvert.pRegistraPai(strCodOld, strCodNew: String);
Begin
  cdsCadPai.Append;
  cdsCadPai.FieldByName('CODOLD').AsString := strCodOld;
  cdsCadPai.FieldByName('CODNEW').AsString := strCodNew;
  cdsCadPai.Post;
End;

Function TConvert.fRetCodPai(strCodOld: String): String;
Begin
  If strCodOld.IsEmpty Then
  Begin
    Result := '(NULL)';

  End Else
  Begin
    Result := QuotedStr(strCodOld);

    If cdsCadPai.FindKey([strCodOld]) Then
      Result := QuotedStr(cdsCadPai.FieldByName('CODNEW').AsString);
  End;

End;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

function fStrToFloat(strValor: String): Double;
Begin

  Result := StrToFloatDef(AnsiReplaceStr(strValor,'.',''), 0);

End;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

function fFormataF(fltNumero: Double): String;
begin
  Result := RightStr('            ' +  FormatFloat('0.000',fltNumero),12);
end;


function fTiraCaracEspeciais(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

Function TConvert.fConverte(pgbStatus: TProgressBar; stbLog: TStatusBar; blnLibUtil : Boolean ): Boolean;
  Var
    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;
begin
  Result := False;

  Try
    Database.Server   := strNum_Ip;
    Database.UserName := strUsuari;
    Database.Password := strPassWd;
    Database.Database := strNomBan;
    Database.Port     := intNumPor;

    Database.Disconnect;

    If blnLibUtil Then
    Begin
      libUtil := LoadLibrary(PChar('libUtil.dll'));

      fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
      fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

      Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
      Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

      FreeLibrary(libUtil);
    End
    Else
    Begin
      Database.UserName := strUsuari;
      Database.Password := strPassWd;
    End;

    Database.Connect;

    Result := fCarregaDados;

  Except

    On E: Exception Do
    Begin
      ShowMessage('Erro: ' + E.Message);
    End;

  End;

end;

Function TConvert.fCarregaDados: Boolean;
Begin
  pCriaCadPai;

  Result := fAbreConsulta And fAbreTemplate And fAbreModelos;
End;

Function TConvert.fGetListaRelatorio(strCodRel: String): String;
  Var
    qryExecuta: TUniQuery;
Begin
  qryExecuta := TUniQuery.Create(Self);
  qryExecuta.Connection := Database;
  qryExecuta.SQL.Text := 'SELECT GROUP_CONCAT(QUOTE(REL_CODREL)) AS CODS FROM ('

+ ' SELECT ' + QuotedStr(strCodRel) + ' AS REL_CODREL     '

+ ' UNION                                                 '

+ ' SELECT                                                '
+ '   C.REL_CODVAL                                        '
+ ' FROM                                                  '
+ '   CADREL C                                            '
+ ' WHERE                                                 '
+ '   C.REL_CODREL = :CODREL                              '
+ '   AND IFNULL(C.REL_CODVAL, "") <> ""                  '

+ ' UNION                                                 '

+ ' SELECT                                                '
+ '   C.REL_CODREL                                        '
+ ' FROM                                                  '
+ '   SUBREL S                                            '
+ ' INNER JOIN CADREL C ON C.AUTOINCREM = S.REL_COMPLE    '
+ ' INNER JOIN CADREL M ON M.AUTOINCREM = S.REL_MASTER    '
+ ' WHERE                                                 '
+ '   M.REL_CODREL = :CODREL                              '

+ ' UNION                                                 '

+ ' SELECT                                                '
+ '   C.REL_CODREL                                        '
+ ' FROM                                                  '
+ '   CHIREL S                                            '
+ ' INNER JOIN CADREL C ON C.AUTOINCREM = S.REL_COMPLE    '
+ ' INNER JOIN CADREL M ON M.AUTOINCREM = S.REL_MASTER    '
+ ' WHERE                                                 '
+ '   M.REL_CODREL = :CODREL                              '

+ ' ) AS TAB ';

  qryExecuta.ParamByName('CODREL').AsString := strCodRel;
  qryExecuta.Open;

  Result := qryExecuta.FieldByName('CODS').AsString;

  FreeAndNil(qryExecuta);
End;

Function TConvert.fGetCodChilds(strCodRels: String): String;
  Var
    stlChilds,
    stlRel: TStringList;
    intContador: Integer;
Begin
  stlChilds := TStringList.Create;
  stlChilds.CommaText := strCodRels;

  stlRel := TStringList.Create;
  stlRel.CommaText := strCodRels;

  For intContador := 1 To stlRel.Count - 1 Do
    pAddChilds(stlRel[intContador], stlChilds);

  Result := stlChilds.CommaText;
  FreeAndNil(stlChilds);
End;

Procedure TConvert.pAddChilds(strCodRel: String; stlChilds: TStringList);
  Var
    qryExecuta: TUniQuery;
Begin
  qryExecuta := TUniQuery.Create(Self);
  qryExecuta.Connection := Database;
  qryExecuta.SQL.Text := 'SELECT QUOTE(F.REL_CODREL) AS REL_CODREL FROM CADREL C ' +
                         ' INNER JOIN CHIREL H ON H.REL_MASTER = C.AUTOINCREM ' +
                         ' INNER JOIN CADREL F ON F.AUTOINCREM = H.REL_COMPLE ' +
                         ' WHERE C.REL_CODREL = ' + strCodRel;
  qryExecuta.Open;

  While Not qryExecuta.Eof Do
  Begin
    stlChilds.Add(qryExecuta.FieldByName('REL_CODREL').AsString);
    pAddChilds(qryExecuta.FieldByName('REL_CODREL').AsString, stlChilds);

    qryExecuta.Next;
  End;

  FreeAndNil(qryExecuta);
End;

Function TConvert.fGeraScriptCopiaRelatorio(strCodRel: String;
                                            Var strNovRel: String): String;
  Var
    strChavesCodDir: string;
    blnInicioScript: Boolean;
Begin
  Result := '';

  If Not fCarregaDados Then
    Exit;

  blnInicioScript := True;
  strChavesCodDir := '';

  cdsCadRel.First;
  While Not cdsCadRel.Eof Do
  Begin
    pAddLista;
    cdsCadRel.Next;
  End;

  blnRelPadrao := False;

  If Not fGeraScript(strChavesCodDir,
                     False{blnCabecalho},
                     False{blnTemplates},
                     False{blnSalvaCADVAL},
                     blnInicioScript,
                     ''{strCodRel},
                      False{blnExportacao}) Then
    Exit;

  strNovRel := strCodRelPai;

  Result := stlScript.Text;
End;

Function TConvert.fCriaQuery: TUniQuery;
Begin
  Result := TUniQuery.Create(Self);
  Result.Connection := Database;
End;

Function TConvert.fAbreConsulta: Boolean;
Begin
  With qryCadRel, SQL Do
  Begin
    Close;
    Add('SELECT ');
    Add('  R.AUTOINCREM AS AUTINC, ');
    Add('  REL_CODREL AS CODREL,   ');
    Add('  REL_VERREL AS VERREL,   ');
    Add('  REL_RELREL AS RELREL,   ');
    Add('  REL_CODMOD AS CODMOD,   ');
    Add('  REL_DIRANT AS DIRANT,   ');

    If fCampoExiste('CADREL','REL_CHAANT') Then
      Add('  REL_CHAANT AS CHAANT,   ')
    Else
      Add('  '''' AS CHAANT,   ');

    If fCampoExiste('CADREL','REL_GRVVAL') Then
      Add('  REL_GRVVAL AS GRVVAL,   ')
    Else
      Add('  ''N'' AS GRVVAL,   ');

    Add('  REL_CHAVE_ AS CHAVE_,   ');
    Add('  REL_DESCRI AS DESCRI,   ');
    Add('  REL_DESCMP AS DESCMP,   ');
    Add('  REL_TIPIMP AS TIPIMP,   ');
    Add('  MEN_NOMMEN AS NOMMEN,   ');
    Add('  MEN_CAPMEN AS CAPMEN,   ');
    Add('  REL_ARQUIV AS ARQUIV,   ');
    Add('  REL_EXPAUT AS EXPAUT,   ');
    Add('  REL_CODVAL AS CODVAL,   ');
    Add('  REL_GATINF AS GATINF    ');

    If fCampoExiste('RELMEN','MEN_NOMME2') Then
      Add(' , MEN_NOMME2 AS NOMME2   ');

    Add('  FROM CADREL R ');

    Add('  LEFT JOIN RELMEN ON REL_CODREL = MEN_CODREL');

    Add('  WHERE TRUE');

    If strCodRelExterno.IsEmpty Then
      Add(' AND REL_CHAVE_ IS NOT NULL AND REL_MD5NEW IS NOT NULL');

    if Trim(strRelArquiv) <> '' then
    begin
      Add(' AND R.REL_ARQUIV = :ARQUIV ');
    end;

    If Not strCodRelExterno.IsEmpty Then
      Add(' AND R.REL_CODREL IN (' + strCodRelExterno + ')');

    Add('  ORDER BY CHAVE_ DESC');

    if Trim(strRelArquiv) <> '' then
    begin
      ParamByName('ARQUIV').AsString := strRelArquiv;
    end;

    ReadOnly := False;

    cdsCadRel.SetProvider(dspProvid);

    cdsCadRel.Close;
    cdsCadRel.Open;
    cdsCadRel.FieldByName('CODREL').Alignment := taCenter;
    cdsCadRel.FieldByName('TIPIMP').Alignment := taCenter;
    cdsCadRel.FieldByName('EXPAUT').Alignment := taCenter;
    cdsCadRel.FieldByName('CODVAL').Visible := False;
    cdsCadRel.ReadOnly := False;

    Result := True;
  End;
End;

Function TConvert.fAbreTemplate: Boolean;
Begin
  With qryCadTem, SQL Do
  Begin
    Close;
    Add('SELECT ');
    Add('  * ');

    Add('  FROM CADTEM ');

    Add('  WHERE  TEM_CHAVE_ IS NOT NULL ');
    Add('     AND TEM_MD5NEW IS NOT NULL');

    Add('  ORDER BY TEM_CHAVE_');

    ReadOnly := False;

    cdsCadTem.SetProvider(dspProTem);

    cdsCadTem.Close;
    cdsCadTem.Open;
    cdsCadTem.FieldByName('TEM_CODIGO').Alignment := taCenter;
    cdsCadTem.ReadOnly := False;

    cdsCadTem.IndexFieldNames := 'TEM_CHAVE_';

    Result := True;
  End;
End;

Function TConvert.fAbreModelos: Boolean;
Begin
  With qryCadMod, SQL Do
  Begin
    Close;
    Add('SELECT ');
    Add('  * ');

    Add('  FROM CADMOD ');

    Add('  WHERE  MOD_CODMOD > 500000 ');

    Add('  ORDER BY MOD_CODMOD');

    ReadOnly := False;

    cdsCadMod.SetProvider(dspProMod);

    cdsCadMod.Close;
    cdsCadMod.Open;
    cdsCadMod.FieldByName('MOD_CODMOD').Alignment := taCenter;
    cdsCadMod.ReadOnly := False;

    cdsCadMod.IndexFieldNames := 'MOD_CODMOD';

    Result := True;
  End;
End;

procedure TConvert.setNumPor(const Value: Integer);
Begin

  If Value <> 0 Then
    FNumPor := Value
  Else
    Raise Exception.Create('A porta deve ser preenchida!');

end;

procedure TConvert.setBanc(const Value: String);
begin

  If Value <> '' Then
    FBanc := Value
  Else
    Raise Exception.Create('O nome do banco deve ser preenchido!');

end;

procedure TConvert.setHost(const Value: String);
begin

  If Value <> '' Then
    FHost := Value
  Else
    Raise Exception.Create('O ip deve ser preenchido!');

end;

procedure TConvert.setPath(const Value: String);
begin

  If Value <> '' Then
    FPath := AnsiReplaceStr(Value,'"','')
  Else
    Raise Exception.Create('O arquivo DBF deve ser preenchido!');

end;

procedure TConvert.setUser(const Value: String);
begin

  If Value <> '' Then
    FUser := Value
  Else
    Raise Exception.Create('O usuario deve ser preenchido!');

end;

function TConvert.fUsarSenhaDLL: Boolean;
begin
  Result := FileExists('libUtil.dll');
end;

procedure TConvert.pAddLista;
  Var
    intIndex: Integer;
    intCont: Integer;
    strTemplateFixo, strFilter: String;
    stlDesgru: TStringList;
    blnInserir : Boolean;
Begin
  With cdsCadRel Do
  Begin
    If IsEmpty Then
      Exit;

    blnInserir := False;

    If stlLista.Find(FieldByName('CODREL').AsString, intIndex) Then
    Begin
      stlLista.Delete(intIndex);

      if (stlLista.Count = 0) then
      Begin
        stlListaCadTem.Clear;
      End;

    End
    Else
    Begin
      stlLista.Add(FieldByName('CODREL').AsString);
      blnInserir := True;
    End;

    strTemplateFixo := '';

    for intCont := 0 to Length(arrTemplateFixo) - 1 do
    begin
      if arrTemplateFixo[intCont].CadRelArquivo = FieldByName('ARQUIV').AsString then
        strTemplateFixo := arrTemplateFixo[intCont].CadTemGrupo;
    end;

    if (strTemplateFixo <> '') and blnInserir then
    Begin
      stlDesgru := TStringList.Create;
      stlDesgru.Text := StringReplace(strTemplateFixo, '@', #13#10, [rfReplaceAll]);

      cdsCadTem.Filtered := False;
      strFilter := ' TEM_DESGRU IN ( ' ;

      for intCont := 0 to stlDesgru.Count - 1 do
      begin
        if intCont = 0 then
          strFilter := strFilter + QuotedStr(stlDesgru[intCont])
        else
          strFilter := strFilter + ', ' + QuotedStr(stlDesgru[intCont]);
      end;

      strFilter := strFilter + ' )';

      cdsCadTem.Filter := strFilter;
      cdsCadTem.Filtered := True;

      cdsCadTem.First;

      While not cdsCadTem.Eof do
      Begin
        If not stlListaCadTem.Find(cdsCadTem.FieldByName('TEM_CODIGO').AsString, intIndex) Then
          stlListaCadTem.Add(cdsCadTem.FieldByName('TEM_CODIGO').AsString);

        cdsCadTem.Next;
      End;

      cdsCadTem.Filtered := False;
    End;

  End;
End;

procedure TConvert.pAddListaTemplate;
  Var
    intIndex: Integer;
Begin
  With cdsCadTem Do
  Begin
    If IsEmpty Then
      Exit;

    If stlListaCadTem.Find(FieldByName('TEM_CODIGO').AsString, intIndex) Then
      stlListaCadTem.Delete(intIndex)
    Else
      stlListaCadTem.Add(FieldByName('TEM_CODIGO').AsString);
  End;
End;

procedure TConvert.pAddListaModelos;
  Var
    intIndex: Integer;
Begin
  With cdsCadMod Do
  Begin
    If IsEmpty Then
      Exit;

    If stlListaCadMod.Find(FieldByName('MOD_CODMOD').AsString, intIndex) Then
      stlListaCadMod.Delete(intIndex)
    Else
      stlListaCadMod.Add(FieldByName('MOD_CODMOD').AsString);
  End;
End;

procedure TConvert.pAddMarcaDesmarcaTodosLista(blnMarca: Boolean);
var
  intIndex: Integer;
  intRecNo: Integer;
begin
  with cdsCadRel do
  begin
    if IsEmpty then
      Exit;

    intRecNo := RecNo;
    DisableControls;

    try
      First;
      while not Eof do
      begin
        if blnMarca then
          stlLista.Add(FieldByName('CODREL').AsString)
        else
        begin
          if stlLista.Find(FieldByName('CODREL').AsString, intIndex) then
            stlLista.Delete(intIndex);
        end;
        Next;
      end;
    finally
      RecNo := intRecNo;
      EnableControls;
    end;
  end;

  if not blnMarca then
    stlListaCadTem.Clear;

end;

procedure TConvert.pAddMarcaDesmarcaTodosListaTemplate(blnMarca: Boolean);
var
  intIndex: Integer;
  intRecNo: Integer;
begin
  with cdsCadTem do
  begin
    if IsEmpty then
      Exit;

    intRecNo := RecNo;
    DisableControls;

    try
      First;
      while not Eof do
      begin
        if blnMarca then
          stlListaCadTem.Add(FieldByName('TEM_CODIGO').AsString)
        else
        begin
          if stlListaCadTem.Find(FieldByName('TEM_CODIGO').AsString, intIndex) then
            stlListaCadTem.Delete(intIndex);
        end;
        Next;
      end;
    finally
      RecNo := intRecNo;
      EnableControls;
    end;
  end;
end;

procedure TConvert.pAdicionaTemplateFixo;
begin
//
end;

procedure TConvert.pAddMarcaDesmarcaTodosListaModelo(blnMarca: Boolean);
var
  intIndex: Integer;
  intRecNo: Integer;
begin
  with cdsCadMod do
  begin
    if IsEmpty then
      Exit;

    intRecNo := RecNo;
    DisableControls;

    try
      First;
      while not Eof do
      begin
        if blnMarca then
          stlListaCadMod.Add(FieldByName('MOD_CODMOD').AsString)
        else
        begin
          if stlListaCadMod.Find(FieldByName('MOD_CODMOD').AsString, intIndex) then
            stlListaCadMod.Delete(intIndex);
        end;
        Next;
      end;
    finally
      RecNo := intRecNo;
      EnableControls;
    end;
  end;
end;

Function TConvert.fInLista(strCodRel: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := stlLista.Find(strCodRel, intIndex);
End;

Function TConvert.fInListaCadTem(strCodTem: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := stlListaCadTem.Find(strCodTem, intIndex);
End;

Function TConvert.fInListaCadMod(strCodMod: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := stlListaCadMod.Find(strCodMod, intIndex);
End;

Function TConvert.fTemCadDir(var strChaves: string): Boolean;
var
  strListaCodRel: string;
  intContador: Integer;
begin
  strListaCodRel := '';

  for intContador := 0 To stlLista.Count - 1 do
    strListaCodRel := strListaCodRel + IfThen(strListaCodRel <> '', '_', '') + stlLista[intContador];

  with qryGeral do
  begin
    Close;

    SQL.Text := 'SELECT GROUP_CONCAT(DISTINCT CONCAT("Filtro: ", PAR_DESPAR, ". Cód.Dir: ", DIR_CODDIR, ".") SEPARATOR ''\n'') AS CODDIR ' +
                ' FROM CADPRR P                                                                     ' +
                '  JOIN CADREL C ON P.PAR_SEQGER = C.AUTOINCREM                                     ' +
                '  JOIN CADDIR D ON SUBSTRING(P.PAR_VERVER, 3, LENGTH(P.PAR_VERVER)) = D.DIR_CODDIR ' +
                ' WHERE P.PAR_VERVER LIKE BINARY ''vv%'' AND LOCATE(C.REL_CODREL, :CODREL)          ';
    ParamByName('CODREL').AsString := strListaCodRel;
    Open;
    strChaves := FieldByName('CODDIR').AsString;
    Result := strChaves <> '';
  end;
end;

function TConvert.fRetExisteGatInf(strCodRel: String): Boolean;
var
  intContador: Integer;
begin
  Result := False;

  with cdsCadRel do
  begin
    if strCodRel = '' then
    begin
      for intContador := 0 to Length(stlArray) - 1 do
        if Locate('CODREL', stlArray[intContador], []) then
          if SameText(FieldByName('GATINF').AsString, 'S') then
            Result := True;

    end
    else
    begin
      If Locate('CODREL', strCodRel, []) Then
        if SameText(FieldByName('GATINF').AsString, 'S') then
          Result := True;
    end;
  end;
end;


Procedure TConvert.pInsereCadVal();
  Var
    strChave, strChaveBKP, strAutIncCADVAL: String;
Begin

  With cdsCadRel Do
  Begin
    strChave    := FieldByName('CHAVE_').AsString;
    strChaveBKP := '';

    strAutIncCADVAL   := QuotedStr('789' + RightStr('0000000' + strChave, 7) + RightStr('0000000' + strChaveBkp, 7) + '789');
    stlScript.Add('INSERT INTO TMP_CADVAL SELECT * FROM CADVAL WHERE VAL_SEQGER = ' + strAutIncCADVAL + ';');
  End;
End;

Procedure TConvert.pInsereCadRel(blnbkp, blnSalvaCADVAL: Boolean);
  Var
    intCampos, intMenus: Integer;
    strValor, strColunas: String;
Begin

  With cdsCadRel Do
  Begin
    If strCodRelExterno.IsEmpty Then
      strChave := FieldByName('CHAVE_').AsString
    Else
      strChave := '';

    If strCodRelExterno.IsEmpty Then
    Begin
      stlScript.Add('-- ------------------------------------------------------------ ' + FieldByName('DESCRI').AsString);

      stlScript.Add('');

      stlScript.Add('DELETE FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW);');
    End;

    strColunas := fRetColunasSQL('CADREL', 'REL_CODREL', true);

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Text := 'SELECT ' + strColunas + ' FROM CADREL WHERE REL_CODREL = :CODREL';
    qryGeral.ParamByName('CODREL').AsString := FieldByName('CODREL').AsString;
    qryGeral.Open;

    stlScript.Add('INSERT INTO `CADREL` (');

    For intCampos := 0 To qryGeral.FieldCount - 1 Do
      If intCampos <> qryGeral.FieldCount - 1 Then
        stlScript.Add(qryGeral.Fields[intCampos].FieldName + ',')
      Else
        stlScript.Add(qryGeral.Fields[intCampos].FieldName);

    stlScript.Add(')');
    stlScript.Add('VALUES');
    stlScript.Add('  (');

    For intCampos := 0 To qryGeral.FieldCount - 1 Do
    Begin

      If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_PADRAO') Then
      Begin
        if (strCodRelExterno.IsEmpty) and (blnRelPadrao) then
          strValor   := QuotedStr('S')
        Else
          strValor   := QuotedStr('N');
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_ARQUIV') And
         (Not strCodRelExterno.IsEmpty) Then
      Begin
        strValor   := QuotedStr('');
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_DTAALT') And
         (Not strCodRelExterno.IsEmpty) Then
      Begin
        strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', Date));
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_HORALT') And
         (Not strCodRelExterno.IsEmpty) Then
      Begin
        strValor := QuotedStr(FormatDateTime('HH:NN:SS', Time));
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'AUTOINCREM') Then
      Begin
        If strCodRelExterno.IsEmpty Then
        Begin
          strValor := QuotedStr('789' + RightStr('0000000' + strChave, 7) + RightStr('0000000' + strChaveBkp, 7) + '789')
        End Else
        Begin
          strValor := fGetAutoIncrem('CADREL');
          stlListaCadRel.Add(qryGeral.Fields[intCampos].AsString + ';' + strValor);
          strValor := QuotedStr(strValor);
        End;

        strSeqGer := strValor;
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CODREL') Then
      Begin
        If strCodRelExterno.IsEmpty Then
        Begin
          strValor := IntToStr(500000 + FieldByName('CHAVE_').AsInteger)
        End Else
        Begin
          strValor := fGetCodigoRelatorio;

          stlListaCodRel.Add(qryGeral.Fields[intCampos].AsString + ';' + strValor);

          If strCodRelPai.IsEmpty Then
            strCodRelPai := strValor;
        End;

        pRegistraPai(qryGeral.Fields[intCampos].AsString, strValor);
        strValor := QuotedStr(strValor);
      End

      Else If (SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CODVAL')) and (FieldByName('CODVAL').AsString <> '') Then
      Begin
        If strCodRelExterno.IsEmpty Then
        Begin
          strValor := IntToStr(500000 + (FieldByName('CODVAL').AsInteger - 500000));
          strValor := QuotedStr(strValor);
          stlListaCodVal.Add(qryGeral.FieldByName('REL_CODVAL').AsString + ',' + IntToStr(500000 + FieldByName('CHAVE_').AsInteger));
        End Else
        Begin
          strValor := fGetCodigoSub(qryGeral.Fields[intCampos].AsString);
        End;
      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CODPAI') Then
      Begin
        If strCodRelExterno.IsEmpty Then
        Begin
          strValor := fRetCodPai(qryGeral.Fields[intCampos].AsString);

          if qryGeral.FieldByName('REL_CODPAI').AsString <> '' then
          Begin
            strValor := '(NULL)';
            stlListaCodPai.Add(qryGeral.FieldByName('REL_CODPAI').AsString + ',' + IntToStr(500000 + FieldByName('CHAVE_').AsInteger));
          End;
        End Else
        Begin
          strValor := fGetCodigoSub(qryGeral.Fields[intCampos].AsString);
        End;

      End

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_RELFR3') Then
        strValor := QuotedStr(UTF8ToString(RawByteString(qryGeral.Fields[intCampos].AsString)))

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_FR3FAS') Then
        strValor := QuotedStr(UTF8ToString(RawByteString(qryGeral.Fields[intCampos].AsString)))

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_MD5OLD') Then
        strValor := QuotedStr(qryGeral.FieldByName('REL_MD5NEW').AsString)

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CHAVE_') And
              (blnbkp Or (Not strCodRelExterno.IsEmpty)) Then
        strValor := '(NULL)'

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CHABKP') And blnbkp Then
        strValor := QuotedStr(qryGeral.FieldByName('REL_CHAVE_').AsString)

      Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_CODBKP') And blnbkp Then
        strValor := '@CODREL'

      Else
      Begin

        If qryGeral.Fields[intCampos].IsNull Then
          strValor := '(NULL)'
        Else
          Case qryGeral.Fields[intCampos].DataType Of
            ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
            ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
            ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));

            Else       strValor := QuotedStr(AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, '\', '\\'));
          End;

      End;

      If intCampos <> qryGeral.FieldCount - 1 Then
        stlScript.Add(strValor + ',')
      Else
        stlScript.Add(strValor);
    End;

    stlScript.Add(');');

    stlScript.Add('');
    stlScript.Add('');

    If strCodRelExterno.IsEmpty Then
    Begin

      If Not(fCampoExiste('RELMEN','MEN_NOMME2')) Then
      Begin
      If (FieldByName('NOMMEN').AsString <> '') And (Not blnbkp) Then
        stlScript.Add('INSERT INTO `RELMEN` (`AUTOINCREM`, `MEN_NOMMEN`, `MEN_CODREL`, `MEN_CAPMEN`) VALUES(' +
                      '"789' + RightStr('0000000' + strChave, 7) + RightStr('0000000' + strChaveBkp , 7) + '789", ' +
            QuotedStr(FieldByName('NOMMEN').AsString) + ', (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + '), ' + QuotedStr(FieldByName('CAPMEN').AsString) + ');');
      end
      Else
      Begin
        If ((FieldByName('NOMMEN').AsString <> '') or ((FieldByName('NOMME2').AsString <> ''))) And (Not blnbkp) Then
        Begin
          intMenus := 1;
          qryGeral.Close;
          qryGeral.SQL.Text := 'SELECT * FROM RELMEN WHERE MEN_CODREL = '
                             + '(SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' +  FieldByName('CHAVE_').AsString + ')';
          qryGeral.Open;

          While not qryGeral.Eof Do
          Begin

            stlScript.Add('INSERT INTO `RELMEN` (`AUTOINCREM`, `MEN_NOMMEN`, `MEN_NOMME2`,`MEN_CODREL`, `MEN_CAPMEN`) VALUES(' +
                          '"789' + RightStr('0000000' + strChave, 7) + RightStr('0000000' + strChaveBkp , 6)+ IntToStr(intMenus) + '789", ' +
                           IfThen((qryGeral.FieldByName('MEN_NOMMEN').AsString) = NullAsStringValue, QuotedStr(qryGeral.FieldByName('MEN_NOMME2').AsString), QuotedStr(qryGeral.FieldByName('MEN_NOMMEN').AsString) ) + ' , ' +
                           IfThen((qryGeral.FieldByName('MEN_NOMME2').AsString) = NullAsStringValue, QuotedStr(qryGeral.FieldByName('MEN_NOMMEN').AsString), QuotedStr(qryGeral.FieldByName('MEN_NOMME2').AsString) ) +
                           ', (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' +  FieldByName('CHAVE_').AsString + '), ' +
                           QuotedStr(qryGeral.FieldByName('MEN_CAPMEN').AsString) + ');');

            intMenus := intMenus + 1;

            qryGeral.Next;

          End;

          qryGeral.Close;

        End;
      End;
      stlScript.Add('');

      stlScript.Add('INSERT INTO `RELVRS` (`RVS_CODREL`, `RVS_VERREL`) VALUES ( '+
                    ' (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' +  FieldByName('CHAVE_').AsString + '), ' +
                    ' (SELECT IFNULL(REL_VERREL,"48.2.30.00") FROM CADREL WHERE REL_CHAVE_ = ' +  FieldByName('CHAVE_').AsString + ') ); ');

      stlScript.Add('');
    End;
  End;
End;

Function TConvert.fRetAutoincrem(Var intContador: Integer): String;
Begin
  If strChave = '' Then
    Result := QuotedStr('7890' + RightStr('000000' + IntToStr(intContador) , 6) + RightStr('0000000' + strChaveBkp, 7) + '789')
  Else
    Result := QuotedStr('7891' + RightStr('000000' + strChave, 6)               + RightStr('0000000' + IntToStr(intContador), 7) + '789');

  Inc(intContador);
End;

Function TConvert.fRetColunasSQL(tabela, codigo: String; autoincrem : Boolean): String;
var
  colunas : String;
  intCampos : Integer;
  lstColunas: TStringList;
Begin
  qryColuna.Close;
  qryColuna.SQL.Clear;
  qryColuna.SQL.Add('SELECT * FROM ' + tabela + ' WHERE FALSE ');
  qryColuna.Open;

  lstColunas := TStringList.Create;

  For intCampos := 0 To qryColuna.FieldCount - 1 Do
  Begin
    if (not SameText(qryColuna.Fields[intCampos].FieldName, 'AUTOINCREM'))
      and  (not SameText(qryColuna.Fields[intCampos].FieldName, codigo)) then

    Begin
      lstColunas.Add(qryColuna.Fields[intCampos].FieldName);
    End;

  End;

  lstColunas.Sort;

  colunas := StringReplace(lstColunas.Text, #13#10, ', ' , [rfReplaceAll]);

  colunas := codigo + ', ' + colunas;

  if autoincrem then
  begin
    colunas := 'AUTOINCREM, ' + colunas;
  end;

  colunas := Copy(colunas, 1, Length(colunas) - 2);

  Result := colunas;
End;

Procedure TConvert.pInsereCadCam;
  Var
    intContReg,
    intCampos: Integer;
    strValor: String;
    strSQL: String;
    strColunas : String;
Begin
  With cdsCadRel Do
  Begin
    strColunas := fRetColunasSQL('CADCAM', 'CAM_SEQGER', true);

    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT ' + strColunas + ' FROM CADCAM WHERE CAM_SEQGER = :SEQGER ORDER BY CAM_NOMCAM ';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    intContReg := 1;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO CADCAM (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'CAM_SEQGER') Then
        Begin
          strValor := strSeqGer;
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'AUTOINCREM') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := fRetAutoincrem(intContReg)
          Else
            strValor := QuotedStr(fGetAutoIncrem('CADCAM'));
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScript.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereTabela(strNomTab, strCamSeqGer: String);
  Var
    intContReg,
    intCampos: Integer;
    strValor: String;
    strSQL: String;
    strColunas : String;
Begin
  With cdsCadRel Do
  Begin
    strColunas := fRetColunasSQL(strNomTab, strCamSeqGer, False);

    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT ' + strColunas + ' FROM ' + strNomTab + ' WHERE ' + strCamSeqGer + ' = :SEQGER ';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    intContReg := 1;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab + ' (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, strCamSeqGer) Then
        Begin
          strValor := strSeqGer;
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'AUTOINCREM') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := fRetAutoincrem(intContReg)
          Else
            strValor := QuotedStr(fGetAutoIncrem(strNomTab));
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScript.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereGruPar;
  Var
    intContReg,
    intCampos: Integer;
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT * FROM GRUPAR WHERE GRU_SEQGER = :SEQGER';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    intContReg := 1;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO GRUPAR (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'AUTOINCREM') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := fRetAutoincrem(intContReg)
          Else
            strValor := QuotedStr(fGetAutoIncrem('GRUPAR'));
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'GRU_SEQGER') Then
        Begin
          strValor := strSeqGer;
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate:    strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScript.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereCadPar(var intContRegDir: Integer; var strChavesCodDir: string);
  Var
    intContReg,
    intCampos: Integer;
    strSQL,
    strValor: String;
    strColunas: String;
Begin

  With cdsCadRel Do
  Begin
    strColunas := fRetColunasSQL('CADPRR', 'PAR_SEQGER', true);

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add('SELECT ' + strColunas + ' FROM CADPRR WHERE PAR_SEQGER = :SEQGER ');

    if Pos(FieldByName('ARQUIV').AsString, '14203_14213_GERACAO_SPED_FISCAL.SQL@12150_12170_GERACAO_DE_SPED_DE_PIS_COFINS.SQL') <= 0 then
    begin
      if (FieldByName('EXPAUT').AsString = 'N') then
        qryGeral.SQL.Add(' AND PAR_AUTOMA = "N"');
    end;

    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    intContReg := 1;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO CADPRR (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'AUTOINCREM') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := fRetAutoincrem(intContReg)
          Else
            strValor := QuotedStr(fGetAutoIncrem('CADPRR'));
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'PAR_SEQGER') Then
        Begin
          strValor := strSeqGer;
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate:    strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScript.Add(strSQL);

      if (Copy(qryGeral.FieldByName('PAR_VERVER').AsString, 1, 2) = 'vv') And
         strCodRelExterno.IsEmpty Then
        fInsereCadDir(intContRegDir, strChavesCodDir, Copy(qryGeral.FieldByName('PAR_VERVER').AsString, 3, Length(qryGeral.FieldByName('PAR_VERVER').AsString) - 2));

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereDirRel(var intContRegDir: Integer; var strChavesCodDir: string);
  Var
    intCampos: Integer;
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT * FROM DIRREL WHERE REL_SEQGER = :SEQGER';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO DIRREL (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_SEQGER') Then
        Begin
          strValor := strSeqGer
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_SEQDIR') Then
        Begin

          If strCodRelExterno.IsEmpty Then
          Begin
            qryCadDir.Close;
            qryCadDir.SQL.Text := 'SELECT DIR_CODDIR FROM CADDIR WHERE AUTOINCREM = :AUTINC';
            qryCadDir.ParamByName('AUTINC').AsString := qryGeral.FieldByName('REL_SEQDIR').AsString;
            qryCadDir.Open;

            If qryCadDir.IsEmpty Then
              ShowMessage('Direito de Acesso ' + qryGeral.FieldByName('REL_SEQDIR').AsString + ' não encontrado!')
            else
              fInsereCadDir(intContRegDir, strChavesCodDir, qryCadDir.FieldByName('DIR_CODDIR').AsString);

            strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
          End
          Else
            strValor := '(NULL)'
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScriptDirRel.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

procedure TConvert.fInsereCadDir(var intContRegDir: Integer; var strChavesCodDir: string; strCodDir: string);
  Var
    intCampos: Integer;
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeralFilha.Close;
    qryGeralFilha.SQL.Text := 'SELECT * FROM CADDIR WHERE LOCATE(DIR_CODDIR, :CODDIR)';
    qryGeralFilha.ParamByName('CODDIR').AsString := strCodDir;
    qryGeralFilha.Open;

    While Not qryGeralFilha.Eof Do
    Begin
      if Pos(qryGeralFilha.FieldByName('DIR_CODDIR').AsString, strChavesCodDir) <= 0 then
      begin

        strChavesCodDir := strChavesCodDir + IfThen(strChavesCodDir <> '', '_', '') + qryGeralFilha.FieldByName('DIR_CODDIR').AsString;

        strSQL := '';
        strSQL := strSQL + 'REPLACE INTO CADDIR (';

        For intCampos := 0 To qryGeralFilha.FieldCount - 1 Do
          If intCampos <> qryGeralFilha.FieldCount - 1 Then
            strSQL := strSQL + qryGeralFilha.Fields[intCampos].FieldName + ', '
          Else
            strSQL := strSQL + qryGeralFilha.Fields[intCampos].FieldName;

        strSQL := strSQL + ') VALUES (';

        For intCampos := 0 To qryGeralFilha.FieldCount - 1 Do
        Begin

          If qryGeralFilha.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeralFilha.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeralFilha.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeralFilha.Fields[intCampos].AsString, ',', '.');
              ftDate:    strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeralFilha.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeralFilha.Fields[intCampos].AsString);
            End;

          If intCampos <> qryGeralFilha.FieldCount - 1 Then
            strSQL := strSQL + strValor + ', '
          Else
            strSQL := strSQL + strValor;
        End;

        strSQL := strSQL + ');';

        stlScriptCadDir.Add(strSQL);
      end;

      qryGeralFilha.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereSubRel(blnbkp: Boolean);
  Var
    intCampos: Integer;
    strChaveComple,
    strChaveCompleBKP,
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT * FROM SUBREL WHERE REL_MASTER = :SEQGER';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO SUBREL (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_MASTER') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := strSeqGer
          Else
            strValor := QuotedStr(fGetAutoincremSub(qryGeral.FieldByName('REL_MASTER').AsString));
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_COMPLE') Then
        Begin
          If strCodRelExterno.IsEmpty Then
          Begin
            qryComple.Close;
            qryComple.SQL.Text := 'SELECT REL_CHAVE_ FROM CADREL WHERE AUTOINCREM = :AUTINC';
            qryComple.ParamByName('AUTINC').AsString := qryGeral.FieldByName('REL_COMPLE').AsString;
            qryComple.Open;

            If qryComple.IsEmpty Then
              ShowMessage('Complemento ' + qryGeral.FieldByName('REL_COMPLE').AsString + ' não encontrado!');

            strChaveComple    := qryComple.FieldByName('REL_CHAVE_').AsString;
            strChaveCompleBKP := '';

            strValor := QuotedStr('789' + RightStr('0000000' + strChaveComple, 7) + RightStr('0000000' + strChaveCompleBkp, 7) + '789');
          End Else
          Begin
            strChaveComple := '';
            strChaveCompleBKP := '';
            strValor := QuotedStr(fGetAutoincremSub(qryGeral.Fields[intCampos].AsString));
          End;

        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScriptSubRel.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereChiRel(blnbkp: Boolean);
  Var
    intCampos: Integer;
    strChaveComple,
    strChaveCompleBKP,
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT * FROM CHIREL WHERE REL_MASTER = :SEQGER';
    qryGeral.ParamByName('SEQGER').AsString := FieldByName('AUTINC').AsString;
    qryGeral.Open;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO CHIREL (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

        If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_MASTER') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := strSeqGer
          Else
            strValor := QuotedStr(fGetAutoincremSub(qryGeral.FieldByName('REL_MASTER').AsString));
        End

        Else If SameText(qryGeral.Fields[intCampos].FieldName, 'REL_COMPLE') Then
        Begin
          If strCodRelExterno.IsEmpty Then
          Begin
            qryComple.Close;
            qryComple.SQL.Text := 'SELECT REL_CHAVE_ FROM CADREL WHERE AUTOINCREM = :AUTINC';
            qryComple.ParamByName('AUTINC').AsString := qryGeral.FieldByName('REL_COMPLE').AsString;
            qryComple.Open;

            If qryComple.IsEmpty Then
              ShowMessage('Child ' + qryGeral.FieldByName('REL_COMPLE').AsString + ' não encontrado!');

            strChaveComple    := qryComple.FieldByName('REL_CHAVE_').AsString;
            strChaveCompleBKP := '';

            strValor := QuotedStr('789' + RightStr('0000000' + strChaveComple, 7) + RightStr('0000000' + strChaveCompleBkp, 7) + '789');
          End Else
          Begin
            strChaveComple := '';
            strChaveCompleBKP := '';
            strValor := QuotedStr(fGetAutoincremSub(qryGeral.Fields[intCampos].AsString));
          End;
        End

        Else
        Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;

        End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScriptChiRel.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

Procedure TConvert.pInsereHisRel;
  Var
    intCampos: Integer;
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Text := 'SELECT * FROM HISREL WHERE HIS_CHAVE_ = :CHAVE';
    qryGeral.ParamByName('CHAVE').AsString := FieldByName('CHAVE_').AsString;
    qryGeral.Open;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO HISREL (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin
        If qryGeral.Fields[intCampos].IsNull Then
          strValor := '(NULL)'
        Else
          Case qryGeral.Fields[intCampos].DataType Of
            ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
            ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
            ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
            Else       strValor := QuotedStr(AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, '\', '\\'));
          End;

        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScriptHisRel.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;

// ATAREL
Procedure TConvert.pInsereAtaRel();
  Var
    intCampos: Integer;
    strSQL,
    strValor: String;
Begin
  With cdsCadRel Do
  Begin
    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add( ' SELECT ATA_CHAVE_, ATA_CODATA, ATA_CODREL, IFNULL(ATA_CHAORI, ATA_CHAVE_) AS ATA_CHAORI ');
    qryGeral.SQL.Add( ' FROM ATAREL WHERE ATA_CHAVE_ = :CHAVE  ');
    qryGeral.ParamByName('CHAVE').AsString := FieldByName('CHAVE_').AsString;
    qryGeral.Open;

    While Not qryGeral.Eof Do
    Begin
      strSQL := '';

      if blnRelPadrao Then
        strSQL := strSQL + 'INSERT INTO ATAREL ('
      else
        strSQL := strSQL + 'REPLACE INTO ATAREL (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName + ', '
        Else
          strSQL := strSQL + qryGeral.Fields[intCampos].FieldName;

      strSQL := strSQL + ') VALUES (';

      For intCampos := 0 To qryGeral.FieldCount - 1 Do
      Begin

          If qryGeral.Fields[intCampos].IsNull Then
            strValor := '(NULL)'
          Else
            Case qryGeral.Fields[intCampos].DataType Of
              ftInteger: strValor := qryGeral.Fields[intCampos].AsString;
              ftFloat  : strValor := AnsiReplaceStr(qryGeral.Fields[intCampos].AsString, ',', '.');
              ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', qryGeral.Fields[intCampos].Value));
              Else       strValor := QuotedStr(qryGeral.Fields[intCampos].AsString);
            End;


        If intCampos <> qryGeral.FieldCount - 1 Then
          strSQL := strSQL + strValor + ', '
        Else
          strSQL := strSQL + strValor;
      End;

      strSQL := strSQL + ');';

      stlScriptAtaRel.Add(strSQL);

      qryGeral.Next;
    End;

    stlScript.Add('');
  End;
End;
//ATAREL

// CALL FINAL
Procedure TConvert.pInsereCallProcedure();
  Var
    intCont: Integer;
    strCall: String;
Begin
  With cdsCadRel Do
  Begin
    strCall := '';

    for intCont := 0 to Length(arrTemplateFixo) - 1 do
    begin
      if arrTemplateFixo[intCont].CadRelArquivo = FieldByName('ARQUIV').AsString then
        strCall := arrTemplateFixo[intCont].CallFinal;
    end;

    If strCall <> '' then
    Begin
      stlScript.Add('');
      stlScript.Add(strCall);
      stlScript.Add('');
    End;
  End;
End;
//CALL FINAL

Procedure TConvert.pInsereDireitos;
Var
  lstChaAnt : TStringList;
  intContador, intChave : Integer;

Begin
  With cdsCadRel Do
  Begin
    If FieldbyName('DIRANT').AsString <> '' Then
    Begin
      stlScript.Add('REPLACE INTO DIROPE (DIR_NOMFRM, OPE_CODOPE, DIR_ACAOUS) ');
      stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), OPE_CODOPE, DIR_ACAOUS FROM DIROPE');
      stlScript.Add('WHERE DIR_NOMFRM = ' + QuotedStr(FieldbyName('DIRANT').AsString)  + ';');

      stlScript.Add('REPLACE INTO DIRGPO (DIR_NOMFRM, GPO_CODGPO, DIR_ACAOUS) ');
      stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), GPO_CODGPO, DIR_ACAOUS FROM DIRGPO');
      stlScript.Add('WHERE DIR_NOMFRM = ' + QuotedStr(FieldbyName('DIRANT').AsString)  + ';');

      stlScript.Add('');
    End;

    if FieldbyName('CHAANT').AsString <> '' then
    Begin
      lstChaAnt := TStringList.Create;
      lstChaAnt.Text := AnsiReplaceStr(FieldbyName('CHAANT').AsString, ',', #13#10);

      for intContador := 0 to lstChaAnt.Count - 1 do
      Begin
        try
          intChave := StrToInt(lstChaAnt[intContador]);

          if (intChave = FieldByName('CHAVE_').AsInteger) then
            continue;

          intChave := intChave + 500000;

          stlScript.Add('REPLACE INTO DIROPE (DIR_NOMFRM, OPE_CODOPE, DIR_ACAOUS) ');
          stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), OPE_CODOPE, DIR_ACAOUS FROM DIROPE');
          stlScript.Add('WHERE DIR_NOMFRM = "' + 'frm' + IntToStr(intChave) + 'Rel'  + '" ;');

          stlScript.Add('REPLACE INTO DIRGPO (DIR_NOMFRM, GPO_CODGPO, DIR_ACAOUS) ');
          stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), GPO_CODGPO, DIR_ACAOUS FROM DIRGPO');
          stlScript.Add('WHERE DIR_NOMFRM = "' + 'frm' + IntToStr(intChave) + 'Rel'  + '" ;');

          stlScript.Add('');
        except
          On E: Exception Do
            Raise Exception.Create('Erro: ' + E.Message);
        end;

      End;

      FreeAndNil(lstChaAnt);
    End;

    stlScript.Add('REPLACE INTO DIROPE (DIR_NOMFRM, OPE_CODOPE, DIR_ACAOUS) ');
    stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), OPE_CODOPE, DIR_ACAOUS FROM DIROPE');
    stlScript.Add('WHERE DIR_NOMFRM = "frmDirAcesso";');

    stlScript.Add('REPLACE INTO DIRGPO (DIR_NOMFRM, GPO_CODGPO, DIR_ACAOUS) ');
    stlScript.Add('SELECT CONCAT("frm", (SELECT REL_CODREL FROM CADREL WHERE REL_CHAVE_ = ' + FieldByName('CHAVE_').AsString + ' AND (REL_MD5OLD = REL_MD5NEW)) , "Rel"), GPO_CODGPO, DIR_ACAOUS FROM DIRGPO');
    stlScript.Add('WHERE DIR_NOMFRM = "frmDirAcesso";');

    stlScript.Add('');

  End;
End;

Procedure TConvert.pGeraCabecalho;
Begin

  stlScript.Clear;
  stlScriptSubRel.Clear;
  stlScriptChiRel.Clear;
  stlScriptHisRel.Clear;
  stlScriptAtaRel.Clear;
  stlScriptCadDir.Clear;
  stlScriptDirRel.Clear;

  stlScript.Add('SET SQL_LOG_BIN = 0;');

  stlScript.Add('');

  stlScript.Add('SET NAMES "utf8";');
  stlScript.Add('SET character_set_connection=utf8;');
  stlScript.Add('SET character_set_client=utf8;');
  stlScript.Add('SET character_set_results=utf8;');

  stlScript.Add('');

End;

Procedure TConvert.pGeraTemplates;
var
  intContador: Integer;
Begin

  intContTem := 0;

  with cdsCadTem do
  begin
    for intContador := 0 To stlListaCadTem.Count - 1 do
    if Locate('TEM_CODIGO', stlListaCadTem[intContador], []) Then
    begin
      If strCodRelExterno.IsEmpty Then
        stlScript.Add('-- TEMPLATES ');
      pInsereCadTem;
    end;
  end;
End;

procedure TConvert.pGeraUpdateCodPai;
var
  strCodPai, strCodrel : String;
  intContagem : Integer;
begin
  stlScript.Add('');

  for intContagem := 0 to stlListaCodPai.Count - 1 do
  begin
    strCodPai := Copy(stlListaCodPai[intContagem], 1, 6);
    strCodrel := Copy(stlListaCodPai[intContagem], 8, 6);

    stlScript.Add('UPDATE CADREL SET REL_CODPAI = ' + fRetCodPai(strCodPai) + ' WHERE REL_CODREL = ' + QuotedStr(strCodrel) + ';');
  end;

end;

Function TConvert.fGetAutoincremSub(strAutInc: String): String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To stlListaCadRel.Count - 1 Do
    If LeftStr(stlListaCadRel[intContador], 20) = strAutInc Then
    Begin
      Result := RightStr(stlListaCadRel[intContador], 20);
      Exit;
    End;
End;

Function TConvert.fGetCodigoSub(strCodigo: String): String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To stlListaCodRel.Count - 1 Do
    If LeftStr(stlListaCodRel[intContador], 6) = strCodigo Then
    Begin
      Result := RightStr(stlListaCodRel[intContador], 6);
      Break;
    End;

  If Result.IsEmpty Then
    Result := ' NULL '
  Else
    Result := QuotedStr(Result);
End;

procedure TConvert.pGeraUpdateCodVal;
var
  strCodVal, strCodrel : String;
  intContagem : Integer;
begin
  stlScript.Add('');

  for intContagem := 0 to stlListaCodVal.Count - 1 do
  begin
    strCodVal := Copy(stlListaCodVal[intContagem], 1, 6);
    strCodrel := Copy(stlListaCodVal[intContagem], 8, 6);

    stlScript.Add('UPDATE CADREL SET REL_CODVAL = ' + QuotedStr(strCodVal) + ' WHERE REL_CODREL = ' + QuotedStr(strCodrel) + ';');
  end;
end;

Procedure TConvert.pGeraModelos;
var
  intContador: Integer;
Begin

  intContMod := 0;

  with cdsCadMod do
  begin
    for intContador := 0 To stlListaCadMod.Count - 1 do
    if Locate('MOD_CODMOD', stlListaCadMod[intContador], []) Then
    begin
      If strCodRelExterno.IsEmpty Then
        stlScript.Add('-- MODELOS DE RELATÓRIOS ');
      pInsereCadMod;
    end;
  end;
End;


Procedure TConvert.pAlimentaFimScript(blnTemplates, blnSalvaCADVAL, blnExisteGatInf: Boolean);
Begin
  stlScript.Add(stlScriptSubRel.Text);
  stlScript.Add(stlScriptChiRel.Text);
  stlScript.Add(stlScriptCadDir.Text);
  stlScript.Add(stlScriptDirRel.Text);
  stlScript.Add(stlScriptHisRel.Text);
  stlScript.Add(stlScriptAtaRel.Text);

  If strCodRelExterno.IsEmpty Then
  Begin
    If stlListaCadTem.Count > 0 then
      pGeraTemplates;

    If stlListaCadMod.Count > 0 then
      pGeraModelos;
  End;
End;

Function TConvert.fGeraScript(var strChavesCodDir: string; blnCabecalho, blnTemplates, blnSalvaCADVAL: Boolean; var blnInicioScript: Boolean; strCodRel: string = ''; blnExportacao: Boolean = False): Boolean;
var
  intContador,
  intContRegDir,
  intValida: Integer;
  blnExisteGatInf: Boolean;
  strCodRelLista,
  strGatCod: String;

  sltListaRel: TStringList;

  procedure pProcessaCadRel(var strChavesCodDir: string; blnSalvaCADVAL: Boolean);
  begin
    pInsereCadRel(False, blnSalvaCADVAL);
    pInsereCadCam;
    pInsereGruPar;
    intContRegDir := 1;
    pInsereCadPar(intContRegDir, strChavesCodDir);

    if fCampoExiste('RELROT', 'ROT_SEQGER') then
      pInsereTabela('RELROT', 'ROT_SEQGER');

    if fCampoExiste('RELMAP', 'MAP_SEQGER') then
      pInsereTabela('RELMAP', 'MAP_SEQGER');

    if fCampoExiste('CAMMAP', 'MAP_SEQGER') then
      pInsereTabela('CAMMAP', 'MAP_SEQGER');

    If strCodRelExterno.IsEmpty Then
      pInsereDirRel(intContRegDir, strChavesCodDir);

    If strCodRelExterno.IsEmpty Then
    Begin
      pInsereSubRel(False);
      pInsereChiRel(False);

      pInsereHisRel;
      pInsereDireitos;
      pInsereAtaRel;
    End;
  end;

Begin
  stlListaCodPai.Clear;
  stlListaCodVal.Clear;

  if blnInicioScript then
  begin
    cdsCadPai.EmptyDataSet;
    blnInicioScript := False;
  end;

  if blnCabecalho then
    pGeraCabecalho;

  pProcessaArrayCod;

  if blnSalvaCADVAL then
  begin
    If strCodRelExterno.IsEmpty Then
      stlScript.Add('-- ------------------------------------------------------------ CADVAL ');
    stlScript.Add('');

    stlScript.Add('DROP TEMPORARY TABLE IF EXISTS TMP_CADVAL;');
    stlScript.Add('CREATE TEMPORARY TABLE TMP_CADVAL(SELECT * FROM CADVAL WHERE FALSE);');
    stlScript.Add('');


    with cdsCadRel do
    begin
      if strCodRel = '' then
      begin
        for intContador := 0 to Length(stlArray) - 1 do
          if Locate('CODREL', stlArray[intContador], []) then
            pInsereCadVal;
      end
      else
      begin
        If Locate('CODREL', strCodRel, []) Then
          pInsereCadVal;
      end;
    end;

    stlScript.Add('');
  end;

  blnExisteGatInf := fRetExisteGatInf(strCodRel);

  if blnExisteGatInf then
  begin
    strGatCod := '';

    with cdsCadRel do
    begin
      if strCodRel = '' then
      begin
        for intContador := 0 to Length(stlArray) - 1 do
          if Locate('CODREL', stlArray[intContador], []) then
            strGatCod := strGatCod + stlArray[intContador] + '_';
      end
      else
      begin
        If Locate('CODREL', strCodRel, []) Then
          strGatCod := strGatCod + '_';
      end;
    end;


    If strCodRelExterno.IsEmpty Then
      stlScript.Add('-- ------------------------------------------------------------ GATILHOS ');
    stlScript.Add('');
    stlScript.Add('CREATE TABLE IF NOT EXISTS GATINF_SCRIPT ( ');
    stlScript.Add(' DTAALT DATE, ');
    stlScript.Add(' CODIGO VARCHAR(6), ');
    stlScript.Add(' CODREL CHAR(6), ');
    stlScript.Add(' PRIMARY KEY(DTAALT, CODIGO, CODREL) ');
    stlScript.Add('); ');

    stlScript.Add('');
    stlScript.Add(' INSERT INTO GATINF_SCRIPT (DTAALT, CODIGO, CODREL) ');
    stlScript.Add(' SELECT ');
    stlScript.Add('   CURRENT_DATE AS DTAALT, ');
    stlScript.Add('   GAT_CODIGO AS CODIGO, ');
    stlScript.Add('   GAT_CODREL AS CODREL  ');
    stlScript.Add(' FROM GATINF ');
    stlScript.Add(' WHERE LOCATE(GAT_CODREL, "' + strGatCod + '") > 0; ');
    stlScript.Add('');

    stlScript.Add(' UPDATE GATINF SET GAT_CODREL = NULL ');
    stlScript.Add(' WHERE GAT_CODIGO IN (SELECT CODIGO FROM GATINF_SCRIPT WHERE DTAALT = CURRENT_DATE) AND LOCATE(GAT_CODREL, "' + strGatCod + '") > 0; ');

    stlScript.Add('');
  end;

  if (stlListaValida.Count > 0) And strCodRelExterno.IsEmpty then
  begin
    for intValida := 0 to stlListaValida.Count - 1 do
    begin
      stlScript.Add('UPDATE CADREL SET REL_CODVAL = NULL WHERE REL_CODVAL = "' + stlListaValida[intValida] + '"; ' );
      stlScript.Add('');
    end;
  end;

  If strCodRelExterno.IsEmpty Then
  Begin
    with cdsCadRel do
    begin
      if strCodRel = '' then
      begin
        for intContador := 0 to Length(stlArray) - 1 do
          if Locate('CODREL', stlArray[intContador], []) then
            pProcessaCadRel(strChavesCodDir, blnSalvaCADVAL);
      end
      else
      begin
        If Locate('CODREL', strCodRel, []) Then
          pProcessaCadRel(strChavesCodDir, blnSalvaCADVAL);
      end;
    end;
  End Else
  Begin

    sltListaRel := TStringList.Create;
    sltListaRel.CommaText := strCodRelExterno;

    For intContador := 0 To sltListaRel.Count - 1 Do
    Begin
      strCodRelLista := AnsiReplaceStr(sltListaRel[intContador], '''', '');
      If cdsCadRel.Locate('CODREL', strCodRelLista, []) Then
        pProcessaCadRel(strChavesCodDir, blnSalvaCADVAL);
    End;

    strCodRelLista := AnsiReplaceStr(sltListaRel[0], '''', '');
    If cdsCadRel.Locate('CODREL', strCodRelLista, []) Then
      pInsereSubRel(False);

    For intContador := 0 To sltListaRel.Count - 1 Do
    Begin
      strCodRelLista := AnsiReplaceStr(sltListaRel[intContador], '''', '');
      If cdsCadRel.Locate('CODREL', strCodRelLista, []) Then
        pInsereChiRel(False);
    End;

    FreeAndNil(sltListaRel);
  End;

  pInsereCallProcedure;

  If (stlListaCodPai.Count > 0) And strCodRelExterno.IsEmpty Then
    pGeraUpdateCodPai;

  If (stlListaCodVal.Count > 0)  And strCodRelExterno.IsEmpty Then
    pGeraUpdateCodVal;

  if blnSalvaCADVAL then
  begin
    stlScript.Add('');
    stlScript.Add('INSERT INTO CADVAL (  SELECT T.* FROM TMP_CADVAL T );');
    stlScript.Add('DROP TEMPORARY TABLE TMP_CADVAL;');
  end;

  if blnExisteGatInf then
  begin
    stlScript.Add('');
    stlScript.Add('UPDATE GATINF G ');
    stlScript.Add('INNER JOIN GATINF_SCRIPT S ON S.CODIGO = G.GAT_CODIGO ');
    stlScript.Add('                          AND S.DTAALT = CURRENT_DATE ');
    stlScript.Add('                          AND LOCATE(S.CODREL, "' + strGatCod + '") > 0 ');
    stlScript.Add('SET G.GAT_CODREL = S.CODREL; ');

  end;

  if not blnExportacao then
    pAlimentaFimScript(blnTemplates, blnSalvaCADVAL, blnExisteGatInf);

  Result := True;
End;

Procedure TConvert.pInsereCadTem;
  Var
    intCampos: Integer;
    strValor: String;
Begin
  With cdsCadTem Do
  Begin

    If strCodRelExterno.IsEmpty Then
      stlScript.Add('-- ------------------------------------------------------------ ' + FieldByName('TEM_DESCRI').AsString);
    stlScript.Add('');

    If strCodRelExterno.IsEmpty Then
      strChave := FieldByName('TEM_CHAVE_').AsString
    Else
      strChave := '';

    Inc(intContTem);

    stlScript.Add('');

     If strCodRelExterno.IsEmpty Then
       stlScript.Add('DELETE FROM CADTEM WHERE TEM_CHAVE_ = ' + FieldByName('TEM_CHAVE_').AsString + ' AND (TEM_MD5OLD = TEM_MD5NEW);');

     stlScript.Add('');

      stlScript.Add('INSERT INTO `CADTEM` (');

      For intCampos := 0 To FieldCount - 1 Do
        If intCampos <> FieldCount - 1 Then
          stlScript.Add(Fields[intCampos].FieldName + ',')
        Else
          stlScript.Add(Fields[intCampos].FieldName);

      stlScript.Add(')');
      stlScript.Add('VALUES');
      stlScript.Add('  (');

      For intCampos := 0 To FieldCount - 1 Do
      Begin

        If SameText(Fields[intCampos].FieldName, 'AUTOINCREM') Then
        Begin
          If strCodRelExterno.IsEmpty Then
            strValor := fRetAutoincrem(intContTem)
          Else
            strValor := QuotedStr(fGetAutoIncrem('CADTEM'));
        End

        Else If SameText(Fields[intCampos].FieldName, 'TEM_CODIGO') Then
        Begin
          strValor := QuotedStr(IntToStr(500000 + FieldByName('TEM_CHAVE_').AsInteger));
        End

        Else If SameText(Fields[intCampos].FieldName, 'TEM_MD5OLD') Then
        Begin
          strValor := QuotedStr(FieldByName('TEM_MD5NEW').AsString);
        End

        Else If Fields[intCampos].IsNull Then
          strValor := '(NULL)'
        Else
          Case Fields[intCampos].DataType Of
            ftInteger: strValor := Fields[intCampos].AsString;
            ftFloat  : strValor := AnsiReplaceStr(Fields[intCampos].AsString, ',', '.');
            ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', Fields[intCampos].Value));

            Else       strValor :=  QuotedStr(Fields[intCampos].AsString);
          End;


        If intCampos <> FieldCount - 1 Then
          stlScript.Add(strValor + ',')
        Else
          stlScript.Add(strValor);
      End;

      stlScript.Add(');');

      stlScript.Add('');
      stlScript.Add('');

      Next;
   End;
End;

Procedure TConvert.pInsereCadMod;
  Var
    intCampos: Integer;
    strValor, strCodigo: String;
Begin
  With cdsCadMod Do
  Begin

    If strCodRelExterno.IsEmpty Then
      stlScript.Add('-- ------------------------------------------------------------ ' + FieldByName('MOD_DESCRI').AsString);
    stlScript.Add('');

    strCodigo    := FieldByName('MOD_CODMOD').AsString;
    Inc(intContMod);

    stlScript.Add('INSERT INTO `CADMOD` (');

    For intCampos := 0 To FieldCount - 1 Do
      If intCampos <> FieldCount - 1 Then
        stlScript.Add(Fields[intCampos].FieldName + ',')
      Else
        stlScript.Add(Fields[intCampos].FieldName);

    stlScript.Add(')');
    stlScript.Add('VALUES');
    stlScript.Add('  (');

    For intCampos := 0 To FieldCount - 1 Do
    Begin

      If SameText(Fields[intCampos].FieldName, 'AUTOINCREM') Then
      Begin
        If strCodRelExterno.IsEmpty Then
          strValor   := QuotedStr('789' + RightStr('0000000' + strCodigo, 7) + '0000000789')
        Else
          strValor := QuotedStr(fGetAutoIncrem('CADMOD'));
      End
      Else If SameText(Fields[intCampos].FieldName, 'MOD_RELFR3') Then
        strValor := QuotedStr(UTF8ToString(RawByteString(Fields[intCampos].AsString)))

      Else If Fields[intCampos].IsNull Then
        strValor := '(NULL)'
      Else
        Case Fields[intCampos].DataType Of
          ftInteger: strValor := Fields[intCampos].AsString;
          ftFloat  : strValor := AnsiReplaceStr(Fields[intCampos].AsString, ',', '.');
          ftDate   : strValor := QuotedStr(FormatDateTime('YYYY-MM-DD', Fields[intCampos].Value));

          Else       strValor :=  QuotedStr(Fields[intCampos].AsString);
        End;


      If intCampos <> FieldCount - 1 Then
        stlScript.Add(strValor + ',')
      Else
        stlScript.Add(strValor);
    End;

    stlScript.Add(');');

    stlScript.Add('');
    stlScript.Add('');

  End;
End;

function TConvert.fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := False;

  qryAux := TUniQuery.Create(Nil);
  qryAux.Connection  := Database;
  qryAux.SQL.Add('DESC ' + strTabela);

  Try
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      If qryAux.FieldByName('Field').AsString = strCampo Then
      Begin
        Result := True;
        Break;
      End;

      qryAux.Next;
    End;

  Except On E: Exception Do

  End;

  FreeAndNil(qryAux);
end;

Procedure TConvert.pNutrindoRelatoriosVersoesDif;
begin
  // 72
  relsver72 := TStringList.Create;
  relsver72.Add('500466');

  // 74
  relsver74 := TStringList.Create;
  relsver74.Add('504247');
end;

Procedure TConvert.pTemRelOutraVersao;
Var
  intIndex, i: Integer;
  retorno : String;
begin

  if Not blnRelPadrao then
    Exit;

  retorno := '';

  for i := 0 to relsver72.Count -1 do
  begin
    intIndex := stlLista.IndexOf(relsver72[i]);

    if intIndex > -1 then
    begin
      retorno := retorno + relsver72[i] + '(72) = ' + relsver74[i] + '(74)' + #13#10;
    end;
  end;

  for i := 0 to relsver74.Count -1 do
  begin
    intIndex := stlLista.IndexOf(relsver74[i]);

    if intIndex > -1 then
    begin
      retorno := retorno + relsver74[i] + '(74) = ' + relsver72[i] + '(72)' + #13#10;
    end;
  end;

  if retorno <> '' then
  begin
    ShowMessage('Encontrados relatórios que estão em duas versões: ' + #13#10 + retorno);
  end;

end;

Procedure TConvert.pProcessaArrayCod;
var
  stlListBkp, stlListNov, stlListVal, stlListFin : TStringList;
  intContador, intIndex, intArray: Integer;
  codigo, precod, valida : String;
begin
  stlListNov := TStringList.Create;
  stlListVal := TStringList.Create;
  stlListFin := TStringList.Create;
  stlListBkp := stlLista;

  stlListaValida := TStringList.Create;

  with cdsCadRel do
  begin
    for intContador := 0 to stlListBkp.Count - 1 do
    begin
      if Locate('CODREL', stlLista[intContador], []) then
      begin
        codigo := FieldByName('CODREL').AsString;
        valida := FieldByName('CODVAL').AsString;
        precod := codigo.Substring(0, 1);

        if precod <> '5' then
        begin
          stlListNov.Add(stlLista[intContador]);
        end
        else
        begin
          stlListFin.Add(stlLista[intContador]);
        end;

        if valida <> '' then
        begin
          stlListVal.Add(valida);
          stlListaValida.Add(valida);
        end;

      end;
    end;
  end;

  for intContador := 0 to stlListVal.Count - 1 do
  begin
    If stlListNov.Find(stlListVal[intContador], intIndex) Then
    begin
      stlListNov.Delete(intIndex)
    end;

    If stlListFin.Find(stlListVal[intContador], intIndex) Then
    begin
      stlListFin.Delete(intIndex)
    end;
  end;

  SetLength(stlArray, 0);

  for intContador := 0 to stlListVal.Count - 1 do
  begin
    intArray := Length(stlArray);
    intArray := intArray + 1;

    SetLength(stlArray, intArray);
    stlArray[intArray - 1] := stlListVal[intContador];
  end;

  for intContador := 0 to stlListFin.Count - 1 do
  begin
    intArray := Length(stlArray);
    intArray := intArray + 1;

    SetLength(stlArray, intArray);
    stlArray[intArray - 1] := stlListFin[intContador];
  end;

  for intContador := 0 to stlListNov.Count - 1 do
  begin
    intArray := Length(stlArray);
    intArray := intArray + 1;

    SetLength(stlArray, intArray);
    stlArray[intArray - 1] := stlListNov[intContador];
  end;

end;

Function TConvert.fRetornaSalvaCadVal: Boolean;
Var
  intCont : Integer;
  cdsBkp : TUniClientDataSet;
Begin
  Result := False;

  cdsBkp := TUniClientDataSet.Create(Nil);
  cdsBkp.Data := cdsCadRel.Data;

  With cdsBkp Do
  Begin
    for intCont := 0 to stlLista.Count - 1 do
    Begin
      If Locate('CODREL', stlLista[intCont], []) Then
        if SameText(FieldByName('GRVVAL').AsString, 'S') then
          Result := True;
    End;
  End;

End;

end.




