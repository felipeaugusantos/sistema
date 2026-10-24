{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lukscolor *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoLukscolor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, IdIcmpClient, StrUtils, Uni, ComObj, Variants, DBFUniProvider,
  untStatusGravando;

Type
  TColLkd = Record
  strCodCol: String;
  fltQtdCol: Double;
End;

type
  TipoIdIcmpClient = Class(TIdIcmpClient);
  TAbstractGravandoExecucaoLukscolor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    DataProducts: TUniConnection; //Excel
    DataSubProducts: TUniConnection;     //Excel
    DataFrm: TUniConnection;    //Excel
    DataMask: TUniConnection;   //Excel
    DataBase: TUniConnection;   //Excel

    tblProducts: TUniQuery; //Excel
    tblSubProds: TUniQuery; //Excel
    tblFrm: IDataSet; //Excel
    tblMask: TUniQuery; //Excel
    tblBases: TUniQuery; //Excel
    tblCnts : TUniQuery; //Excel

    ExcelFrm         : Variant; // Excel
    intMaxLinhaFrm   : Integer; // Excel
    intLinhaAtualFrm : Integer; // Excel

    qryLKD_CADBAS : IDataSet; //Excel
    qryLKD_CADCOL : IDataSet; //Excel
    qryLKD_CADEMB : IDataSet; //Excel
    qryLKD_CADLKD : IDataSet; //Excel
    qryLKD_CADNFM : IDataSet; //Excel
    intAutLkd     : Integer; //Excel

    conLukscolor: TADOConnection; // Access

    //Sistema Prisma(Access)
    function fVerificaIP(strPath:String): Boolean;
    function GetAdoLuksColor(strPath:String):TADOConnection;
    function fVerificaCadEmb(): Boolean;
    ////////////////////////////End;

    function fValidaPath : Boolean;
    function GetPath : String;


    //Excel Application
    function fDiretorioValido():Boolean;
    procedure pCarregarProducts();
    procedure pCarregarSubProducts(strPath:String);
    procedure pCarregarBase();
    procedure pCarregarFrm(strPathPro, strPathSub:String; Gravando: IGravando);
    procedure pCarregarMask(strPath: String);
    procedure pApagarTemporaria();
    procedure pPreencheTemporariaFRM(Gravando: IGravando);
    procedure pAtualizaTabelas();
    procedure pImportaCadastroEmbalagem(gravando: IGravando);
    function fVerificaCadEmbalagem(): Boolean;
    function fVerificaCadBases(): Boolean;
    function fVerificaCadColorantes(): Boolean;
    function fMaxLinha(Excel:Variant):Integer;
    function fRetProximoCodSeq():Integer;
    function fConverteQtdEmb(fltQtd:Double; strUniOri, strUniNov:String):Double;
    function fCalcQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb:String):Double;
    function fRetUnidade(fltQtd:Double):String;
    function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
    function fRetQtdEmbalagem(strUnidade, strEmbalagem:String):Double;

    function fGravaCadLkd(intCodSeq: Integer; strBasSe, strProKey, strSubKey:String; arrColLkd: Array of TColLkd; strDesTin:String): Boolean;
    function fGravaCadNfm(qryNfm: IDataSet; Gravando: IGravando):Boolean;
    procedure pGravaCadCol(arrColLkd: Array of TColLkd);
    procedure pGravaCadBas(strBasSe, strProKey, strSubKey, strDesTin, strEmbalagem:String);
     /////////////////////////////////////////////End;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;



implementation

uses
  untAutcomTintaFactory, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoLukscolorCores }


