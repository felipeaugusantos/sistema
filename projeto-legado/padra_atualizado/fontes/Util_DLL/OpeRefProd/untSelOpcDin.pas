unit untSelOpcDin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.JSON, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView,
  cxGridCitel, cxGrid, cxCheckBox,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untPaiConfirma, untFuncoesSimples,
  Uni, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TdtoOpcDinParam = record
    strId: String;
    strDescricao: String;
    blnSelecionado: Boolean;
  end;
  TArrayOpcDinParam = TArray<TdtoOpcDinParam>;

  IBuilderOpcDin = interface
    ['{A3F1E2D0-9B4C-4E7A-BF3D-5C8A1E2F9D7B}']
    function pAdd(const AstrId, AstrDescricao: String;
      AblnSelecionado: Boolean = False): IBuilderOpcDin;
    function fBuild: TArrayOpcDinParam;
  end;

  TBuilderOpcDin = class(TInterfacedObject, IBuilderOpcDin)
  private
    FarrItens: TArrayOpcDinParam;
  public
    class function fNovo: IBuilderOpcDin;
    function pAdd(const AstrId, AstrDescricao: String;
      AblnSelecionado: Boolean = False): IBuilderOpcDin;
    function fBuild: TArrayOpcDinParam;
  end;

  TGerOpcDin = class
  private
    FstrChave: String;
    FstrOperador: String;
    FarrParametros: TArrayOpcDinParam;
    procedure pCarregarDoDb;
  public
    constructor Create(const AstrChave, AstrOperador: String; const AarrParametros: TArrayOpcDinParam); overload;
    constructor Create(const AstrChave: String; const AarrParametros: TArrayOpcDinParam); overload;
    function fSelecionado(const AstrId: String): Boolean;
    function fListaCamposSelecionados: TArray<String>;
    procedure pAbrirConfiguracao;
  end;

  TfrmSelOpcDin = class(TfrmPaiConfirma)
    cdsOpcoes: TUniClientDataSet;
    dtsOpcoes: TDataSource;
    cxgOpcoes: TcxGridCitel;
    cxlOpcoes: TcxGridLevel;
    cxvOpcoes: TcxGridDBTableViewCitel;
    cxvSelecionado: TcxGridDBColumn;
    cxvDescricao: TcxGridDBColumn;
    cxvId: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
  private
    FstrChave: String;
    FstrOperador: String;
    FarrParametros: TArrayOpcDinParam;
    FblnConfirmou: Boolean;
    procedure pInicializaCDS;
    procedure pCarregarOpcoes;
    function fCarregarJsonSalvo: String;
    procedure pMarcaDesmarcaTodos(AMarca: Boolean);

    procedure pSalvarJson;
  public
    class function fCriarSelecao(
      const AstrChave: String;
      const AstrOperador: String;
      var AarrParametros: TArrayOpcDinParam
    ): Boolean; overload;
    class function fCriarSelecao(const AstrChave: String; var AarrParametros: TArrayOpcDinParam): Boolean; overload;

  end;

var
  frmSelOpcDin: TfrmSelOpcDin;

implementation

{$R *.dfm}

procedure TfrmSelOpcDin.pInicializaCDS;
begin
  cdsOpcoes.Close;
  cdsOpcoes.FieldDefs.Clear;
  cdsOpcoes.FieldDefs.Add('OPC_ID',        ftString, 100);
  cdsOpcoes.FieldDefs.Add('OPC_DESCRICAO', ftString, 200);
  cdsOpcoes.FieldDefs.Add('OPC_SEL',       ftBoolean);
  cdsOpcoes.CreateDataSet;
end;

procedure TfrmSelOpcDin.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False)

end;

procedure TfrmSelOpcDin.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True)
end;

procedure TfrmSelOpcDin.pMarcaDesmarcaTodos(AMarca: Boolean);
begin
  cdsOpcoes.First;
  while not cdsOpcoes.Eof Do
  begin
    cdsOpcoes.Edit;
    cdsOpcoes.FieldByName('OPC_SEL').AsBoolean := AMarca;
    cdsOpcoes.Post;
    cdsOpcoes.Next;
  end;
end;

function TfrmSelOpcDin.fCarregarJsonSalvo: String;
var
  qryDin: TUniQuery;
