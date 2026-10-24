unit untSelItensImprimirSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, UITypes,
  Uni, UniClientDataSet;

type
  TfrmSelItensImprimirSeparacao = class(TfrmPaiConfirma)
    pnlLegendas: TPanel;
    shpEditavel: TShape;
    lblEditavel: TLabel;
    cxgItens: TcxGridCitel;
    cxgItensDBTableView: TcxGridDBTableViewCitel;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensQTDSEP: TcxGridDBColumn;
    cxgItensLevel: TcxGridLevel;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    dtsItens: TDataSource;
    cxgItensSEPARA: TcxGridDBColumn;
    btnReimprimir: TBitBtnLocked;
    procedure cxgItensDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgItensQTDSEPPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
  private
    { Private declarations }
    FConsiderarJaSeparado: Boolean;

    procedure pCriaDataSetItens;
    procedure pMarcaDesmarcaTodos(AMarcar: Boolean = True);

    function fValidaMultiplo(var AQtdSep: Double): Boolean;
    function fConfirma: Boolean;
    function fValidaQuantidadeSeparada: Boolean;
    function fPermiteReimpressao: Boolean;
    function fPossuiSeparacaoJaImpressa: Boolean;
    procedure pReimprimeSeparacao(const ASeqSep: Integer);
  public
    { Public declarations }
    FItens: TUniClientDataSet;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strCodVen: String;
    intSeqSep: Integer;
  end;

implementation

uses
  untFuncoesSimples, untLiberacao, untReimpressao, Separacao.Classes.Parcial,
  untTypesSistema;

{$R *.dfm}

procedure TfrmSelItensImprimirSeparacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  if (FItens.State <> dsBrowse) then
    FItens.Post;

  if (not fValidaQuantidadeSeparada) then
  begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade a separar!', ['&Ok']);
    Exit;
  end;

  if (not fConfirma) then
  begin
    ModalResult := mrCancel;
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TfrmSelItensImprimirSeparacao.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmSelItensImprimirSeparacao.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos;
end;

procedure TfrmSelItensImprimirSeparacao.btnReimprimirClick(Sender: TObject);
var
  LSeqSep: Integer;
begin
  inherited;

  if (not btnReimprimir.Visible) then
    Exit;

  if (not fPossuiSeparacaoJaImpressa) then
  begin
    pMensagemOk('Este documento não possui separação impressa.');
    Exit;
  end;

  if (not fPermiteReimpressao) then
    Exit;

  if SelecionaSeparacaoParcial(strNumDoc, strEspDoc, strCodEmp, LSeqSep) then
    pReimprimeSeparacao(LSeqSep);
end;

procedure TfrmSelItensImprimirSeparacao.cxgItensDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := shpEditavel.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmSelItensImprimirSeparacao.cxgItensQTDSEPPropertiesEditValueChanged(
  Sender: TObject);
var
  LQtdSep: Double;
begin
  inherited;

  if (cxgItensDBTableView.Controller.FocusedColumn.Name <> 'cxgItensQTDSEP') then
    Exit;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    Exit;

  LQtdSep := fStrToFloat(TcxTextEdit(Sender).Text);

  if FConsiderarJaSeparado and (LQtdSep > (FItens.FieldByName('QTDITE').AsFloat - FItens.FieldByName('SEPARA').AsFloat)) then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitido quantidade a separar maior que a quantidade disponível!', ['&Ok']);
    FItens.Cancel;
    Exit;
  end
  else if (LQtdSep > FItens.FieldByName('QTDITE').AsFloat) then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitido quantidade a separar maior que a quantidade do item do pedido!', ['&Ok']);
    FItens.Cancel;
    Exit;
  end;

  if (not fValidaMultiplo(LQtdSep)) then
    FItens.FieldByName('QTDSEP').AsFloat := LQtdSep;
end;

function TfrmSelItensImprimirSeparacao.fConfirma: Boolean;
begin
  Result := GravaSeparacaoParcialPedido(FItens, strNumDoc, strEspDoc, strCodEmp, intSeqSep);
end;

procedure TfrmSelItensImprimirSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSetItens;
  FConsiderarJaSeparado := fCfgSis('SPCIMP', varBoolean);
  intSeqSep := 0;

  if (not FConsiderarJaSeparado) then
  begin
    Self.Width := Self.Width - cxgItensSEPARA.Width;
    cxgItensSEPARA.Visible := False;
    btnReimprimir.Visible  := False;
  end;
end;

procedure TfrmSelItensImprimirSeparacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F5 : btnMarcarTodos.Click;
    VK_F6 : btnDesmarcarTodos.Click;
    VK_F7 : btnReimprimir.Click;
    VK_F10: btnConfirma.Click;
  end;
end;

procedure TfrmSelItensImprimirSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := Self.Caption + ' - ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp;
end;

