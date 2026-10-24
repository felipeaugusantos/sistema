{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta AnjoSintetica *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAnjoSintetica;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, untStatusGravando,  Variants, DBFUniProvider;


Type
  TColAja = Record
  strCodCol: String;
  fltQtdCol: Double;
End;

type
  TAbstractGravandoExecucaoAnjoSintetica = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    DataProduts : TUniConnection;
    DataSubProd : TUniConnection;
    DataFrm     : TUniConnection;
    DataMask    : TUniConnection;
    DataBases   : TUniConnection;

    tblProducts : TUniQuery;
    tblSubProds : TUniQuery;
    tblFrm      : TUniQuery;
    tblMask     : TUniQuery;
    tblBases    : TUniQuery;
    tblCnts     : TUniQuery;

    qryTmpFrm     : IDataSet;
    qryAJA_CADBAS : IDataSet;
    qryAJA_CADCOL : IDataSet;
    qryAJA_CADEMB : IDataSet;
    qryAJA_CADNFM : IDataSet;
    qryAJA_CADAJA : IDataSet;

    procedure pCarregarProdutos;
    procedure pCarregarSubProduto(strPathProduto:String; Gravando: IGravando);
    procedure pCarregarFrm(strPathProduto, strPathSubProduto:String; Gravando:IGravando);
    procedure pCarregarMask(strPathSubProduto:String; Gravando:IGravando);
    procedure pCarregarBases;
    procedure pGravaCadCol(arrColAja: Array Of TColAja; Gravando: IGravando);
    procedure pGravaCadBas(strBase, strProKey, strSubKey, strDescri:String; Gravando:IGravando);
    procedure pAtualizarTabelas;
    procedure pGravaCadEmb(Gravando:IGravando);


    function fCalQtdEmb(strEmbCom, strQtdEmb:String; fltQuantidade:Double):Double;
    function fGravaCadAja(intCodSeq:Integer; strBase, strProKey, strSubKey, strDescri:String; ArrColAja: Array of TColAja; Gravando: IGravando):Boolean;
    function fRetornaProximoCodSeq():Integer;
    function fVerificaCadBas():Boolean;
    function fVerificaCadCol():Boolean;
    function fVerificaCadEmb():Boolean;
    function fExisteEmbalagem(strIdEmb:String; fltQtdEmb:Double):Boolean;
    function fValidaDiretorio : Boolean;
    function GetPath : String;
    function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;

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

{ TGravandoExecucaoAnjoSinteticaCores }

constructor TAbstractGravandoExecucaoAnjoSintetica.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('AJA');

  qryAJA_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qryAJA_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qryAJA_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qryAJA_CADNFM := TAutcomTintaFactory.Get.fGetDataSet;
  qryAJA_CADAJA := TAutcomTintaFactory.Get.fGetDataSet;

  qryAJA_CADBAS.SQL := '    SELECT * FROM AJA_CADBAS  ';
  qryAJA_CADCOL.SQL := '    SELECT * FROM AJA_CADCOL  ';
  qryAJA_CADEMB.SQL := '    SELECT * FROM AJA_CADEMB  ';
  qryAJA_CADNFM.SQL := '    SELECT * FROM AJA_CADNFM  ';
  qryAJA_CADAJA.SQL := '    SELECT * FROM AJA_CADAJA  ';

  qryAJA_CADBAS.Open;
  qryAJA_CADCOL.Open;
  qryAJA_CADEMB.Open;
  qryAJA_CADNFM.Open;
  qryAJA_CADAJA.Open;


end;

destructor TAbstractGravandoExecucaoAnjoSintetica.Destroy;
begin
  inherited;
  If Assigned(tblProducts) Then
    FreeAndNil(tblProducts);

  If Assigned(tblSubProds) Then
    FreeAndNil(tblSubProds);

  If Assigned(tblFrm) Then
    FreeAndNil(tblFrm);

  If Assigned(tblMask) Then
    FreeAndNil(tblMask);

  If Assigned(tblBases) Then
    FreeAndNil(tblBases);

  If Assigned(tblCnts) Then
    FreeAndNil(tblCnts);

  If Assigned(DataProduts) Then
    FreeAndNil(DataProduts);

  If Assigned(DataSubProd) Then
    FreeAndNil(DataSubProd);

  If Assigned(DataFrm) Then
    FreeAndNil(DataFrm);

  If Assigned(DataMask) Then
    FreeAndNil(DataMask);

  If Assigned(DataBases) Then
    FreeAndNil(DataBases);
end;

function TAbstractGravandoExecucaoAnjoSintetica.fCalQtdEmb(strEmbCom,
  strQtdEmb: String; fltQuantidade: Double): Double;
Var
  fltEmbAtu,
  fltEmbMas :Double;
begin
  qryAJA_CADEMB.Locate('EMB_CODEMB', strEmbCom, []);
  fltEmbAtu := qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryAJA_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQuantidade / fltEmbAtu;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fExisteEmbalagem(
  strIdEmb: String; fltQtdEmb: Double): Boolean;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_CODEMB FROM AJA_CADEMB   ' +
                  '     WHERE EMB_CODEMB = :CODEMB        ' +
                  '   AND EMB_QTDEMB = :QTDEMB            ' ;
    qryGen.ParamByName('CODEMB').AsString := TStrUtils.fStrZero(Trim(strIdEmb), 2);
    qryGen.ParamByName('QTDEMB').AsFloat  := fltQtdEmb;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fGravaCadAja(intCodSeq: Integer;
  strBase, strProKey, strSubKey, strDescri: String;
  ArrColAja: array of TColAja; Gravando: IGravando): Boolean;
Var
  intContador: Integer;
  strMd5Key:String;
begin
  Result := False;
  If (Gravando.Status <> sgGravando) Then
    Exit;

  If qryAJA_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBase, strProKey, strSubKey,
    qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    If (qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString <> strDescri) Or
      (qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString <> tblFrm.FieldByName('KEY1').AsString) Or
      (qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString <> tblFrm.FieldByName('KEY2').AsString) Or
      (qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString <> qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString) Or
      qryAJA_CADAJA.IsEmpty Then
    Begin
      qryAJA_CADAJA.Insert;
      qryAJA_CADAJA.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADAJA', TAutcomTintaFactory.Get.GetCodEmp);
      qryAJA_CADAJA.FieldByName('AJA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryAJA_CADAJA.FieldByName('AJA_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
      qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString := strDescri;
      qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString := tblFrm.FieldByName('KEY1').AsString;
      qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString := tblFrm.FieldByName('KEY2').AsString;
      qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString := qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryAJA_CADAJA.FieldByName('AJA_BASE__').AsString := qryAJA_CADBAS.FieldByName('BAS_BASE__').AsString;
      qryAJA_CADAJA.FieldByName('AJA_PROKEY').AsString := qryAJA_CADBAS.FieldByName('BAS_PROKEY').AsString;
      qryAJA_CADAJA.FieldByName('AJA_SUBKEY').AsString := qryAJA_CADBAS.FieldByName('BAS_SUBKEY').AsString;

      strMd5Key := qryAJA_CADAJA.FieldByName('AJA_DESCRI').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_CODIGO').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_CODIG2').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_UNIDAD').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_PROKEY').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_SUBKEY').AsString +
                   qryAJA_CADAJA.FieldByName('AJA_BASE__').AsString;

      For intContador := Low(ArrColAja) To High(ArrColAja) Do
      Begin
        strMd5Key := strMd5Key + arrColAja[intContador].strCodCol +
          StringReplace(FormatFloat('0.0000', arrColAja[intContador].fltQtdCol), ',', '.', []);

        If TStrUtils.fEmptyStr(arrColAja[intContador].strCodCol) Then
          Continue;

        qryAJA_CADAJA.FieldByName('AJA_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString :=
          arrColAja[intContador].strCodCol;

        qryAJA_CADAJA.FieldByName('AJA_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat  :=
          arrColAja[intContador].fltQtdCol;
      End;

      qryAJA_CADAJA.FieldByName('AJA_MD5KEY').AsString := GetMD5(strMd5Key);
      qryAJA_CADAJA.Post;

      Result := True;
    End;


  End;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fRetornaProximoCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT AJA_CODSEQ FROM AJA_CADAJA ORDER BY AJA_CODSEQ DESC LIMIT 1    ';
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('AJA_CODSEQ').AsInteger + 1;

  Except
    Raise;
  End;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fstrEspaco(Str: String; Tamanho,
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
End;

function TAbstractGravandoExecucaoAnjoSintetica.fValidaDiretorio : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath + '\PRODUCTS.DBF')) Then
    Result := False;
end;

function TAbstractGravandoExecucaoAnjoSintetica.fVerificaCadBas(): Boolean;
begin
  pAtualizarTabelas;
  Result := (Not qryAJA_CADBAS.IsEmpty);
end;

function TAbstractGravandoExecucaoAnjoSintetica.fVerificaCadCol(): Boolean;
begin
  pAtualizarTabelas;
  Result := (Not qryAJA_CADCOL.IsEmpty)
end;

function TAbstractGravandoExecucaoAnjoSintetica.fVerificaCadEmb(): Boolean;
Var
  tblCans :TUniQuery;
  DataCans: TUniConnection;
  intContador, intErros:Integer;
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

  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  tblCans.Open;
  tblCans.First;

  If Not qryAJA_CADEMB.IsEmpty Then
  Begin
    For intContador := 1 To tblCans.RecordCount Do
    Begin
      If (tblCans.FieldByName('NOM_Q').AsFloat > 0) And
         (Not TStrUtils.fEmptyStr(tblCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryAJA_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
        Begin
          Inc(intErros);
          Break;
        End
        Else If TStrUtils.fEmptyStr(qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
        Begin
          Inc(intErros);
          Break;
        End;
      End;
    End;
    tblCans.Next;
  End
  Else
    Inc(intErros);

  Result := intErros = 0;
  tblCans.Close;
  FreeAndNil(tblCans);
  FreeAndNil(DataCans);

end;

function TAbstractGravandoExecucaoAnjoSintetica.GetPath: String;
begin
  Result := conf.fGet('PATAJA');
end;


procedure TAbstractGravandoExecucaoAnjoSintetica.pAtualizarTabelas;
begin
  qryAJA_CADBAS.Close;
  qryAJA_CADCOL.Close;
  qryAJA_CADEMB.Close;
  qryAJA_CADNFM.Close;
  qryAJA_CADAJA.Close;

  qryAJA_CADBAS.Open;
  qryAJA_CADCOL.Open;
  qryAJA_CADEMB.Open;
  qryAJA_CADNFM.Open;
  qryAJA_CADAJA.Open;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pCarregarBases;
begin
  DataBases := TUniConnection.Create(Nil);
  DataBases.ProviderName := 'DBF';
  DataBases.LoginPrompt := False;
  DataBases.Database := GetPath;

  If Not (DataBases.Connected) Then
    DataBases.Connected := True;


  tblBases := TUniQuery.Create(Nil);
  tblBases.Connection := DataBases;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('    SELECT * FROM \BASES.DBF    ');
  tblBases.Open;
  tblBases.First;

  tblCnts := TUniQuery.Create(Nil);
  tblCnts.Connection := DataBases;

  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('   SELECT * FROM \CNTS.DBF   ');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pCarregarFrm(strPathProduto,
  strPathSubProduto: String; Gravando: IGravando);
Var
  strPath:String;
begin
  strPath := '';

  If FileExists(strPathSubProduto + '\FRM.DBF') Then
    strPath := strPathSubProduto
  Else If FileExists(strPathProduto + '\FRM.DBF') Then
    strPath := strPathProduto
  Else
    strPath := GetPath;

  DataFrm := TUniConnection.Create(Nil);
  DataFrm.ProviderName := 'DBF';
  DataFrm.LoginPrompt := False;
  DataFrm.Database := strPath;

  If Not (DataFrm.Connected) Then
    DataFrm.Connected := True;

  tblFrm := TUniQuery.Create(Nil);
  tblFrm.Connection := DataFrm;

  tblFrm.Close;
  tblFrm.SQL.Clear;
  tblFrm.SQL.Add('    SELECT * FROM \FRM.DBF    ');
  tblFrm.Open;
  tblFrm.First;



end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pCarregarMask(
  strPathSubProduto: String; Gravando: IGravando);
begin
  DataMask := TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt := False;
  DataMask.Database := strPathSubProduto;

  If Not (DataMask.Connected) Then
    DataMask.Connected := True;

  tblMask := TUniQuery.Create(Nil);
  tblMask.Connection := DataMask;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('   SELECT * FROM \MASK.DBF   ');
  tblMask.Open;
  tblMask.First;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pCarregarProdutos;
begin
  DataProduts := TUniConnection.Create(Nil);
  DataProduts.ProviderName := 'DBF';
  DataProduts.LoginPrompt := False;
  DataProduts.Database := GetPath;

  If Not (DataProduts.Connected) Then
    DataProduts.Connected := True;

  tblProducts := TUniQuery.Create(Nil);
  tblProducts.Connection := DataProduts;


  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add(' SELECT * FROM \PRODUCTS.DBF ');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pCarregarSubProduto(
  strPathProduto: String; Gravando: IGravando);
begin
  DataSubProd := TUniConnection.Create(Nil);
  DataSubProd.ProviderName := 'DBF';
  DataSubProd.LoginPrompt := False;
  DataSubProd.Database := strPathProduto;

  If Not (DataSubProd.Connected) Then
    DataSubProd.Connected := True;

  tblSubProds := TUniQuery.Create(Nil);
  tblSubProds.Connection := DataSubProd;


  tblSubProds.Close;
  tblSubProds.SQL.Clear;
  tblSubProds.SQL.Add('   SELECT * FROM \SUBPRODS.DBF   ');
  tblSubProds.Open;
  tblSubProds.First;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pGravaCadBas(strBase,
  strProKey, strSubKey, strDescri: String; Gravando: IGravando);
begin

  If (Gravando.Status <> sgGravando) Then
    Exit;

  If Not qryAJA_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayof([strBase, strProKey, strSubKey,
    qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin

    qryAJA_CADBAS.Insert;
    qryAJA_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryAJA_CADBAS.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryAJA_CADBAS.FieldByName('BAS_BASE__').AsString := strBase;
    qryAJA_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryAJA_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryAJA_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryAJA_CADBAS.FieldByName('BAS_DESCRI').AsString := strDescri;
    qryAJA_CADBAS.Post;
  End;
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pGravaCadCol(
  arrColAja: array of TColAja; Gravando: IGravando);
Var
  intContador: Integer;
  function fRetornaDescricaoColorante(strColId:String):String;
  Begin
    Result := '';
    strColId := fstrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);
    If tblCnts.Locate('ID', strColId, []) Then
      Result := tblCnts.FieldByname('DESCR').AsString;
  End;
begin
  If (Gravando.Status <> sgGravando) Then
    Exit;

  For intContador := Low(arrColAja) To High(arrColAja) Do
  Begin
    qryAJA_CADCOL.First;

    If Not qryAJA_CADCOL.Locate('COL_CODCOL', arrColAja[intContador].strCodCol, []) Then
    Begin
      If Not TStrUtils.fEmptyStr(ArrColAja[intContador].strCodCol) Then
      Begin

        If TStrUtils.fEmptyStr(ArrColAja[intContador].strCodCol) Then
          Break;

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryAJA_CADCOL.Insert;
        qryAJA_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
        qryAJA_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryAJA_CADCOL.FieldByName('COL_CODCOL').AsString := arrColAja[intContador].strCodCol;
        qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescricaoColorante(arrColAja[IntContador].strCodCol);
        qryAJA_CADCOL.Post;
      End;
    End
    Else If TStrUtils.fEmptyStr(qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryAJA_CADCOL.Edit;
      qryAJA_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescricaoColorante(arrColAja[intContador].strCodCol);
      qryAJA_CADCOL.Post;
    End;
  End
end;

procedure TAbstractGravandoExecucaoAnjoSintetica.pGravaCadEmb(
  Gravando: IGravando);
Var
  tblCans: TUniQuery;
  intContador: Integer;
  DataCans: TUniConnection;
begin
  Gravando.Texto  := 'Carregando Dados do Cadastro de Embalagens...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  pAtualizarTabelas;

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

  Gravando.Texto :=  'Deletando Cadastro de Embalagem...';

  qryAJA_CADEMB.Close;
  qryAJA_CADEMB.SQL.Empty;
  qryAJA_CADEMB.SQL := '  DELETE FROM AJA_CADEMB    ';
  qryAJA_CADEMB.ExecSQL;
  qryAJA_CADEMB.SQL.Empty;

  Gravando.Texto := 'Cadastro de Embalagem deletado...';

  qryAJA_CADEMB.SQL := '    SELECT * FROM AJA_CADEMB    ';
  qryAJA_CADEMB.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('AJA_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';


  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.RegistrarProgresso(0, 0, 0);
  Gravando.Texto := 'Processando Cadastro de Embalagem...';

  For intContador := 1 To tblCans.RecordCount Do
  Begin
    If Not TStrUtils.fEmptyStr(tblCans.FieldByName('NOM_Q').AsString) Then
    Begin
      If Not fExisteEmbalagem(tblCans.FieldByName('ID').AsString, tblCans.FieldByName('NOM_Q').AsFloat) Then
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryAJA_CADEMB.Insert;
        qryAJA_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qryAJA_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryAJA_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
        qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat := tblCans.FieldByName('NOM_Q').AsFloat;

        If qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat = 900 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LT'
        Else If qryAJA_CADEMB.FieldByName('EMB_QTDEMB').AsFloat = 3600 Then
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'GL'
        Else
          qryAJA_CADEMB.FieldByName('EMB_UNIDAD').AsString := 'LA';

        qryAJA_CADEMB.Post;
      End;
    End;
    tblCans.Next;
    Gravando.RegistrarProgresso(0 , intContador, tblCans.RecordCount);
  End;

  FreeAndNil(tblCans);
  FreeAndNil(DataCans);
end;

end.
