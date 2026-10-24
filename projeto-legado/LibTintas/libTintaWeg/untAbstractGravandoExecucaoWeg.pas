{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Weg *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoWeg;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, Variants,  DBFUniProvider;

Type
  TColWeg = Record
    strCodCol:String;
    fltQtdCol:Double;
End;

Type
  TAbstractGravandoExecucaoWeg = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    tblProdutos: TUniQuery;
    tblSubprods: TUniQuery;
    tblFrm: TUniQuery;
    tblMask: TUniQuery;
    tblBases: TUniQuery;
    tblCnts: TUniQuery;

    qryWEG_CADBAS : IDataSet;
    qryWEG_CADCOL : IDataSet;
    qryWEG_CADEMB : IDataSet;
    qryWEG_CADNFM : IDataSet;
    qryWEG_CADWEG : IDataSet;

    DataDBFPro:  TUniConnection;
    DataDBFSubp: TUniConnection;
    DataDBFFrm:  TUniConnection;
    DataDBFMask: TUniConnection;
    DataDBFBase: TUniConnection;
    DataDBFCnts: TUniConnection;

    function fCalQtdEmb(fltQtdCol:Double; strEmbCon, strQtdEmb:String):Double;
    function fRetProximoCodSeq():Integer;
    function fRetUnidade(fltQtdEmb:Double):String;
    function fExisteEmbalagem(strIDEmb:String; fltQtdEmb:Double):Boolean;
    function fValidaCadBases():Boolean;
    function fValidaCadColorantes():Boolean;
    function fValidaCadEmbalagem():Boolean;
    function fValidaDiretorio(): Boolean;
    function GetPath(): String;
    function fGravarCadWeg(intCodSeq:Integer; strBase, strProKey, strSubKey, strDescri:String; arrColWeg: Array Of TColWeg; Gravando: IGravando): Boolean;
    function fGravarCadEmb(Gravando: IGravando): Boolean;
    function fGravarCadBas(strBase, strProKey, strSubKey, strDescri:String; Gravando: IGravando): Boolean;
    function fGravarCadCol(arrColWeg: Array Of TColWeg; Gravando: IGravando):Boolean;
    function fGravarCadNfm(qryNFM:IDataSet; Gravando:IGravando):Boolean;
    function fStrEspaco(Str:String; Tamanho:Integer; intPos:Integer = 1):String;
    function fConverteQtdEmb(fltQtd:Double; strUniOri, strUniNov:String):Double;


    procedure pCarregarProdutos(Gravando: IGravando);
    procedure pCarregarSubProdutos(strPathPro:String; Gravando: IGravando);
    procedure pCarregarMask(strPathSubprod:String; Gravando: IGravando);
    procedure pCarregarFrm(strPathPro, strPathSubprod:String; Gravando: IGravando);
    procedure pCarregarBases(Gravando: IGravando);
    procedure pCarregarCnts(Gravando: IGravando);
    procedure pAtualizarTabela();

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untFuncoesGenerica, untStatusGravando;

{ TGravandoExecucaoWegCores }

constructor TAbstractGravandoExecucaoWeg.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('WEG');

  //Query Cadastro de Bases
  qryWEG_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qryWEG_CADBAS.Close;
  qryWEG_CADBAS.SQL.Empty;
  qryWEG_CADBAS.SQL :=  '   SELECT * FROM WEG_CADBAS  ';
  qryWEG_CADBAS.Open;
  qryWEG_CADBAS.First;

  //Query Cadastro de Colorantes
  qryWEG_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qryWEG_CADCOL.Close;
  qryWEG_CADCOL.SQL.Empty;
  qryWEG_CADCOL.SQL := '    SELECT * FROM WEG_CADCOL   ';
  qryWEG_CADCOL.Open;
  qryWEG_CADCOL.First;

  //Query Cadastro de Embalagem
  qryWEG_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qryWEG_CADEMB.Close;
  qryWEG_CADEMB.SQL.Empty;
  qryWEG_CADEMB.SQL := '    SELECT * FROM WEG_CADEMB    ';
  qryWEG_CADEMB.Open;
  qryWEG_CADEMB.First;

  //Query Cadastro de Novas Fórmulas
  qryWEG_CADNFM := TAutcomTintaFactory.Get.fGetDataSet;
  qryWEG_CADNFM.Close;
  qryWEG_CADNFM.SQL.Empty;
  qryWEG_CADNFM.SQL := '    SELECT * FROM WEG_CADNFM   ';
  qryWEG_CADNFM.Open;
  qryWEG_CADNFM.First;

  //Query Cadastro de Fórmulas
  qryWEG_CADWEG := TAutcomTintaFactory.Get.fGetDataSet;
  qryWEG_CADWEG.Close;
  qryWEG_CADWEG.SQL.Empty;
  qryWEG_CADWEG.SQL := '    SELECT * FROM WEG_CADWEG    ';
  qryWEG_CADWEG.Open;
  qryWEG_CADWEG.First;

end;

destructor TAbstractGravandoExecucaoWeg.Destroy;
begin
  inherited;

  If Assigned(DataDBFPro) Then
    FreeAndNil(DataDBFPro);

  If Assigned(tblProdutos) Then
    FreeAndNil(tblProdutos);

  If Assigned(DataDBFSubp) Then
    FreeAndNil(DataDBFSubp);

  If Assigned(tblSubprods) Then
    FreeAndNil(tblSubprods);

  If Assigned(DataDBFMask) Then
    FreeAndNil(DataDBFMask);

  If Assigned(tblMask) Then
    FreeAndNil(tblMask);

  If Assigned(DataDBFFrm) Then
    FreeAndNil(DataDBFFrm);

  If Assigned(tblFrm) Then
    FreeAndNil(tblFrm);

  If Assigned(DataDBFBase) Then
    FreeAndNil(DataDBFBase);

  If Assigned(tblBases) Then
    FreeAndNil(tblBases);

  If Assigned(DataDBFCnts) Then
    FreeAndNil(DataDBFCnts);

  If Assigned(tblCnts) Then
    FreeAndNil(tblCnts);
end;

function TAbstractGravandoExecucaoWeg.fCalQtdEmb(fltQtdCol: Double; strEmbCon,
  strQtdEmb: String): Double;
Var
  fltEmbAtu: Double;
  fltEmbMas: Double;
begin

  qryWEG_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
    fltEmbAtu := qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryWEG_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
    fltEmbMas := qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

function TAbstractGravandoExecucaoWeg.fConverteQtdEmb(fltQtd: Double; strUniOri,
  strUniNov: String): Double;
Var
  qryGen: IDataSet;
  fltUniOri,
  fltUniNov:Double;
begin
  Try
    fltUniOri := 1;
    fltUniNov := 1;

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT * FROM WEG_CADEMB    ';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD', strUniOri, []) Then
      fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    If qryGen.Locate('EMB_UNIDAD', strUniNov, []) Then
      fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    Result := fltUniNov * fltQtd / fltUniOri;
  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoWeg.fExisteEmbalagem(strIDEmb: String;
  fltQtdEmb: Double): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Try
    qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
    qryConsulta.SQL.Empty;
    qryConsulta.SQL := '    SELECT EMB_CODEMB FROM WEG_CADEMB WHERE EMB_CODEMB = :EMBALAGEM     ';
    qryConsulta.SQL := qryConsulta.SQL + '    AND EMB_QTDEMB = :QUANTIDADE    ';
    qryConsulta.ParamByName('EMBALAGEM').AsString := TStrUtils.fStrZero(Trim(strIDEmb), 2);
    qryConsulta.ParamByName('QUANTIDADE').AsFloat := fltQtdEmb;
    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);
  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoWeg.fGravarCadBas(strBase, strProKey,
  strSubKey, strDescri: String; Gravando: IGravando): Boolean;