begin
  Result := '';
  qryDin := fCriaQuery(nil);
  try
    qryDin.SQL.Add('SELECT OPC_CONFIG ');
    qryDin.SQL.Add('  FROM OPCDIN ');
    qryDin.SQL.Add(' WHERE OPC_CHAVE_ = :CHAVE ');
    If FstrOperador <> '' then
      qryDin.SQL.Add('   AND  OPC_CODOPE = :CODOPE');
    qryDin.ParamByName('CHAVE').AsString  := FstrChave;
    If FstrOperador <> '' then
      qryDin.ParamByName('CODOPE').AsString := FstrOperador;
    qryDin.Open;
    if not qryDin.IsEmpty then
      Result := qryDin.FieldByName('opc_config').AsString;
  finally
    FreeAndNil(qryDin);
  end;
end;

class function TfrmSelOpcDin.fCriarSelecao(const AstrChave: String; var AarrParametros: TArrayOpcDinParam): Boolean;
var
  frmSel: TfrmSelOpcDin;
begin
  Result := False;
  pCriarFormularios(TfrmSelOpcDin, frmSel);
  try
    frmSel.FstrChave      := UpperCase(AstrChave);
    frmSel.FstrOperador   := '';
    frmSel.FarrParametros := AarrParametros;
    frmSel.FblnConfirmou  := False;
    frmSel.ShowModal;
    if frmSel.FblnConfirmou then
    begin
      AarrParametros := frmSel.FarrParametros;
      Result := True;
    end;
  finally
    FreeAndNil(frmSel);
  end;

end;

procedure TfrmSelOpcDin.pCarregarOpcoes;
var
  strJson : String;
  objArray: TJSONArray;
  objItem : TJSONValue;
  objObj  : TJSONObject;
  strId   : String;
  dictSel : TDictionary<String, Boolean>;
  blnSel  : Boolean;
  intI    : Integer;
begin
  pInicializaCDS;

  strJson := fCarregarJsonSalvo;
  dictSel := TDictionary<String, Boolean>.Create;
  try
    if strJson <> '' then
    begin
      objArray := TJSONObject.ParseJSONValue(strJson) as TJSONArray;
      if Assigned(objArray) then
      try
        for objItem in objArray do
        begin
          objObj := objItem as TJSONObject;
          strId  := objObj.GetValue('id').Value;
          blnSel := (objObj.GetValue('sel') as TJSONBool).AsBoolean;
          dictSel.AddOrSetValue(strId, blnSel);
        end;
      finally
        FreeAndNil(objArray);
      end;
    end;

    cdsOpcoes.DisableControls;
    try
      for intI := 0 to High(FarrParametros) do
      begin
        cdsOpcoes.Append;
        cdsOpcoes.FieldByName('OPC_ID').AsString        := FarrParametros[intI].strId;
        cdsOpcoes.FieldByName('OPC_DESCRICAO').AsString := FarrParametros[intI].strDescricao;
        if dictSel.ContainsKey(FarrParametros[intI].strId) then
          cdsOpcoes.FieldByName('OPC_SEL').AsBoolean := dictSel[FarrParametros[intI].strId]
        else
          cdsOpcoes.FieldByName('OPC_SEL').AsBoolean := FarrParametros[intI].blnSelecionado;
        cdsOpcoes.Post;
      end;
    finally
      cdsOpcoes.EnableControls;
    end;

    if not cdsOpcoes.IsEmpty then
      cdsOpcoes.First;
  finally
    FreeAndNil(dictSel);
  end;
end;

procedure TfrmSelOpcDin.pSalvarJson;
var
  objArray : TJSONArray;
  objItem  : TJSONObject;
  strJson  : String;
  qryDin   : TUniQuery;
  blnExiste: Boolean;
