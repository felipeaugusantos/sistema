{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta SherwinWilliams  *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoSherwinWilliams;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, untStrUtils, DBFUniProvider, untStatusGravando,
  ComObj, Variants, UniClientDataSet;

Type
  TColShe = Record
    strCodCol: String;
    fltQtdCol: Double;
    strDesCol: String;
  End;

type
  TAbstractGravandoExecucaoSherwinWilliams = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    qrySHE_CADEMB: IDataSet;
    qrySHE_CADBAS: IDataSet;
    qrySHE_CADCOL: IDataSet;

    DataBases: TUniConnection;
    tblBases : TUniQuery;

    DataProducts: TUniConnection;
    tblProducts : TUniQuery;

    DataCans: TUniConnection;
    tblCans : TUniQuery;

    DataCnts: TUniConnection;
    tblCnts : TUniQuery;

{    DataFrm: TUniConnection;
    tblFrm : TUniQuery;}

    tblFrm: IDataSet;

    ExcelFrm: Variant;

    DataSubprods: TUniConnection;
    tblSubprods : TUniQuery;

    DataMask: TUniConnection;
    tblMask : TUniQuery;

    DFUniProvider: TDBFUniProvider;

    intMaxLinhaFrm: Integer;
    intLinhaAtualFrm: Integer;

    cdsCol: TUniClientDataSet;

    function fMaxLinha(Excel: Variant): Integer;

    procedure CarregarDados;

    function fValidaPath : Boolean;
    function GetPath : String;

    procedure pCarregarProducts;
    procedure pCarregarBases;
    procedure pCarregarCans;
    procedure pCarregarCnts;

    procedure pCarregarCADEMB;
    procedure pImportarCADEMB(const gravando: IGravando);

    procedure pCarregarCADBAS;
    procedure pCarregarCADCOL;

    procedure pCriaConexaoFrm;
    procedure pCriaConexaoMask;
    procedure pCriaConexaoSubprods;

    procedure pCarregarSubprods(strPatPro: String);
    procedure pCarregarFrm(strPatPro, strPatSub: String; const gravando: IGravando);
    procedure pCarregarMask(strPatSub: String);

    function fVerificaCadEmb: Boolean;
    function fVerificaCadBas: Boolean;
//    function fVerificaCadBasConfig: Boolean;
    function fVerificaCadCol: Boolean;

    function fRetBasesMask: String;

    procedure pPreencheTemporariaFRM(const gravando: IGravando);

    function fRetDesCol(strCodCol: String): String;
    procedure pApagandoTemporarias;
    procedure pLocalizaBase(strIdBase: String);
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TGravandoExecucaoSherwinWilliamsCores }

procedure TAbstractGravandoExecucaoSherwinWilliams.CarregarDados;
begin
  If fValidaPath And (DFUniProvider = Nil) Then
  Begin
    DFUniProvider := TDBFUniProvider.Create(Nil);

    pCarregarProducts;
    pCarregarBases;
    pCarregarCans;
    pCarregarCnts;

    pCarregarCADEMB;
    pCarregarCADBAS;
    pCarregarCADCOL;

    pCriaConexaoFrm;
    pCriaConexaoMask;
    pCriaConexaoSubprods;
  End;
end;

constructor TAbstractGravandoExecucaoSherwinWilliams.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SHE');

  CarregarDados;
end;

destructor TAbstractGravandoExecucaoSherwinWilliams.Destroy;
begin
  if Assigned(DFUniProvider) then FreeAndNil(DFUniProvider);
  if Assigned(DataBases)     then FreeAndNil(DataBases);
  if Assigned(tblBases)      then FreeAndNil(tblBases);
  if Assigned(DataProducts)  then FreeAndNil(DataProducts);
  if Assigned(tblProducts)   then FreeAndNil(tblProducts);
