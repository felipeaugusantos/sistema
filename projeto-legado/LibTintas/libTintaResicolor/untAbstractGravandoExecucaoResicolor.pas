{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Resicolor *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoResicolor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, ComObj, Variants, untStatusGravando, DBFUniProvider, UniClientDataSet, StrUtils,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms;

Type
  TColRsi = Record
  strCodCol: String;
  fltQtdCol: Double;
End;


Type
  TAbstractGravandoExecucaoResicolor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    //Conexões
    DataProducts: TUniConnection;
    DataSubProds: TUniConnection;
    //DataFrm     : TUniConnection;
    DataMask    : TUniConnection;
    DataBases   : TUniConnection;
    DataCnts    : TUniConnection;
    DataRuler   : TUniConnection;
    blnQtdRgt   : Boolean;
    cdsCadBas   : TUniClientDataSet;
    cdsCadRuler : TUniClientDataSet;

    ExcelFrm : Variant;

    intMaxLinhaFrm,
    intLinhaAtualFrm,
    intAutRsi : Integer;

    //Querys Origem
    tblProducts: TUniQuery;
    tblSubProds: TUniQuery;
    tblMask    : TUniQuery;
    tblBases   : TUniQuery;
    tblCnts    : TUniQuery;
    tblRuler   : TUniQuery;
    //tblFrm     : TUniQuery;
    qryFrm      : IDataSet;
    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;
    qryConf: TUniQuery;

    //Querys Destino
    qryRSI_CADBAS: IDataSet;
    qryRSI_CADCOL: IDataSet;
    qryRSI_CADEMB: IDataSet;
    qryRSI_CADNFM: IDataSet;
    qryRSI_CADRSI: IDataSet;




    //Procedures Gerações
    procedure pPreparaConexaoFireDac();
    procedure pPreencheQryCadBas;
    procedure pCarregarProdutos();
    procedure pCarregarSubProdutos(StrPath: String);
    procedure pCarregarFrm(strPath1, strPath2:String; Gravando : IGravando);
    procedure pCarregarMask(strPath: String);
    procedure pCarregarBases();
    procedure pCarregarRuler(strPath:String);
    procedure pGravaCadastroColorantes(arrColRsi : Array of TColRsi; Gravando: IGravando);
    procedure pImportarCadastroEmbalagem(Gravando : IGravando);
    procedure pGravarCadastroBases(strBase:String; strProKey:String; strSubKey:String; strDescri:String; Gravando: IGravando);
    function fGravarCadastroResicolor(intCodSeq:Integer; strBase:String; strproKey:String; strSubKey:String;
    arrColRsi: Array Of TColRsi; strDescri:String; strCodEmb: String; strKey2: String; Gravando: IGravando; strEmbArq: String): String;
    procedure pPreencheTemporariaFRM(const gravando: IGravando);
    procedure pPreencherRuler();
    procedure pApagandoTemporarias;



    //Funções Gerações
    function fMaxLinha(Excel:Variant):Integer;
    function fCalQtdEmb(fltQtdCol:Double; strEmbCon, strQtdEmb:String): Double;
    function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
    function fRetornaCodSeq():Integer;
    function fRetornaQtdEmbalagem(strEmbalagem:String):Double;
    function fVerificaCadastroEmbalagem():Boolean;
    function fRetUnidade(fltQtd:Double):String;
    function fVerificaCadastroBases():Boolean;
    function fVerificaCadastroColorante():Boolean;
    function fRetUnidadeEmbalagem(strCodEmb: String): String;

    //NovasFormulas
    function fGravarNovasFormulas(qryNovasFormulas: IDataSet; Gravando: IGravando):Boolean;
    function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
    procedure pVerificaBase();


    function fValidaPath(): Boolean;
    function GetPath(): String;
    function GetPathPro(): String;

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

{ TGravandoExecucaoResicolorCores }

constructor TAbstractGravandoExecucaoResicolor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('RSI');

  DataProducts := TUniConnection.Create(Nil);
  DataProducts.ProviderName := 'DBF';
  DataProducts.LoginPrompt := False;
  tblProducts := TUniQuery.Create(Nil);


  DataBases := TUniConnection.Create(Nil);
  DataBases.ProviderName := 'DBF';
  DataBases.LoginPrompt := False;
  tblBases := TUniQuery.Create(Nil);
  tblCnts := TUniQuery.Create(Nil);

  DataSubProds := TUniConnection.Create(Nil);
  DataSubProds.ProviderName := 'DBF';
  DataSubProds.LoginPrompt := False;
  tblSubProds := TUniQuery.Create(Nil);

  DataRuler := TUniConnection.Create(Nil);
  DataRuler.ProviderName := 'DBF';
  DataRuler.LoginPrompt := False;
  tblRuler := TUniQuery.Create(Nil);

  DataMask := TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt := False;
  tblMask := TUniQuery.Create(Nil);

  //tblFrm  := TAutcomTintaFactory.Get.fCriaQuery;
  //DataFrm := TUniConnection.Create(Nil);
  //DataFrm.ProviderName := 'DBF';
  //DataFrm.LoginPrompt := False;

  qryRSI_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qryRSI_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qryRSI_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qryRSI_CADNFM := TAutcomTintaFactory.Get.fGetDataSet;
  qryRSI_CADRSI := TAutcomTintaFactory.Get.fGetDataSet;

  qryRSI_CADBAS.SQL := '    SELECT * FROM RSI_CADBAS    ';
  qryRSI_CADCOL.SQL := '    SELECT * FROM RSI_CADCOL    ';
  qryRSI_CADEMB.SQL := '    SELECT * FROM RSI_CADEMB    ';
  qryRSI_CADNFM.SQL := '    SELECT * FROM RSI_CADNFM    ';
  qryRSI_CADRSI.SQL := '    SELECT * FROM RSI_CADRSI WHERE FALSE   ';

  qryRSI_CADBAS.Open;
  qryRSI_CADCOL.Open;
  qryRSI_CADEMB.Open;
  qryRSI_CADNFM.Open;
  qryRSI_CADRSI.Open;

  qryFrm := TAutcomTintaFactory.Get.fGetDataSet;

  cdsCadRuler := TUniClientDataSet.Create(Nil);

  cdsCadRuler.FieldDefs.AddFieldDef;
  cdsCadRuler.FieldDefs[0].DataType := ftString;
  cdsCadRuler.FieldDefs[0].Name := 'ID';
  cdsCadRuler.FieldDefs[0].Size := 1;

  cdsCadRuler.FieldDefs.AddFieldDef;
  cdsCadRuler.FieldDefs[1].DataType := ftString;
  cdsCadRuler.FieldDefs[1].Name := 'RULE';
  cdsCadRuler.FieldDefs[1].Size := 12;
  cdsCadRuler.CreateDataSet;

  pPreparaConexaoFireDac();
end;

destructor TAbstractGravandoExecucaoResicolor.Destroy;
begin
  inherited;

  FreeAndNil(tblProducts);
  FreeAndNil(tblSubProds);
  FreeAndNil(tblMask);
  FreeAndNil(tblBases);
  FreeAndNil(tblBases);
  FreeAndNil(tblCnts);
  FreeAndNil(tblRuler);
  FreeAndNil(cdsCadBas);
  FreeAndNil(cdsCadRuler);

  If Assigned(DataProducts) Then
    FreeAndNil(DataProducts);

  If Assigned(DataSubProds) Then
    FreeAndNil(DataSubProds);

  If Assigned(DataMask) Then
    FreeAndNil(DataMask);

  If Assigned(DataBases) Then
    FreeAndNil(DataBases);

  If Assigned(DataCnts) Then
    FreeAndNil(DataCnts);

  If Assigned(DataRuler) Then
    FreeAndNil(DataRuler);

  FreeAndNil(FDDatabase);
  FreeAndNil(FDCursor);
  FreeAndNil(FDDriverLink);
end;

function TAbstractGravandoExecucaoResicolor.fCalQtdEmb(fltQtdCol: Double;
  strEmbCon, strQtdEmb: String): Double;
Var
  fltEmbAtu : Double;
  fltEmbMas : Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryRSI_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryRSI_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

function TAbstractGravandoExecucaoResicolor.fConverteQtdEmb(fltQtd: Double;
  strUniOri, strUniNov: String): Double;
Var
  qryGen: IDataSet;
  fltUniOri: Double;
  fltUniNov: Double;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT * FROM RSI_CADEMB';
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

function TAbstractGravandoExecucaoResicolor.fGravarNovasFormulas(
  qryNovasFormulas: IDataSet; Gravando: IGravando): Boolean;
Var
  intContador: Integer;
  qryGen: IDataSet;
begin

  qryRSI_CADBAS.Close;
  qryRSI_CADBAS.SQL.Empty;
  qryRSI_CADBAS.SQL := '    SELECT * FROM RSI_CADBAS WHERE BAS_BASE__ = :BASE AND     ' +
                       '      BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY           ' ;

  qryRSI_CADBAS.ParamByName('BASE').AsString := qryNovasFormulas.FieldByName('NFM_BASE__').AsString;
  qryRSI_CADBAS.ParamByName('PROKEY').AsString := qryNovasFormulas.FieldByName('NFM_PROKEY').AsString;
  qryRSI_CADBAS.ParamByName('SUBKEY').AsString := qryNovasFormulas.FieldByName('NFM_SUBKEY').AsString;

  qryRSI_CADBAS.Open;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   DELETE FROM RSI_CADRSI WHERE RSI_CODIGO = :CODPRO   ';
  qryGen.ParamByName('CODPRO').AsString := qryNovasFormulas.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;

  While Not qryRSI_CADBAS.Eof Do
  Begin

    If (Gravando.Status <> sgGravando)  Then
      Break;

    qryRSI_CADRSI.Insert;
    qryRSI_CADRSI.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADRSI', TAutcomTintaFactory.Get.GetCodEmp);
    qryRSI_CADRSI.FieldByName('RSI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryRSI_CADRSI.FieldByName('RSI_DESCRI').AsString := qryNovasFormulas.FieldByName('NFM_DESCRI').AsString + ' ' + qryNovasFormulas.FieldByName('NFM_CODPRO').AsString;
    qryRSI_CADRSI.FieldByName('RSI_CODIGO').AsString := qryNovasFormulas.FieldByName('NFM_CODPRO').AsString;
    qryRSI_CADRSI.FieldByName('RSI_CODIG2').AsString := qryNovasFormulas.FieldByName('NFM_CODPRO').AsString;
    qryRSI_CADRSI.FieldByName('RSI_UNIDAD').AsString := qryRSI_CADBAS.FieldByName('BAS_UNIDAD').AsString;
    qryRSI_CADRSI.FieldByName('RSI_CODITE').AsString := qryRSI_CADBAS.FieldByName('BAS_CODITE').AsString;
    qryRSI_CADRSI.FieldByName('RSI_CODSEQ').AsString := TStrUtils.fStrZero(fRetornaCodSeq, 15);
    qryRSI_CADRSI.FieldByName('RSI_BASE__').AsString := qryNovasFormulas.FieldByName('NFM_BASE__').AsString;
    qryRSI_CADRSI.FieldByName('RSI_PROKEY').AsString := qryNovasFormulas.FieldByName('NFM_PROKEY').AsString;
    qryRSI_CADRSI.FieldByName('RSI_SUBKEY').AsString := qryNovasFormulas.FieldByName('NFM_SUBKEY').AsString;
    qryRSI_CADRSI.FieldByName('RSI_DTACAD').AsDate   := qryNovasFormulas.FieldByName('NFM_DTACAD').AsDate;

    For intContador := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(qryNovasFormulas.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      qryRSI_CADRSI.FieldByName('RSI_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
        qryNovasFormulas.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString;

      qryRSI_CADRSI.FieldByName('RSI_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
        fConverteQtdEmb(qryNovasFormulas.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intContador, 2)).AsFloat,
                        qryNovasFormulas.FieldByName('NFM_UNIDAD').AsString, qryRSI_CADBAS.FieldByName('BAS_UNIDAD').AsString);
    End;

    qryRSI_CADRSI.FieldByName('RSI_MD5KEY').AsString := GetMD5(qryRSI_CADRSI.FieldByName('RSI_DESCRI').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_BASE__').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_CODIGO').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_CODIG2').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_PROKEY').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_SUBKEY').AsString +
                                                               qryRSI_CADRSI.FieldByName('RSI_UNIDAD').AsString);
    qryRSI_CADRSI.Post;
    qryRSI_CADBAS.Next;
  End;

  Result := True;

end;

function TAbstractGravandoExecucaoResicolor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoResicolor.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

function TAbstractGravandoExecucaoResicolor.fRetornaCodSeq(): Integer;
Var
  qryGen : IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.SQL := 'SELECT RSI_CODSEQ '+
                       '  FROM RSI_CADRSI '+
                       ' ORDER BY RSI_CODSEQ DESC '+
                       ' LIMIT 1;';
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('RSI_CODSEQ').AsInteger + 1;

  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoResicolor.fRetornaQtdEmbalagem(
  strEmbalagem: String): Double;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_QTDEMB FROM LKD_CADEMB WHERE EMB_CODEMB = :EMBALAGEM   ';
  qryGen.ParamByName('EMBALAGEM').AsString := strEmbalagem;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

end;

function TAbstractGravandoExecucaoResicolor.fRetUnidade(fltQtd: Double): String;
begin
  If fltQtd < 1500 Then
   Result := 'LT'
  Else If (fltQtd >= 1500) And (fltQtd <= 5000) Then
   Result := 'GL'
  Else If fltQtd > 5000 Then
   Result := 'LA';
end;

function TAbstractGravandoExecucaoResicolor.fRetUnidadeEmbalagem(
  strCodEmb: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL.Empty;
    qryGen.SQL := ' SELECT              ' +
                  '   EMB_UNIDAD        ' +
                  ' FROM                ' +
                  '   RSI_CADEMB        ' +
                  ' WHERE               ' +
                  '   EMB_CODEMB = :EMB ';
    qryGen.ParamByName('EMB').AsString := strCodEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_UNIDAD').AsString;
  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoResicolor.fstrEspaco(Str: String; Tamanho,
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

function TAbstractGravandoExecucaoResicolor.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath + '\PRODUCTS.DBF')) Then
    Result := False;
end;

procedure TAbstractGravandoExecucaoResicolor.pVerificaBase;
begin
  If blnQtdRgt Then
  Begin
    If intMaxLinhaFrm > 1200 Then
    Begin
      intMaxLinhaFrm := 1200;
    End;
  End;

end;

function TAbstractGravandoExecucaoResicolor.fVerificaCadastroBases(): Boolean;
begin
  Result := (Not qryRSI_CADBAS.IsEmpty);
end;

function TAbstractGravandoExecucaoResicolor.fVerificaCadastroColorante: Boolean;
begin
   Result := (Not qryRSI_CADCOL.IsEmpty);
end;

function TAbstractGravandoExecucaoResicolor.fVerificaCadastroEmbalagem(): Boolean;
Var
  conDataCans : TUniConnection;
  QryCans     : TUniQuery;
  intCont     :  Integer;
  intErros    : Integer;
begin
  Try
    intErros := 0;

    conDataCans:= TUniConnection.Create(Nil);

    conDataCans.ProviderName := 'DBF';
    conDataCans.LoginPrompt  := False;

    conDataCans.Database     := GetPath;

    If (Not conDataCans.Connected) Then
      conDataCans.Connected := True;

    QryCans := TUniQuery.Create(Nil);

    QryCans.Connection := conDataCans;

    QryCans.Close;
    QryCans.SQL.Clear;
    QryCans.SQL.Add('SELECT * FROM \CANS.DBF');
    QryCans.Open;
    QryCans.First;

    If Not qryRSI_CADEMB.IsEmpty Then
    Begin
      For intCont := 1 To QryCans.RecordCount Do
      Begin
        If (QryCans.FieldByName('NOM_Q').AsFloat > 0) And (Not TStrUtils.fEmptyStr(QryCans.FieldByName('NOM_Q').AsString)) Then
        Begin

          If Not qryRSI_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(QryCans.FieldByName('ID').AsString), 2), []) Then
          Begin
            Inc(intErros);
            Break;
          End
          Else
          If TStrUtils.fEmptyStr(qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
          Begin
            Inc(intErros);
            Break;
          End;
        End;

        QryCans.Next;
      End;
    End
    Else
      Inc(intErros);

    Result := intErros = 0;
    QryCans.Close;
  Finally
    If Assigned(QryCans) Then
      FreeAndNil(QryCans);
    If Assigned(conDataCans)Then
      FreeAndNil(conDataCans);
  End;
end;

function TAbstractGravandoExecucaoResicolor.GetPath: String;
begin
  Result := conf.fGet('PATRSI');
end;


function TAbstractGravandoExecucaoResicolor.GetPathPro: String;
begin
  Result := Conf.fGet('PATPRO');
end;

procedure TAbstractGravandoExecucaoResicolor.pApagandoTemporarias;
begin
  TAutcomTintaFactory.Get.DropTable('TMP_GERFRMFUT');
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarBases;
begin
  DataBases.Connected := False;
  DataBases.Database := GetPath;

  If Not DataBases.Connected Then
    DataBases.Connected := True;

  tblBases.Connection := DataBases;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('    SELECT * FROM \BASES.DBF    ');
  tblBases.Open;
  tblBases.First;


  tblCnts.Connection := DataBases;

  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('   SELECT * FROM \CNTS.DBF   ');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarFrm(strPath1,
  strPath2: String; Gravando : IGravando);
Var
  strPath3:String;
begin
  Try

    If FileExists(strPath2 + '\FRM.DBF') Then
      strPath3 := strPath2
    Else If FileExists(strPath1 + '\FRM.DBF') Then
      strPath3 := strPath1
    Else
      strPath3 := GetPath;

    ExcelFrm := CreateOleObject('Excel.Application');
    ExcelFrm.Visible := False;
    ExcelFrm.WorkBooks.Add(strPath3 + '\FRM.DBF');

    intMaxLinhaFrm   := fMaxLinha(ExcelFrm);
    //pVerificaBase;
    intLinhaAtualFrm := 2;

    gravando.Texto := 'Importando Arquivo: ' + strPath3;

    if gravando.Status <> sgGravando then
    begin
      pApagandoTemporarias;
      Exit;
    end;

    pPreencheTemporariaFRM(Gravando);

    if gravando.Status <> sgGravando then
    begin
      pApagandoTemporarias;
      Exit;
    end;

    gravando.Texto := 'Processando Arquivo: ' + strPath3;
    qryFrm.Close;
    qryFrm.SQL := 'SELECT * FROM TMP_GERFRMFUT';
    qryFrm.Open;
  Finally
    ExcelFrm.WorkBooks.Close;
    ExcelFrm.Quit;
    ExcelFrm := Unassigned;
  End;
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarMask(strPath: String);
begin

  DataMask.Connected := False;
  DataMask.Database  := strPath;

  If Not DataMask.Connected Then
    DataMask.Connected := True;

  tblMask.Close;
  tblMask.Connection := DataMask;


  tblMask.SQL.Clear;
  tblMask.SQL.Add('   SELECT * FROM \mask.dbf');
  tblMask.Open;
  tblMask.First;
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarProdutos;
begin
  DataProducts.Connected := False;
  DataProducts.Database := GetPath;

  If Not DataProducts.Connected Then
    DataProducts.Connected := True;

  tblProducts.Connection := DataProducts;

  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('   SELECT * FROM \products.dbf   ');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarRuler(strPath: String);
begin

  DataRuler.Connected := False;
  DataRuler.Database  := strPath;

  If Not DataRuler.Connected Then
    DataRuler.Connected := True;

  tblRuler.Close;
  tblRuler.Connection := DataRuler;

  tblRuler.SQL.Clear;
  tblRuler.SQL.Add('    SELECT * FROM \ruler.dbf    ');
  tblRuler.Open;
  tblRuler.First;
end;

procedure TAbstractGravandoExecucaoResicolor.pCarregarSubProdutos(
  StrPath: String);
begin

  DataSubProds.Connected := False;
  DataSubProds.Database := strPath;

  If Not DataSubProds.Connected Then
    DataSubProds.Connected := True;


  tblSubProds.Close;
  tblSubProds.Connection := DataSubProds;


  tblSubProds.SQL.Clear;
  tblSubProds.SQL.Add('   SELECT * FROM \subprods.dbf   ');
  tblSubProds.Open;
  tblSubProds.First;
end;

procedure TAbstractGravandoExecucaoResicolor.pGravaCadastroColorantes(
  arrColRsi: array of TColRsi; Gravando: IGravando);
Var
  intContador: Integer;
  function fRetornaDescColorante(strColId: String): String;
  Begin
    Result := '';
    strColId := fstrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);

    If tblCnts.Locate('ID', strColId, []) Then
     Result := tblCnts.FieldByname('DESCR').AsString;
  End;