begin
  objArray := TJSONArray.Create;
  try
    cdsOpcoes.First;
    while not cdsOpcoes.Eof do
    begin
      objItem := TJSONObject.Create;
      objItem.AddPair('id', cdsOpcoes.FieldByName('OPC_ID').AsString);
      if cdsOpcoes.FieldByName('OPC_SEL').AsBoolean then
        objItem.AddPair('sel', TJSONTrue.Create)
      else
        objItem.AddPair('sel', TJSONFalse.Create);
      objArray.AddElement(objItem);
      cdsOpcoes.Next;
    end;
    strJson := objArray.ToString;
  finally
    FreeAndNil(objArray);
  end;

  qryDin := fCriaQuery(nil);
  try
    qryDin.SQL.Add('SELECT COUNT(*) AS QTD ');
    qryDin.SQL.Add('  FROM OPCDIN ');
    qryDin.SQL.Add(' WHERE OPC_CHAVE_ = :CHAVE ');
    If FstrOperador <> '' then
      qryDin.SQL.Add('   AND OPC_CODOPE = :CODOPE');
    qryDin.ParamByName('CHAVE').AsString  := FstrChave;
    If FstrOperador <> '' then
      qryDin.ParamByName('CODOPE').AsString := FstrOperador;
    qryDin.Open;
    blnExiste := qryDin.FieldByName('QTD').AsInteger > 0;
    qryDin.Close;
    qryDin.SQL.Clear;
    if blnExiste then
    begin
      qryDin.SQL.Add('UPDATE OPCDIN ');
      qryDin.SQL.Add('   SET OPC_CONFIG = :CONFIG  ');
      qryDin.SQL.Add(' WHERE OPC_CHAVE_ = :CHAVE ');
      If FstrOperador <> '' then
        qryDin.SQL.Add('   AND OPC_CODOPE = :CODOPE');
      qryDin.ParamByName('CONFIG').AsString := strJson;
      qryDin.ParamByName('CHAVE').AsString  := FstrChave;
      If FstrOperador <> '' then
        qryDin.ParamByName('CODOPE').AsString := FstrOperador;
      qryDin.ExecSQL;
    end
    else
    begin
      qryDin.SQL.Text := 'INSERT INTO OPCDIN (AUTOINCREM, OPC_CHAVE_, OPC_CONFIG, OPC_CODOPE) ' +
        'VALUES (:AUTOINCREM, :CHAVE, :CONFIG, :CODOPE)';
      qryDin.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('OPCDIN', VS_strCodEmp);
      qryDin.ParamByName('CHAVE').AsString      := FstrChave;
      qryDin.ParamByName('CONFIG').AsString     := strJson;
      qryDin.ParamByName('CODOPE').Clear;
      If FstrOperador <> '' then
        qryDin.ParamByName('CODOPE').AsString     := FstrOperador;
      qryDin.ExecSQL;
    end;
  finally
    FreeAndNil(qryDin);
  end;
end;

procedure TfrmSelOpcDin.FormShow(Sender: TObject);
begin
  inherited;
  blnVerificaCampos := False;
  pCarregarOpcoes;
end;

procedure TfrmSelOpcDin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdsOpcoes.Close;
  inherited;
end;

procedure TfrmSelOpcDin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F1 then
    btnMarcaTodos.Click;
  If Key = VK_F2 then
    btnDesmarcaTodos.Click;
end;

procedure TfrmSelOpcDin.btnConfirmaClick(Sender: TObject);
var
  intI: Integer;
begin
  inherited;
  pSalvarJson;

  cdsOpcoes.First;
  for intI := 0 to High(FarrParametros) do
  begin
    if not cdsOpcoes.Eof then
    begin
      FarrParametros[intI].blnSelecionado :=
        cdsOpcoes.FieldByName('OPC_SEL').AsBoolean;
      cdsOpcoes.Next;
    end;
  end;

  FblnConfirmou := True;
end;

class function TfrmSelOpcDin.fCriarSelecao(
  const AstrChave: String;
  const AstrOperador: String;
  var AarrParametros: TArrayOpcDinParam
): Boolean;
var
  frmSel: TfrmSelOpcDin;
begin
  Result := False;
  pCriarFormularios(TfrmSelOpcDin, frmSel);
  try
    frmSel.FstrChave      := UpperCase(AstrChave);
    frmSel.FstrOperador   := AstrOperador;
    frmSel.FarrParametros := AarrParametros;
    frmSel.FblnConfirmou  := False;
    frmSel.ShowModal;
    if frmSel.FblnConfirmou then
    begin
      AarrParametros := frmSel.FarrParametros;
      Result := True;
    end;
  finally
    FreeAndNil(frmSel);
  end;
end;

{ TGerOpcDin }

constructor TGerOpcDin.Create(const AstrChave, AstrOperador: String;
  const AarrParametros: TArrayOpcDinParam);