begin
  Result := True;

  If Not qryWEG_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBase, strProKey, strSubKey,
    qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryWEG_CADBAS.Insert;
    qryWEG_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryWEG_CADBAS.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryWEG_CADBAS.FieldByName('BAS_BASE__').AsString := strBase;
    qryWEG_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryWEG_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryWEG_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryWEG_CADBAS.FieldByName('BAS_DESCRI').AsString := strDescri;
    qryWEG_CADBAS.Post;
  End;

end;

function TAbstractGravandoExecucaoWeg.fGravarCadCol(arrColWeg: array of TColWeg;
  Gravando: IGravando): Boolean;
Var
  intContador: Integer;

  Function fRetornaDescricaoColorante(strColId:String):String;
  Begin
    Result := '';
    strColId := fStrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);
    If tblCnts.Locate('ID', strColId, []) Then
      Result := tblCnts.FieldByName('DESCR').AsString;
  End;
begin
  Result := True;

  For intContador := Low(arrColWeg) To High(arrColWeg) Do
  Begin
    qryWEG_CADCOL.First;

    If Not qryWEG_CADCOL.Locate('COL_CODCOL', VarArrayOf([arrColWeg[intContador].strCodCol]), []) Then
    Begin
      If Not TStrUtils.fEmptyStr(arrColWeg[intContador].strCodCol) Then
      Begin

        qryWEG_CADCOL.Insert;
        qryWEG_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
        qryWEG_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryWEG_CADCOL.FieldByName('COL_CODCOL').AsString := arrColWeg[intContador].strCodCol;
        qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescricaoColorante(arrColWeg[intContador].strCodCol);
        qryWEG_CADCOL.FieldByName('COL_EMBALA').AsFloat  := 3600;
        qryWEG_CADCOL.Post;
      End;
    End
    Else If TStrUtils.fEmptyStr(qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryWEG_CADCOL.Edit;
      qryWEG_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescricaoColorante(arrColWeg[intContador].strCodCol);
      qryWEG_CADCOL.Post;
    End;
  End;

end;

function TAbstractGravandoExecucaoWeg.fGravarCadEmb(
  Gravando: IGravando): Boolean;
Var
  tblCans: TUniQuery;
  DataCans: TUniConnection;
  intContador:Integer;
begin
  Result := True;

  pAtualizarTabela;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Excluindo cadastro de Embalagem inconsistente...';
  qryWEG_CADEMB.Close;
  qryWEG_CADEMB.SQL.Empty;
  qryWEG_CADEMB.SQL := '  DELETE FROM WEG_CADEMB    ';
  qryWEG_CADEMB.ExecSQL;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Processando Cadastro de Embalagem...';

  qryWEG_CADEMB.SQL.Empty;
  qryWEG_CADEMB.SQL := '    SELECT * FROM WEG_CADEMB WHERE FALSE    ';
  qryWEG_CADEMB.Open;
  qryWEG_CADEMB.First;

  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt := False;
  DataCans.Database := GetPath;

  If Not (DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  tblCans.Open;
  tblCans.First;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  For intContador := 1 To tblCans.RecordCount Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
    Begin
      qryWEG_CADEMB.Insert;
      qryWEG_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
      qryWEG_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryWEG_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
      qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
      qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(qryWEG_CADEMB.FieldByName('EMB_QTDEMB').AsFloat);
      qryWEG_CADEMB.Post;
    End;

    tblCans.Next;
    Gravando.RegistrarProgresso(0, tblCans.RecNo, tblCans.RecordCount);
  End;

  If Assigned(tblCans) Then
    FreeAndNil(tblCans);

  If Assigned(DataCans) Then
    FreeAndNil(DataCans);


end;

function TAbstractGravandoExecucaoWeg.fGravarCadNfm(qryNFM: IDataSet;
  Gravando: IGravando): Boolean;
Var
  intForm: Integer;
  qryDelNfm: IDataSet;
begin
  Result := True;

  If (Gravando.Status <> sgGravando) Then
  Begin
    Gravando.Texto := 'A geração de Novas Fórmulas foi cancelada pelo Usuario...';
    Exit;
  End;


  qryWEG_CADWEG.Close;
  qryWEG_CADWEG.SQL.Empty;
  qryWEG_CADWEG.SQL := '    SELECT * FROM WEG_CADWEG WHERE FALSE    ';
  qryWEG_CADWEG.Open;

  qryWEG_CADBAS.Close;
  qryWEG_CADBAS.SQL.Empty;
  qryWEG_CADBAS.SQL := '    SELECT * FROM WEG_CADBAS            ' +
                       '      INNER JOIN CADITE ON CADITE = BAS_CODITE   ' +
                       '    WHERE BAS_BASE__ = :BASE            ' +
                       '      AND BAS_PROKEY = :PROKEY AND               ' +
                       '    AND BAS_SUBKEY = :SUBKEY            ';

  qryWEG_CADBAS.ParamByName('BASE').AsString   := qryNFM.FieldByName('NFM_BASE__').AsString;
  qryWEG_CADBAS.ParamByName('PROKEY').AsString := qryNFM.FieldByName('NFM_PROKEY').AsString;
  qryWEG_CADBAS.ParamByName('SUBKEY').AsString := qryNFM.FieldByName('NFM_SUBKEY').AsString;

  qryDelNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelNfm.SQL := '    DELETE FROM WEG_CADWEG WHERE WEG_CODIGO = :CODIGO   ';
  qryDelNfm.ParamByName('CODIGO').AsString := qryNFM.FieldByName('NFM_CODPRO').AsString;
  qryDelNfm.ExecSQL;

  While Not qryWEG_CADBAS.Eof Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryWEG_CADWEG.Insert;
    qryWEG_CADWEG.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADWEG', TAutcomTintaFactory.Get.GetCodEmp);
    qryWEG_CADWEG.FieldByName('WEG_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString := qryNFM.FieldByName('NFM_DESCRI').AsString + ' ' + qryNFM.FieldByName('NFM_CODPRO').AsString;
    qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString := qryNFM.FieldByName('NFM_CODPRO').AsString;
    qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString := qryNFM.FieldByName('NFM_CODPRO').AsString;
    qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString := qryWEG_CADBAS.FieldByName('BAS_UNIDAD').AsString;
    qryWEG_CADWEG.FieldByName('WEG_CODITE').AsString := qryWEG_CADBAS.FieldByName('BAS_CODITE').AsString;
    qryWEG_CADWEG.FieldByName('WEG_NOMCOR').AsString := qryNFM.FieldByName('NFM_NOMCOR').AsString;
    qryWEG_CADWEG.FieldByName('WEG_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
    qryWEG_CADWEG.FieldByName('WEG_BASE__').AsString := qryNFM.FieldByName('NFM_BASE__').AsString;
    qryWEG_CADWEG.FieldByName('WEG_PROKEY').AsString := qryNFM.FieldByName('NFM_PROKEY').AsString;
    qryWEG_CADWEG.FieldByName('WEG_SUBKEY').AsString := qryNFM.FieldByName('NFM_SUBKEY').AsString;
    qryWEG_CADWEG.FieldByName('WEG_DTACAD').AsDate   := qryNFM.FieldByName('NFM_DTACAD').AsDate;

    For intForm := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(qryNFM.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intForm, 2)).AsString) Then
        Break;

      qryWEG_CADWEG.FieldByName('WEG_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString :=
        qryNFM.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intForm, 2)).AsString;

      qryWEG_CADWEG.FieldByName('WEG_QTDB' + TStrUtils.fStrZero(intForm,2)).AsFloat :=
        fConverteQtdEmb(qryNFM.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intForm, 2)).AsFloat,
          qryNFM.FieldByName('NFM_UNIDAD').AsString, qryWEG_CADBAS.FieldByName('BAS_UNIDAD').AsString);
    End;

    qryWEG_CADWEG.FieldByName('WEG_MD5KEY').AsString := GetMD5(qryWEG_CADWEG.FieldByName('WEG_BASE__').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_PROKEY').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_SUBKEY').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_NOMCOR').AsString);
    qryWEG_CADWEG.Post;
    qryWEG_CADBAS.Next;

  End;

