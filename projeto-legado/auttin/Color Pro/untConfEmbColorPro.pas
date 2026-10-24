unit untConfEmbColorPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxListBox, ExtCtrls,
    Uni, untIConsultaTinta,
  StdCtrls, Buttons, dbcgrids, UniClientDataSet, Mask, DBCtrls, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, cxButtonEdit,
  Datasnap.DBClient;

type
  TfrmConfEmbColorPro = class(TFrame) 
    dtsPrevia: TDataSource;
    qryPrevia: TUniQuery;
    grpVisiveis: TGroupBox;
    dbgConsulta: TcxGrid;
    dbgViewConsulta: TcxGridDBTableView;
    dbgLvlConsulta: TcxGridLevel;
    cdsEmb: TUniClientDataSet;
    dtsEmb: TDataSource;
    cdsEmbDESLIN: TStringField;
    cdsEmbCODCFG: TStringField;
    cdsEmbVALCFG: TStringField;
    cdsEmbDESCFG: TStringField;
    dbgViewConsultaDESLIN: TcxGridDBColumn;
    dbgViewConsultaCODCFG: TcxGridDBColumn;
    dbgViewConsultaVALCFG: TcxGridDBColumn;
    dbgViewConsultaDESCFG: TcxGridDBColumn;
    cdsEmbEMBALA: TStringField;
    dbgViewConsultaEMBALA: TcxGridDBColumn;

    procedure dbgViewConsultaVALCFGPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbgViewConsultaVALCFGPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    Canvas: TCanvas;
    cdsLinhas: TUniClientDataSet;
    strLinhasConfig: String;
    { Private declarations }
    procedure pConstruirGrid;
    function fRetEmbalagem(strCodCfg: String): String;
    procedure pSelecionaConfiguracao;
    procedure pSelecionaLinhas;
    procedure pAtualizaProduto(strCodIte: String);
    procedure pCriaClientPrincipal;
    procedure pValidaProduto(strCodIte: String);
    function fFormataLinhasConfiguradas: String;
  public

    constructor Create(AOwner: TComponent; Parent: TWinControl;
      Canvas: TCanvas; strLinhasConfig: String); reintroduce;
    destructor Destroy; override;

    { Public declarations }

    procedure pSalvarEmbalagens;
  end;

implementation

uses
   Types, SysConst, StrUtils, untTypesSistema, untConsultas, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfEmbColorPro }


constructor TfrmConfEmbColorPro.Create(AOwner: TComponent; Parent: TWinControl;
  Canvas: TCanvas; strLinhasConfig: String);
begin
  inherited Create(AOwner);
  Self.Parent := Parent;
  Self.Canvas := Canvas;
  Self.strLinhasConfig := strLinhasConfig;
  pCriaClientPrincipal;
  pConstruirGrid;
end;

procedure TfrmConfEmbColorPro.dbgViewConsultaVALCFGPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  arrSel: TConsultasArray;
  Key: Char;

  edtItem: TEdit;
begin
  Key := '/';
  edtItem := TEdit(Sender);
  if fPesqItem(conIteSimples, TForm(Self), edtItem, nil, nil, Key, arrSel) Then
  Begin
    pAtualizaProduto(edtItem.Text);
  End;
end;

procedure TfrmConfEmbColorPro.dbgViewConsultaVALCFGPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  pAtualizaProduto(DisplayValue);
  pValidaProduto(DisplayValue);
end;

destructor TfrmConfEmbColorPro.Destroy;
begin
  FreeAndNil(cdsLinhas);
  cdsEmb.EmptyDataSet;
  inherited;
end;

function TfrmConfEmbColorPro.fFormataLinhasConfiguradas: String;
begin
  Result := ''; //QuotedStr(strLinhasConfig);

  While Not fEmptyStr(strLinhasConfig) Do
  Begin
    If fEmptyStr(Result)Then
      Result := QuotedStr(Copy(strLinhasConfig, 1, 3))
    Else
      Result := Result + ',' + QuotedStr(Copy(strLinhasConfig, 1, 3));

    strLinhasConfig := Trim(Copy(strLinhasConfig, 4, Length(strLinhasConfig)));
  End;
end;

function TfrmConfEmbColorPro.fRetEmbalagem(strCodCfg: String): String;
begin
  Result := '';
  If Copy(strCodCfg, Length(strCodCfg) - 1, 2) = 'LT' Then
    Result := 'Litro'
  Else If Copy(strCodCfg, Length(strCodCfg) - 1, 2) = 'GL' Then
    Result := 'Galão'
  Else If Copy(strCodCfg, Length(strCodCfg) - 1, 2) = 'LA' Then
    Result := 'Lata';