//  if Assigned(DataFrm)       then FreeAndNil(DataFrm);
//  if Assigned(tblFrm)        then FreeAndNil(tblFrm);
  if Assigned(DataSubprods)  then FreeAndNil(DataSubprods);
  if Assigned(tblSubprods)   then FreeAndNil(tblSubprods);
  TAutcomTintaFactory.Get.DropTable('TMP_GERFRMSHE');
  TAutcomTintaFactory.Get.DropTable('TMP_MD5KEYSHE');
  inherited;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fMaxLinha(
  Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fRetBasesMask: String;
begin
  Result := '';

  tblMask.First;
  while not tblMask.Eof do
  Begin
    If (tblMask.FieldByName('TYPE').AsString = 'BA') Then
      If Pos(Trim(tblMask.FieldByName('PNT_ID').AsString), Result) <= 0 Then
        Result := Result + Trim(tblMask.FieldByName('PNT_ID').AsString) + '_';

    tblMask.Next;
  End;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fRetDesCol(
  strCodCol: String): String;
begin
  Result := '';
  If cdsCol.Locate('ID', strCodCol, []) Then
    Result := cdsCol.FieldByName('DESCR').AsString;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fValidaPath : Boolean;
var
  strPath: String;
begin
  Result := True;

  If (Not DirectoryExists(GetPath)) Then
    Result := False;

  If Result Then
  Begin
    strPath := GetPath;

    If Not FileExists(strPath + '\PRODUCTS.DBF') Then
      Result := False;
  End;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fVerificaCadBas: Boolean;
begin
  Result := (Not qrySHE_CADBAS.IsEmpty); {And (fVerificaCadBasConfig);}
end;

{function TAbstractGravandoExecucaoSherwinWilliams.fVerificaCadBasConfig: Boolean;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT COUNT(*) AS CONT FROM SHE_CADBAS WHERE BAS_CODITE IS NOT NULL';
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;
end;}

function TAbstractGravandoExecucaoSherwinWilliams.fVerificaCadCol: Boolean;
begin
  Result := Not qrySHE_CADCOL.IsEmpty;
end;

function TAbstractGravandoExecucaoSherwinWilliams.fVerificaCadEmb: Boolean;
begin
  Result := Not qrySHE_CADEMB.IsEmpty;

  tblCans.First;
  If Not qrySHE_CADEMB.IsEmpty Then
  Begin
    While not tblCans.Eof Do
    Begin
      If Not qrySHE_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2), []) Then
      Begin
        Result := False;
        Break;
      End
      Else If TStrUtils.fEmptyStr(qrySHE_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
      Begin
        Result := False;
        Break;
      End;
      tblCans.Next;
    End;
  End;
end;

function TAbstractGravandoExecucaoSherwinWilliams.GetPath: String;
begin
  Result := conf.fGet('TXTSHE');
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pApagandoTemporarias;
begin
  TAutcomTintaFactory.Get.DropTable('TMP_GERFRMSHE');
  TAutcomTintaFactory.Get.DropTable('TMP_MD5KEYSHE');
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarBases;
begin
  DataBases := TUniConnection.Create(Nil);
  DataBases.ProviderName := 'DBF';
  DataBases.LoginPrompt  := False;

  DataBases.Database     := GetPath;

  If (Not DataBases.Connected) Then
    DataBases.Connected := True;

  tblBases := TUniQuery.Create(Nil);
  tblBases.Connection := DataBases;

  tblBases.Close;
  tblBases.SQL.Clear;
  tblBases.SQL.Add('SELECT * FROM \BASES.DBF');
  tblBases.Open;
  tblBases.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarCADBAS;
begin
  qrySHE_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qrySHE_CADBAS.SQL := ' SELECT * FROM SHE_CADBAS ';
  qrySHE_CADBAS.Open;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarCADCOL;
begin
  qrySHE_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qrySHE_CADCOL.SQL := ' SELECT * FROM SHE_CADCOL ';
  qrySHE_CADCOL.Open;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarCADEMB;
begin
  qrySHE_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qrySHE_CADEMB.SQL := ' SELECT * FROM SHE_CADEMB ';
  qrySHE_CADEMB.Open;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarCans;
begin
  DataCans := TUniConnection.Create(Nil);
  DataCans.ProviderName := 'DBF';
  DataCans.LoginPrompt  := False;

  DataCans.Database     := GetPath;

  If (Not DataCans.Connected) Then
    DataCans.Connected := True;

  tblCans := TUniQuery.Create(Nil);
  tblCans.Connection := DataCans;

  tblCans.Close;
  tblCans.SQL.Clear;
  tblCans.SQL.Add('SELECT * FROM \CANS.DBF');
  tblCans.Open;
  tblCans.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarCnts;
begin
  DataCnts := TUniConnection.Create(Nil);
  DataCnts.ProviderName := 'DBF';
  DataCnts.LoginPrompt  := False;

  DataCnts.Database     := GetPath;

  If (Not DataCnts.Connected) Then
    DataCnts.Connected := True;

  tblCnts := TUniQuery.Create(Nil);
  tblCnts.Connection := DataCnts;

  tblCnts.Close;
  tblCnts.SQL.Clear;
  tblCnts.SQL.Add('SELECT * FROM \CNTS.DBF');
  tblCnts.Open;
  tblCnts.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarProducts;
begin
  DataProducts := TUniConnection.Create(Nil);
  DataProducts.ProviderName := 'DBF';
  DataProducts.LoginPrompt  := False;

  DataProducts.Database     := GetPath;

  If (Not DataProducts.Connected) Then
    DataProducts.Connected := True;

  tblProducts := TUniQuery.Create(Nil);
  tblProducts.Connection := DataProducts;

  tblProducts.Close;
  tblProducts.SQL.Clear;
  tblProducts.SQL.Add('SELECT * FROM \PRODUCTS.DBF');
  tblProducts.Open;
  tblProducts.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarFrm(strPatPro, strPatSub: String; const gravando: IGravando);
var
  strFrm: String;
begin
//Essa instrucao foi comentada porque ao abrir os arquivos frm
//Em alguns casos nao estavam mostrando todas as informacoes corretamente
//Alem de estar duplicando alguns registros,
//pode ser o novo componente de conexao uniconnection com o drive DBF
{
  If FileExists(strPatSub + '\FRM.DBF') Then
    DataFrm.Database := strPatSub
  Else If FileExists(strPatPro + '\FRM.DBF') Then
    DataFrm.Database := strPatPro
  Else
    DataFrm.Database := GetPath;

  If (Not DataFrm.Connected) Then
    DataFrm.Connected := True;

  gravando.Texto := 'Processando Arquivo: ' + DataFrm.Database;

  Try
    tblFrm.Close;
    tblFrm.SQL.Clear;
    tblFrm.SQL.Add('SELECT * FROM \FRM.DBF');
    tblFrm.Open;
  Except
    on E: Exception do
    begin
      gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      gravando.Texto := 'Erro nesse Arquivo: ' + DataFrm.Database;
    End;
  End;

  tblFrm.First;
 }

  If FileExists(strPatSub + '\FRM.DBF') Then
    strFrm := strPatSub
  Else If FileExists(strPatPro + '\FRM.DBF') Then
    strFrm := strPatPro
  Else
    strFrm := GetPath;

  Try
    ExcelFrm := CreateOleObject('Excel.Application');
    ExcelFrm.Visible := False;
    ExcelFrm.WorkBooks.Add(strFrm + '\FRM.DBF');

    intMaxLinhaFrm   := fMaxLinha(ExcelFrm);
    intLinhaAtualFrm := 2;

    gravando.Texto := 'Importando Arquivo: ' + strFrm;

    if gravando.Status <> sgGravando then
    begin
      pApagandoTemporarias;
      Exit;
    end;

    pPreencheTemporariaFRM(gravando);

    if gravando.Status <> sgGravando then
    begin
      pApagandoTemporarias;
      Exit;
    end;

    gravando.Texto := 'Processando Arquivo: ' + strFrm;

    tblFrm.SQL := 'SELECT * FROM TMP_GERFRMSHE';
    tblFrm.Open;
  Finally
    ExcelFrm.WorkBooks.Close;
  End;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarMask(strPatSub: String);
begin
  DataMask.Database := strPatSub;

  If (Not DataMask.Connected) Then
    DataMask.Connected := True;

  tblMask.Close;
  tblMask.SQL.Clear;
  tblMask.SQL.Add('SELECT * FROM \MASK.DBF');
  tblMask.Open;
  tblMask.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCarregarSubprods(
  strPatPro: String);
begin
  If Not FileExists(strPatPro + '\SUBPRODS.DBF') Then
  Begin
    tblSubprods.Close;
    Exit;
  End;

  DataSubprods.Database := strPatPro;

  If (Not DataSubprods.Connected) Then
    DataSubprods.Connected := True;

  tblSubprods.Close;
  tblSubprods.SQL.Clear;
  tblSubprods.SQL.Add('SELECT * FROM \SUBPRODS.DBF');
  tblSubprods.Open;
  tblSubprods.First;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCriaConexaoFrm;
begin
{  DataFrm := TUniConnection.Create(Nil);
  DataFrm.ProviderName := 'DBF';
  DataFrm.LoginPrompt  := False;

  tblFrm := TUniQuery.Create(Nil);
  tblFrm.Connection := DataFrm;}

  tblFrm := TAutcomTintaFactory.Get.fGetDataSet;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCriaConexaoSubprods;
begin
  DataSubprods := TUniConnection.Create(Nil);
  DataSubprods.ProviderName := 'DBF';
  DataSubprods.LoginPrompt  := False;

  tblSubprods := TUniQuery.Create(Nil);
  tblSubprods.Connection := DataSubprods;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pCriaConexaoMask;
begin
  DataMask := TUniConnection.Create(Nil);
  DataMask.ProviderName := 'DBF';
  DataMask.LoginPrompt  := False;

  tblMask := TUniQuery.Create(Nil);
  tblMask.Connection := DataMask;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pImportarCADEMB(const gravando: IGravando);
begin
  Try
    Try
      gravando.Texto := 'Iniciando processo de importação do cadastro de embalagens ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD SHE_CADEMB...';
      TAutcomTintaFactory.Get.fInsereProCod('SHE_CADEMB');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      tblCans.First;
      While Not tblCans.Eof Do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        qrySHE_CADEMB.Insert;
        qrySHE_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
        qrySHE_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
        qrySHE_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qrySHE_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHE_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qrySHE_CADEMB.Post;

        tblCans.Next;
      End;
    Except
      On E: Exception Do
      Begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    gravando.Texto := 'Importação do cadastro de embalagens realizada com sucesso...';
  End;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pLocalizaBase(
  strIdBase: String);
begin
  tblBases.First;
  While not tblBases.Eof Do
  Begin

    If (Trim(tblBases.FieldByName('ID').AsString) = strIdBase) Then
      Break;

    tblBases.Next;
  End;
end;

procedure TAbstractGravandoExecucaoSherwinWilliams.pPreencheTemporariaFRM(const gravando: IGravando);
var
  qryFrm: IDataSet;
  intTemp: Integer;
begin
  qryFrm := TAutcomTintaFactory.Get.fGetDataSet;

  TAutcomTintaFactory.Get.DropTable('TMP_GERFRMSHE');

  qryFrm.SQL := ' CREATE TABLE TMP_GERFRMSHE  ' +
                ' (                           ' +
                '    BASE_ID CHAR(02),        ' +
                '    CAN_ID  CHAR(02),        ' +
                '    FORMULA VARCHAR(100),    ' +
                '    KEY1    VARCHAR(100),    ' +
                '    KEY2    VARCHAR(100),    ' +
                '    KEY3    VARCHAR(100),    ' +
                '    COMMENT VARCHAR(255)     ' +
                '  );                         ';
  qryFrm.ExecSQL;

  qryFrm.SQL := ' INSERT INTO TMP_GERFRMSHE   ' +
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

  For intTemp := 1 To intMaxLinhaFrm Do
  Begin
    if gravando.Status <> sgGravando then
      Exit;

    //Limpa os parametros
    qryFrm.ParamByName('BASE_ID').Value := Null;
    qryFrm.ParamByName('CAN_ID').Value  := Null;
    qryFrm.ParamByName('FORMULA').Value := Null;
    qryFrm.ParamByName('KEY1').Value    := Null;
    qryFrm.ParamByName('KEY2').Value    := Null;
    qryFrm.ParamByName('KEY3').Value    := Null;
    qryFrm.ParamByName('COMMENT').Value := Null;


    qryFrm.ParamByName('BASE_ID').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,8].Text;
    qryFrm.ParamByName('CAN_ID').AsString  := ExcelFrm.Cells.Item[intLinhaAtualFrm,9].Text;
    qryFrm.ParamByName('FORMULA').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,11].Text;
    qryFrm.ParamByName('KEY1').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,3].Text;
    qryFrm.ParamByName('KEY2').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,4].Text;
    qryFrm.ParamByName('KEY3').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm,5].Text;
    qryFrm.ParamByName('COMMENT').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm,27].Text;
    qryFrm.ExecSql;

    gravando.RegistrarProgresso(0, intLinhaAtualFrm - 1, intMaxLinhaFrm);

    intLinhaAtualFrm := intLinhaAtualFrm + 1;
  End;

end;

end.