constructor TAbstractGravandoExecucaoLukscolor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LKS');

  intAutLkd := 1;

  qryLKD_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qryLKD_CADBAS.SQL := '    SELECT * FROM LKD_CADBAS    ';
  qryLKD_CADBAS.Open;

  qryLKD_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qryLKD_CADCOL.SQL := '    SELECT * FROM LKD_CADCOL    ';
  qryLKD_CADCOL.Open;

  qryLKD_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qryLKD_CADEMB.SQL := '    SELECT * FROM LKD_CADEMB    ';
  qryLKD_CADEMB.Open;

  qryLKD_CADNFM := TAutcomTintaFactory.Get.fGetDataSet;
  qryLKD_CADNFM.SQL := '    SELECT * FROM LKD_CADNFM    ';
  qryLKD_CADNFM.Open;

  qryLKD_CADLKD := TAutcomTintaFactory.Get.fGetDataSet;
  qryLKD_CADLKD.SQL := '    SELECT * FROM LKD_CADLKD    ';
  qryLKD_CADLKD.Open;

end;

destructor TAbstractGravandoExecucaoLukscolor.Destroy;
begin
  inherited;
  If Assigned(tblProducts) Then
    FreeAndNil(tblProducts);

  If Assigned(tblSubProds) Then
    FreeAndNil(tblSubProds);

  If Assigned(tblMask) Then
    FreeAndNil(tblMask);

  If Assigned(tblBases) Then
    FreeAndNil(tblBases);

  If Assigned(tblCnts) Then
    FreeAndNil(tblCnts);

  If Assigned(DataProducts) Then
    FreeAndNil(DataProducts);

  If Assigned(DataSubProducts) Then
    FreeAndNil(DataSubProducts);

  If Assigned(DataFrm) Then
    FreeAndNil(DataFrm);

  If Assigned(DataMask) Then
    FreeAndNil(DataMask);

  If Assigned(DataBase) Then
    FreeAndNil(DataBase);

  pApagarTemporaria;
end;

function TAbstractGravandoExecucaoLukscolor.fCalcQtdEmb(fltQtdCol: Double;
  strEmbCon, strQtdEmb: String): Double;
var
  fltEmbAtu,
  fltEmbMas:Double;
begin

  qryLKD_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
    fltEmbAtu := qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryLKD_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
    fltEmbMas := qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

function TAbstractGravandoExecucaoLukscolor.fConverteQtdEmb(fltQtd: Double;
  strUniOri, strUniNov: String): Double;
var
  qryGen: IDataSet;
  fltUniNov,
  fltUniOri:Double;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT * FROM LKD_CADEMB    ';
    qryGen.Open;

    qryGen.Locate('EMB_UNIDAD', strUniOri, []);
    fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    qryGen.Locate('EMB_UNIDAD', strUniNov, []);
    fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    Result := fltUniNov * fltQtd / fltUniOri;

  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoLukscolor.fDiretorioValido: Boolean;
begin
  Result := FileExists(GetPath + '\PRODUCTS.DBF');
end;

function TAbstractGravandoExecucaoLukscolor.fGravaCadLkd(intCodSeq: Integer;
  strBasSe, strProKey, strSubKey: String; arrColLkd: array of TColLkd;
  strDesTin: String): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  If (qryLKD_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
    VarArrayOf([strBasSe, strProKey, strSubKey, qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString]),  [])) Then
  Begin
    If (qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString <> strDesTin) or
       (qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) or
       (qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) or
       (qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString <> qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString) or
       qryLKD_CADLKD.IsEmpty Then
    Begin
      qryLKD_CADLKD.Insert;
      qryLKD_CADLKD.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADLKD', TAutcomTintaFactory.Get.GetCodEmp);
      qryLKD_CADLKD.FieldByName('LKD_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryLKD_CADLKD.FieldByName('LKD_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
      qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString := strDesTin;
      qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString := AnsiUpperCase(tblFrm.FieldByName('KEY2').AsString);
      qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString := qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryLKD_CADLKD.FieldByName('LKD_BASE__').AsString := qryLKD_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryLKD_CADLKD.FieldByName('LKD_PROKEY').AsString := qryLKD_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryLKD_CADLKD.FieldByName('LKD_SUBKEY').AsString := qryLKD_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      For intCont := Low(arrColLkd) To High(arrColLkd) Do
      Begin

        If TStrUtils.fEmptyStr(arrColLkd[intCont].strCodCol) Then
          Break;

        qryLKD_CADLKD.FieldByName('LKD_FORM' + TStrUtils.fStrZero(intCont + 1, 2)).AsString := arrColLkd[intCont].strCodCol;
        qryLKD_CADLKD.FieldByName('LKD_QTDB' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloat  := arrColLkd[intCont].fltQtdCol;
      End;

      qryLKD_CADLKD.FieldByName('LKD_MD5KEY').AsString := GetMd5(qryLKD_CADLKD.FieldByName('LKD_DESCRI').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_BASE__').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_CODIGO').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_CODIG2').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_PROKEY').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_UNIDAD').AsString +
                                                                 qryLKD_CADLKD.FieldByName('LKD_SUBKEY').AsString);

      qryLKD_CADLKD.Post;
      Result := True;
    End;
  End;