begin
  For intContador := Low(arrColRsi) To High(arrColRsi) Do
  Begin
    qryRSI_CADCOL.First;

    If Not qryRSI_CADCOL.Locate('COL_CODCOL', arrColRsi[intContador].strCodCol, []) Then
    Begin
      If Not TStrUtils.fEmptyStr(arrColRsi[intContador].strCodCol) Then
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        If TStrUtils.fEmptyStr(arrColRsi[intContador].strCodCol) Then
          Break;


        qryRSI_CADCOL.Insert;
        qryRSI_CADCOL.FieldByName('COL_CODCOL').AsString := arrColRsi[intContador].strCodCol;
        qryRSI_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryRSI_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
        qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColRsi[intContador].strCodCol);
        qryRSI_CADCOL.FieldByName('COL_EMBALA').AsFloat  := 1000;
        qryRSI_CADCOL.Post;

      End;
    End
    Else If TStrUtils.fEmptyStr(qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryRSI_CADCOL.Edit;
      qryRSI_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColRsi[intContador].strCodCol);
      qryRSI_CADCOL.Post;
    End;
  End;
end;
procedure TAbstractGravandoExecucaoResicolor.pGravarCadastroBases(strBase,
  strProKey, strSubKey, strDescri: String; Gravando: IGravando);