end;

function TAbstractGravandoExecucaoWeg.fGravarCadWeg(intCodSeq: Integer; strBase,
  strProKey, strSubKey, strDescri: String;
  arrColWeg: array of TColWeg; Gravando: IGravando): Boolean;
Var
  intContador: Integer;
begin
  Result := True;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  If qryWEG_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBase, strProKey, strSubKey,
    qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin

    qryWEG_CADWEG.Insert;
    qryWEG_CADWEG.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADWEG', TAutcomTintaFactory.Get.GetCodEmp);
    qryWEG_CADWEG.FieldByName('WEG_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryWEG_CADWEG.FieldByName('WEG_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
    qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString := strDescri;
    qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
    qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
    qryWEG_CADWEG.FieldByName('WEG_NOMCOR').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY3').AsString);
    qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString := qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryWEG_CADWEG.FieldByName('WEG_BASE__').AsString := strBase;
    qryWEG_CADWEG.FieldByName('WEG_PROKEY').AsString := strProKey;
    qryWEG_CADWEG.FieldByName('WEG_SUBKEY').AsString := strSubKey;

    For intContador := Low(arrColWeg) To High(arrColWeg) Do
    Begin

      If TStrUtils.fEmptyStr(arrColWeg[intContador].strCodCol) Then
        Break;

      qryWEG_CADWEG.FieldByName('WEG_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString := ArrColWeg[intContador].strCodCol;
      qryWEG_CADWEG.FieldByName('WEG_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat  := ArrColWeg[intContador].fltQtdCol;
    End;

    qryWEG_CADWEG.FieldByName('WEG_MD5KEY').AsString := GetMD5(qryWEG_CADWEG.FieldByName('WEG_BASE__').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_UNIDAD').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_PROKEY').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_SUBKEY').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_DESCRI').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_CODIGO').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_CODIG2').AsString +
                                                               qryWEG_CADWEG.FieldByName('WEG_NOMCOR').AsString);

    qryWEG_CADWEG.Post;
  End;