end;

function TAbstractGravandoExecucaoLukscolor.fGravaCadNfm(
  qryNfm: IDataSet; Gravando: IGravando): Boolean;
var
  intContador: Integer;
  qryBases,
  qryCadLkd: IDataSet;
begin
  qryCadLkd := TAutcomTintaFactory.Get.fGetDataSet;



  qryCadLkd.SQL := 'DELETE FROM LKD_CADLKD WHERE LKD_CODIGO = ' + QuotedStr(qryNfm.FieldByName('NFM_CODPRO').AsString);
  qryCadLkd.ExecSQL;
  qryCadLkd.SQL.Empty;
  qryCadLkd.SQL := '    SELECT * FROM LKD_CADLKD WHERE FALSE    ';
  qryCadLkd.Open;

  qryBases  := TAutcomTintaFactory.Get.fGetDataSet;



  qryBases.SQL  := '    SELECT * FROM LKD_CADBAS WHERE  ' +
                   '      BAS_BASE__ = :BASE AND        ' +
                   '      BAS_PROKEY = :PKEY            ' ;

  qryBases.ParamByName('BASE').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
  qryBases.ParamByName('PKEY').AsString := qryNfm.FieldByName('NFM_PROKEY').AsString;
  qryBases.Open;

  While Not qryBases.Eof Do
  Begin
    qryCadLkd.Insert;
    qryCadLkd.FieldByName('LKD_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_CODIGO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_CODIG2').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadLkd.FieldByName('LKD_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
    qryCadLkd.FieldByName('LKD_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadLkd.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADLKD', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadLkd.FieldByName('LKD_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
    qryCadLkd.FieldByName('LKD_BASE__').AsString := qryBases.FieldByName('BAS_BASE__').AsString;
    qryCadLkd.FieldByName('LKD_PROKEY').AsString := qryBases.FieldByName('BAS_PROKEY').AsString;
    qryCadLkd.FieldByName('LKD_SUBKEY').AsString := qryBases.FieldByName('BAS_SUBKEY').AsString;
    qryCadLkd.FieldByName('LKD_DTACAD').AsDate   := qryNfm.FieldByName('NFM_DTACAD').AsDate;

    For intContador := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      qryCadLkd.FieldByName('LKD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
        qryNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString;

      qryCadLkd.FieldByName('LKD_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
        fConverteQtdEmb(qryNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intContador, 2)).AsFloat,
                        qryNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.FieldByName('BAS_UNIDAD').AsString);
    End;

    qryCadLkd.FieldByName('LKD_MD5KEY').AsString := GetMD5(qryCadLkd.FieldByName('LKD_DESCRI').AsString +
                                                           qryCadLkd.FieldByName('LKD_BASE__').AsString +
                                                           qryCadLkd.FieldByName('LKD_CODIGO').AsString +
                                                           qryCadLkd.FieldByName('LKD_CODIG2').AsString +
                                                           qryCadLkd.FieldByName('LKD_PROKEY').AsString +
                                                           qryCadLkd.FieldByName('LKD_UNIDAD').AsString +
                                                           qryCadLkd.FieldByName('LKD_SUBKEY').AsString);

    qryCadLkd.Post;
    qryBases.Next;
  End;

  If qryLKD_CADNFM.Eof Then
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso...';

  Result := True;
end;

function TAbstractGravandoExecucaoLukscolor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoLukscolor.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

function TAbstractGravandoExecucaoLukscolor.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT LKD_CODSEQ AS CODSEQ FROM LKD_CADLKD ORDER BY LKD_CODSEQ DESC LIMIT 1 ';
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGeN.FieldByName('CODSEQ').AsInteger + 1;

  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoLukscolor.fRetQtdEmbalagem(
  strUnidade, strEmbalagem: String): Double;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_QTDEMB FROM LKD_CADEMB WHERE EMB_UNIDAD = :UNIDADE AND EMB_CODEMB = :EMBALAGEM   ';
  qryGen.ParamByName('UNIDADE').AsString := strUnidade;
  qryGen.ParamByName('EMBALAGEM').AsString := strEmbalagem;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_QTDEMB').AsFloat;
end;

function TAbstractGravandoExecucaoLukscolor.fRetUnidade(fltQtd: Double): String;
begin
 Result := '';
  If fltQtd <= 1000 Then
    Result := 'LT'
  Else If fltQtd <= 4000 Then
    Result := 'GL'
  Else If fltQtd > 4001 Then
    Result := 'LA';
end;

function TAbstractGravandoExecucaoLukscolor.fstrEspaco(Str: String; Tamanho,
  intPos: Integer): String;
Var
	I:integer;
Begin
  Case intPos Of
  	1:For I := Length(Str) To Tamanho -1 Do
		  	Str:= Str + ' ';
    2:For I := Length(Str) To Tamanho -1 Do
    		Str := ' ' + Str;
  End;
  fStrEspaco := Str;
end;

function TAbstractGravandoExecucaoLukscolor.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoLukscolor.fVerificaCadBases: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryLKD_CADBAS.IsEmpty);
end;

function TAbstractGravandoExecucaoLukscolor.fVerificaCadColorantes: Boolean;
begin
  pAtualizaTabelas;
  Result := (Not qryLKD_CADCOL.IsEmpty);
end;

function TAbstractGravandoExecucaoLukscolor.fVerificaCadEmb: Boolean;
var
  qryCadEmb: IDataSet;
begin
  Try
    qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
    qryCadEmb.SQL := '    SELECT * FROM LKD_CADEMB              '    +
                     '      WHERE EMB_UNIDAD IS NULL  OR        '    +
                     '    EMB_UNIDAD = ""                       ' ;
    qryCadEmb.Open;

    Result := qryCadEmb.RecordCount > 0;
  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoLukscolor.fVerificaCadEmbalagem(): Boolean;
var
  tblCans: TUniQuery;
  DataCans: TUniConnection;
  intCont, intErros: Integer;
begin
  intErros := 0;

  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt := False;
  DataCans.Database := GetPath;

  If Not (DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  //SQL
  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF');
  tblCans.Open;
  tblCans.First;




  If Not qryLKD_CADEMB.IsEmpty Then
  Begin
    For intCont := 1 To tblCans.RecordCount Do
    Begin
      If Not qryLKD_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
      Begin
        Inc(intErros);
        Break;
      End
      Else If TStrUtils.fEmptyStr(qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
      Begin
        Inc(intErros);
        Break;
      End;
      tblCans.Next;
    End;
  End
  Else
    Inc(intErros);

  Result := intErros = 0;
  tblCans.Close;

  If Assigned(tblCans) Then
    FreeAndNil(tblCans);

  If Assigned(DataCans) Then
    FreeAndNil(DataCans);
end;

function TAbstractGravandoExecucaoLukscolor.fVerificaIP(
  strPath: String): Boolean;
var
  IPTesta: TipoIdIcmpClient;
  strIp : String;
  intPos: Integer;
begin
  If Copy(strPath, 1 , 2) = '\\' Then
  Begin
    intPos := PosEx('\', strPath, 3);
    strIp  := Copy(strPath, 3, intPos - 3);

    IPTesta := TipoIdIcmpClient.Create(Nil);
    IPTesta.Host := strIp;
    Try
      IPTesta.ReceiveTimeout := 5000;
      IPTesta.Ping();
    Except
    End;

    Case IPTesta.ReplyStatus.ReplyStatusType Of
      rsError: Result := False;
      rsErrorTTLExceeded: Result := False;
      rsErrorUnreachable: Result := False;
      rsTimeout: Result := False;
    Else
      Result := True;
    End;

    If (Result) Then
    Begin
      Result := FileExists(strPath);

      If Not Result Then
        Result := DirectoryExists(strPath);
    End;

    FreeAndNil(IPTesta);

  End
  Else
  Begin
    Result := FileExists(strPath);

    If Not Result Then
      Result := DirectoryExists(strPath);
  End;
end;

function TAbstractGravandoExecucaoLukscolor.GetAdoLuksColor(
  strPath: String): TADOConnection;
begin
  If Not Assigned(conLukscolor) Then
  Begin
    conLukscolor := TADOConnection.Create(Nil);
    conLukscolor.LoginPrompt := False;
    conLukscolor.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + strPath +
    ';Persist Security Info=True';

  End;

  Result := conLukscolor;
end;

function TAbstractGravandoExecucaoLukscolor.GetPath: String;
begin
  If conf.fGet('LKSPRI') = 'S' Then
    Result := conf.fGet('PATPRI')
  Else
    Result := conf.fGet('PATLKS');
end;


procedure TAbstractGravandoExecucaoLukscolor.pApagarTemporaria;
begin
  TAutcomTintaFactory.Get.DropTable('TMP_GERFRM');
  TAutcomTintaFactory.Get.DropTable('TMP_MD5KEY');
end;

procedure TAbstractGravandoExecucaoLukscolor.pAtualizaTabelas;
begin
  qryLKD_CADBAS.Close;
  qryLKD_CADCOL.Close;
  qryLKD_CADEMB.Close;
 // qryLKD_CADLKD.Close;
  qryLKD_CADNFM.Close;

  qryLKD_CADBAS.Open;
  qryLKD_CADCOL.Open;
  qryLKD_CADEMB.Open;
//  qryLKD_CADLKD.Open;
  qryLKD_CADNFM.Open;
end;

procedure TAbstractGravandoExecucaoLukscolor.pCarregarBase;
begin
  DataBase := TUniConnection.Create(Nil);
  DataBase.ProviderName := 'DBF';
  DataBase.LoginPrompt := False;
  DataBase.Database := GetPath;

  If Not (DataBase.Connected) Then
    DataBase.Connected := True;

  tblBases := TUniQuery.Create(Nil);
  tblBases.Connection := DataBase;

  //SQL
  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('    SELECT * FROM \BASES.DBF    ');
  tblBases.Open;
  tblBases.First;

  tblCnts := TUniQuery.Create(Nil);
  tblCnts.Connection := DataBase;

  //SQL
  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('    SELECT * FROM \CNTS.DBF    ');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAbstractGravandoExecucaoLukscolor.pCarregarFrm(strPathPro,
  strPathSub: String; Gravando: IGravando);
var
  strPath: String;
begin
  pApagarTemporaria;

  If FileExists(strPathSub + '\FRM.DBF') Then
    strPath := strPathSub
  Else If FileExists(strPathPro + '\FRM.DBF') Then
    strPath := strPathPro
  Else
    strPath := GetPath;

  Try
    ExcelFrm := CreateOleObject('Excel.Application');
    ExcelFrm.Visible := False;
    ExcelFrm.WorkBooks.Add(strPath + '\FRM.DBF');

    intMaxLinhaFrm := fMaxLinha(ExcelFrm);
    intLinhaAtualFrm := 2;



    pPreencheTemporariaFRM(Gravando);
    Gravando.RegistrarProgresso(0, 0, 0);

    tblFrm := TAutcomTintaFactory.Get.fGetDataSet;
    tblFrm.SQL.Empty;
    tblFrm.SQL := '   SELECT * FROM TMP_GERFRM    ';
    tblFrm.Open;

  Finally
    ExcelFrm.WorkBooks.Close;
  End;

end;

procedure TAbstractGravandoExecucaoLukscolor.pCarregarMask(strPath: String);
begin
  DataMask := TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt := False;
  DataMask.Database := strPath;

  If Not (DataMask.Connected) Then
    DataMask.Connected := True;


  tblMask := TUniQuery.Create(Nil);
  tblMask.Connection := DataMask;

  //SQL
  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add(' SELECT * FROM \MASK.DBF ');
  tblMask.Open;
  tblMask.First;
end;

procedure TAbstractGravandoExecucaoLukscolor.pCarregarProducts;
begin
  DataProducts := TUniConnection.Create(Nil);
  DataProducts.ProviderName := 'DBF';
  DataProducts.LoginPrompt := False;
  DataProducts.Database := GetPath;

  If Not (DataProducts.Connected) Then
    DataProducts.Connected := True;

  tblProducts := TUniQuery.Create(Nil);
  tblProducts.Connection := DataProducts;

  //SQL
  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('   SELECT * FROM \PRODUCTS.DBF   ');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAbstractGravandoExecucaoLukscolor.pCarregarSubProducts(
  strPath: String);
begin
  DataSubProducts := TUniConnection.Create(Nil);
  DataSubProducts.ProviderName := 'DBF';
  DataSubProducts.LoginPrompt := False;
  DataSubProducts.Database := strPath;

  If Not (DataSubProducts.Connected) Then
    DataSubProducts.Connected := True;

  tblSubProds := TUniQuery.Create(Nil);
  tblSubProds.Connection := DataSubProducts;

  //SQL
  tblSubProds.Close;
  tblSubProds.SQL.Clear;
  tblSubProds.SQL.Add('   SELECT * FROM \SUBPRODS.DBF   ');
  tblSubProds.Open;
  tblSubProds.First;
end;

procedure TAbstractGravandoExecucaoLukscolor.pGravaCadBas(strBasSe, strProKey,
  strSubKey, strDesTin, strEmbalagem: String);
begin
  If Not qryLKD_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBasSe, strProKey, strSubKey,
    qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    qryLKD_CADBAS.Insert;
    qryLKD_CADBAS.FieldByName('BAS_BASE__').AsString := strBasSe;
    qryLKD_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryLKD_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryLKD_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryLKD_CADBAS.FieldByName('BAS_QTDEMB').AsFloat  := fRetQtdEmbalagem(qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString, strEmbalagem);
    qryLKD_CADBAS.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryLKD_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryLKD_CADBAS.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  End;
end;

procedure TAbstractGravandoExecucaoLukscolor.pGravaCadCol(
  arrColLkd: array of TColLkd);
var
  intContador: Integer;

  Function fRetornaDescColorante(strColId:String):String;
  Begin
    Result := '';
    strColId := fstrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);
    If tblCnts.Locate('ID', strColId, []) Then
      Result := tblCnts.FieldByName('DESCR').AsString;
  End;

begin
  For intContador := Low(arrColLkd) To High(arrColLkd) Do
  Begin
    qryLKD_CADCOL.First;
    If Not qryLKD_CADCOL.Locate('COL_CODCOL', arrColLkd[intContador].strCodCol, []) Then
    Begin

      If TStrUtils.fEmptyStr(arrColLkd[intContador].strCodCol) Then
        Break;

      qryLKD_CADCOL.Insert;
      qryLKD_CADCOL.FieldByName('COL_CODCOL').AsString := arrColLkd[intContador].strCodCol;
      qryLKD_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryLKD_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColLkd[intContador].strCodCol);
      qryLKD_CADCOL.FieldByName('COL_EMBALA').AsFloat  := 1000;
      qryLKD_CADCOL.Post;
    End
    Else If TStrUtils.fEmptyStr(qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryLKD_CADCOL.Edit;
      qryLKD_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColLkd[intContador].strCodCol);
      qryLKD_CADCOL.Post;
    End;
  End;
end;

procedure TAbstractGravandoExecucaoLukscolor.pImportaCadastroEmbalagem(gravando: IGravando);
var
  DataCans: TUniConnection;
  tblCans: TUniQuery;
begin
  pAtualizaTabelas;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagens...';

  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt := False;
  DataCans.Database := GetPath;

  If Not (DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  //SQL
  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  tblCans.Open;
  tblCans.First;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('LKD_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := Format('Processando Cadastro de Embalagens[%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    While Not tblCans.Eof Do
    Begin
      qryLKD_CADEMB.Insert;
      qryLKD_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
      qryLKD_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
      qryLKD_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
      qryLKD_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryLKD_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
      qryLKD_CADEMB.Post;
      tblCans.Next;
      Gravando.RegistrarProgresso(0, tblCans.RecNo, tblCans.RecordCount);
    End;
  Finally
    Gravando.Texto := 'O cadastro de Embalagens foi importado...'
  End;



  tblCans.Close;

  If Assigned(tblCans) Then
    FreeAndNil(tblCans);

  If Assigned(DataCans) Then
    FreeAndNil(DataCans);
end;


procedure TAbstractGravandoExecucaoLukscolor.pPreencheTemporariaFRM(Gravando: IGravando);
var
  qryFrm : IDataSet;
  intTemporaria: Integer;
begin
  qryFrm := TAutcomTintaFactory.Get.fGetDataSet;

  TAutcomTintaFactory.Get.DropTable('TMP_GERFRM');

  qryFrm.SQL := ' CREATE TABLE TMP_GERFRM         ' +
                ' (                               ' +
                ' BASE_ID CHAR(02),               ' +
                ' CAN_ID  CHAR(02),               ' +
                ' FORMULA VARCHAR(100),           ' +
                ' KEY1    VARCHAR(100),           ' +
                ' KEY2    VARCHAR(100),           ' +
                ' COMMENT VARCHAR(255)            ' +
                '   )                             ';

  qryFrm.ExecSQL;

  qryFrm.SQL.Empty;
  qryFrm.SQL := '   SELECT * FROM TMP_GERFRM    ';
  qryFrm.Open;

  Gravando.Texto := 'Carregando Subproduto. Aguarde...';

  For intTemporaria := 1 To intMaxLinhaFrm Do
  Begin
    qryFrm.Insert;

    qryFrm.FieldByName('BASE_ID').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 8].Text;
    qryFrm.FieldByName('CAN_ID').AsString  := ExcelFrm.Cells.Item[intLinhaAtualFrm, 9].Text;
    qryFrm.FieldByName('FORMULA').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 11].Text;
    qryFrm.FieldByName('KEY1').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm, 3].Text;
    qryFrm.FieldByName('KEY2').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm, 4].Text;
    qryFrm.FieldByName('COMMENT').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 27].Text;
    qryFrm.Post;

    intLinhaAtualFrm := intLinhaAtualFrm + 1;
    Gravando.RegistrarProgresso(0, intTemporaria, intMaxLinhaFrm);
  End;

end;

end.