begin
  If Not qryRSI_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                  VarArrayOf([strBase, strProKey, strSubKey, qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin

    qryRSI_CADBAS.Insert;
    qryRSI_CADBAS.FieldByName('BAS_BASE__').AsString := strBase;
    qryRSI_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryRSI_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryRSI_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryRSI_CADBAS.FieldByName('BAS_DESCRI').AsString := strDescri;
    qryRSI_CADBAS.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryRSI_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryRSI_CADBAS.Post;
  End;
end;

function TAbstractGravandoExecucaoResicolor.fGravarCadastroResicolor(
  intCodSeq: Integer; strBase, strproKey, strSubKey: String;
  arrColRsi: array of TColRsi; strDescri: String; strCodEmb: String; strKey2: String; Gravando: IGravando; strEmbArq: String): String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + 'INSERT INTO RSI_CADRSI (';
  Result := Result + 'RSI_CODSEQ, ';
  Result := Result + 'RSI_DESCRI, ';
  Result := Result + 'RSI_CODIGO, ';
  Result := Result + 'RSI_CODIG2, ';
  Result := Result + 'RSI_UNIDAD, ';
  Result := Result + 'RSI_CODEMP, ';
  Result := Result + 'RSI_BASE__, ';
  Result := Result + 'RSI_PROKEY, ';
  Result := Result + 'RSI_SUBKEY, ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + 'RSI_FORM' + TStrUtils.fStrZero(intContador, 2) + ', ';
    Result := Result + 'RSI_QTDB' + TStrUtils.fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + 'RSI_MD5KEY) ';

  Result := Result + 'VALUES (';
  Result := Result + ':RSI_CODSEQ, ';
  Result := Result + ':RSI_DESCRI, ';
  Result := Result + ':RSI_CODIGO, ';
  Result := Result + ':RSI_CODIG2, ';
  Result := Result + ':RSI_UNIDAD, ';
  Result := Result + ':RSI_CODEMP, ';
  Result := Result + ':RSI_BASE__, ';
  Result := Result + ':RSI_PROKEY, ';
  Result := Result + ':RSI_SUBKEY, ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + ':RSI_FORM' + TStrUtils.fStrZero(intContador, 2) + ', ';
    Result := Result + ':RSI_QTDB' + TStrUtils.fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + ':RSI_MD5KEY); ';
end;

procedure TAbstractGravandoExecucaoResicolor.pImportarCadastroEmbalagem(Gravando : IGravando);
Var
  tblCans  : TUniQuery;
  DataCans : TUniConnection;
  intCont  : Integer;
begin
  Try
    Gravando.Texto := 'Carregando Dados do Cadastro de Embalagens...';

    DataCans := TUniConnection.Create(Nil);

    DataCans.ProviderName := 'DBF';
    DataCans.LoginPrompt  := False;

    DataCans.DataBase := GetPath;

    If (Not DataCans.Connected) Then
      DataCans.Connected := True;

    tblCans := TUniQuery.Create(Nil);

    tblCans.Connection := DataCans;

    tblCans.Close;
    tblCans.SQL.Clear;
    tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
    tblCans.Open;
    tblCans.First;

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('RSI_CADEMB');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Processando Cadastro de Embalagens...';

    For intCont := 1 To tblCans.RecordCount Do
    Begin

      If (Gravando.Status <> sgGravando) Then
        Break;

      qryRSI_CADEMB.Insert;
      qryRSI_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
      qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
      qryRSI_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
      qryRSI_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
      qryRSI_CADEMB.Post;
      tblCans.Next;

      Gravando.RegistrarProgresso(0, intCont, tblCans.RecordCount);
    End;
  Finally
    FreeAndNil(tblCans);
    FreeAndNil(DataCans);
  End;
end;

procedure TAbstractGravandoExecucaoResicolor.pPreencheQryCadBas;
begin
  cdsCadBas := TUniClientDataSet.Create(Nil);

  cdsCadBas.FieldDefs.AddFieldDef;
  cdsCadBas.FieldDefs[0].DataType := ftString;
  cdsCadBas.FieldDefs[0].Name := 'ID';
  cdsCadBas.FieldDefs[0].Size := 5;

  cdsCadBas.FieldDefs.AddFieldDef;
  cdsCadBas.FieldDefs[1].DataType := ftString;
  cdsCadBas.FieldDefs[1].Name := 'PROD_KEY';
  cdsCadBas.FieldDefs[1].Size := 10;

  cdsCadBas.FieldDefs.AddFieldDef;
  cdsCadBas.FieldDefs[2].DataType := ftString;
  cdsCadBas.FieldDefs[2].Name := 'SUBP_KEY';
  cdsCadBas.FieldDefs[2].Size := 10;

  cdsCadBas.CreateDataSet;

  tblBases.First;
  While Not tblBases.Eof Do
  Begin
    cdsCadBas.Append;
    cdsCadBas.FieldByName('ID').AsString    := Trim(tblBases.FieldByName('ID').AsString);
    cdsCadBas.FieldByName('PROD_KEY').AsString := Trim(tblBases.FieldByName('PROD_KEY').AsString);
    cdsCadBas.FieldByName('SUBP_KEY').AsString  := Trim(tblBases.FieldByName('SUBP_KEY').AsString);
    cdsCadBas.Post;
    tblBases.Next;
  End;
end;

procedure TAbstractGravandoExecucaoResicolor.pPreencherRuler;
begin
  cdsCadRuler.EmptyDataSet;

  tblRuler.First;

  While Not tblRuler.Eof Do
  Begin
    cdsCadRuler.Append;
    cdsCadRuler.FieldByName('ID').AsString    := Trim(tblRuler.FieldByName('ID').AsString);
    cdsCadRuler.FieldByName('RULE').AsString := Trim(tblRuler.FieldByName('RULE').AsString);
    cdsCadRuler.Post;

    tblRuler.Next;
  End;
end;

procedure TAbstractGravandoExecucaoResicolor.pPreencheTemporariaFRM(
  const gravando: IGravando);
var
  qryArq: TFDQuery;
  intQtd: Integer;
  intContador: Integer;
begin
  qryArq := TFDQuery.Create(Nil);
  qryArq.Connection := FDDatabase;
  qryArq.SQL.Clear();

  TAutcomTintaFactory.Get.DropTable('TMP_GERFRMFUT');

  qryArq.SQL.Text := ' CREATE TABLE TMP_GERFRMFUT  ' +
                     ' (                           ' +
                     '    BASE_ID CHAR(02),        ' +
                     '    CAN_ID  CHAR(02),        ' +
                     '    FORMULA VARCHAR(100),    ' +
                     '    KEY1    VARCHAR(100),    ' +
                     '    KEY2    VARCHAR(100),    ' +
                     '    KEY3    VARCHAR(100),    ' +
                     '    COMMENT VARCHAR(255)     ' +
                     '  );                         ';
  qryArq.ExecSQL;

  qryArq.Close;
  qryArq.SQL.Clear;

  qryArq.SQL.Text := ' INSERT INTO TMP_GERFRMFUT   ' +
                     ' (                           ' +
                     '    BASE_ID ,                ' +
                     '    CAN_ID  ,                ' +
                     '    FORMULA ,                ' +
                     '    KEY1    ,                ' +
                     '    KEY2    ,                ' +
                     '    KEY3    ,                ' +
                     '    COMMENT                  ' +
                     '  )                          ' +
                     '  VALUES                     ' +
                     ' (                           ' +
                     '    :BASE_ID ,               ' +
                     '    :CAN_ID  ,               ' +
                     '    :FORMULA ,               ' +
                     '    :KEY1    ,               ' +
                     '    :KEY2    ,               ' +
                     '    :KEY3    ,               ' +
                     '    :COMMENT                 ' +
                     '  );                         ';

  If (Gravando.Status <> sgGravando) Then
  Begin
    pApagandoTemporarias;
    Exit;
  End;

  qryArq.Params.ClearValues();
  qryArq.Params.ArraySize := intMaxLinhaFrm;
  intQtd := 0;

  For intContador := 0 To Pred(intMaxLinhaFrm) Do
  Begin
    qryArq.ParamByName('BASE_ID').AsStrings[intContador] := ExcelFrm.Cells.Item[intLinhaAtualFrm,8].Text;
    qryArq.ParamByName('CAN_ID').AsStrings[intContador]  := ExcelFrm.Cells.Item[intLinhaAtualFrm,9].Text;
    qryArq.ParamByName('FORMULA').AsStrings[intContador] := ExcelFrm.Cells.Item[intLinhaAtualFrm,11].Text;
    qryArq.ParamByName('KEY1').AsStrings[intContador]    := ExcelFrm.Cells.Item[intLinhaAtualFrm,3].Text;
    qryArq.ParamByName('KEY2').AsStrings[intContador]    := ExcelFrm.Cells.Item[intLinhaAtualFrm,4].Text;
    qryArq.ParamByName('KEY3').AsStrings[intContador]    := ExcelFrm.Cells.Item[intLinhaAtualFrm,5].Text;
    qryArq.ParamByName('COMMENT').AsStrings[intContador] := ExcelFrm.Cells.Item[intLinhaAtualFrm,27].Text;

    gravando.RegistrarProgresso(0, intLinhaAtualFrm - 1, intMaxLinhaFrm);
    Inc(intLinhaAtualFrm);
    Inc(intQtd);

    If intLinhaAtualFrm <= intMaxLinhaFrm + 1 Then
      Continue
    Else
      Break;
  End;

  qryArq.Execute(intQtd, 0);
  FreeAndNil(qryArq);
end;

procedure TAbstractGravandoExecucaoResicolor.pPreparaConexaoFireDac;
begin
  qryConf := TAutcomTintaFactory.Get.fCriaQuery();
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + qryConf.Connection.Database;
  FUser_Name := 'User_Name=' + qryConf.Connection.Username;
  FPassword  := 'Password=' + qryConf.Connection.Password;
  FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
  FServer    := 'Server=' + qryConf.Connection.Server;
  FreeAndNil(qryConf);

  FDDatabase   := TFDConnection.Create(Nil);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  FDCursor     := TFDGUIxWaitCursor.Create(Nil);

  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;
end;

end.