end;

function TAbstractGravandoExecucaoWeg.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoWeg.fRetProximoCodSeq():Integer;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL.Empty;
    qryGen.SQL := '   SELECT WEG_CODSEQ FROM WEG_CADWEG ORDER BY WEG_CODSEQ DESC LIMIT 1;';
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('WEG_CODSEQ').AsInteger + 1;

  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoWeg.fRetUnidade(fltQtdEmb: Double): String;
begin
  If fltQtdEmb = 3600 Then
    Result := 'GL'
  Else If fltQtdEmb = 20000 Then
    Result := 'LA'
  Else
    Result := 'LT';
end;

function TAbstractGravandoExecucaoWeg.fStrEspaco(Str: String; Tamanho,
  intPos: Integer): String;
Var
  I: Integer;
begin
  Case intPos Of
    1: For I := Length(Str) To Tamanho - 1 Do
      Str := Str + ' ';
    2: For I := Length(Str) To Tamanho - 1 Do
      Str := ' ' + Str;
  End;

  Result := Str;
end;

function TAbstractGravandoExecucaoWeg.fValidaCadColorantes(): Boolean;
begin
  Result := (Not qryWEG_CADCOL.IsEmpty);
end;

function TAbstractGravandoExecucaoWeg.fValidaCadEmbalagem(): Boolean;
Var
  tblCans : TUniQuery;
  DataCans: TUniConnection;
  intCont,
  intErros: Integer;