begin
  inherited Create;
  FstrChave      := UpperCase(AstrChave);
  FstrOperador   := AstrOperador;
  FarrParametros := AarrParametros;
  pCarregarDoDb;
end;

procedure TGerOpcDin.pCarregarDoDb;
var
  qryDin  : TUniQuery;
  strJson : String;
  objArray: TJSONArray;
  objItem : TJSONValue;
  objObj  : TJSONObject;
  strId   : String;
  blnSel  : Boolean;
  dictSel : TDictionary<String, Boolean>;
  intI    : Integer;
begin
  strJson := '';
  qryDin := fCriaQuery(nil);
  try
    qryDin.SQL.Add('SELECT OPC_CONFIG');
    qryDin.SQL.Add('  FROM OPCDIN ');
    qryDin.SQL.Add(' WHERE OPC_CHAVE_ = :CHAVE ');
    If FstrOperador <> '' then
      qryDin.SQL.Add('   AND OPC_CODOPE = :CODOPE');
    qryDin.ParamByName('CHAVE').AsString  := FstrChave;
    If FstrOperador <> '' then
      qryDin.ParamByName('CODOPE').AsString := FstrOperador;
    qryDin.Open;
    if not qryDin.IsEmpty then
      strJson := qryDin.FieldByName('OPC_CONFIG').AsString;
  finally
    FreeAndNil(qryDin);
  end;

  if strJson = '' then
    Exit;

  dictSel := TDictionary<String, Boolean>.Create;
  try
    objArray := TJSONObject.ParseJSONValue(strJson) as TJSONArray;
    if Assigned(objArray) then
    try
      for objItem in objArray do
      begin
        objObj := objItem as TJSONObject;
        strId  := objObj.GetValue('id').Value;
        blnSel := (objObj.GetValue('sel') as TJSONBool).AsBoolean;
        dictSel.AddOrSetValue(strId, blnSel);
      end;
    finally
      FreeAndNil(objArray);
    end;

    for intI := 0 to High(FarrParametros) do
      if dictSel.ContainsKey(FarrParametros[intI].strId) then
        FarrParametros[intI].blnSelecionado := dictSel[FarrParametros[intI].strId];
  finally
    FreeAndNil(dictSel);
  end;
end;

function TGerOpcDin.fSelecionado(const AstrId: String): Boolean;
var
  intI: Integer;
begin
  Result := False;
  for intI := 0 to High(FarrParametros) do
    if FarrParametros[intI].strId = AstrId then
    begin
      Result := FarrParametros[intI].blnSelecionado;
      Break;
    end;
end;

procedure TGerOpcDin.pAbrirConfiguracao;
begin
  TfrmSelOpcDin.fCriarSelecao(FstrChave, FstrOperador, FarrParametros);
end;

constructor TGerOpcDin.Create(const AstrChave: String;
  const AarrParametros: TArrayOpcDinParam);
begin
  inherited Create;
  FstrChave      := UpperCase(AstrChave);
  FstrOperador   := '';
  FarrParametros := AarrParametros;
  pCarregarDoDb;
end;

function TGerOpcDin.fListaCamposSelecionados: TArray<String>;
var
  intI, intLen: Integer;
begin
  intLen := 0;
  SetLength(Result, Length(FarrParametros));
  for intI := 0 to High(FarrParametros) do
    if FarrParametros[intI].blnSelecionado then
    begin
      Result[intLen] := FarrParametros[intI].strId;
      Inc(intLen);
    end;
  SetLength(Result, intLen);
end;

{ TBuilderOpcDin }

class function TBuilderOpcDin.fNovo: IBuilderOpcDin;
begin
  Result := TBuilderOpcDin.Create;
end;

function TBuilderOpcDin.pAdd(const AstrId, AstrDescricao: String;
  AblnSelecionado: Boolean = False): IBuilderOpcDin;
var
  intLen: Integer;
begin
  intLen := Length(FarrItens);
  SetLength(FarrItens, intLen + 1);
  FarrItens[intLen].strId          := AstrId;
  FarrItens[intLen].strDescricao   := AstrDescricao;
  FarrItens[intLen].blnSelecionado := AblnSelecionado;
  Result := Self;
end;

function TBuilderOpcDin.fBuild: TArrayOpcDinParam;
begin
  Result := FarrItens;
end;

end.