function TfrmSelItensImprimirSeparacao.fPermiteReimpressao: Boolean;
var
  objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('Expedição - Reimprimir Separação de Produtos');
    objLiberacao.objMsgLibera.pAddTexto('Documentos que já tiveram a separação impressa:');
    objLiberacao.objMsgLibera.pAddTexto(strNumDoc +'-'+ strEspDoc +'-'+ strCodEmp);
    objLiberacao.strDirAce := 'RIMPSE';
    objLiberacao.strMsgSen := 'Expedição - Reimprimir Separação de Produtos';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
end;

function TfrmSelItensImprimirSeparacao.fPossuiSeparacaoJaImpressa: Boolean;
begin
  Result := GetQuantSeparacaoJaImpressa(strNumDoc, strEspDoc, strCodEmp) > 0;
end;

function TfrmSelItensImprimirSeparacao.fValidaMultiplo(var AQtdSep: Double): Boolean;
var
  LMltVen,
  LValor: Double;
begin
  Result := True;

  LMltVen := fCampoTabela('ITE_MLTVEN', 'CADITE', ['ITE_CODITE'], [FItens.FieldByName('CODITE').AsString]);

  if (LMltVen <= 0) then
    LMltVen := 1;

  LValor := fFormataFloatInterna(AQtdSep / LMltVen, 4);

  if ((LValor - Int(LValor)) > 0) then
  begin
    AQtdSep := Int(((AQtdSep + LMltVen) / LMltVen)) * LMltVen;
    fMensagem('', 'A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(LMltVen, ffNumber, 12, 3), ['&OK']);
    Result := False;
  end;
end;

function TfrmSelItensImprimirSeparacao.fValidaQuantidadeSeparada: Boolean;
var
  LClone: TUniClientDataSet;
begin
  LClone := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(LClone, FItens);

    LClone.Filtered := False;
    LClone.Filter := 'QTDSEP > 0';
    LClone.Filtered := True;

    Result := (LClone.RecordCount > 0);
  finally
    FreeAndNil(LClone);
  end;
end;

procedure TfrmSelItensImprimirSeparacao.pCriaDataSetItens;
begin
  FItens := TUniClientDataSet.Create(Self);
  FItens.FieldDefs.Add('AUTINC', ftString, 20);
  FItens.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  FItens.FieldDefs.Add('DESITE', ftString, 50);
  FItens.FieldDefs.Add('QTDITE', ftFloat);
  FItens.FieldDefs.Add('QTDSEP', ftFloat);
  FItens.FieldDefs.Add('QTDANT', ftFloat);
  FItens.FieldDefs.Add('SEPARA', ftFloat);
  FItens.CreateDataSet;

  (FItens.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('QTDSEP') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('QTDSEP') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('QTDANT') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('SEPARA') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItens.FieldByName('SEPARA') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  dtsItens.DataSet := FItens;
end;

procedure TfrmSelItensImprimirSeparacao.pMarcaDesmarcaTodos(AMarcar: Boolean = True);
var
  LBookmark: TBookmark;
begin
  inherited;

  LBookmark := FItens.GetBookmark;
  FItens.First;

  try
    while not FItens.Eof do
    begin
      FItens.Edit;

      if AMarcar then
        FItens.FieldByName('QTDSEP').AsFloat := IIF(FConsiderarJaSeparado,
                                                    FItens.FieldByName('QTDITE').AsFloat - FItens.FieldByName('SEPARA').AsFloat,
                                                    FItens.FieldByName('QTDITE').AsFloat)
      else
        FItens.FieldByName('QTDSEP').AsFloat := 0;

      FItens.Post;

      FItens.Next;
    end;
  finally
    FItens.GotoBookmark(LBookmark);
    FItens.FreeBookmark(LBookmark);
  end;
end;

procedure TfrmSelItensImprimirSeparacao.pReimprimeSeparacao(const ASeqSep: Integer);
var
  objImpSep: TReimpressao;
begin
  objImpSep := TReimpressao.Create(strNumDoc,
                                   strEspDoc,
                                   0,
                                   0,
                                   strCodCli,
                                   strCodEmp,
                                   strCodVen,
                                   False,
                                   '',
                                   (fCfgSis('SEPEXP') = 'E'),
                                   False,
                                   False,
                                   '',
                                   '',
                                   False,
                                   0,
                                   False,
                                   '');
  try
    objImpSep.blnExpedicao := True;
    objImpSep.blnReimpressaoDaSeparacaoPedido := True;

    objImpSep.fImprimeSeparacao('',
                                False,
                                False,
                                False,
                                True,
                                False,
                                opcNaoSolicitado,
                                False,
                                VS_strExpRetiraEntrega,
                                False,
                                ASeqSep);
  finally
    FreeAndNil(objImpSep);
  end;
end;

end.