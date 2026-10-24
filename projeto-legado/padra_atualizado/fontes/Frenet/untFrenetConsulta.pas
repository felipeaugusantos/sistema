unit untFrenetConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass, Math,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, System.UITypes,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncFatTypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  FrenetJSON.Classes, FrenetWS.Classes, Uni, untFuncFat, System.StrUtils, cxProgressBar,
  QualP.Classe.Controle, untEndPartidaConsFrete;

type
  TTypeFrete = (tfFrenet, tfQualP, tfDataFrete, tfIntelipost);

  TfrmFrenetConsulta = class(TfrmPaiSimples)
    dtsFrenet: TDataSource;
    btnFrenetOk: TBitBtnLocked;
    tsTransportadoras: TTabSheet;
    tsItens: TTabSheet;
    dtsItens: TDataSource;
    cxGridCitel2DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel2Level1: TcxGridLevel;
    cxGridCitel2: TcxGridCitel;
    cxGridCitel2DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1Column3: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1Column4: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1Column5: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1Column6: TcxGridDBColumn;
    pnlQualP: TPanel;
    pnlFrenet: TPanel;
    btnQualpOk: TBitBtnLocked;
    gpbFrenet: TGroupBox;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn;
    ERROR_: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    Panel2: TPanel;
    lblCepDeEntrega: TLabel;
    edtCepDeEntrega: TEdit;
    pnlDataFrete: TPanel;
    gpbDataFrete: TGroupBox;
    cxgDataFrete: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlSuperiorDataFrete: TPanel;
    lblCepDataFrete: TLabel;
    edtCepDataFrete: TEdit;
    dtsDataFrete: TDataSource;
    btnDataFrete: TBitBtnLocked;
    pnlEndPartida: TPanel;
    lblEndPartida: TLabel;
    btnIntelipost: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    dtsIntelipost: TDataSource;
    pnlIntelipost: TPanel;
    gpbIntelipost: TGroupBox;
    cxgIntelipost: TcxGridCitel;
    cxGridDBTableViewCitel2: TcxGridDBTableViewCitel;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    Panel1: TPanel;
    lblCepIntelipost: TLabel;
    edtCepIntelipost: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnFrenetOkClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxGridCitel1DBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnQualpOkClick(Sender: TObject);
    procedure btnDataFreteClick(Sender: TObject);
    procedure btnIntelipostClick(Sender: TObject);

  private
    { Private declarations }
    FcdsTransportadoras      : TUniClientDataSet;
    FcdsItens                : TUniClientDataSet;
    FobjRootServices         : TRootServices;
    FfltFatorReducao         : Double;
    FstrCodigoTransportadora : String;
    FfltValorDoFrete         : Double;
    FstrMensagemDoFrete      : String;
    FfltValorSubsidiado      : Double;
    FControleQualP           : TControleQualP;
    FStrCodRot               : String;
    FEndPartida              : TRecEnderecoPartida;
    FcdsTransportadorasDataFrete: TUniClientDataSet;
    FcdsTransportadorasIntelipost: TUniClientDataSet;

    procedure pConfiguraFrenet;
    procedure pConfiguraDataFrete;
    procedure pConfiguraIntelipost;
    procedure pConfiguraItens;

    function GetPlacaVeiculo: String;

    function fConsiderarSomenteItensEntrega: Boolean;
    function fConsultarFreteWS(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fConsultarFreteDataFreteWS(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fConsultarFreteIntelipostWS(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure pAdicionaTranspostadoraCliente(
      const AShippingSevices: TShippingSevices; const AQuery: TUniQuery;
      const AblnCorreioNaoCadastrado: Boolean; const ACodigoFrenet: String);
    procedure pAlimentarClientTransportadoras;
    procedure pAtualizaItens(TypeFrete: TTypeFrete);
    procedure pAlimentaClientItens;
    procedure pRealizarIntegracao(TypeFrete: TTypeFrete);

    procedure pGravarDadosFrete(const ATipoFrete: TTypeFrete);
    function fItemEhEntregaImediata(const item: TDadosFechamento): Boolean;
  public
    { Public declarations }
    fatVenda : TFatVenda;

    property strCodigoTransportadora : String read FstrCodigoTransportadora write FstrCodigoTransportadora;
    property fltValorDoFrete         : Double read FfltValorDoFrete         write FfltValorDoFrete;
    property strMensagemDoFrete      : String read FstrMensagemDoFrete      write FstrMensagemDoFrete;
    property strPlacaVeiculo         : String read GetPlacaVeiculo;
    property strCodRot               : String                               write FStrCodRot;
    property recEndPartida           : TRecEnderecoPartida read FEndPartida write FEndPartida;
  end;

implementation

uses untFuncoesSimples, untGravando, untDataFreteCalcularFrete,
  untIntelipost.QuoteByProduct;

{$R *.dfm}

{ TfrmFrenetConsulta }

procedure TfrmFrenetConsulta.btnConfirmarClick(Sender: TObject);
  var
    LQueryPeso      : TUniQuery;
    LQueryDimensoes : TUniQuery;
begin
  inherited;

  if (not pnlFrenet.Visible) and
     (not pnlDataFrete.Visible) and
     (not pnlIntelipost.Visible) then

  FcdsItens.First;
  while not FcdsItens.Eof do
  Begin
    if FcdsItens.FieldBYName('ITE_PESO__').AsFloat < 0 then
    Begin
      fMensagem('Atenção','Peso inválido do produto "'+FcdsItens.FieldBYName('ITE_NOMITE').AsString+'", o mesmo deve ser maior que zero. Favor revisar',['&OK']);
      Exit;
    End;

    FcdsItens.next;
  End;

  LQueryPeso      := fCriaQuery(nil);
  LQueryDimensoes := fCriaQuery(nil);
  Try
    LQueryPeso.SQL.Text := 'UPDATE CADITE SET ITE_PESOIT = :PESOIT WHERE ITE_CODITE = :CODITE ';

    LQueryDimensoes.SQL.Text := 'UPDATE DESSIT SET ITE_EXPALT = :EXPALT, ITE_EXPLAR = :EXPLAR, ITE_EXPPRO = :EXPPRO WHERE ITE_CODITE = :CODITE ';

    FcdsItens.First;
    while not FcdsItens.Eof do
    Begin
      LQueryPeso.ParamByName('CODITE').AsString := FcdsItens.FieldBYName('ITE_CODITE').AsString;
      LQueryPeso.ParamByName('PESOIT').AsFloat  := FcdsItens.FieldBYName('ITE_PESO__').AsFloat;
      LQueryPeso.ExecSql;

      LQueryDimensoes.ParamByName('CODITE').AsString := FcdsItens.FieldBYName('ITE_CODITE').AsString;
      LQueryDimensoes.ParamByName('EXPALT').AsFloat  := FcdsItens.FieldBYName('ITE_ALTURA').AsFloat;
      LQueryDimensoes.ParamByName('EXPLAR').AsFloat  := FcdsItens.FieldBYName('ITE_LARGUR').AsFloat;
      LQueryDimensoes.ParamByName('EXPPRO').AsFloat  := FcdsItens.FieldBYName('ITE_PROFUN').AsFloat;
      LQueryDimensoes.ExecSql;

      FcdsItens.next;
    End;

  Finally
    freeAndNil(LQueryPeso);
    freeAndNil(LQueryDimensoes);
  End;

  if pnlFrenet.Visible then
    pRealizarIntegracao(tfFrenet);

  if pnlDataFrete.Visible then
    pRealizarIntegracao(tfDataFrete);

  if pnlIntelipost.Visible then
    pRealizarIntegracao(tfIntelipost);
end;

procedure TfrmFrenetConsulta.btnDataFreteClick(Sender: TObject);
var
  LblnValidado : Boolean;
begin
  inherited;

  LblnValidado := True;

  if FcdsTransportadorasDataFrete.IsEmpty  then
  Begin
    fMensagem('Atenção','Nenhuma transportadora foi selecionada.',['&OK']);
    LblnValidado := False;
  End
  else if fEmptyStr(FcdsTransportadorasDataFrete.FieldByName('TRA_CODTRA').AsString) then
  Begin
    fMensagem('Atenção','Transportadora sem vínculo no AutCom. Vá até o cadastro de transportadoras, vincule e/ou crie a '+
    'transportadora informando no campo: ' + sLineBreak +
    'Cód. Transp. DataFrete: '+FcdsTransportadorasDataFrete.FieldByName('TRA_CODDTF').AsString + sLineBreak +
    'Razão: '+FcdsTransportadorasDataFrete.FieldByName('TRA_NOMTRA').AsString + sLineBreak +
    'CNPJ: '+FcdsTransportadorasDataFrete.FieldByName('TRA_C_G_C_').AsString,['&OK']);
    LblnValidado := False;
  End;

  if LblnValidado then
  Begin
    Self.FstrCodigoTransportadora := FcdsTransportadorasDataFrete.FieldByName('TRA_CODTRA').AsString;
    Self.FfltValorDoFrete         := FcdsTransportadorasDataFrete.FieldByName('TRA_VLRFRE').AsFloat;
    If fCfgSis('AMPTED', varBoolean) Then
      Self.FstrMensagemDoFrete      := 'ENTREGA EM ATÉ '+IntToStr(FcdsTransportadorasDataFrete.FieldByName('TRA_DIAENT').AsInteger)+' DIAS ÚTEIS APÓS A LIBERAÇÃO DO PEDIDO';
    pGravarDadosFrete(tfDataFrete);

    Self.ModalResult := mrOK;
  End;

end;

procedure TfrmFrenetConsulta.btnIntelipostClick(Sender: TObject);
var
  LblnValidado : Boolean;
begin
  inherited;

  LblnValidado := True;

  if FcdsTransportadorasIntelipost.IsEmpty  then
  Begin
    fMensagem('Atenção','Nenhuma transportadora foi selecionada.',['&OK']);
    LblnValidado := False;
  End
  else if fEmptyStr(FcdsTransportadorasIntelipost.FieldByName('TRA_CODTRA').AsString) then
  Begin
    fMensagem('Atenção','Transportadora sem vínculo no AutCom. Vá até o cadastro de transportadoras, vincule e/ou crie a '+
    'transportadora informando no campo: ' + sLineBreak +
    'Cód. Transp. Intelipost: '+FcdsTransportadorasIntelipost.FieldByName('TRA_CODITP').AsString + sLineBreak +
    'Razão: '+FcdsTransportadorasIntelipost.FieldByName('TRA_NOMTRA').AsString + sLineBreak,['&OK']);
    LblnValidado := False;
  End;

  if LblnValidado then
  Begin
    Self.FstrCodigoTransportadora := FcdsTransportadorasIntelipost.FieldByName('TRA_CODTRA').AsString;
    Self.FfltValorDoFrete         := FcdsTransportadorasIntelipost.FieldByName('TRA_VLRFRE').AsFloat;
    Self.FstrMensagemDoFrete      := 'ENTREGA EM ATÉ '+IntToStr(FcdsTransportadorasIntelipost.FieldByName('TRA_DIAENT').AsInteger)+' DIAS ÚTEIS APÓS A LIBERAÇÃO DO PEDIDO';
    pGravarDadosFrete(tfIntelipost);

    Self.ModalResult := mrOK;
  End;
end;

procedure TfrmFrenetConsulta.btnFrenetOkClick(Sender: TObject);
  var
    LblnValidado : Boolean;
begin
  inherited;

  LblnValidado := True;

  if FcdsTransportadoras.IsEmpty  then
  Begin
    fMensagem('Atenção','Nenhuma transportadora foi selecionada.',['&OK']);
    LblnValidado := False;
  End
  else if fEmptyStr(FcdsTransportadoras.FieldByName('TRA_CODTRA').AsString) then
  Begin
    fMensagem('Atenção','Transportadora sem vínculo no AutCom. Vá até o cadastro de transportadoras, vincule e/ou crie a '+
    'transportadora informando no campo "Código da Transportadora pela Frenet" o código: "'+FcdsTransportadoras.FieldByName('TRA_CODFRE').AsString+'"'+
    IIF(fEmptyStr(FcdsTransportadoras.FieldByName('TRA_DESCRI').AsString),'',', lembrando de incluir na descrição da transportadora a palavra: "'+FcdsTransportadoras.FieldByName('TRA_DESCRI').AsString+'"')+'.',['&OK']);
    LblnValidado := False;
  End
  else if FcdsTransportadoras.FieldByName('TRA_ERROR_').AsBoolean then
  Begin
    fMensagem('Atenção','Transportadora indisponível para uso!'+#10#13+'Motivo: '+FcdsTransportadoras.FieldByName('TRA_MSGERR').AsString,['&OK']);
    LblnValidado := False;
  End;

  if LblnValidado then
  Begin
    Self.FstrCodigoTransportadora := FcdsTransportadoras.FieldByName('TRA_CODTRA').AsString;
    Self.FfltValorDoFrete         := FcdsTransportadoras.FieldByName('TRA_VLRFRE').AsFloat;
    If fCfgSis('AMPTEF', varBoolean) Then
      Self.FstrMensagemDoFrete      := 'ENTREGA EM ATÉ '+IntToStr(FcdsTransportadoras.FieldByName('TRA_DIAENT').AsInteger)+' DIAS ÚTEIS APÓS A LIBERAÇÃO DO PEDIDO';
    pGravarDadosFrete(tfFrenet);

    Self.ModalResult := mrOK;
  End;

end;

procedure TfrmFrenetConsulta.btnQualpOkClick(Sender: TObject);
var
  LValidado : Boolean;
begin
  inherited;

  LValidado := True;

  if fEmptyStr(FControleQualP.PlacaVeiculo)  then
  begin
    fMensagem('Atenção','Nenhum veículo foi selecionado.',['&OK']);
    LValidado := False;
  end;

  if LValidado then
  Begin
    Self.FfltValorDoFrete := FControleQualP.ValorTotalFrete;
    pGravarDadosFrete(tfQualP);

    Self.ModalResult := mrOK;
  End;
end;

procedure TfrmFrenetConsulta.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.ModalResult := mrClose;
  Self.Close;
end;

procedure TfrmFrenetConsulta.cxGridCitel1DBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (ACanvas.Brush.Color <> clHighlight) Then
    ACanvas.Brush.Color := clWindow;

  ACanvas.Font.Color := clBlack;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ERROR_.Index] Then
    ACanvas.Font.Color := clRed;

  If (ACanvas.Brush.Color = clHighlight) Then
    ACanvas.Font.Color := clWhite;
end;

procedure TfrmFrenetConsulta.FormCreate(Sender: TObject);
begin
  inherited;
  FControleQualP      := nil;
  FcdsTransportadoras := nil;
  FcdsItens           := nil;
  FobjRootServices    := nil;
  FStrCodRot          := EmptyStr;
  FcdsTransportadorasDataFrete := nil;
  FcdsTransportadorasIntelipost := nil;

  FillChar(FEndPartida, SizeOf(FEndPartida), #0);
end;

procedure TfrmFrenetConsulta.FormDestroy(Sender: TObject);
begin
  if Assigned(FcdsTransportadoras) then
    FreeAndNil(FcdsTransportadoras);

  if Assigned(FcdsItens) then
    FreeAndNil(FcdsItens);

  if Assigned(FobjRootServices) then
    FreeAndNil(FobjRootServices);

  if Assigned(FControleQualP) then
    FreeAndNil(FControleQualP);

  if Assigned(FcdsTransportadorasDataFrete) then
    FreeAndNil(FcdsTransportadorasDataFrete);

  if Assigned(FcdsTransportadorasIntelipost) then
    FreeAndNil(FcdsTransportadorasIntelipost);

  inherited;
end;


procedure TfrmFrenetConsulta.FormShow(Sender: TObject);
var
  strIntegrando: String;
begin
  inherited;
  pnlEndPartida.Visible := fCfgSis('ENPAFR', varBoolean);
  pnlIntelipost.Visible := (fCfgSis('ITPUTI', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));
  pnlDataFrete.Visible := (fCfgSis('DTFUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));
  pnlQualP.Visible := (fCfgSis('QLPUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));
  pnlFrenet.Visible := (fCfgSis('FREUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));

  btnFrenetOk.Visible := pnlFrenet.Visible;
  btnQualpOk.Visible := pnlQualP.Visible;
  btnDataFrete.Visible := pnlDataFrete.Visible;
  btnIntelipost.Visible := pnlIntelipost.Visible;
  btnConfirmar.Visible := False;

  strIntegrando := IIF(pnlFrenet.Visible, 'Frenet', '');
  strIntegrando := strIntegrando + IIF(pnlQualP.Visible, IIF(not fEmptyStr(strIntegrando),'/', '')+'Qualp', '');
  strIntegrando := strIntegrando + IIF(pnlDataFrete.Visible, IIF(not fEmptyStr(strIntegrando),'/', '')+'DataFrete', '');
  strIntegrando := strIntegrando + IIF(pnlIntelipost.Visible, IIF(not fEmptyStr(strIntegrando),'/', '')+'Intelipost', '');
  Self.Caption := 'Consulta de Frete ' + strIntegrando;

  if pnlFrenet.Visible then
  begin
    pConfiguraFrenet;

    If (fCfgSis('UTPEDE', varInteger) = 2) Then
      FfltFatorReducao := fCampoTabela('PER_PERCEN', 'PERAPL', ['PER_ESTADO'], [fatVenda.strCliEst])
    Else
      FfltFatorReducao := fCfgSis('FREFT'+fatVenda.strTabPre, varDouble);

    pRealizarIntegracao(tfFrenet);

    if dtsFrenet.DataSet.Active then
      dtsFrenet.DataSet.First;

    pSetFocus(cxGridCitel1);
  end
  else
  begin
    Self.Height := Self.Height
                 - pnlFrenet.Height;
  end;

  if pnlQualP.Visible then
  begin
    FControleQualP := TControleQualP.Create;

    FControleQualP
      .fSetFatVenda(fatVenda)
      .fSetPainelQualP(pnlQualP)
      .fSetCodRot(FStrCodRot)
      .fSetCepPartida(FEndPartida.strCep)
      .fExecutar;

    if not pnlFrenet.Visible then
      pSetFocus(pnlQualP);
  end
  else
  begin
    Self.Height := Self.Height
                 - pnlQualP.Height;
  end;

  if pnlDataFrete.Visible then
  begin
    pConfiguraDataFrete;

    if pgcDados.ActivePage <> tsTransportadoras then
      Exit;

    pRealizarIntegracao(tfDataFrete);

    if dtsDataFrete.DataSet.Active then
      dtsDataFrete.DataSet.First;

    pSetFocus(cxgDataFrete);
  end
  else
  begin
    Self.Height := Self.Height
                 - pnlDataFrete.Height;
  end;

  if pnlIntelipost.Visible then
  begin
    pConfiguraIntelipost;

    if pgcDados.ActivePage <> tsTransportadoras then
      Exit;

    pRealizarIntegracao(tfIntelipost);

    if dtsIntelipost.DataSet.Active then
      dtsIntelipost.DataSet.First;

    pSetFocus(cxgIntelipost);
  end
  else
  begin
    Self.Height := Self.Height
                 - pnlIntelipost.Height;
  end;

  If pnlEndPartida.Visible Then
  Begin
    Self.Height := Self.Height + pnlEndPartida.Height;

    lblEndPartida.Caption := 'Endereço de partida: (' + FEndPartida.strDescricao + ') ' +
                             FEndPartida.strEndereco + ' - ' +
                             FEndPartida.strBairro + ' - ' +
                             FEndPartida.strCidade +
                             ' - CEP: ' + fFormataCEP(FEndPartida.strCep);
  End;
end;

function TfrmFrenetConsulta.GetPlacaVeiculo: String;
begin
  Result := FControleQualP.PlacaVeiculo;
end;

procedure TfrmFrenetConsulta.pRealizarIntegracao(TypeFrete: TTypeFrete);
  var
    frmIntegrando : TfrmGravando;
    strIntegracao: String;
begin
  pgcDados.ActivePage   := tsTransportadoras;
  btnFrenetOk.Visible   := True and pnlFrenet.Visible;
  btnCancelar.Visible   := True;
  btnConfirmar.Visible  := False;
  btnQualpOk.Visible    := True and pnlQualp.Visible;
  btnDataFrete.Visible  := True and pnlDataFrete.Visible;
  btnIntelipost.Visible := True and pnlIntelipost.Visible;

  Try
    pCriarFormularios(TfrmGravando, frmIntegrando);
    if TypeFrete = tfFrenet then
      frmIntegrando.fExecutarAcao        := fConsultarFreteWS
    else if TypeFrete = tfDataFrete then
      frmIntegrando.fExecutarAcao        := fConsultarFreteDataFreteWS
    else if TypeFrete = tfIntelipost then
      frmIntegrando.fExecutarAcao        := fConsultarFreteIntelipostWS;

    strIntegracao := EmptyStr;
    case TypeFrete of
      tfFrenet: strIntegracao := 'Frenet';
      tfDataFrete: strIntegracao := 'DataFrete';
      tfIntelipost: strIntegracao := 'Intelipost';
    end;

    frmIntegrando.lblGravando.Caption  := 'Aguarde integração com a '+strIntegracao+'...';
    frmIntegrando.pgbStatus.Visible    := False;
    frmIntegrando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If Assigned(frmIntegrando) Then
    pFreeAndNil(frmIntegrando);
end;

procedure TfrmFrenetConsulta.pAtualizaItens(TypeFrete: TTypeFrete);
begin
  Self.Caption := 'Atualização das Dimensões\Pesos dos Itens';

  FcdsItens.EmptyDataSet;

  pAlimentaClientItens;

  if FcdsItens.Recordcount > 0 then
  Begin
    pgcDados.ActivePage   := tsItens;
    btnFrenetOk.Visible   := False;
    btnCancelar.Visible   := False;
    btnConfirmar.Visible  := True;
    btnQualpOk.Visible    := False;
    btnDataFrete.Visible  := False;
    btnIntelipost.Visible := False;
  End
  Else
    pRealizarIntegracao(TypeFrete);
end;

procedure TfrmFrenetConsulta.pConfiguraFrenet;
begin
  FcdsTransportadoras := TUniClientDataSet.Create(nil);
  FcdsTransportadoras.FieldDefs.Add('TRA_CODTRA', ftString,  8  , False);
  FcdsTransportadoras.FieldDefs.Add('TRA_CODFRE', ftString,  20 , False);
  FcdsTransportadoras.FieldDefs.Add('TRA_NOMTRA', ftString,  100, False);
  FcdsTransportadoras.FieldDefs.Add('TRA_DESCRI', ftString,  100, False);
  FcdsTransportadoras.FieldDefs.Add('TRA_DIAENT', ftInteger,   0, False);
  FcdsTransportadoras.FieldDefs.Add('TRA_VLRFRE', ftFloat,     0, False);
  FcdsTransportadoras.FieldDefs.Add('TRA_ERROR_', ftBoolean,   0, False);
  FcdsTransportadoras.FieldDefs.Add('TRA_MSGERR', ftString,  100, False);
  FcdsTransportadoras.CreateDataSet;
  FcdsTransportadoras.Open;

  pConfiguraItens;

  dtsFrenet.DataSet := FcdsTransportadoras;

  FobjRootServices := TRootServices.Create;
end;

procedure TfrmFrenetConsulta.pConfiguraDataFrete;
begin
  FcdsTransportadorasDataFrete := TUniClientDataSet.Create(nil);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_CODTRA', ftString,  008);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_CODDTF', ftString,  020);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_NOMTRA', ftString,  100);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_C_G_C_', ftString,  018);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_DESCRI', ftString,  100);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_PREENT', ftString,  010);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_DIAENT', ftInteger     );
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_VLRFRE', ftFloat       );
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_COTID_', ftString,  050);
  FcdsTransportadorasDataFrete.FieldDefs.Add('TRA_CODTAB', ftInteger, 000);
  FcdsTransportadorasDataFrete.CreateDataSet;
  FcdsTransportadorasDataFrete.Open;

  pConfiguraItens;

  dtsDataFrete.DataSet := FcdsTransportadorasDataFrete;
end;

procedure TfrmFrenetConsulta.pConfiguraIntelipost;
begin
  FcdsTransportadorasIntelipost := TUniClientDataSet.Create(nil);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_CODTRA', ftString,  008);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_CODITP', ftString,  020);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_NOMTRA', ftString,  100);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_DESCRI', ftString,  100);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_DIAENT', ftInteger     );
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_VLRFRE', ftFloat       );
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_QUOTID', ftString,  050);
  FcdsTransportadorasIntelipost.FieldDefs.Add('TRA_METHID', ftInteger, 000);
  FcdsTransportadorasIntelipost.CreateDataSet;
  FcdsTransportadorasIntelipost.Open;

  pConfiguraItens;

  dtsIntelipost.DataSet := FcdsTransportadorasIntelipost;
end;

procedure TfrmFrenetConsulta.pConfiguraItens;
begin
  if Assigned(FcdsItens) then
    Exit;

  FcdsItens := TUniClientDataSet.Create(nil);
  FcdsItens.FieldDefs.Add('ITE_CODITE', ftString,   8);
  FcdsItens.FieldDefs.Add('ITE_NOMITE', ftString, 100);
  FcdsItens.FieldDefs.Add('ITE_PESO__', ftFloat,    0);
  FcdsItens.FieldDefs.Add('ITE_LARGUR', ftFloat,    0);
  FcdsItens.FieldDefs.Add('ITE_ALTURA', ftFloat,    0);
  FcdsItens.FieldDefs.Add('ITE_PROFUN', ftFloat,    0);
  FcdsItens.CreateDataSet;
  FcdsItens.Open;

  dtsItens.Dataset := FcdsItens;
end;

procedure TfrmFrenetConsulta.pGravarDadosFrete(const ATipoFrete: TTypeFrete);
begin
  if ATipoFrete = tfFrenet then
  begin
    fatVenda.strQlpPlaVei := EmptyStr;
    fatVenda.fltQlpDist   := 0;
    fatVenda.fltQlpVlrCmb := 0;
    fatVenda.fltQlpVlrPed := 0;
    fatvenda.strFreTipApi := 'FRENET';

    fatvenda.blnFreFatRecalculado := True;
  end
  else
  if ATipoFrete = tfQualP then
  begin
    fatVenda.strQlpPlaVei := FControleQualP.PlacaVeiculo;
    fatVenda.fltQlpDist   := FControleQualP.Resposta.Distancia.Valor;
    fatVenda.fltQlpVlrCmb := FControleQualP.CustoCombustivel;
    fatVenda.fltQlpVlrPed := FControleQualP.CustoPedagio;
    fatvenda.strFreTipApi := 'QUALP';

    fatvenda.blnFreFatRecalculado := Self.FfltValorDoFrete > 0;
  end
  else
  if ATipoFrete = tfDataFrete then
  begin
    fatVenda.strQlpPlaVei := EmptyStr;
    fatVenda.fltQlpDist   := 0;
    fatVenda.fltQlpVlrCmb := 0;
    fatVenda.fltQlpVlrPed := 0;
    fatVenda.intCodTab := FcdsTransportadorasDataFrete.FieldByName('TRA_CODTAB').AsInteger;
    fatVenda.strCotId_ := FcdsTransportadorasDataFrete.FieldByName('TRA_COTID_').AsString;
    fatvenda.strFreTipApi := 'DATAFRETE';

    fatvenda.blnFreFatRecalculado := True;
  end
  else
  if ATipoFrete = tfIntelipost then
  begin
    fatVenda.strQlpPlaVei := EmptyStr;
    fatVenda.fltQlpDist   := 0;
    fatVenda.fltQlpVlrCmb := 0;
    fatVenda.fltQlpVlrPed := 0;
    fatVenda.intCodTab := FcdsTransportadorasIntelipost.FieldByName('TRA_METHID').AsInteger;
    fatVenda.strCotId_ := FcdsTransportadorasIntelipost.FieldByName('TRA_QUOTID').AsString;
    fatvenda.intDiasEnt := FcdsTransportadorasIntelipost.FieldByName('TRA_DIAENT').AsInteger;
    fatvenda.strFreTipApi := 'INTELIPOST';

    fatvenda.blnFreFatRecalculado := True;
  end;
end;

procedure TfrmFrenetConsulta.pAdicionaTranspostadoraCliente(
  const AShippingSevices: TShippingSevices; const AQuery: TUniQuery;
  const AblnCorreioNaoCadastrado: Boolean; const ACodigoFrenet: String);
begin
  FcdsTransportadoras.Append;
  FcdsTransportadoras.FieldByName('TRA_CODTRA').AsString := IIF(Not AblnCorreioNaoCadastrado, AQuery.FieldByName('TRA_CODTRA').AsString, '');
  FcdsTransportadoras.FieldByName('TRA_CODFRE').AsString := ACodigoFrenet;

  If Not fCfgSis('FRENTR', varBoolean) Then
  Begin
    FcdsTransportadoras.FieldByName('TRA_NOMTRA').AsString := IIF(AQuery.IsEmpty Or AblnCorreioNaoCadastrado,
                                                                  AShippingSevices.Carrier + IIF(AblnCorreioNaoCadastrado, ' - '+AShippingSevices.ServiceDescription, ''),
                                                                  AQuery.FieldByName('TRA_NOMTRA').AsString);
  End
  Else
  Begin
    FcdsTransportadoras.FieldByName('TRA_NOMTRA').AsString := IIF(AQuery.IsEmpty Or AblnCorreioNaoCadastrado,
                                                                  AShippingSevices.ServiceDescription,
                                                                  AQuery.FieldByName('TRA_NOMTRA').AsString);
  End;

  if (AShippingSevices.CarrierCode = fCfgSis('FRECOR', varString)) then
    FcdsTransportadoras.FieldByName('TRA_DESCRI').AsString := AShippingSevices.ServiceDescription;

  FcdsTransportadoras.FieldByName('TRA_ERROR_').AsBoolean := AShippingSevices.Error;

  If (FcdsTransportadoras.FieldByName('TRA_ERROR_').AsBoolean) Then
  Begin
    FcdsTransportadoras.FieldByName('TRA_MSGERR').AsString :=  AnsiReplaceStr(AShippingSevices.Msg, 'Erro: ', '');
  End
  Else
  Begin
    FcdsTransportadoras.FieldByName('TRA_DIAENT').AsInteger := StrToInt(AShippingSevices.DeliveryTime);

    FcdsTransportadoras.FieldByName('TRA_VLRFRE').AsFloat   := fFormataFloat((StrToFloat(AnsiReplaceStr(AShippingSevices.ShippingPrice,'.',','))) -
                                                               FfltValorSubsidiado, 2);

    if FcdsTransportadoras.FieldByName('TRA_VLRFRE').AsFloat < 0 then
      FcdsTransportadoras.FieldByName('TRA_VLRFRE').AsFloat := 0;
  End;

  FcdsTransportadoras.Post;
end;

procedure TfrmFrenetConsulta.pAlimentaClientItens;
  var
    LintCont  : Integer;
begin
  For LintCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If fConsiderarSomenteItensEntrega Then
      If fatVenda.arrMatItens[LintCont].strEntRet = 'R' then
        Continue;

    FcdsItens.Append;
    FcdsItens.FieldBYName('ITE_CODITE').AsString := fatVenda.arrMatItens[LintCont].strCodIte;
    FcdsItens.FieldBYName('ITE_NOMITE').AsString := fatVenda.arrMatItens[LintCont].strDesIte;
    FcdsItens.FieldBYName('ITE_PESO__').AsFloat  := fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
    FcdsItens.FieldBYName('ITE_LARGUR').AsFloat  := fCampoTabela('ITE_EXPLAR', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
    FcdsItens.FieldBYName('ITE_ALTURA').AsFloat  := fCampoTabela('ITE_EXPALT', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
    FcdsItens.FieldBYName('ITE_PROFUN').AsFloat  := fCampoTabela('ITE_EXPPRO', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
    FcdsItens.Post;
  End;

  FcdsItens.Last;
  while not FcdsItens.bof do
  Begin
    if FcdsItens.FieldBYName('ITE_PESO__').AsFloat > 0 then
      if FcdsItens.FieldBYName('ITE_LARGUR').AsFloat > 0 then
        if FcdsItens.FieldBYName('ITE_ALTURA').AsFloat > 0 then
          if FcdsItens.FieldBYName('ITE_PROFUN').AsFloat > 0 then
          Begin
            FcdsItens.Delete;
          End;

    FcdsItens.Prior;
  End;
end;

function TfrmFrenetConsulta.fConsiderarSomenteItensEntrega: Boolean;
begin
  Result := fCfgSis('FRENRE', varBoolean);
end;

procedure TfrmFrenetConsulta.pAlimentarClientTransportadoras;
  var
    LShippingSevices        : TShippingSevices;
    LQuery                  : TUniQuery;
    blnCorreioNaoCadastrado : Boolean;
    LCodigoFrenet           : String;
begin
  Try
    LQuery := fCriaQuery(nil);
    LQuery.SQL.Text := 'SELECT TRA_CODTRA, TRA_NOMTRA FROM CADTRA WHERE TRA_CODFRE = :CODFRE ';

    for LShippingSevices in FobjRootServices.ShippingSevicesArray do
    Begin
      if fCfgSis('FRESVC', varBoolean) then
        LCodigoFrenet := LShippingSevices.ServiceCode
      else
        LCodigoFrenet := LShippingSevices.CarrierCode;

      LQuery.ParamByName('CODFRE').AsString := LCodigoFrenet;
      LQuery.Open;

      blnCorreioNaoCadastrado := False;
      if LShippingSevices.CarrierCode = fCfgSis('FRECOR', varString) then
      Begin
        blnCorreioNaoCadastrado := True;

        LQuery.First;
        While Not LQuery.Eof Do
        Begin
          If Pos(AnsiUpperCase(LShippingSevices.ServiceDescription), AnsiUpperCase(LQuery.FieldByName('TRA_NOMTRA').AsString)) > 0 Then
          Begin
            blnCorreioNaoCadastrado := False;
            Break;
          End;

          LQuery.Next;
        End;
      End;

      pAdicionaTranspostadoraCliente(
        LShippingSevices, LQuery, blnCorreioNaoCadastrado, LCodigoFrenet);

      LQuery.Close;
    End;

    TStringField (FcdsTransportadoras.FieldByName('TRA_CODTRA')).Alignment := taCenter;
    TStringField (FcdsTransportadoras.FieldByName('TRA_CODFRE')).Alignment := taCenter;
    TStringField (FcdsTransportadoras.FieldByName('TRA_NOMTRA')).Alignment := taCenter;
    TIntegerField(FcdsTransportadoras.FieldByName('TRA_DIAENT')).Alignment := taCenter;
    TFloatField  (FcdsTransportadoras.FieldByName('TRA_VLRFRE')).Alignment := taRightJustify;


  Finally
    FreeAndNil(LQuery);
  End;

end;

function TfrmFrenetConsulta.fConsultarFreteDataFreteWS(
  pgbStatus: TcxProgressBar): Boolean;
var
  DataFreteCalcularFrete: TDataFreteCalcularFrete;
  RetornoDataFreteCalcularFrete: TRetornoDataFreteCalcularFrete;
  Produto: TProdutosClass;
  LintCont: Integer;

  qryAux: TUniQuery;
  data: TDataClass;
begin
  Result := False;

  edtCepDataFrete.Text := fFormataCEP(fatVenda.strCepEnt);

  DataFreteCalcularFrete := TDataFreteCalcularFrete.fNew;
  try
    DataFreteCalcularFrete.cepOrigem := StrToIntDef(fRetSomenteNumeros(
                                                    IIF(Not fEmptyStr(FEndPartida.strCep), FEndPartida.strCep,
                                                    fCampoTabela('EMP_C_E_P_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]))), 0);
    DataFreteCalcularFrete.cepDestino := StrToIntDef(fatVenda.strCepEnt, 0);

    for LintCont := 0 to Length(fatVenda.arrMatItens) -1 do
    begin
      if fatVenda.arrMatItens[LintCont].strEntRet = 'R' then
        Continue;

      Produto := DataFreteCalcularFrete.fNewProduto;
      Produto.descricao := fatVenda.arrMatItens[LintCont].strDesIte;
      Produto.sku := fatVenda.arrMatItens[LintCont].strCodIte;
      Produto.peso := fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
      Produto.altura := fCampoTabela('COALESCE(ITE_EXPALT,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]) / 100;
      Produto.largura := fCampoTabela('COALESCE(ITE_EXPLAR,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]) / 100;
      Produto.comprimento := fCampoTabela('COALESCE(ITE_EXPPRO,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]) / 100;
      Produto.preco := fatVenda.arrMatItens[LintCont].fltUniTar;
      Produto.qtd := fatVenda.arrMatItens[LintCont].fltQtdIte;
      Produto.volume := Ceil(fatVenda.arrMatItens[LintCont].fltEmbala);
    end;

    if Length(DataFreteCalcularFrete.produtos) <= 0 then
    begin
      fMensagem('Atenção','Nenhum item para ENTREGA foi encontrado no pedido para o cálculo do frete!',['&OK']);
      Exit;
    end;

    DataFreteCalcularFrete.InfComp.doc_empresa := fTiraCaracEspeciaisPonto(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]));
    DataFreteCalcularFrete.InfComp.doc_destinatario := '';

    If (Assigned(fatVenda)) Then
      DataFreteCalcularFrete.InfComp.doc_destinatario := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);

    RetornoDataFreteCalcularFrete := DataFreteCalcularFrete.fCalcularFrete;
    if Assigned(RetornoDataFreteCalcularFrete) then
    begin
      qryAux := fCriaQuery(nil);
      try
        for data in RetornoDataFreteCalcularFrete.data do
        begin
          if fEmptyStr(data.cod_transportador) then
            Continue;

          qryAux.Close;
          qryAux.SQL.Text := 'SELECT TRA_CODTRA, TRA_NOMTRA FROM CADTRA WHERE TRA_CODDTF = :CODDTF ';
          qryAux.ParamByName('CODDTF').AsString := data.cod_transportador;
          qryAux.Open;

          FcdsTransportadorasDataFrete.Append;
          FcdsTransportadorasDataFrete.FieldByName('TRA_CODTRA').AsString   := qryAux.FieldByName('TRA_CODTRA').AsString;
          FcdsTransportadorasDataFrete.FieldByName('TRA_CODDTF').AsString   := data.cod_transportador;
          FcdsTransportadorasDataFrete.FieldByName('TRA_NOMTRA').AsString   := data.nome_transportador;
          FcdsTransportadorasDataFrete.FieldByName('TRA_C_G_C_').AsString   := data.cnpj_transportador;
          FcdsTransportadorasDataFrete.FieldByName('TRA_DESCRI').AsString   := data.descricao;
          FcdsTransportadorasDataFrete.FieldByName('TRA_PREENT').AsString   := IIF(data.data_previsao_entrega = 0, 'N/A', data.data_previsao_entrega);
          FcdsTransportadorasDataFrete.FieldByName('TRA_DIAENT').AsExtended := data.data_previsao_entrega;
          FcdsTransportadorasDataFrete.FieldByName('TRA_VLRFRE').AsFloat    := data.valor_frete;
          FcdsTransportadorasDataFrete.FieldByName('TRA_CODTAB').AsString   := data.cod_tabela;
          FcdsTransportadorasDataFrete.FieldByName('TRA_COTID_').AsString   := RetornoDataFreteCalcularFrete.id_cotacao;
          FcdsTransportadorasDataFrete.Post;
        end;


        cxGridDBTableViewCitel1.BeginUpdate;
        try
          cxGridDBTableViewCitel1.ApplyBestFit();
        finally
          cxGridDBTableViewCitel1.EndUpdate;
        end;

      finally
        FreeAndNil(qryAux);
      end;
    end
    else
      pAtualizaItens(tfDataFrete);

  finally
    FreeAndNil(DataFreteCalcularFrete);

    if Assigned(RetornoDataFreteCalcularFrete) then
      FreeAndNil(RetornoDataFreteCalcularFrete);
  end;
end;

function TfrmFrenetConsulta.fConsultarFreteIntelipostWS(
  pgbStatus: TcxProgressBar): Boolean;
var
  IntelipostCalcularFrete: TQuoteByProduct;
  RetornoIntelipostCalcularFrete: TRetornoQuoteByProduct;
  Produto: TProductsClass;
  LintCont: Integer;

  qryAux: TUniQuery;
  deliveryOptions: TDelivery_optionsClass;

  blnTodosItensEstaoProntosParaIntegrar: Boolean;
begin
  Result := False;
  blnTodosItensEstaoProntosParaIntegrar := True;

  edtCepIntelipost.Text := fFormataCEP(fatVenda.strCepEnt);

  IntelipostCalcularFrete := TQuoteByProduct.fNew;
  try
    IntelipostCalcularFrete.origin_zip_code := fRetSomenteNumeros(fCampoTabela('EMP_C_E_P_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]));
    IntelipostCalcularFrete.destination_zip_code := fatVenda.strCepEnt;
    IntelipostCalcularFrete.quoting_mode := MODO_COTACAO;

    for LintCont := 0 to Length(fatVenda.arrMatItens) -1 do
    begin
      if not fItemEhEntregaImediata(fatVenda.arrMatItens[LintCont]) then
        Continue;

      Produto := IntelipostCalcularFrete.fNewProduto;
      Produto.sku_id := fatVenda.arrMatItens[LintCont].strCodIte;
      Produto.weight := fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
      Produto.height := fCampoTabela('COALESCE(ITE_EXPALT,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
      Produto.width  := fCampoTabela('COALESCE(ITE_EXPLAR,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
      Produto.length := fCampoTabela('COALESCE(ITE_EXPPRO,0)', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte]);
      Produto.cost_of_goods := fatVenda.arrMatItens[LintCont].fltTotIte;
      Produto.quantity := fatVenda.arrMatItens[LintCont].fltQtdIte;

      blnTodosItensEstaoProntosParaIntegrar := ((Produto.weight > 0) and (Produto.height > 0) and (Produto.width > 0) and (Produto.length > 0));
      if not blnTodosItensEstaoProntosParaIntegrar then
        Break;
    end;

    if not blnTodosItensEstaoProntosParaIntegrar then
    begin
      fMensagem('Atenção','Preencha as informações de peso e dimensões dos itens antes de realizar a cotação do frete.',['&OK']);
      pAtualizaItens(tfIntelipost);
      Exit;
    end;

    if Length(IntelipostCalcularFrete.products) <= 0 then
    begin
      fMensagem('Atenção','Apenas itens de entrega imediata são cotados. '+sLineBreak+
                          'Ajuste os itens do seu pedido para realizar a cotação do frete!',['&OK']);
      Exit;
    end;

    RetornoIntelipostCalcularFrete := IntelipostCalcularFrete.fCalcularFrete;

    if Assigned(RetornoIntelipostCalcularFrete) then
    begin
      qryAux := fCriaQuery(nil);
      try
        for deliveryOptions in RetornoIntelipostCalcularFrete.content.delivery_options do
        begin
          qryAux.Close;
          qryAux.SQL.Text := 'SELECT TRA_CODTRA, TRA_NOMTRA FROM CADTRA WHERE TRA_ITPUSA = "S" AND TRA_CODITP = :CODITP ';
          qryAux.ParamByName('CODITP').AsInteger := deliveryOptions.delivery_method_id;
          qryAux.Open;

          FcdsTransportadorasIntelipost.Append;
          FcdsTransportadorasIntelipost.FieldByName('TRA_CODTRA').AsString   := qryAux.FieldByName('TRA_CODTRA').AsString;
          FcdsTransportadorasIntelipost.FieldByName('TRA_CODITP').AsInteger  := deliveryOptions.delivery_method_id;
          FcdsTransportadorasIntelipost.FieldByName('TRA_NOMTRA').AsString   := deliveryOptions.delivery_method_name;
          FcdsTransportadorasIntelipost.FieldByName('TRA_DESCRI').AsString   := deliveryOptions.description;
          FcdsTransportadorasIntelipost.FieldByName('TRA_DIAENT').AsExtended := deliveryOptions.delivery_estimate_business_days;
          FcdsTransportadorasIntelipost.FieldByName('TRA_VLRFRE').AsExtended := deliveryOptions.final_shipping_cost;
          FcdsTransportadorasIntelipost.FieldByName('TRA_QUOTID').AsString   := FloatToStr(RetornoIntelipostCalcularFrete.content.id);
          FcdsTransportadorasIntelipost.FieldByName('TRA_METHID').AsInteger  := deliveryOptions.delivery_method_id;
          FcdsTransportadorasIntelipost.Post;
        end;


        cxGridDBTableViewCitel2.BeginUpdate;
        try
          cxGridDBTableViewCitel2.ApplyBestFit();
        finally
          cxGridDBTableViewCitel2.EndUpdate;
        end;

      finally
        FreeAndNil(qryAux);
      end;
    end;

  finally
    FreeAndNil(IntelipostCalcularFrete);

    if Assigned(RetornoIntelipostCalcularFrete) then
      FreeAndNil(RetornoIntelipostCalcularFrete);
  end;
end;

function TfrmFrenetConsulta.fConsultarFreteWS(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    LintCont: Integer;
    LobjFrenetJSONBuilder : TFrenetJSONBuilder;
    LstrLinha : String;
    LobjFrenetWS : TFrenetWS;
    LintCodigoRetorno : Integer;
    LstrMensagemRetorno : String;
    LstrJSON : String;
    LfltTotalVenda: Double;
begin
  Result := False;

  edtCepDeEntrega.Text := fFormataCEP(fatVenda.strCepEnt);

  LobjFrenetJSONBuilder := TFrenetJSONBuilder.Create;
  LobjFrenetWS          := TFrenetWS.Create;

  Try
    LobjFrenetJSONBuilder.CEPOrigem    := IIF(Not fEmptyStr(FEndPartida.strCep), FEndPartida.strCep,
                                              fCampoTabela('EMP_C_E_P_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False));
    LobjFrenetJSONBuilder.CEPDestino   := fatVenda.strCepEnt;
    LfltTotalVenda := 0;

    For LintCont := 0 To Length(fatVenda.arrMatItens) -1 Do
    Begin

      If fConsiderarSomenteItensEntrega Then
      Begin
        If fatVenda.arrMatItens[LintCont].strEntRet = 'R' then
          Continue;
      End;

      LfltTotalVenda := LfltTotalVenda + fatVenda.arrMatItens[LintCont].fltTotIte;

      LobjFrenetJSONBuilder.cdsItens.Append;
      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_CODIGO').AsString := fatVenda.arrMatItens[LintCont].strCodIte;
      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_QUANTI').AsString := StringReplace(FloatToStr(fatVenda.arrMatItens[LintCont].fltQtdIte), ',', '.', [rfReplaceAll]);

      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_PESO__').AsString :=
        StringReplace(FloatToStr(fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte])), ',', '.', [rfReplaceAll]);

      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_LARGUR').AsString :=
        StringReplace(FloatToStr(fCampoTabela('ITE_EXPLAR', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte])), ',', '.', [rfReplaceAll]);

      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_ALTURA').AsString :=
        StringReplace(FloatToStr(fCampoTabela('ITE_EXPALT', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte])), ',', '.', [rfReplaceAll]);

      LobjFrenetJSONBuilder.cdsItens.FieldBYName('ITE_COMPRI').AsString :=
        StringReplace(FloatToStr(fCampoTabela('ITE_EXPPRO', 'DESSIT', ['ITE_CODITE'], [fatVenda.arrMatItens[LintCont].strCodIte])), ',', '.', [rfReplaceAll]);
      LobjFrenetJSONBuilder.cdsItens.Post;
    End;

    LobjFrenetJSONBuilder.ValorDaVenda := StringReplace(FloatToStr(LfltTotalVenda), ',', '.', [rfReplaceAll]);
    FfltValorSubsidiado := (LfltTotalVenda * (FfltFatorReducao/100));

    if not LobjFrenetJSONBuilder.fGerarJSONParaEnvioPedidoFrete(LstrJSON, LstrMensagemRetorno) then
    Begin
      fMensagem('Atenção', LstrMensagemRetorno, ['&OK']);

      if fVerificaAcessoSistema('frmCadProdutos') then
        pAtualizaItens(tfFrenet);

      Exit;
    End;

    LstrLinha := LobjFrenetWS.fComunicar(LintCodigoRetorno,
                                         LstrMensagemRetorno,
                                         LstrJSON);

    if LintCodigoRetorno = 200 then
    Begin
      FobjRootServices := TRootServices.FromJsonString(LstrLinha);
      pAlimentarClientTransportadoras;
    End
    Else
    Begin
      FobjRootServices := Nil;
      fMensagem('Atenção','Erro na integração com a Frenet: "'+LstrMensagemRetorno+'". Se o problema persistir entre em contato com a Citel.',['&OK']);
    End;

  Finally
    FreeAndNil(LobjFrenetJSONBuilder);
    FreeAndNIl(LobjFrenetWS);
  End;

  Result := True;

end;

function TfrmFrenetConsulta.fItemEhEntregaImediata(const item: TDadosFechamento): Boolean;
var
  objFiltersItem: TFiltersItem;
begin
  objFiltersItem := TFiltersItem.Create;
  try
    Result := objFiltersItem.fFiltraEntregaImediata(item);
  finally
    FreeAndNil(objFiltersItem);
  end;
end;

end.