end;

procedure TfrmConfEmbColorPro.pAtualizaProduto(strCodIte: String);
begin
  cdsEmb.Edit;
  cdsEmb.FieldByName('VALCFG').AsString := strCodIte;
  cdsEmb.FieldByName('DESCFG').AsString := fRetNomProduto(strCodIte);
  cdsEmb.Post;
end;

procedure TfrmConfEmbColorPro.pConstruirGrid;
begin
  pSelecionaLinhas;

  cdsLinhas.First;
  While Not cdsLinhas.Eof Do
  Begin

    pSelecionaConfiguracao;

    cdsLinhas.Next;
  End;

  dbgViewConsulta.NavigatorButtons.First.Click;
  dbgViewConsulta.ViewData.Collapse(True);
end;

procedure TfrmConfEmbColorPro.pCriaClientPrincipal;
begin
  cdsEmb.CreateDataSet;
  cdsEmb.IndexFieldNames := 'DESLIN';
end;

procedure TfrmConfEmbColorPro.pSalvarEmbalagens;
var
  qryCfgTin: TUniQuery;
begin
  Try
    qryCfgTin := fCriaQuery;
    With qryCfgTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT *                                   ');
      SQL.Add('   FROM CFGTIN                              ');
      SQL.Add('  WHERE CFG_CODEMP = :CODEMP                ');
      SQL.Add('    AND CFG_IDEPRO = "WCP"                  ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES"        ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      cdsEmb.DisableControls;
      cdsEmb.First;
      While Not cdsEmb.Eof Do
      Begin
        If qryCfgTin.Locate('CFG_CODCFG', cdsEmbCODCFG.AsString, []) Then
        Begin
          qryCfgTin.Edit;
          qryCfgTin.FieldByName('CFG_VALCFG').AsString := cdsEmbVALCFG.AsString;
          qryCfgTin.Post;
        End;

        cdsEmb.Next;
      End;
    End;
  Finally
    FreeAndNil(qryCfgTin);
    cdsEmb.EnableControls;
  End;
end;

procedure TfrmConfEmbColorPro.pSelecionaConfiguracao;
var
  qryCfgTin: TUniQuery;
begin
  Try
    qryCfgTin := fCriaQuery;
    With qryCfgTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT *                                   ');
      SQL.Add('   FROM CFGTIN                              ');
      SQL.Add('  WHERE CFG_CODEMP = :CODEMP                ');
      SQL.Add('    AND CFG_IDEPRO = "WCP"                  ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES"        ');
      SQL.Add('    AND LOCATE(:NOMLIN, CFG_DESCRI) > 0     ');
      SQL.Add('    AND LOCATE("ITEM EMB.", CFG_DESCRI) > 0 ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NOMLIN').AsString := cdsLinhas.FieldByName('WAN_NOMLIN').AsString;
      Open;

      First;
      While Not Eof Do
      Begin
        cdsEmb.Append;
        cdsEmbDESLIN.AsString := cdsLinhas.FieldByName('WAN_NOMLIN').AsString;
        cdsEmbEMBALA.AsString := fRetEmbalagem(qryCfgTin.FieldByName('CFG_CODCFG').AsString);
        cdsEmbVALCFG.AsString := qryCfgTin.FieldByName('CFG_VALCFG').AsString;
        cdsEmbDESCFG.AsString := fRetNomProduto(qryCfgTin.FieldByName('CFG_VALCFG').AsString);
        cdsEmbCODCFG.AsString := qryCfgTin.FieldByName('CFG_CODCFG').AsString;
        cdsEmb.Post;

        qryCfgTin.Next;
      End;
    End;
  Finally
    FreeAndNil(qryCfgTin);
  End;
end;

procedure TfrmConfEmbColorPro.pSelecionaLinhas;
Var
  qryLinhas: TUniQuery;
begin
  Try
    qryLinhas := fCriaQuery;
    With qryLinhas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT *             ');
      SQL.Add('   FROM WANPRO_CADLIN ');
      SQL.Add('  WHERE LPAD(WAN_CODLIN, 3, "0") IN (' + fFormataLinhasConfiguradas + ') ');
      SQL.Add('  ORDER BY WAN_NOMLIN ');
      Open;

      cdsLinhas := fCriaClientDatset(qryLinhas);
    End;
  Finally
    FreeAndNil(qryLinhas);
  End;
end;

procedure TfrmConfEmbColorPro.pValidaProduto(strCodIte: String);
begin
  If (Not fEmptyStr(strCodIte)) And fEmptyStr(cdsEmb.FieldByName('DESCFG').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
    pAtualizaProduto('');
  End;
end;

end.