begin
  intErros := 0;

  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt := False;
  DataCans.Database := GetPath;

  If (Not DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  tblCans.Open;
  tblCans.First;

  If Not qryWEG_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0 ) And
        Not (TStrUtils.fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryWEG_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
          Inc(intErros);
          Break;
        End
        Else If TStrUtils.fEmptyStr(qryWEG_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
        Begin
          Inc(intErros);
          Break;
        End;
      End;
      tblCans.Next;
    End;
  End
  Else
    Inc(intErros);

  Result := intErros = 0;

  //tblCans.Close;

  If Assigned(tblCans) Then
    FreeAndNil(tblCans);

  If Assigned(DataCans) Then
    FreeAndNil(DataCans);

end;

function TAbstractGravandoExecucaoWeg.fValidaCadBases(): Boolean;
begin
  Result := (Not qryWEG_CADBAS.IsEmpty);
end;

function TAbstractGravandoExecucaoWeg.fValidaDiretorio(): Boolean;
begin
  Result := True;
  If (Not FileExists(GetPath + '\PRODUCTS.DBF')) Then
    Result := False;
end;

function TAbstractGravandoExecucaoWeg.GetPath(): String;
begin
  Result := conf.fGet('PATWEG');
end;


procedure TAbstractGravandoExecucaoWeg.pAtualizarTabela();
begin

  qryWEG_CADBAS.Close; //Atualiza Cadastro de Bases.
  qryWEG_CADBAS.Open;

  qryWEG_CADCOL.Close; //Atualiza Cadastro de Colorantes.
  qryWEG_CADCOL.Open;

  qryWEG_CADEMB.Close; //Atualiza Cadastro de Embalagem.
  qryWEG_CADEMB.Open;

  qryWEG_CADNFM.Close; //Atualiza Cadastro de Novas Fórmulas.
  qryWEG_CADNFM.Open;

  qryWEG_CADWEG.Close; //Atualiza Cadastro de Fórmulas.
  qryWEG_CADWEG.Open
end;

procedure TAbstractGravandoExecucaoWeg.pCarregarBases(Gravando: IGravando);
begin
  DataDBFBase := TUniConnection.Create(Nil);
  DataDBFBase.ProviderName := 'DBF';
  DataDBFBase.LoginPrompt := False;
  DataDBFBase.Database := GetPath;

  If Not (DataDBFBase.Connected) Then
    DataDBFBase.Connected := True;

  tblBases := TUniQuery.Create(Nil);
  tblBases.Connection := DataDBFBase;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('    SELECT * FROM \BASES.DBF    ');
  tblBases.Open;
  tblBases.First;
end;

procedure TAbstractGravandoExecucaoWeg.pCarregarCnts(Gravando: IGravando);
begin
  DataDBFCnts := TUniConnection.Create(Nil);
  DataDBFCnts.ProviderName := 'DBF';
  DataDBFCnts.LoginPrompt := False;
  DataDBFCnts.Database := GetPath;

  If Not (DataDBFCnts.Connected) Then
    DataDBFCnts.Connected := True;

  tblCnts := TUniQuery.Create(Nil);
  tblCnts.Connection := DataDBFCnts;

  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('   SELECT * FROM \CNTS.DBF   ');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAbstractGravandoExecucaoWeg.pCarregarFrm(strPathPro,
  strPathSubprod: String; Gravando: IGravando);
Var
  strDBpath:String;
begin
  DataDBFFrm := TUniConnection.Create(Nil);
  DataDBFFrm.ProviderName := 'DBF';
  DataDBFFrm.LoginPrompt := False;

  If FileExists(strPathSubprod + '\FRM.DBF') Then
    strDBpath := strPathSubprod
  Else If FileExists(strPathPro + 'FRM.DBF') Then
    strDBpath := strPathPro
  Else
    strDBPath := GetPath;

  DataDBFFrm.Database := strDBpath;

  If Not (DataDBFFrm.Connected) Then
    DataDBFFrm.Connected := True;

  tblFrm := TUniQuery.Create(Nil);
  tblFrm.Connection := DataDBFFrm;

  tblFrm.Close;
  tblFrm.SQL.Clear;
  tblFrm.SQL.Add('    SELECT * FROM \FRM.DBF    ');

  Gravando.Texto := 'Carregando Subproduto. Aguarde...';
  tblFrm.Open;
  tblFrm.First;

end;

procedure TAbstractGravandoExecucaoWeg.pCarregarMask(strPathSubprod: String;
  Gravando: IGravando);
begin
  DataDBFMask := TUniConnection.Create(Nil);
  DataDBFMask.ProviderName := 'DBF';
  DataDBFMask.LoginPrompt := False;
  DataDBFMask.Database := strPathSubprod;

  If Not (DataDBFMask.Connected) Then
    DataDBFMask.Connected := True;

  tblMask := TUniQuery.Create(Nil);
  tblMask.Connection := DataDBFMask;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('   SELECT * FROM \MASK.DBF   ');
  tblMask.Open;
  tblMask.First;
end;

procedure TAbstractGravandoExecucaoWeg.pCarregarProdutos(Gravando: IGravando);
begin
  DataDBFPro := TUniConnection.Create(Nil);
  DataDBFPro.ProviderName := 'DBF';
  DataDBFPro.LoginPrompt := False;
  DataDBFPro.Database := GetPath;

  If Not (DataDBFPro.Connected) Then
    DataDBFPro.Connected := True;

  tblProdutos := TUniQuery.Create(Nil);
  tblProdutos.Connection := DataDBFPro;

  tblProdutos.Close;
  tblProdutos.SQL.Clear;
  tblProdutos.SQL.Add('   SELECT * FROM \PRODUCTS.DBF   ');
  tblProdutos.Open;
  tblProdutos.First;


end;

procedure TAbstractGravandoExecucaoWeg.pCarregarSubProdutos(strPathPro: String;
  Gravando: IGravando);
begin

  DataDBFSubp := TUniConnection.Create(Nil);
  DataDBFSubp.ProviderName := 'DBF';
  DataDBFSubp.LoginPrompt := False;
  DataDBFSubp.Database := strPathPro;

  If Not (DataDBFSubp.Connected) Then
    DataDBFSubp.Connected := True;

  tblSubprods := TUniQuery.Create(Nil);
  tblSubprods.Connection := DataDBFSubp;

  tblSubprods.Close;
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('   SELECT * FROM \SUBPRODS.DBF   ');
  tblSubprods.Open;
  tblSubprods.First;

end;

end.
